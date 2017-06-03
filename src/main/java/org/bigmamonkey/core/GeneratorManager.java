package org.bigmamonkey.core;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.reflect.FieldUtils;
import org.bigmamonkey.config.Config;
import org.bigmamonkey.config.ModelBuilderConfig;
import org.bigmamonkey.config.TemplateConfig;
import org.bigmamonkey.modelBuilder.JsonModelBuilder;
import org.bigmamonkey.modelBuilder.MySqlConfig;
import org.bigmamonkey.modelBuilder.MySqlModelBuilder;
import org.bigmamonkey.util.ClassBuilder;
import org.bigmamonkey.util.ConfigReader;

import java.io.File;
import java.io.FileWriter;
import java.util.HashMap;
import java.util.List;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class GeneratorManager {

    private String configPath;
    private String templatePath;
    private HashMap<String, List<Object>> dataModels = new HashMap<>();
    private HashMap<String, ModelBuilderConfig> modelBuilderConfigs = new HashMap<>();
    private Configuration cfg;

    public GeneratorManager() {
        this("config.json", "templates");
    }

    public GeneratorManager(String configPath) {
        this(configPath, "templates");
    }

    public GeneratorManager(String configPath, String templatePath) {
        this.configPath = StringUtils.isEmpty(configPath) ? "config.json" : configPath;
        this.templatePath = StringUtils.isEmpty(templatePath) ? "templates" : templatePath;
    }

    public void Start() throws Exception {

        Config config = ConfigReader.getConfigByFilePath(Config.class, configPath);

        for (ModelBuilderConfig modelBuilderConfig : config.getModelBuilders()) {
            modelBuilderConfigs.put(modelBuilderConfig.getName(), modelBuilderConfig);
        }

        List<TemplateConfig> templates = config.getTemplates();
        for (TemplateConfig template : templates) {
            String moderBuilderName = template.getModelBuilderName();
            if (!modelBuilderConfigs.containsKey(moderBuilderName)) {
                throw new Exception("template's datasourceclassname not be defined");
            }

            List<Object> models;
            if (dataModels.containsKey(moderBuilderName)) {
                models = dataModels.get(moderBuilderName);
            } else {
                ModelBuilderConfig modelBuilderConfig = modelBuilderConfigs.get(moderBuilderName);
                String builderType = modelBuilderConfig.getType();
                IModelBuilder ds;
                Class<?> type;
                switch (builderType) {
                    case "db:mysql":
                        type = MySqlConfig.class;
                        ds = new MySqlModelBuilder();
                        break;
                    case "json":
                        type = HashMap.class;
                        ds = new JsonModelBuilder();
                        break;
                    case "custom":
                        String modelBuilderClassName = modelBuilderConfig.getModelBuilderClassName();
                        ds = ClassBuilder.newInstance(modelBuilderClassName);
                        type = ClassBuilder.getGenericTypeArgumengt(modelBuilderClassName);
                        break;
                    default:
                        throw new Exception("modelBuilderConfig miss type...");
                }

                models = ds.buildDataModels(ConfigReader.getConfigByFilePath(type, modelBuilderConfig.getConfigPath()));

                dataModels.put(moderBuilderName, models);
            }
            cfg = new Configuration(Configuration.VERSION_2_3_22);
            cfg.setDirectoryForTemplateLoading(new File(templatePath));
            cfg.setDefaultEncoding("UTF-8");
            cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);

            for (Object eachModel : models) {
                ProcessTemplate(eachModel, template);
            }
        }
    }

    private void ProcessTemplate(Object dataModel, TemplateConfig template) throws Exception {

        ModelHolder modelHolder = new ModelHolder(dataModel, template.getOptions());
        String tempFilename = template.getTemplateFilename();
        String outputPath = template.getOutputPath();
        String outputFilenameRule = template.getOutputFilenameRule();

        int startIndex = outputFilenameRule.indexOf("{") + 1;
        int endIndex = outputFilenameRule.indexOf("}");

        if (startIndex >= endIndex) {
            throw new StringIndexOutOfBoundsException(endIndex - startIndex);
        }

        String propName = outputFilenameRule.substring(startIndex, endIndex);
        String filenameValue;
        if (dataModel instanceof HashMap) {
            filenameValue = (String) ((HashMap) dataModel).get(propName);
        } else {
            filenameValue = (String) FieldUtils.readDeclaredField(dataModel, propName, true);
        }

        String filename = outputFilenameRule.replace("{" + propName + "}", filenameValue);
        outputPath = outputPath.endsWith("/") ? outputPath : outputPath + "/";

        filename = outputPath + filename;

        File ditc = new File(outputPath);
        if (!ditc.mkdirs()) {
            throw new Exception("make output dictionary error...");
        }

        Template temp = cfg.getTemplate(tempFilename);
        FileWriter writer = new FileWriter(new File(filename));
        temp.process(modelHolder, writer);
        writer.close();
    }
}
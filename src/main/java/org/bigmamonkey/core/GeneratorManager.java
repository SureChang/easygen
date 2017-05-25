package org.bigmamonkey.core;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import org.bigmamonkey.config.Config;
import org.bigmamonkey.config.ModelBuilderConfig;
import org.bigmamonkey.config.TemplateConfig;
import org.bigmamonkey.util.ConfigReader;

import java.io.File;
import java.io.FileWriter;
import java.lang.reflect.ParameterizedType;
import java.util.HashMap;
import java.util.List;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class GeneratorManager {

    private String configPath;
    private HashMap<String, DataModel> dataModels = new HashMap<String, DataModel>();
    private HashMap<String, ModelBuilderConfig> modelBuilderConfigs = new HashMap<String, ModelBuilderConfig>();

    public GeneratorManager(String configPath) {
        this.configPath = configPath;
    }

    public void Start() throws Exception {

        Config config = ConfigReader.getConfig(Config.class, configPath);

        for (ModelBuilderConfig modelBuilderConfig : config.getModelBuilders()) {
            modelBuilderConfigs.put(modelBuilderConfig.getName(), modelBuilderConfig);
        }

        List<TemplateConfig> templates = config.getTemplates();
        for (TemplateConfig template : templates) {
            String moderBuilderName = template.getModelBuilderName();
            if (!modelBuilderConfigs.containsKey(moderBuilderName)) {
                throw new Exception("template's datasourceclassname not be defined");
            }

            DataModel dataModel = new DataModel();
            if (dataModels.containsKey(moderBuilderName)) {
                dataModel = dataModels.get(moderBuilderName);
            } else {
                ModelBuilderConfig modelBuilderConfig = modelBuilderConfigs.get(moderBuilderName);
                String modelBuilderClassName = modelBuilderConfig.getModelBuilderClassName();
                Class<?> builderClass = Class.forName(modelBuilderClassName);
                Class<?> type = (Class<?>) (((ParameterizedType) builderClass.getGenericInterfaces()[0]).getActualTypeArguments()[0]);

                IModelBuilder ds = (IModelBuilder) builderClass.newInstance();
                Object modelData = ds.loadDataModel(ConfigReader.getConfig(type, modelBuilderConfig.getConfigPath()));
                dataModel.setModel(modelData);
                dataModels.put(moderBuilderName, dataModel);
            }

            Configuration cfg = new Configuration(Configuration.VERSION_2_3_22);
            cfg.setDirectoryForTemplateLoading(new File("templates"));
            cfg.setDefaultEncoding("UTF-8");
            cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);

            Template temp = null;
            temp = cfg.getTemplate(template.getTemplateFilename());
            FileWriter writer = null;
            writer = new FileWriter(new File(template.getOutputPath()));
            temp.process(dataModel, writer);
            writer.close();
        }
    }
}
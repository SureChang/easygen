package org.bigmamonkey.core;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import org.bigmamonkey.config.Config;
import org.bigmamonkey.config.DataSourceConfig;
import org.bigmamonkey.config.TemplateConfig;
import org.bigmamonkey.util.ConfigReader;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.reflect.ParameterizedType;
import java.util.HashMap;
import java.util.List;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class GeneratorManager {

    private String configPath;
    private HashMap<String, Object> dataSources = new HashMap<String, Object>();
    private HashMap<String, DataSourceConfig> dataSourceConfigs = new HashMap<String, DataSourceConfig>();

    public GeneratorManager(String configPath) {
        this.configPath = configPath;
    }

    public void Start() throws Exception {

        Config config = ConfigReader.getConfig(Config.class, configPath);

        for (DataSourceConfig dataSourceConfig : config.getDataSources()) {
            dataSourceConfigs.put(dataSourceConfig.getName(), dataSourceConfig);
        }

        List<TemplateConfig> templates = config.getTemplates();
        for (TemplateConfig template : templates) {
            String dataSourceName = template.getDataSourceName();
            if (!dataSourceConfigs.containsKey(dataSourceName)) {
                throw new Exception("template's datasourceclassname not be defined");
            }
            Object dataSource;
            if (dataSources.containsKey(dataSourceName)) {
                dataSource = dataSources.get(dataSourceName);
            } else {
                DataSourceConfig dataSourceConfig = dataSourceConfigs.get(dataSourceName);
                String dataSourceClassName = dataSourceConfig.getDataSourceClassName();
                Class<?> aClass = Class.forName(dataSourceClassName);
                Class<?> type = (Class<?>) (((ParameterizedType) aClass.getGenericInterfaces()[0]).getActualTypeArguments()[0]);

                IDataSource ds = (IDataSource) aClass.newInstance();
                dataSource = ds.loadDataSource(ConfigReader.getConfig(type, dataSourceConfig.getConfigPath()));
            }

            Configuration cfg = new Configuration(Configuration.VERSION_2_3_22);
            cfg.setDirectoryForTemplateLoading(new File("templates"));
            cfg.setDefaultEncoding("UTF-8");
            cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);

            Template temp = null;
            temp = cfg.getTemplate(template.getTemplateFilename());
            FileWriter writer = null;
            writer = new FileWriter(new File(template.getOutputPath()));

            temp.process(dataSource, writer);
        }
    }
}

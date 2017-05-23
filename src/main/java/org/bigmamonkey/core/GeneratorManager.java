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
import java.lang.reflect.Type;
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

    public void Start() {

        Config config;
        try {
            config = ConfigReader.getConfig(Config.class, configPath);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            return;
        }

        for (DataSourceConfig dataSourceConfig : config.getDataSources()) {
            dataSourceConfigs.put(dataSourceConfig.getName(), dataSourceConfig);
        }

        List<TemplateConfig> templates = config.getTemplates();
        for (TemplateConfig template : templates) {
            String dataSourceName = template.getDataSourceName();
            if (!dataSourceConfigs.containsKey(dataSourceName)) {
                System.out.println("template's datasourceclassname not be defined");
                return;
            }
            Object dataSource;
            if (dataSources.containsKey(dataSourceName)) {
                dataSource = dataSources.get(dataSourceName);
            } else {
                try {
                    DataSourceConfig dataSourceConfig = dataSourceConfigs.get(dataSourceName);
                    String dataSourceClassName = dataSourceConfig.getDataSourceClassName();
                    Class<?> aClass = Class.forName(dataSourceClassName);
                    Class<?> type = (Class<?>) (((ParameterizedType) aClass.getGenericInterfaces()[0]).getActualTypeArguments()[0]);

                    IDataSource ds = (IDataSource) aClass.newInstance();
                    dataSource = ds.loadDataSource(ConfigReader.getConfig(type, dataSourceConfig.getConfigPath()));
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                    return;
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                    return;
                } catch (InstantiationException e) {
                    e.printStackTrace();
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                    return;
                }
            }

            Configuration cfg = new Configuration(Configuration.VERSION_2_3_22);
            try {
                cfg.setDirectoryForTemplateLoading(new File("templates"));
            } catch (IOException e) {
                e.printStackTrace();
            }
            cfg.setDefaultEncoding("UTF-8");
            cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);

            Template temp = null;
            try {
                temp = cfg.getTemplate(template.getTemplateFilename());
            } catch (IOException e) {
                e.printStackTrace();
            }
            FileWriter writer = null;
            try {
                writer = new FileWriter(new File(template.getOutputPath()));
            } catch (IOException e) {
                e.printStackTrace();
            }

            try {
                temp.process(dataSource, writer);
            } catch (TemplateException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}

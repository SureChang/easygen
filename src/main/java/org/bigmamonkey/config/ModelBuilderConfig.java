package org.bigmamonkey.config;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class ModelBuilderConfig {

    private String name;
    private String configPath;
    private String modelBuilderClassName;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getConfigPath() {
        return configPath;
    }

    public void setConfigPath(String configPath) {
        this.configPath = configPath;
    }

    public String getModelBuilderClassName() {
        return modelBuilderClassName;
    }

    public void setModelBuilderClassName(String modelBuilderClassName) {
        this.modelBuilderClassName = modelBuilderClassName;
    }
}
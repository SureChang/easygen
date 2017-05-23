package org.bigmamonkey.config;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class DataSourceConfig {

    private String name;
    private String configPath;
    private String dataSourceClassName;

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

    public String getDataSourceClassName() {
        return dataSourceClassName;
    }

    public void setDataSourceClassName(String dataSourceClassName) {
        this.dataSourceClassName = dataSourceClassName;
    }
}

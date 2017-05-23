package org.bigmamonkey.config;

import org.bigmamonkey.config.DataSourceConfig;
import org.bigmamonkey.config.TemplateConfig;

import java.util.List;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class Config {

    private List<DataSourceConfig> dataSources;
    private List<TemplateConfig> templates;

    public List<DataSourceConfig> getDataSources() {
        return dataSources;
    }

    public void setDataSources(List<DataSourceConfig> dataSources) { this.dataSources = dataSources; }

    public List<TemplateConfig> getTemplates() {
        return templates;
    }

    public void setTemplates(List<TemplateConfig> templates) {
        this.templates = templates;
    }

}

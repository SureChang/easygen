package org.bigmamonkey.config;

import java.util.List;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class Config {

    private List<ModelBuilderConfig> modelBuilders;
    private List<TemplateConfig> templates;

    public List<ModelBuilderConfig> getModelBuilders() {
        return modelBuilders;
    }

    public void setModelBuilders(List<ModelBuilderConfig> modelBuilders) { this.modelBuilders = modelBuilders; }

    public List<TemplateConfig> getTemplates() {
        return templates;
    }

    public void setTemplates(List<TemplateConfig> templates) {
        this.templates = templates;
    }

}

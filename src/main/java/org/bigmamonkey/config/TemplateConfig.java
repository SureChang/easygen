package org.bigmamonkey.config;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class TemplateConfig {

    private String name;
    private String modelBuilderName;
    private String templateFilename;
    private String outputPath;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTemplateFilename() {
        return templateFilename;
    }

    public void setTemplateFilename(String templateFilename) {
        this.templateFilename = templateFilename;
    }

    public String getOutputPath() {
        return outputPath;
    }

    public void setOutputPath(String outputPath) {
        this.outputPath = outputPath;
    }

    public String getModelBuilderName() {
        return modelBuilderName;
    }

    public void setModelBuilderName(String modelBuilderName) {
        this.modelBuilderName = modelBuilderName;
    }
}

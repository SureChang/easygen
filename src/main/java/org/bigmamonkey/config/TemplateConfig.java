package org.bigmamonkey.config;

import java.util.HashMap;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class TemplateConfig {

    private String name;
    private String modelBuilderName;
    private String templateFilename;
    private String outputPath;
    private String outputFilenameRule;
    private boolean oneFile = false;
    private HashMap<String, String> options;

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

    public String getOutputFilenameRule() {
        return outputFilenameRule;
    }

    public void setOutputFilenameRule(String outputFilenameRule) {
        this.outputFilenameRule = outputFilenameRule;
    }

    public HashMap<String, String> getOptions() {
        return options;
    }

    public void setOptions(HashMap<String, String> options) {
        this.options = options;
    }

    public boolean isOneFile() {
        return oneFile;
    }

    public void setOneFile(boolean oneFile) {
        this.oneFile = oneFile;
    }
}

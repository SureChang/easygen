package org.bigmamonkey;

import java.util.HashMap;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class TemplateConfig {

    private String name;
    private String templatePath;
    private String outputPath;
    private HashMap<String, String> options;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTemplatePath() {
        return templatePath;
    }

    public void setTemplatePath(String templatePath) {
        this.templatePath = templatePath;
    }

    public String getOutputPath() {
        return outputPath;
    }

    public void setOutputPath(String outputPath) {
        this.outputPath = outputPath;
    }

    public HashMap<String, String> getOptions() {
        return options;
    }

    public void setOptions(HashMap<String, String> options) {
        this.options = options;
    }
}

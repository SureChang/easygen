package org.bigmamonkey;


import java.util.List;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class Config {

    private String dbUrl; // 数据库访问链接
    private String driverClassName; //驱动类名称
    private String username;
    private String password;
    private List<TemplateConfig> templates;

    public String getDbUrl() {
        return dbUrl;
    }

    public void setDbUrl(String dbUrl) {
        this.dbUrl = dbUrl;
    }

    public String getDriverClassName() {
        return driverClassName;
    }

    public void setDriverClassName(String driverClassName) {
        this.driverClassName = driverClassName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<TemplateConfig> getTemplates() {
        return templates;
    }

    public void setTemplates(List<TemplateConfig> templates) {
        this.templates = templates;
    }
}

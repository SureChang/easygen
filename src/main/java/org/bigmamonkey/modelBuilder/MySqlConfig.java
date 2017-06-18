package org.bigmamonkey.modelBuilder;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class MySqlConfig {

    private String dbUrl; // 数据库访问链接
    private String driverClassName; //驱动类名称
    private String username;
    private String password;
    private String tables; // 可指定要生成的表名，用,分割

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

    public String getTables() {
        return tables;
    }

    public void setTables(String tables) {
        this.tables = tables;
    }
}

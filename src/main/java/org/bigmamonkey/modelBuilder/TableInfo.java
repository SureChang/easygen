package org.bigmamonkey.modelBuilder;

import org.apache.commons.lang3.StringUtils;
import org.bigmamonkey.util.StringUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class TableInfo {
    private String name;
    private String upperCaseName;
    private List<TableField> fields = new ArrayList<>();
    private List<String> pkgs = new ArrayList<>();
    private TableField primaryKey;

    public String getName() {
        return name;
    }

    public void setName(String name) throws Exception {

        this.name = name;
        this.upperCaseName = StringUtil.ToUpperName(name);
    }

    public String getUpperCaseName() {
        return upperCaseName;
    }

    public void setUpperCaseName(String upperCaseName) {
        this.upperCaseName = upperCaseName;
    }

    public List<TableField> getFields() {
        return fields;
    }

    public void setFields(List<TableField> fields) {
        this.fields = fields;
        fields.forEach(field -> {

            String pkg = field.getColumnType().getPkg();
            if (StringUtils.isEmpty(pkg) || pkgs.contains(pkg)) {
                return;
            }
            pkgs.add(pkg);
        });
    }

    public List<String> getPkgs() {
        return pkgs;
    }

    public void setPkgs(List<String> pkgs) {
        this.pkgs = pkgs;
    }

    public TableField getPrimaryKey() {
        return primaryKey;
    }

    public void setPrimaryKey(TableField primaryKey) {
        this.primaryKey = primaryKey;
    }
}
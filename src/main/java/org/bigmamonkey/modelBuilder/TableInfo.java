package org.bigmamonkey.modelBuilder;

import org.apache.commons.lang3.StringUtils;
import org.bigmamonkey.util.StringUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class TableInfo {
    private String name; // 原始表名
    private String upperCaseName; //前缀大写+首字符大写表名，用于创建PO、Mapper等
    private String simpleName;// 去掉前缀的表名，目前只支持_分割的表名，如sys_user
    private String upperCaseSimpleName; //simpleName的首字母大写形式
    private List<TableField> fields = new ArrayList<>();
    private List<String> pkgs = new ArrayList<>(); // 所有字段类型对应的Java包，import到java文件
    private TableField primaryKey; // 主键字段
    private String remarks; // 表注释

    public String getName() {
        return name;
    }

    public void setName(String name) throws Exception {

        this.name = name;
        this.upperCaseName = StringUtil.ToUpperName(name);
        this.simpleName = StringUtil.ToSimpleName(name);
        this.upperCaseSimpleName = StringUtil.ToSimpleName(this.upperCaseName);
    }

    public String getUpperCaseName() {
        return upperCaseName;
    }

    public void setUpperCaseName(String upperCaseName) {
        this.upperCaseName = upperCaseName;
    }

    public String getSimpleName() {
        return simpleName;
    }

    public void setSimpleName(String simpleName) {
        this.simpleName = simpleName;
    }

    public String getUpperCaseSimpleName() {
        return upperCaseSimpleName;
    }

    public void setUpperCaseSimpleName(String upperCaseSimpleName) {
        this.upperCaseSimpleName = upperCaseSimpleName;
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

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
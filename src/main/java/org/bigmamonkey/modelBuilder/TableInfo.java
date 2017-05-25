package org.bigmamonkey.modelBuilder;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class TableInfo {
    private String name;
    private List<TableField> fields = new ArrayList<>();
    private TableField primaryKey;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<TableField> getFields() {
        return fields;
    }

    public void setFields(List<TableField> fields) {
        this.fields = fields;
    }

    public TableField getPrimaryKey() {
        return primaryKey;
    }

    public void setPrimaryKey(TableField primaryKey) {
        this.primaryKey = primaryKey;
    }
}

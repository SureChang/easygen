package org.bigmamonkey.modelBuilder;

import org.bigmamonkey.util.StringUtil;

import java.sql.Types;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class TableField {
    private String name;
    private String upperCaseName;
    private int dataType;
    private DbColumnType columnType;
    private String typeName;
    private int columnSize;
    private String remarks;

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

    public int getDataType() {
        return dataType;
    }

    public void setDataType(int dataType) {
        this.dataType = dataType;

        switch (dataType) {
            case Types.INTEGER:
                columnType = DbColumnType.INTEGER;
                typeName = "INTEGER";
                break;
            case Types.BIGINT:
                columnType = DbColumnType.LONG;
                typeName = "BIGINT";
                break;
            case Types.BIT:
                columnType = DbColumnType.BOOLEAN;
                typeName = "BIT";
                break;
            case Types.VARCHAR:
                columnType = DbColumnType.STRING;
                typeName = "VARCHAR";
                break;
            case Types.TIMESTAMP:
                columnType = DbColumnType.DATE;
                typeName = "TIMESTAMP";
                break;
            case Types.FLOAT:
                columnType = DbColumnType.FLOAT;
                typeName = "FLOAT";
                break;
            case Types.DOUBLE:
                columnType = DbColumnType.DOUBLE;
                typeName = "DOUBLE";
                break;
            default:
                columnType = DbColumnType.STRING;
                typeName = "VARCHAR";
                break;
        }
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public int getColumnSize() {
        return columnSize;
    }

    public void setColumnSize(int columnSize) {
        this.columnSize = columnSize;
    }

    public DbColumnType getColumnType() {
        return columnType;
    }

    public void setColumnType(DbColumnType columnType) {
        this.columnType = columnType;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}

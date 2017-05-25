package org.bigmamonkey.modelBuilder;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class TableField {
    private String name;
    private int dataType;
    private DbColumnType columnType;
    private String typeName;
    private int columnSize;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getDataType() {
        return dataType;
    }

    public void setDataType(int dataType) {
        this.dataType = dataType;
        switch (dataType){
            case 4:
                columnType = DbColumnType.INTEGER;
                break;
            case 12:
                columnType = DbColumnType.TIME;
            default:
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
}

package org.bigmamonkey.modelBuilder;

import org.bigmamonkey.core.IModelBuilder;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class MySqlModelBuilder implements IModelBuilder<MySqlConfig> {

    public Object loadDataModel(MySqlConfig config) throws Exception {

        try {
            Class.forName(config.getDriverClassName());
        } catch (ClassNotFoundException e) {
            throw new Exception("load driver exception..", e);
        }

        List<TableInfo> tableInfos;
        Connection connection;
        try {
            connection = DriverManager.getConnection(config.getDbUrl(), config.getUsername(), config.getPassword());
            DatabaseMetaData dbMetaData = connection.getMetaData();
            String[] tableNames = config.getTables().split(",");
            tableInfos = new ArrayList<>();
            for (String tableName : tableNames) {
                List<TableField> tableFields = getTableFields(dbMetaData, tableName);
                String primaryKeyName = getAllPrimaryKeys(dbMetaData, tableName);
                TableField primaryKey = tableFields.stream()
                        .filter(field -> field.getName().equals(primaryKeyName))
                        .findFirst().get();
                TableInfo tableInfo = new TableInfo();
                tableInfo.getFields().addAll(tableFields);
                tableInfo.setPrimaryKey(primaryKey);
                tableInfos.add(tableInfo);
            }

        } catch (SQLException e) {
            throw new Exception("load database metadata exception..", e);
        }

        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tableInfos ;
    }

    /**
     * 获得表或视图中的所有列信息
     */
    public static List<TableField> getTableFields(DatabaseMetaData dbMetaData, String tableName) throws SQLException {

        ArrayList<TableField> tableFields = new ArrayList<>();

        ResultSet rs = dbMetaData.getColumns(null, null, tableName, "%");
        while (rs.next()) {
            String columnName = rs.getString("COLUMN_NAME");//列名
            int dataType = rs.getInt("DATA_TYPE"); //对应的    类型
            String dataTypeName = rs.getString("TYPE_NAME");//java.sql.Types类型   名称
            int columnSize = rs.getInt("COLUMN_SIZE");//列大小

            TableField tableField = new TableField();
            tableField.setName(columnName);
            tableField.setDataType(dataType);
            tableField.setTypeName(dataTypeName);
            tableField.setColumnSize(columnSize);
            tableFields.add(tableField);
        }
        return tableFields;
    }

    /**
     * 获得一个表的主键信息
     */
    public static String getAllPrimaryKeys(DatabaseMetaData dbMetaData, String tableName) throws SQLException {
        String columnName = null;
        ResultSet rs = dbMetaData.getPrimaryKeys(null, null, tableName);
        while (rs.next()){
             columnName = rs.getString("COLUMN_NAME");//列名
            return columnName;
        }
        return columnName;
    }
}
package org.bigmamonkey.dataSource;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.bigmamonkey.config.Config;
import org.bigmamonkey.config.DataSourceConfig;
import org.bigmamonkey.config.MySqlConfig;
import org.bigmamonkey.core.IDataSource;

import java.io.File;
import java.io.IOException;
import java.sql.*;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public class MySqlDataSource implements IDataSource<MySqlConfig> {

    private static DatabaseMetaData dbMetaData;

    public Object loadDataSource(MySqlConfig config) throws Exception {

        try {
            Class.forName(config.getDriverClassName());
        } catch (ClassNotFoundException e) {
            throw new Exception("load driver exception..", e);
        }

        Connection connection;
        try {
            connection = DriverManager.getConnection(config.getDbUrl(), config.getUsername(), config.getPassword());
            dbMetaData = connection.getMetaData();
            getTableColumns(null, "sys_user");
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
        return null;
    }

    /**
     * 获得该用户下面的所有表
     */
    private static void LoadGenerateMetaData(String schemaName) {
        try {
            // table type. Typical types are "TABLE", "VIEW", "SYSTEM TABLE", "GLOBAL TEMPORARY", "LOCAL TEMPORARY", "ALIAS", "SYNONYM".
            String[] types = { "TABLE" };
            ResultSet rs = dbMetaData.getTables(null, schemaName, "%", types);
            while (rs.next()) {
                String tableName = rs.getString("TABLE_NAME");  //表名
                String tableType = rs.getString("TABLE_TYPE");  //表类型
                String remarks = rs.getString("REMARKS");       //表备注
                System.out.println(tableName + "-" + tableType + "-" + remarks);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 获得表或视图中的所有列信息
     */
    public static void getTableColumns(String schemaName, String tableName) {

        try{

            ResultSet rs = dbMetaData.getColumns(null, schemaName, tableName, "%");
            while (rs.next()){
                String tableCat = rs.getString("TABLE_CAT");//表目录（可能为空）
                String tableSchemaName = rs.getString("TABLE_SCHEM");//表的架构（可能为空）
                String tableName_ = rs.getString("TABLE_NAME");//表名
                String columnName = rs.getString("COLUMN_NAME");//列名
                int dataType = rs.getInt("DATA_TYPE"); //对应的java.sql.Types类型
                String dataTypeName = rs.getString("TYPE_NAME");//java.sql.Types类型   名称
                int columnSize = rs.getInt("COLUMN_SIZE");//列大小
                int decimalDigits = rs.getInt("DECIMAL_DIGITS");//小数位数
                int numPrecRadix = rs.getInt("NUM_PREC_RADIX");//基数（通常是10或2）
                int nullAble = rs.getInt("NULLABLE");//是否允许为null
                String remarks = rs.getString("REMARKS");//列描述
                String columnDef = rs.getString("COLUMN_DEF");//默认值
                int sqlDataType = rs.getInt("SQL_DATA_TYPE");//sql数据类型
                int sqlDatetimeSub = rs.getInt("SQL_DATETIME_SUB");   //SQL日期时间分?
                int charOctetLength = rs.getInt("CHAR_OCTET_LENGTH");   //char类型的列中的最大字节数
                int ordinalPosition = rs.getInt("ORDINAL_POSITION");  //表中列的索引（从1开始）

                /**
                 * ISO规则用来确定某一列的为空性。
                 * 是---如果该参数可以包括空值;
                 * 无---如果参数不能包含空值
                 * 空字符串---如果参数为空性是未知的
                 */
                String isNullAble = rs.getString("IS_NULLABLE");

                /**
                 * 指示此列是否是自动递增
                 * 是---如果该列是自动递增
                 * 无---如果不是自动递增列
                 * 空字串---如果不能确定它是否
                 * 列是自动递增的参数是未知
                 */
                String isAutoincrement = rs.getString("IS_AUTOINCREMENT");

                System.out.println(tableCat + "-" + tableSchemaName + "-" + tableName_ + "-" + columnName + "-"
                        + dataType + "-" + dataTypeName + "-" + columnSize + "-" + decimalDigits + "-" + numPrecRadix
                        + "-" + nullAble + "-" + remarks + "-" + columnDef + "-" + sqlDataType + "-" + sqlDatetimeSub
                        + charOctetLength + "-" + ordinalPosition + "-" + isNullAble + "-" + isAutoincrement + "-");
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
    }

    /**
     * 获得一个表的主键信息
     */
    public static void getAllPrimaryKeys(String schemaName, String tableName) {
        try{
            ResultSet rs = dbMetaData.getPrimaryKeys(null, schemaName, tableName);
            while (rs.next()){
                String columnName = rs.getString("COLUMN_NAME");//列名
                short keySeq = rs.getShort("KEY_SEQ");//序列号(主键内值1表示第一列的主键，值2代表主键内的第二列)
                String pkName = rs.getString("PK_NAME"); //主键名称
                System.out.println(columnName + "-" + keySeq + "-" + pkName);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
}

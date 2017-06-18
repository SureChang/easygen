package org.bigmamonkey.modelBuilder;

/**
 * Created by bigmamonkey on 5/23/17.
 */
public enum DbColumnType {

    STRING("String", null),
    LONG("Long", null),
    INTEGER("Integer", null),
    FLOAT("Float", null),
    DOUBLE("Double", null),
    BOOLEAN("Boolean", null),
    BYTE_ARRAY("byte[]", null),
    CHARACTER("Character", null),
    OBJECT("Object", null),
    DATE("Date", "java.util.Date"),
    TIME("Time", "java.sql.Time"),
    BLOB("Blob", "java.sql.Blob"),
    CLOB("Clob", "java.sql.Clob"),
    TIMESTAMP("Timestamp", "java.sql.Timestamp"),
    BIG_INTEGER("BigInteger", "java.math.BigInteger"),
    BIG_DECIMAL("BigDecimal", "java.math.BigDecimal"),
    LOCAL_DATE("LocalDate", "java.time.LocalDate"),
    LOCAL_TIME("LocalTime", "java.time.LocalTime"),
    LOCAL_DATE_TIME("LocalDateTime", "java.time.LocalDateTime");

    private final String javaType; // 字段对应的java类型
    private final String pkg; // java类型需要导入的包路径，基本类型不需要，为null

    DbColumnType(final String javaType, final String pkg) {
        this.javaType = javaType;
        this.pkg = pkg;
    }

    public String getJavaType() {
        return this.javaType;
    }

    public String getPkg() {
        return this.pkg;
    }
}

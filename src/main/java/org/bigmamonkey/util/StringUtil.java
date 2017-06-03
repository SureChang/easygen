package org.bigmamonkey.util;

/**
 * Created by bigmamonkey on 6/1/17.
 */
public class StringUtil {

    public static String ToUpperName(String str) throws Exception {
        String[] strs = str.split("_");
        if ((str.length() < 0)) {
            throw new Exception("table name rule wrong..");
        }
        StringBuilder stringBuilder = new StringBuilder();
        if (strs.length == 2) {
            stringBuilder.append(strs[0].toUpperCase());
            stringBuilder.append("_");
            stringBuilder.append(strs[1].toUpperCase().charAt(0));
            stringBuilder.append(strs[1].substring(1));
        } else {
            stringBuilder.append(strs[0].toUpperCase().charAt(0));
            stringBuilder.append(strs[0].substring(1));
        }

        return stringBuilder.toString();
    }

    public static String ToSimpleName(String str) {
        String[] strs = str.split("_");
        return strs[strs.length - 1];
    }
}

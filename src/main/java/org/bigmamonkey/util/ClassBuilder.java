package org.bigmamonkey.util;

import java.lang.reflect.ParameterizedType;

/**
 * Created by bigmamonkey on 6/3/17.
 */
public class ClassBuilder {
    public static <TClass> TClass newInstance(String className) throws ClassNotFoundException, IllegalAccessException, InstantiationException {
        Class<?> builderClass = Class.forName(className);
        return (TClass) builderClass.newInstance();
    }

    public static Class<?> getGenericTypeArgumengt(String className) throws ClassNotFoundException {
        Class<?> builderClass = Class.forName(className);
        return (Class<?>) (((ParameterizedType) builderClass.getGenericInterfaces()[0]).getActualTypeArguments()[0]);
    }
}

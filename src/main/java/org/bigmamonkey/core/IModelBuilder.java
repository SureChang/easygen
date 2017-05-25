package org.bigmamonkey.core;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public interface IModelBuilder<T> {
    Object loadDataModel(T config) throws Exception;
}

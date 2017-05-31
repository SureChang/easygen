package org.bigmamonkey.core;

import java.util.List;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public interface IModelBuilder<T> {
    List<Object> buildDataModels(T config) throws Exception;
}

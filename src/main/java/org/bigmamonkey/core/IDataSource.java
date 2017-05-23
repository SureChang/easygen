package org.bigmamonkey.core;

import org.bigmamonkey.config.DataSourceConfig;

/**
 * Created by bigmamonkey on 5/22/17.
 */
public interface IDataSource<T> {
    Object loadDataSource(T config) throws Exception;
}

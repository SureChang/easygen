package org.bigmamonkey.core;

import java.util.List;

/**
 * 模型构建器接口
 * @param <T> 构建器配置类类型
 */
public interface IModelBuilder<T> {

    /**
     * 构建数据模型
     * @param config 构建器配置类实例
     * @return 数据模型列表，返回List接口以支持批量生成
     * @throws Exception
     */
    List<Object> buildDataModels(T config) throws Exception;
}

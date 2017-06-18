package org.bigmamonkey.core;

import java.util.HashMap;

/**
 * 模型根对象，用于保存数据模型和模板自己定义参数，
 * 注意这里的model保存的是ModelBuilder返回的List中的元素。
 * Created by bigmamonkey on 5/31/17.
 */
public class ModelHolder {
    private Object model;
    private HashMap<String, String> options;

    public ModelHolder(Object model, HashMap<String, String> options) {
        this.model = model;
        this.options = options;
    }

    public Object getModel() {
        return model;
    }

    public void setModel(Object model) {
        this.model = model;
    }

    public HashMap<String, String> getOptions() {
        return options;
    }

    public void setOptions(HashMap<String, String> options) {
        this.options = options;
    }
}
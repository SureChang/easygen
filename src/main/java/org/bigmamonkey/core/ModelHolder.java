package org.bigmamonkey.core;

import java.util.HashMap;

/**
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
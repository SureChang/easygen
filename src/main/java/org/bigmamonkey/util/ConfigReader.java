package org.bigmamonkey.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;
import java.io.IOException;

/**
 * Created by bigmamonkey on 5/23/17.
 */
public class ConfigReader {

    public static <TConfig> TConfig getConfigByFilePath(Class<TConfig> type, String path) throws Exception {

        File file = new File(path);
        if (!file.exists()) {
            String errMsg = String.format("config file at {%s} not exist..", path);
            throw new Exception(errMsg);
        }

        ObjectMapper objectMapper = new ObjectMapper();
        TConfig config;
        try {
            config = objectMapper.readValue(file, type);
            return config;
        } catch (IOException e) {
            String errMsg = String.format("read config file {%s} exception..", path);
            throw new Exception(errMsg, e);
        }
    }
}

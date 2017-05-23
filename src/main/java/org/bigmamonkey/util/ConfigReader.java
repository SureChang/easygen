package org.bigmamonkey.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;
import java.io.IOException;

/**
 * Created by bigmamonkey on 5/23/17.
 */
public class ConfigReader {

    public static <TConfig> TConfig getConfig(Class<TConfig> type, String path) throws Exception {

        File file = new File(path);
        if (!file.exists()) {
            throw new Exception("can not find the config file with name config.json..");
        }

        ObjectMapper objectMapper = new ObjectMapper();
        TConfig config;
        try {
            config = objectMapper.readValue(file, type);
            return config;
        } catch (IOException e) {
            throw new Exception("read config file exception..", e);
        }
    }
}

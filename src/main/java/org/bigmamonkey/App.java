package org.bigmamonkey;

import org.bigmamonkey.config.DataSourceConfig;
import org.bigmamonkey.core.GeneratorManager;

import java.sql.*;
import java.util.List;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main(String[] args )
    {
        GeneratorManager generatorManager = new GeneratorManager("/home/bigmamonkey/github/easygen/src/main/resources/config.json");
        try {
            generatorManager.Start();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
}

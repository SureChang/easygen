package org.bigmamonkey;

import org.bigmamonkey.core.GeneratorManager;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main(String[] args )
    {
        if(args.length == 0){
            System.out.println("the configPath argument missed..");
            return;
        }

        String configPath = args[0];
        GeneratorManager generatorManager = new GeneratorManager(configPath);
        try {
            generatorManager.Start();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
}

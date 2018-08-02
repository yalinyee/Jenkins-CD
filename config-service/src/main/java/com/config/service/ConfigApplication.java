package com.config.service;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.cloud.config.server.EnableConfigServer;

/**
 * 配置服务器
 *author JamesYe 2018-06-12
 */
@SpringBootApplication
@EnableConfigServer
public class ConfigApplication 
{
    public static void main( String[] args )
    {
        new SpringApplicationBuilder(ConfigApplication.class).run(args);
    }
}

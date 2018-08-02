package com.discovery.service;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

/**
 * 配置服务中心
 * author JamesYe 2018-06-12
 *
 */
@SpringBootApplication
@EnableEurekaServer
public class DiscoveryApplication 
{
    public static void main( String[] args )
    {
        new SpringApplicationBuilder(DiscoveryApplication.class).run(args);
    }
}

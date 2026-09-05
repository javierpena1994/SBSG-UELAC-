package com.sbsg.contingencias.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.CacheControl;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.File;

@Configuration
public class CorsConfig {

    @Bean
    public WebMvcConfigurer webMvcConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**")
                        .allowedOriginPatterns("*")
                        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "HEAD", "PATCH")
                        .allowedHeaders("*")
                        .allowCredentials(false)
                        .maxAge(3600);
            }

            @Override
            public void addResourceHandlers(ResourceHandlerRegistry registry) {
                // Servir archivos estáticos en vivo directamente desde la carpeta frontend
                File frontendDir = new File("frontend");
                if (!frontendDir.exists() || !frontendDir.isDirectory()) {
                    frontendDir = new File("../frontend");
                }

                String frontendPath = frontendDir.toURI().toString();
                if (!frontendPath.endsWith("/")) {
                    frontendPath += "/";
                }
                registry.addResourceHandler("/**")
                        .addResourceLocations(frontendPath, "classpath:/static/")
                        .setCacheControl(CacheControl.noStore().mustRevalidate().cachePrivate());
            }
        };
    }
}


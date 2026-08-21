package com.springboot.pageland;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 브라우저에서 /images/** 로 요청 시 C:/pageland_images/ 폴더의 파일을 즉시 반환
        registry.addResourceHandler("/images/**")
                .addResourceLocations("file:///C:/pageland/pageland_images/");
    }
}
package com.jhta.project.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
//servlet-context.xml 을 대신하는 클래스
@EnableWebMvc //<annotation-driven /> 대신 쓰는것.
@ComponentScan(basePackages = {"com.jhta.project.controller"})
public class ServletConfig implements WebMvcConfigurer{
	//뷰 리절버 설정
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setViewClass(JstlView.class);
		resolver.setPrefix("/WEB-INF/views/");
		resolver.setSuffix(".jsp");
		registry.viewResolver(resolver);//뷰리절버 등록하기
	}
	//정적자원 처리하기
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
		registry.addResourceHandler("/admin/**").addResourceLocations("/admin/");
	}
	
	@Bean(name = "multipartResolver")
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver resolver = new CommonsMultipartResolver();
		resolver.setMaxUploadSize(5242880);
		resolver.setMaxInMemorySize(1048576);
		resolver.setDefaultEncoding("UTF-8");
		return resolver;
	}
}

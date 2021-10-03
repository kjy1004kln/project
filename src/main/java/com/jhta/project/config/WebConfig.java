package com.jhta.project.config;

import javax.servlet.Filter;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {
	//root-context.xml에 대한 기능을 갖는 클래스 설정
	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] {RootConfig.class};
	}
	//servletContext.xml에 대한 기능을 갖는 클래스 설정
	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class[] {ServletConfig.class, WebSocketConfig.class };
	}
	//dispachserservlet의 servlet-mapping 설정
	@Override
	protected String[] getServletMappings() {
		// TODO Auto-generated method stub
		return new String[] {"/"};
	}
	//필터 등록하기
	@Override
	protected Filter[] getServletFilters() {
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("utf-8");
		//인코딩 설정한걸로 무조건 지정해주라는 메소드임
		filter.setForceEncoding(true);
		return new Filter[] {filter};
	}
}

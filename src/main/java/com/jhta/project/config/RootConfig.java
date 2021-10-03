package com.jhta.project.config;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;


//root-context.xml을 대신하는 클래스
@Configuration
@MapperScan(basePackages = {"com.jhta.mybatis.mapper"})
@ComponentScan(basePackages = {"com.jhta.project.service"}, excludeFilters = @ComponentScan.Filter(type = FilterType.ASPECTJ, pattern = "com.jhta.controller.*"))

public class RootConfig {
	@Bean
	public BasicDataSource dataSource() {
		BasicDataSource datasource = new BasicDataSource();
		datasource.setDriverClassName("oracle.jdbc.OracleDriver");
		datasource.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		datasource.setUsername("final");
		datasource.setPassword("final1234");
		return datasource;
	}
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception{
		SqlSessionFactoryBean sb = new SqlSessionFactoryBean();
		sb.setDataSource(dataSource());
		//매퍼 로케이션은 안줘도 된다. mapperscan에서 두가지 모두 해준다고보면된다.
		return (SqlSessionFactory)sb.getObject();
	}
}

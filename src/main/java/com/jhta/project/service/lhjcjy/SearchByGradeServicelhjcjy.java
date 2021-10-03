package com.jhta.project.service.lhjcjy;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.lhjcjy.SearchByGradeMapperlhjcjy;
import com.jhta.project.vo.lhjcjy.SearchVolhjcjy;



@Service
public class SearchByGradeServicelhjcjy {
@Autowired private SearchByGradeMapperlhjcjy mapper;

	public List<SearchVolhjcjy> getGradeSec(HashMap<String, Object> map){
		return mapper.getGradeSec(map);
	}
}

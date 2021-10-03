package com.jhta.project.service.lhjcjy;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.lhjcjy.AutoCompleteMapperlhjcjy;
import com.jhta.mybatis.mapper.lhjcjy.FirstSearchMapperlhjcjy;
import com.jhta.mybatis.mapper.lhjcjy.SearchByStarMapperlhjcjy;
import com.jhta.project.vo.lhjcjy.SearchVolhjcjy;



@Service
public class SearchByStarServicelhjcjy {
@Autowired private SearchByStarMapperlhjcjy mapper;

	public List<SearchVolhjcjy> getStarList(HashMap<String, Object> map){
		return mapper.getStarList(map);
	}
	
	public List<SearchVolhjcjy> getStarSec(HashMap<String, Object> map){
		return mapper.getStarSec(map);
	}
}

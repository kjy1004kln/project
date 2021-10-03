package com.jhta.mybatis.mapper.lhjcjy;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.lhjcjy.SearchVolhjcjy;


public interface SearchByGradeMapperlhjcjy {
	public List<SearchVolhjcjy> getGradeSec(HashMap<String, Object> map);
}

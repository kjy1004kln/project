package com.jhta.mybatis.mapper.lhjcjy;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.lhjcjy.SearchVolhjcjy;


public interface SearchByStarMapperlhjcjy {
	public List<SearchVolhjcjy> getStarList(HashMap<String, Object> map);
	public List<SearchVolhjcjy> getStarSec(HashMap<String, Object> map);
}

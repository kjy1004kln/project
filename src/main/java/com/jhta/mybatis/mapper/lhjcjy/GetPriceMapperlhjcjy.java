package com.jhta.mybatis.mapper.lhjcjy;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.lhjcjy.AccommodationsVolhjcjy;



public interface GetPriceMapperlhjcjy {
	List<AccommodationsVolhjcjy> getprice(HashMap<String, Object> map);
	String daylist(HashMap<String, Object> map);
}

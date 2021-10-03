package com.jhta.mybatis.mapper.hjy.firstsearch;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.lhjcjy.AccommodationsVolhjcjy;

public interface GetPriceMapperHjy {
	List<AccommodationsVolhjcjy> getprice(HashMap<String, Object> map);
	String daylist(HashMap<String, Object> map);
}

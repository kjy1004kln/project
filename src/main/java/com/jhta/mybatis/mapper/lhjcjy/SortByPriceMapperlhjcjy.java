package com.jhta.mybatis.mapper.lhjcjy;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.lhjcjy.AccommodationsVo2lhjcjy;



public interface SortByPriceMapperlhjcjy {
	List<AccommodationsVo2lhjcjy> sortPrice_low(HashMap<String, Object> map);
	List<AccommodationsVo2lhjcjy> sortPrice_high(HashMap<String, Object> map);
	List<AccommodationsVo2lhjcjy> sortbyall(HashMap<String, Object> map);
	List<AccommodationsVo2lhjcjy> rangeSlider_price(HashMap<String, Object> map);
}

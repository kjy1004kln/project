package com.jhta.project.service.lhjcjy;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.lhjcjy.AutoCompleteMapperlhjcjy;
import com.jhta.mybatis.mapper.lhjcjy.FirstSearchMapperlhjcjy;
import com.jhta.project.vo.lhjcjy.AccommodationsVo2lhjcjy;
import com.jhta.project.vo.lhjcjy.RangeSlider_GetMinMaxVolhjcjy;




@Service
public class FirstSearchServicelhjcjy {
@Autowired private FirstSearchMapperlhjcjy mapper;
@Autowired private AutoCompleteMapperlhjcjy mapper1;

	public List<String> findhotel(String aname){
		return mapper1.findhotel(aname);
	}
	
	public List<AccommodationsVo2lhjcjy> searchDefault(HashMap<String, Object> map){
		return mapper.searchDefault(map);
	}
	public RangeSlider_GetMinMaxVolhjcjy rangeSlider_getMinMax(HashMap<String, Object> map) {
		return mapper.rangeSlider_getMinMax(map);
	}
}

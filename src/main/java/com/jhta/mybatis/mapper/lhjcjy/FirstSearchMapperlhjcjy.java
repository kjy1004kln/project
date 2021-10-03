package com.jhta.mybatis.mapper.lhjcjy;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.lhjcjy.AccommodationsVo2lhjcjy;
import com.jhta.project.vo.lhjcjy.RangeSlider_GetMinMaxVolhjcjy;




public interface FirstSearchMapperlhjcjy {
	public List<AccommodationsVo2lhjcjy> searchDefault(HashMap<String, Object> map);
	public RangeSlider_GetMinMaxVolhjcjy rangeSlider_getMinMax(HashMap<String, Object> map);
}

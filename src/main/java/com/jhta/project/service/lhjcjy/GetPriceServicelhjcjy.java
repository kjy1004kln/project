package com.jhta.project.service.lhjcjy;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.lhjcjy.GetPriceMapperlhjcjy;
import com.jhta.project.vo.lhjcjy.AccommodationsVolhjcjy;


@Service
public class GetPriceServicelhjcjy {
	@Autowired private GetPriceMapperlhjcjy mapper;
	
	public List<AccommodationsVolhjcjy> getprice(HashMap<String, Object> map){
		return mapper.getprice(map);
	}
	public String daylist(HashMap<String, Object> map) {
		return mapper.daylist(map);
	}
}

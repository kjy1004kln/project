package com.jhta.project.service.lhjcjyhjy;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.lhjcjy.GetPriceMapperlhjcjy;
import com.jhta.mybatis.mapper.lhjcjyhjy.GetPriceMapperlhjcjyhjy;
import com.jhta.project.vo.lhjcjy.AccommodationsVolhjcjy;


@Service
public class GetPriceServicelhjcjyhjy {
	@Autowired private GetPriceMapperlhjcjyhjy mapper;
	
	public List<AccommodationsVolhjcjy> getprice(HashMap<String, Object> map){
		return mapper.getprice(map);
	}
}

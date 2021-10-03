package com.jhta.project.service.kjy;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.kjy.FavoritesearchMapperkjy;
import com.jhta.project.vo.kjy.FavoritesearchVo_kjy;

@Service
public class FavoritesearchService_kjy {
	@Autowired private FavoritesearchMapperkjy mapper;
	public List<FavoritesearchVo_kjy> hotelsearch(String hotel) {
		return mapper.hotelsearch(hotel);
	}
	public List<FavoritesearchVo_kjy> airportsearch(String portname) {
		return mapper.airportsearch(portname);
	}
	public List<FavoritesearchVo_kjy> airlinesearch(String airname) {
		return mapper.airlinesearch(airname);
	}
}

package com.jhta.project.controller.kjy;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.mybatis.mapper.kjy.FavoriteMapperkjy;
import com.jhta.mybatis.mapper.kjy.FavoritesearchMapperkjy;
import com.jhta.project.vo.kjy.FavoriteVo_kjy;
import com.jhta.project.vo.kjy.FavoritesearchVo_kjy;

@Controller
public class FavoritesearchController_kjy {
	@Autowired private FavoritesearchMapperkjy service;
	@Autowired private FavoriteMapperkjy faservice;
	
	@RequestMapping(value="/user/kjy/hotelseach", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> hotelsearch(HttpServletRequest req, HttpServletResponse resp,
			String hotel){
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		HashMap<String, Object> map=new HashMap<String, Object>();
		List<FavoritesearchVo_kjy> list=service.hotelsearch(hotel);
		FavoriteVo_kjy favo=faservice.list(mid);
		String fahotel=favo.getFavhotel();
		
		if(fahotel!=null) {
			for(FavoritesearchVo_kjy vo:list) {
				//만약 등록되어있는 호텔일경우(contains단어가 포함되어있는지)
				if(fahotel.contains(vo.getKrchainname())) {
					vo.setKrchainname(null);
					vo.setEngchainname(null);
				}
			}
		}
		map.put("hotel",list);
		return map;
	}
	
	@RequestMapping(value="/user/kjy/airportsearch", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> airportsearch(HttpServletRequest req, HttpServletResponse resp,
			String portname){
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		HashMap<String, Object> map=new HashMap<String, Object>();
		List<FavoritesearchVo_kjy> list=service.airportsearch(portname);
		
		FavoriteVo_kjy favo=faservice.list(mid);
		String faport=favo.getFavairport();
		
		if(faport!=null) {
			for(FavoritesearchVo_kjy vo:list) {
				//만약 등록되어있는 호텔일경우(contains단어가 포함되어있는지)
				if(faport.contains(vo.getPortname())) {
					vo.setPortname(null);
				}
			}
		}
		
		map.put("port", list);
		return map;
	}
	
	@RequestMapping(value="/user/kjy/airlinesearch", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> airlinesearch(HttpServletRequest req, HttpServletResponse resp,
			String airname){
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		HashMap<String, Object> map=new HashMap<String, Object>();
		List<FavoritesearchVo_kjy> list=service.airlinesearch(airname);
		
		FavoriteVo_kjy favo=faservice.list(mid);
		String faline=favo.getFavairline();
		
		if(faline!=null) {
			for(FavoritesearchVo_kjy vo:list) {
				//만약 등록되어있는 호텔일경우(contains단어가 포함되어있는지)
				if(faline.contains(vo.getAirname())) {
					vo.setAirname(null);
				}
			}
		}
		
		map.put("air", list);
		return map;
	}
}

package com.jhta.project.controller.lhjcjy;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.jhta.project.service.lhjcjy.SearchByStarServicelhjcjy;
import com.jhta.project.vo.lhjcjy.SearchVolhjcjy;



@RestController
public class SearchByStarControllerlhjcjy {
	@Autowired private SearchByStarServicelhjcjy service;
	
	@RequestMapping(value = "lhjcjy/firstsearchStar", produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> list(String searchHotel, String checkin, String checkout, String countPeople, String countRoom){
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			String checkin1=checkin.replace("-", "");
			String checkout1=checkout.replace("-", "");
			map.put("aaddress", searchHotel);
			map.put("aname", searchHotel);
			map.put("rcheckin", checkin1);
			map.put("rcheckout", checkout1);
			map.put("rimaxper", countPeople);
			map.put("riminper", countPeople);
			map.put("countRoom", countRoom);
			//System.out.println("ajax: " + searchHotel + ", " + checkin  + ", " + checkout  + ", " + countRoom  + ", " + countPeople );
			
			List<SearchVolhjcjy> list = service.getStarList(map);
			map.put("list", list);
			//System.out.println("ajax: " + list);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return map;
	}
	
	@RequestMapping(value = "lhjcjy/starsection", produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> starsection(String searchHotel, String checkin, String checkout, String countPeople, String countRoom, int restar){
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			String checkin1=checkin.replace("-", "");
			String checkout1=checkout.replace("-", "");
			map.put("aaddress", searchHotel);
			map.put("aname", searchHotel);
			map.put("rcheckin", checkin1);
			map.put("rcheckout", checkout1);
			map.put("rimaxper", countPeople);
			map.put("riminper", countPeople);
			map.put("countRoom", countRoom);
			map.put("restar", restar);
			//System.out.println("ajax: " + searchHotel + ", " + checkin  + ", " + checkout  + ", " + countRoom  + ", " + countPeople );
			List<SearchVolhjcjy> list = service.getStarSec(map);
			map.put("list", list);
			//System.out.println("ajax: " + list);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return map;
	}
}

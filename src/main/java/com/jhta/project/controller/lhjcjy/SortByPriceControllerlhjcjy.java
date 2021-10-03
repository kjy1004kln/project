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
import org.springframework.web.servlet.ModelAndView;

import com.jhta.project.service.lhjcjy.SortByPriceServicelhycjy;
import com.jhta.project.vo.lhjcjy.AccommodationsVo2lhjcjy;


@RestController
public class SortByPriceControllerlhjcjy {
	@Autowired private SortByPriceServicelhycjy service;
	@RequestMapping(value = "lhjcjy/sortbyall", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> sortbyall(String searchHotel,String checkin,
			String checkout,String countPeople,String countRoom){
		HashMap<String, Object> hs =new HashMap<String, Object>();
		try {
			DateFormat df1=new SimpleDateFormat("yyyyMMdd");
			String checkin1=checkin.replace("-", "");
			String checkout1=checkout.replace("-", "");
			hs.put("aaddress", searchHotel);
			hs.put("aname", searchHotel);
			hs.put("rcheckin", checkin1);
			hs.put("rcheckout", checkout1);
			hs.put("rimaxper", countPeople);
			hs.put("countRoom", countRoom);
			List<AccommodationsVo2lhjcjy> list=service.sortbyall(hs);
			hs.put("list", list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return hs;
	}
	@RequestMapping(value = "lhjcjy/sortbyprice_low", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> sortbyprice(String searchHotel,String checkin,
			String checkout,String countPeople,String countRoom){
		HashMap<String, Object> hs =new HashMap<String, Object>();
		try {
			DateFormat df1=new SimpleDateFormat("yyyyMMdd");
			String checkin1=checkin.replace("-", "");
			String checkout1=checkout.replace("-", "");
			hs.put("aaddress", searchHotel);
			hs.put("aname", searchHotel);
			hs.put("rcheckin", checkin1);
			hs.put("rcheckout", checkout1);
			hs.put("rimaxper", countPeople);
			hs.put("countRoom", countRoom);
			List<AccommodationsVo2lhjcjy> list=service.sortPrice_low(hs);
			hs.put("list", list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return hs;
	}
	@RequestMapping(value = "lhjcjy/sortbyprice_high", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> sortbyprice_high(String searchHotel,String checkin,
			String checkout,String countPeople,String countRoom){
		HashMap<String, Object> hs =new HashMap<String, Object>();
		try {
			DateFormat df1=new SimpleDateFormat("yyyyMMdd");
			String checkin1=checkin.replace("-", "");
			String checkout1=checkout.replace("-", "");
			hs.put("aaddress", searchHotel);
			hs.put("aname", searchHotel);
			hs.put("rcheckin", checkin1);
			hs.put("rcheckout", checkout1);
			hs.put("rimaxper", countPeople);
			hs.put("countRoom", countRoom);
			List<AccommodationsVo2lhjcjy> list=service.sortPrice_high(hs);
			hs.put("list", list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return hs;
	}
	@RequestMapping(value="lhjcjy/rangeslider", produces= {MediaType.APPLICATION_JSON_VALUE} )
	public @ResponseBody HashMap<String, Object> pricegraph(String searchHotel,String checkin,
			String checkout,String countPeople,String countRoom, String minprice, String maxprice){
		HashMap<String, Object> hs =new HashMap<String, Object>();
		try {
			DateFormat df1=new SimpleDateFormat("yyyyMMdd");
			String checkin1=checkin.replace("-", "");
			String checkout1=checkout.replace("-", "");
			hs.put("aaddress", searchHotel);
			hs.put("aname", searchHotel);
			hs.put("rcheckin", checkin1);
			hs.put("rcheckout", checkout1);
			hs.put("rimaxper", countPeople);
			hs.put("countRoom", countRoom);
			hs.put("minprice", minprice);
			hs.put("maxprice", maxprice);
			System.out.println(minprice+","+maxprice);
			List<AccommodationsVo2lhjcjy> list=service.rangeSlider_price(hs);
			hs.put("list", list);
			System.out.println(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return hs;
	}
}

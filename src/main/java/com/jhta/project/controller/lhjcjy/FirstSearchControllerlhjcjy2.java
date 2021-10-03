package com.jhta.project.controller.lhjcjy;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.project.service.lhjcjy.FirstSearchServicelhjcjy;
import com.jhta.project.service.lhjcjy.GetPriceServicelhjcjy;
import com.jhta.project.service.lhjcjy.PeriodServicelhjcjy;
import com.jhta.project.vo.lhjcjy.AccommodationsVo2lhjcjy;
import com.jhta.project.vo.lhjcjy.AccommodationsVolhjcjy;
import com.jhta.project.vo.lhjcjy.RangeSlider_GetMinMaxVolhjcjy;
import com.jhta.project.vo.lhjcjy.SearchVolhjcjy;



@Controller
public class FirstSearchControllerlhjcjy2 {
	@Autowired private FirstSearchServicelhjcjy service;
	@Autowired private GetPriceServicelhjcjy gpservice;
	
	@GetMapping("lhjcjy/firstsearch3") //
	public String searchForm() {
		return "user/lhjcjy/firstsearch3";
	}

	@RequestMapping(value = "lhjcjy/firstsearch3", method = RequestMethod.POST)
	public ModelAndView search(String searchHotel, String checkin, String checkout, String countPeople, String countRoom) {
		HashMap<String, Object> hs = new HashMap<String, Object>();
		ModelAndView mv = new ModelAndView();
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
			
			mv.addObject("aaddress", searchHotel);
			mv.addObject("rcheckin", checkin);
			mv.addObject("rcheckout", checkout);
			mv.addObject("rimaxper", countPeople);
			mv.addObject("countRoom", countRoom);
			List<AccommodationsVolhjcjy> list = gpservice.getprice(hs);
			//List<AccommodationsVo2lhjcjy> list = service.searchDefault(hs);
			//입력한 날짜 중간포함 리스트 얻기
			HashMap<String, Object> hs1=new HashMap<String, Object>();
			String STARTDAY1=checkin.replace("-", "");
			String ENDDAY1=checkout.replace("-", "");
			hs1.put("STARTDAY", STARTDAY1);
			hs1.put("ENDDAY", ENDDAY1);
			
			RangeSlider_GetMinMaxVolhjcjy minmax=service.rangeSlider_getMinMax(hs);
			mv.addObject("minmax", minmax);
			mv.addObject("list", list);
			System.out.println(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		mv.setViewName("user/lhjcjy/firstsearch2");
		return mv;
	}
}

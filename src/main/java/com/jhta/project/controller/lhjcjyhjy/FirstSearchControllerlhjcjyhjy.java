package com.jhta.project.controller.lhjcjyhjy;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.project.controller.hjy.FirstSearchControllerHjy;
import com.jhta.project.service.lhjcjy.FirstSearchServicelhjcjy;
import com.jhta.project.service.lhjcjyhjy.GetPriceServicelhjcjyhjy;
import com.jhta.project.vo.lhjcjy.AccommodationsVolhjcjy;
import com.jhta.project.vo.lhjcjy.RangeSlider_GetMinMaxVolhjcjy;



@Controller
public class FirstSearchControllerlhjcjyhjy {
	@Autowired private FirstSearchServicelhjcjy service;
	@Autowired private GetPriceServicelhjcjyhjy gpservice;
	
	Logger logger = LoggerFactory.getLogger(FirstSearchControllerHjy.class);

	//메인검색 완성하면 지우기
	@GetMapping("lhjcjyhjy/firstsearch") //
	public String searchForm() {
		return "user/lhjcjyhjy/firstsearch";
	}

	@RequestMapping(value = "lhjcjyhjy/firstsearch", method = RequestMethod.POST)
	public ModelAndView search(String searchHotel, String checkin, String checkout, String countPeople, String countRoom) {
		logger.debug(searchHotel);
		logger.debug(checkin);
		logger.debug(checkout);
		logger.debug(countPeople);
		logger.debug(countRoom);
		HashMap<String, Object> hs = new HashMap<String, Object>();
		ModelAndView mv = new ModelAndView();
		try {
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
			
			mv.addObject("nullmsg","조건에 맞는 호텔이 없습니다");
			RangeSlider_GetMinMaxVolhjcjy minmax=service.rangeSlider_getMinMax(hs);
			mv.addObject("minmax", minmax);
			mv.addObject("list", list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		mv.setViewName("user/lhjcjyhjy/firstsearch2");
		return mv;
	}
}

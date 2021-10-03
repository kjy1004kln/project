package com.jhta.project.controller.hjy;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.project.service.hjy.GetPriceServiceHjy;
import com.jhta.project.service.lhjcjy.FirstSearchServicelhjcjy;
import com.jhta.project.service.lhjcjy.GetPriceServicelhjcjy;
import com.jhta.project.service.lhjcjy.PeriodServicelhjcjy;
import com.jhta.project.vo.lhjcjy.AccommodationsVolhjcjy;
import com.jhta.project.vo.lhjcjy.SearchVolhjcjy;



@Controller
public class FirstSearchControllerHjy {
	@Autowired private GetPriceServiceHjy gpservicehjy;
	Logger logger = LoggerFactory.getLogger(FirstSearchControllerHjy.class);

	@GetMapping("hjy/firstsearch") //
	public String searchForm() {
		return "user/hjy/firstsearch/firstSearch";
	}

	@RequestMapping(value = "hjy/firstsearch", method = RequestMethod.POST)
	public ModelAndView search(String searchHotel, String checkin, String checkout, String countPeople, String countRoom) {
		logger.debug(searchHotel);
		logger.debug(checkin);
		logger.debug(checkout);
		logger.debug(countPeople);
		logger.debug(countRoom);
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
			List<AccommodationsVolhjcjy> list = gpservicehjy.getprice(hs);
			mv.addObject("list", list);
		}catch(Exception e) {
			e.printStackTrace();
		}

		mv.setViewName("user/hjy/firstsearch/firstSearch2");
		return mv;
	}
}

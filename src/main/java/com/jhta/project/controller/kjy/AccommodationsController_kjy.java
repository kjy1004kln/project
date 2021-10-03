package com.jhta.project.controller.kjy;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.mybatis.mapper.kjy.AccommodationsMapperkjy;
import com.jhta.mybatis.mapper.kjy.ReservationMapperkjy;
import com.jhta.project.vo.kjy.FavoriteVo_kjy;
import com.jhta.project.vo.kjy.ReservationVo_kjy;


@Controller
public class AccommodationsController_kjy {
	
	@RequestMapping(value="/user/kjy/accommodations", method= RequestMethod.GET)
	public ModelAndView AccommodationsForm() {
		ModelAndView mv=new ModelAndView("user/kjy/accommodations");
		return mv;
	}
	
	@RequestMapping(value="/user/kjy/accommodations", method= RequestMethod.POST)
	public ModelAndView Accommodations(String mid, HttpServletRequest request) {
		HttpSession session=request.getSession(true);
		session.setAttribute("mid",mid);
		ModelAndView mv=new ModelAndView("user/kjy/accommodations");
		return mv;
	}
	
}

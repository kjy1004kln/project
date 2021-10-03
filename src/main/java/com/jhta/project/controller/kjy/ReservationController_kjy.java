package com.jhta.project.controller.kjy;


import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.mybatis.mapper.kjy.MypageMapperkjy;
import com.jhta.mybatis.mapper.kjy.ReservationMapperkjy;
import com.jhta.mybatis.mapper.kjy.ReviewMapperkjy;
import com.jhta.project.util.kjy.PageUtil_kjy;
import com.jhta.project.vo.kjy.MypageVo_kjy;
import com.jhta.project.vo.kjy.PayMentVo_kjy;
import com.jhta.project.vo.kjy.ReservationVo_kjy;

@Controller
public class ReservationController_kjy {
	@Autowired private ReservationMapperkjy service;
	@Autowired private MypageMapperkjy mypageservice;
	
	@RequestMapping(value="/user/kjy/reservation", method = RequestMethod.GET)
	public ModelAndView ReservationForm(String riid, String startday, String endday, String ramount, String mid, 
			String sum) {
		ModelAndView mv=new ModelAndView("user/kjy/reservation");
		mv.addObject("riid",riid);
		mv.addObject("startday",startday);
		mv.addObject("endday",endday);
		mv.addObject("ramount",ramount);
		mv.addObject("sum",sum);
		mv.addObject("mid",mid);
		return mv;
	}
	
	@RequestMapping(value="/user/kjy/reservationlist", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> reservationlist(HttpServletRequest req, HttpServletResponse resp,
			@RequestParam(value="pageNum",defaultValue = "1") int pageNum){
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		
		//페이징처리
		int pastcount=service.pastcount(mid);
		PageUtil_kjy pu=new PageUtil_kjy(pageNum, 5, 5, pastcount);
		HashMap<String, Object> pmap=new HashMap<String, Object>();
		pmap.put("startRowNum", pu.getStartRow());
		pmap.put("endRowNum", pu.getEndRow());
		pmap.put("mid", mid);
		
		List<ReservationVo_kjy> pastlist=service.pastlist(pmap);
		List<ReservationVo_kjy> currentlist=service.currentlist(mid);
		
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("startPageNum", pu.getStartPageNum());
		map.put("endPageNum", pu.getEndPageNum());
		map.put("pageCount", pu.getTotalPageCount());
		map.put("pageNum", pageNum);
		map.put("pastlist", pastlist);
		map.put("currentlist", currentlist);
		return map;
	}
	
	@RequestMapping(value="/user/kjy/reservationpwdcheck", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> reservationpwdcheck(HttpServletRequest req, HttpServletResponse resp,
			String mpw){
		HashMap<String, Object> map=new HashMap<String, Object>();
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		MypageVo_kjy vo=mypageservice.list(mid);
		if(mpw.equals(vo.getMpw()) || mpw==vo.getMpw()) {
			map.put("code", "success");
		}else {
			map.put("code", "fail");
		}
		return map;
	}
	
	@RequestMapping(value="/user/kjy/reservationcancel", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> reservationcancel(HttpServletRequest req, HttpServletResponse resp,
			String pid){
		int pid1=Integer.parseInt(pid);
		HashMap<String, Object> map=new HashMap<String, Object>();
		PayMentVo_kjy vo=service.payment(pid1);
		int rid=vo.getRid();
		int n=service.rcancel(rid);//예약페이지 업데이트
		//int n1=service.refund(pid1);//결제페이지 업데이트
		if(n>0) {
			map.put("code", "success");
		}else {
			map.put("code", "fail");
		}
		return map;
	}
	
}

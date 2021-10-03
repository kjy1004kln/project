package com.jhta.project.controller.phj;


import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.project.service.jhr.MembersService;
import com.jhta.project.service.phj.ReservationServicephj;
import com.jhta.project.vo.jhr.MembersVo;
import com.jhta.project.vo.phj.ReservationVo;

@Controller
public class ReservationController_phj {
	@Autowired private ReservationServicephj service;
	@Autowired private MembersService memberService;
	@GetMapping("phj/pay")
	public String payForm() {
		return "user/phj/pay";
	}
	
	@RequestMapping(value="phj/checkReservation/{mid}",produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> checkRes(@PathVariable("mid")String mid){
		ReservationVo vo=service.selectRes(mid);
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("mid", vo.getMid());
		map.put("rordernum", vo.getRordernum());
		return map;
	}
	
	@RequestMapping(value="phj/reservation",method=RequestMethod.GET)
	public ModelAndView ReservationInfo(String riid, String startday, String endday, String ramount, String mid, 
			String sum,int aid,int roomnum) {
		ModelAndView mv=new ModelAndView("user/phj/resinfo");
		mv.addObject("riid",riid);
		mv.addObject("startday",startday);
		mv.addObject("endday",endday);
		mv.addObject("ramount",ramount);
		mv.addObject("sum",sum);
		mv.addObject("mid",mid);
		mv.addObject("aid",aid);
		mv.addObject("rroomnum",roomnum);
		return mv;
	}
	@RequestMapping(value="phj/reservationOk",method=RequestMethod.GET)
	public ModelAndView ReservationInsert(ReservationVo vo,String sum,int rexperson,int rexbed,int rexbreaknum,
			String breakfastfee,String bedfee,String personfee,String totalbedfee,String totalbreakfee) {
		ModelAndView mv=new ModelAndView("user/phj/pay");
		mv.addObject("sum", sum);
		mv.addObject("rid", vo.getRid());
		mv.addObject("rroomnum", vo.getRroomnum());
		mv.addObject("ramount", vo.getRamount());
		mv.addObject("rcheckin", vo.getRcheckin());
		mv.addObject("rcheckout", vo.getRcheckout());
		mv.addObject("rresname", vo.getRresname());
		mv.addObject("rresemail", vo.getRresemail());
		mv.addObject("rresphone", vo.getRresphone());
		mv.addObject("rexbreaknum", vo.getRexbreaknum());
		mv.addObject("rexbed",vo.getRexbed());
		mv.addObject("rexperson", vo.getRexperson());
		mv.addObject("rcancel", vo.getRcancel());
		mv.addObject("mid", vo.getMid());
		mv.addObject("riid", vo.getRiid());
		mv.addObject("rordernum", vo.getRordernum());
		MembersVo membersVo = memberService.checkId( vo.getMid());
		mv.addObject("membersVo", membersVo);
		mv.addObject("rexperson", rexperson);
		mv.addObject("rexbreaknum", rexbreaknum);
		mv.addObject("rexbed", rexbed);
		mv.addObject("breakfastfee",breakfastfee);
		mv.addObject("bedfee", bedfee);
		mv.addObject("totalpersonfee", personfee);
		mv.addObject("totalbedfee", totalbedfee);
		mv.addObject("totalbreakfee", totalbreakfee);
		mv.addObject("code","success");
		mv.addObject("code","fail");
		return mv;
	}
	
	@RequestMapping(value="phj/insert",produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> insert(
			@RequestBody ReservationVo vo) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		try {
			service.insertRes(vo);
			map.put("rid",vo.getRid());
			map.put("ptoken", vo.getPtoken());
			map.put("code","success");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("code","fail");
		}
		return map;
	}
}

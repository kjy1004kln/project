package com.jhta.project.controller.phj;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.project.service.phj.Additional_feeService_phj;
import com.jhta.project.vo.phj.Additional_FeeVo_phj;

@Controller
public class Additional_feeController {
	@Autowired private Additional_feeService_phj service;
	
	@GetMapping(value="phj/addfee/{riid}",produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> addfee(@PathVariable("riid")int riid){
		Additional_FeeVo_phj vo=service.selectFee(riid);
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("personfee", vo.getAfpersonnel());
		map.put("bedfee", vo.getAfbed());
		map.put("breakfastfee", vo.getAfbreakfast());
		return map;
	}
}

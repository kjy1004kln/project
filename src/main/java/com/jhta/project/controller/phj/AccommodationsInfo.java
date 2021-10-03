package com.jhta.project.controller.phj;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.project.service.phj.AccommodationsService_phj;
import com.jhta.project.vo.hjy.Room_InfoVo;
import com.jhta.project.vo.phj.AccommodationsVo;

@Controller
public class AccommodationsInfo {
	@Autowired private AccommodationsService_phj service;
	@GetMapping("/test")
	public String test() {
		return "user/phj/test";
	}
	
	@GetMapping(value="/phj/accoinfo/{aid}",produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> accoinfo(@PathVariable("aid")int aid) {
		AccommodationsVo vo=service.select(aid);
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("aname",vo.getAname());
		map.put("amainimg",vo.getAmainimg());
		map.put("aphone",vo.getAphone());
		map.put("aaddress",vo.getAaddress());
		return map;
	}
	
}

package com.jhta.project.controller.lhjcjy;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jhta.project.service.lhjcjy.FirstSearchServicelhjcjy;
import com.jhta.project.vo.lhjcjy.AccommodationsVolhjcjy;

@RestController
public class FirstSearchAjaxControllerlhjcjy {
	@Autowired private FirstSearchServicelhjcjy service;
	
	@RequestMapping(value="/lhjcjy/ajax/auto", produces= {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> autolist(String aname,HttpServletRequest request,
            HttpServletResponse response) {
		
		HashMap<String, Object> map =new HashMap<String, Object>();
		List<String> list= service.findhotel(aname);
		System.out.println(list);
		map.put("list", list);
		return map;
	}
}

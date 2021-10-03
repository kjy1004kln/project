package com.jhta.project.controller.jhr;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.mybatis.mapper.jhr.UserqnaMapper;
import com.jhta.project.vo.jhr.UserqnaVo;
import com.jhta.util.PageUtil;

@Controller
public class ListController {
	@Autowired UserqnaMapper service;
	@RequestMapping(value="/user/jhr/list", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> reservationlist(HttpServletRequest req, HttpServletResponse resp,
			@RequestParam(value="pageNum",defaultValue = "1") int pageNum, String category){
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		//페이징처리
		HashMap<String, Object> countmap=new HashMap<String, Object>();
		countmap.put("mid", mid);
		countmap.put("category", category);
		int count=service.count(countmap);
		PageUtil pu=new PageUtil(pageNum,10,10,count);
		HashMap<String, Object> pmap=new HashMap<String, Object>();
		pmap.put("category", category);
		pmap.put("startRowNum", pu.getStartRow());
		pmap.put("endRowNum", pu.getEndRow());
		pmap.put("mid", mid);
		List<UserqnaVo> list=service.list(pmap);
		
		
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("startPageNum", pu.getStartPageNum());
		map.put("endPageNum", pu.getEndPageNum());
		map.put("pageCount", pu.getTotalPageCount());
		map.put("pageNum", pageNum);
		map.put("list", list);
		return map;
	}
}

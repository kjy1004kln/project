package com.jhta.project.controller.jhr;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.mybatis.mapper.kjy.ChatMapperkjy;
import com.jhta.project.vo.kjy.Chat_buddyVo_kjy;
import com.jhta.project.vo.kjy.Chat_membersVo_kjy;

@Controller
public class Chat_buddydelController {
	@Autowired private ChatMapperkjy service;
	
	@RequestMapping(value="/user/jhr/buddyDel", method= RequestMethod.GET)
	public ModelAndView buddyDelete (String cbbuid, String cmid, HttpServletRequest req, HttpServletResponse resp) {
		ModelAndView mv=new ModelAndView("user/kjy/chat_main");
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("cmid", cmid);
		map.put("cbbuid", cbbuid);
		service.delete(map);
		Chat_membersVo_kjy vo=service.member(cmid);
		List<Chat_membersVo_kjy> list=service.buddy(cmid);
		mv.addObject("vo",vo);
		mv.addObject("list",list);
		return mv;
	}
}

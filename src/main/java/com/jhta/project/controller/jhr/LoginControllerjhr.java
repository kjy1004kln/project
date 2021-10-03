package com.jhta.project.controller.jhr;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.jhta.project.service.jhr.MembersService;
import com.jhta.project.vo.jhr.MembersVo;

@Controller
public class LoginControllerjhr {
	@Autowired private MembersService service;
	@GetMapping("/jhr/login")
	public String loginForm() {
		return "user/jhr/login";
	}
	@PostMapping("/jhr/login")
	public String login(String mid, String mpw, HttpSession session, Model model) {
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("mid",mid);
		map.put("mpw",mpw);
		MembersVo vo=service.isMember(map);
		if(vo!=null && vo.getMdrop()!=null) {
			model.addAttribute("errMsg","탈퇴한 회원은 로그인 할 수 없습니다.");
			return "user/jhr/login";
		}
		if(vo!=null) { //회원인 경우 세션에 아이디 담기
			session.setAttribute("mid", mid);
			session.setAttribute("mpw", mpw);
			return "redirect:/";
		} else {
			model.addAttribute("errMsg", "아이디 또는 비밀번호가 맞지 않습니다.");
			return "user/jhr/login";
		}
	}
	@GetMapping("/jhr/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}

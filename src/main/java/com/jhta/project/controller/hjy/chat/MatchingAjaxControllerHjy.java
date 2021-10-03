package com.jhta.project.controller.hjy.chat;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jhta.mybatis.mapper.hjy.chat.ChatBuddyMapperHjy;
import com.jhta.project.service.hjy.ChatAddServiceHjy;
import com.jhta.project.service.hjy.ChatMembersServiceHjy;
import com.jhta.project.vo.hjy.ChatAddVo;
import com.jhta.project.vo.hjy.ChatBuddyVo;

@RestController
public class MatchingAjaxControllerHjy {
	@Autowired ChatAddServiceHjy chatAddService;
	@Autowired ChatBuddyMapperHjy chatBuddyService;
	@Autowired ChatMembersServiceHjy chatMembersService;
	/**
	 * 요청한 친구목록 불러올 ajax
	 * @param session
	 * @return
	 */
	@RequestMapping(value="hjy/chatAddList")
	public HashMap<String, Object> chatAddList(HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<ChatAddVo> list = chatAddService.chatAddList((String)session.getAttribute("mid"));
		map.put("list", list);
		return map;
	}
	/**
	 * 친구요청 눌렀을때 실행되는 ajax
	 * @param toId
	 * @param session
	 * @return
	 */
	@RequestMapping(value="hjy/friendreq")
	public HashMap<String, Object> friendreq(String reqId,String myId,HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			int n = chatAddService.isexist(new ChatAddVo(0, myId, reqId,null));
			if(n>0) {
				map.put("result", "친구 요청 대기중인 회원입니다.");
			}else {
				chatAddService.friendReqInsert(new ChatAddVo(0, myId, reqId,null));
				map.put("result", "친구 요청을 전송하였습니다.");
			}
		}catch(Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
		}
		return map;
	}
	/**
	 * 친구목록 ajax
	 * @param myId
	 * @return
	 */
	@RequestMapping(value="/hjy/chatBuddyList", produces= {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> chatBuddyList(String myId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			List<ChatBuddyVo> list = chatBuddyService.chatBuddyList(myId);
			map.put("list", list);
			map.put("result", "success");
		}catch (Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
		}
		return map;
	}
	/**
	 * 받은 친구 요청을 처리하는 ajax
	 * @param reqId
	 * @param myId
	 * @param select
	 * @return
	 */
	@RequestMapping(value="/hjy/accdelreq", produces= {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> accdelreq(String reqId, String myId,String select) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> del = new HashMap<String, Object>();
		try {
			del.put("cmid", myId);
			del.put("caaddid", reqId);
			chatAddService.delete(del);
			if(select.equals("acc")) {
				chatBuddyService.buddyInsert(new ChatBuddyVo(0, reqId, myId));
			}
			map.put("result", "success");
		}catch (Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
		}
		map.put("sel", select);
		return map;
	}
}

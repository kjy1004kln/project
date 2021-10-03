package com.jhta.project.controller.kjy;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.jhta.mybatis.mapper.kjy.ChatMapperkjy;
import com.jhta.project.handler.SocketHandler;
import com.jhta.project.vo.kjy.Chat_membersVo_kjy;
import com.jhta.project.vo.kjy.Chat_messageVo_kjy;
import com.jhta.project.vo.kjy.Chat_roomjoinVo_kjy;

@Controller
public class Chat_mainController_kjy {
	@Autowired private ChatMapperkjy service;
	@Autowired private SocketHandler sockethandler;
	
	@RequestMapping(value="/user/kjy/chat_main", method= RequestMethod.GET)
	public ModelAndView chat_Form(HttpServletRequest req, HttpServletResponse resp) {
		ModelAndView mv=new ModelAndView("user/kjy/chat_main");
		HttpSession session=req.getSession();
		String cmid=(String)session.getAttribute("mid");
		//본인 프로필 불러오기
		Chat_membersVo_kjy vo=service.member(cmid);
		//날짜 형식 변경
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String strNowDate = simpleDateFormat.format(vo.getCmbirth());
		
		//친구목록 불러오기
		List<Chat_membersVo_kjy> list=service.buddy(cmid);
		mv.addObject("list",list);
		mv.addObject("strNowDate",strNowDate);
		mv.addObject("vo", vo);
		return mv;
	}
	
	@RequestMapping(value="/user/kjy/chat_room1", produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> chat_room1(String cmid){
		HashMap<String, Object> map=new HashMap<String, Object>();
		HashMap<String, Object> countmap=new HashMap<String, Object>();
		List<HashMap<String, Object>> countlist=new ArrayList<HashMap<String,Object>>();
		List<String> chat_rank=service.chat_rank(cmid);
		for (int i=0; i<chat_rank.size(); i++) {
			String crid = chat_rank.get(i);
			countmap=service.count(crid);
			countlist.add(countmap);
		}
		map.put("countlist", countlist);
		return map;
	}
	
	@RequestMapping(value="/user/kjy/chat_room2", produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> chat_room2(String cmid, String crid){
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("cmid", cmid);
		map.put("crid", crid);
		List<Chat_roomjoinVo_kjy> list=service.roomjoin(map);
		List<Chat_messageVo_kjy> list2=service.chat_message_recently(crid);
		//안읽은 메세지 개수 구하기
		int notread=service.chat_msg_notread(map);
		
		HashMap<String, Object> listmap=new HashMap<String, Object>();
		
		
		listmap.put("list", list);
		listmap.put("list2", list2);
		listmap.put("notread", notread);
		return listmap;
	}
	@RequestMapping(value="/user/kjy/chating_check", method= RequestMethod.GET)
	public ModelAndView chating_check(String cmid, String cbbuid, String cmprofile, String cmname) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		ModelAndView mv=new ModelAndView("user/kjy/chat_room");
		int cnt=0;
		int crid=0;
		boolean check=false; //방여부 체크
		//cmid=본인아이디, cbbuid=친구아이디
		HashMap<String, Object> checkmap=new HashMap<String, Object>();
		checkmap.put("cmid", cmid);
		checkmap.put("cbbuid", cbbuid);
		List<Chat_roomjoinVo_kjy> roomcheck=service.roomcheck(checkmap);
		if(roomcheck.isEmpty()) {
			//검색결과 아무것도 없을경우
			check=true;
		}
		if(check==false) {
			check=true;
			//검색결과는 있으나 2명이상 방일경우(신규생성가능)
			for(Chat_roomjoinVo_kjy vo:roomcheck) {
				cnt=service.roomcheck_cnt(vo.getCrid());
				if(cnt==2) {
					crid=vo.getCrid();
					check=false;
					break;
				}
			}
		}

		if(check==true) {
			//새로 방 생성
			int n1=service.chat_room_insert();
			//방금 생성한 시퀀스 번호 확인(방번호)
			crid=service.room_seq();
			HashMap<String, Object> roomjoin=new HashMap<String, Object>();
			roomjoin.put("cmid",cmid);
			roomjoin.put("crid",crid);
			//cmid=본인아이디로 된 roomjoin생성
			int n2=service.chat_roomjoin_insert(roomjoin);
			roomjoin.put("cmid", cbbuid);
			//cbbuid=친구아이디로 된 roomjoin생성
			int n3=service.chat_roomjoin_insert(roomjoin);
			
			//방생성시 시스템 메세지 발송
			//본인입장
			Chat_messageVo_kjy sysvo1=new Chat_messageVo_kjy(0, null, null, cmname+"님이 입장하셨습니다.", cmid, crid, null, null, null);
			//친구입장
			Chat_membersVo_kjy cmvo=service.member(cbbuid);
			Chat_messageVo_kjy sysvo2=new Chat_messageVo_kjy(0, null, null, cmvo.getCmname()+"님이 입장하셨습니다.", cbbuid, crid, null, null, null);
			int sysmsg1=service.chat_message_system(sysvo1);
			int sysmsg2=service.chat_message_system(sysvo2);
			if(sysmsg1==0 || sysmsg2==0) {
				System.out.println("시스템 메세지 오류");
			}
			
			if(n1==0 && n2==0 && n3==0) {
				System.out.println("방생성 오류발생");
			}
			mv.addObject("cmid",cmid);//본인아이디 전송
			mv.addObject("cmprofile", cmprofile);//본인 프로필 전송
			mv.addObject("cmname",cmname);//본인 이름 전송
			mv.addObject("crid",crid);//방번호 전송
		}else if(check==false) {
			//기존에 있던 방 열기
			mv.addObject("cmid",cmid);//본인아이디 전송
			mv.addObject("cmprofile", cmprofile);//본인 프로필 전송
			mv.addObject("cmname",cmname);//본인 이름 전송
			mv.addObject("crid",crid);//방번호 전송
		}
		return mv;
	}
	
	@RequestMapping(value="/user/kjy/chating_room", method= RequestMethod.GET)
	public ModelAndView chating_room(String cmid, String crid, String cmprofile, String cmname) {
		ModelAndView mv=new ModelAndView("user/kjy/chat_room");
		mv.addObject("cmid",cmid);//본인아이디 전송
		mv.addObject("cmprofile", cmprofile);//본인 프로필 전송
		mv.addObject("cmname",cmname);//본인 이름 전송
		mv.addObject("crid",crid);//방번호 전송
		return mv;
	}
	
	@RequestMapping(value="/user/kjy/messagelist", produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> messagelist(String crid){
		HashMap<String, Object> map=new HashMap<String, Object>();
		int crid1=Integer.parseInt(crid);
		List<Chat_messageVo_kjy> list=service.chat_message_list(crid1);
		map.put("list", list);
		return map;
	}

	@RequestMapping(value="/user/kjy/chat_exit", produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> chat_exit(String crid, String cmid,String cmname){
		HashMap<String, Object> map=new HashMap<String, Object>();
		int crid1=Integer.parseInt(crid);
		//시스템 메세지 보내기
		String msgsysmsg=cmname+"님이 나가셨습니다.";
		Chat_messageVo_kjy msgvo=new Chat_messageVo_kjy(0, null, null,msgsysmsg, cmid, crid1, null, null, null);
		int n=service.chat_message_system(msgvo);
		//채팅메세지 테이블에서 아이디 unknown으로 변경
		HashMap<String, Object> exitmap=new HashMap<String, Object>();
		exitmap.put("cmid", cmid);
		exitmap.put("crid", crid);
		int n1=service.chat_exit(exitmap);
		//채팅방연결 테이블에서 아이디 unknown으로 변경
		int n2=service.chat_exit_join(exitmap);
		if(n==0 && n1==0 && n2==0) {
			System.out.println("채팅방 나가기 작업 실패!");
			map.put("code", "fail");
		}else {
			map.put("code", "success");
			map.put("msgsysmsg", msgsysmsg);
		}
		return map;
	}
	
	
	//채팅방 친구초대 페이지
	@RequestMapping(value="/user/kjy/chat_add", method= RequestMethod.GET)
	public @ResponseBody ModelAndView chat_add(String crid, String cmid, String cmname, String cmprofile){
		ModelAndView mv=new ModelAndView("user/kjy/chat_add");
		HashMap<String, Object> checkmap=new HashMap<String, Object>();
		checkmap.put("cmid", cmid);
		checkmap.put("crid", crid);
		List<Chat_membersVo_kjy> list=service.chat_add_check(checkmap);
		mv.addObject("cmid",cmid);//본인아이디 전송
		mv.addObject("cmprofile", cmprofile);//본인 프로필 전송
		mv.addObject("cmname",cmname);//본인 이름 전송
		mv.addObject("crid",crid);//방번호 전송
		mv.addObject("list", list);
		return mv;
	}
	
	//친구초대 리스트
	@RequestMapping(value="/user/kjy/chat_addlist", produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> chat_addlist(@RequestParam(value="addcbbuid[]") String[] addcbbuid, 
			@RequestParam(value="crid") int crid) throws Exception{
		HashMap<String, Object> map=new HashMap<String, Object>();
		boolean check=false;
		//방번호에 친구아이디 추가
		
		HashMap<String, WebSocketSession> sessionMap = sockethandler.getSessionList();
		for(int i=0; i<addcbbuid.length; i++) {
			HashMap<String, Object> magsys=new HashMap<String, Object>();
			String cmid=addcbbuid[i];
			HashMap<String, Object> addmap=new HashMap<String, Object>();
			addmap.put("cmid", cmid);
			addmap.put("crid", crid);
			int n=service.chat_roomjoin_insert(addmap);
			if(n==0) {
				System.out.println("오류발생!");
				check=false;
				break;
			}else {
				check=true;
				//시스템 메세지 발송
				Chat_membersVo_kjy memvo=service.member(cmid);
				String msgsysmessage=memvo.getCmname()+"님이 입장하셨습니다.";
				Chat_messageVo_kjy sysmsgvo=new Chat_messageVo_kjy(0, null, null, msgsysmessage, cmid, crid, null, null, null);
				int sysnum=service.chat_message_system(sysmsgvo);
				System.out.println(sysnum);
				magsys.put("msgsysmessage",msgsysmessage);
				
				//메세지 보내기
				JSONObject obj=new JSONObject();
				obj.put("msgsysmsg",msgsysmessage);
				for(String key : sessionMap.keySet()) {
					WebSocketSession wss = sessionMap.get(key);
					try {
						wss.sendMessage(new TextMessage(obj.toJSONString()));
					}catch(Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		
		if(check==true) {
			map.put("code", "success");
		}else {
			map.put("code", "fail");
		}
		return map;
	}
	
	@RequestMapping(value="/user/kjy/chat_close", produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> chat_close(String cmid, String crid){
		HashMap<String, Object> closemap=new HashMap<String, Object>();
		HashMap<String, Object> map=new HashMap<String, Object>();
		System.out.println(cmid);
		closemap.put("cmid", cmid);
		closemap.put("crid", crid);
		int n=service.chat_close(closemap);
		if(n>0) {
			map.put("code", "success");
		}else {
			map.put("code", "fail");
		}
		return map;
	}
	
	@RequestMapping(value="/user/kjy/chat_cmscname", produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> chat_cmscname(String cmscname, String cmid){
		HashMap<String, Object> cmsmap=new HashMap<String, Object>();
		HashMap<String, Object> map=new HashMap<String, Object>();
		cmsmap.put("cmid", cmid);
		cmsmap.put("cmscname", cmscname);
		int n=service.cmscname(cmsmap);
		if(n>0) {
			map.put("code", "success");
		}else {
			map.put("code", "fail");
		}
		return map;
	}
}

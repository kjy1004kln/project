package com.jhta.project.handler;

import java.util.ArrayList;
import java.util.HashMap;


import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.jhta.mybatis.mapper.kjy.ChatMapperkjy;
import com.jhta.project.vo.kjy.Chat_messageVo_kjy;

@Component
public class SocketHandler extends TextWebSocketHandler{
	@Autowired private ChatMapperkjy service;
	HashMap<String, WebSocketSession> sessionMap = new HashMap<>();
	
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) {
		String msg = message.getPayload();
		JSONObject obj = JsonToObjectParser(msg);
		String cmid=(String) obj.get("cmid");
		int crid=Integer.valueOf((String) obj.get("crid"));
		String msgmessage=(String) obj.get("msgmessage");
		String msgsysmsg=(String) obj.get("msgsysmsg");
		int n=0;
		//채팅방 메세지 보내기(db저장)
		if(msgmessage!=null && msgsysmsg==null ) {
			Chat_messageVo_kjy vo=new Chat_messageVo_kjy(0, msgmessage, null, null , cmid, crid, null, null, null);
			n=service.chat_message_insert(vo);
		}
		if(n==0) {
			System.out.println("채팅메세지 입력실패");
		}
		
		for(String key : sessionMap.keySet()) {
			WebSocketSession wss = sessionMap.get(key);
			try {
				wss.sendMessage(new TextMessage(obj.toJSONString()));
				System.out.println("obj.toJSONString():"+obj.toJSONString());
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	@SuppressWarnings("unchecked")
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//소켓 연결
		
		super.afterConnectionEstablished(session);
		sessionMap.put(session.getId(), session);
		JSONObject obj = new JSONObject();
		obj.put("type", "getId");
		obj.put("sessionId", session.getId());
		session.sendMessage(new TextMessage(obj.toJSONString()));
		System.out.println("소켓연결!");
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//소켓 종료
		sessionMap.remove(session.getId());
		super.afterConnectionClosed(session, status);
	}
	
	private static JSONObject JsonToObjectParser(String jsonStr) {
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(jsonStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return obj;
	}
	
	public HashMap<String, WebSocketSession> getSessionList() throws Exception{
		return sessionMap;
	}
}
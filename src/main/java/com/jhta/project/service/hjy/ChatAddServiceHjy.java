package com.jhta.project.service.hjy;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.hjy.chat.ChatAddMapperHjy;
import com.jhta.project.vo.hjy.ChatAddVo;

@Service
public class ChatAddServiceHjy {
	@Autowired ChatAddMapperHjy mapper;
	public int friendReqInsert(ChatAddVo vo) {
		return mapper.friendReqInsert(vo);
	};
	public List<ChatAddVo> chatAddList(String cmid){
		return mapper.chatAddList(cmid);
	};
	public int isexist(ChatAddVo vo) {
		return mapper.isexist(vo);
	};
	public int delete(HashMap<String, Object> del) {
		return mapper.delete(del);
	};
}

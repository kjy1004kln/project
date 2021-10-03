package com.jhta.project.service.hjy;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.hjy.chat.ChatBuddyMapperHjy;
import com.jhta.project.vo.hjy.ChatBuddyVo;

@Service
public class ChatBuddyServiceHjy {
	@Autowired ChatBuddyMapperHjy mapper;
	public int buddyInsert(ChatBuddyVo vo) {
		return mapper.buddyInsert(vo);
	};
	public List<ChatBuddyVo> chatBuddyList(String cmid) {
		return mapper.chatBuddyList(cmid);
	};
}

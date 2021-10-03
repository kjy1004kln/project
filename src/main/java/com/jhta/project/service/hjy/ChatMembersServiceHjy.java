package com.jhta.project.service.hjy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.hjy.chat.ChatMembersMapperHjy;
import com.jhta.project.vo.kjy.Chat_membersVo_kjy;

@Service
public class ChatMembersServiceHjy {
	@Autowired ChatMembersMapperHjy mapper;
	public Chat_membersVo_kjy find(String cmid) {
		return mapper.find(cmid);
	};
}

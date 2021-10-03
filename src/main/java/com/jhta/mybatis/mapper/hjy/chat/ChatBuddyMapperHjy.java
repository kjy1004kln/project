package com.jhta.mybatis.mapper.hjy.chat;

import java.util.List;

import com.jhta.project.vo.hjy.ChatBuddyVo;

public interface ChatBuddyMapperHjy {
	public int buddyInsert(ChatBuddyVo vo);
	public List<ChatBuddyVo> chatBuddyList(String cmid);
}

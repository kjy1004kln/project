package com.jhta.mybatis.mapper.kjy;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.kjy.Chat_membersVo_kjy;
import com.jhta.project.vo.kjy.Chat_messageVo_kjy;
import com.jhta.project.vo.kjy.Chat_roomjoinVo_kjy;

public interface ChatMapperkjy {
	Chat_membersVo_kjy member(String cmid);
	List<Chat_membersVo_kjy> buddy(String cmid);
	List<Chat_roomjoinVo_kjy> roomjoin(HashMap<String, Object> map);
	int cmscname(HashMap<String, Object> map);
	List<Chat_messageVo_kjy> chat_message_recently(String crid);
	HashMap<String, Object> count(String crid);
	List<Chat_roomjoinVo_kjy> roomcheck(HashMap<String, Object> map);
	int roomcheck_cnt(int crid);
	int chat_room_insert();
	int room_seq();
	int chat_roomjoin_insert(HashMap<String, Object> map);
	int chat_message_system(Chat_messageVo_kjy vo);
	int chat_message_insert(Chat_messageVo_kjy vo);
	List<Chat_messageVo_kjy> chat_message_list(int crid);
	List<String> chat_rank(String cmid);
	int delete(HashMap<String, Object> map);
	int chat_exit(HashMap<String, Object> map);
	int chat_exit_join(HashMap<String, Object> map);
	List<Chat_membersVo_kjy> chat_add_check(HashMap<String, Object> map);
	int chat_close(HashMap<String, Object> map);
	int chat_msg_notread(HashMap<String, Object> map);
}

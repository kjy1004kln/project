package com.jhta.project.service.kjy;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.kjy.ChatMapperkjy;
import com.jhta.project.vo.kjy.Chat_membersVo_kjy;
import com.jhta.project.vo.kjy.Chat_messageVo_kjy;
import com.jhta.project.vo.kjy.Chat_roomjoinVo_kjy;

@Service
public class ChatService {
	@Autowired private ChatMapperkjy mapper;
	public Chat_membersVo_kjy member(String cmid) {
		return mapper.member(cmid);
	}
	public List<Chat_membersVo_kjy> buddy(String cmid){
		return mapper.buddy(cmid);
	}
	public List<Chat_roomjoinVo_kjy> roomjoin(HashMap<String, Object> map){
		return mapper.roomjoin(map);
	}
	public int cmscname(HashMap<String, Object> map) {
		return mapper.cmscname(map);
	}
	public List<Chat_messageVo_kjy> chat_message_recently(String crid){
		return mapper.chat_message_recently(crid);
	}
	public HashMap<String, Object> count(String crid){
		return mapper.count(crid);
	}
	public List<Chat_roomjoinVo_kjy> roomcheck(HashMap<String, Object> map) {
		return mapper.roomcheck(map);
	}
	public int roomcheck_cnt(int crid) {
		return mapper.roomcheck_cnt(crid);
	}
	public int chat_room_insert() {
		return mapper.chat_room_insert();
	}
	public int room_seq() {
		return mapper.room_seq();
	}
	public int chat_roomjoin_insert(HashMap<String, Object> map) {
		return mapper.chat_roomjoin_insert(map);
	}
	public int chat_message_system(Chat_messageVo_kjy vo) {
		return mapper.chat_message_system(vo);
	}
	public int chat_message_insert(Chat_messageVo_kjy vo) {
		return mapper.chat_message_insert(vo);
	}
	public List<Chat_messageVo_kjy> chat_message_list(int crid){
		return mapper.chat_message_list(crid);
	}
	public List<String> chat_rank(String cmid){
		return mapper.chat_rank(cmid);
	}
	public int delete(HashMap<String, Object> map) {
		return mapper.delete(map);
	}
	public int chat_exit(HashMap<String, Object> map) {
		return mapper.chat_exit(map);
	}
	public int chat_exit_join(HashMap<String, Object> map) {
		return mapper.chat_exit_join(map);
	}
	public List<Chat_membersVo_kjy> chat_add_check(HashMap<String, Object> map){
		return mapper.chat_add_check(map);
	}
	public int chat_close(HashMap<String, Object> map) {
		return mapper.chat_close(map);
	}
	public int chat_msg_notread(HashMap<String, Object> map) {
		return mapper.chat_msg_notread(map);
	}
}

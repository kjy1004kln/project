package com.jhta.project.service.jhr;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.jhr.UserqnaMapper;
import com.jhta.project.vo.jhr.UserqnaVo;

@Service
public class UserqnaService {
   @Autowired UserqnaMapper mapper;
   public UserqnaVo detail(HashMap<String, String> map) {
	   return mapper.detail(map);
   }
   public List<UserqnaVo> detail2(String mid) {
	   return mapper.detail2(mid);
   }
   public int delete(UserqnaVo vo) {
	   return mapper.delete(vo);
   }
   public int update(HashMap<String, String> map) {
	   return mapper.update(map);
   }
   public List<UserqnaVo> checkId(String mid) {
	   return mapper.checkId(mid);
   }
   public List<UserqnaVo> list(HashMap<String, Object> map) {
	   return mapper.list(map);
   }
   public int getCount(HashMap<String, Object> map) {
	   return mapper.count(map);
   }
   public UserqnaVo prev(int num) {
	   return mapper.prev(num);
   }
   public UserqnaVo next(int num) {
	   return mapper.next(num);
   }
}
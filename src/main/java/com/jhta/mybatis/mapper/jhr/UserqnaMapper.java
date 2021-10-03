package com.jhta.mybatis.mapper.jhr;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.jhr.UserqnaVo;

public interface UserqnaMapper {
	UserqnaVo detail(HashMap<String,String> map);
	List<UserqnaVo> detail2(String mid);
	int delete(UserqnaVo vo);
	int update(HashMap<String, String> map);
	List<UserqnaVo> checkId(String mid);
	List<UserqnaVo> list(HashMap<String, Object> map);
	int count(HashMap<String, Object> map);
	UserqnaVo prev(int num);
	UserqnaVo next(int num);
}

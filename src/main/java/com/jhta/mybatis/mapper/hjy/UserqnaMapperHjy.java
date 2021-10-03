package com.jhta.mybatis.mapper.hjy;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.hjy.UserqnaVo;

public interface UserqnaMapperHjy {
	public List<UserqnaVo> qnalist(HashMap<String, Object> map);
	public int qnacount(HashMap<String, Object> map);
	public UserqnaVo qnaDetail(int qid);
	public UserqnaVo prev(int qid);
	public UserqnaVo next(int qid);
	public String qnaAns(int qid);
	public int qnawrite(UserqnaVo vo);
	public int getQref();
}

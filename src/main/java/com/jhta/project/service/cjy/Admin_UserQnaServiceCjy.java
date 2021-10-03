package com.jhta.project.service.cjy;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.cjy.Admin_UserQnaMapperCjy;
import com.jhta.project.vo.cjy.Admin_ManageMemVo;
import com.jhta.project.vo.cjy.UserqnaVo;

@Service
public class Admin_UserQnaServiceCjy {
	@Autowired Admin_UserQnaMapperCjy mapper;
	public List<UserqnaVo> list(){
		return mapper.list();
	}
	public int insert(UserqnaVo vo) {
		return mapper.insert(vo);
	}
	public int update(UserqnaVo vo) {
		return mapper.update(vo);
	}
	public int delete(String qid) {
		return mapper.delete(qid);
	}
	public int updatetoy(String qid) {
		return mapper.updatetoy(qid);
	}
	public UserqnaVo test(String qid){
		return mapper.test(qid);
	}
	public UserqnaVo commentList(int qref){
		return mapper.commentList(qref);
	}
	public int updateton(String qid) {
		return mapper.updateton(qid);
	}
}

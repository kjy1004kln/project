package com.jhta.project.controller.cjy;

import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jhta.project.service.cjy.Admin_UserQnaServiceCjy;
import com.jhta.project.vo.cjy.ReservationVo;
import com.jhta.project.vo.cjy.UserqnaVo;

@RestController
public class Admin_UserQnaControllerCjy {
	@Autowired Admin_UserQnaServiceCjy service;
	
	//userqna 리스트
	@RequestMapping(value="admin/cjy/userqnalist", produces = {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> userqnalist(){
		HashMap<String, Object> map = new HashMap<String,Object>();
		try {
			List<UserqnaVo> list=service.list();
			System.out.println(list);

			map.put("list", list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	//해당 qid에 대한 정보 가져오기
	@RequestMapping(value="admin/cjy/userqnaselect", produces = {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> userqnaselect(String qid){
		HashMap<String, Object> map = new HashMap<String,Object>();
		try {
			UserqnaVo vo=service.test(qid);
			map.put("list", vo);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	//qna 관리자 답변달기
	@RequestMapping(value="admin/cjy/userqnareply", produces = {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> userqnareply(String qid,String qcontent){
		HashMap<String, Object> map = new HashMap<String,Object>();
		try {
			//int qid1=Integer.parseInt(qid);
			System.out.println("qid"+qid);
			System.out.println("qcontent"+qcontent);
			UserqnaVo vo=service.test(qid);
			String qlev="Y";
			
			int qref=vo.getQref();
			int qstep=vo.getQstep();
			int qstep1=qstep+1;
			String qtitle=vo.getQtitle();
			String qtitle1="re "+qtitle;
			String mid="admin";

			UserqnaVo vo1= new UserqnaVo(qid,null,null,qtitle,qcontent,null,null,qlev,qref,qstep1,mid);
			int insert=service.insert(vo1);
			int n=service.updatetoy(qid); //원글 qlev "Y"로 처리
			map.put("code", "success");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("code", "fail");
		}
		return map;
	}
	//클릭하면 답변 보여지기
	@RequestMapping(value="admin/cjy/userqnacommentList", produces = {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> userqnacommentList(String qref){
		HashMap<String, Object> map = new HashMap<String,Object>();
		try {
			int qref1=Integer.parseInt(qref);
			UserqnaVo vo=service.commentList(qref1);
			System.out.println(vo);
			map.put("vo", vo);
			map.put("code", "success");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("code", "fail");
		}
		return map;
	}
	//qna 관리자 답변 수정하기 (관리자가 작성한 답변만 수정할 수 있음)
	@RequestMapping(value="admin/cjy/userqnaupdate", produces = {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> userqnaupdate(String qid,String qcontent){
		System.out.println("qcontent:"+qcontent);
		System.out.println("qid"+qid);
		HashMap<String, Object> map = new HashMap<String,Object>();
		UserqnaVo vo=service.test(qid);
		UserqnaVo vo2=service.commentList(vo.getQref());
		String qid1=vo2.getQid();
		String qtitle=vo.getQtitle();
		String qlev="Y";
		int qref=vo.getQref();
		int qstep=1;
		String mid="admin";
		UserqnaVo vo1= new UserqnaVo(qid1,null,null,qtitle,qcontent,null,null,qlev,qref,qstep,mid);
		try {
			int update=service.update(vo1);
			map.put("code", "success");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("code", "fail");
		}
		return map;
	}
	//qna 원글 삭제하기
	@RequestMapping(value="admin/cjy/userqnadelete", produces = {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> userqnadelete(String qid){
		HashMap<String, Object> map = new HashMap<String,Object>();
		try {
			int delete=service.delete(qid);
			map.put("code", "success");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("code", "fail");
		}
		return map;
	}
	//qna 답변 삭제하기
	@RequestMapping(value="admin/cjy/userqnadelete2", produces = {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> userqnadelete2(String qid){
		HashMap<String, Object> map = new HashMap<String,Object>();
		try {
			UserqnaVo vo=service.test(qid);
			UserqnaVo vo1=service.commentList(vo.getQref());
			String qid1=vo1.getQid();
			System.out.println("qid1:"+qid1);
			System.out.println("qid:"+qid);
			int updateton=service.updateton(qid); 
			int updateton1=service.updateton(qid1); 
			int delete=service.delete(qid1);
			map.put("code", "success");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("code", "fail");
		}
		return map;
	}
	
}

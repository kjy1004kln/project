package com.jhta.project.controller.hjy;

import java.util.HashMap;
import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jhta.project.service.hjy.CommentsServiceHjy;
import com.jhta.project.vo.hjy.CommentsVo;

@RestController
public class CommentsAjaxControllerHjy {
	@Autowired
	CommentsServiceHjy commentsService;
	
	/**
	 * commList
	 * 댓글목록 불러오기
	 * @param bid
	 * @return list
	 */
	@RequestMapping(value="hjy/commentList", produces= {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> commentList(int bid) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		try {
			Integer cnt = commentsService.commcnt(bid);
			if(cnt==null) {
				cnt=0;
			}
			List<CommentsVo> list = commentsService.list(bid);
			map.put("cnt", cnt);
			map.put("list", list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * CommentInsert
	 * 댓글등록하기
	 * @param model
	 * @param vo
	 * @param mid
	 * @return 성공,실패여부
	 */
	@RequestMapping(value="hjy/commentInsert", produces= {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> CommentInsert(HttpServletRequest req, Model model, CommentsVo vo) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		try {
			HttpSession session=req.getSession();
			String mid=(String)session.getAttribute("mid");
			System.out.println("mid:  " + mid);
			vo.setClev(0);
			vo.setCstep(0);
			vo.setMid(mid);
			commentsService.insert(vo);
			map.put("code", "success");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("code", "fail");
		}
		return map;
	}
	
	/**
	 * findComment
	 * int cid에 해당하는 글에 대한 정보(vo) 리턴
	 * @param cid
	 * @return vo
	 */
	@RequestMapping(value="hjy/findComment", produces= {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> findComment(int cid) {
		HashMap<String, Object> map = new HashMap<String,Object>();
			CommentsVo vo = commentsService.find(cid);
			map.put("vo", vo);
		try {
		}catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * updateComment
	 * 수정한 댓글 db에 update
	 * @param cid
	 * @param ccontent
	 * @return 성공,실패여부
	 */
	@RequestMapping(value="hjy/updateComment", produces= {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> updateComment(int cid,String ccontent) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("cid", cid);
		map.put("ccontent", ccontent);
		try {
			commentsService.upcateCcontent(map);
			map.put("code", "success");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("code", "fail");
		}
		return map;
	}
	
	/**
	 * updateCommentPlus
	 * 댓글의 댓글 db에 저장하기
	 * @param cid
	 * @param ccontent
	 * @return 성공,실패여부
	 */
	@RequestMapping(value="hjy/updateCommentPlus", produces= {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> updateCommentPlus(int cid,String ccontent,HttpSession session) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		try {
			CommentsVo vo = commentsService.find(cid);
			vo.setClev(vo.getClev()+1);
			vo.setCstep(vo.getCstep()+1);
			vo.setCcontent(ccontent);
			vo.setMid((String)session.getAttribute("mid"));
			commentsService.insertPlus(vo);
			map.put("cstep", vo.getCstep());
			map.put("cid", commentsService.seq());
			commentsService.update(map);
			map.put("code", "success");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("code", "fail");
		}
		return map;
	}
	
	/**
	 * 댓글 삭제하기
	 * deleteForm
	 * @param cid
	 * @return 성공,실패여부
	 */
	@RequestMapping(value="hjy/deleteForm", produces= {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> deleteForm(int cid) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		try {
			CommentsVo vo = commentsService.find(cid);
			commentsService.deleteComment(cid);
			map.put("code", "success");

		}catch(Exception e) {
			e.printStackTrace();
			map.put("code", "fail");
		}
		return map;
	}
}

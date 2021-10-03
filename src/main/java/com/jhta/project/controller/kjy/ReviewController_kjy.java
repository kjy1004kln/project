package com.jhta.project.controller.kjy;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jhta.mybatis.mapper.kjy.ReviewMapperkjy;
import com.jhta.project.util.kjy.PageUtil_kjy;
import com.jhta.project.vo.kjy.ReviewVo_kjy;

@Controller
public class ReviewController_kjy {
	@Autowired private ReviewMapperkjy service;
	@Autowired private ServletContext sc;
	
	@RequestMapping(value="/user/kjy/review1", produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> list(@RequestParam(value="pageNum",defaultValue = "1") int pageNum, String aid){
		int aid1=Integer.parseInt(aid);
		int count=service.count(aid1);
		PageUtil_kjy pu=new PageUtil_kjy(pageNum, 5, 5, count);
		HashMap<String, Object> pmap=new HashMap<String, Object>();
		pmap.put("startRowNum", pu.getStartRow());
		pmap.put("endRowNum", pu.getEndRow());
		pmap.put("aid", aid1);
		List<ReviewVo_kjy> list=service.list(pmap);
		
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("result", list);
		map.put("startPageNum", pu.getStartPageNum());
		map.put("endPageNum", pu.getEndPageNum());
		map.put("pageCount", pu.getTotalPageCount());
		map.put("pageNum", pageNum);
		return map;
	}
	
	@RequestMapping(value="/user/kjy/review2", produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> starsum(String aid){
		int aid1=Integer.parseInt(aid);
		HashMap<String, Object> map=service.sumstar(aid1);
		return map;
	}
	
	@RequestMapping(value="/user/kjy/reservationreview", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> reservationreview(HttpServletRequest req, HttpServletResponse resp,
			String rid){
		int rid1=Integer.parseInt(rid);
		HashMap<String, Object> map=new HashMap<String, Object>();
		map=service.reviewin(rid1);
		return map;
	}
	@RequestMapping(value="/user/kjy/inserttest", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody int reviewinsert(HttpServletRequest req, HttpServletResponse resp,
			ReviewVo_kjy vo, MultipartFile review_photo){
		int n=0;
		try{
			HttpSession session=req.getSession();
			String mid=(String)session.getAttribute("mid");
			vo.setReid(0);
			vo.setMid(mid);
			vo.setRerdate(null);
			//파일 업로드
			String dir=sc.getRealPath("/resources/images/review");
			String orgfilename=review_photo.getOriginalFilename();
			String savefilename=UUID.randomUUID()+"_"+orgfilename;
			InputStream is=review_photo.getInputStream();
			FileOutputStream fos=new FileOutputStream(dir+"\\"+savefilename);
			FileCopyUtils.copy(is, fos);
			is.close();
			fos.close();
			vo.setRephoto(savefilename);
			n=service.reviewinsert(vo);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return n;
	}
}

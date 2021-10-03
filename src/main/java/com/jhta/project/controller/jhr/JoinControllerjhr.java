package com.jhta.project.controller.jhr;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jhta.project.service.jhr.MembersService;
import com.jhta.project.vo.jhr.Chat_membersVo;
import com.jhta.project.vo.jhr.MembersVo;
import com.jhta.project.vo.kjy.FavoriteVo_kjy;

@Controller
public class JoinControllerjhr {
	@Autowired ServletContext sc;
	@Autowired private MembersService service;
	@GetMapping("/jhr/join")
	public String insertForm() {
		return "user/jhr/join";
	}
	@PostMapping("/jhr/join")
	//프로필사진 입력 선택사항
	public String insert(MembersVo vo, FavoriteVo_kjy vo2, Chat_membersVo vo3, MultipartFile profile, Model model) { //MROFILE->그냥 파일 저장, PROFILE->파일명만 뽑아서 저장
		//업로드 할 폴더의 절대 경로 구하기
		String path=sc.getRealPath("/resources/images/members");
		String orgfilename=profile.getOriginalFilename(); //전송된 파일명
		String savefilename=UUID.randomUUID()+"_"+orgfilename; //저장할 파일명(중복되지 않는 이름으로 만들기)
		try {
			//1. 파일업로드 하기
			if(!profile.isEmpty()){
				InputStream is=profile.getInputStream();
				FileOutputStream fos=new FileOutputStream(path+"\\"+savefilename);
				FileCopyUtils.copy(is, fos);
				is.close();
				fos.close();
				
				//2. 업로드 된 파일정보 DB에 저장하기
				File f=new File(path+"\\"+savefilename);
				vo.setMprofile(savefilename);
			}
			service.insert(vo);
			service.insert2(vo2);
			vo3.setCmid(vo.getMid());
			vo3.setCmname(vo.getMname());
			vo3.setCmbirth(vo.getMbirth());
			vo3.setCmprofile(vo.getMprofile());
			service.insert3(vo3);
			return "redirect:/jhr/login";
		} catch(Exception e) {
			e.printStackTrace();
			return "user/jhr/login";
		}
	}
	
	@RequestMapping(value="/checkId/{mid}",produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String,Object> checkId(@PathVariable("mid")String mid){
		MembersVo vo=service.checkId(mid);
		HashMap<String,Object> map=new HashMap<String, Object>();
		if(vo!=null) {
			map.put("using",true);
		}else {
			map.put("using",false);
		}
		return map;
	}
}
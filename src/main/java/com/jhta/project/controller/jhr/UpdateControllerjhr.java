package com.jhta.project.controller.jhr;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jhta.project.service.jhr.MembersService;
import com.jhta.project.vo.jhr.MembersVo;

@Controller
public class UpdateControllerjhr {
	@Autowired private MembersService service;
	@Autowired private ServletContext sc;
	@GetMapping("/jhr/mypageUpdate")
	public String updateForm(String mid,Model model) {
		return "user/jhr/mypageUpdate";
	}
	@RequestMapping(value="/mypageupdate/{mid}",produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody MembersVo checkId(@PathVariable("mid")String mid){
		MembersVo vo=service.checkId(mid);
		return vo;
	}
	
	@RequestMapping(value="/update",produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> update(MembersVo vo, MultipartFile profile, Model model) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		try {
			if(!profile.isEmpty()) { //전송된 파일이 있는 경우
				String dir=sc.getRealPath("/resources/images/members");
				String orgfilename=profile.getOriginalFilename();
				String savefilename=UUID.randomUUID()+"_" + orgfilename;
				InputStream is=profile.getInputStream();
				FileOutputStream fos=new FileOutputStream(dir +"\\" + savefilename);
				FileCopyUtils.copy(is,fos);
				is.close();
				fos.close();
				//2. 기존파일 삭제
				MembersVo m=service.find(vo.getMid());
				File f=new File(dir+"\\" + m.getMprofile());
				f.delete();
				//3. db에서 업데이트
				MembersVo vo1=new MembersVo(vo.getMid(),vo.getMpw(),vo.getMname(),vo.getMphone(),vo.getMemail(),null,vo.getMbirth(),savefilename,null);
				service.update(vo1);
			} else {
				MembersVo vo1=new MembersVo(vo.getMid(),vo.getMpw(),vo.getMname(),vo.getMphone(),vo.getMemail(),null,vo.getMbirth(),null,null);
				service.update(vo1);
			}
			//int n=service.update(vo);
			map.put("code","success");
		} catch(Exception e) {
			e.printStackTrace();
			map.put("code", "fail");
		}
		return map;
	}
}

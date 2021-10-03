package com.jhta.project.controller.cjy;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.jhta.project.service.cjy.Admin_ManageMembersServiceCjy;
import com.jhta.project.vo.cjy.Admin_ManageMemVo;
import com.jhta.util.PageUtil;

@RestController
public class Admin_ManageMembersControllerCjy {
	@Autowired Admin_ManageMembersServiceCjy memService;
	@RequestMapping(value="admin/cjy/searchmem", produces = {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> memlist(){
		HashMap<String, Object> map = new HashMap<String,Object>();
		try {
			List<Admin_ManageMemVo> list=memService.list();
			//mrdate=2021-08-20 10:46:04, mbirth=2021-08-05 00:00:00 이런 형태로 출력되어 날짜만 자르기
			for(int i=0; i<list.size() ;i++) {
				System.out.println(list.get(i).getMrdate());
				if(list.get(i).getMrdate()!=null && list.get(i).getMbirth()!=null) {
				String mrdate1=list.get(i).getMrdate().substring(0,10);
				String mbirth1=list.get(i).getMbirth().substring(0,10);
				list.get(i).setMrdate(mrdate1);
				list.get(i).setMbirth(mbirth1);
				}
			}		
			map.put("list", list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return map;
		

	}
}

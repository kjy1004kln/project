package com.jhta.project.controller.lhj;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.jhta.project.service.lhj.AccommodationsServicelhj;
import com.jhta.project.vo.lhj.AccommodationsVo;
import com.jhta.project.vo.lhj.Room_infoVo;



@RestController
public class AccommodationsControllerlhj {
	@Autowired private AccommodationsServicelhj acservice;
	@Autowired ServletContext sc;
	
	@RequestMapping(value = "admin/lhj/accommlist", produces = {MediaType.APPLICATION_JSON_VALUE}) //숙소 목록 불러오기
	public HashMap<String, Object> accommList() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<AccommodationsVo> list = acservice.accommlist();
		String aregdate1 = list.get(0).getAregdate().substring(0,10);
		for(int i=0; i<list.size() ;i++) {
			list.get(i).setAregdate(aregdate1);
		}	
		map.put("list", list);
		//System.out.println("컨트롤러: " + list);
		return map;
	}
	
	@RequestMapping(value = "admin/lhj/detail", produces = {MediaType.APPLICATION_JSON_VALUE}) //개별 숙소 목록 불러오기
	public HashMap<String, Object> detail(int aid){
		HashMap<String, Object> map = new HashMap<String, Object>();
		AccommodationsVo vo = acservice.detail(aid);
		//System.out.println("컨트롤러: " + aid);
		String aregdate1 = vo.getAregdate().substring(0,10);
		vo.setAregdate(aregdate1);
		map.put("vo", vo);
		return map;
	}
	
	@RequestMapping(value = "admin/lhj/accommUpdate", method = {RequestMethod.POST})  //숙소 정보 변경하기
	public HashMap<String, Object> accommUpdate(AccommodationsVo vo, MultipartHttpServletRequest mfRequest){
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<MultipartFile> fileList = mfRequest.getFiles("file");
		//파일이 수정되지 않았을 때
		if(fileList.get(0).getOriginalFilename()==null || fileList.get(0).getOriginalFilename()=="") {
			//System.out.println(vo);
			int n = acservice.accommUpdate(vo);
			if(n > 0) {
				map.put("msg", "숙소 정보 변경이 완료되었습니다.");
			}else {
				map.put("msg", "숙소 정보 변경에 실패했습니다.");
			}
	     } else {
	    	String path = sc.getRealPath("/resources/images/accommodations");
			String orgfilename = fileList.get(0).getOriginalFilename();// 전송된 메인 사진 파일명
			String savefilename = UUID.randomUUID() + "_" + orgfilename;// 저장할 파일명
			try {
				InputStream is = fileList.get(0).getInputStream();
				FileOutputStream fos = new FileOutputStream(path + "//" + savefilename);
				FileCopyUtils.copy(is, fos);
				is.close();
				fos.close();
				// 1. 기존 파일 삭제
				AccommodationsVo avo = acservice.detail(vo.getAid());
				File file = new File(path + "//" + avo.getAmainimg());
				if (file.exists()) {
					file.delete();
				}
				// 2. 업로드된 파일정보 DB에 저장하기
				vo.setAmainimg(savefilename);
				int n = acservice.accommUpdate(vo);
				if(n > 0) {
					map.put("msg", "숙소 정보 변경이 완료되었습니다.");
				}else {
					map.put("msg", "숙소 정보 변경에 실패했습니다.");
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}
	     }        
		return map;
	}
	
	@RequestMapping(value = "admin/lhj/roomlist", produces = {MediaType.APPLICATION_JSON_VALUE}) //객실 목록 불러오기
	public HashMap<String, Object> roomList(int aid) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<Room_infoVo> list = acservice.roomlist(aid);
		map.put("list", list);
		//System.out.println("컨트롤러: " + list);
		return map;
	}
	
	@RequestMapping(value = "admin/lhj/roomDetail", produces = {MediaType.APPLICATION_JSON_VALUE}) //개별 객실 목록 불러오기
	public HashMap<String, Object> roomDetail(int riid){
		HashMap<String, Object> map = new HashMap<String, Object>();
		Room_infoVo vo = acservice.roomDetail(riid);
		//System.out.println("컨트롤러: " + riid);
		map.put("vo", vo);
		System.out.println(vo.getAid());
		return map;
	}
	
	@RequestMapping(value = "admin/lhj/roomUpdate", method = {RequestMethod.POST}) //숙소 정보 변경하기
	public HashMap<String, Object> roomUpdate(Room_infoVo vo, MultipartHttpServletRequest mfRequest){
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<MultipartFile> fileList = mfRequest.getFiles("file");
		System.out.println("메인이미지: "+fileList.get(0).getOriginalFilename());
		System.out.println("추가이미지1: "+fileList.get(1).getOriginalFilename());
		System.out.println("추가이미지2: "+fileList.get(2).getOriginalFilename());
		String rpath = sc.getRealPath("/resources/images/room_info");
		Room_infoVo rvo = acservice.roomDetail(vo.getRiid());
		for (int i = 0; i < fileList.size(); i++) {
			//i번째 파일을 수정했을때
			if(fileList.get(i).getOriginalFilename() != "") {
			System.out.println(i+"번째 진입");
			System.out.println(fileList.get(i).getOriginalFilename());
			String rorgfilename = fileList.get(i).getOriginalFilename();// 전송된 사진 파일명
			String rsavefilename = UUID.randomUUID() + "_" + rorgfilename;// 저장할 파일명
			try {
				InputStream is = fileList.get(i).getInputStream();
				FileOutputStream fos = new FileOutputStream(rpath + "//" + rsavefilename);
				FileCopyUtils.copy(is, fos);
				is.close();
				fos.close();
				// 1. 기존 파일 삭제
				File file = null;
				if(i==0) {
					file = new File(rpath + "//" + rvo.getRimainimg());
					if (file.exists()) {
						file.delete();
					}
				// 2. 파일정보 vo에 저장하기
					vo.setRimainimg(rsavefilename);
				}else if(i==1) {
					file = new File(rpath + "//" + rvo.getRiextraimg1());
					if (file.exists()) {
						file.delete();
					}
					// 2. 파일정보 vo에 저장하기
					vo.setRiextraimg1(rsavefilename);
				}else if(i==2) {
					file = new File(rpath + "//" + rvo.getRiextraimg2());
					if (file.exists()) {
						file.delete();
					}
					// 2. 파일정보 vo에 저장하기
					vo.setRiextraimg2(rsavefilename);
				}
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}else{
				System.out.println("진입");
				if(i==0) {
					vo.setRimainimg(rvo.getRimainimg());
				}else if(i==1) {
					vo.setRiextraimg1(rvo.getRiextraimg1());
				}else if(i==2) {
					vo.setRiextraimg2(rvo.getRiextraimg2());
				}
			}
		}	
		//DB에 업데이트하기
		int n = acservice.roomUpdate(vo);
		System.out.println(vo);
		if(n > 0) {
			map.put("msg", "숙소 정보 변경이 완료되었습니다.");
		}else {
			map.put("msg", "숙소 정보 변경에 실패했습니다.");
		}
		return map;
	}
	
	// 삭제 클릭시 삭제여부 변경
	@RequestMapping(value = "admin/lhj/delUpdate", produces = {MediaType.APPLICATION_JSON_VALUE}) //숙소 정보 변경하기
	public HashMap<String, Object> delUpdate(int aid){
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		map.put("aid", aid);
		int data = acservice.delupdate(map);
		if(data > 0) {
			map2.put("data", data);
			System.out.println("컨트롤러: " + data);
			map2.put("msg", "숙소 삭제가 완료되었습니다.");
		}else {
			map2.put("msg", "숙소 삭제에 실패했습니다.");
		}
		return map2;
	}
}

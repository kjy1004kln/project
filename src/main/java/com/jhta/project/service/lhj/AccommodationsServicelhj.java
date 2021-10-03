package com.jhta.project.service.lhj;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.lhj.Admin_AccommodationsMapperlhj;
import com.jhta.project.vo.lhj.AccommodationsVo;
import com.jhta.project.vo.lhj.Room_infoVo;


@Service
public class AccommodationsServicelhj {
	@Autowired private Admin_AccommodationsMapperlhj mapper;
	
	public int count(HashMap<String, Object> map) {
		return mapper.count(map);
	}
	public List<AccommodationsVo> accommlist(){
		return mapper.accommlist();
	}
	public AccommodationsVo detail(int aid){
		return mapper.detail(aid);
	}
	public List<Room_infoVo> roomlist(int aid){
		return mapper.roomlist(aid);
	}
	public Room_infoVo roomDetail(int riid){
		return mapper.roomDetail(riid);
	}
	public int accommUpdate(AccommodationsVo vo) {
		return mapper.accommUpdate(vo);
	}
	public int roomUpdate(Room_infoVo vo) {
		return mapper.roomUpdate(vo);
	}
	public int delupdate(HashMap<String, Object> map) {
		return mapper.delupdate(map);
	}
}
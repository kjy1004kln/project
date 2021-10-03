package com.jhta.project.service.kjy;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.kjy.Room_infoMapperkjy;
import com.jhta.project.vo.kjy.Room_infoVo_kjy;

@Service
public class Room_infoService_kjy {
	@Autowired private Room_infoMapperkjy mapper;
	public List<Room_infoVo_kjy> list(HashMap<String, Object> map){
		return mapper.list(map);
	}
	public String daylist(HashMap<String, Object> map) {
		return mapper.daylist(map);
	}
	public int personnel(int riid) {
		return mapper.personnel(riid);
	}
}

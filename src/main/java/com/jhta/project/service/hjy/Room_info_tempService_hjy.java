package com.jhta.project.service.hjy;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.hjy.Room_info_tempMapperHjy;
import com.jhta.project.vo.hjy.Room_InfoVo;


@Service
public class Room_info_tempService_hjy {
	@Autowired Room_info_tempMapperHjy mapper;
	public int seq() {
		return mapper.seq();
	}
	public List<Room_InfoVo> find(int aid) {
		List<Room_InfoVo> Room_info_tempVoList = mapper.find(aid);
		return Room_info_tempVoList;
	};
	public int insert(Room_InfoVo vo) {
		return mapper.insert(vo);
	};
	public int delete(int aid) {
		return mapper.delete(aid);
	};
}

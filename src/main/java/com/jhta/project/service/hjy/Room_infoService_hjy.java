package com.jhta.project.service.hjy;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.hjy.Room_infoMapperHjy;
import com.jhta.project.vo.hjy.Room_InfoVo;


@Service
public class Room_infoService_hjy {
	@Autowired Room_infoMapperHjy mapper;
	public int seq() {
		return mapper.seq();
	}
	public int insert(Room_InfoVo vo) {
		return mapper.insert(vo);
	};
}

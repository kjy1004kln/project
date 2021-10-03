package com.jhta.project.service.hjy;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.hjy.AccommodationsMapperHjy;
import com.jhta.mybatis.mapper.hjy.Accommodations_tempMapperHjy;
import com.jhta.project.vo.hjy.AccommodationsVo;


@Service
public class AccommodationsTempServiceHjy {
	@Autowired Accommodations_tempMapperHjy mapper;
	public int seq() {
		return mapper.seq();
	}
	public AccommodationsVo find(int aid) {
		return mapper.find(aid);
	};
	public int insert(AccommodationsVo vo) {
		return mapper.insert(vo);
	}
	public int delete(int aid) {
		return mapper.delete(aid);
	};
}

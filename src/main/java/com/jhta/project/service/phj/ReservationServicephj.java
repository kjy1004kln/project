package com.jhta.project.service.phj;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.phj.ReservationMapper;
import com.jhta.project.vo.phj.ReservationVo;

@Service
public class ReservationServicephj {
	@Autowired private ReservationMapper mapper;
	
	public void setMapper(ReservationMapper mapper) {
		this.mapper=mapper;
	}
	public int insertRes(ReservationVo vo) {
		return mapper.insertRes(vo);
	}
	public ReservationVo selectRes(String mid) {
		return mapper.selectRes(mid);
	}
}

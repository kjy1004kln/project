package com.jhta.project.service.hjy;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.hjy.admin.ReservationMapperHjy;
import com.jhta.project.vo.cjy.ReservationVo;
import com.jhta.project.vo.hjy.ReservationRateVo;
@Service
public class ReservationServiceHjy {
	@Autowired ReservationMapperHjy mapper;
	public List<ReservationRateVo> hotelReserRate(String time){
		return mapper.hotelReserRate(time);
	};
	public List<ReservationRateVo> RoomReserRate(String time){
		return mapper.roomReserRate(time);
	};

}

package com.jhta.mybatis.mapper.hjy.admin;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.cjy.ReservationVo;
import com.jhta.project.vo.hjy.ReservationRateVo;

public interface ReservationMapperHjy {
	public List<ReservationRateVo> hotelReserRate(String time);
	public List<ReservationRateVo> roomReserRate(String time);
}

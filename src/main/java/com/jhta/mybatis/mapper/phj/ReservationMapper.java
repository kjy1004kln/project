package com.jhta.mybatis.mapper.phj;

import com.jhta.project.vo.phj.ReservationVo;

public interface ReservationMapper {
	int insertRes(ReservationVo vo);
	ReservationVo selectRes(String mid);
}

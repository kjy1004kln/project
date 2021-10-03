package com.jhta.mybatis.mapper.kjy;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.kjy.AccommodationsVo_kjy;
import com.jhta.project.vo.kjy.PayMentVo_kjy;
import com.jhta.project.vo.kjy.ReservationVo_kjy;

public interface ReservationMapperkjy {
	List<ReservationVo_kjy> pastlist(HashMap<String, Object> map);
	List<ReservationVo_kjy> currentlist(String mid);
	int pastcount(String mid);
	int rcancel(int rid);
	int refund(int pid);
	PayMentVo_kjy payment(int pid);
}

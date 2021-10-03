package com.jhta.project.service.kjy;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.kjy.ReservationMapperkjy;
import com.jhta.project.vo.kjy.AccommodationsVo_kjy;
import com.jhta.project.vo.kjy.PayMentVo_kjy;
import com.jhta.project.vo.kjy.ReservationVo_kjy;

@Service
public class ReservationService_kjy {
	@Autowired private ReservationMapperkjy mapper;
	public List<ReservationVo_kjy> pastlist(HashMap<String, Object> map){
		return mapper.pastlist(map);
	}
	public List<ReservationVo_kjy> currentlist(String mid){
		return mapper.currentlist(mid);
	}
	public int pastcount(String mid) {
		return mapper.pastcount(mid);
	}
	public int rcancel(int rid) {
		return mapper.rcancel(rid);
	}
	public int refund(int pid) {
		return mapper.refund(pid);
	}
	public PayMentVo_kjy payment(int pid) {
		return mapper.payment(pid);
	}
}

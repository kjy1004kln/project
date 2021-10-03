package com.jhta.project.service.phj;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.phj.PaymentMapper_phj;
import com.jhta.project.vo.phj.PaymentVo_phj;

@Service
public class PaymentService_phj {
	@Autowired private PaymentMapper_phj mapper;
	
	public void setMapper(PaymentMapper_phj mapper) {
		this.mapper=mapper;
	}
	
	public int insertPayOk(PaymentVo_phj vo) {
		return mapper.insertPayOk(vo);
	}
}

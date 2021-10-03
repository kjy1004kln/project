package com.jhta.project.service.lhj;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.lhj.Admin_PaymentMapperlhj;
import com.jhta.project.vo.lhj.PaymentVo;


@Service
public class PaymentServicelhj {
	@Autowired private Admin_PaymentMapperlhj mapper;
	
	public int count(HashMap<String, Object> map) {
		return mapper.count(map);
	}
	public List<PaymentVo> paymentlist(){
		return mapper.paymentlist();
	}
}
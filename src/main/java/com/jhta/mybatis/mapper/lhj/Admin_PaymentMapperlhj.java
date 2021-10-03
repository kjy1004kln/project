package com.jhta.mybatis.mapper.lhj;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.lhj.PaymentVo;

public interface Admin_PaymentMapperlhj {
	public int count(HashMap<String, Object> map);
	public List<PaymentVo> paymentlist();
}
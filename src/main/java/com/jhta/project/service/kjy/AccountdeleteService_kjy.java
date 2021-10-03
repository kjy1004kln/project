package com.jhta.project.service.kjy;

import org.springframework.beans.factory.annotation.Autowired;

import com.jhta.mybatis.mapper.kjy.AccountdeleteMapperkjy;

public class AccountdeleteService_kjy {
	@Autowired private AccountdeleteMapperkjy mapper;
	public String mpwcheck(String mid) {
		return mapper.mpwcheck(mid);
	}
	public int memberdel(String mid) {
		return mapper.memberdel(mid);
	}
}

package com.jhta.project.service.hjy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.hjy.admin.MembersMapperHjy;
@Service
public class MembersServiceHjy {
	@Autowired MembersMapperHjy mapper;
	public int allMembers() {
		return mapper.allMembers();
	};
	public int monthMembers() {
		return mapper.monthMembers();
	};
}

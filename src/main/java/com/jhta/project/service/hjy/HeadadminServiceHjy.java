package com.jhta.project.service.hjy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.hjy.admin.AdminMapperHjy;
import com.jhta.project.vo.hjy.HeadadminVo;

@Service
public class HeadadminServiceHjy {
	@Autowired AdminMapperHjy mapper;
	public HeadadminVo login(HeadadminVo vo) {
		return mapper.login(vo);
	}
}

package com.jhta.project.service.hjy;


import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.hjy.PeriodMapperHjy;
import com.jhta.mybatis.mapper.lhjcjy.PeriodMapperlhjcjy;
import com.jhta.project.vo.hjy.PeriodVo;

@Service
public class PeriodService_hjy {
	@Autowired PeriodMapperHjy mapper;
	public int seq() {
		return mapper.seq();
	}
	public int insert(PeriodVo vo) {
		return mapper.insert(vo);
	};
}

package com.jhta.project.service.hjy;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.hjy.Additional_feeMapperHjy;
import com.jhta.project.vo.hjy.Additional_feeVo;
@Service
public class Additional_feeService_hjy {
	@Autowired Additional_feeMapperHjy mapper;
	public int seq() {
		return mapper.seq();
	}
	public int insert(Additional_feeVo vo) {
		return mapper.insert(vo);
	};

}

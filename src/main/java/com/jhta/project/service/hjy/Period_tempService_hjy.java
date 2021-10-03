package com.jhta.project.service.hjy;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.hjy.PeriodMapperHjy;
import com.jhta.mybatis.mapper.hjy.Period_tempMapperHjy;
import com.jhta.project.vo.hjy.Additional_feeVo;
import com.jhta.project.vo.hjy.PeriodVo;

@Service
public class Period_tempService_hjy {
	@Autowired Period_tempMapperHjy mapper;
	public int seq() {
		return mapper.seq();
	}
	public List<PeriodVo> find(int aid) {
		List<PeriodVo> PeriodVoList = mapper.find(aid);
		return PeriodVoList;
	};
	public int insert(PeriodVo vo) {
		return mapper.insert(vo);
	};
	public int delete(int aid) {
		return mapper.delete(aid);
	};
}

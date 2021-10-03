package com.jhta.mybatis.mapper.hjy;

import java.util.ArrayList;
import java.util.List;

import com.jhta.project.vo.hjy.PeriodVo;

public interface Period_tempMapperHjy {
	public int seq();
	public List<PeriodVo> find(int aid);
	public int insert(PeriodVo vo);
	public int delete(int aid);
}

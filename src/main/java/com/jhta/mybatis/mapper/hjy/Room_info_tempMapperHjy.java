package com.jhta.mybatis.mapper.hjy;

import java.util.ArrayList;
import java.util.List;

import com.jhta.project.vo.hjy.Room_InfoVo;

public interface Room_info_tempMapperHjy {
	public int seq();
	public List<Room_InfoVo> find(int aid);
	public int insert(Room_InfoVo vo);
	public int delete(int aid);
}

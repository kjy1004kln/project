package com.jhta.mybatis.mapper.kjy;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.kjy.Room_infoVo_kjy;

public interface Room_infoMapperkjy {
	List<Room_infoVo_kjy> list(HashMap<String, Object> map);
	String daylist(HashMap<String, Object> map);
	int personnel(int riid);
}

package com.jhta.mybatis.mapper.kjy;

import java.util.HashMap;

import com.jhta.project.vo.kjy.MypageVo_kjy;

public interface MypageMapperkjy {
	MypageVo_kjy list(String mid);
	int profiledel(String mid);
	int profileup(HashMap<String, Object> map);
}

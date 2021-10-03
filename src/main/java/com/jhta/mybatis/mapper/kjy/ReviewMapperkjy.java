package com.jhta.mybatis.mapper.kjy;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.kjy.ReviewVo_kjy;

public interface ReviewMapperkjy {
	List<ReviewVo_kjy> list(HashMap<String, Object> map);
	HashMap<String, Object> sumstar(int aid);
	int count(int aid);
	HashMap<String, Object> reviewin(int rid);
	int reviewinsert(ReviewVo_kjy vo);
}

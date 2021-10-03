package com.jhta.mybatis.mapper.hjy;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.hjy.CommentsVo;

public interface CommentsMapperHjy {
	public List<CommentsVo> list(int bid);
	public int insert(CommentsVo vo);
	public int insertPlus(CommentsVo vo);
	public int update(HashMap<String, Object> map);
	public CommentsVo find(int cid);
	public int upcateCcontent(HashMap<String, Object> map);
	public int deleteComment(int cid);
	public int seq();
	public Integer commcnt(int bid);
}

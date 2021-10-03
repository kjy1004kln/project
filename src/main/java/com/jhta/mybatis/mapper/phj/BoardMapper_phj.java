package com.jhta.mybatis.mapper.phj;

import java.util.HashMap;
import java.util.List;

import com.jhta.project.vo.phj.BoardVo_phj;

public interface BoardMapper_phj {
	public int count_phj(HashMap<String, Object> map);
	public int count_phj_cate(HashMap<String, Object> map);
	int insertBoard(BoardVo_phj vo);
	int deleteBoard(int bid);
	int updateBoard(BoardVo_phj vo);
	List<BoardVo_phj> selectBoard(String bcate);
	List<BoardVo_phj> selectBoardAll();
	List<BoardVo_phj> selectBoardMine(HashMap<String, Object> map);
	List<BoardVo_phj> selectBoardcate(HashMap<String, Object> map);
}

package com.jhta.project.service.phj;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.mybatis.mapper.phj.BoardMapper_phj;
import com.jhta.project.vo.phj.BoardVo_phj;
@Service
public class BoardService_phj {
	@Autowired private BoardMapper_phj mapper;
	
	public void setMapper(BoardMapper_phj mapper) {
		this.mapper=mapper;
	}
	public int insertBoard(BoardVo_phj vo) {
		return mapper.insertBoard(vo);
	}
	public int deleteBoard(int bid) {
		return mapper.deleteBoard(bid);
	}
	public int updateBoard(BoardVo_phj vo) {
		return mapper.updateBoard(vo);
	}
	public List<BoardVo_phj> selectBoard(String bcate) {
		return mapper.selectBoard(bcate);
	}
	public List<BoardVo_phj> selectBoardMine(HashMap<String, Object> map) {
		return mapper.selectBoardMine(map);
	}
	public List<BoardVo_phj> selectBoardcate(HashMap<String, Object> map) {
		return mapper.selectBoardcate(map);
	}
	public int count_phj(HashMap<String, Object> map) {
		return mapper.count_phj(map);
	}
	public int count_phj_cate(HashMap<String, Object> map) {
		return mapper.count_phj_cate(map);
	}
}

package com.with.corona.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.corona.dao.BoardDAO;
import com.with.corona.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	BoardDAO boardDAO;
	
	// DAO에서 게시판 조회를 가져옴
	@Override
	public List<BoardVO> qnaSelect(){
		
		return boardDAO.qnaSelect();
	}

	@Override
	public int qnaInsert() {

		return boardDAO.qnaInsert();
	}
}

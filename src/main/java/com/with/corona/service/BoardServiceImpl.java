package com.with.corona.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.corona.dao.BoardDAO;
import com.with.corona.vo.BoardVO;
import com.with.corona.vo.PagingVO;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	BoardDAO boardDAO;
	
	// DAO에서 게시판 조회를 가져옴
	@Override
	public List<BoardVO> qnaSelect(PagingVO pagingVO){
		
		return boardDAO.qnaSelect(pagingVO);
	}
	
	// 페이징 처리 (글 전체 개수)
	@Override
	public int qnaTotal() {
		
		return boardDAO.qnaTotal();
	}
	
	// 게시판 등록
	@Override
	public int qnaInsert(BoardVO boardVO) {

		return boardDAO.qnaInsert(boardVO);
	}

	// 게시판 상세조회
	@Override
	public BoardVO qnaView(int boardId) {
		
		return boardDAO.qnaView(boardId);
	}

	// 게시판 수정
	@Override
	public int qnaUpdate(BoardVO boardVO) {
		
		return boardDAO.qnaUpdate(boardVO);
	}




}

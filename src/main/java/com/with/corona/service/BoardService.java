package com.with.corona.service;

import java.util.List;

import com.with.corona.vo.BoardVO;

public interface BoardService {

	// 게시판 조회
	List<BoardVO> qnaSelect();
	
	// 게시판 등록
	int qnaInsert(BoardVO boardVO);
	
	// 게시판 상세 조회
	BoardVO qnaView(int boardId);
}

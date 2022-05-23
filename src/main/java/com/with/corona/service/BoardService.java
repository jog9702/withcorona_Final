package com.with.corona.service;

import java.util.List;

import com.with.corona.dao.BoardDAO;
import com.with.corona.dao.BoardDAOImpl;
import com.with.corona.vo.BoardVO;
import com.with.corona.vo.PagingVO;

public interface BoardService {

	// 게시판 조회
	List<BoardVO> qnaSelect(PagingVO pagingVO);
	
	// 페이징 처리 (글 전체 개수)
	int qnaTotal();
	
	// 게시판 등록
	int qnaInsert(BoardVO boardVO);
	
	// 게시판 상세 조회
	BoardVO qnaView(int boardId);
	
	// 게시판 수정
	int qnaUpdate(BoardVO boardVO);
	
	// 게시판 삭제
	int qnaDelete(int boardId);
	
	// 게시판 답글
	int qnaReply(BoardVO boardVO);
}

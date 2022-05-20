package com.with.corona.dao;

import java.util.List;

import com.with.corona.vo.BoardVO;
import com.with.corona.vo.CommentVO;
import com.with.corona.vo.PagingVO;

public interface BoardDAO {
	
	//게시판 조회
	List<BoardVO> qnaSelect(PagingVO pagingVO);
	
	// 페이징 처리 (전체 글 개수)
	int qnaTotal();
	
	// 게시판 등록
	int qnaInsert(BoardVO boardVO);
	
	// 게시판 상세 조회
	BoardVO qnaView(int boardId);
	
	// 게시판 수정
	int qnaUpdate(BoardVO boardVO);
	
	// 게시판 삭제
	int qnaDelete();
	
	// 댓글 조회
	List<CommentVO> commentSelect();
	
	// 댓글 입력
	int commentInsert();
	
	// 댓글 수정
	int commentUpdate();
	
	// 댓글 삭제
	int commentDelete();
	
	
}

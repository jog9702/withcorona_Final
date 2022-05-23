package com.with.corona.dao;

import java.util.List;

import com.with.corona.vo.BoardVO;
import com.with.corona.vo.CommentVO;

public interface CommentDAO {
	
	// 댓글 조회
	List<CommentVO> commentSelect(int boardId);
	
	// 댓글 등록
	int CommentInsert(CommentVO commentVO);
	
	// 댓글 수정
	int CommentUpdate(CommentVO commentVO);
	
	// 댓글 삭제
	int CommentDelete(CommentVO commentVO);
}

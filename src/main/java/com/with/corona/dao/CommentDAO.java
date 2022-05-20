package com.with.corona.dao;

import java.util.List;

import com.with.corona.vo.CommentVO;

public interface CommentDAO {
	
	// 댓글 조회
	List<CommentVO> commentSelect(int boardId);
}

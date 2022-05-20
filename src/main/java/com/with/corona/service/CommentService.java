package com.with.corona.service;

import java.util.List;

import com.with.corona.vo.CommentVO;

public interface CommentService {
	
	// 댓글 조회
	List<CommentVO> commentList(int boardId);
}

package com.with.corona.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.corona.dao.CommentDAO;
import com.with.corona.vo.CommentVO;

@Service
public class CommentServiceImpl implements CommentService{
	@Autowired
	CommentDAO commentDAO;
	
	// 댓글 조회
	@Override
	public List<CommentVO> commentList(int boardId) {
		System.out.println("service boardId : " + boardId);
		return commentDAO.commentSelect(boardId);
	}

}

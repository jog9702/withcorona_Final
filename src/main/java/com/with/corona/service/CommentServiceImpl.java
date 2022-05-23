package com.with.corona.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.corona.dao.CommentDAO;
import com.with.corona.vo.BoardVO;
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
	
	// 댓글 등록
	@Override
	public int CommentInsert(CommentVO commentVO) {
		
		return commentDAO.CommentInsert(commentVO);
	}
	
	// 댓글 수정
	@Override
	public int CommentUpdate(CommentVO commentVO) {
		// TODO Auto-generated method stub
		return commentDAO.CommentUpdate(commentVO);
	}

	// 댓글 삭제
	@Override
	public int CommentDelete(CommentVO commentVO) {
		// TODO Auto-generated method stub
		return commentDAO.CommentDelete(commentVO);
	}
	

}

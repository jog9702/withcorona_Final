package com.with.corona.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.with.corona.vo.CommentVO;

@Repository
public class CommentDAOImpl implements CommentDAO{
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<CommentVO> commentSelect(int boardId) {
		List<CommentVO> commentList = sqlSession.selectList("mapper.comment.commentSelect", boardId);
		
		return commentList;
	}

}

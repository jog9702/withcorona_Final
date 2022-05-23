package com.with.corona.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.with.corona.vo.BoardVO;
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
	//댓글 등록
	@Override
	public int CommentInsert(CommentVO commentVO) {

		
		int commentInsert = sqlSession.insert("mapper.withcorona.commentinsert", commentVO);
		
		return commentInsert;
	}
	//댓글 수정
	@Override
	public int CommentUpdate(CommentVO commentVO) {

			int commentUpdate = sqlSession.update("mapper.withcorona.commentUpdate", commentVO);
			
			return commentUpdate;
	}
	//댓글 삭제
	@Override
	public int CommentDelete(CommentVO commentVO) {
		int commentDelete = sqlSession.delete("mapper.withcorona.commentDelete", commentVO);
		return commentDelete;
	}

}

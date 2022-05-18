package com.with.corona.dao;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.with.corona.vo.BoardVO;
import com.with.corona.vo.CommentVO;

@Repository
public class BoardDAOImpl implements BoardDAO{
	@Autowired
	SqlSession sqlSession;
	
	// qnaList에 게시판 조회 셀렉트리스트를 넣어줌
	@Override
	public List<BoardVO> qnaSelect() {
		List<BoardVO> qnaList = sqlSession.selectList("mapper.withcorona.qnaSelect");
		
		return qnaList;
	}

	@Override
	public int qnaInsert() {
		int qnaInsert = sqlSession.insert("mapper.withcorona.qnaInsert");
		
		return qnaInsert;
	}

	@Override
	public BoardVO qnaView() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int qnaUpdate() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int qnaDelete() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int qnaTotal() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<CommentVO> commentSelect() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int commentInsert() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int commentUpdate() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int commentDelete() {
		// TODO Auto-generated method stub
		return 0;
	}
}

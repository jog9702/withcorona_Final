package com.with.corona.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.with.corona.vo.BoardVO;
import com.with.corona.vo.CommentVO;
import com.with.corona.vo.PagingVO;

@Repository
public class BoardDAOImpl implements BoardDAO{
	@Autowired
	SqlSession sqlSession;
	
	// qnaList에 게시판 조회 셀렉트리스트를 넣음
	@Override
	public List<BoardVO> qnaSelect(PagingVO pagingVO) {
		System.out.println("111 : "+pagingVO.getStart()+","+pagingVO.getEnd());
		List<BoardVO> qnaList = sqlSession.selectList("mapper.withcorona.qnaSelect", pagingVO);
		
		return qnaList;
	}
	
	// 게시판 페이징 처리 (전체 글 개수)
	@Override
	public int qnaTotal() {
		int qnaTotal = sqlSession.selectOne("mapper.withcorona.qnaTotal");
		
		return qnaTotal;
	}
	
	// 게시판 등록
	@Override
	public int qnaInsert(BoardVO boardVO) {
		int qnaInsert = sqlSession.insert("mapper.withcorona.qnaInsert", boardVO);
		
		return qnaInsert;
	}

	// 게시판 상세 조회
	@Override
	public BoardVO qnaView(int boardId) {
		BoardVO qnaView = sqlSession.selectOne("mapper.withcorona.qnaView", boardId);
		
		return qnaView;
	}

	// 게시판 수정
	@Override
	public int qnaUpdate(BoardVO boardVO) {
		int qnaUpdate = sqlSession.update("mapper.withcorona.qnaUpdate", boardVO);
		
		return qnaUpdate;
	}

	@Override
	public int qnaDelete() {
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

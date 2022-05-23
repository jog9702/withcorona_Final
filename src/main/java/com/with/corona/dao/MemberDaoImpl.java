package com.with.corona.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.with.corona.vo.UserVO;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	SqlSession sqlSession;
	
	//Name Email 조회(id찾을 때)
	@Override
	public UserVO findId(UserVO userVO) {
		UserVO userInfo = sqlSession.selectOne("mapper.member.findByNameAndEmail", userVO);
		
		return userInfo;
	}
	
	//Id Name Email 조회 (pw 찾을 때)
	@Override
	public UserVO findPw(UserVO userVO) {
		UserVO userInfo = sqlSession.selectOne("mapper.member.findByLoginIdAndNameAndEmail", userVO);
		
		return userInfo;
	}
	
}

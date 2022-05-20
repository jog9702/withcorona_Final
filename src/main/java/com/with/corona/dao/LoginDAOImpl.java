package com.with.corona.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.with.corona.vo.UserVO;

@Repository
public class LoginDAOImpl implements LoginDAO{
	@Autowired
	SqlSession sqlSession;
	
	// 로그인할때 아이디와 비밀번호를 db와 비교
	@Override
	public UserVO login(UserVO userVO) {
		UserVO login = sqlSession.selectOne("mapper.login.login", userVO);
		
		return login;
	}
}

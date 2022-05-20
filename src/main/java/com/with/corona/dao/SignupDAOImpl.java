package com.with.corona.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.with.corona.vo.UserVO;

@Repository
public class SignupDAOImpl implements SignupDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public boolean signupCheck(String id) {
		boolean checkResult = false;
		System.out.println("signupDAO: " + id);
		List<UserVO> userVO = sqlSession.selectList("mapper.signup.signupCheck", id);
		
		if(userVO.size() > 0) {
			System.out.println("동일한 id 있음");
		} else {
			System.out.println("동일한 id 없음");
			checkResult = true;
		}
		
		return checkResult;
	}

	@Override
	public String signupSuccess(UserVO userVO) {
		
		sqlSession.insert("mapper.signup.signupSuccess", userVO);
		
		return null;
	}
	
	
	
}

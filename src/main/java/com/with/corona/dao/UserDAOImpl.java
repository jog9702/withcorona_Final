package com.with.corona.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.with.corona.vo.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public UserVO edit(UserVO userVO) {
		
		sqlSession.update("mapper.user.edit", userVO);
		
		UserVO returnUserVO = sqlSession.selectOne("mapper.user.userInfo", userVO);
		System.out.println("UserDAO: " + returnUserVO.getUserId());
		
		return returnUserVO;
	}

	@Override
	public void userDelete(String id) {
		
		System.out.println("UserDAO: " + id);
		sqlSession.delete("mapper.user.commentDelete", id);
		sqlSession.delete("mapper.user.boardDelete", id);
		sqlSession.delete("mapper.user.userDelete", id);
		System.out.println("delete success");
		
	}

	
	
}

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

	@Override
	public boolean checkPw(UserVO userVO) {
		
		System.out.println("UserDAO: " + userVO.getUserId() + ", " + userVO.getUserPassword());
		
		boolean check = false;
		
		try {
			
			UserVO result = sqlSession.selectOne("mapper.user.checkPw", userVO);
			
			if(result == null) {
				check = false;
			} else {
				check = true;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("DAO return: " + check);
		return check;
	}
	
	
}

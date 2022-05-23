package com.with.corona.dao;

import com.with.corona.vo.UserVO;

public interface LoginDAO {
	
	// 로그인 
	UserVO login(UserVO userVO);
	
	//로그인 체크
	boolean loginCheck(UserVO userVO);
	
}

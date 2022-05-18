package com.with.corona.dao;

import com.with.corona.vo.UserVO;

public interface LoginDAO {
	
	// 로그인 
	UserVO login(UserVO userVO);
	
}

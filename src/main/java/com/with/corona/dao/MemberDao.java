package com.with.corona.dao;

import com.with.corona.vo.UserVO;

public interface MemberDao {
	
	// 로그인
	UserVO findId(UserVO userVO);
	
	UserVO findPw(UserVO userVO);
}


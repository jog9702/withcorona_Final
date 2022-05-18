package com.with.corona.service;

import com.with.corona.vo.UserVO;

public interface LoginService {
	
	// 로그인 확인
	UserVO login(UserVO userVO);
	
}

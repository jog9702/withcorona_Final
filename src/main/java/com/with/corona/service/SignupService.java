package com.with.corona.service;

import java.util.List;

import com.with.corona.vo.UserVO;

public interface SignupService {

	boolean signupCheck(String id);
	
	String signupSuccess(UserVO userVO);
	
}

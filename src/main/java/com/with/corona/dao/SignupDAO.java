package com.with.corona.dao;

import java.util.List;

import com.with.corona.vo.UserVO;

public interface SignupDAO {

	boolean signupCheck(String id);
	
	String signupSuccess(UserVO userVO);
}

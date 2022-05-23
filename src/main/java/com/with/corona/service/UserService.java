package com.with.corona.service;

import java.util.List;

import com.with.corona.vo.UserVO;

public interface UserService {

	UserVO edit(UserVO userVO);
	
	void userDelete(String id);
}

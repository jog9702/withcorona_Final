package com.with.corona.dao;

import java.util.List;

import com.with.corona.vo.UserVO;

public interface UserDAO {

	public UserVO edit(UserVO userVO);
	
	void userDelete(String id);
}

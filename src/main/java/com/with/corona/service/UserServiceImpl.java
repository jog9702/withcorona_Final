package com.with.corona.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.corona.dao.UserDAO;
import com.with.corona.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;

	@Override
	public UserVO edit(UserVO userVO) {
		
		System.out.println("UserSerivce");
		UserVO returnUserVO = userDAO.edit(userVO);
		
		return returnUserVO;
	}

	@Override
	public void userDelete(String id) {
		
		userDAO.userDelete(id);
		
	}
	
}

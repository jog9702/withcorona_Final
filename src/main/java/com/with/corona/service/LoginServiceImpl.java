package com.with.corona.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.corona.dao.LoginDAO;
import com.with.corona.vo.UserVO;

@Service
public class LoginServiceImpl implements LoginService{
	@Autowired
	LoginDAO loginDAO;
	
	// 로그인 확인
	@Override
	public UserVO login(UserVO userVO) {
		return loginDAO.login(userVO);
	}

	@Override
	public boolean loginCheck(UserVO userVO) {
		
		boolean check = loginDAO.loginCheck(userVO);
		
		return check;
	}
	
	
}

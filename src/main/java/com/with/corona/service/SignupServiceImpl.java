package com.with.corona.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.corona.dao.SignupDAO;
import com.with.corona.vo.UserVO;

@Service
public class SignupServiceImpl implements SignupService {

	@Autowired
	SignupDAO signupDAO;

	@Override
	public boolean signupCheck(String id) {
		boolean checkResult = false;
		System.out.println("signupService: " + id);
		checkResult = signupDAO.signupCheck(id);
		
		return checkResult;
	}

	@Override
	public String signupSuccess(UserVO userVO) {

		signupDAO.signupSuccess(userVO);
		
		return null;
	}
	
}

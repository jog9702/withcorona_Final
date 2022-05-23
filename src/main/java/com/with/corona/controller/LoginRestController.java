package com.with.corona.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.with.corona.service.LoginService;
import com.with.corona.vo.UserVO;

@RestController
public class LoginRestController {

	@Autowired
	LoginService loginService;
	
	@RequestMapping(value="/loginCheck", method=RequestMethod.POST)
	public boolean loginResult(
			@RequestParam("userId") String userId,
			@RequestParam("userPassword") String userPw){
		
	
		UserVO userVO = new UserVO();
		userVO.setUserId(userId);
		userVO.setUserPassword(userPw);
		
		boolean check = loginService.loginCheck(userVO);
		
		return check;
		
	}
	
}

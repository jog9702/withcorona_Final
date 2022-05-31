package com.with.corona.controller;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.with.corona.service.LoginService;
import com.with.corona.service.Sha256;
import com.with.corona.vo.UserVO;

@RestController
public class LoginRestController {

	@Autowired
	LoginService loginService;
	
	@RequestMapping(value="/loginCheck", method=RequestMethod.POST)
	public boolean loginResult(
			@RequestParam("userId") String userId,
			@RequestParam("userPassword") String userPw){
		
		boolean check = false;
	
		try {
			//암호화 SHA-256
			Sha256 sha256 = new Sha256();
			String cryptogram = sha256.encrypt(userPw);
			System.out.println("암호화 결과: " + cryptogram.equals(sha256.encrypt(userPw)));
			
			UserVO userVO = new UserVO();
			userVO.setUserId(userId);
			userVO.setUserPassword(cryptogram);
			
			check = loginService.loginCheck(userVO);
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		return check;
		
	}
	
}

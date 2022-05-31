package com.with.corona.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.with.corona.service.Sha256;
import com.with.corona.service.SignupService;
import com.with.corona.vo.UserVO;

@RestController
public class SignupRestController {

	@Autowired
	SignupService signupService;
	
	@RequestMapping("/signupCheck")
	public boolean signupResult(
			@RequestParam("id") String userId,
			@RequestParam("pwd") String userPassword,
			@RequestParam("name") String userName,
			@RequestParam("gender") String userGender,
			@RequestParam("email") String userEmail,
			@RequestParam("address") String userAddress,
			HttpServletResponse response) {
		
		System.out.println("signupCtrl: " + userId + "," + userPassword + "," + userName + "," + userGender + "," + userEmail + "," + userAddress);
		
		boolean checkResult = signupService.signupCheck(userId);
		System.out.println("signupCtrl: " + checkResult);
		
		boolean result;
		if(checkResult) {

			
			UserVO userVO = new UserVO();
			try {
				
				//암호화 SHA-256
				Sha256 sha256 = new Sha256();
				String cryptogram = sha256.encrypt(userPassword);
				System.out.println("암호화 결과: " + cryptogram.equals(sha256.encrypt(userPassword)));
				
				System.out.println("checkResult: " + checkResult);
				userVO.setUserId(userId);
				userVO.setUserPassword(cryptogram);
				userVO.setUserName(userName);
				userVO.setUserGender(userGender);
				userVO.setUserEmail(userEmail);
				userVO.setUserAddress(userAddress);
				userVO.setUserAuth("0");
				
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			signupService.signupSuccess(userVO);
			System.out.println("Ctrl Result: " + checkResult);
			result = true;
		} else {
			
			System.out.println("Ctrl Result: " + checkResult);
			result = false;
		}
		
		
		return result;
	}
	
}


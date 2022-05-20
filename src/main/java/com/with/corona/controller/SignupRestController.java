package com.with.corona.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
			HttpServletResponse response) {
		
		System.out.println("signupCtrl: " + userId + "," + userPassword + "," + userName + "," + userGender + "," + userEmail);
		
		boolean checkResult = signupService.signupCheck(userId);
		System.out.println("signupCtrl: " + checkResult);
		
		boolean result;
		if(checkResult) {

			
			UserVO userVO = new UserVO();
			try {
				System.out.println("checkResult: " + checkResult);
				userVO.setUserId(userId);
				userVO.setUserPassword(userPassword);
				userVO.setUserName(userName);
				userVO.setUserGender(userGender);
				userVO.setUserEmail(userEmail);
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

package com.with.corona.controller;

import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.with.corona.service.Sha256;
import com.with.corona.service.UserService;
import com.with.corona.vo.UserVO;

@Controller
public class UserController {

	@Autowired
	UserService userService;
	
	@RequestMapping("/checkMypage")
	public String checkMypage() {
		
		return "checkMypage";
		
	}
	
	@RequestMapping("/resultMypage")
	@ResponseBody public boolean mypage(
			@RequestParam("pwd") String pwd,
			HttpSession session) {
		
		UserVO userVO = new UserVO();
		
		String id = (String) session.getAttribute("userId");
		
		//암호화 SHA-256
		try {
			Sha256 sha256 = new Sha256();
			String cryptogram;
			cryptogram = sha256.encrypt(pwd);
			System.out.println("암호화 결과: " + cryptogram.equals(sha256.encrypt(pwd)));
			
			userVO.setUserId(id);
			userVO.setUserPassword(cryptogram);
			System.out.println("UserCtrl: " + userVO.getUserId() + ", " + userVO.getUserPassword());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		boolean result = userService.checkPw(userVO);
		
		return result;
		
	}
	
	@RequestMapping("/mypage")
	public String mypage() {
		return "mypage";
		
	}
	
	@RequestMapping("/edit")
	public String edit(
			@RequestParam("id") String id,
			@RequestParam("pwd") String pwd,
			@RequestParam("name") String name,
			@RequestParam("email") String email,
			@RequestParam("gender") String gender,
			@RequestParam("address") String address,
			HttpServletRequest request) {
		
		System.out.println("UserCtrl: " + id + ", " + pwd + ", " + name + ", " + email + ", " + gender + ", " + address);
		
		UserVO userVO = new UserVO();
		
		try {
			//암호화 SHA-256
			Sha256 sha256 = new Sha256();
			String cryptogram;
			cryptogram = sha256.encrypt(pwd);
			System.out.println("암호화 결과: " + cryptogram.equals(sha256.encrypt(pwd)));
			
			userVO.setUserId(id);
			userVO.setUserPassword(cryptogram);
			userVO.setUserName(name);
			userVO.setUserEmail(email);
			userVO.setUserGender(gender);
			userVO.setUserAddress(address);
			
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		UserVO returnUserVO = userService.edit(userVO);
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		request.getSession().setAttribute("userId", returnUserVO.getUserId());
		request.getSession().setAttribute("userPassword", returnUserVO.getUserPassword());
		request.getSession().setAttribute("userName", returnUserVO.getUserName());
		request.getSession().setAttribute("userGender", returnUserVO.getUserGender());
		request.getSession().setAttribute("userEmail", returnUserVO.getUserEmail());
		request.getSession().setAttribute("userAddress", returnUserVO.getUserAddress());
		request.getSession().setAttribute("userVO", returnUserVO);
		
		return "homepage";
		
	}
	
	@RequestMapping("userDelete")
	public String userDelete(
			@RequestParam("id") String id,
			HttpServletRequest request) {
		
		System.out.println("UserCtrl: " + id);
		userService.userDelete(id);
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		return "mypage";
	}
	
}

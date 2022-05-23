package com.with.corona.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.with.corona.service.UserService;
import com.with.corona.vo.UserVO;

@Controller
public class UserController {

	@Autowired
	UserService userService;
	
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
			HttpServletRequest request) {
		
		System.out.println("UserCtrl: " + id + ", " + pwd + ", " + name + ", " + email + ", " + gender);
		
		UserVO userVO = new UserVO();
		userVO.setUserId(id);
		userVO.setUserPassword(pwd);
		userVO.setUserName(name);
		userVO.setUserEmail(email);
		userVO.setUserGender(gender);
		
		UserVO returnUserVO = userService.edit(userVO);
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		request.getSession().setAttribute("userId", returnUserVO.getUserId());
		request.getSession().setAttribute("userPassword", returnUserVO.getUserPassword());
		request.getSession().setAttribute("userName", returnUserVO.getUserName());
		request.getSession().setAttribute("userGender", returnUserVO.getUserGender());
		request.getSession().setAttribute("userEmail", returnUserVO.getUserEmail());
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

package com.with.corona.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.with.corona.service.LoginService;
import com.with.corona.vo.UserVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
	
	@Autowired
	LoginService loginService;
	
	// 로그인 페이지로 이동
	@RequestMapping("/login")
	public String loginPage() {
		
		return "login";
	}
	
	// 로그인 기능, 포스트방식으로 보내게 설정
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(
			@RequestParam("userId") String userId,
			@RequestParam("userPassword") String userPassword,
			HttpServletRequest request
			) {
		String login;
		UserVO userVO = new UserVO();
		HttpSession session = request.getSession();
		
		userVO.setUserId(userId);
		userVO.setUserPassword(userPassword);
		System.out.println(userVO.getUserId());
		System.out.println(userVO.getUserPassword());
		
		UserVO result = loginService.login(userVO);
		
		System.out.println(result.getUserId());
		System.out.println(result.getUserPassword());
		System.out.println(result.getUserAuth());
		
		if(result.getUserAuth() != null) {
			System.out.println("로그인 성공");
			request.getSession().setAttribute("userId", result.getUserId());
			request.getSession().setAttribute("userVO", result);
			System.out.println(result.getUserId());
			System.out.println(result.getUserPassword());
			System.out.println(result.getUserAuth());
			login = "redirect:/qna";
		} else {
			System.out.println("로그인 실패");
			login = "/withcorona/login";
		}

		
		return login;
	}
}

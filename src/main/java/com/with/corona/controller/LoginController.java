package com.with.corona.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.with.corona.service.LoginService;
import com.with.corona.vo.UserVO;

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
	public @ResponseBody String login(
			@RequestParam("userId") String userId,
			@RequestParam("userPassword") String userPassword,
			HttpServletRequest request
			) {
		String login;
		UserVO userVO = new UserVO();
		HttpSession session = request.getSession();
		
		userVO.setUserId(userId);
		userVO.setUserPassword(userPassword);
		
		UserVO result = loginService.login(userVO);
		
			System.out.println("로그인 성공");
			request.getSession().setAttribute("userId", result.getUserId());
			request.getSession().setAttribute("userPassword", result.getUserPassword());
			request.getSession().setAttribute("userName", result.getUserName());
			request.getSession().setAttribute("userGender", result.getUserGender());
			request.getSession().setAttribute("userEmail", result.getUserEmail());
			request.getSession().setAttribute("userVO", result);
			System.out.println("아이디 : " + result.getUserId());
			System.out.println("비밀번호 : " + result.getUserPassword());
			System.out.println("권한 : " + result.getUserAuth());

			return "SUCC";
	}
	
	// 로그아웃 세션을 삭제해서 처리
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		
		return "redirect:qna";
	}
	
}

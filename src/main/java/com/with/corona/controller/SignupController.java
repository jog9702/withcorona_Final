package com.with.corona.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.with.corona.service.SignupService;
import com.with.corona.vo.UserVO;

@Controller
public class SignupController {
	
	@Autowired
	SignupService signupService;
	
	@RequestMapping("/signup")
	public String signup() {
		
		return "signup";
	}
	
}

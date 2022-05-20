package com.with.corona.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.with.corona.service.MemberService;
import com.with.corona.vo.UserVO;



@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	//ID 찾기 페이지로 이동
	@RequestMapping("/testLoginId")
	public String showFindLoginId(){
		
		return "findLoginId";
	}
	
	//ID 결과 값
	@RequestMapping("/doFindLoginId")
	public String doFindLoginid(@RequestParam Map<String, Object> param, Model model) {
		
		System.out.println("doFindLoginId : name : "+ param.get("name"));
		UserVO resultVo = memberService.findId(param);
		
		
		
		if(resultVo != null) {
			model.addAttribute("findvo", resultVo);
			System.out.println("user_id : "+ resultVo.getUserId());
		} else {
			resultVo = new UserVO();
			resultVo.setUserId("없는 아이디");
			model.addAttribute("findvo", resultVo);
			
		}
		return "doFindLoginId";
	}
	
	//비밀번호 찾기 페이지로 이동
	@RequestMapping("/testLoginPasswd")
	public String showFindLoginPasswd(){
		return "findLoginPasswd";
	}
	
	//비밀번호 결과값
	@RequestMapping("/doFindLoginPasswd")
	public String doFindLoginPasswd(@RequestParam Map<String, Object> param, Model model) {
		UserVO resultVo = memberService.findPw(param);
		if(resultVo != null) {
			String msg = resultVo.getUserPassword()+ "입니다.";
			resultVo.setUserPassword(msg);
			model.addAttribute("findvo", resultVo);
			System.out.println("user_Pw : "+ resultVo.getUserId());
		} else {
			
			resultVo = new UserVO();
			resultVo.setUserPassword("일치하는 회원이 없습니다.");
			model.addAttribute("findvo", resultVo);
			
		}
		return "dofindLoginPasswd";
	}
	
}

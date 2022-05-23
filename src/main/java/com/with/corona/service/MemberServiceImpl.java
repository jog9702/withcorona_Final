package com.with.corona.service;

import java.lang.reflect.Member;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.corona.dao.MemberDao;
import com.with.corona.vo.UserVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDao memberDao;

	// vo에 
	@Override
	public UserVO findId(Map<String, Object> param) {
		String name = (String) param.get("name");
		String email = (String) param.get("email");
		
		System.out.println("findLoginId : name : "+ param.get("name"));
		UserVO uservo = new UserVO();
		uservo.setUserName(name);
		uservo.setUserEmail(email);
		UserVO resultVo = memberDao.findId(uservo);
		
//		if (resultVo == null) {
//			return Maps.of("resiltCode", "F-1", "msg", "일치하는 회원이 없습니다.");
//		}
//		return Maps.of("resultCode", "S-1", "msg", "당신의 로그인 아이디는 " + member.getLoginId() + " 입니다.");
		
		return resultVo;
	}

	@Override
	public UserVO findPw(Map<String, Object> param) {
		String loginId = (String) param.get("id");
		String name = (String) param.get("name");
		String email = (String) param.get("email");
		System.out.println("findLoginid : name : "+ param.get("name"));
		UserVO uservo = new UserVO();
		uservo.setUserId(loginId);
		uservo.setUserName(name);
		uservo.setUserEmail(email);
		UserVO resultVo = memberDao.findPw(uservo);
//		Member member = memberDao.findByLoginIdAndNameAndEmail(loginId, name, email);
//		
//		if (member == null) {
//			return Maps.of("resultCode", "F-1", "msg", "일치하는 회원이 없습니다.");
//		}
//		
//		String tempLoginPasswd = Math.random() * 1000 + "";
//		member.setLoginPasswd(tempLoginPasswd);
//		
//		memberDao.update(member);
//		
//		String mailTitle = name + "님, 당신의 계정(" + loginId + ")의 임시 패드워드 입니다.";
//		String mailBody = "임시 패스워드 : " + tempLoginPasswd;
//		mailService.send(email, mailTitle, mailBody);
//		
//		return Map.of("resultCode", "S-1", "msg", "입력하신 메일로 임시 패드워드가 발송되었습니다.");
		return resultVo;
	}
	
	
}

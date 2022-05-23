package com.with.corona.service;

import java.util.Map;

import com.with.corona.vo.UserVO;

public interface MemberService {

	// id 처리
	UserVO findId(Map<String, Object> param);
	// pw 처리
	UserVO findPw(Map<String, Object> param);

}

package com.with.corona.service;

import java.util.Map;

import com.with.corona.vo.UserVO;

public interface MemberService {

	UserVO findId(Map<String, Object> param);

	UserVO findPw(Map<String, Object> param);

}

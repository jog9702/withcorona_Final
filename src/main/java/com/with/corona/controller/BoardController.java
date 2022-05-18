package com.with.corona.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.with.corona.service.BoardService;
import com.with.corona.vo.BoardVO;
import com.with.corona.vo.UserVO;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	// qna 주소 입력시 서비스에서 게시판조회를 가져와 모델에 넣음
	@RequestMapping("/qna")
	public String qnaList(Model model) {
		List<BoardVO> qnaList = boardService.qnaSelect();
		model.addAttribute("qnaList", qnaList);
		
		return "qna";
	}
	
	// 게시판 등록 
	@RequestMapping("/qnaForm")
	public String qnaInsert(Model model) {
		int qnaInsert = boardService.qnaInsert();
		model.addAttribute("qnaInsert", qnaInsert);
		
		return "qna";
	}
	

	
}

package com.with.corona.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.with.corona.service.BoardService;
import com.with.corona.vo.BoardVO;
import com.with.corona.vo.CommentVO;

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
	
	// 게시판 등록 페이지로 이동
	@RequestMapping("/qnaForm")
	public String qnaFormPage() {
		
		return "qnaForm";
	}
	
	// 게시판 등록 request에 받아 boardVO에 넣고 인서트 
	@RequestMapping(value="/qnaInsert", method=RequestMethod.POST)
	public String qnaInsert(HttpServletRequest request) {
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardTitle(request.getParameter("boardTitle"));
		boardVO.setBoardDesc(request.getParameter("boardDesc"));
		boardVO.setUserId((String)request.getSession().getAttribute("userId"));
				
		int qnaInsert = boardService.qnaInsert(boardVO);
		
		System.out.println("작성 아이디 : " + request.getSession().getAttribute("userId"));
		System.out.println("작성 제목 : " + request.getSession().getAttribute("boardTitle"));
		System.out.println("작성 내용 : " + request.getSession().getAttribute("boardDesc"));
		
		return "redirect:qna";
	}
	
	// 게시판 상세 조회
	@RequestMapping("/qnaView")
	public String qnaView(
			Model model,
			HttpServletRequest request
			) {
		BoardVO	boardVO = new BoardVO();
		//CommentVO commentVo = new CommentVO();
		
		boardVO.setBoardId(Integer.parseInt(request.getParameter("boardId")));
		boardVO.setUserId((String)request.getSession().getAttribute("userId"));
		
		System.out.println(boardVO.getBoardId());
		BoardVO qnaView = boardService.qnaView(boardVO.getBoardId());
		model.addAttribute("qnaView", qnaView);
		
		return "qnaView";
	}

	
}

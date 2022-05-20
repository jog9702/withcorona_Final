package com.with.corona.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.corona.service.BoardService;
import com.with.corona.vo.BoardVO;
import com.with.corona.vo.CommentVO;
import com.with.corona.vo.PagingVO;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	// 게시판과 댓글 VO 생성
	BoardVO boardVO = new BoardVO();
	CommentVO commentVo = new CommentVO();
	
	// qna 주소 입력시 서비스에서 게시판조회를 가져와 모델에 넣음
	@RequestMapping("/qna")
	public String qnaList(
			HttpServletRequest request,
			Model model
			) {
		PagingVO pagingVO = new PagingVO();
		
		// 현재 페이지 값	
		if(request.getParameter("pageNum") != null) {
			int pageNum = Integer.parseInt(request.getParameter("pageNum"));
			pagingVO.setPageNum(pageNum);
		}
		if(request.getParameter("countPerPage") != null) {
			int countPerPage = Integer.parseInt(request.getParameter("countPerPage"));
			pagingVO.setCountPerPage(countPerPage);			
		}
		
		// 게시글 총 개수
		int total = boardService.qnaTotal();
		pagingVO.setTotal(total);
		
		// 쿼리문 1번 조건
		int start = (pagingVO.getPageNum() - 1) * pagingVO.getCountPerPage() + 1;
		pagingVO.setStart(start);
		
		// 쿼리문 2번	조건
		int end = start + pagingVO.getCountPerPage();
		pagingVO.setEnd(end);
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		
		// 총 버튼 개수	게시글 총 개수를 하나의 화면에 보여줄 글 개수로 나눈 후 올림처리
		double totalpaging = Math.ceil((double)pagingVO.getTotal() / pagingVO.getCountPerPage());
		pagingVO.setTotalPaging(totalpaging);

		// 버튼을 얼마나 보여줄지 처리
		int postion = (int)Math.ceil((double)pagingVO.getPageNum() / pagingVO.getSection());
		pagingVO.setPostion(postion);
		
		// 이전 버튼
		int prev = ((postion - 1) * pagingVO.getSection()) + 1;
		pagingVO.setPrev(prev);
		System.out.println("prev : " + prev);
		
		// 다음 버튼
		int next = pagingVO.getPrev() + pagingVO.getSection() - 1;
		pagingVO.setNext(next);
		System.out.println("next : " + next);
		
		System.out.println(">>"+ (pagingVO.getNext() > pagingVO.getTotalPaging()) +","+ pagingVO.getTotalPaging());
		
		// 다음 버튼이 마지막 글버튼일경우 안나오게 함
		if(pagingVO.getNext() > pagingVO.getTotalPaging()){
			next = (int)pagingVO.getTotalPaging();
			pagingVO.setNext(next);
		}
			
		List<BoardVO> qnaList = boardService.qnaSelect(pagingVO);
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("paging", pagingVO);
		System.out.println("qnaList.size : " + qnaList.size());
		
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
//		BoardVO boardVO = new BoardVO();
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
//		BoardVO	boardVO = new BoardVO();
//		CommentVO commentVo = new CommentVO();
		System.out.println("req : " + request.getParameter("boardId"));
		
		boardVO.setBoardId(Integer.parseInt(request.getParameter("boardId")));
		boardVO.setUserId((String)request.getSession().getAttribute("userId"));
		
		System.out.println(boardVO.getBoardId());
		BoardVO qnaView = boardService.qnaView(boardVO.getBoardId());
		model.addAttribute("qnaView", qnaView);
		
		return "qnaView";
	}
	
	// 게시판 수정 페이지로 이동
	@RequestMapping("/qnaUpdateForm")
	public String qnaUpdateFormPage(
			Model model,
			HttpServletRequest request
			) {
//		BoardVO boardVO = new BoardVO();
		boardVO.setBoardId(Integer.parseInt(request.getParameter("boardId")));
		boardVO.setUserId((String)request.getSession().getAttribute("userId"));
		
		System.out.println("boardId : " + boardVO.getBoardId());
		System.out.println("userId : " + boardVO.getUserId());
		boardVO = boardService.qnaView(boardVO.getBoardId());
		model.addAttribute("qna", boardVO);
		
		return "qnaUpdateForm";
	}
	
	// 게시판 수정
	@RequestMapping("/qnaUpdate")
	public String qnaUpdate(
			RedirectAttributes redirectAttributes,
			HttpServletRequest request
			) {
		
//		BoardVO boardVO = new BoardVO();
		boardVO.setBoardTitle(request.getParameter("boardTitle"));
		boardVO.setBoardDesc(request.getParameter("boardDesc"));
		boardVO.setUserId((String)request.getSession().getAttribute("userId"));
		boardVO.setBoardId(Integer.parseInt(request.getParameter("boardId")));
		redirectAttributes.addAttribute("boardId", boardVO.getBoardId());
				
		int qnaUpdate = boardService.qnaUpdate(boardVO);
		
		System.out.println("작성 아이디 : " + request.getSession().getAttribute("userId"));
		System.out.println("작성 제목 : " + request.getSession().getAttribute("boardTitle"));
		System.out.println("작성 내용 : " + request.getSession().getAttribute("boardDesc"));
		
		return "redirect:qnaView";
	}
	

	
}

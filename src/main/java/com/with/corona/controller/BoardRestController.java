package com.with.corona.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.with.corona.service.BoardService;
import com.with.corona.service.CommentService;
import com.with.corona.vo.BoardVO;
import com.with.corona.vo.CommentVO;
import com.with.corona.vo.PagingVO;

@RestController
public class BoardRestController {
	
	@Autowired
	BoardService boardService;
	@Autowired
	CommentService commentService;
	
	// 게시판 조회 데이터 넘기기
	@RequestMapping(value="/qnaResult")
	public Map qna(HttpServletRequest request){
		Map map = new HashMap();
		PagingVO pagingVO = new PagingVO();
		
		// 현재 페이지 값	
		if(request.getParameter("pageNum") != null) {
			int pageNum = Integer.parseInt(request.getParameter("pageNum"));
			pagingVO.setPageNum(pageNum);
			System.out.println("pageNum : " + pageNum);
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
		int end = start + pagingVO.getCountPerPage() - 1;
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
		
		System.out.println(">"+ pagingVO.getPageNum() + ", " + pagingVO.getCountPerPage());
		System.out.println(">>"+ (pagingVO.getNext() > pagingVO.getTotalPaging()) +","+ pagingVO.getTotalPaging());
		
		// 다음 버튼이 마지막 글버튼일경우 안나오게 함
		if(pagingVO.getNext() > pagingVO.getTotalPaging()){
			next = (int)pagingVO.getTotalPaging();
			pagingVO.setNext(next);
		}
		
		List<BoardVO> qna = boardService.qnaSelect(pagingVO);
		
		map.put("qna", qna);
		map.put("paging", pagingVO);
		
		System.out.println(qna);
		
		return map;
	}
	
//	@RequestMapping("qnaInsert")
//	public String qnaInsert(
//			HttpServletRequest request,
//			@RequestParam("boardTitle") String boardTitle,
//			@RequestParam("boardDesc") String boardDesc
//			) {
//		BoardVO boardVO = new BoardVO();
//		boardVO.setBoardTitle(boardTitle);
//		boardVO.setBoardDesc(boardDesc);
//		boardVO.setUserId((String)request.getSession().getAttribute("userId"));
//				
//		int qnaInsert = boardService.qnaInsert(boardVO);
//		
//		System.out.println("작성 아이디 : " + request.getSession().getAttribute("userId"));
//		System.out.println("작성 제목 : " + request.getSession().getAttribute("boardTitle"));
//		System.out.println("작성 내용 : " + request.getSession().getAttribute("boardDesc"));
//		
//		return "redirect:qna";
//	}
	
//	// 게시판 상세 조회 및 댓글 조회 데이터 넘기기
//	@RequestMapping("/qnaViewResult")
//	public Map qnaView(
//			HttpServletRequest request,
//			@RequestParam("boardId") int boardId
//			) {
//		Map map = new HashMap();
//		BoardVO	boardVO = new BoardVO();
//		CommentVO commentVO = new CommentVO();
//		System.out.println("req : " + request.getParameter("boardId"));
//		
//		boardVO.setBoardId(boardId);
//		boardVO.setUserId((String)request.getSession().getAttribute("userId"));
//		
//		System.out.println(boardVO.getBoardId());
//		BoardVO qnaView = boardService.qnaView(boardVO.getBoardId());
//		
//		commentVO.setBoardId(boardId);
//		System.out.println("commnet boardId : " + commentVO.getBoardId());
//		List<CommentVO> commentList = commentService.commentList(boardId);
//		
//		map.put("qnaView", qnaView);
//		map.put("commentList", commentList);
//		
//		return map;
//	}
	
}

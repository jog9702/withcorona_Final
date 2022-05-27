package com.with.corona.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.corona.service.BoardService;
import com.with.corona.service.CommentService;
import com.with.corona.vo.BoardVO;
import com.with.corona.vo.CommentVO;
import com.with.corona.vo.PagingVO;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	CommentService commentService;

	// qna 주소 입력시 서비스에서 게시판조회를 가져와 모델에 넣음
	@RequestMapping("/qna")
	public String qnaList() {
		
		return "qna";
	}
	
	// 게시판 등록 페이지로 이동
	@RequestMapping("/qnaForm")
	public String qnaFormPage() {
		
		return "qnaForm";
	}
	
	// 게시판 등록 request에 받아 boardVO에 넣고 인서트 
	@RequestMapping(value="/qnaInsert", method=RequestMethod.POST)
	public String qnaInsert(
			HttpServletRequest request,
			@RequestParam("boardTitle") String boardTitle,
			@RequestParam("boardDesc") String boardDesc
			) {
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardTitle(boardTitle);
		boardVO.setBoardDesc(boardDesc);
		boardVO.setUserId((String)request.getSession().getAttribute("userId"));
				
		int qnaInsert = boardService.qnaInsert(boardVO);
		
		System.out.println("작성 아이디 : " + request.getSession().getAttribute("userId"));
		System.out.println("작성 제목 : " + request.getSession().getAttribute("boardTitle"));
		System.out.println("작성 내용 : " + request.getSession().getAttribute("boardDesc"));
		
		return "redirect:qna";
	}
	
	// 게시판 상세 조회 및 댓글 조회
	@RequestMapping("/qnaView")
	public String qnaView(
			Model model,
			HttpServletRequest request,
			@RequestParam("boardId") int boardId
			) {
		BoardVO	boardVO = new BoardVO();
		CommentVO commentVO = new CommentVO();
		System.out.println("req : " + request.getParameter("boardId"));
		
		boardVO.setBoardId(boardId);
		boardVO.setUserId((String)request.getSession().getAttribute("userId"));
		
		System.out.println(boardVO.getBoardId());
		BoardVO qnaView = boardService.qnaView(boardVO.getBoardId());
		model.addAttribute("qnaView", qnaView);
		
		commentVO.setBoardId(boardId);
		System.out.println("commnet boardId : " + commentVO.getBoardId());
		List<CommentVO> commentList = commentService.commentList(boardId);
		model.addAttribute("commentList", commentList);
		
		
		return "qnaView";
	}
	
	// 게시판 수정 페이지로 이동
	@RequestMapping("/qnaUpdateForm")
	public String qnaUpdateFormPage(
			Model model,
			HttpServletRequest request,
			@RequestParam("boardId") int boardId
			) {
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardId(boardId);
		boardVO.setUserId((String)request.getSession().getAttribute("userId"));
		
		System.out.println("boardId : " + boardVO.getBoardId());
		System.out.println("userId : " + boardVO.getUserId());
		boardVO = boardService.qnaView(boardVO.getBoardId());
		model.addAttribute("qna", boardVO);
		
		return "qnaUpdateForm";
	}
	
	// 게시판 수정
	@RequestMapping(value="/qnaUpdate", method=RequestMethod.POST)
	public String qnaUpdate(
			RedirectAttributes redirectAttributes,
			HttpServletRequest request,
			@RequestParam("boardTitle") String boardTitle,
			@RequestParam("boardDesc") String boardDesc,
			@RequestParam("boardId") int boardId
			) {
		
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardTitle(boardTitle);
		boardVO.setBoardDesc(boardDesc);
		boardVO.setUserId((String)request.getSession().getAttribute("userId"));
		boardVO.setBoardId(boardId);
		redirectAttributes.addAttribute("boardId", boardVO.getBoardId());
				
		int qnaUpdate = boardService.qnaUpdate(boardVO);
		
		System.out.println("작성 아이디 : " + request.getSession().getAttribute("userId"));
		System.out.println("작성 제목 : " + request.getSession().getAttribute("boardTitle"));
		System.out.println("작성 내용 : " + request.getSession().getAttribute("boardDesc"));
		
		return "redirect:qnaView";
	}
	
	// 게시판 삭제
	@RequestMapping(value="/qnaDelete", method=RequestMethod.GET)
	public String qnaDelete(
			HttpServletRequest request,
			@RequestParam("boardId") int boardId
			) {
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardId(boardId);
		System.out.println("boadrId : " + boardVO.getBoardId());
		
		int qnaDelete = boardService.qnaDelete(boardVO.getBoardId());
		
		return "redirect:qna";
	}
	

	// 게시판 답글 등록 페이지로 이동
	@RequestMapping("/qnaReplyForm")
	public String qnaReplyFormPage(
			Model model,
			HttpServletRequest request,
			@RequestParam("boardParentno") int boardParentno
			) {
		BoardVO boardVO = new BoardVO();
		
		boardVO.setUserId((String)request.getSession().getAttribute("userId"));
		boardVO.setBoardParentno(boardParentno);
		System.out.println("해당 페이지 parentno : " + boardVO.getBoardParentno());
		model.addAttribute("qnaReply", boardVO);
		
		return "qnaReplyForm";
	}
	
	// 게시판 답글 등록
	@RequestMapping(value="/qnaReply", method=RequestMethod.POST)
	public String qnaReply(
			HttpServletRequest request,
			@RequestParam("boardTitle") String boardTitle,
			@RequestParam("boardDesc") String boardDesc,
			@RequestParam("boardParentno") int boardParentno
			) {
		BoardVO boardVO = new BoardVO();
		
		boardVO.setBoardTitle(boardTitle);
		boardVO.setBoardDesc(boardDesc);
		boardVO.setUserId((String)request.getSession().getAttribute("userId"));
		boardVO.setBoardParentno(boardParentno);
		System.out.println("boardParentno : " + boardVO.getBoardParentno());
		
		int qnaReply = boardService.qnaReply(boardVO);
		
		return "redirect:qna";
	}

	// 댓글 등록 request에 받아 CommentVO에 넣고 인서트 
		@RequestMapping("/CommentInsert")
		public String commentinsert(HttpServletRequest request,String commentDesc,Integer boardId) {
			CommentVO commentVO = new CommentVO();
			commentVO.setCommentDesc(commentDesc);
			commentVO.setBoardId(boardId);
			commentVO.setUserId((String)request.getSession().getAttribute("userId"));
			
			int commentinsert = commentService.CommentInsert(commentVO);
			
			System.out.println("작성 아이디 : " + request.getSession().getAttribute("userId"));
			System.out.println("작성 내용 : " + request.getSession().getAttribute("commentDesc"));
			
		return "redirect:qnaView?boardId="+request.getParameter("boardId");
		}
		
		// 댓글 수정
		@RequestMapping(value="/CommentUpdate", method=RequestMethod.GET)
		public String commentUpdate(
				RedirectAttributes redirectAttributes,
				HttpServletRequest request
				) {
			
			CommentVO commentVO = new CommentVO();
			commentVO.setUserId((String)request.getSession().getAttribute("userId"));
			
			commentVO.setCommentDesc(request.getParameter("commentDesc"));
			System.out.println(request.getParameter("commentDesc"));
			commentVO.setCommentId(Integer.parseInt(request.getParameter("commentId")));
			System.out.println(Integer.parseInt(request.getParameter("commentId")));
			redirectAttributes.addAttribute("commentId", commentVO.getCommentId());
					
			int commentUpdate = commentService.CommentUpdate(commentVO);
			
			return "redirect:qnaView?boardId="+request.getParameter("boardId");
		}
		// 댓글 삭제
		@RequestMapping(value="/CommentDelete", method=RequestMethod.GET)
		public String commentDelete(HttpServletRequest request) {
			CommentVO commentVO = new CommentVO();
			commentVO.setCommentId(Integer.parseInt(request.getParameter("commentId")));
			System.out.println( commentVO.getCommentId() );
			int commentDelete = commentService.CommentDelete(commentVO);
			
			return "redirect:qnaView?boardId="+request.getParameter("boardId");
		}
	
}

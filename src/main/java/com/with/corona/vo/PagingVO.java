package com.with.corona.vo;

public class PagingVO {
	
	private int total;				// 글 전체
	private int pageNum = 1;		// 현재 페이지
	private int countPerPage = 3;	// 한페이지에 보여줄 글 개수
	private int section = 2;		// 묶음
	private int postion;			// 묶음의 묶음
	private int prev;				// 이전
	private int next;				// 다음
	private int start;				// 쿼리 1
	private int end;				// 쿼리 2
	private double totalPaging;		// countPerPage에 따른 아래 버튼 개수(11개 글 10개글을 보여줄시 1,2번)
	
	
	
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getCountPerPage() {
		return countPerPage;
	}
	public void setCountPerPage(int countPerPage) {
		this.countPerPage = countPerPage;
	}
	public int getSection() {
		return section;
	}
	public void setSection(int section) {
		this.section = section;
	}
	public int getPostion() {
		return postion;
	}
	public void setPostion(int postion) {
		this.postion = postion;
	}
	public int getPrev() {
		return prev;
	}
	public void setPrev(int prev) {
		this.prev = prev;
	}
	public int getNext() {
		return next;
	}
	public void setNext(int next) {
		this.next = next;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public double getTotalPaging() {
		return totalPaging;
	}
	public void setTotalPaging(double totalPaging) {
		this.totalPaging = totalPaging;
	}
	
	
	
}

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>COVID-19 | 게시글 목록 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"
		integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
		crossorigin="anonymous"></script>
<script>
	// ajax로 게시판 띄우기 
	$(document).ready(function(){
		getQnaList();
		getPaging();
	})
	// 상세조회 링크
	function goView(){
		location.href = "${ contextPath }/qnaView?boardId=" + boardId;
	}
	// 글작성 링크
	function goInsert(){
		location.href = "${ contextPath }/qnaForm";
	}
	// 게시판 조회 데이터 ajax로 받기 
	function getQnaList(p){
		console.log("p:",p);
		if(p == undefined){
			p=1;
		}
		console.log("p:",p);
		$.ajax({
			url: "/withcorona/qnaResult",
			data: {
				pageNum:p,
				countPerPage:5
				},
			type: "GET",
			success: function(obj) {
				console.log(obj);
				getQnaListCallback(obj);
			},
			error: function(xhr, status, error){}
		});
	}
	// ajax에서 데이터를 받아 string qna에 넣어 tbody에 넣기
	function getQnaListCallback(obj) {
		let boardVO = obj.qna;
		let boardVOLength = obj.qna.length;
		
		let qna = "";
		
		if(boardVOLength > 0){
			for(let i=0; i<boardVOLength; i++){
				let level = boardVO[i].level;
				let boardId = boardVO[i].boardId;
				
				console.log(boardId);
				
				let userId = boardVO[i].userId;
				let boardTitle = boardVO[i].boardTitle;
				let boardDesc = boardVO[i].boardDesc;
				let boardTime = boardVO[i].boardTime;
				// "YYYY-MM-DDTHH:mm:ss.sssZ"의 형식에서 T를 기준으로 잘라 날짜만 가져오기
				let time = new Date(+boardTime + 3240 * 10000).toISOString().split("T")[0];
				let boardParentno = boardVO[i].boardParentno;
				
				/* <a href="${ contextPath }/qnaView?boardId=${ qna.boardId }">${ qna.boardTitle }</a> */
				
				qna += "<tr>"
				if(boardParentno == 0){
					qna += "<td>" + boardId + "</td>";					
				}else{
					qna += "<td></td>";
				}
				qna += "<td>" + userId + "</td>";
				qna += "<td>"
				if(level > 1){
					qna += "<span id='reply' style='padding-left:"+ (10*level) +"px;'>[답변]</span>";
					qna += "<a href=${contextPath}/qnaView?boardId=" + boardId + ">" + boardTitle + "</a></td>";
				}else{
					qna += "<a href=${contextPath}/qnaView?boardId=" + boardId + ">" + boardTitle + "</a></td>";				
				}
				
				// 좀 더 반복을 줄인 방법
// 				let str = "";
// 				if(level > 1){
// 					str = "<span id='reply' style='padding-left:"+ (10*level) +"px;'>[답변]</span>";
// 				}
// 				qna +=  str + boardTitle + "</td>";
				
				qna += "<td>";
				qna += time;
				qna += "</td>";
				qna += "</tr>";
			}
		}else{
			qna += "<tr>";
			qna += "<td clospan='5'>등록된 글이 없습니다.</td>";
			qna += "</tr>";
		}
		$("tbody").html(qna);
	}
	function getPaging(p){
			if(p == undefined){
				p=1;
			}
			$.ajax({
				url: "/withcorona/qnaResult",
				data: {
					pageNum:p,
					countPerPage:5
					},
			type: "GET",
			success: function(obj2) {
				console.log(obj2);
				getPagingCallback(obj2);
			},
			error: function(xhr, status, error){}
		});
	}
	function getPagingCallback(obj2) {
		let pagingVO = obj2.paging;
		let pagingVOLength = obj2.paging.length;
		
		
		let total = pagingVO.total;
		let pageNum = pagingVO.pageNum;
		let countPerPage = pagingVO.countPerPage;
		let section = pagingVO.section;
		let postion = pagingVO.postion;
		let prev = pagingVO.prev;
		let next = pagingVO.next;
		let start = pagingVO.start;
		let end = pagingVO.end;
		let totalPaging = pagingVO.totalPaging;
		
		console.log("total",total);
		console.log("pagenum",pageNum);
		console.log("countPerPage", countPerPage);
		console.log("postion", postion);
		console.log("prev", prev);
		console.log("next", next);
		console.log("start", start);
		console.log("end", end);
		console.log("totalPaging", totalPaging);
		
		let paging = "";
		
		if(prev != 1){
			//  a 태그와 ajax가 같이 실행되는 문제 해결을 위한 javascript:void(0) , href에 #을 넣어도 되지만 오류가 생길수있음
			paging += "<a href='javascript:void(0)' style='margin:10px;' onclick='getQnaList(" + (prev - 1) + "); getPaging(" + (prev - 1) + ");'>[이전]</a>";
		}
		for(let i=prev; i<=next; i++){
			if(pageNum == i){
				paging += "<a style='font-weight:bold;' href='javascript:void(0)' style='font-weight:bold; margin:10px;' onclick='getQnaList(" + i + "); getPaging(" + i + ");'>[" + i + "]</a>";
			}else{
				paging += "<a href='javascript:void(0)' style='margin:10px;' onclick='getQnaList(" + i + "); getPaging(" + i + ");'>[" + i + "]</a>";
			}
		}
		if(next != totalPaging){
			paging += "<a href='javascript:void(0)' style='margin:10px;' onclick='getQnaList(" + (next + 1) + "); getPaging(" + (next + 1) + ");'>[다음]</a>";
		}
		$(".paging").html(paging);
	}
</script>
<style>
	#logo{
		height:60px;
		margin:auto;
	}
    #main_view{
        max-width: 100%;
        width: 100%;
    }
    
    .mgt{
        margin-top: 30px;
     }
    .mglr{
        margin: 0px 30px;
    }
    .flex{
        display: flex;
        justify-content: space-around;
        width: 100%;
        margin-top: 45px;
    }
    .flex1{
        display: flex;
        justify-content: center;
        width: 100%;
        margin-top: 30px;
    }
    .fs{
    font-size: 40px;
    width: 200px;
    text-align: center;
    margin: auto;
    padding-top: 20px;
    padding-bottom: 20px;
    }
    .fs1{
        font-size: 50px;
        width: 100%;
        text-align: center;
    }
    a:link {
       text-decoration: none;
       color: black;
   }
   
   a:visited {
       text-decoration: none;
       color: black;
   }
   
   a:hover {
       text-decoration: none;
       color: blue;
   }
   
   a:active {
       text-decoration: none;
   }
   .mg{
      margin-top: 100px;
      font-size: 10px;
      width:100%;
      text-align: right;
   }
   .login{
      float: right;
   }
   .center{
   		margin: auto;
    	width: 1000px;
    	text-align:right;
    	margin-top : -102px;
    	margin-right:72px;
   }
   .bgcg{
   		background-color:rgba(225, 225, 225, 0.5);
   }

table {
  border-collapse: collapse;
  border-spacing: 0;
}
section.notice {
  padding: 80px 0;
}

.board-table {
  font-size: 13px;
  width: 100%;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}
.th-title{
	text-align:left;
}

.board-table a {
  color: #333;
  display: inline-block;
  line-height: 1.4;
  word-break: break-all;
  vertical-align: middle;
}
.board-table a:hover {
  text-decoration: underline;
}
.board-table th {
  text-align: center;
}

.board-table .th-num {
  width: 100px;
  text-align: center;
}

.board-table .th-date {
  width: 200px;
}

.board-table th, .board-table td {
  padding: 14px 0;
}

.al{
	text-align: left;
}


.board-table tbody th {
  padding-left: 28px;
  padding-right: 14px;
  border-top: 1px solid #e7e7e7;
  text-align: left;
}

.board-table tbody th p{
  display: none;
}
#board-list{
	margin-top: 100px;
}
.bold{
	font-weight:1000;
	border-bottom: 3px solid #000000;
}
tbody{
	
}
</style>
</head>
<body>
    <header>
    <div class="fixed">
        <div class="fs">
            <a href="/withcorona/covidHomepage"><img id="logo" src="resources/img/logo.png"></a>
        </div>
        <div class="login">
        	<c:if test="${ userVO.userAuth == null }">
				<a href="/withcorona/login"><input type="button" value="로그인"></a>
				<a href="/withcorona/signup"><input type="button" value="회원가입"></a>
			</c:if>
        	<c:if test="${ userVO.userAuth != null }">
				<a href="/withcorona/logout"><input type="button" value="로그아웃"></a>
				<a href="/withcorona/mypage"><input type="button" value="회원정보"></a>
			</c:if>
        </div>
        <div class="flex">
            <div><a href="/withcorona/covidKorea">국내 상세</a></div>
            <div><a href="/withcorona/covidForeign">해외 상세</a></div>
            <div><a href="/withcorona/search">가까운 검사소 찾기</a></div>
            <div><a href="/withcorona/qna" class="bold">문의/제보</a></div>
        </div>
        <hr>
    </div>
    </header>
    <section class="notice">
    <div id="board-list">
        <div class="container">
            <table class="board-table">
                <thead>
                <tr>
                    <th scope="col" class="th-num">번호</th>
                    <th scope="col" class="th-id">작성자</th>
                    <th scope="col" class="th-title">제목</th>
                    <th scope="col" class="th-date">등록일</th>
                </tr>
                </thead>
				<tbody>
			</tbody>
    	</table>
    	<br>
    	<div  class="paging" style="text-align:center">
		</div>
    </section>
    	<div class="center">
    	<a href="${ contextPath }/qnaForm">
    	<c:if test="${ userVO.userAuth != null }">
    		<button>글쓰기</button>
		</c:if>
		</a>
		</div>
	</a>
</body>
</html>
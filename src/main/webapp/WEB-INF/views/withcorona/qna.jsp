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
<style>
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

</style>
</head>
<body>
    <header>
    <div class="fixed">
        <div class="fs">
            <a href="/withcorona/covidHomepage">COVID-19</a>
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
            <div><a href="/withcorona/qna">문의/제보</a></div>
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
				<c:choose>
					<c:when test="${ empty qnaList }">
						<tr height="10">
							<td colspan="5">등록된 글이 없습니다</td>
						</tr>
					</c:when>
					<c:when test="${! empty qnaList }">
						<c:forEach var="qna" items="${ qnaList }" varStatus="qnaNum">
							<tr class="reply" align="center" data-lev="level_${ qna.level }">
								<c:if test="${qna.boardParentno == 0}">
									<td width="5%">${ qna.boardId }</td>
								</c:if>
								<c:if test="${qna.boardParentno != 0}">
									<td width="5%"></td>
								</c:if>
								<td width="10%">${ qna.userId }</td>
								<td align="left" width="35%" class="level_${ qna.level }">
									<span style="padding-right:30px"></span>
									<c:choose>
										<c:when test="${ qna.level > 1 }">
											<c:forEach begin="1" end="${ qna.level }" step="1">
												<span style="padding-right:10px"></span>
											</c:forEach>
											<span style="font-size:12px">[답변]</span>
											<a href="${ contextPath }/qnaView?boardId=${ qna.boardId }">${ qna.boardTitle }</a>
										</c:when>
										<c:otherwise>
											<a href="${ contextPath }/qnaView?boardId=${ qna.boardId }">${ qna.boardTitle }</a>
										</c:otherwise>
									</c:choose>
								</td class="al">
								<td width="10%">
									<fmt:formatDate value="${ qna.boardTime }"/>
								</td>
							</tr>
						</c:forEach>
					</c:when>
				</c:choose>
			</tbody>
    	</table>
    	<br>
    	<div style="text-align:center">
		<c:if test="${ paging.prev != 1 }">
			<a href="${ contextPath }/qna?pageNum=${ paging.prev - 1 }&countPerPage=${ paging.countPerPage }" style="margin:10px;">[이전]</a>
		</c:if>
		<c:forEach begin="${ paging.prev }" end="${ paging.next }" var="paging1">
			<c:if test="${ paging.pageNum == paging1 }">
				<a style="color:red; font-weight:bold;" href="${ contextPath }/qna?pageNum=${ paging1 }&countPerPage=${ paging.countPerPage }" style="margin:10px;">[${ paging1 }]</a>			
			</c:if>
			<c:if test="${ paging.pageNum != paging1 }">
				<a href="${ contextPath }/qna?pageNum=${ paging1 }&countPerPage=${ paging.countPerPage }" style="margin:10px;">[${ paging1 }]</a>
			</c:if>
		</c:forEach>
		<c:if test="${ paging.next != paging.totalPaging }">
			<a href="${ contextPath }/qna?pageNum=${ paging.next + 1 }&countPerPage=${ paging.countPerPage }" style="margin:10px;">[다음]</a>
		</c:if>
	</div>
    </section>
    	<div class="center">
    	<a href="${ contextPath }/qnaForm">
    	<button>
		글쓰기
		</button>
		</a>
		</div>
	</a>
</body>
</html>
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
<title>COVID-19 | 게시판 수정 페이지</title>
<style>
    #main_view{
        max-width: 100%;
        width: 100%;
    }
    
    .mgt{
        margin-top: 240px;
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
        width: 100%;
        text-align: center;
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
   section{
   	width: 500px;
    margin: auto;
    margin-top: 140px;
   }
   	.textForm {
		border-bottom: 2px solid #adadad;
		margin: 30px;
		padding: 10px 0px 10px 0px;
	}
   	.input_text {
		width: 100%;
		border:none;
		outline:none;
		color: #636e72;
		font-size:16px;
		height:25px;
		background: none;
	}
	   	.input_textbox {
		width: 100%;
		border:none;
		outline:none;
		color: #636e72;
		font-size:16px;
		height:60px;
		background: none;
	}
   	.btn {
		position:relative;
		left:30%;
		transform: translateX(-50%);
		margin-bottom: 20px;
		width:40%;
		height:40px;
		background: rgba(225, 225, 225, 0.5);
		background-position: left;
		background-size: 200%;
		font-weight: bold;
		border:none;
		cursor:pointer;
		transition: 0.4s;
		display:inline;
	}
	.t_c{
		text-align: center;
		margin-top: 130px;
	}
</style>
</head>
<body>
	<div id="main_view">
	<header>
	    <div class="fixed">
	        <div class="fs">
	            <a href="/withcorona/covidHomepage">COVID-19</a>
	        </div>
	        <div class="login">
        	<c:if test="${ userVO.userAuth == null }">
				<a href="/withcorona/login"><input type="button" value="로그인"></a>
			</c:if>
        	<c:if test="${ userVO.userAuth != null }">
				<a href="/withcorona/logout"><input type="button" value="로그아웃"></a>
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
	<section>
		<div class="t_c"><h1>글 수정</h1></div>
		<div class="textForm">작성자  ${ qna.userId }</div>
		<form name="qnaForm" method="post" action="${ contextPath }/qnaUpdate">
			<div class="textForm">
			<input  class="input_text" name="boardTitle" type="text" value="제목 : ${ qna.boardTitle }"><br> 
			</div>
			<br>
			<div class="textForm">
			<textarea class="input_textbox" name="boardDesc"rows="10" cols="65" maxlength="4000">내용 : ${ qna.boardDesc }</textarea>
			</div>
			<br><br>
			<input type="hidden" class="btn" name="boardId" value="${ qna.boardId }">
			<input type="submit" class="btn" value="수정하기">
			<input type="button" class="btn" value="취소하기" onclick="history.back(-1)">
		</form>
	</section>
	</div>
</body>
</html>
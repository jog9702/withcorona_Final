<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>COVID-19 | 찾기 페이지</title>
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
        width: 350px;
    	margin: auto;
    	text-align: center;
        margin-top: 50px;
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
   .size{
   	width: 250px;
    height: 20px;
   }
</style>
</head>
<body>
	<div id="main_view">
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
				<a href="/withcorona/checkMypage"><input type="button" value="회원정보"></a>
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
    	<div class="mgt">
    	     ${ findvo.userPassword } <br>
	    	<a href="/withcorona/covidHomepage">메인으로</a> | <a href="/withcorona/login"> 로그인 하러가기</a> |
	    	<a href="/withcorona/signUp">회원 가입</a>
    	</div>
    </section>
    </div>
</body>
</html>
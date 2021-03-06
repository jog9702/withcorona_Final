<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
		let glgl = "${glgl}";
		
		$(function(){
			bind();
			if(glgl.length != 0){
				alert(glgl);
			}
		})	
		
		function bind(){
			
			$("#tableReset").off("click").on("click", function(){
				let url = "http://localhost:8080/withcorona/reset";
				let data=null;
				
				api(url, "get", data, function(){
					alert("테이블이 초기화 되었습니다 페이지를 새로고침 해주세요");
					console.log("테이블이 초기화 되었습니다 페이지를 새로고침 해주세요");
				});
			})
		}
	
	
	
		function api(url, method, data, fnSucc, fnFail, fnComplete){
			
			let option = {
				url: url,
				type: method
			}
			
			if(data != undefined) {
				option.data = data;
			}
			if(fnSucc) {
				option.success = fnSucc;
			}
			if(fnFail) option.fail = fnFail;
			if(fnComplete) option.complete = fnComplete;
			
			$.ajax(option);
		}
		
		function getListSuccess(data){
			console.log("success", data);
// 			$("html").html(data);
		}
			
		
	</script>
<meta charset="UTF-8">
<title>COVID-19 | 메인페이지</title>
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


/* korea */
.center {
	text-align: center;
}

.mgt-30 {
	margin-top: 2%;
}

.update {
	margin-top: 1%;
}

.bgc {
	background-color: lightgray;
	width: 20px;
}

#graph {
	display: flex;
	justify-content: space-around;
	width: 700px;
	height: 300px;
	border: 1px gray solid;
	align-items: flex-end;
}

#name {
	width: 740px;
	display: flex;
	justify-content: space-around;
}

.mga {
	margin: auto;
}

.mgt--30 {
	width: 85px;
	margin-left: -10px;
	margin-top: -50px;
}
.pointer{
	height: 90px;
}
#pointerInner{
	width: 32px;
}
.hover{
	background-color: black;
}
h3{
	text-align: center
}
.bold{
	font-weight:1000;
	border-bottom: 3px solid #000000;
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
            <div class="fs1">일일 확진자수 : ${ todayCount }</div>
            <div class="flex1">
                <div class="mglr">연간 확진자수 : ${ yearCount }</div>
                <div class="mglr">월간 확진자수 : ${ monthCount }</div>
                <div class="mglr">사망자수 : ${ todayDeath }</div>
            </div>
        </div>
        
        <div class= "center update">
	        <c:if test="${ userVO.userAuth eq '1' }">
		        <button type="button" id="tableReset">테이블 초기화</button>
	        </c:if>
        </div>

        
    </section>
    </div>
</body>
</html>
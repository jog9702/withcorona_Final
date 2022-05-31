<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
   	    margin: auto;
    	width: 350px;
    	margin-top: 80px;
    }
	.fs_12{
   		font-size: 12px;
   		text-align: center;
	}
	.red{
		color: red;
	}
	.hide{
		display: none;
	}
	.text_center
	{
		text-align: center;
	}
	#delete{
		text-align: center;
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
	.btn {
		position:relative;
		left:40%;
		transform: translateX(-50%);
		margin-top: 20px;
		margin-bottom: 20px;
		width:80%;
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
	}
</style>
<script
    src="https://code.jquery.com/jquery-3.6.0.js"
    integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
    crossorigin="anonymous">
</script>
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
	    	<c:if test="${ userVO.userAuth == null }">
	    		<script>
	    			alert("로그인을 해야합니다.");
	    			location.href="/withcorona/login";
	    		</script>
	    	</c:if>
	    	<c:if test="${ userVO.userAuth != null }">
	    		<div class="mgt">
		    		<form>
				    	<div class="t_c"><h2>비밀번호를 입력하세요</h2></div>
				    	<div class="textForm">
				    		<input type="password" class="input_text" id="pwd" placeholder="비밀번호를 입력하세요.">
				    	</div>
				    	<div class="t_c"><button type="button" class="btn" id="btn_pw">확인</button></div>
			    	</form>
			    </div>
	    	</c:if>
	    </section>
	   </div>

	<script>
	
		$(function(){
			bind();
		})
	
		function bind(){
			
			$("#btn_pw").off("click").on("click", function(){
				
				let pwd = $("#pwd").val();
				
				$.ajax({
					url: "http://localhost:8080/withcorona/resultMypage",
					type: "get",
					data: {pwd : pwd},
					contentType: 'application/json; charset=UTF-8',
					success : function(data){

						let check = data;
						
						if(check){
							location.href="/withcorona/mypage";
						} else {
							alert("비밀번호가 틀립니다.");
						}
						
					},
					fail : function(data){
						console.log("fail, "+data);
					},
					complete: function(data){
						console.log("comp", data);
					}
				});
				
			});
			
		}
		
	</script>
</body>
</html>
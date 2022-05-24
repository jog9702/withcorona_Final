<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>COVID-19 | 회원정보 페이지</title>
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
    	width: 260px;
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
	    	<c:if test="${ userVO.userAuth == null }">
	    		<script>
	    			alert("로그인을 해야합니다.");
	    			location.href="/withcorona/login";
	    		</script>
	    	</c:if>
	    	<c:if test="${ userVO.userAuth != null }">
		    	<% String id = (String)session.getAttribute("userId"); %>
		    	<% String name = (String)session.getAttribute("userName"); %>
		    	<% String pw = (String)session.getAttribute("userPassword"); %>
		    	<% String email = (String)session.getAttribute("userEmail"); %>
		    	<form>
			    	<div class="t_c"><h1>회원정보수정</h1></div>
			    	<div class="red fs_12">*는 필수입니다.</div>
			    	<div class="textForm">
			    		<input type="text" class="input_text" id="id" value="<%=id%>" readonly>
			    	</div>
			    	<div class="textForm">
			    		<span class="red">*비밀번호 </span>
			    		<input type="password" class="input_text" id="pwd" value="<%=pw%>">
			    	</div>
			    	<div class="hide red fs_12">비밀번호는 필수입니다</div>
			    	<div class="textForm">
			    		<span class="red">*이름 </span>
			    		<input type="text" class="input_text" id="name" value="<%=name%>">
			    	</div>
			    	<div class="hide red fs_12">이름은 필수입니다</div>
			    	<div class="textForm">
			    		<span class="red">*이메일 </span>
			    		<input type="email" class="input_text" id="email" value="<%=email%>">
			    	</div>
			    	<div class="hide red fs_12">이메일은 필수입니다</div>
			    	<div class="t_c input_text">
			    		성별
			    		<input type="radio" id="male" class="gender" name="gender" value="male">남자
			    		<input type="radio" id="female" class="gender" name="gender" value="female">여자
			    	</div>
		    		<div class="text_center">
			    		<button type="button" class="btn" id="btn_edit">수정하기</button>
					   	<div id="delete">
					   		<button type="button" class="btn" id="btn_userDelete">탈퇴하기</button>
					   	</div>
			    	</div>
		    	</form>
	    	</c:if>
	    </section>
    </div>
    
    <script>
    	
    	$(function(){
    		init();
    		bind();
    	});
    	
    	function init(){
    		
    		let gender = '<%=(String)session.getAttribute("userGender")%>'
    		console.log(gender);
    		if(gender == "male"){
    			console.log("male");
    			$("#male").attr("checked", true);
    		} else{
    			console.log("female");
    			$("#female").attr("checked", true);
    		}
    		
    	}
    	
    	function bind(){
    		
    		$("#btn_edit").off("click").on("click", function(){
    			
    			console.log("btn_edit")
    			let id = '<%=(String)session.getAttribute("userId") %>'
				console.log(id);
    			
    			let pwd = $("#pwd").val();
    			let name = $("#name").val();
    			let gender = $(".gender:checked").val();
    			let email = $("#email").val();
    			console.log("id:", id , "pwd:", pwd , "name:", name , "gender:", gender , "email:", email);
    			
    			let data = {
						id : id,
						pwd : pwd,
						name : name,
						gender : gender,
						email : email
					}
					
				let url = "http://localhost:8080/withcorona/edit";
    			
    			$.ajax({
					url: url,
					type: "get",
					data: data,
					contentType: 'application/json; charset=UTF-8',
					success : function(data){
						console.log("ajax - mypage");
						alert("회원정보가 수정되었습니다.");
						
						location.href = "http://localhost:8080/withcorona/covidHomepage";
					},
					fail : function(data){
						console.log("fail, "+data);
					},
					complete: function(data){
						console.log("comp", data);
					}
				})
	    		
    		});
    		
    		$("#id").off("keydown").on("keydown", function(evt){
    			
    			if(evt.keyCode == 13){
    				$("#pwd").trigger("focus");
    			} else {
    				$(this).parent().parent().next().children().addClass("hide");
    			}
    		});
    		
    		$("#id").off("blur").on("blur", function(evt){

    			if( $(this).val() == "" ){
    				$(this).parent().parent().next().children().removeClass("hide");
    			}
    			
    		});
    		
			$("#pwd").off("keydown").on("keydown", function(evt){
    			
    			if(evt.keyCode == 13){
    				$("#name").trigger("focus");
    			} else {
    				$(this).parent().next().addClass("hide");
    			}
    		});
    		
    		$("#pwd").off("blur").on("blur", function(evt){

    			if( $(this).val() == "" ){
    				$(this).parent().next().removeClass("hide");
    			}
    			
    		});
    		
			$("#name").off("keydown").on("keydown", function(evt){
    			
    			if(evt.keyCode == 13){
    				$("#email").trigger("focus");
    			} else {
    				$(this).parent().next().addClass("hide");
    			}
    		});
    		
    		$("#name").off("blur").on("blur", function(evt){

    			if( $(this).val() == "" ){
    				$(this).parent().next().removeClass("hide");
    			}
    			
    		});
    		
			$("#email").off("keydown").on("keydown", function(evt){
    			
    			if(evt.keyCode == 13){
    				$(".gender").trigger("focus");
    			} else {
    				$(this).parent().next().addClass("hide");
    			}
    		});
    		
    		$("#email").off("blur").on("blur", function(evt){

    			if( $(this).val() == "" ){
    				$(this).parent().next().removeClass("hide");
    			}
    			
    		});
    		
    		$("#btn_userDelete").off("click").on("click", function(){

    			let id = '<%=(String)session.getAttribute("userId") %>'
    			let pwd = '<%=(String)session.getAttribute("userPassword") %>'
	    		console.log("pwd", pwd);
    			
	    		let checkPw = prompt('비밀번호를 입력하세요');
	    		console.log("checkPw", checkPw);
	    		
	    		if(checkPw == pwd){
	    			
	    			let checkText = prompt('탈퇴하시려면 "정말 탈퇴하겠습니다" 를 입력하세요.')
	    			
	    			if(checkText == '정말 탈퇴하겠습니다'){
	    				
	    				let url = "http://localhost:8080/withcorona/userDelete";
	    				
	    				let data = {
	    						id : id
	    				}
	    				
	    				$.ajax({
	    					url: url,
	    					type: "get",
	    					data: data,
	    					contentType: 'application/json; charset=UTF-8',
	    					success : function(data){
	    						console.log("ajax - mypage");
	    						alert("탈퇴완료");
	    						
	    						let page = "http://localhost:8080/withcorona/covidHomepage"
	    						location.replace(page);
	    					},
	    					fail : function(data){
	    						console.log("fail, "+data);
	    					},
	    					complete: function(data){
	    						console.log("comp", data);
	    					}
	    				})
	    				
	    			} else {
		    			alert("잘못 입력하셨습니다")
	    			}
	    			
	    		} else {

	    			alert("비밀번호가 틀립니다.");
	    			
	    		}
    			
    		})
    		
    	}
    
    </script>
</body>
</html>
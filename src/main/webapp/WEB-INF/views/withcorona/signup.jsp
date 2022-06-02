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
<title>COVID-19 | 회원가입 페이지</title>
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
	.text_center{
		text-align: center;
		margin-top: 20px;
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
		    	<form>
			    	<div class="t_c"><h1>회원가입</h1></div>
			    	<div class="red fs_12">*는 필수입니다.</div>
			    	<div class="textForm">
			    		<span class="red ">* </span>
			    		<input type="text" class="input_text" id="id" placeholder="아이디">
			    	</div>
			    	<div class="hide red fs_12">아이디를 꼭 입력하세요</div>
			    	<div class="textForm">
			    		<span class="red fs_12">* 비밀번호는 8~16자 영문, 숫자, 특수문자가 포함되어야 합니다. </span>
			    		<input type="password" class="input_text" id="pwd" placeholder="비밀번호">
			    	</div>
			    	<div class="hide red fs_12">유효하지 않은 비밀번호입니다.</div>
			    	<div class="textForm">
			    		<span class="red">* </span>
			    		<input type="password" class="input_text" id="pwdCheck" placeholder="비밀번호 확인">
			    	</div>
			    	<div class="hide red fs_12">비밀번호가 일치하지 않습니다.</div>
			    	<div class="textForm">
			    		<span class="red">* </span>
			    		<input type="text" class="input_text" id="name" placeholder="이름">
			    	</div>
			    	<div class="hide red fs_12">이름은 필수입니다</div>
			    	<div class="textForm">
			    		<span class="red fs_12">* 이메일 양식에 맞게 작성해 주세요.</span>
			    		<input type="email" class="input_text" id="email" placeholder="이메일">
			    	</div>
			    	<div class="hide red fs_12">이메일 양식이 맞지 않습니다.</div>
			    	<div class="textForm">
			    		<span class="red">* </span>
			    		<input type="text" class="input_text" id="addr" placeholder="주소" readonly>
			    	</div>
			    	<div class="textForm">
			    		<input type="text" class="input_text" id="addrDetail" placeholder="상세주소">
			    	</div>
			    	<div class="t_c input_text">
			    		성별
			    		<input type="radio" class="gender" name="gender" value="male" checked>남자
			    		<input type="radio" class="gender" name="gender" value="female">여자
			    	</div>
		    		<div class="text_center">
			    		<button type="button" class="btn" id="btn_signup">가입하기</button>
				    	<input type="reset" class="btn" value="다시입력">
			    	</div>
		    	</form>
	    	</div>
	    </section>
    </div>
    
    <script>
    	
    	$(function(){
    		bind();
    	});
    	
    	function bind(){
    		
    		$("#btn_signup").off("click").on("click", function(){
    			
    			
    			
    			console.log("btn_signup")
    			
    			let id = $("#id").val();
    			let pwd = $("#pwd").val();
    			let pwdCheck = $("#pwdCheck").val();
    			let name = $("#name").val();
    			let gender = $(".gender:checked").val();
    			let email = $("#email").val();
    			let addr = $("#addr").val();
    			let addrDetail = $("#addrDetail").val();
    			
    			let address = addr + " & " +addrDetail;
    			console.log(address);
    			console.log("id:", id , "pwd:", pwd , "name:", name , "gender:", gender , "email:", email , "address:", address);
    			
    			if(!id == "" && !id == "" && !pwd == "" && !pwdCheck == "" && !name == "" && !email == "" && !address == ""){
    				
	    			let data = {
							"id" : id,
							"pwd" : pwd,
							"name" : name,
							"gender" : gender,
							"email" : email,
							"address" : address
						}
						
					let url = "http://localhost:8080/withcorona/signupCheck";
	    			
	    			$.ajax({
						url: url,
						type: "get",
						data: data,
						contentType: 'application/json; charset=UTF-8',
						success : function(data){
							let result = data;
							console.log("ajax result: ", result);
							
							if(result){
								alert(id + " 님 가입을 축하드립니다.");
								let page = "http://localhost:8080/withcorona/login"
								location.replace(page);
							} else {
								alert("동일한 id가 있습니다.");
							}
						},
						fail : function(data){
							console.log("fail, "+data);
						},
						complete: function(data){
							console.log("comp", data);
						}
					})
    				
    			} else {
    				
    				alert("필수값을 입력해주세요");
    				
    			}
	    		
    		});
    		
    		$("#id").off("keydown").on("keydown", function(evt){
    			
    			if(evt.keyCode == 13){
    				$("#pwd").trigger("focus");
    			} else {
    				$(this).parent().next().addClass("hide");
    			}
    		});
    		
    		$("#id").off("blur").on("blur", function(evt){

    			if( $(this).val() == "" ){
    				$(this).parent().next().removeClass("hide");
    			}
    			
    		});
    		
			$("#pwd").off("keydown").on("keydown", function(evt){
    			
    			if(evt.keyCode == 13){
    				$("#pwdCheck").trigger("focus");
    			} /* else {
    				$(this).parent().next().addClass("hide");
    			} */
    		});
    		
    		$("#pwd").off("blur").on("blur", function(evt){

    			if( $(this).val() == "" ){
    				$(this).parent().next().removeClass("hide");
    			}
    			
    		});
    		
			$("#pwd").off("keyup").on("keyup", function(evt){

				let pwd = $("#pwd").val();
    			let pwdCheck = $("#pwdCheck").val();
    			
    			console.log("pwd keyup: ", pwd);
    			console.log("pwd keyup: ", pwdCheck);
    			
    			let regExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
    			
    			if(regExp.test(pwd)){
    				console.log("ok");
    				$(this).parent().next().addClass("hide");
    			} else {
    				console.log("no");
    				$(this).parent().next().removeClass("hide");
    			}
    			
    			
    			if(pwd == pwdCheck){
    				$(this).parent().next().next().next().addClass("hide");
    			} else {
    				$(this).parent().next().next().next().removeClass("hide");
    			}
				
    		});
    		
    		$("#pwdCheck").off("keyup").on("keyup", function(evt){
    			
    			let pwd = $("#pwd").val();
    			let pwdCheck = $("#pwdCheck").val();
				
    			console.log("ku", pwd);
    			console.log("ku", pwdCheck);
    			
    			if(pwd == pwdCheck){
    				$(this).parent().next().addClass("hide");
    			} else {
    				$(this).parent().next().removeClass("hide");
    			}
    			
    		});
    		
			$("#pwdCheck").off("keydown").on("keydown", function(evt){
    			
    			if(evt.keyCode == 13){
    				$("#name").trigger("focus");
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
    			} /* else {
    				$(this).parent().next().addClass("hide");
    			} */
    		});
			
    		$("#email").off("blur").on("blur", function(evt){

    			if( $(this).val() == "" ){
    				$(this).parent().next().removeClass("hide");
    			}
    			
    		});
    		
			$("#email").off("keyup").on("keyup", function(evt){

				let regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
				
				let email = $("#email").val();
				
				if(regExp.test(email)){
					$(this).parent().next().addClass("hide");
				} else {
					$(this).parent().next().removeClass("hide");
				}
				
    		});
    		
			$("#addr").off("click").on("click", function(){
				
				new daum.Postcode({
			        oncomplete: function(data) {
			            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
			            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
			            
			            let addr = data.address;
			            console.log(addr);
			            $("#addr").attr("value", addr);
			            $("#addrDetail").trigger("focus");
			        }
				}).open();
				
				
			});
    		
    	}
    
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>COVID-19 | 로그인 페이지</title>
<style>
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
    .flex div a{
    	font-weight: 600;
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
* {
  margin: 0px;
  padding: 0px;
  text-decoration: none;
  font-family:sans-serif;

}

body {
  background-image:#34495e;
}

.joinForm {
  position:absolute;
  width:400px;
  height:400px;
  padding: 30px, 20px;
  background-color:#FFFFFF;
  text-align:center;
  top:40%;
  left:50%;
  transform: translate(-50%,-50%);
  border-radius: 15px;
}

.joinForm h2 {
  text-align: center;
  margin: 30px;
}

.textForm {
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 0px 10px 0px;
}


.id {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.pw {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.name {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.email {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.nickname {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.cellphoneNo {
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

.btn:hover {
  background-position: right;
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
    	<div class="mgt">
	    	<form>
	    	<div class="textForm">
	    		<input class="input_text" type="text" id="userId" name="userId" placeholder="아이디" required><br>
	    	</div>
	    	<div class="textForm">
	    		<input class="input_text" type="password" id="userPassword" name="userPassword" placeholder="비밀번호" required>
	    	</div><br>
	    		<input type="button" class="btn" id="btn_login" value="로그인">
	    		<input type="reset" class="btn" value="다시입력"><br><br><br>
	    	</form>

	    	Forgot your <a href="/withcorona/member/testLoginId" style="color:blue;">ID</a> 	or
	    	<a href="/withcorona/member/testLoginPasswd" style="color:blue;">Password</a>?
	    	
	    	<input type="button" class="btn" id="" onclick="location.href='/withcorona/signup'" value="회원 가입">
	    	<br>
	    	

    	</div>
    </section>
    </div>
    
    
    <script>
	    $(function(){
			bind();
		});
	    
	    function bind(){
	    	
	    	$("#btn_login").off("click").on("click", function(){
	    		
	    		let id = $("#userId").val();
	    		let pw = $("#userPassword").val();
	    		console.log("test", userId, userPassword)
	    		
	    		let data = {
						userId : id,
						userPassword : pw
					}
					
				let url = "http://localhost:8080/withcorona/loginCheck";
    			
    			$.ajax({
					url: url,
					type: "post",
					data: data,
					contentType:"application/x-www-form-urlencoded; charset=UTF-8",
					success : function(data2){
						
						let check = data2;
						
						if(check){
							alert("로그인 성공");
							
							url = "http://localhost:8080/withcorona/login";
			    			
			    			$.ajax({
								url: url,
								type: "post",
								data: data,
								contentType:"application/x-www-form-urlencoded; charset=UTF-8",
								success : function(data){
									
									location.href = "http://localhost:8080/withcorona/covidHomepage"
									
								},
								fail : function(data){
									console.log("fail, "+data);
								},
								complete: function(data){
									console.log("comp", data);
								}
							})
							
							
						} else {
							alert("정보가 일치하지 않습니다.");
						}
						
					},
					fail : function(data){
						console.log("fail, "+data);
					},
					complete: function(data){
						console.log("comp", data);
					}
				})
	    		
	    	});
	    	
	    }
    </script>
</body>
</html>
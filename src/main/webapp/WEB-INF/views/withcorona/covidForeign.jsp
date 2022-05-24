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
	
			$("#s_btn").off("click").on("click", function(){
				let checked = $("#loc").val();
				console.log(checked);
				
				let url = "http://localhost:8080/withcorona/covidForeignDetail";
				let data = {
					loc : checked
				};
				
				api(url, "get", data, function(data){
					console.log("success", data);
					$("#content").html($("#loc").val() + "확진자수 : " + data.foreignLocalInfo +
									" 명<br>사망자수 : "+data.foreignDeath +" 명");
				});
			})
			
	        $(".hover").hover(function(){
	        	$(this).css("cursor", "pointer");
	            console.log("hover : "+$(this).attr("value"));
	            
	            let loc = $(this).attr("value");
	            console.log(loc);
				let url = "http://localhost:8080/withcorona/covidForeignDetail";
				let data = {
					loc : loc
				};
	            
				api(url, "get", data, function(data){
					console.log("success", data);
					$("#content").html(data.foreignLocalI + "<br>국가 확진자수 : " + data.foreignLocalInfo +
									" 명<br>사망자수 : "+data.foreignDeath +" 명");
				});
	            
	        },function(){
	        	$("#content").html("국가위에 마우스를 올려주세요");
	        });
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
<title>COVID-19 | 해외 확진자 상세 페이지</title>
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
        margin-top: 154px;
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
   		text-align:center;
   }
   .mgt-30{
   		margin-top:-45px;
   }
   .update{
   		margin-top:1%;
   }
   .mgt-18{
   		margin-top:18px;
   }
   .bold{
	font-weight:1000;
	border-bottom: 3px solid #000000;
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
            <div><a href="/withcorona/covidForeign" class="bold">해외 상세</a></div>
            <div><a href="/withcorona/search">가까운 검사소 찾기</a></div>
            <div><a href="/withcorona/qna">문의/제보</a></div>
        </div>
        <hr>
    </div>
    </header>
    <section>
        <div class="mgt-18">
            <div class="fs1">
            	<div class="center">
			        <img  class="parent" src="resources/img/asiamap.jpg" usemap="#ex">
			        <map name="ex">
			            <area class="hover" shape="rect" coords="252,43,286,66" target="_blank" value="몽골">
			            <area class="hover" shape="rect" coords="422,122,451,142" target="_blank" value="한국">
			            <area class="hover" shape="rect" coords="476,126,506,145" target="_blank" value="일본">
			            <area class="hover" shape="rect" coords="274,137,306,162" target="_blank" value="중국">
			            <area class="hover" shape="rect" coords="189,180,222,198" target="_blank" value="부탄">
			            <area class="hover" shape="rect" coords="140,170,177,194" target="_blank" value="네팔">
			            <area class="hover" shape="rect" coords="13,137,92,158" target="_blank" value="아프가니스탄">
			            <area class="hover" shape="rect" coords="41,179,97,202" target="_blank" value="파키스탄">
			            <area class="hover" shape="rect" coords="102,218,141,239" target="_blank" value="인도">
			            <area class="hover" shape="rect" coords="144,237,206,254" target="_blank" value="방글라데시">
			            <area class="hover" shape="rect" coords="297,220,338,238" target="_blank" value="마카오">
			            <area class="hover" shape="rect" coords="340,230,365,245" target="_blank" value="홍콩">
			            <area class="hover" shape="rect" coords="390,215,422,234" target="_blank" value="대만">
			            <area class="hover" shape="rect" coords="397,265,440,289" target="_blank" value="필리핀">
			            <area class="hover" shape="rect" coords="264,243,302,260" target="_blank" value="라오스">
			            <area class="hover" shape="rect" coords="250,267,285,284" target="_blank" value="태국">
			            <area class="hover" shape="rect" coords="312,289,349,307" target="_blank" value="베트남">
			            <area class="hover" shape="rect" coords="268,308,315,322" target="_blank" value="캄보디아">
			            <area class="hover" shape="rect" coords="141,326,194,345" target="_blank" value="스리랑카">
			            <area class="hover" shape="rect" coords="276,343,340,361" target="_blank" value="말레이시아">
			            <area class="hover" shape="rect" coords="322,405,386,424" target="_blank" value="인도네시아">
			            <area class="hover" shape="rect" coords="76,362,117,384" target="_blank" value="몰디브">
			            <area class="hover" shape="rect" coords="270,371,305,387" target="_blank" value="싱가포르">
			            <area class="hover" shape="rect" coords="214,235,253,251" target="_blank" value="미얀마">
			        </map>
    			</div>
            </div>
        </div>
        
        <div>
            <div class="mgt- select mgt-30 center">
	 	       	<div id="content">국가위에 마우스를 올려주세요</div>
            </div>

        </div>
    </section>
</body>
</html>
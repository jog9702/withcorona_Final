<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>COVID-19 | 검사소 결과 페이지</title>
<style>
    #main_view{
        max-width: 100%;
        width: 100%;
    }
    
    .mgt{
    	margin: auto;
    	width: 1000px;
    	text-align:right;
    	margin-bottom:15px;
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
   .bgcg{
   		background-color:rgba(225, 225, 225, 0.5);
   }

table {
	border: 2px solid;
	width: 1000px;
	margin : auto;
	border-radius: 10px;
}

th, td {
	border: 1px solid;
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
				<c:if test="${ vo.userAuth == null }">
					<a href="/withcorona/login"><input type="button" value="로그인"></a>
				</c:if>
				<c:if test="${ vo.userAuth != null }">
					<a href="/withcorona/logout"><input type="button" value="로그아웃"></a>
				</c:if>
			</div>
			<div class="flex">
				<div>
					<a href="/withcorona/covidKorea">국내 상세</a>
				</div>
				<div>
					<a href="/withcorona/covidForeign">해외 상세</a>
				</div>
				<div>
					<a href="/withcorona/search">가까운 검사소 찾기</a>
				</div>
				<div>
					<a href="/withcorona/qna">문의/제보</a>
				</div>
			</div>
			<hr>
		</div>
	</header>

	<section>
		<div class="mgt">
			<form action="http://localhost:8080/withcorona/selectClinic"
				method="post">
				<input type="text" placeholder="지역을 입력하세요" name="loc"> <input type="submit"
					value="조회" />
			</form>
		</div>

		<table class="table">
			<tr class="bgcg">
				<th>지역명</th>
				<th>보건소명</th>
				<th>주소</th>
				<th>전화번호</th>
			</tr>
			<c:forEach var="list" items="${ list }">
				<tr>
					<td>${ list.clinicLocal }</td>
					<td>${ list.clinicName }</td>
					<td>${ list.clinicInfo }</td>
					<td>${ list.clinicTel }</td>
				</tr>
			</c:forEach>
		</table>
	</section>

</body>
</html>
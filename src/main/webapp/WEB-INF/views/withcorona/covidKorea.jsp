<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	let glgl = "${glgl}";

	$(function() {
		bind();
		graph();
		if(glgl.length != 0){
			alert(glgl);
		}
	})

	function bind() {

		$("#s_btn")
				.off("click")
				.on(
						"click",
						function() {
							let checked = $("#loc").val();
							console.log(checked);

							let url = "http://127.0.0.1:8080/withcorona/covidKoreaDetail";
							let data = {
								loc : checked
							};

							api(url, "get", data, function(data) {
								$("#content").html(
										$("#loc").val() + "지역 확진자수 : "
												+ data.koreaLocalInfo
												+ " 명<br>사망자수 : "
												+ data.koreaDeath + " 명");
							});
						})
	}

	function graph() {

		let url = "http://127.0.0.1:8080/withcorona/graph";
		let data = {};

		api(url, "get", data, function(data) {
			let list = data.vo;
			let listDis = data.dis;
			let listHeight = data.height;
			console.log(listDis);

			for (let i = listHeight.length; i > 0; i--) {
				$("#graph").append(
						"<div class='bgc hover' data-num='" + (i - 1)
								+ "' style='height:" + (listHeight[i - 1] + 40)
								+ "% ;'><div class='mgt--30' inner-num='"
								+ (i - 1) + "'>"
								+ list[i - 1].koreaLocalInfo + "</div></div>");
				if(i-1 != 0){
					$("#graph").append("<div><div id='pointerInner'></div><div class='pointer' data-numm='"+(i-1)+"'>---></div></div>");
				}
			}
			for (let i = list.length; i > 0; i--) {
				$("#name").append("<div>" + list[i - 1].koreaTime + "</div>");
				if(i-1 != 0){
					$("#name").append("<div class='es'> </div>");
				}
			}


			let num = $(".hover").attr("data-num");

			$($(".hover").children("div")[0]).css("display", "");
			
			$(".pointer").hover(function() {

				let num = $(this).attr("data-numm") - 1;
				
				if(listDis[num] >= 0){
					$(this).prev().html(listDis[num]+"<br>증가");
					$($(this).prev()).css("color", "red");
				}else{
					let nummm = listDis[num]*-1;
					console.log("nummm"+nummm);
					$(this).prev().html(nummm+"<br>감소");
					$($(this).prev()).css("color", "blue");
				}
			}, function() {
				$(this).prev().html("");
			});
		});

	}

	function api(url, method, data, fnSucc, fnFail, fnComplete) {

		let option = {
			url : url,
			type : method
		}

		if (data != undefined) {
			option.data = data;
		}
		if (fnSucc) {
			option.success = fnSucc;
		}
		if (fnFail)
			option.fail = fnFail;
		if (fnComplete)
			option.complete = fnComplete;

		$.ajax(option);
	}

	function getListSuccess(data) {
		console.log("success", data);
		// 			$("html").html(data);
	}
</script>
<meta charset="UTF-8">
<title>COVID-19 | 국내 확진자 상세 페이지</title>
<style>
#main_view {
	max-width: 100%;
	width: 100%;
}

.mgt {
	margin-top: 50px;
}

.mglr {
	margin: 0px 30px;
}

.flex {
	display: flex;
	justify-content: space-around;
	width: 100%;
	margin-top: 45px;
}

.flex1 {
	display: flex;
	justify-content: center;
	width: 100%;
	margin-top: 30px;
}

.fs {
	font-size: 40px;
	width: 100%;
	text-align: center;
}

.fs1 {
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

.mg {
	margin-top: 100px;
	font-size: 10px;
	width: 100%;
	text-align: right;
}

.login {
	float: right;
}

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
				</c:if>
				<c:if test="${ userVO.userAuth != null }">
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
			<!-- 그래프 시작 -->
			<h3>주간 확진자 증감 추이</h3>
			<div>
				<div id="graph" class="mga">
				</div>
				<div id="name" class="mga">
				</div>
			</div>
			<!-- 그래프 끝 -->


			<%--             <div class="fs1">일일 확진자수 : ${ todayCount }</div> --%>
			<div class="flex1">
				<div class="mglr">일일 확진자수 : ${ todayCount }</div>
				<div class="mglr">연간 확진자수 : ${ yearCount }</div>
				<div class="mglr">월간 확진자수 : ${ monthCount }</div>
				<div class="mglr">사망자수 : ${ todayDeath }</div>
			</div>
		</div>

		<div>
			<div class="mgt- select center mgt-30">
				<div id="content">지역을 입력하세요</div>
			</div>

			<div class="select center">
				<select id="loc">
					<option value="서울">서울</option>
					<option value="경기">경기</option>
					<option value="강원">강원</option>
					<option value="충북">충북</option>
					<option value="충남">충남</option>
					<option value="전북">전북</option>
					<option value="전남">전남</option>
					<option value="경북">경북</option>
					<option value="경남">경남</option>
					<option value="제주">제주</option>
				</select>
				<button type="button" id="s_btn">조회</button>
			</div>

		</div>
	</section>
</body>
</html>
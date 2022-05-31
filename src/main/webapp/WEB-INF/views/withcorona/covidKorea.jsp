<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script>
	let glgl = "${glgl}";

	$(function() {
		bind();
		graph("7", "주간");
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

							let url = "http://localhost:8080/withcorona/covidKoreaDetail";
							let data = {
								loc : checked
							};

							api(url, "get", data, function(data) {
								$("#content").html(
										"<span style='color: red; font-weight: bold'>"+$("#loc").val() + "</span>지역 일일 확진자수 : <span style='color: red; font-weight: bold'>"
												+ data.koreaLocalInfo
												+ " </span>명<br>일일 사망자수 : <span style='color: red; font-weight: bold'>"
												+ data.koreaDeath + "</span> 명");
							});
						})
						
		
						
		$(".child_btn").off("click").on("click", function(){
			let dataDate = $(this).attr("data-date");
			let wm = $(this).text();
			$("#graph").html("<canvas id='mixed-chart' width='820' height='350'></canvas>")
			graph(dataDate, wm);
			console.log(wm);
		})
		$(".child_btn").hover(function(){
			$(this).css("cursor", "pointer");
		})
	}

	function graph(dataDate, wm) {

		let url = "http://localhost:8080/withcorona/graph";
		let data = {
				dataDate : dataDate
		};

		api(url, "get", data, function(data) {
			let list = data.vo;
			let listDis = data.dis;
			
			let graph_1 = [];
			let graph_2 = [];
			for(let i=list.length-1; i>-1; i--){
				graph_1.push(list[i].koreaLocalInfo);
				graph_2.push(list[i].koreaTime);
			}
			
			
			new Chart(document.getElementById("mixed-chart"), {
			    type: 'bar',
			    data: {
			      labels: graph_2,
			      datasets: [{
			          label: "일일 확진자수",
			          type: "line",
			          borderColor: "#3e95cd",
			          data: graph_1,
			          fill: false
			        }, {
			          label: "일일 확진자수",
			          type: "bar",
			          backgroundColor: "rgba(255,0,0,0.5)",
			          backgroundColorHover: "#3e95cd",
			          data: graph_1
			        }
			      ]
			    },
			    options: {
			      title: {
			        display: true,
			        text:  wm + ' 확진자 증감 추이(명)',
			      },
			      legend: {display: false},
							
			    }
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
#logo{
	height:60px;
	margin:auto;
}
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

 .fs{
 font-size: 40px;
 width: 200px;
 text-align: center;
 margin: auto;
 padding-top: 20px;
 padding-bottom: 20px;
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
	width: 870px;
	height: 380px;
	border: 1px gray solid;
	align-items: flex-end;
	margin: auto;
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
.my_btn{
	display: flex;
    justify-content: space-evenly;
    width: 250px;
    margin: auto;
    margin-bottom: 18px;
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
				<a href="/withcorona/checkMypage"><input type="button" value="회원정보"></a>
			</c:if>
        </div>
			<div class="flex">
				<div>
					<a href="/withcorona/covidKorea" class="bold">국내 상세</a>
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
			<div>
				<div class="my_btn">
					<div id="week" class="child_btn" data-date="7">주간</div>
					<div id="month" class="child_btn" data-date="30">월간</div>
					<div id="year" class="child_btn" data-date="365">연간</div>
				</div>
				<div id="graph" >
					<canvas id="mixed-chart" width="820" height="350"></canvas>
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
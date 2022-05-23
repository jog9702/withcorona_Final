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
    #main_view{
        max-width: 100%;
        width: 100%;
    }
    
    .mgt{
    	margin: 50px auto auto auto;
    	width: 1000px;
    	text-align:center;
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
    #clinicResult{
		text-align: center;
	}
	#map{
		width: 700px;
		height: 600px;
		margin: 20px 25px;
	}
	#table{
		width: 700px;
		height: 600px;
		overflow: auto;
		margin: 20px 25px;
		font-size: 15px;
		text-align: center;
	}
	.flex-container {
		display: flex;
		justify-content: center;
	}
	#initText{
		text-align: center;
		line-height: 350px;
	}
	#searchClinic{
		width: 300px;
		height: 25px;
		font-size: 18px;
		color: #4a4a4a;
	}
	#btnClinic{
		height: 30px;
	}
	.btn_color{
		background-color: #666666;
	}
</style>

<script
    src="https://code.jquery.com/jquery-3.6.0.js"
    integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
    crossorigin="anonymous">
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=94216fdceef7f8a20f232316c9cbca45&libraries=services"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
</head>
<body>

	<header>
    <div class="fixed">
        <div class="fs">
            <a href="/withcorona/covidHomepage">COVID-19</a>
        </div>
        <div class="login">
        	<c:if test="${ userVO.userAuth == null }">
				<a href="/withcorona/login"><input class="btn_color" type="button" value="로그인"></a>
				<a href="/withcorona/signup"><input type="button" value="회원가입"></a>
			</c:if>
        	<c:if test="${ userVO.userAuth != null }">
				<a href="/withcorona/logout"><input type="button" value="로그아웃"></a>
				<a href="/withcorona/mypage"><input type="button" value="회원정보"></a>
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
			<div>지역을 입력하세요(2글자 이상)</div>
			<input type="text" id="searchClinic" placeholder="ex) 천안시, 서울 등" name="loc">
			<button type=button id="btnClinic">검색</button>
	    </div>
	    <div id="clinicResult">
	    </div>
	    <div class="flex-container">
		    <div id="table" class="flex-item">
		    </div>
		   	<div id="map" class="flex-item"></div>
	    </div>
    </section>

	
	<script>
	
		$(function(){
	    	init();
	    	bind();
	    })
	    
	    
	    function bind(){
			
			$("#searchClinic").off("keydown").on("keydown", function(evt){
				
				if(evt.keyCode == 13){
					$("#btnClinic").click();
				}
				
			});
			
			
	    	$("#btnClinic").off("click").on("click", function(){
	
	    		let tt = $("#searchClinic").val();
	    		console.log("tt: ", tt);
	    		console.log("tt.length: ", tt.length);
				if(tt.length < 2){
					
					alert("2글자 이상만 검색 가능합니다.");
					
				} else {
					
					let searchClinic = $("#searchClinic").val();
		    		console.log("clinic.jsp: ",searchClinic);
		    		
		    		$("#clinicResult").html("<div>'"+searchClinic+"' 검색 결과 입니다.</div>");
		    		
		    		let data1 = {
							"searchClinic" : searchClinic,
							"action" : "clinic"
						}
						
					let url = "http://localhost:8080/withcorona/result";
						
					$.ajax({
						"url": url,
						type: "get",
						"data": data1,
						contentType: 'application/json; charset=UTF-8',
						success : function(data){
							let obj = JSON.parse(data);
							console.log("ajax", obj[0].clinicName);
							if(obj.length != 0){
		
								$("#table").html("");
								
								let html = "";
								
								html += "<table>";
								html += "<thead>";
								html += "	<tr>";
								html += "		<th style='width:140px'>보건소</th>";
								html += "		<th style='width:400px'>주소</th>";
								html += "		<th style='width:125px'>번호</th>";
								html += "		<th style='width:44px'>지도</th>";
								html += "	</tr>";
								html += "</thead>";
								
								for(let i=0; i<obj.length; i++){
									
									html += "<tbody>";
									html += "	<tr>";
									html += "		<td>"+obj[i].clinicName+"</td>";
									html += "		<td>"+obj[i].clinicInfo+"</td>";
									html += "		<td>"+obj[i].clinicTel+"</td>";
									html += "		<td><button type='button' id='clinicMap"+[i]+"' class='clinicMap' value='"+obj[i].clinicInfo+"' data-name='"+obj[i].clinicName+"'>위치</button></td>";
									html += "	</tr>";
									html += "</tbody>"
									
								}
								
								html += "</table>"
								$("#table").append(html);
								
							} else {
								let html = "";
								
								html += '<tr>';
								html += '	<td>';
								html += '		표시할 내용이 없습니다.';
								html += '	</td>';
								html += '</tr>';
		
								$("#clinicTable").append(html);
							}
						},
						fail : function(data){
							console.log("fail, "+data);
						},
						complete: function(data){
							console.log("comp", data);
						}
					});
					
				}
				
	    		
	    		
	    		
	    	});
	    	
	    	$(document).off("click").on("click", "[id^=clinicMap]", function(){
	    		console.log("주소", $(this).val());
	    		console.log("보건소명", $(this).attr("data-name"));
	    		let clinic = $(this).attr("data-name");
	    		$("#map").html("");
	    		
	    		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(33.450701,
							126.570667), // 지도의 중심좌표
					level : 3// 지도의 확대 레벨
				};

				// 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption);

				// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
				var mapTypeControl = new kakao.maps.MapTypeControl();

				// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
				// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
				map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

				// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
				var zoomControl = new kakao.maps.ZoomControl();
				map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();

				// 주소로 좌표를 검색합니다
				geocoder.addressSearch($(this).val(),	function(result, status) {

					// 정상적으로 검색이 완료됐으면 
					if (status === kakao.maps.services.Status.OK) {

						var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

						// 결과값으로 받은 위치를 마커로 표시합니다
						var marker = new kakao.maps.Marker({
																map : map,
																position : coords
															});

						// 인포윈도우로 장소에 대한 설명을 표시합니다
						var infowindow = new kakao.maps.InfoWindow({
																content : '<div style="width:150px;text-align:center;padding:6px 0;">'+clinic+'</div>'
																	});
						infowindow.open(map, marker);// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						map.setCenter(coords);
					}
				});
	    		
	    	});
	    	
		}
	    
	    
	    function init(){
	    	
	    	html = "";
	    	
			html += '<h2 id="initText">검색결과창</h2>';
	    	
	    	$("#table").append(html);
    	
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
					level : 3// 지도의 확대 레벨
			};

			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption);

			// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
			var mapTypeControl = new kakao.maps.MapTypeControl();

			// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
			// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();

			// 주소로 좌표를 검색합니다
			geocoder.addressSearch('충남 천안시 동남구 대흥로 215',	function(result, status) {

				// 정상적으로 검색이 완료됐으면 
				if (status === kakao.maps.services.Status.OK) {

					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

					// 결과값으로 받은 위치를 마커로 표시합니다
					var marker = new kakao.maps.Marker({
															map : map,
															position : coords
														});

					// 인포윈도우로 장소에 대한 설명을 표시합니다
					var infowindow = new kakao.maps.InfoWindow({
															content : '<div style="width:150px;text-align:center;padding:6px 0;">휴먼교육센터</div>'
																});
					infowindow.open(map, marker);// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					map.setCenter(coords);
				}
			});

		}
	    
	</script>

</body>
</html>
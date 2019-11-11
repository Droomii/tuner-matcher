<%@page import="poly.dto.PianoDTO"%>
<%@page import="java.util.Set"%>
<%@page import="poly.dto.TunerDTO"%>
<%@page import="poly.dto.UserDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="../user/session.jsp" %>
<%
	TunerDTO tDTO = (TunerDTO)request.getAttribute("tDTO");
%>

<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>내 주변에서 찾기</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="../header.jsp" %>
</head>
<%if(!user_type.equals("1")){%>
<script type="text/javascript">
alert("잘못된 접근입니다");
location.href="/index.do";
<%}%>
</script>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="../menu.jsp" %>
	
	<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-body"><!-- Basic example section start -->
<!-- Header footer section start -->
<section id="header-footer">
	<div class="row match-height">
	<div class="col-xs-12 offset-lg-1">
		<div class="col-xs-12 col-md-8 col-lg-7">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title">내 주변에서 찾기</h4>
				</div>
				<div class="card-body">
					<div class="card-block">
					<div id="map" style="width:100%;height:500px;"></div>
					
					</div>
				</div>
			</div>
		</div>
		<div class="col-xs-12 col-md-4 col-lg-3">
			<div class="card" >
				<div class="card-header">
					<h4 class="card-title">요청 목록</h4>
				</div>
				<div class="card-body" >
					<div class="card-block overflow-auto" style="height:500px;">
						<p>gdgdg</p>
						<p>gdgdg</p>
						<p>gdgdg</p>
						<p>gdgdg</p>
						<p>gdgdg</p>
						<p>gdgdg</p>
						<p>gdgdg</p>
						<p>gdgdg</p>
						<p>gdgdg</p>
						<p>gdgdg</p>
						<p>gdgdg</p>
						<p>gdgdg</p>
						<p>gdgdg</p>
						<p>gdgdg</p>
					</div>
				</div>
			</div>
		</div>
		</div>
	</div>
</section>
<!-- Header footer section end -->

        </div>
      </div>
    </div>
	
	
	
	
	<!-- footer.jsp 경로설정 -->
	<%@include file="../footer.jsp" %>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=166a1380ea4bddbad714a838dbb867a6&libraries=services,clusterer,drawing"></script>
	<script type="text/javascript">
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
		level: 4 //지도의 레벨(확대, 축소 정도)
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	var geocoder = new kakao.maps.services.Geocoder();
	var tunerAddr = null;
	function init(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	        console.log(result);
	        tunerAddr = result[0];
	        var moveLoc = new kakao.maps.LatLng(tunerAddr.y, tunerAddr.x);
	        map.setCenter(moveLoc);
	        
	        var imageSrc = '/resources/images/home.png', // 마커이미지의 주소입니다    
	        imageSize = new kakao.maps.Size(40, 52), // 마커이미지의 크기입니다
	        imageOption = {offset: new kakao.maps.Point(20, 52)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	        
	        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	        marker = new kakao.maps.Marker({
	            position: moveLoc,
	            image:markerImage
	        });
	        
	        
	        marker.setMap(map);
	    }
	};
	
	geocoder.addressSearch('<%=tDTO.getAddr()%>', init);
	
	
	</script>
</body>
</html>
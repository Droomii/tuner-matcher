<%@page import="poly.dto.ReqDTO"%>
<%@page import="poly.dto.PianoDTO"%>
<%@page import="poly.dto.TunerDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="../user/session.jsp" %>
<%
	TunerDTO tDTO = (TunerDTO)request.getAttribute("tDTO");
	List<ReqDTO> rList = (ArrayList<ReqDTO>)request.getAttribute("rList"); 
	List<Integer> dList = (ArrayList<Integer>)request.getAttribute("dList"); 
	String tunerAddr = tDTO.getAddr();
	tunerAddr = tunerAddr.split("\\(")[0].split(",")[0];
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
	<div class="row">
	<div class="col-xs-12 offset-lg-1">
		<div class="col-xs-12 col-md-8 col-lg-7">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title">내 주변에서 찾기</h4>
				</div>
				<div class="card-body">
					<div style="height:600px">
					<div id="map" style="width:100%;height:100%;"></div>
					
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
					<div class="card-block overflow-auto" style="height:600px; padding:0">
						<%for(ReqDTO rDTO : rList){
							if(dList.contains(Integer.parseInt(rDTO.getReq_seq()))){
								continue;
							}
							%>
						<div class="req-container" style="padding:1rem 1rem 0 1rem" id="req-<%=rDTO.getReq_seq()%>" onclick="location.href='/req/ReqDetail.do?req_seq=<%=rDTO.getReq_seq()%>'" role="button">
						<h5 class="card-text text-truncate mb-0"><strong><%=CmmUtil.nvl(rDTO.getReq_title(), true) %></strong></h5>
							<div class="card-text text-truncate"><%=CmmUtil.nvl(rDTO.getReq_content(), true).replaceAll("&lt;br&gt;", " ") %></div>
							<div class="card-text text-truncate text-muted"><%=rDTO.getSido_name().replaceAll("특별시","").replaceAll("광역시","").replaceAll("특별자치","") %> <%=rDTO.getSgg_name() %> | <%=rDTO.getBids() %>명 입찰중</div>
							<hr style="margin-bottom:0">
						</div>
						<%} 
						if(rList.size()==0){	%>
						<div class="card-tect text-xs-center"><br>- 주변 조율 요청이 없습니다. -</div>
						<%} %>
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
		level: 6 //지도의 레벨(확대, 축소 정도)
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	var geocoder = new kakao.maps.services.Geocoder();
	var homeLoc;
	function init(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	        console.log(result);
	        var tunerAddr = result[0];
	        var moveLoc = new kakao.maps.LatLng(tunerAddr.y, tunerAddr.x);
	        homeLoc = moveLoc;
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
	
	var markerObj = {};
	function addMarker(req_seq, obj){
		markerObj[req_seq] = obj;
	}
	
	
	
	geocoder.addressSearch('<%=tunerAddr%>', init);
	<%for(ReqDTO reqDTO2 : rList){%>
	geocoder.addressSearch('<%=reqDTO2.getAddr().split("\\(")[0].split(",")[0]%>', function(result, status){
		if (status === kakao.maps.services.Status.OK) {
	        console.log(result);
	        var reqAddr = result[0];
	        addMarker('<%=reqDTO2.getReq_seq()%>', reqAddr);
	        var reqLoc = new kakao.maps.LatLng(reqAddr.y, reqAddr.x);
	        
	        var imageSrc = '/resources/images/help.png', // 마커이미지의 주소입니다    
	        imageSize = new kakao.maps.Size(31, 42), // 마커이미지의 크기입니다
	        imageOption = {offset: new kakao.maps.Point(16, 42)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	        
	        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	        marker = new kakao.maps.Marker({
	            position: reqLoc,
	            image:markerImage,
	            clickable:true
	        });
	        marker.setMap(map);
	        
	        kakao.maps.event.addListener(marker, 'click', function(){
	        	location.href="/req/ReqDetail.do?req_seq=<%=reqDTO2.getReq_seq()%>"
	        });
	        
	        kakao.maps.event.addListener(marker, 'mouseover', function(){
	        	$("#req-<%=reqDTO2.getReq_seq()%>").css("background-color", "rgb(227, 227, 227)")
	        	$("#req-<%=reqDTO2.getReq_seq()%>").parent().animate({
                    scrollTop: $("#req-<%=reqDTO2.getReq_seq()%>").offset().top-250
                }, 200);
	        	
	        });
	        
	        kakao.maps.event.addListener(marker, 'mouseout', function(){
	        	$("#req-<%=reqDTO2.getReq_seq()%>").css("background-color", "")
	        });
	        
	        
	    }
	});
	<%}%>
	
	// 요청 하이라이트
	$(".req-container").mouseenter(function(){
	    $(this).css("background-color", "rgb(227, 227, 227)")
	    var bounds = new kakao.maps.LatLngBounds();
	    bounds.extend(homeLoc);
	    var target = markerObj[$(this).attr('id').split('-')[1]];
	    var moveLatLng = new kakao.maps.LatLng(target.y, target.x);
	    bounds.extend(moveLatLng);
	    map.setBounds(bounds);
	});
	$(".req-container").mouseleave(function(){
	    $(this).css("background-color", "")
	});
	</script>
</body>
</html>
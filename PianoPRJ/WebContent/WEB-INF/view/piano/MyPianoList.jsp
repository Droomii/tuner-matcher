<%@page import="poly.dto.PianoDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/user/session.jsp" %>

<%
	List<PianoDTO> pList = (List<PianoDTO>)request.getAttribute("pList"); 
	String proc = CmmUtil.nvl((String)session.getAttribute("proc"));
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>
<style>
	.card:hover{
		background-color:rgb(219, 231, 255);
		border-color:rgb(219, 231, 255);
		cursor : pointer;
	}
</style>
<meta charset="UTF-8">
<%if(proc.equals("public")){%>
	<title>공개 요청하기</title>
<%}else if(proc.equals("private")){%>
<title>1:1 요청</title>
	
<%}else{%>
<title>내 피아노 목록</title>
<%} %>


<!-- header.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="/WEB-INF/view/menu.jsp" %>
	<div class="app-content content container-fluid">
	<div class="content-wrapper">
	<div class="content-header row">
          <div class="content-header-left col-xs-7">
            
            <%if(proc.equals("public")){%>
				<h2 class="content-header-title">공개 요청하기</h2>
				<h4 class="content-header-title">서비스를 받고자 하는 피아노를 선택해주세요</h4>
			<%}else if(proc.equals("private")){%>
			<h2 class="content-header-title">1:1 요청하기</h2>
				<h4 class="content-header-title">서비스를 받고자 하는 피아노를 선택해주세요</h4>
			<%}else{%>
			<h2 class="content-header-title">내 피아노 정보</h2>
			<%} %>
          </div>
          <div class="content-header-right col-xs-5">
            <button onclick="location.href='/piano/AddPiano.do';" class="btn btn-success float-xs-right">피아노 추가하기</button>
          </div>
        </div>
	<div class="content-body">
	<div class="row match-height">
	<%if(pList.size()==0) {%>
	<div class="text-xs-center" style="color:rgb(100,100,100)">
	<div><i class="icon-android-alert" style="font-size:10rem;"></i></div>
	<div style="font-size:2rem;">등록된 피아노가 없습니다.</div>
	</div>
	<%}else{ %>
		<%for(PianoDTO pDTO : pList){ %>
		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 col-xl-3">
		<div class="card" onclick="location.href='/piano/PianoDetail.do?no=<%=pDTO.getPiano_seq()%>'">
				<div class="card-body">
					<div class="card-block">
						<h4 class="card-title text-truncate"><%=CmmUtil.nvl(pDTO.getPiano_name(), true) %></h4>
						<h6 class="card-subtitle text-muted text-truncate"><%=CmmUtil.nvl(pDTO.getPiano_desc(), "설명 없음", true)  %></h6>
						<%if(pDTO.getPiano_photo_dir()!=null) {%>
						<img class="img-fluid my-1" src="/img/piano/<%=pDTO.getPiano_seq() %>/thumbnail.<%=pDTO.getPiano_photo_dir() %>" alt="Card image cap">
						<%}else{ %>
						<img class="img-fluid my-1" src="/resources/images/piano_default.png" alt="piano">
						<%} %>
						<div class="card-text text-truncate"><%=CmmUtil.nvl(pDTO.getBrand(), true) %></div>
						<div class="card-text "><%=pDTO.getPiano_type().equals("0") ? "업라이트" : "그랜드"%></div>
						<div class="card-text">마지막 조율: <%=pDTO.getLast_tuned_date()!=null? pDTO.getLast_tuned_date().substring(0, 10) : "모름" %></div>
					</div>
				</div>
			</div>
			</div>
			<%} %>
		<%} %>
		</div>
	</div>
	</div>
	</div>
	<!-- footer.jsp 경로설정 -->
	<%@include file="/WEB-INF/view/footer.jsp" %>
</body>
</html>
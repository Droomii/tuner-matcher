<%@page import="poly.dto.TunerDTO"%>
<%@page import="poly.dto.PianoDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/user/session.jsp" %>

<%
	List<TunerDTO> tList = (List<TunerDTO>)request.getAttribute("tList"); 
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
<title>1:1 요청</title>

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

			<h2 class="content-header-title">1:1 요청하기</h2>
			<h4 class="content-header-title">조율을 요청할 조율사를 선택해주세요</h4>
          </div>
        </div>
	<div class="content-body">
	<div class="row">
	<%if(tList.size()==0) {%>
	<div class="text-xs-center" style="color:rgb(100,100,100)">
	<div><i class="icon-android-alert" style="font-size:10rem;"></i></div>
	<div style="font-size:2rem;">자주 찾는 조율사가 없습니다.</div>
	</div>
	<%}else{ %>
		<%for(TunerDTO tDTO : tList){ %>
		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-4">
		<div class="card" onclick="location.href='/req/PrivateTunerDetail.do?tuner_seq=<%=tDTO.getTuner_seq()%>'">
				<div class="card-body">
					<div class="card-block" style="display:flex">
					<div class="col-xs-4" style="width:160px;min-width:160px;">
						<img class="rounded img-fluid img-thumbnail" src="/img/tuner/<%=tDTO.getTuner_seq() %>/profile.<%=tDTO.getId_photo_dir() %>" alt="Card image cap">
					</div>
					<div class="col-xs-8">
						<h5><strong><%=CmmUtil.nvl( tDTO.getTuner_name(), true) %></strong></h5>
						<div class="card-text text-muted text-truncate"><%=CmmUtil.nvl(tDTO.getTuner_comment(), true) %></div>
						<div class="card-text text-truncate"><%=tDTO.getTuner_level().equals("0") ? "기능사" : "산업기사" %></div>
						<div class="card-text text-truncate"><%=CmmUtil.nvl(tDTO.getAffiliation(), true) %></div>
						<div class="card-text text-truncate"><%=CmmUtil.nvl(tDTO.getSido_name()) %> <%=CmmUtil.nvl(tDTO.getSgg_name()) %></div>
						<div class="card-text text-muted valign-middle"><span class="valign-middle"><%=CmmUtil.nvl(tDTO.getScore()) %></span><i class="icon-android-star valign-middle" style="font-size:1.2rem;color:orange"></i></div>
					</div>
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
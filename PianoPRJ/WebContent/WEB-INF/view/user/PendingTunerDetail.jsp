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
	UserDTO uDTO = (UserDTO)request.getAttribute("uDTO");

	TunerDTO tDTO = (TunerDTO)request.getAttribute("tDTO");
	Map<String, ArrayList<String>> sggGrouped = (Map<String, ArrayList<String>>)request.getAttribute("sggGrouped");
	Set<String> sggKeys = sggGrouped.keySet();
	
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>페이지 타이틀</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="../header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="../menu.jsp" %>
	
	<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-body"><!-- Basic example section start -->
<!-- Header footer section start -->
<section id="header-footer">
	<div class="row match-height">
		<div class="col-xs-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title">승인대기 조율사 정보</h4>
				</div>
				<div class="card-body">
					<div class="card-block text-xs-center">
					<img class="rounded mx-auto d-block img-thumbnail" style="height:200px"src="/img/tuner/<%=tDTO.getTuner_seq() %>/profile.<%=tDTO.getId_photo_dir() %>" alt="Card image cap">
						<br>
						<h5><%=CmmUtil.nvl(uDTO.getUser_nick(), true) %></h5>
					</div>
					<div class="card-block">
						<p class="card-text">이름 : <%=CmmUtil.nvl(uDTO.getUser_name(), true) %></p>
						<p class="card-text">이메일 : <%=CmmUtil.nvl( uDTO.getEmail(), true) %></p>
						<p class="card-text">전화번호 : <%=CmmUtil.nvl(uDTO.getUser_tel()) %></p>
						<p class="card-text">자격증 등급 : <%=tDTO.getTuner_level().equals("0") ? "기능사" : "산업기사" %></p>
						<p class="card-text">소속 : <%=CmmUtil.nvl(tDTO.getAffiliation(), true) %></p>
						<p class="card-text">근무지 : <%=CmmUtil.nvl(tDTO.getAddr(), true) %></p>
						<%if(!sggKeys.contains("전국")) { %>
						<p class="card-text">활동지역 : </p>
						<%} %>
						<%String sggString;%>
						<%for(String key : sggKeys){
							if(key.equals("전국")){ %>
							<p class="card-text">활동지역 : 전국</p><%break; }%>
							<%sggString = sggGrouped.get(key).toString(); %>
						<p class="card-text">&nbsp;&nbsp;&nbsp;- <%=key %> : <%=sggString.substring(1, sggString.length()-1) %></p>
						<%} %>
						<br>
						<p class="card-text">한줄소개 : <%=CmmUtil.nvl(tDTO.getTuner_comment(), "없음", true) %></p>
						<p class="card-text">이력 : <%if(CmmUtil.nvl(tDTO.getTuner_exp()).equals("")){ out.print("없음");%></p>
						<%}else{ %>
						<p class="card-text"><%=CmmUtil.revertXSS(tDTO.getTuner_exp()) %></p>
						<%} %>
					</div>
				</div>
				<div class="card-footer border-top-blue-grey border-top-lighten-5 text-muted">
				<div class="row">
					<div class="col-xs-4 text-xs-left">
						<button class="button btn btn-primary">뒤로 </button>
					</div>
					<span class="col-xs-4 text-xs-center">
						<button class="button btn btn-warning">반려 </button>
						<button class="button btn btn-success" onclick="accept();">승인 </button>
					</span>
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
	
	
	
	<script type="text/javascript">
	function accept(){
		if(confirm("가입을 승인하시겠습니까?")){
			location.href = "/user/AcceptTuner.do?tuner_seq=<%=tDTO.getTuner_seq()%>"
		}
	}
	</script>
	<!-- footer.jsp 경로설정 -->
	<%@include file="../footer.jsp" %>
</body>
</html>
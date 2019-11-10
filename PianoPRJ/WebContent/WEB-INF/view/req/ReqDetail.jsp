<%@page import="poly.dto.ReqDTO"%>
<%@page import="poly.dto.PianoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/user/session.jsp" %>

<%
	PianoDTO pDTO = (PianoDTO)request.getAttribute("pDTO");
	String proc = CmmUtil.nvl((String)session.getAttribute("proc"));
	String back = proc.equals("public") ? "/req/UserPublicReqList"
										:"/req/UserPrivateReqList";
	ReqDTO rDTO = (ReqDTO)request.getAttribute("rDTO");
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>
<style>
	.text-bold-700{
		background-color:rgb(220,220,220);
		padding: 0.2rem;
	}
	.desc{
		padding: 0.2rem;
	}
	.has-error, .has-danger{
    		color:crimson;
    		}
   	.success-msg{
   		color:#3c763d;
   		display:none;
   		line-height:1.8;
</style>


<meta charset="UTF-8">

<title>요청 정보</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="/WEB-INF/view/menu.jsp" %>
	<div class="app-content content container-fluid">
	<div class="content-body"><!-- Basic example section start -->
<!-- Header footer section start -->
<section id="header-footer">
	<div class="row match-height">
		<div class="col-xs-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title">요청 정보</h4>
				</div>
				<div class="card-body">
					<div class="card-block">
						<h5 class="form-section text-bold-600">피아노 정보</h5>
						<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" >브랜드</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getBrand()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">일련번호</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getSerial()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">피아노 타입</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPiano_type()).equals("0")?"업라이트" : "그랜드"%></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">용도</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPlayer_type()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">마지막 조율 날짜</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class=" border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getLast_tuned_date()).equals("") ? "모름" : CmmUtil.nvl(pDTO.getLast_tuned_date()).substring(0,10)%></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-3 text-xs-left text-sm-center text-bold-700">주소</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getAddr()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-3 text-xs-left text-sm-center text-bold-700">사진</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc">asd</div>
									
							</div>
							</div>
						
					</div>
					
					<div class="card-block">
						<h5 class="form-section text-bold-600">요청서 정보</h5>
						<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" >요청사항</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(rDTO.getReq_content()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">참고사진</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getSerial()) %></div>
								</div>
							</div>
						
					</div>
				</div>
				<form method="post" hidden="hidden" name="req_action">
					<input value="<%=rDTO.getReq_seq() %>" name="req_seq">
				</form>
				<div class="card-footer text-xs-center">
					<span>
						<a href="<%=back %>.do" class="button btn btn-sm btn-info">뒤로 </a>
						<button onclick="editReq()" class="button btn btn-sm btn-success">수정 </button>
						<button onclick="deleteConfirm()" class="button btn btn-sm btn-danger">삭제</button>
						
					</span>
				</div>
			</div>
		</div>
	</div>
	<%if(rDTO.getReq_type().equals("0")) {%>
	<div class="row">
					<div class="col-xs-12 col-lg-6 offset-lg-3">
					<div class="card">
				<div class="card-header">
					<h4 class="card-title" id="basic-layout-form">입찰 현황</h4>
				</div>
			</div>
					</div>
				</div>
				<%}%>
</section>
<!-- Header footer section end -->

        </div>
	</div>
	<!-- footer.jsp 경로설정 -->
	<%@include file="/WEB-INF/view/footer.jsp" %>
	
	
	<script>
	function deleteConfirm(){
		if(confirm("삭제하시겠습니까?")){
			var form = document.req_action;
			form.action = "/req/DeleteReq.do";
			form.submit();
		}
	}
	
	function editReq(){
		var form = document.req_action;
		form.action = "/piano/EditReq.do";
		form.submit();
	}
	
	
	</script>
</body>
</html>
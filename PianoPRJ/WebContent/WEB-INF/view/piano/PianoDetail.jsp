<%@page import="poly.dto.ReqDTO"%>
<%@page import="poly.dto.PianoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/user/session.jsp" %>

<%
	PianoDTO pDTO = (PianoDTO)request.getAttribute("pDTO");
	String proc = CmmUtil.nvl((String)session.getAttribute("proc"));
	String back = proc.equals("public") ? "/req/NewPublicReq"
			: proc.equals("private") ? "/req/NewPrivateReq"
					: "/piano/MyPianoList";
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
   	}
   	html, body {
   		height:100%;
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
				<h4 class="content-header-title">요청사항을 작성해주세요</h4>
			<%}else if(proc.equals("private")){%>
			<h2 class="content-header-title">1:1 요청하기</h2>
			<h4 class="content-header-title">요청사항을 작성해주세요</h4>
			<%}else{%>
			<h2 class="content-header-title">내 피아노 정보</h2>
			<%} %>
          </div>
        </div>
	<div class="content-body"><!-- Basic example section start -->
<!-- Header footer section start -->
<section id="header-footer">
	<div class="row match-height">
		<div class="col-xs-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title"><%=CmmUtil.nvl(pDTO.getPiano_name(), true) %></h4>
					<p class="card-title text-muted text-truncate"><%=CmmUtil.nvl(pDTO.getPiano_desc(), "설명 없음", true)  %></p>
				</div>
				<div class="card-body">
					<div class="card-block">
						<h5 class="form-section text-bold-600">피아노 정보</h5>
						<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" >브랜드</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getBrand(), true) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">일련번호</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getSerial(), true) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">피아노 타입</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPiano_type(), true).equals("0")?"업라이트" : "그랜드"%></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">용도</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPlayer_type(), true) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">마지막 조율 날짜</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class=" border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getLast_tuned_date(), true).equals("") ? "모름" : CmmUtil.nvl(pDTO.getLast_tuned_date()).substring(0,10)%></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-3 text-xs-left text-sm-center text-bold-700">주소</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getAddr()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700"><span style="margin:auto">사진</span></div>
									<%if(pDTO.getPiano_photo_dir()!=null){ %>
									<div style="border-color:rgb(150,150,150);padding:0" class="border col-xs-9 desc">
									<img class="img-fluid my-0" src="/img/piano/<%=pDTO.getPiano_seq() %>/image.<%=pDTO.getPiano_photo_dir() %>" alt="Card image cap">
									<%}else{ %>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc">사진 없음</div>
									
									<%} %>
									</div>
									
							</div>
							</div>
						
					</div>
				</div>
				<form method="post" hidden="hidden" name="piano_action">
					<input value="<%=pDTO.getPiano_seq() %>" name="piano_seq">		
				</form>
				<div class="card-footer text-xs-center">
					<span>
						<a href="<%=back %>.do" class="button btn btn-sm btn-info">뒤로 </a>
						<button onclick="editPiano()" class="button btn btn-sm btn-success">정보 수정 </button>
						<%if(!proc.startsWith("p")) {%>
						<button onclick="deleteConfirm()" class="button btn btn-sm btn-danger">피아노 삭제</button>
						<%}%>
						
					</span>
				</div>
			</div>
		</div>
	</div>
	<%if(proc.startsWith("p")) {%>
	<div class="row">
					<div class="col-xs-12 col-lg-6 offset-lg-3">
					<div class="card">
				<div class="card-header">
					<h4 class="card-title" id="basic-layout-form">요청서 작성</h4>
				</div>
				<div class="card-body collapse in">
					<div class="card-block">
					<form onsubmit="return submitReq();" enctype="multipart/form-data" data-toggle="validator" role="form" name="regForm" class="form" action="/req/<%=proc %>ReqSubmit.do" method="post" autocomplete="off">
							<input hidden="hidden" id="req_content" name="req_content">
							<input value="<%=pDTO.getPiano_seq() %>" name="piano_seq" hidden>
							<div class="form-body">
								<div class="form-group has-feedback">
									<label for="req_title">요청서 제목</label>
									<input type="text" id="notice_title" class="form-control" maxlength="50" placeholder="요청서 제목을 입력해주세요" required name="req_title">
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>
								<div class="form-group has-feedback">
									<label for="req_content">요청사항</label>
									<textarea onchange="checkBytes(this, 4000);" onKeyUp="checkBytes(this, 4000);" id="temp_content" rows="10" class="form-control" placeholder="요청사항을 입력해주세요" required></textarea>
									<div class="float-xs-right"><span class="byte">0</span>/4000 bytes</div>
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>
								<div class="form-group">
									<label>참고사진</label>
									<label id="req_img_label" class="file center-block">
										<input type="file" id="req_img" name="req_img" accept=".png,.gif,.jpg,.jpeg">
										<span class="file-custom"></span>
									</label>
								</div>
							</div>
							<div id="date-group has-feedback">
									<div class="form-group" style="margin-bottom:0" >
									<label>희망일시<span class="red">*</span> (날짜 선택 후 가능한 시간에 체크해주세요)</label>
										<input type="date" id="date" class="form-control date" style="width:12rem" onchange="getHour(this);">
									</div>
										<div id="hours" style="margin-top:1em">
										</div>
		
								<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
								<div class="help-block with-errors"></div>
								</div>
							
							<div class="form-actions">
								<button onclick="location.href='<%=back %>.do'" type="button" class="btn btn-warning mr-1">
									<i class="icon-cross2"></i> 취소
								</button>
								<button type="submit" class="btn btn-primary">
									<i class="icon-check2"></i> 작성
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
					</div>
				</div>
				<%}%>
</section>
<!-- Header footer section end -->

        </div>
	</div>
	</div>
	
	<!-- footer.jsp 경로설정 -->
	<%@include file="/WEB-INF/view/footer.jsp" %>
	
	
	<script>
	<%if(!proc.startsWith("p")) {%>
	function deleteConfirm(){
		if(confirm("삭제하시겠습니까?")){
			var form = document.piano_action;
			form.action = "/piano/DeletePiano.do";
			form.submit();
		}
	}
	<%}else{%>
	
	var tomorrow = new Date();
	tomorrow.setDate(tomorrow.getDate());
	
	document.getElementById("date").setAttribute('min', tomorrow.toISOString().split('T')[0]);
	
	var form = document.reqForm
	function submitReq(){
		var checklen = document.querySelectorAll('.pref-hour:checked').length;
		if(checklen==0){
			alert("최소 하나의 희망일시는 선택해야 합니다.");
			return false;
		}
		
		$("#req_content").val(document.getElementById('temp_content').value.trim().replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>"));
		$("#req_title").val($("#req_title").val().replace(/<br>/g, " "));
	}
	
	function getHour(elem){
		if(document.getElementsByClassName(elem.value).length!=0){
			alert("이미 선택한 날짜입니다");
			return;
		}
		var query = {date : elem.value,
				sgg_code : <%=pDTO.getSgg_code()%>};
		$.ajax({
			url:"/req/GetHour.do",
			type:"post",
			data:query,
			success:function(data){
				$("#hours").append(data);
				$('[data-toggle="tooltip"]').tooltip();
			}
		});
   	}
	<%} %>
	
	function editPiano(){
		var form = document.piano_action;
		form.action = "/piano/EditPiano.do";
		form.submit();
	}
	
	function delDate(elem){
   		elem.parentElement.parentElement.parentElement.remove();
   	}
	
	
	</script>
	<script src="/resources/js/validator.js" type="text/javascript"></script>
	<script src="/resources/js/bytechecker.js" type="text/javascript"></script>
</body>
</html>
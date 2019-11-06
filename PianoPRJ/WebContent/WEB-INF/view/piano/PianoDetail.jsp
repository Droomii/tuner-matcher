<%@page import="poly.dto.PianoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/user/session.jsp" %>

<%
	PianoDTO pDTO = (PianoDTO)request.getAttribute("pDTO");
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
</style>

<meta charset="UTF-8">
<title>피아노 정보</title>
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
            <h2 class="content-header-title">내 피아노 정보</h2>
          </div>
        </div>
	<div class="content-body"><!-- Basic example section start -->
<!-- Header footer section start -->
<section id="header-footer">
	<div class="row match-height">
		<div class="col-xs-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title"><%=CmmUtil.nvl(pDTO.getPiano_name()) %></h4>
					<p class="card-title text-muted text-truncate"><%=CmmUtil.nvl(pDTO.getPiano_desc(), "설명 없음")  %></p>
				</div>
				<div class="card-body">
					<div class="card-block">
						<h5 class="form-section text-bold-600">피아노 정보</h5>
						<div class="col-xs-12 border no-border-bottom">
							<div class="row border-bottom">
									<div class=" full-height  col-xs-3 text-xs-left text-sm-center text-bold-700">브랜드</div>
									<div class="  col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getBrand()) %></div>
								</div>
								<div class="row border-bottom">
									<div class=" full-height  col-xs-3 text-xs-left text-sm-center text-bold-700">일련번호</div>
									<div class="  col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getSerial()) %></div>
								</div>
								<div class="row border-bottom">
									<div class=" full-height  col-xs-3 text-xs-left text-sm-center text-bold-700">피아노 타입</div>
									<div class="  col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPiano_type()).equals("0")?"업라이트" : "그랜드"%></div>
								</div>
								<div class="row border-bottom">
									<div class=" full-height  col-xs-3 text-xs-left text-sm-center text-bold-700">용도</div>
									<div class="  col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPlayer_type()) %></div>
								</div>
								<div class="row border-bottom">
									<div class=" full-height  col-xs-3 text-xs-left text-sm-center text-bold-700">마지막 조율 날짜</div>
									<div class="  col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getLast_tuned_date()).equals("") ? "모름" : CmmUtil.nvl(pDTO.getLast_tuned_date()).substring(0,10)%></div>
								</div>
								<div class="row border-bottom">
									<div class=" full-height col-xs-3 text-xs-left text-sm-center text-bold-700">주소</div>
									<div class="  col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getAddr()) %></div>
								</div>
								<div class="row border-bottom">
									<div class=" full-height  col-xs-3 text-xs-left text-sm-center text-bold-700">사진</div>
									<div class="  col-xs-9 desc">asd</div>
									
							</div>
							</div>
						
					</div>
				</div>
				<form method="post" hidden="hidden" name="piano_action">
					<input value="<%=pDTO.getPiano_seq() %>" name="piano_seq">		
				</form>
				<div class="card-footer text-xs-center">
					<span>
						<a href="/piano/MyPianoList.do" class="button btn btn-sm btn-info">뒤로 </a>
						
						<button onclick="deleteConfirm()" class="button btn btn-sm btn-danger">피아노 삭제</button>
						<button class="button btn btn-sm btn-success">정보 수정 </button>
						
					</span>
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
	<%@include file="/WEB-INF/view/footer.jsp" %>
	
	<script>
	function deleteConfirm(){
		if(confirm("삭제하시겠습니까?")){
			var form = document.piano_action;
			form.action = "/piano/DeletePiano.do";
			form.submit();
		}
	}
	
	function EditPiano(){
		var form = document.piano_action;
		form.action = "/piano/EditPiano.do";
		form.submit();
	}
	</script>
</body>
</html>
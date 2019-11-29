<%@page import="poly.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	NoticeDTO rDTO = (NoticeDTO)request.getAttribute("rDTO");
%>
<!-- session.jsp 경로 설정 -->
<%@ include file="../user/session.jsp" %>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>공지 수정</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="../header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="../menu.jsp" %>
	<div class="app-content content container-fluid">
		<div class="content-wrapper">
			<div class="content-body">
				<div class="row">
					<div class="col-xs-12 col-lg-6 offset-lg-3">
					<div class="card">
				<div class="card-header">
					<h4 class="card-title" id="basic-layout-form">공지 수정</h4>
				</div>
				<div class="card-body collapse in">
					<div class="card-block">
						<form class="form" name="noticeForm" action="/notice/NoticeUpdate.do" method="post">
							<input hidden="hidden" id="notice_content" name="notice_content">
							<input hidden="hidden" value="<%=rDTO.getNotice_seq() %>" name="notice_seq">
							<div class="form-body">
								<div class="form-group">
									<label for="notice_title">공지 제목</label>
									<input type="text" id="notice_title" class="form-control" value="<%=CmmUtil.nvl(rDTO.getNotice_title())%>" placeholder="공지 제목을 입력해주세요" name="notice_title">
								</div>
								<div class="form-group">
                                    <input type="checkbox" name="top" value="Y" id="top" class="chk-remember" <%if(rDTO.getTop().equals("Y")){ %> checked <%} %>>
                                    <label for="top">상단 공지에 등록</label>
                                </div>
								 
								<div class="form-group">
									<label for="notice_content">공지 내용</label>
									<textarea id="temp_content" rows="10" class="form-control" placeholder="공지 내용을 입력해주세요"><%=CmmUtil.revertXSS(rDTO.getNotice_content()).replaceAll("<br>", "\n")%></textarea>
								</div>
							</div>

							<div class="form-actions">
								<button onclick="location.href='/notice/NoticeList.do'" type="button" class="btn btn-warning mr-1">
									<i class="icon-cross2"></i> 취소
								</button>
								<button type="button" class="btn btn-primary" onclick="submitNotice();">
									<i class="icon-check2"></i> 작성
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
	var form = document.noticeForm
	function submitNotice(){
		$("#notice_content").val(document.getElementById('temp_content').value.replace(/\n/g, "<br>"));
		$("#notice_title").val($("#notice_title").val().replace(/<br>/g, " "));
		form.submit();
	}
	
	</script>
	
	
	
	
	
	
	<!-- footer.jsp 경로설정 -->
	<%@include file="../footer.jsp" %>
</body>
</html>
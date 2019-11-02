<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.NoticeDTO"%>
<%
	NoticeDTO rDTO = (NoticeDTO)request.getAttribute("rDTO");
%>
<!-- session.jsp 경로 설정 -->
<%@ include file="../user/session.jsp" %>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>공지사항 - 도와조율</title>
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
                <h4 class="card-title">공지사항</h4>
                <a class="heading-elements-toggle"><i class="icon-ellipsis font-medium-3"></i></a>
            </div>
				<div class="card-body">
					<div class="card-block">
						<div class="row">
							<div class="col-xs-8">
								<h5 class="card-title" style="margin-bottom:5px"><%=rDTO.getNotice_title() %></h5>
							</div>
							<div class="col-xs-4 text-xs-right">
								관리자 | <%=rDTO.getRegdate() %>
							</div>
						</div>
						<hr style="margin-top:0;border-color:rgb(150,150,150)">
						<div class="row" style="margin-top:5px;">
							<div class="col-xs-12">
								<p class="card-text"><%=rDTO.getNotice_content() %></p>
							</div>
						</div>
						<hr style="margin-top:1rem;border-color:rgb(150,150,150)">
						<div class="row">
						<div class="col-xs-6">
						<a href="/notice/NoticeList.do" class="btn btn-info">목록</a>
						</div>
						<%if(user_type.equals("2")){ %>
						<div class="col-xs-6 text-xs-right">
						<form name="noticeAction" method="post" hidden="hidden">
						<input name="notice_seq" value="<%=rDTO.getNotice_seq() %>">
						</form>
						<button type="button" onclick="del();" class="btn btn-danger">삭제</button>
						<button type="button" onclick="update();" class="btn btn-success">수정</button>
						</div>
						<%} %>
						</div>
					</div>
				</div>
			</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	
	
	<!-- footer.jsp 경로설정 -->
	<%@include file="../footer.jsp" %>
	<script type="text/javascript">
	var form = document.noticeAction
	function del(){
		var conf = confirm("삭제하시겠습니까?", "예", "아니오");
		if(conf){
			form.action="/notice/NoticeDelete.do";
			form.submit();
		}
	}
	
	function update(){
		form.action="/notice/NoticeEditInfo.do";
		form.submit();
	}
	
	</script>
</body>
</html>
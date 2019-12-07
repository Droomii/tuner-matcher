<%@page import="java.util.Set"%>
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
	String userTypeKor = "일반 사용자";
	
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>단골고객 정보</title>
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
					<h4 class="card-title">단골고객 정보</h4>
				</div>
				<div class="card-body">
					<div class="card-block text-xs-center">
					<img class="img-fluid my-1" src="/resources/images/user_default.png" style="height:100px" alt="Card image cap">
						<br>
						<h5><%=CmmUtil.nvl(uDTO.getUser_nick(), true) %></h5>
					</div>
					<div class="card-block">
						<p class="card-text">이름 : <%=CmmUtil.nvl(uDTO.getUser_name(), true) %></p>
						<p class="card-text">이메일 : <%=CmmUtil.nvl( uDTO.getEmail(), true) %></p>
						<p class="card-text">전화번호 : <%=CmmUtil.nvl(uDTO.getUser_tel()) %></p>
					</div>
				</div>
				<div class="card-footer">
						<div class="float-xs-left">
						<a class="button btn btn-info" href="/myPage/FollowerList.do">뒤로</a>
						</div>						
						<div class="float-xs-right">
						<button class="button btn btn-danger" onclick="removeFollower()">목록에서 제거</button>
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
	<script type="text/javascript">

	function removeFollower(){
		if(confirm("단골 고객 목록에서 제거하시겠습니까?")){
			location.href = "/follow/FollowerRemove.do?user_seq=<%=uDTO.getUser_seq()%>"
		}
	}

	</script>
	<script type="text/javascript" src="/resources/js/bytechecker.js"></script>
</body>
</html>
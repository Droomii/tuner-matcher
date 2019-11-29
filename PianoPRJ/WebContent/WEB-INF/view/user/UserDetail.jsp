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
					<h4 class="card-title">개인정보</h4>
				</div>
				<div class="card-body">
					<div class="card-block text-xs-center">
					<img class="img-fluid my-1" src="/resources/images/user_default.png" style="height:100px" alt="Card image cap">
						<br>
						<h5><%=CmmUtil.nvl(uDTO.getUser_nick(1), true) %><%=uDTO.getUser_state()==3 ? "<span class=\"red\">(정지 회원)</span>"  : uDTO.getUser_state()==4 ? "<span class=\"red\">(탈퇴 회원)</span>" : ""%></h5>
					</div>
					<div class="card-block">
						<%if(uDTO.getUser_state()==3){ %>
						<p class="card-text red">정지 사유 : <%=CmmUtil.nvl(uDTO.getSuspend_reason(), true) %></p>
						<%} %>
						<p class="card-text">이름 : <%=CmmUtil.nvl(uDTO.getUser_name(), true) %></p>
						<p class="card-text">이메일 : <%=CmmUtil.nvl( uDTO.getEmail(), true) %></p>
						<p class="card-text">전화번호 : <%=CmmUtil.nvl(uDTO.getUser_tel()) %></p>
					</div>
				</div>
				<div class="card-footer">
						<div class="float-xs-left">
						<a class="button btn btn-info" href="/user/UserList.do">목록</a>
						</div>						
						<div class="float-xs-right">
						<%if(uDTO.getUser_state()==3 || uDTO.getUser_state()==4){ %>
						<button class="button btn btn-warning" onclick="recoverUser();">회원 복구</button>
						<%}else{ %>
						<button class="button btn btn-danger" data-toggle="modal" data-target="#decline-form">회원 정지</button>
						<%} %>
						<a class="button btn btn-success" href="/user/AUserEdit.do?user_seq=<%=uDTO.getUser_seq()%>">회원정보 수정</a>
						</div>
						</div>
						<!-- 회원쩡찌 모달 -->
						<div class="modal fade text-xs-left" id="decline-form" tabindex="-1" role="dialog" aria-labelledby="serialHelpLabel" style="display: none;" aria-hidden="true">
						  <div class="modal-dialog" role="document">
							<div class="modal-content">
							  <div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								  <span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title " id="serialHelpLabel">정지사유 입력</h4>
							  </div>
							  <div class="modal-body no-border">
								<form onsubmit="return suspendUser();" autocomplete="off" data-toggle="validator" role="form" name="suspendForm" class="form no-border" action="/user/UserSuspend.do" method="post" autocomplete="off">
							<!-- 리뷰 내용 -->
							<input hidden value="<%=uDTO.getUser_seq() %>" name="user_seq">
							<div class="form-group col-xs-12 has-feedback no-border">
								<input hidden="hidden" id="suspend_reason" name="suspend_reason">
								<textarea onchange="checkBytesNoNl(this, 200);" onKeyUp="checkBytesNoNl(this, 200);" id="temp_content" rows="5" class="form-control" placeholder="정지 사유를 입력해주세요"></textarea>
								<div class="float-xs-right"><span class="byte">0</span>/200 bytes</div>
								
							</div>
	                        <div class="modal-footer">
	                        <button type="submit" class="button btn btn-danger float-xs-right">정지</button>
								<button type="button" class="btn grey btn-outline-secondary float-xs-left" data-dismiss="modal">닫기</button>
							  </div>
							</form>
							  </div>
							  
							</div>
						  </div>
						</div>
						<!-- /반려 모달 -->
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
	function suspendUser(){
		if($("#temp_content").val().trim().length==0){
			alert("정지 사유를 입력해주세요");
			return false;
		}
		
		if(confirm("회원을 정지하시겠습니까?")){
			var form = document.suspendForm;
			form.suspend_reason.value = form.temp_content.value.trim().replace(/\n/g, " ");
		}else{
			return false;
		}
	}
	
	<%if(uDTO.getUser_state().matches("[34]")){ %>
	function recoverUser(){
		if(confirm("해당 회원을 복구하시겠습니까?")){
			location.href = "/user/UserRecover.do?user_seq=<%=uDTO.getUser_seq()%>"
		}
	}
	
	<%}%>
	</script>
	<script type="text/javascript" src="/resources/js/bytechecker.js"></script>
</body>
</html>
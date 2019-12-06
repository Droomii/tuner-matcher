<%@page import="poly.dto.UserDTO"%>
<%@page import="poly.dto.TunerDTO"%>
<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.RepuDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	UserDTO uDTO = (UserDTO)request.getAttribute("uDTO");
	String user_type = (String)session.getAttribute("user_type");
%>
    
<div class="modal fade text-xs-left" id="user-detail" tabindex="-1" role="dialog" aria-labelledby="user-detail-title" style="display: none;" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
	  <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		  <span aria-hidden="true">×</span>
		</button>
		<h6 class="modal-title" id="user-detail-title"><strong>고객 상세정보</strong></h6>
	  </div>
	  <div class="modal-body">
					<div class="card-block text-xs-center">
					<img class="img-fluid my-1" src="/resources/images/user_default.png" style="height:100px" alt="Card image cap">
						<br>
						<h5><%=CmmUtil.nvl(uDTO.getUser_nick(true), true) %><%=uDTO.getUser_state()==3 ? "<span class=\"red\">(정지 회원)</span>"  : uDTO.getUser_state()==4 ? "<span class=\"red\">(탈퇴 회원)</span>" : ""%></h5>
					</div>
					<div class="card-block">
						<%if(uDTO.getUser_state()==3){ %>
						<p class="card-text red">정지 사유 : <%=CmmUtil.nvl(uDTO.getSuspend_reason(), true) %></p>
						<%} %>
						<p class="card-text">이름 : <%=CmmUtil.nvl(uDTO.getUser_name(true), true) %></p>
						<p class="card-text">이메일 : <%=CmmUtil.nvl( uDTO.getEmail(true), true) %></p>
						<p class="card-text">전화번호 : <%=CmmUtil.nvl(uDTO.getUser_tel(true)) %></p>
					</div>
				</div>
	  <div class="modal-footer">
		<div class="float-xs-right">
		<%if(uDTO.getUser_state()==3 || uDTO.getUser_state()==4){ %>
		<button class="button btn btn-warning" onclick="recoverUser();">회원 복구</button>
		<%}else{ %>
		<button class="button btn btn-danger" data-toggle="modal" data-backdrop="false" data-target="#user-decline-form">회원 정지</button>
		<!-- 회원쩡찌 모달 -->
		<div class="modal fade text-xs-left" id="user-decline-form" tabindex="-1" role="dialog" aria-labelledby="serialHelpLabel" style="display: none;" aria-hidden="true">
		  <div class="modal-dialog" role="document">
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				  <span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title " id="serialHelpLabel">정지사유 입력</h4>
			  </div>
			  <div class="modal-body no-border">
				<form onsubmit="return suspendUser();" autocomplete="off" data-toggle="validator" role="form" name="userSuspendForm" class="form no-border" action="/user/UserSuspend.do" method="post" autocomplete="off">
			<!-- 리뷰 내용 -->
			<input hidden value="<%=uDTO.getUser_seq() %>" name="user_seq">
			<div class="form-group col-xs-12 has-feedback no-border">
				<input hidden="hidden" id="user_suspend_reason" name="suspend_reason">
				<textarea onchange="checkBytesNoNl(this, 200);" onKeyUp="checkBytesNoNl(this, 200);" id="user_temp_content" rows="5" class="form-control" placeholder="정지 사유를 입력해주세요"></textarea>
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
		<%} %>
		</div>
		<div class="float-xs-left">
		<button type="button" class="btn grey btn-outline-secondary" data-dismiss="modal">닫기</button>
		</div>
	  </div>
	</div>
  </div>
</div>
<script>
function suspendUser(){
	if($("#user_temp_content").val().trim().length==0){
		alert("정지 사유를 입력해주세요");
		return false;
	}
	
	if(confirm("회원을 정지하시겠습니까?")){
		var form = document.userSuspendForm;
		form.suspend_reason.value = form.user_temp_content.value.trim().replace(/\n/g, " ");
	}else{
		return false;
	}
}
</script>
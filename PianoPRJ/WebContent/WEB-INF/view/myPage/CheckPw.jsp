<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->

<%
	String action = (String)request.getAttribute("action");
	String back = (String)request.getAttribute("back");
	String forWhat = (String)request.getAttribute("forWhat");
%>
<%@ include file="../user/session.jsp" %>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>암호 재확인</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="../header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="../menu.jsp" %>
	
	<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-body"><!-- Basic form layout section start -->
<section id="basic-form-layouts">

	<div class="row">
		<div class="col-xs-12 col-lg-4 offset-lg-4">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title">암호 재확인</h4>
				</div>
				<div class="card-body collapse in">
					<div class="card-block">
					<div class="card-text text-xs-center">
					<%=CmmUtil.nvl(forWhat).equals("update") ? "정보 수정을" : "회원 탈퇴를"%> 위하여 암호를 다시 입력해주세요
					</div>
						<form class="form" name="checkForm" action="<%=CmmUtil.nvl(action)%>" method="post">
							<div class="form-body">

								<div class="form-group">
									<label for="eventRegInput4"></label>
									<input type="password" id="password" class="form-control" placeholder="암호를 입력해주세요" name="password">
								</div>
								<div id="errorMsg" style="color:crimson"></div>
							</div>

							<div class="form-actions center">
								<button type="button" class="btn btn-warning mr-1" onclick="href.location='<%=CmmUtil.nvl(back)%>';">
									<i class="icon-cross2"></i> 돌아가기
								</button>
								<button type="button" class="btn btn-primary" onclick="doSubmit();">
									<i class="icon-check2"></i> 확인
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- // Basic form layout section end -->
        </div>
      </div>
    </div>
	<script type="text/javascript">
	var form = document.checkForm;
	function doSubmit(){
		if("<%=forWhat%>"=="delete"){
			if(!confirm("회원탈퇴를 하시겠습니까?")){
				return;
			}
			
		}
		form.submit();
		
	}
	</script>
	
	
	
	<!-- footer.jsp 경로설정 -->
	<%@include file="../footer.jsp" %>
</body>
</html>
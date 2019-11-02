<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	String title = CmmUtil.nvl((String)request.getAttribute("title"));
	String status = CmmUtil.nvl((String)request.getAttribute("status"));
	String msg = CmmUtil.nvl((String)request.getAttribute("msg"));
	String id = CmmUtil.nvl((String)request.getAttribute("id"));
	String findType = CmmUtil.nvl((String)request.getAttribute("findType"));

%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
  <head>
	<%@ include file="../header.jsp" %>
	<meta charset="UTF-8">
    <title><%=title %></title>
  </head>
  <body data-open="click" data-menu="vertical-menu" data-col="1-column" class="vertical-layout vertical-menu 1-column  blank-page blank-page">
    <!-- ////////////////////////////////////////////////////////////////////////////-->
    <div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-header row">
        </div>
        <div class="content-body"><section class="flexbox-container">
    <div class="col-md-4 offset-md-4 col-xs-10 offset-xs-1  box-shadow-2 p-0">
        <div class="card border-grey border-lighten-3 m-0 px-2 py-3 p-0">
            <div class="card-header no-border pb-0">
                <div class="card-title text-xs-center">
                </div>
            </div>
            <div class="card-body collapse in">
                <div class="card-block text-xs-center">
                <div class="fonticon-wrap" style="margin-bottom:1.5rem">
                <%if(status.equals("1")){%><i class="icon-android-cancel" style="font-size:10rem;color:rgb(255, 102, 102)"></i><%}else{ %>
                <i class="icon-checkmark-circled" style="font-size:10rem;color:rgb(31, 189, 0)"></i><%} %>
                
                </div>
                <%=msg %>
                </div>
            </div>
            <div class="card-block text-xs-center">
                	<button type="button" class="btn btn-primary btn-lg" onclick="location.href='/user/UserLogin.do'">처음으로</button>
                </div>
            <div class="card-footer">
                
                    <%if(status.equals("1")){ %><p class="text-xs-center m-0"><a href="/user/Register.do" class="card-link">회원가입</a></p>
                    <%}else if(!findType.equals("pw") && !findType.equals("pwProc")){ %>
                    <div class="float-xs-left col-xs-12 text-xs-center"><a href="/user/RecoverPw.do" class="card-link">암호 초기화</a></div><%} %>
            </div>
        </div>
    </div>
</section>

        </div>
      </div>
    </div>
    <!-- ////////////////////////////////////////////////////////////////////////////-->

<script>
	function validate(){
		
		var valid = false;
		if(document.loginForm.id.value==""){
			alert("아이디를 입력해주세요");
			return false;
		}else if(document.loginForm.password.value==""){
			alert("암호를 입력해주세요");
			return false;
		}
		
		var query = {
				id : $("#id").val(),
				password : $("#password").val()
				};
		$.ajax({
			url:"/user/LoginTest.do",
			type:"post",
			data:query,
			success:function(data){
				console.log("data : " + data)
				if(data=="1"){
					console.log("validated")
					document.loginForm.submit()
				}else{
					console.log("login error")
					$("#errorMsg").html("아이디 또는 암호가 일치하지 않습니다.")
				}
			}
		});

		return valid;
		
	}
</script>
    <!-- BEGIN VENDOR JS-->
    <script src="/resources/app-assets/js/core/libraries/jquery.min.js" type="text/javascript"></script>
    <script src="/resources/app-assets/vendors/js/ui/tether.min.js" type="text/javascript"></script>
    <script src="/resources/app-assets/js/core/libraries/bootstrap.min.js" type="text/javascript"></script>
    <script src="/resources/app-assets/vendors/js/ui/perfect-scrollbar.jquery.min.js" type="text/javascript"></script>
    <script src="/resources/app-assets/vendors/js/ui/unison.min.js" type="text/javascript"></script>
    <script src="/resources/app-assets/vendors/js/ui/blockUI.min.js" type="text/javascript"></script>
    <script src="/resources/app-assets/vendors/js/ui/jquery.matchHeight-min.js" type="text/javascript"></script>
    <script src="/resources/app-assets/vendors/js/ui/screenfull.min.js" type="text/javascript"></script>
    <script src="/resources/app-assets/vendors/js/extensions/pace.min.js" type="text/javascript"></script>
    <!-- BEGIN VENDOR JS-->
    <!-- BEGIN PAGE VENDOR JS-->
    <!-- END PAGE VENDOR JS-->
    <!-- BEGIN ROBUST JS-->
    <script src="/resources/app-assets/js/core/app-menu.js" type="text/javascript"></script>
    <script src="/resources/app-assets/js/core/app.js" type="text/javascript"></script>
    <!-- END ROBUST JS-->
    <!-- BEGIN PAGE LEVEL JS-->
    <!-- END PAGE LEVEL JS-->
  </body>
</html>

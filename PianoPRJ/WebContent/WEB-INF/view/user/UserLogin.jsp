<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	String error = CmmUtil.nvl((String)request.getAttribute("error"));

%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
  <head>
	<%@ include file="../header.jsp" %>
	<meta charset="UTF-8">
    <title>로그인 - 도와조율</title>
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
                    <div class="p-1"><img src="/resources/app-assets/images/logo/logo.png" alt="branding logo"></div>
                </div>
                <h6 class="card-subtitle line-on-side text-muted text-xs-center font-small-3 pt-2"><span>도와조율에 로그인</span></h6>
            </div>
            <div class="card-body collapse in">
                <div class="card-block">
                    <form name="loginForm" method="post" class="form-horizontal form-simple" action="/user/LoginProc.do" onsubmit="return validate();">
                        <fieldset class="form-group position-relative has-icon-left mb-0">
                            <input type="text" class="form-control form-control-lg input-lg" maxlength="20" id="id" name="id" placeholder="아이디">
                            <div class="form-control-position">
                                <i class="icon-head"></i>
                            </div>
                        </fieldset>
                        <fieldset class="form-group position-relative has-icon-left">
                            <input type="password" class="form-control form-control-lg input-lg" id="password" name="password" placeholder="암호">
                            <div class="form-control-position">
                                <i class="icon-key3"></i>
                            </div>
                            <div id="errorMsg" style="color:crimson"></div>
                            
                        </fieldset>
                        
                        <button type="submit" class="btn btn-primary btn-lg btn-block"><i class="icon-unlock2"></i> 로그인</button>
                    </form>
                </div>
            </div>
            <div class="card-footer">
                <div class="float-xs-left col-xs-12 text-xs-center"><a href="/user/Find.do" class="card-link">아이디/암호 찾기</a></div>
                    <p class="text-xs-center m-0">회원이 아니신가요? <a href="/user/Register.do" class="card-link">회원가입</a></p>
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
				if(data=="0"){
					location.href = "/main.do";
				}else if(data=="1"){
					$("#errorMsg").html("아이디 또는 암호가 일치하지 않습니다.")
				}else if(data=="2"){
					$("#errorMsg").html("이메일 인증이 필요합니다.")
				}else{
					alert("해당 계정은 관리자에 의해 정지되었습니다.\n정지 사유 : " + data)
					$("#errorMsg").html("관리자에 의해 정지된 계정입니다.")
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

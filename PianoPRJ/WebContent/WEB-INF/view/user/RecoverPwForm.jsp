<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String code = (String)request.getAttribute("code");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>암호 초기화</title>
	<%@include file="../header.jsp" %>
</head>
<body>

	<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-header row">
        </div>
        <div class="content-body"><section class="flexbox-container">
    <div class="col-md-4 offset-md-4 col-xs-10 offset-xs-1 box-shadow-2 p-0">
        <div class="card border-grey border-lighten-3 px-2 py-2 m-0">
            <div class="card-header no-border pb-0">
                <div class="card-title text-xs-center">
                    <img src="../../app-assets/images/logo/robust-logo-dark.png" alt="branding logo">
                </div>
                <h6 class="card-subtitle line-on-side text-muted text-xs-center font-small-3 pt-2"><span>암호 초기화</span></h6>
            </div>
            <div class="card-body collapse in">
                <div class="card-block">
                    <form data-toggle="validator" role="form" name="recoverForm" onsubmit="return validate();" class="form-horizontal form" action="/user/RecoverPwFormProc.do" autocomplete="off"method="post">
                        <fieldset class="form-group position-relative has-icon-left mb-0">
                            <input type="password" class="form-control form-control-lg input-lg" id="password" name="password" placeholder="새 암호 입력">
                            <div class="form-control-position">
                                <i class="icon-key3"></i>
                            </div>
                            <div class="help-block with-errors"></div>
                        </fieldset>
                        <fieldset class="form-group position-relative has-icon-left has-feedback">
                            <input type="password" class="form-control form-control-lg input-lg" id="verify_password" placeholder="암호 확인" data-match="#password" data-match-error="암호가 일치하지 않습니다" required>
                            <div class="form-control-position">
                                <i class="icon-key3"></i>
                            </div>
                            <div class="help-block with-errors red"></div>
                            <input name="code" value="<%=code %>" hidden="hidden">
                        </fieldset>
                        <button type="submit" class="btn btn-primary btn-lg btn-block"><i class="icon-lock4"></i>암호 초기화</button>
                    </form>
                </div>
            </div>
            <div class="card-block text-xs-center">
                	<button type="button" class="btn btn-primary btn-lg" onclick="location.href='/user/UserLogin.do'">처음으로</button>
                </div>
            <div class="card-footer no-border">
                <p class="float-sm-left text-xs-center"><a href="login.do" class="card-link">로그인</a></p>
                <p class="float-sm-right text-xs-center">회원이 아니신가요? <a href="UserReg.do" class="card-link">회원가입</a></p>
            </div>
        </div>
    </div>
</section>

        </div>
      </div>
    </div>
    <script src="/resources/app-assets/js/core/libraries/jquery.min.js" type="text/javascript"></script>
    <script src="/resources/app-assets/vendors/js/ui/tether.min.js" type="text/javascript"></script>
    <script src="/resources/app-assets/js/core/libraries/bootstrap.min.js" type="text/javascript"></script>
    <script src="/resources/js/validator.js" type="text/javascript"></script>
</body>
</html>
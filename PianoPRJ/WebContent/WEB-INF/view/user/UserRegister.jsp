<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ page import="poly.dto.SggDTO" %>

<%

	List<SggDTO> sList = (List<SggDTO>)request.getAttribute("sList");

%>
    
    
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
  <head>

    <title>조율사 회원가입 - 도와조율</title>
		<%@ include file="../header.jsp" %>
	<meta charset="UTF-8">
    <style>
    	.has-error, .has-danger{
    		color:crimson;
    		}
    	.success-msg{
    		color:#3c763d;
    		display:none;
    		line-height:1.8;
    	}
    </style>
   
  </head>
  <body data-open="click" data-menu="vertical-menu" data-col="1-column" class="vertical-layout vertical-menu 1-column  blank-page blank-page">
    <!-- ////////////////////////////////////////////////////////////////////////////-->
    <div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-header row">
        </div>
        <div class="content-body"><section class="container">
    <div class="col-md-8 offset-md-2 col-xs-12 box-shadow-2 p-0">
		<div class="card border-grey border-lighten-3 px-2 py-2 m-0">
			<div class="card-header no-border">
				<div class="card-title text-xs-center">
					<img src="/resources/app-assets/images/logo/robust-logo-dark.png" alt="branding logo">
				</div>
				<h6 class="card-subtitle line-on-side text-muted text-xs-center font-small-3 pt-2"><span>조율사 회원가입</span></h6>
			</div>
			<div class="card-body collapse in">
					<div class="card-block">
						<form data-toggle="validator" role="form" name="form" class="form" action="/user/UserRegProc.do" method="post" autocomplete="off">
							<div class="form-body">
								<h4 class="form-section"><i class="icon-head"></i> 기본 정보</h4>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="user_name" class="control-label" >이름</label>
											<input type="text" pattern="^[가-힣]{1,}$" id="user_name" maxlength="7" class="form-control" placeholder="이름을 입력해주세요" name="user_name" required data-pattern-error="한글만 입력 가능합니다.">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>										
										</div>
										
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="id">아이디</label>
											<input type="text" pattern="^[_A-z0-9]{4,}$" id="id" class="form-control" maxlength="20" placeholder="아이디를 입력해주세요" name="id" data-pattern-error="대소문자 영문 및 언더바(_)만 사용 가능합니다(4글자 이상)" data-remote="/user/DupCheck.do" data-remote-error="이미 사용중인 아이디입니다" required>
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="success-msg">사용 가능한 아이디입니다.</div>
											<div class="help-block with-errors"></div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="user_nick">닉네임</label>
											<input type="text" id="projectinput2" pattern="^[가-힣A-z][가-힣A-z0-9]{1,}$" class="form-control" maxlength="7" placeholder="닉네임을 입력해주세요" name="user_nick" required data-pattern-error="한글, 영문 및 숫자만 가능합니다(숫자로 시작 불가)">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="email">이메일</label>
											<input type="text" id="email" class="form-control" placeholder="이메일을 입력해주세요" maxlength="45" name="email" pattern="^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$" data-remote="/user/DupCheck.do" data-remote-error="이미 사용중인 이메일입니다"  required data-error="유효한 이메일 주소가 아닙니다">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="success-msg">사용 가능한 이메일입니다.</div>
											<div class="help-block with-errors"></div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="user_tel">전화번호</label>
											<input type="text" id="user_tel" class="form-control" placeholder="전화번호를 입력해주세요" pattern="[^1-9][0-9]{1,2}-[0-9]{3,4}-[0-9]{4}" data-pattern-error="올바른 전화번호가 아닙니다." onKeyUp="phoneNumberFormat(this);"name="user_tel" required>
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="password">암호</label>
											<input type="password" id="password" class="form-control" placeholder="암호를 입력해주세요" name="password" required data-error="필수 입력사항입니다">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="verify_passwd">암호 확인</label>
											<input type="password" id="verify_passwd" class="form-control" placeholder="암호를 재입력해주세요" data-match="#password" data-match-error="암호가 일치하지 않습니다" required>
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label>성별</label>
											<div class="input-group">
												<label class="display-inline-block custom-control custom-radio ml-1">
													<input type="radio" name="user_sex" value="M" checked="checked" class="custom-control-input">
													<span class="custom-control-indicator"></span>
													<span class="custom-control-description ml-0">남</span>
												</label>
												<label class="display-inline-block custom-control custom-radio">
													<input type="radio" name="user_sex" value="F" class="custom-control-input">
													<span class="custom-control-indicator"></span>
													<span class="custom-control-description ml-0">여</span>
												</label>
											</div>
										</div>
										
									</div>
								</div>
								</div>
							<div class="form-actions text-xs-center">
							<a href="/index.do" class="btn btn-warning d-flex">
									<i class="icon-cross2"></i> 취소
								</a>
							<button type="submit" class="btn btn-primary">
									<i class="icon-check2 d-flex"></i> 가입신청
								</button>
								
								
							</div>
						</form>
					</div>
				</div>
		</div>
	</div>
</section>
        </div>
      </div>
    </div>
    <!-- ////////////////////////////////////////////////////////////////////////////-->




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
    
    <!-- FORM VALIDATOR JS -->
	<script src="/resources/js/validator.js" type="text/javascript"></script>
    <script>
    
    // 전화번호 형식 자동변환
    function phoneNumberFormat(obj) {
    	obj.value = obj.value.replace(/[^0-9\-]/g, "");
	    var number = obj.value.replace(/[^0-9]/g, "");
	    var tel = "";
	
	    // 서울 지역번호(02)가 들어오는 경우
	    if(number.substring(0, 2).indexOf('02') == 0) {
	    	$("#user_tel").attr("maxlength", "12")
	        if(number.length < 3) {
	            return number;
	        } else if(number.length < 6) {
	            tel += number.substr(0, 2);
	            tel += "-";
	            tel += number.substr(2);
	        } else if(number.length < 10) {
	            tel += number.substr(0, 2);
	            tel += "-";
	            tel += number.substr(2, 3);
	            tel += "-";
	            tel += number.substr(5);
	        } else {
	            tel += number.substr(0, 2);
	            tel += "-";
	            tel += number.substr(2, 4);
	            tel += "-";
	            tel += number.substr(6);
	        }
	    
	    // 서울 지역번호(02)가 아닌경우
	    } else {
	    	$("#user_tel").attr("maxlength", "13")
	        if(number.length < 4) {
	            return number;
	        } else if(number.length < 7) {
	            tel += number.substr(0, 3);
	            tel += "-";
	            tel += number.substr(3);
	        } else if(number.length < 11) {
	            tel += number.substr(0, 3);
	            tel += "-";
	            tel += number.substr(3, 3);
	            tel += "-";
	            tel += number.substr(6);
	        } else {
	            tel += number.substr(0, 3);
	            tel += "-";
	            tel += number.substr(3, 4);
	            tel += "-";
	            tel += number.substr(7);
	        }
	    }
	
	    obj.value = tel;
	    $(obj).focusout();
	}

    </script>
    
     <!-- addrInput popup -->
    <script language="javascript">
		function goPopup(){
			// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrCoordUrl.do)를 호출하게 됩니다.
		    var pop = window.open("/addr/AddrPopup.do","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
		}
		function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn
								, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno
								, emdNo, entX, entY){
			// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
			document.form.addr.value = roadFullAddr.replace("& #40;", "(").replace("& #41;", ")");
			document.form.sido_name.value = siNm;
			document.form.sgg_name.value = sggNm;
			document.form.emd_name.value = emdNm;
			document.form.li_name.value = liNm;
			document.form.x_pos.value = entX;
			document.form.y_pos.value = entY;
			$('#addr').attr("readonly", "readonly");
		}
	</script>
	<script src="/js/bytechecker.js" type="text/javascript"></script>
  </body>
</html>

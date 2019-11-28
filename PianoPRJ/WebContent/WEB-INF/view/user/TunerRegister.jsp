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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Robust admin is super flexible, powerful, clean &amp; modern responsive bootstrap 4 admin template with unlimited possibilities.">
    <meta name="keywords" content="admin template, robust admin template, dashboard template, flat admin template, responsive admin template, web app">
    <meta name="author" content="PIXINVENT">
    <title>조율사 회원가입 - 도와조율</title>
    <link rel="apple-touch-icon" sizes="60x60" href="/resources/app-assets/images/ico/apple-icon-60.png">
    <link rel="apple-touch-icon" sizes="76x76" href="/resources/app-assets/images/ico/apple-icon-76.png">
    <link rel="apple-touch-icon" sizes="120x120" href="/resources/app-assets/images/ico/apple-icon-120.png">
    <link rel="apple-touch-icon" sizes="152x152" href="/resources/app-assets/images/ico/apple-icon-152.png">
    <link rel="shortcut icon" type="image/x-icon" href="/resources/app-assets/images/ico/favicon.ico">
    <link rel="shortcut icon" type="image/png" href="/resources/app-assets/images/ico/favicon-32.png">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-touch-fullscreen" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <!-- BEGIN VENDOR CSS-->
    <link rel="stylesheet" type="text/css" href="/resources/app-assets/css/bootstrap.css">
    <!-- font icons-->
    <link rel="stylesheet" type="text/css" href="/resources/app-assets/fonts/icomoon.css">
    <link rel="stylesheet" type="text/css" href="/resources/app-assets/fonts/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/app-assets/vendors/css/extensions/pace.css">
    <!-- END VENDOR CSS-->
    <!-- BEGIN ROBUST CSS-->
    <link rel="stylesheet" type="text/css" href="/resources/app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="/resources/app-assets/css/app.css">
    <link rel="stylesheet" type="text/css" href="/resources/app-assets/css/colors.css">
    <!-- END ROBUST CSS-->
    <!-- BEGIN Page Level CSS-->
    <link rel="stylesheet" type="text/css" href="/resources/app-assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="/resources/app-assets/css/core/menu/menu-types/vertical-overlay-menu.css">
    <link rel="stylesheet" type="text/css" href="/resources/app-assets/css/pages/login-register.css">
    <!-- END Page Level CSS-->
    <!-- BEGIN Custom CSS-->
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/style.css">
    <!-- END Custom CSS-->
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
						<form data-toggle="validator" enctype="multipart/form-data" role="form" name="form" class="form" action="/user/TunerRegProc.do" method="post" autocomplete="off" onsubmit="doSubmit();">
							<div class="form-body">
								<h4 class="form-section"><i class="icon-head"></i> 기본 정보</h4>
								<div class="row">
								<div class="col-xs-12 red" style="margin-bottom:1em">*표시된 항목은 필수 입력사항입니다.</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="user_name" class="control-label">이름<span class="red">*</span></label>
											<input type="text" pattern="^[가-힣]{1,}$" id="user_name" maxlength="15" class="form-control" placeholder="이름을 입력해주세요" name="user_name" required data-pattern-error="한글만 입력 가능합니다.">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>										
										</div>
										
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="id">아이디<span class="red">*</span></label>
											<input type="text" pattern="^[_A-z0-9]{4,}$" id="id" class="form-control" maxlength="20" placeholder="아이디를 입력해주세요" name="id" data-pattern-error="대소문자 영문 및 언더바(_)만 사용 가능합니다(4글자 이상)" data-remote="/user/DupCheck.do" data-remote-error="이미 사용중인 아이디입니다" required>
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="success-msg">사용 가능한 아이디입니다.</div>
											<div class="help-block with-errors"></div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="user_nick">닉네임<span class="red">*</span></label>
											<input type="text" id="projectinput2" pattern="^[가-힣A-z0-9]{1,}$" class="form-control" placeholder="닉네임을 입력해주세요" name="user_nick" required data-pattern-error="한글, 영문 및 숫자만 가능합니다">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="email">이메일<span class="red">*</span></label>
											<input type="text" id="email" class="form-control" placeholder="이메일을 입력해주세요" name="email" pattern="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$" data-remote="/user/DupCheck.do" data-remote-error="이미 사용중인 이메일입니다"  required data-error="유효한 이메일 주소가 아닙니다">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="success-msg">사용 가능한 이메일입니다.</div>
											<div class="help-block with-errors"></div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="user_tel">전화번호<span class="red">*</span></label>
											<input type="text" id="user_tel" class="form-control" placeholder="전화번호를 입력해주세요" pattern="[^1-9][0-9]{1,2}-[0-9]{3,4}-[0-9]{4}" data-pattern-error="올바른 전화번호가 아닙니다." onKeyUp="phoneNumberFormat(this);"name="user_tel" required>
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="password">암호<span class="red">*</span></label>
											<input type="password" id="password" class="form-control" placeholder="암호를 입력해주세요" name="password" required data-error="필수 입력사항입니다">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="verify_passwd">암호 확인<span class="red">*</span></label>
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

								<!--조율사 경력 정보-->
								<h4 class="form-section"><i class="icon-clipboard4"></i> 조율사 정보</h4>

								<div class="form-group">
									<label>자격증 등급</label>
									<div class="input-group">
										<label class="display-inline-block custom-control custom-radio ml-1">
											<input type="radio" name="tuner_level" value="0" checked="checked" class="custom-control-input">
											<span class="custom-control-indicator"></span>
											<span class="custom-control-description ml-0">기능사</span>
										</label>
										<label class="display-inline-block custom-control custom-radio">
											<input type="radio" name="tuner_level" value="1" class="custom-control-input">
											<span class="custom-control-indicator"></span>
											<span class="custom-control-description ml-0">산업기사</span>
										</label>
									</div>
								</div>
								
								<div class="form-group has-feedback">
									<label>자격증 사진<span class="red">*</span></label>
									<label id="projectinput7" class="file center-block">
										<input type="file" id="cert_img" name="cert_img" accept=".png,.gif,.jpg,.jpeg" required data-error="자격증 사진은 필수입니다.">
										<span class="file-custom"></span>
									</label>
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
									
								</div>
								
								<div class="form-group has-feedback">
									<label>프로필 사진<span class="red">*</span></label>
									<label id="projectinput7" class="file center-block">
										<input type="file" id="profile_img" name="profile_img"accept=".png,.gif,.jpg,.jpeg" required data-error="프로필 사진은 필수입니다.">
										<span class="file-custom"></span>
									</label>
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>

								<div class="form-group has-feedback">
									<label for="sosok">소속<span class="red">*</span></label>
									<input type="text" id="sosok" name="affiliation" class="form-control" placeholder="예) ㅇㅇ피아노, ㅇㅇ대학교, 프리랜서 등" required data-error="필수 입력사항입니다">
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>

								<div class="form-group">
									<label for="donationinput7">한줄 소개</label>
									<textarea id="donationinput7" rows="2" class="form-control square" name="tuner_comment" placeholder="본인에 대한 소개를 한 줄로 작성해주세요"></textarea>
								</div>
								
								<div class="form-group">
								<input hidden="hidden" id="tuner_exp" name="tuner_exp">
									<label for="temp_exp">이력</label>
									<textarea id="temp_exp" rows="20" class="form-control square" name="temp_exp" placeholder="본인의 이력을 작성해주세요"></textarea>
								</div>
							
								<h4 class="form-section"><i class="icon-clipboard4"></i> 지역 정보</h4>
								<div class="form-group has-feedback" data-toggle="tooltip" data-placement="top" data-original-title="근무지 기준으로 가까운 조율 요청부터 표시됩니다." onclick="goPopup();">
									<label for="addr">근무지 주소<span class="red">*</span></label>
									<div class="input-group">
										<input type="text" name="addr" id="addr" class="form-control" placeholder="주소를 검색해주세요" required data-error="필수 입력사항입니다">
										<div class="input-group-btn"><button type="button" class="btn btn-primary float-xs-right">주소검색</button></div>
									</div>
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>
								<input type="text" name="sido_name" id="sido_name" hidden="hidden">
								<input type="text" name="sgg_name" id="sgg_name" hidden="hidden">
								<input type="text" name="emd_name" id="emd_name" hidden="hidden">
								<input type="text" name="li_name" id="li_name" hidden="hidden">
								<input type="text" name="x_pos" id="x_pos" hidden="hidden">
								<input type="text" name="y_pos" id="y_pos" hidden="hidden">
								<div id="svc-area-group" data-toggle="tooltip" data-placement="top" data-original-title="선택한 활동지역의 조율 요청을 조회할 수 있습니다.">
									<div class="form-group svc-area" style="margin-bottom:0" >
										<label>활동지역을 선택해주세요<span class="red">*</span></label>
										<select class="form-control" onchange="getDetailSgg(this);">
											<option value="00">전국</option>
											<% for(SggDTO sDTO : sList){ %>
											<option value=<%=sDTO.getSggCode()%>><%=sDTO.getSggName() %></option>
											<%}%>	
										</select>
										<div class="detail-checkboxes row" style="margin-top:1em">
											<input type="checkbox" name="sgg_code" class="sgg-detail" value="00" checked hidden="hidden">
										</div>
										<div class="text-xs-right">
											<button type="button" class="btn btn-danger btn-sm" onclick="delArea(this);">
												<i class="icon-cross2"></i> 지역 삭제
											</button>
										</div>
		
									</div>
								</div>
							</div><!-- end of form body -->
							
							
							<div class="form-actions text-xs-right">
							<button type="button" class="btn btn-primary btn-sm" onclick="addArea();" data-toggle="tooltip" data-placement="top" data-original-title="다른 지역을 추가로 선택할 수 있습니다.">
									<i class="icon-check2 d-flex"></i> 지역 추가
								</button>
								</div>
							<div class="form-actions text-center">
							<button type="submit" class="btn btn-primary">
									<i class="icon-check2 d-flex"></i> 가입신청
								</button>
								<button type="button" class="btn btn-warning mr-1 d-flex">
									<i class="icon-cross2"></i> 취소
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
	
	
	
    <script>
    var svcAreaForm = document.getElementById("svc-area-group").innerHTML;
   	
    function doSubmit(){
		$("#tuner_exp").val(document.getElementById('temp_exp').value.replace(/\n/g, "<br>"));
		$("#tuner_comment").val($("#tuner_comment").val().replace(/<br>/g, " "));
		form.submit();
	}
    
    // 상세 시군구코드 구하기
    function getDetailSgg(elem){
    	if(document.getElementsByClassName('sido-'+elem.value).length!=0){
			alert("이미 선택한 시도입니다");
			return;
		}
		var query = {sidoCode : elem.value};
		console.log("sidocode : " + elem.value);
		$.ajax({
			url:"/addr/GetSgg.do",
			type:"post",
			data:query,
			success:function(data){
				elem.parentElement.getElementsByClassName('detail-checkboxes')[0].innerHTML = data;
			}
		});
   	}
   	
    // 전체 선택/취소
   	function toggleAll(elem){
   		var checkboxes = elem.parentElement.parentElement.getElementsByClassName('sgg-detail');
		for(var i=1; i < checkboxes.length; i++){
			var checkbox = checkboxes[i];
			checkbox.checked = elem.checked;
			checkbox.disabled = elem.checked;
			checkbox.name = elem.checked ? "" : "sgg_code";
			
		}
   	}
    
   	function addArea(){
   		$('#svc-area-group').append(svcAreaForm);
   	}
   	
   	function delArea(elem){
   		if(document.getElementsByClassName('svc-area').length == 1){
   			alert("최소 한 개의 활동지역은 있어야 합니다.");
   			return;
   		}
   			
   		elem.parentElement.parentElement.remove();
   	}
   	
   	// 모두 체크 되었는지 확인
   	function checkAllChecked(elem){
   		var subDetails = elem.parentElement.parentElement.getElementsByClassName('sub-detail');
   		var allChecked = true;
   		for(var i = 0; i < subDetails.length; i++){
   			allChecked = allChecked && subDetails[i].checked;
   		}
   		if(allChecked){
   			elem.parentElement.parentElement.getElementsByClassName('select-all')[0].click();
   		}
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
			$("#addr").focusout();
		}
	</script>
  </body>
</html>

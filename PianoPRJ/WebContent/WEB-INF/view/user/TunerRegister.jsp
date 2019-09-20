<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="UTF-8"%>
<%@ page import="poly.dto.SggDTO" %>

<%

	List<SggDTO> sList = (List<SggDTO>)request.getAttribute("sList");

%>
    
    
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Robust admin is super flexible, powerful, clean &amp; modern responsive bootstrap 4 admin template with unlimited possibilities.">
    <meta name="keywords" content="admin template, robust admin template, dashboard template, flat admin template, responsive admin template, web app">
    <meta name="author" content="PIXINVENT">
    <title>Register Page - Robust Free Bootstrap Admin Template</title>
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
			document.form.roadAddrPart1.value = roadAddrPart1;
			document.form.roadAddrPart2.value = roadAddrPart2;
			document.form.addrDetail.value = addrDetail;
			document.form.zipNo.value = zipNo;
			document.form.entX.value = entX;
			document.form.entY.value = entY;
		}
	</script>
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
						<form class="form" action="/user/TunerRegProc.do" method="post">
							<div class="form-body">
								<h4 class="form-section"><i class="icon-head"></i> 기본 정보</h4>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label for="user_name">이름</label>
											<input type="text" id="user_name" class="form-control" placeholder="이름을 입력해주세요" name="user_name">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label for="id">아이디</label>
											<input type="text" id="id" class="form-control" placeholder="아이디를 입력해주세요" name="id">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label for="user_nick">닉네임</label>
											<input type="text" id="projectinput2" class="form-control" placeholder="닉네임을 입력해주세요" name="user_nick">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label for="email">이메일</label>
											<input type="text" id="email" class="form-control" placeholder="이메일을 입력해주세요" name="email">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label for="user_tel">전화번호</label>
											<input type="text" id="user_tel" class="form-control" placeholder="전화번호를 입력해주세요" name="user_tel">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label for="password">암호</label>
											<input type="password" id="password" class="form-control" placeholder="암호를 입력해주세요" name="password">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label for="verify_passwd">암호 확인</label>
											<input type="password" id="verify_passwd" class="form-control" placeholder="암호를 재입력해주세요">
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
										
										<div class="form-group">
											<label>자격증 사진</label>
											<label id="projectinput7" class="file center-block">
												<input type="file" id="file">
												<span class="file-custom"></span>
											</label>
										</div>
										
										<div class="form-group">
											<label>프로필 사진</label>
											<label id="projectinput7" class="file center-block">
												<input type="file" id="file">
												<span class="file-custom"></span>
											</label>
										</div>

										<div class="form-group">
											<label for="sosok">소속</label>
											<input type="text" id="sosok" name="affiliation" class="form-control" placeholder="예) ㅇㅇ피아노, ㅇㅇ대학교, 프리랜서 등">
										</div>

								<div class="form-group">
									<label for="donationinput7">한줄 소개</label>
									<textarea id="donationinput7" rows="2" class="form-control square" name="tuner_comment" placeholder="본인에 대한 소개를 한 줄로 작성해주세요"></textarea>
								</div>
								
								<div class="form-group">
									<label for="donationinput8">이력</label>
									<textarea id="donationinput8" rows="10" class="form-control square" name="tuner_exp" placeholder="본인의 이력을 작성해주세요"></textarea>
								</div>
							</div>
							<h4 class="form-section"><i class="icon-clipboard4"></i> 지역 정보</h4>
							<label for="user_name">근무지 주소</label>
							<div class="row">
							
									<div class="col-xs-10">
									
										<div class="form-group">
											
											<input type="text" id="user_name" class="form-control" placeholder="이름을 입력해주세요" name="user_name">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="form-group">
											<button type="button" class="btn btn-primary float-xs-right" onclick="goPopup();">주소검색</button>
										</div>
									</div>
								</div>
							<div id="svc-area-group">
								<div class="form-group svc-area" style="margin-bottom:0">
									<label>활동지역을 선택해주세요</label>
									<select class="form-control" onchange="getDetailSgg(this);">
										<option value="00">전국</option>
										<% for(SggDTO sDTO : sList){ %>
										<option value=<%=sDTO.getSggCode()%>><%=sDTO.getSggName() %></option>
										<%}%>	
									</select>
									<div class="detail-checkboxes row" style="margin-top:1em">
										<div class="col-xs-4">세부지역 없음</div>
										<input type="checkbox" name="sgg_code" class="sgg-detail" value="00" checked hidden="hidden">
									</div>
									<div class="text-xs-right">
										<button type="button" class="btn btn-danger btn-sm" onclick="delArea(this);">
											<i class="icon-cross2"></i> 지역 삭제
										</button>
									</div>
	
								</div>
							</div>
							<div class="form-actions text-xs-right">
							<button type="button" class="btn btn-primary btn-sm" onclick="addArea();">
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
    <script>
    var svcAreaForm = document.getElementById("svc-area-group").innerHTML;
   	
    // 상세 시군구코드 구하기
    function getDetailSgg(elem){
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
  </body>
</html>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="poly.dto.TunerDTO"%>
<%@page import="poly.dto.UserDTO"%>
<%@page import="poly.dto.SggDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="../user/session.jsp" %>

<%

	UserDTO uDTO = (UserDTO)request.getAttribute("uDTO");

%>

<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>
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
<meta charset="UTF-8">
<title>정보수정</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="../header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="../menu.jsp" %>
	
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
				<h6 class="card-subtitle line-on-side text-muted text-xs-center font-small-3 pt-2"><span>조율사 정보수정</span></h6>
			</div>
			<div class="card-body collapse in">
					<div class="card-block">
						<form data-toggle="validator" role="form" name="form" class="form" action="/user/DoUserInfoEdit.do" method="post" autocomplete="off" onsubmit="doSubmit();">
							<div class="form-body">
								<h4 class="form-section"><i class="icon-head"></i> 기본 정보</h4>
								<div class="row">
								<div class="col-xs-12 red" style="margin-bottom:1em">*표시된 항목은 필수 입력사항입니다.</div>
									<div class="col-md-12">
										
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="user_nick">닉네임<span class="red">*</span></label>
											<input value="<%=uDTO.getUser_nick()%>" type="text" id="projectinput2" pattern="^[가-힣A-z0-9]{1,}$" class="form-control" placeholder="닉네임을 입력해주세요" name="user_nick" required data-pattern-error="한글, 영문 및 숫자만 가능합니다">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="email">이메일<span class="red">*</span></label>
											<input value="<%=uDTO.getEmail()%>" type="text" id="email" class="form-control" placeholder="이메일을 입력해주세요" name="email" pattern="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$" data-remote="/user/EditDupCheck.do" data-remote-error="이미 사용중인 이메일입니다"  required data-error="유효한 이메일 주소가 아닙니다">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="success-msg">사용 가능한 이메일입니다.</div>
											<div class="help-block with-errors"></div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="user_tel">전화번호<span class="red">*</span></label>
											<input value="<%=uDTO.getUser_tel()%>" type="text" id="user_tel" pattern="^[0-9]{9,}$" class="form-control" placeholder="전화번호를 입력해주세요" name="user_tel" required data-pattern-error="유효한 전화번호가 아닙니다">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
								</div>
								<div class="row">
								</div>
							</div><!-- end of form body -->
							<div class="form-actions text-center">
							<button type="submit" class="btn btn-primary">
									<i class="icon-check2 d-flex"></i> 정보수정
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
	
	
	
	
	<!-- footer.jsp 경로설정 -->
	<%@include file="../footer.jsp" %>
	<script src="/resources/js/validator.js" type="text/javascript"></script>
    <script>
    var svcAreaForm = document.getElementById("svc-area-group").innerHTML;
   	
    function doSubmit(){
		$("#tuner_exp").val(document.getElementById('temp_exp').value.replace(/\n/g, "<br>"));
		$("#tuner_comment").val($("#tuner_comment").val().replace(/<br>/g, " "));
		form.submit();
	}
    
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
   	
   	function getDetailSggWithChecks(elem, list){
		var query = {sidoCode : elem.value};
		console.log("sidocode : " + elem.value);
		$.ajax({
			url:"/addr/GetSgg.do",
			type:"post",
			data:query,
			success:function(data){
				var detailCheckboxes = elem.parentElement.getElementsByClassName('detail-checkboxes')[0]
				detailCheckboxes.innerHTML = data;
				
				var checkboxes = detailCheckboxes.querySelectorAll('input')
		   		console.log("checkboxes");
		   		console.log(checkboxes[0].value);
		   		for(var i=0; i<checkboxes.length; i++){
		   			if(list.includes(parseInt(checkboxes[i].value))){
		   				console.log(checkboxes[i].value)
		   				checkboxes[i].click();
		   			}
		   		}
			}
		});
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
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="../user/session.jsp" %>
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
<title>페이지 타이틀</title>
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
        <div class="row">
       <div class="col-xs-12 col-sm-8 offset-sm-2"> 
<div class="card">
			<div class="card-header">
			<h4 class="card-title">피아노 추가</h4>
			</div>
			<div class="card-body collapse in">
					<div class="card-block">
						<form data-toggle="validator" id="form" enctype="multipart/form-data" role="form" name="form" class="form" action="/piano/DoAddPiano.do" method="post" autocomplete="off" onsubmit="doSubmit();">
							<div class="form-body">
								<div class="row">
								<div class="col-xs-12 red" style="margin-bottom:1em">*표시된 항목은 필수 입력사항입니다.</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="piano_name" class="control-label">피아노 이름<span class="red">*</span></label>
											<input type="text" id="piano_name" maxlength="30" pattern="^[가-힣A-Za-z1-9]{1,}[1-9가-힣A-Za-z\s]*" data-pattern-error="영문, 한글, 숫자 및 띄어쓰기만 가능합니다(띄어쓰기로는 시작 불가능)" class="form-control" placeholder="피아노의 이름을 지어주세요" name="piano_name" required >
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>										
										</div>
										
									</div>
									
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="brand">피아노 브랜드<span class="red">*</span></label>
											<input type="text" id="brand" class="form-control" maxlength="15" pattern="^[가-힣A-Za-z1-9]{1,}[1-9가-힣A-Za-z\s]*" data-pattern-error="영문, 한글, 숫자 및 띄어쓰기만 가능합니다(띄어쓰기로 시작 불가능)" placeholder="예) 삼익, 영창, 야마하" name="brand" required>
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="player_type">피아노 용도<span class="red">*</span></label>
											<input type="text" id="player_type" class="form-control" maxlength="15" pattern="^[가-힣A-Za-z1-9]{1,}[1-9가-힣A-Za-z\s]*" data-pattern-error="영문, 한글, 숫자 및 띄어쓰기만 가능합니다(띄어쓰기로 시작 불가능)" placeholder="예)가정용, 전공자용, 학원용, 공연용 등" name="player_type" required>
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="piano_desc">피아노 설명</label>
											<input type="text" id="piano_desc" class="form-control" maxlength="100" pattern="^[가-힣A-Za-z1-9]{1,}[1-9가-힣A-Za-z\s]*" data-pattern-error="영문, 한글, 숫자 및 띄어쓰기만 가능합니다(띄어쓰기로 시작 불가능)" placeholder="피아노의 정보를 간략히 적어주세요(상세위치, 모델 등)" name="piano_desc">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="serial">피아노 일련번호</label><a><i class="icon-help-circled" style="font-size:1.2rem;margin-left:0.5rem;color:rgb(31, 189, 0)" data-toggle="modal" data-target="#serial_help"></i></a>
											<!-- modal -->
											<div class="modal fade text-xs-left" id="serial_help" tabindex="-1" role="dialog" aria-labelledby="serialHelpLabel" style="display: none;" aria-hidden="true">
											  <div class="modal-dialog" role="document">
												<div class="modal-content">
												  <div class="modal-header">
													<button type="button" class="close" data-dismiss="modal" aria-label="Close">
													  <span aria-hidden="true">×</span>
													</button>
													<h4 class="modal-title" id="serialHelpLabel">피아노 일련번호 예시</h4>
												  </div>
												  <div class="modal-body">
													<img alt="피아노 일련번호 예시" src="/resources/images/serial_help.png" style="max-width:100%;max-height:100%">
												  </div>
												  <div class="modal-footer">
													<button type="button" class="btn grey btn-outline-secondary" data-dismiss="modal">닫기</button>
												  </div>
												</div>
											  </div>
											</div>
											<!-- /modal -->
											<input type="text" id="serial" pattern="^[A-Za-z1-9]*" class="form-control" data-pattern-error="영문 및 숫자만 입력 가능합니다" placeholder="피아노 스케일(덮개를 열면 보이는 철재 구조물)에 적인 일련번호를 적어주세요" name="serial">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group">
											<label for="last_tuned_date">마지막 조율 날짜</label>
											<input type="date" id="last_tuned_date" class="form-control" name="last_tuned_date" data-toggle="tooltip" data-trigger="hover" data-placement="right" data-title="정확할 필요는 없습니다" data-original-title="" title="">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label>피아노 타입</label><a><i class="icon-help-circled" style="font-size:1.2rem;margin-left:0.5rem;color:rgb(31, 189, 0)" data-toggle="modal" data-target="#type_help"></i></a>
											<!-- modal -->
											<div class="modal fade text-xs-left" id="type_help" tabindex="-1" role="dialog" aria-labelledby="typeHelpLabel" style="display: none;" aria-hidden="true">
											  <div class="modal-dialog" role="document">
												<div class="modal-content">
												  <div class="modal-header">
													<button type="button" class="close" data-dismiss="modal" aria-label="Close">
													  <span aria-hidden="true">×</span>
													</button>
													<h4 class="modal-title" id="typeHelpLabel">피아노 타입 예시</h4>
												  </div>
												  <div class="modal-body">
													<img alt="피아노 일련번호 예시" src="/resources/images/type_help.png" style="max-width:100%;max-height:100%">
												  </div>
												  <div class="modal-footer">
													<button type="button" class="btn grey btn-outline-secondary" data-dismiss="modal">닫기</button>
												  </div>
												</div>
											  </div>
											</div>
											<!-- /modal -->
											<div class="input-group">
												<label class="display-inline-block custom-control custom-radio ml-1">
													<input type="radio" name="piano_type" value="0" checked="checked" class="custom-control-input">
													<span class="custom-control-indicator"></span>
													<span class="custom-control-description ml-0">업라이트</span>
												</label>
												<label class="display-inline-block custom-control custom-radio">
													<input type="radio" name="piano_type" value="1" class="custom-control-input">
													<span class="custom-control-indicator"></span>
													<span class="custom-control-description ml-0">그랜드</span>
												</label>
											</div>
										</div>
										
									</div>
									<div class="col-xs-12">
									<div class="form-group">
										<label>피아노 사진 </label>
										<label id="piano_image" class="file center-block">
											<input type="file" id="piano_img" name="piano_img" accept=".png,.gif,.jpg,.jpeg">
											<span class="file-custom"></span>
										</label>
									</div>
								</div>
								</div>
								<div class="form-group has-feedback" data-toggle="tooltip" data-placement="top" data-original-title="피아노 위치에 따라 주변 조율사에게 노출됩니다" onclick="goPopup();">
									<label for="addr">피아노 주소<span class="red">*</span></label>
									<div class="input-group">
										<input type="text" name="addr" id="addr" class="form-control" placeholder="주소를 검색해주세요" required  data-error="필수 입력사항입니다">
										<div class="input-group-btn"><button type="button" id="addrButton" class="btn btn-primary float-xs-right">주소검색</button></div>
									</div>
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>
								
								<input type="text" name="sgg_code" id="sgg_code" hidden="hidden">
								<input type="text" name="sido_name" id="sido_name" hidden="hidden">
								<input type="text" name="sgg_name" id="sgg_name" hidden="hidden">
								<input type="text" name="emd_name" id="emd_name" hidden="hidden">
								<input type="text" name="li_name" id="li_name" hidden="hidden">
								<input type="text" name="x_pos" id="x_pos" hidden="hidden">
								<input type="text" name="y_pos" id="y_pos" hidden="hidden">
							</div><!-- end of form body -->
							<div class="form-actions text-center">
							<button type="submit" class="btn btn-primary">
									<i class="icon-check2 d-flex"></i> 등록
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
</div>
</section>
        </div>
      </div>
    </div>
	
	
	
	
	<!-- footer.jsp 경로설정 -->
	<%@include file="../footer.jsp" %>
	<script src="/resources/js/validator.js" type="text/javascript"></script>
    <script>
    window.onload = function(){
    	var tomorrow = new Date();
    	tomorrow.setDate(tomorrow.getDate());
    	
    	document.getElementById("last_tuned_date").setAttribute('max', tomorrow.toISOString().split('T')[0]);
    	
    }
    
    
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
			document.form.sgg_code.value = admCd;
			$('#addr').attr("readonly", "readonly");
			$("#addr").focusout();
		}
	</script>

</body>
</html>
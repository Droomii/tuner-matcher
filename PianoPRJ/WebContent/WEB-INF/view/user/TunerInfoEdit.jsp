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

	List<SggDTO> sList = (List<SggDTO>)request.getAttribute("sList");
	UserDTO uDTO = (UserDTO)request.getAttribute("uDTO");
	TunerDTO tDTO = (TunerDTO)request.getAttribute("tDTO");
	Map<String, ArrayList<String>> sggDTOList = (Map<String, ArrayList<String>>)request.getAttribute("sggDTOList");
	String tuner_level = tDTO.getTuner_level();
	Set<String> sggKeys = sggDTOList.keySet();

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
<title>조율사 정보수정</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="../header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="../menu.jsp" %>
	
	<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-header row">
        <h4 class="card-title">조율사 정보수정</h4>
        </div>
        <div class="content-body"><section class="container">
    <div class="col-md-8 offset-md-2 col-xs-12 box-shadow-2 p-0">
		<div class="card border-grey border-lighten-3 px-2 py-2 m-0">
			<div class="card-header no-border">
				<div class="card-title text-xs-center">
					<img src="/resources/app-assets/images/logo/logo.png" alt="branding logo">
				</div>
				<h6 class="card-subtitle line-on-side text-muted text-xs-center font-small-3 pt-2"><span>조율사 정보수정</span></h6>
			</div>
			<div class="card-body collapse in">
					<div class="card-block">
						<form data-toggle="validator" id="regForm" enctype="multipart/form-data" role="form" name="form" class="form" action="/user/ADoTunerInfoEdit.do" method="post" autocomplete="off">
							<input value="<%=uDTO.getUser_seq()%>" name="user_seq" hidden>
							<div class="form-body">
								<h4 class="form-section"><i class="icon-head"></i> 기본 정보</h4>
								<div class="row">
								<div class="col-xs-12 red" style="margin-bottom:1em">*표시된 항목은 필수 입력사항입니다.</div>
									<div class="col-md-12">
										
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="user_nick">닉네임<span class="red">*</span></label>
											<input value="<%=CmmUtil.nvl(uDTO.getUser_nick(), true)%>" type="text" id="projectinput2" pattern="^[가-힣A-z][가-힣A-z0-9]{1,}$" maxlength="7" class="form-control" placeholder="닉네임을 입력해주세요" name="user_nick" required data-pattern-error="한글, 영문 및 숫자만 가능합니다(숫자로 시작 불가)">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="email">이메일<span class="red">*</span></label>
											<input value="<%=CmmUtil.nvl(uDTO.getEmail(), true)%>" type="text" id="email" class="form-control" maxlength="45" placeholder="이메일을 입력해주세요" name="email" pattern="^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$"  data-remote="/user/EditDupCheck.do?user_seq=<%=uDTO.getUser_seq() %>" data-remote-error="이미 사용중인 이메일입니다"  required data-error="유효한 이메일 주소가 아닙니다">
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="success-msg">사용 가능한 이메일입니다.</div>
											<div class="help-block with-errors"></div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group has-feedback">
											<label for="user_tel">전화번호<span class="red">*</span></label>
											<input value="<%=CmmUtil.nvl(uDTO.getUser_tel(), true)%>" type="text" id="user_tel" class="form-control" placeholder="전화번호를 입력해주세요" pattern="[^1-9][0-9]{1,2}-[0-9]{3,4}-[0-9]{4}" data-pattern-error="올바른 전화번호가 아닙니다." onKeyUp="phoneNumberFormat(this);"name="user_tel" required>
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											<div class="help-block with-errors"></div>
										</div>
									</div>
								</div>
								
								
								<div class="row">
								</div>

								<!--조율사 경력 정보-->
								<h4 class="form-section"><i class="icon-clipboard4"></i> 조율사 정보</h4>

								<div class="form-group">
									<label>자격증 등급</label>
									<div class="input-group">
										<label class="display-inline-block custom-control custom-radio ml-1">
											<input type="radio" name="tuner_level" value="0" <%=tuner_level.equals("0") ? "checked=\"checked\"" : "" %> class="custom-control-input">
											<span class="custom-control-indicator"></span>
											<span class="custom-control-description ml-0">기능사</span>
										</label>
										<label class="display-inline-block custom-control custom-radio">
											<input type="radio" name="tuner_level" value="1" <%=tuner_level.equals("1") ? "checked=\"checked\"" : "" %> class="custom-control-input">
											<span class="custom-control-indicator"></span>
											<span class="custom-control-description ml-0">산업기사</span>
										</label>
									</div>
								</div>
								<div class="form-group has-feedback">
									<label for="sosok">소속<span class="red">*</span></label>
									<input value="<%=CmmUtil.nvl(tDTO.getAffiliation(), true)%>" type="text" id="sosok" name="affiliation" class="form-control" maxlength="30" placeholder="예) ㅇㅇ피아노, ㅇㅇ대학교, 프리랜서 등" required data-error="필수 입력사항입니다">
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>

								<div class="form-group">
									<label for="tuner_comment">한줄 소개</label>
									<textarea id="tuner_comment" onchange="checkBytes(this, 200);" onKeyUp="checkBytes(this, 200);" rows="2" class="form-control square" name="tuner_comment" placeholder="본인에 대한 소개를 한 줄로 작성해주세요"><%=CmmUtil.nvl(tDTO.getTuner_comment(), true)%></textarea>
									<div class="float-xs-right"><span class="byte">0</span>/200 bytes</div>
								</div>
								
								<div class="form-group">
								<input hidden="hidden" id="tuner_exp" name="tuner_exp">
									<label for="temp_exp">이력</label>
									<textarea id="temp_exp" rows="20" onchange="checkBytes(this, 4000);" onKeyUp="checkBytes(this, 4000);" class="form-control square" name="temp_exp" placeholder="본인의 이력을 작성해주세요"><%=CmmUtil.nvl(tDTO.getTuner_exp()).replaceAll("<br>", "\n")%></textarea>
									<div class="float-xs-right"><span class="byte">0</span>/4000 bytes</div>
								</div>
								<%if(!user_state.equals("1")){ %>
								<div class="form-group has-feedback">
									<label>자격증 사진</label>
									<label id="projectinput7" class="file center-block">
										<input type="file" id="cert_img" name="cert_img" accept=".png,.gif,.jpg,.jpeg">
										<span class="file-custom"></span>
									</label>
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>
								<%} %>
								<div class="form-group">
									<label>프로필 사진</label>
									<label id="img_label"  class="file center-block">
										<input type="file" name="profile_img" id="profile_img" accept=".png,.gif,.jpg,.jpeg">
										<span class="file-custom"></span>
									</label>
								</div>
								<h4 class="form-section"><i class="icon-clipboard4"></i> 지역 정보</h4>
								<div class="form-group has-feedback" data-toggle="tooltip" data-placement="top" data-original-title="근무지 기준으로 가까운 조율 요청부터 표시됩니다." onclick="goPopup();">
									<label for="addr">근무지 주소<span class="red">*</span></label>
									<div class="input-group">
										<input value="<%=CmmUtil.revertXSS(CmmUtil.nvl(tDTO.getAddr())) %>" type="text" name="addr" id="addr" class="form-control" placeholder="주소를 검색해주세요" required data-error="필수 입력사항입니다">
										<div class="input-group-btn"><button type="button" class="btn btn-primary float-xs-right">주소검색</button></div>
									</div>
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>
								<input value="<%=CmmUtil.nvl(tDTO.getSido_name()) %>" type="text" name="sido_name" id="sido_name" hidden="hidden">
								<input value="<%=CmmUtil.nvl(tDTO.getSgg_name()) %>" type="text" name="sgg_name" id="sgg_name" hidden="hidden">
								<input value="<%=CmmUtil.nvl(tDTO.getEmd_name()) %>" type="text" name="emd_name" id="emd_name" hidden="hidden">
								<input value="<%=CmmUtil.nvl(tDTO.getLi_name()) %>" type="text" name="li_name" id="li_name" hidden="hidden">
								<input value="<%=CmmUtil.nvl(tDTO.getX_pos()) %>" type="text" name="x_pos" id="x_pos" hidden="hidden">
								<input value="<%=CmmUtil.nvl(tDTO.getY_pos()) %>" type="text" name="y_pos" id="y_pos" hidden="hidden">
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
	<script src="/js/bytechecker.js" type="text/javascript"></script>
	<script>
    $("#password").on('keyup', function(){
    	if($("#password").val()!=""){
    		$("#verify_passwd").attr('required', 'required');
    	}else{
    		$("#verify_passwd").removeAttr('required')
    	}
    	$("#verify_passwd").focusout();
    })
	
	
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
   	
    $('#regForm').validator().on('submit', function (e) {
  	  if (e.isDefaultPrevented()) {
  		  alert('필수항목을 입력해주세요')
  	  } else {
  		var arr = [];
 	    	$(".sgg-detail:checked").each(function () {
 	    	    arr.push($(this).val());
 	    	});
 	    	if(arr.length==0){
 	    		alert('최소 하나의 활동지역은 선택해야 합니다.');
 	    		e.preventDefault();
 	    		return;
 	    	}
 	    $("#tuner_exp").val(document.getElementById('temp_exp').value.trim().replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>"));
  		$("#tuner_comment").val($("#tuner_comment").val().trim());
  	  }
  	})
    
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
   		if(document.getElementsByClassName('sido-all').length>0){
			alert("전국으로 설정해둔 지역이 있습니다");
			return;
		}
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
   	var sggKeys = <%=sggKeys%>;
   	var sggDTOList = <%=sggDTOList.toString().replaceAll("=", ":")%>
   	
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
   	
   	window.onload = function(){
   		for(var i=0; i<sggKeys.length; i++){
   			
	   		var svcArea = document.getElementsByClassName('svc-area');
	   		svcArea = svcArea[svcArea.length-1];
	   		var dropdown =svcArea.getElementsByClassName('form-control')[0];
	   		var optLen = dropdown.options.length;
	   		console.log("optlen = " + optLen)
	   		console.log("sggkeys : " +sggKeys[i])
	   		for (var k=0; k<optLen; k++){
	   			console.log("into for")
	   		    if (dropdown.options[k].value == sggKeys[i]){
	   		        dropdown.options[k].selected = true;
	   		     
	   		     	getDetailSggWithChecks(dropdown, sggDTOList[sggKeys[i]]);
	   		     	if(i!=sggKeys.length-1){
	   		     		addArea();
	   		     	}
	   		        break;
	   		    }
	   		}
   		}
   		checkBytes(document.getElementById('tuner_comment'), 200)
   		checkBytes(document.getElementById('temp_exp'), 4000)
   		
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
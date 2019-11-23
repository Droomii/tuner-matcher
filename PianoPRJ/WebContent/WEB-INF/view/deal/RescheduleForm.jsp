<%@page import="poly.dto.DealDTO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="poly.dto.ReqDTO"%>
<%@page import="poly.dto.PianoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/user/session.jsp" %>

<%
	String userTypeName = user_type.equals("0") ? "User" : "Tuner";
	ReqDTO rDTO = (ReqDTO)request.getAttribute("rDTO");
	Map<String, List<String>> prefDates = (LinkedHashMap<String, List<String>>)request.getAttribute("prefDates");
	String[] weekdays = {"일", "월", "화", "수", "목", "금", "토"}; 
	
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>
<style>
	.text-bold-700{
		background-color:rgb(220,220,220);
		padding: 0.3rem;
	}
	.desc{
		padding: 0.3rem;
	}
	.has-error, .has-danger{
    		color:crimson;
    		}
   	.success-msg{
   		color:#3c763d;
   		display:none;
   		line-height:1.8;
</style>


<meta charset="UTF-8">

<title>일정 변경 요청</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="/WEB-INF/view/menu.jsp" %>
	<div class="app-content content container-fluid">
	<div class="content-body"><!-- Basic example section start -->
<!-- Header footer section start -->
<section id="header-footer">
		<div class="row">
					<div class="col-xs-12 col-lg-6 offset-lg-3">
					<div class="card">
				<div class="card-header">
					<h4 class="card-title" id="basic-layout-form">일정 변경 요청</h4>
				</div>
				<div class="card-body collapse in">
					<div class="card-block">
					<form onsubmit="return submitReschedule();" autocomplete="off" data-toggle="validator" role="form" name="regForm" class="form" action="/deal/PlaceBid.do" method="post" autocomplete="off">
							<input hidden="hidden" id="diagnosis_content" name="diagnosis_content">
							<input value="<%=rDTO.getReq_seq() %>" name="req_seq" hidden>
							<div id="date-group has-feedback">
									<div class="form-group" style="margin-bottom:0" >
									<label>희망일시<span class="red">*</span></label>
									<div>
									<%
									String ss = null;
									for(Iterator<String> keyIter = prefDates.keySet().iterator();keyIter.hasNext();){
										ss = keyIter.next();
										List<String> hours = prefDates.get(ss);
										Date d = new SimpleDateFormat("yyyy-M-dd").parse(ss);
										Calendar c = Calendar.getInstance();
										c.setTime(d);
										int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
									%>
									<div class="card-text full-date text-bold-600"><%=ss %>(<%=weekdays[dayOfWeek-1] %>)</div>
									<div class="row">
									<%for(String hour : hours){ %>
										<div class="col-xs-3">
										<label class="checkbox-inline"><input type="radio" name="possible_date" class="pref-hour" value="<%=ss %>h<%=hour%>"><%=hour %>:00</label>
										</div>
									<%} %>
									</div>
									<%if(keyIter.hasNext()){ %><hr style="margin:0 0 0.5rem 0"><%} %>
									<%} %>
									</div>
									</div>
								<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
								<div class="help-block with-errors"></div>
								</div>
							<div class="form-body">
								<div class="form-group has-feedback">
									<label for="temp_content">소견</label>
									<textarea id="temp_content" rows="10" class="form-control" placeholder="소견을 입력해주세요(가격 책정 이유 등 상세히)" required></textarea>
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>
															
							</div>
							
							
							<div class="card-footer text-xs-center">
								<a href="#" class="button btn btn-info">뒤로 </a>
								<button type="submit" class="button btn btn-success">변경 요청</button>
							</div>
						</form>
					</div>
				</div>
			</div>
					</div>
			</div>
</section>
<!-- Header footer section end -->

        </div>
	</div>
	<!-- footer.jsp 경로설정 -->
	<%@include file="/WEB-INF/view/footer.jsp" %>
	
	
	<script>
	<%if(user_type.equals("2") || user_seq.equals(rDTO.getUser_seq())){%>
	function deleteConfirm(){
		if(confirm("요청서를 삭제하시겠습니까?")){
			var form = document.req_action;
			form.action = "/req/DeleteReq.do";
			form.submit();
		}
	}
	
	function editReq(){
		var form = document.req_action;
		form.action = "/req/EditReq.do";
		form.submit();
	}
	
	<%}%>
	<%if(user_type.equals("1")){%>
	function submitBid(){
		var checklen = document.querySelectorAll('.pref-hour:checked').length;
		if(checklen==0){
			alert("최소 하나의 희망일시는 선택해야 합니다.");
			return false;
		}
		if(getPrice()){
			alert("항목 및 총 견적가는 0원일 수 없습니다.");
			return false;
		}
		if(!confirm("입찰하시겠습니까? 한번 등록하면 수정이 불가능합니다.")){
			return false;
		}
		
		$("#diagnosis_content").val(document.getElementById('temp_content').value.replace(/\n/g, "<br>"));
	}
	function totalPrice(total, elem){
		return total+(parseInt(elem.value) || 0);	
	}
	
	
	
	function getPrice(){
		var prices = document.getElementsByClassName("price");
	    var anyChecked = false;
	    for(var i = 0; i<prices.length; i++){
	    	var ea = prices[i].parentElement.parentElement.getElementsByClassName("ea")[0].value
	    	try{
	    		var checked = prices[i].parentElement.parentElement.getElementsByClassName('checkbox')[0].checked;
	    		anyChecked = anyChecked || checked;
	    	}catch(err){
	    		var checked = true;
	    		anyChecked = anyChecked || checked;
	    	}
	    	if(checked){
		    	ea = parseInt(ea) || 0;
		    	var val = (parseInt(prices[i].value) || 0)
		    	val = val * ea
		    	if(val==0){
		    		return true
		    	}
		    	
				}
	    }
		return !anyChecked;
	}
	function updatePrice(){
		var prices = document.getElementsByClassName("price");
	    var total = 0;
	    for(var i = 0; i<prices.length; i++){
	    	var ea = prices[i].parentElement.parentElement.getElementsByClassName("ea")[0].value
	    	try{
	    		var checked = prices[i].parentElement.parentElement.getElementsByClassName('checkbox')[0].checked;	
	    	}catch(err){
	    		var checked = true;
	    	}
	    	if(checked){
		    	ea = parseInt(ea) || 0;
		    	var val = (parseInt(prices[i].value) || 0)
		    	val = val * ea
		    	total += val
				}
	    }
	    koreanTotal = numberToKorean(total)
	    total = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    $("#total").html(total);
	    $("#koreanTotal").html(koreanTotal=="" ? "0" : koreanTotal);
	}
	
	
	
	function numberToKorean(number){
	    var inputNumber  = number < 0 ? false : number;
	    var unitWords    = ['', '만', '억', '조', '경'];
	    var splitUnit    = 10000;
	    var splitCount   = unitWords.length;
	    var resultArray  = [];
	    var resultString = '';

	    for (var i = 0; i < splitCount; i++){
	         var unitResult = (inputNumber % Math.pow(splitUnit, i + 1)) / Math.pow(splitUnit, i);
	        unitResult = Math.floor(unitResult);
	        if (unitResult > 0){
	            resultArray[i] = unitResult;
	        }
	    }

	    for (var i = 0; i < resultArray.length; i++){
	        if(!resultArray[i]) continue;
	        resultString = String(resultArray[i]) + unitWords[i] + resultString;
	    }

	    return resultString;
	}
	
	$(function() {
		  $(".price").on("keyup", function(event) {
			    var value = $(this).val();
			  	value = value.replace(/[^0-9]/g, "")
			    $(this).val(parseInt(value) || 0);
			    updatePrice();
			    
		  })
		});
	$(function() {
		  $(".ea").on("change", function(event) {
			    updatePrice();
		  })
		});
	
	$(function() {
		  $(".checkbox").on("change", function(event) {
			  var checkState = this.checked
			  var inputs = this.parentElement.parentElement.parentElement.querySelectorAll('input')
			  inputs[1].disabled = !checkState;
			  inputs[2].disabled = !checkState;
			  updatePrice();
		  })
		});
	<%}%>
	
	</script>
	<script src="/resources/js/validator.js" type="text/javascript"></script>
</body>
</html>
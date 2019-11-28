<%@page import="poly.util.Pagination"%>
<%@page import="java.util.ArrayList"%>
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
	PianoDTO pDTO = (PianoDTO)request.getAttribute("pDTO");
	String userTypeName = user_type.equals("0") ? "User" : "Tuner";
	String proc = CmmUtil.nvl((String)session.getAttribute("proc"));
	String back = proc.equals("public") ? "/req/" + userTypeName + "PublicReqList"
										:"/req/" + userTypeName + "PrivateReqList";
	ReqDTO rDTO = (ReqDTO)request.getAttribute("rDTO");
	Map<String, List<String>> prefDates = (LinkedHashMap<String, List<String>>)request.getAttribute("prefDates");
	List<DealDTO> dList = (List<DealDTO>)request.getAttribute("dList");
	if(dList==null){
		dList=new ArrayList<>();
	}
	String[] weekdays = {"일", "월", "화", "수", "목", "금", "토"}; 
	
	Pagination pg = (Pagination)request.getAttribute("pg");
	
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

	}
	.title{
		max-width: 40%;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    
	}
	
	.table {
	  display: table;
	}
	.table-row {
	  display: table-row;
	}
	.table-head-cell {
		display: table-cell;
		padding: 10px 20px 10px 20px;
		border-bottom : 2px solid rgb(200,200,200);
		border-top : 1px solid rgb(200,200,200);
	}
	.table-cell {
	  display: table-cell;
	  padding: 10px 20px 10px 20px;
	  border-bottom: 1px solid lightgray;
	}
	.item:hover{
		background-color:rgb(240,240,240);
	}
</style>


<meta charset="UTF-8">

<title>요청 정보</title>
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
	<div class="row match-height">
		<div class="col-xs-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title">요청 정보</h4>
				</div>
				<div class="card-body">
					<div class="card-block">
						<h5 class="form-section text-bold-600">피아노 정보</h5>
						<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">브랜드</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getBrand(), true) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">일련번호</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getSerial(), true) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">피아노 타입</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPiano_type()).equals("0")?"업라이트" : "그랜드"%></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">용도</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPlayer_type(), true) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">마지막 조율 날짜</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class=" border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getLast_tuned_date()).equals("") ? "모름" : CmmUtil.nvl(pDTO.getLast_tuned_date()).substring(0,10)%></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">주소</div></div>
									<%if(user_type.equals("1")){ %>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc"><%=CmmUtil.nvl(rDTO.getSido_name()) %> <%=CmmUtil.nvl(rDTO.getSgg_name()) %></div>
									<%}else{ %>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getAddr()) %></div>
									<%} %>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700"><span style="margin:auto">사진</span></div>
									<%if(pDTO.getPiano_photo_dir()!=null){ %>
									<div style="border-color:rgb(150,150,150);padding:0" class="border col-xs-9 desc">
									<img class="img-fluid my-0" src="/img/piano/<%=pDTO.getPiano_seq() %>/image.<%=pDTO.getPiano_photo_dir() %>" alt="Card image cap">
									<%}else{ %>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc">사진 없음</div>
									
									<%} %>
									</div>
									
								</div>
							</div>
						
					</div>
					
					<div class="card-block">
						<h5 class="form-section text-bold-600">요청서 정보</h5>
						<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">요청사항</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(rDTO.getReq_content()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700"><span style="margin:auto">참고사진</span></div>
									<%if(rDTO.getPhoto_dir()!=null){ %>
									<div style="border-color:rgb(150,150,150);padding:0" class="border col-xs-9 desc">
									<img class="img-fluid my-0" src="/img/req/<%=rDTO.getReq_seq() %>/image.<%=rDTO.getPhoto_dir() %>" alt="Card image cap"></div>
									<%}else{ %>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc">사진 없음</div>
									<%} %>
									
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">가능일시</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc">
									<%
									String s = null;
									for(Iterator<String> keyIter = prefDates.keySet().iterator();keyIter.hasNext();){
										s = keyIter.next();
										List<String> hours = prefDates.get(s);
										Date d = new SimpleDateFormat("yyyy-M-dd").parse(s);
										Calendar c = Calendar.getInstance();
										c.setTime(d);
										int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
									%>
									<%=s %>(<%=weekdays[dayOfWeek-1] %>) : <br>
									&nbsp;&nbsp;- <%=String.join(":00, ", hours)%>:00<br><%if(keyIter.hasNext()){ %><br><%} %>
									<%} %>
									</div>
								</div>
							</div>
						
					</div>
					<form method="post" hidden="hidden" name="req_action">
					<input value="<%=rDTO.getReq_seq() %>" name="req_seq">
				</form>
				<div class="card-footer text-xs-center">
					<span>
					<%if(user_type.equals("0")){ %>
						<a href="<%=back %>.do" class="button btn btn-info">뒤로 </a>
						<%if(dList.size()==0){ %>
						<button onclick="editReq()" class="button btn btn-success">수정 </button>
						<%} %>
						<button onclick="deleteConfirm()" class="button btn btn-danger">삭제</button>
					<%}else{ %>
						<a href="<%=back %>.do" class="button btn btn-info">뒤로 </a>
					<%} %>
					</span>
				</div>
				</div>
				
			</div>
		</div>
	</div>
	<%if(rDTO.getPrivate_seq()==null && user_type.equals("0")) {
		
	%>
	<div class="row">
		<div class="col-xs-12 col-lg-6 offset-lg-3">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title" id="basic-layout-form">입찰 현황</h4>
				</div>
	            <div class="card-body collapse in">
	                <div class="card-block card-dashboard" id="bid-container">
                        <div class="table">
                            <div class="table-row">
                                    <div class="table-head-cell"><strong>조율사 성명</strong></div>
                                    <div class="table-head-cell"><strong>견적가</strong></div>
                                    <div class="table-head-cell"><strong>희망일시</strong></div>
                            </div>
                            
                            <%for(DealDTO dDTO : dList){ %>
                            <div class="table-row item" role="button" onclick="location.href='/req/ReqBidDetail.do?deal_seq=<%=dDTO.getDeal_seq()%>'">
                                    <div class="table-cell"><%=CmmUtil.nvl(dDTO.getTuner_name(), true)%></div>
                                    <div class="table-cell"><%=CmmUtil.nvl(dDTO.getTotal()) %>원</div>
                                    <div class="table-cell"><%=CmmUtil.nvl(dDTO.getFullDate()) %></div>
                            </div>
                            <%} %>
                        </div>
                        <%if(dList.size()==0) {%>
                            <div class="card-text text-xs-center">- 아무도 입찰하지 않았습니다 - </div>
                            <%}else{ %>
	                        <%@include file="/WEB-INF/view/Pagination-ajax.jsp"%>
	                        <%} %>
                	</div>
	                
	            </div>
			</div>
		</div>
	</div>
	<%}else if(user_type.equals("1")){%>
		<div class="row">
					<div class="col-xs-12 col-lg-6 offset-lg-3">
					<div class="card">
				<div class="card-header">
					<h4 class="card-title" id="basic-layout-form">견적서 작성</h4>
				</div>
				<div class="card-body collapse in">
					<div class="card-block">
					<form onsubmit="return submitBid();" autocomplete="off" data-toggle="validator" role="form" name="regForm" class="form" action="/deal/PlaceBid.do" method="post" autocomplete="off">
							<input hidden="hidden" id="diagnosis_content" name="diagnosis_content">
							<input value="<%=rDTO.getReq_seq() %>" name="req_seq" hidden>
							<input value="<%=proc.equals("public") ? "0" : "1" %>" name="deal_type" hidden>
							<div class="form-body">
								<div class="form-group has-feedback">
									<label for="temp_content">소견</label>
									<textarea onchange="checkBytes(this, 4000);" onKeyUp="checkBytes(this, 4000);" id="temp_content" rows="10" class="form-control" placeholder="소견을 입력해주세요(가격 책정 이유 등 상세히)" required></textarea>
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>
								<div class="form-group">
									<label for="req_content">서비스 견적</label>
									<table class="table mb-0" style="width:100%;">
			                            <thead class="bg-teal bg-lighten-4">
			                                <tr>
			                                    <th style="width:40%;text-align:center" colspan="2">항목</th>
			                                    <th style="text-align:center">수량</th>
			                                    <th style="text-align:center">가격</th>
			                                </tr>
			                            </thead>
			                            <tbody>
			                                <tr class="row">
			                                    <td style="width:40%;" colspan="2">
			                                    <label class="checkbox-inline mb-0"><input type="checkbox" class="checkbox" id="tune" checked> 조율</label>
			                                    </td>
			                                    <td><input type="number" min="1" value="1" id="projectinput2" class="form-control ea" name="tuning_ea" style="padding:0.1rem;width:3rem;"></td>
			                                    <td style="display:flex;justify-content:flex-end"><input type="text" maxlength="6" value="0" id="projectinput2" class="form-control price" name="tuning_price" style="width:5rem;padding:0.1rem;text-align:right;display:inline"> 원</td>
			                                </tr>
			                                <tr>
			                                    <td style="width:40%;" colspan="2">
			                                     <label class="checkbox-inline mb-0"><input type="checkbox" class="checkbox" id="regulation"> 조정</label>
			                                    </td>
			                                    <td><input disabled type="number" min="1" value="1" id="projectinput2" class="form-control ea" name="regul_ea" style="padding:0.1rem;width:3rem;"></td>
			                                    <td style="display:flex;justify-content:flex-end"><input disabled type="text" maxlength="6" value="0" id="projectinput2" class="form-control price" name="regul_price" style="width:5rem;padding:0.1rem;text-align:right;display:inline"> 원</td>
			                                </tr>
			                                <tr>
			                                    <td style="width:40%;" colspan="2">
			                                    <label class="checkbox-inline mb-0"><input type="checkbox" class="checkbox" id="voicing"> 정음</label>
			                                    </td>
			                                    <td><input disabled type="number" min="1" value="1" id="projectinput2" class="form-control ea" name="voicing_ea" style="padding:0.1rem;width:3rem;"></td>
			                                    <td style="display:flex;justify-content:flex-end"><input disabled type="text" maxlength="6" value="0" id="projectinput2" class="form-control price" name="voicing_price" style="width:5rem;padding:0.1rem;text-align:right;display:inline"> 원</td>
			                                </tr>
			                                <tr>
			                                    <td style="width:40%;" colspan="2">
			                                    <label class="checkbox-inline mb-0"><input type="checkbox" class="checkbox" id="transport"> 운반</label>
			                                    </td>
			                                    <td><input disabled type="number" min="1" value="1" id="projectinput2" class="form-control ea" name="transport_ea" style="padding:0.1rem;width:3rem;"></td>
			                                    <td style="display:flex;justify-content:flex-end"><input disabled type="text" maxlength="6" value="0" id="projectinput2" class="form-control price" name="transport_price" style="width:5rem;padding:0.1rem;text-align:right;display:inline"> 원</td>
			                                </tr>
			                                <tr>
			                                    <td style="width:40%;" colspan="2">
			                                    <label class="checkbox-inline mb-0"><input type="checkbox"  class="checkbox" id="repair"> 기타(수리, 부품 등)</label>
			                                    </td>
			                                    <td><input type="number" min="1" value="1" hidden disabled id="projectinput2" class="form-control ea" style="padding:0.1rem;width:3rem;"></td>
			                                    <td style="display:flex;justify-content:flex-end"><input type="text" disabled value="0" maxlength="7" id="projectinput2" class="form-control price" name="other_price" style="width:5rem;padding:0.1rem;text-align:right;display:inline"> 원</td>
			                                </tr>
			                                <tr>
			                                    <td colspan="5" style="text-align:right;background-color:rgb(179, 226, 255)">계 :&nbsp;<span id="total">0</span>원(<span id="koreanTotal">0</span>원)</td>
			                                </tr>

			                            </tbody>
			                        </table>
								</div>
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
							</div>
							
							
							<div class="card-footer text-xs-center">
								<a href="<%=back %>.do" class="button btn btn-info">뒤로 </a>
								<button type="submit" class="button btn btn-success">입찰하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
					</div>
			</div>
	<%} %>
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
		
		$("#diagnosis_content").val(document.getElementById('temp_content').value.trim().replace(/\n/g, "<br>"));
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
	<%}else{%>
	function gotoPage(el){
		var page = el.getAttribute('data-page');
		$.ajax({
			url : "GetReqBid.do",
			data : {page : page,
				req_seq : "<%=rDTO.getReq_seq()%>"},
			type : "post",
			success : function(data){
				$("#bid-container").html(data);
			}
			
		})
	}
	<%}%>
	
	</script>
	<script src="/resources/js/validator.js" type="text/javascript"></script>
	<script type="text/javascript" src="/js/bytechecker.js"></script>
</body>
</html>
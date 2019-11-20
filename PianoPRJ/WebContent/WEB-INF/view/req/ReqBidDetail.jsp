<%@page import="poly.util.FormatUtil"%>
<%@page import="poly.dto.UserDTO"%>
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
	ReqDTO rDTO = (ReqDTO)request.getAttribute("rDTO");
	DealDTO dDTO = (DealDTO)request.getAttribute("dDTO");	
	String back = (String)request.getAttribute("back");
	back = back==null ? "/deal/TunerBidList.do" : back;
	UserDTO uDTO = (UserDTO)request.getAttribute("uDTO");
	
	String tuner_tel = FormatUtil.phone(uDTO.getUser_tel());
	String tuner_name = uDTO.getUser_name();
	
	
	String[] weekdays = {"일", "월", "화", "수", "목", "금", "토"};
	
	String date = dDTO.getPossible_date();
	Date d = new SimpleDateFormat("yyyy-M-dd").parse(date.split("h")[0]);
	Calendar c = Calendar.getInstance();
	c.setTime(d);
	int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
	String weekday = weekdays[dayOfWeek-1];
	
	
	int itemLen = 0;
	Map<String, String> items = new LinkedHashMap<>();
	if(dDTO.getTuning_price()!= null){
		int eaPrice = Integer.parseInt(dDTO.getTuning_price()) * Integer.parseInt(dDTO.getTuning_ea()); 
		items.put("조율", dDTO.getTuning_ea()+","+ Integer.toString(eaPrice));
		itemLen++;
	}
	
	if(dDTO.getRegul_price()!= null){
		int eaPrice = Integer.parseInt(dDTO.getRegul_price()) * Integer.parseInt(dDTO.getRegul_ea()); 
		items.put("조정", dDTO.getRegul_ea()+","+ Integer.toString(eaPrice));
		itemLen++;
	}
	
	if(dDTO.getVoicing_price()!= null){
		int eaPrice = Integer.parseInt(dDTO.getVoicing_price()) * Integer.parseInt(dDTO.getVoicing_ea()); 
		items.put("정음", dDTO.getVoicing_ea()+","+ Integer.toString(eaPrice));
		itemLen++;
	}
	
	if(dDTO.getTransport_price()!= null){
		int eaPrice = Integer.parseInt(dDTO.getTransport_price()) * Integer.parseInt(dDTO.getTransport_ea()); 
		items.put("운반", dDTO.getTransport_ea()+","+ Integer.toString(eaPrice));
		itemLen++;
	}
	
	if(dDTO.getOther_price()!= null){
		int eaPrice = Integer.parseInt(dDTO.getOther_price()); 
		items.put("기타", "1,"+ Integer.toString(eaPrice));
		itemLen++;
	}
	
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
   	table, th, td{
   		border:2px solid rgb(150,150,150);
   	}
</style>


<meta charset="UTF-8">

<title>견적 정보</title>
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
						<h4 class="card-title" id="basic-layout-form">견적 정보</h4>
					</div>
		            <div class="card-body collapse in">
			            <div class="card-block">
							<h5 class="form-section text-bold-600">조율사 정보</h5>
							<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">성명</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 desc"><div style="margin:auto"><%=tuner_name %></div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">연락처</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 desc"><div style="margin:auto"><%=tuner_tel %></div></div>
								</div>
							</div>
						</div>
		                <div class="card-block">
						<h5 class="form-section text-bold-600">견적 정보</h5>
						<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
								<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">소견</div></div>
								<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(dDTO.getDiagnosis_content()) %></div>
							</div>
							<div class="row" style="display:flex;">
								<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">희망일시</div></div>
								<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=date.split("h")[0] %>(<%=weekday %>) <%=date.split("h")[1] %>:00</div>
							</div>
						</div>
					</div>
					<div class="card-block">
					<h5 class="form-section text-bold-600">가격</h5>
						<table class="table table-bordered" style="border:2px solid rgb(150,150,150);">
                        <thead>
                            <tr style="background-color:rgb(220,220,220);">
                                <th style="width:9rem;text-align:center;">거래번호</th>
                                <th style="text-align:center">품목</th>
                                <th style="width:8rem;text-align:center">수량</th>
                                <th style="width:10rem;text-align:center">가격</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%Iterator<String> itemKeys = items.keySet().iterator(); 
                        String itemKey = itemKeys.next();%>
                            <tr>
                                <th rowspan="<%=itemLen%>" style="vertical-align:middle;text-align:center"><%=dDTO.getDeal_seq() %></th>
                                <td><%=itemKey %></td>
                                <td style="text-align:center"><%=items.get(itemKey).split(",")[0] %></td>
                                <td style="text-align:right"><%=String.format("%,d", Integer.parseInt(items.get(itemKey).split(",")[1]))%> 원</td>
                            </tr>
                            <%while(itemKeys.hasNext()){ 
                            itemKey = itemKeys.next();%>
                            <tr>
                                <td><%=itemKey %></td>
                                <td style="text-align:center"><%=items.get(itemKey).split(",")[0] %></td>
                                <td style="text-align:right"><%=String.format("%,d", Integer.parseInt(items.get(itemKey).split(",")[1]))%> 원</td>
                            </tr>
                            <%} %>
                            <tr>
                                <th colspan="3" style="background-color:rgb(220,220,220);text-align:right">총합</th>
                                <th style="text-align:right"><%=dDTO.getTotal() %> 원</th>
                            </tr>
                        </tbody>
                    </table>
					</div>
		            </div>
		            <div class="card-footer text-xs-center">
					<span>
						<a href="<%=back %>" class="button btn btn-info">뒤로 </a>
					</span>
				</div>
				</div>
			</div>
		</div>
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
									<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getBrand()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">일련번호</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getSerial()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">피아노 타입</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPiano_type()).equals("0")?"업라이트" : "그랜드"%></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">용도</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPlayer_type()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">마지막 조율 날짜</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class=" border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getLast_tuned_date()).equals("") ? "모름" : CmmUtil.nvl(pDTO.getLast_tuned_date()).substring(0,10)%></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">주소</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc"><%=CmmUtil.nvl(rDTO.getSido_name()) %> <%=CmmUtil.nvl(rDTO.getSgg_name()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">사진</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc">asd</div>
									
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
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">참고사진</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getSerial()) %></div>
								</div>
							</div>
						
					</div>
				</div>
				<form method="post" hidden="hidden" name="req_action">
					<input value="<%=rDTO.getReq_seq() %>" name="req_seq">
				</form>
				<div class="card-footer text-xs-center">
					<span>
						<a href="<%=back %>" class="button btn btn-info">뒤로 </a>
					</span>
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
	function bidCancel(){
		if(confirm("입찰을 취소하시겠습니까?")){
			location.href="/deal/BidCancel.do?deal_seq=<%=dDTO.getDeal_seq()%>";
		}
	}
	</script>
	<script src="/resources/js/validator.js" type="text/javascript"></script>
</body>
</html>
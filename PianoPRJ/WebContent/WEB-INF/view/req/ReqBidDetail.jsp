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
   	
   	.checked{
   		color:orange;
   	}
   	
   	.title{
		max-width: 40%;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    
	}
	
	.table {
	  display: table;
	  border:1px solid rgb(150,150,150);
	}
	.table-row {
	  display: table-row;
	}
	.table-head-cell {
		display: table-cell;
		padding: 10px 20px 10px 20px;
		border-bottom : 1px solid rgb(200,200,200);
		border-top : 1px solid rgb(200,200,200);
	}
	.table-cell {
	  display: table-cell;
	  padding: 10px 20px 10px 20px;
	  border: 0.5px solid lightgray;
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
							<div>
							<h5 class="form-section text-bold-600 float-xs-left" >조율사 정보</h5>
							<button class="button btn btn-sm btn-info float-xs-right" data-toggle="modal" data-target="#tuner-detail">조율사 상세정보</button>
							<!-- modal -->
							<div id="modal-container"></div>
							<!-- /modal -->
						</div>
							<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">성명</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 desc"><div style="margin:auto"><%=CmmUtil.nvl(tuner_name, true) %></div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">연락처</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 desc"><div style="margin:auto"><%=CmmUtil.nvl(uDTO.getUser_tel(), true) %></div></div>
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
					<div>
					<div>
					<button class="button btn btn-sm btn-info float-xs-right" style="margin-bottom:0.2rem" data-toggle="modal" data-target="#market-price">시세 조회</button>
					<!-- market price modal -->
					<div class="modal fade text-xs-left" id="market-price" tabindex="-1" role="dialog" aria-labelledby="market-price-title" style="display: none;" aria-hidden="true">
					<div class="modal-dialog modal-lg" style="max-width:1200px"role="document">
										<div class="modal-content">
										  <div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											  <span aria-hidden="true">×</span>
											</button>
											<h4 class="modal-title" id="market-price-modal">시세 정보</h4>
										  </div>
										  <div class="modal-body">
											<div id="chartdiv" style="width:100%;height:600px"></div>
											<div class="text-xs-center">범례를 클릭하면 해당 항목을 끄고 켤 수 있습니다</div>
										  </div>
										  <div class="modal-footer">
											<button type="button" class="btn grey btn-outline-secondary" data-dismiss="modal">닫기</button>
										  </div>
										</div>
									  </div>
					</div>
					<!-- /market price modal -->
					</div>
						<div class="table mb-0" style="border-bottom:0">
                        <div class="table-row" style="background-color:rgb(220,220,220);font-weight:bold">
                                <div class="table-head-cell" style="text-align:center">품목</div>
                                <div class="table-head-cell" style="width:8rem;text-align:center">수량</div>
                                <div class="table-head-cell" style="width:10rem;text-align:center">가격</div>
                        </div>
                        <%Iterator<String> itemKeys = items.keySet().iterator(); 
                        String itemKey = itemKeys.next();%>
                            <div class="table-row">
                                <div class="table-cell"><%=itemKey %></div>
                                <div class="table-cell" style="text-align:center"><%=items.get(itemKey).split(",")[0] %></div>
                                <div class="table-cell" style="text-align:right"><%=String.format("%,d", Integer.parseInt(items.get(itemKey).split(",")[1]))%> 원</div>
                            </div>
                            <%while(itemKeys.hasNext()){ 
                            itemKey = itemKeys.next();%>
                            <div class="table-row">
                                <div class="table-cell"><%=itemKey %></div>
                                <div class="table-cell" style="text-align:center"><%=items.get(itemKey).split(",")[0] %></div>
                                <div class="table-cell" style="text-align:right"><%=String.format("%,d", Integer.parseInt(items.get(itemKey).split(",")[1]))%> 원</div>
                            </div>
                            <%} %>
                           
                    </div>
                    <div class='table' style="border-top:0">
                    <div class="table-row">
                                <div class="table-cell" style="background-color:rgb(220,220,220);text-align:right"><strong>총합</strong></div>
                                <div class="table-cell" style="width:10rem;text-align:right"><%=dDTO.getTotal() %> 원</div>
                            </div>
                            </div>
					</div>
		            </div>
		            <div class="card-footer text-xs-center">
					<span>
						<a href="<%=back %>" class="button btn btn-info">뒤로 </a>
					</span>
					<span>
						<button onclick="auctionOff();" class="button btn btn-success">채택하기 </button>
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
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc"><%=CmmUtil.nvl(rDTO.getSido_name()) %> <%=CmmUtil.nvl(rDTO.getSgg_name()) %></div>
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
									<img class="img-fluid my-0" src="/img/req/<%=rDTO.getReq_seq() %>/image.<%=rDTO.getPhoto_dir() %>" alt="Card image cap">
									<%}else{ %>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc">사진 없음
									<%} %>
									</div>
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
	<script src="//www.amcharts.com/lib/4/core.js"></script>
	<script src="//www.amcharts.com/lib/4/charts.js"></script>
	<script type="text/javascript">
	function auctionOff(){
		if(confirm("해당 견적을 채택하시겠습니까?")){
			location.href="/deal/AuctionOff.do?deal_seq=<%=dDTO.getDeal_seq()%>";
		}
	}
	
	window.onload = function(){
		var query = {tuner_seq : "<%=dDTO.getTuner_seq()%>"};
		$.ajax({
			url:"/repu/GetTunerRepu.do",
			type:"post",
			data:query,
			success:function(data){
				if(data==null){
					alert('비정상적인 접근입니다.');
					return;
				}else{
					$("#modal-container").html(data);
				}
			}
		});
		
		// chart
		var obj;
	
		$.ajax({
			url:"/price/GetMarketPrice.do",
			type:"post",
			success:function(data){
				obj = data;
				for(var i=0; i<obj.length; i++){
					obj[i].deal_date = new Date(obj[i].deal_date);
				}
				

				// Create chart instance
				var chart = am4core.create("chartdiv", am4charts.XYChart);
				chart.paddingRight = 20;

				// Add data
				chart.data = obj;
				
				// Create axes
				var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
				dateAxis.renderer.minGridDistance = 50;
				dateAxis.renderer.grid.template.location = 0.5;
				dateAxis.startLocation = 0.5;
				dateAxis.endLocation = 0.5;
				dateAxis.dateFormats.setKey("day", "MM/dd");
				dateAxis.dateFormatter = new am4core.DateFormatter();
				
				// Create value axis
				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.numberFormatter = new am4core.NumberFormatter();
				valueAxis.numberFormatter.numberFormat = "#,###원"; 
				
				//Create series
				var tuningSeries = chart.series.push(new am4charts.LineSeries());
				tuningSeries.name = "조율";
				tuningSeries.dataFields.valueY = "tuning_avg";
				tuningSeries.dataFields.dateX = "deal_date";
				tuningSeries.strokeWidth = 3;
				tuningSeries.tensionX = 0.8;
				tuningSeries.tooltipText = "조율 : {tuning_avg.formatNumber('#,###원')}";
				tuningSeries.tooltip.pointerOrientation = "vertical";
				tuningSeries.stroke = am4core.color("#4272f5");
				tuningSeries.tooltip.getFillFromObject = false;
				tuningSeries.tooltip.background.fill = am4core.color("#4272f5");

				var regulSeries = chart.series.push(new am4charts.LineSeries());
				regulSeries.name = "조정";
				regulSeries.dataFields.valueY = "regul_avg";
				regulSeries.dataFields.dateX = "deal_date";
				regulSeries.strokeWidth = 3;
				regulSeries.tensionX = 0.8;
				regulSeries.stroke = am4core.color("#f55d42");
				regulSeries.tooltipText = "조정 : {regul_avg.formatNumber('#,###원')}";
				regulSeries.tooltip.getFillFromObject = false;
				regulSeries.tooltip.background.fill = am4core.color("#f55d42");

				var voicingSeries = chart.series.push(new am4charts.LineSeries());
				voicingSeries.name= "정음";
				voicingSeries.dataFields.valueY = "voicing_avg";
				voicingSeries.dataFields.dateX = "deal_date";
				voicingSeries.strokeWidth = 3;
				voicingSeries.tensionX = 0.8;
				voicingSeries.stroke = am4core.color("#26bd00");
				voicingSeries.tooltipText = "정음 : {voicing_avg.formatNumber('#,###원')}";
				voicingSeries.tooltip.getFillFromObject = false;
				voicingSeries.tooltip.background.fill = am4core.color("#26bd00");

				var transportSeries = chart.series.push(new am4charts.LineSeries());
				transportSeries.name = "운반"
				transportSeries.dataFields.valueY = "transport_avg";
				transportSeries.dataFields.dateX = "deal_date";
				transportSeries.strokeWidth = 3;
				transportSeries.tensionX = 0.8;
				transportSeries.stroke = am4core.color("#bd00a4");
				transportSeries.tooltipText = "운반 : {transport_avg.formatNumber('#,###원')}";
				transportSeries.tooltip.getFillFromObject = false;
				transportSeries.tooltip.background.fill = am4core.color("#bd00a4");
		
				chart.legend = new am4charts.Legend();
				chart.cursor = new am4charts.XYCursor();
				
			}
		});
		
	}
	
	
	
	</script>
	<script src="/resources/js/validator.js" type="text/javascript"></script>
</body>
</html>
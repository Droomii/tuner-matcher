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
	Map<String, List<String>> prefDates = (Map<String, List<String>>)request.getAttribute("prefDates");
	
	
	String tuner_name = uDTO.getUser_name();
	
	
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
   	}
   	
   	.checked{
   		color:orange;
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
					
					
					<div class="card-block">
						<h5 class="form-section text-bold-600">위치 정보</h5>
						<div class="col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
								<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">주소</div></div>
								<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getAddr()) %></div>
							</div>
						</div>
					</div>
					<div class="card-block pt-0">
						<div style="height:600px">
							<div id="map" style="width:100%;height:100%;"></div>
						</div>
					</div>
					
					
					
				</div>
				<form method="post" hidden="hidden" name="req_action">
					<input value="<%=rDTO.getReq_seq() %>" name="req_seq">
					<input value="<%=rDTO.getPrivate_seq() %>" name="private_seq">
				</form>
				<div class="card-footer text-xs-center">
					<span>
						<a href="<%=back %>" class="button btn btn-info">뒤로 </a>
						<%if(user_type.equals("0")){ %>
						<%if(dDTO==null) {%>
						<button onclick="editReq()" class="button btn btn-success">수정 </button>
						<%} %>
						<button onclick="deleteConfirm()" class="button btn btn-danger">삭제</button>
						<%} %>
					</span>
				</div>
			</div>
		</div>
	</div>
	<%if(user_type.equals("0")){ %>
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
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 desc"><div style="margin:auto"><%=tuner_name %></div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">연락처</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 desc"><div style="margin:auto"><%=uDTO.getUser_tel() %></div></div>
								</div>
							</div>
						</div>
						<%if(dDTO!=null){ 
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
					<%}else{ %>
					<div class="card-block pt-0">
					<h4 class="card-text text-xs-center">- 조율사가 견적서를 등록하지 않았습니다 -</h4>
					</div>
					<%} %>
		            </div>
		            <div class="card-footer text-xs-center">
					<span>
						<a href="<%=back %>" class="button btn btn-info">뒤로 </a>
					</span>
					<%if(dDTO!=null) {%>
					<span>
						<button onclick="decline();" class="button btn btn-danger">거절 </button>
						<button onclick="auctionOff();" class="button btn btn-success">수락 </button>
					</span>
					<%} %>
				</div>
				</div>
			</div>
		</div>
		<%}else if(user_type.equals("1")){ %>
			<%if(dDTO==null){ %>
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
							<input value="1" name="deal_type" hidden>
							<div class="form-body">
								<div class="form-group has-feedback">
									<label for="temp_content">소견</label>
									<textarea id="temp_content" rows="10" class="form-control" placeholder="소견을 입력해주세요(가격 책정 이유 등 상세히)" required></textarea>
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
								<button type="submit" class="button btn btn-success">견적 등록</button>
							</div>
						</form>
					</div>
				</div>
			</div>
					</div>
			</div>
			<%}else{
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
			<div class="row match-height">
		<div class="col-xs-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title">견적 정보</h4>
				</div>
				<div class="card-body">
					<div class="card-block">
						<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
								<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">소견</div></div>
								<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(dDTO.getDiagnosis_content()) %></div>
							</div>
						</div>
					</div>
					<div class="card-block">
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
					<div class="card-block">
						<h5 class="form-section text-bold-600">위치 및 날짜 정보</h5>
						<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
								<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">주소</div></div>
								<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(rDTO.getSido_name()) %> <%=CmmUtil.nvl(rDTO.getSgg_name()) %>(세부 위치는 낙찰 후 공개됩니다)</div>
							</div>
							<div class="row" style="display:flex;">
								<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">날짜</div></div>
								<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=date.split("h")[0] %>(<%=weekday %>) <%=date.split("h")[1] %>:00</div>
							</div>
						</div>
					</div>
				</div>
				<form method="post" hidden="hidden" name="req_action">
					<input value="<%=rDTO.getReq_seq() %>" name="req_seq">
					<input value="<%=rDTO.getPrivate_seq() %>" name="private_seq">
				</form>
				<div class="card-footer text-xs-center">
					<span>
						<a href="<%=back %>" class="button btn btn-info">뒤로 </a>
					</span>
					<%if(dDTO.getDeal_state().equals("0")) {%>
					<span>
						<button onclick="bidCancel();" class="button btn btn-danger">견적 삭제</button>
					</span>
					<%} %>
				</div>
				
				
			</div>
		</div>
	</div>
			<%} %>
		
		
		<%} %>
	
</section>
<!-- Header footer section end -->

        </div>
	</div>
	<!-- footer.jsp 경로설정 -->
	<%@include file="/WEB-INF/view/footer.jsp" %>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=166a1380ea4bddbad714a838dbb867a6&libraries=services,clusterer,drawing"></script>
	<script type="text/javascript">
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
	
	
	
	<%if(dDTO!=null && user_type.equals("0")){%>
	function auctionOff(){
		if(confirm("해당 견적을 채택하시겠습니까?")){
			location.href="/deal/AuctionOff.do?deal_seq=<%=dDTO.getDeal_seq()%>";
		}
	}
	function decline(){
		if(confirm("해당 견적을 거절하시겠습니까?")){
			location.href="/deal/DeclineDeal).do?deal_seq=<%=dDTO.getDeal_seq()%>";
		}
	}
	<%}%>
	
	window.onload = function(){
		var query = {tuner_seq : "<%=rDTO.getPrivate_seq()%>"};
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
		
	}
	
	// 지도

	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
		level: 6 //지도의 레벨(확대, 축소 정도)
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	var geocoder = new kakao.maps.services.Geocoder();
	
	function init(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	        console.log(result);
	        var tunerAddr = result[0];
	        var moveLoc = new kakao.maps.LatLng(tunerAddr.y, tunerAddr.x);
	        map.setCenter(moveLoc);
	        
	        var imageSrc = '/resources/images/help.png', // 마커이미지의 주소입니다    
	        imageSize = new kakao.maps.Size(31, 42), // 마커이미지의 크기입니다
	        imageOption = {offset: new kakao.maps.Point(16, 42)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	        
	        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	        marker = new kakao.maps.Marker({
	            position: moveLoc,
	            image:markerImage
	        });
	        marker.setMap(map);
	    }
	};
	geocoder.addressSearch('<%=CmmUtil.nvl(pDTO.getAddr()).split("&#40")[0].split(",")[0] %>', init);
	
	<%if(user_type.equals("1")){%>
	<%if(dDTO==null){%>
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
		if(!confirm("견적을 등록하시겠습니까? 한번 등록하면 수정이 불가능합니다.")){
			return false;
		}
		
		$("#diagnosis_content").val(document.getElementById('temp_content').value.replace(/\n/g, "<br>"));
	}
	<%}else{%>
	function bidCancel(){
		if(confirm("견적을 삭제하시겠습니까?")){
			location.href="/deal/BidCancel.do?deal_seq=<%=dDTO.getDeal_seq()%>&req_seq=<%=rDTO.getReq_seq() %>";
		}
	}
	<%}%>
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
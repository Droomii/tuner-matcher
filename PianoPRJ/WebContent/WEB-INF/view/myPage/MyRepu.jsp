<%@page import="poly.dto.RepuDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/user/session.jsp" %>
<%
	RepuDTO rDTO = (RepuDTO)request.getAttribute("rDTO");
	int[] techRates = rDTO.getTechRates();
	int[] timeRates = rDTO.getPunctualRates();
	int[] kindnessRates = rDTO.getKindnessRates();
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>내 평판 조회</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="/WEB-INF/view/menu.jsp" %>
	<div class="app-content content container-fluid">
	<div class="content-wrapper">
		<div class="content-body"><!-- Basic example section start -->
		<!-- Header footer section start -->
		<section id="header-footer">
			<div class="row match-height">
				<div class="col-xs-12 col-md-10 offset-md-1 col-lg-8 offset-lg-2">
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">내 평판 조회</h4>
						</div>
						<div class="card-body">
							<div class="card-block">
								<div class="card-text"><strong>리뷰 요약정보(<%=rDTO.getTotal_reviews() %>건)</strong></div>
								<hr style="border-color:gray;margin-top:0.2rem">
								<div class="row">
									<div class="col-xs-4 border-right">
										<h6><strong>기술 만족도</strong></h6>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											만족&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=techRates[0]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=techRates[0]%>% 
											</div>
										</div>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											보통&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=techRates[1]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=techRates[1]%>% 
											</div>
										</div>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											불만족&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=techRates[2]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=techRates[2]%>% 
											</div>
										</div>
									</div>
									<div class="col-xs-4 border-right">
										<h6><strong>시간 만족도</strong></h6>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											만족&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=timeRates[0]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=timeRates[0]%>% 
											</div>
										</div>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											보통&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=timeRates[1]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=timeRates[1]%>% 
											</div>
										</div>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											불만족&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=timeRates[2]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=timeRates[2]%>% 
											</div>
										</div>
									</div>
									<div class="col-xs-4">
										<h6><strong>친절도</strong></h6>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											만족&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=kindnessRates[0]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=kindnessRates[0]%>% 
											</div>
										</div>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											보통&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=kindnessRates[1]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=kindnessRates[1]%>% 
											</div>
										</div>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											불만족&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=kindnessRates[2]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=kindnessRates[2]%>% 
											</div>
										</div>
									</div>
									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- Header footer section end -->
		
		        </div>
	
	
	
	
	
	
	
	
	</div>
	</div>
	<!-- footer.jsp 경로설정 -->
	<%@include file="/WEB-INF/view/footer.jsp" %>
</body>
</html>
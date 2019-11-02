<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->

<!DOCTYPE html>

<html lang="en" data-textdirection="ltr" class="loading">
<head>
<%@ include file="./user/session.jsp" %>
<meta charset="UTF-8">
<title>페이지 타이틀</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="menu.jsp" %>
	
	
<!-- 조율사 메인 -->
<%if(user_type.equals("1")){ %>
	<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-header row">
        </div>
        <div class="content-body"><!-- stats -->
<div class="row">
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="pink">3건</h3>
                            <span>내 주변 요청</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-bag2 pink font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="teal">4건</h3>
                            <span>1:1 요청</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-user1 teal font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="deep-orange">2건</h3>
                            <span>신규 리뷰</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-diagram deep-orange font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="cyan">123점</h3>
                            <span>평판</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-ios-help-outline cyan font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--/ stats -->
<!--/ project charts -->
<!--/ project charts -->
<!-- Recent invoice with Statistics -->
<div class="row match-height">
    <div class="col-xl-12 col-lg-12">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title">다가오는 일정</h4>
                <a class="heading-elements-toggle"><i class="icon-ellipsis font-medium-3"></i></a>
                <div class="heading-elements">
                    <ul class="list-inline mb-0">
                        <li><a data-action="reload"><i class="icon-reload"></i></a></li>
                        <li><a data-action="expand"><i class="icon-expand2"></i></a></li>
                    </ul>
                </div>
            </div>
            <div class="card-body">
                <div class="card-block">
					<div class="row" style="border-bottom: solid 0.1em lightgrey">
						<div class="col-xs-4 text-bold-800 text-xs-left ">거래번호</div>
						<div class="col-xs-4 text-xs-left text-bold-800">고객 성함</div>
						<div class="col-xs-4 text-xs-left text-bold-800">거래일시</div>
					</div>
               <div class="row">
						<div class="col-xs-4 text-xs-left">123</div>
						<div class="col-xs-4 text-xs-left">김도우</div>
				   <div class="col-xs-4 text-xs-left"><span class="text-xs-center">19/09/09(월) 11시</span></div>
					</div>
               <div class="row">
						<div class="col-xs-4 text-xs-left">124</div>
						<div class="col-xs-4 text-xs-left">홍길동</div>
						<div class="col-xs-4 text-xs-left">19/09/10(월)<span class="text-xs-center"> 11시</span></div>
					</div>
                </div>   
                      
                <div class="card-block">
                    <p><span class="float-xs-right"><a href="#">조율 일정 <i class="icon-arrow-right2"></i></a></span></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Recent invoice with Statistics -->


        </div>
      </div>
    </div>
<%} %>
<!-- 조율사 메인 끝 -->
	
	
	
	
	
	<!-- footer.jsp 경로설정 -->
	<%@include file="footer.jsp" %>
</body>
</html>
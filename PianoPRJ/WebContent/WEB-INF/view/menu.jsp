<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header-navbar.jsp" %>

    <!-- ////////////////////////////////////////////////////////////////////////////-->


   
    <!-- main menu-->
    <div data-scroll-to-active="true" class="main-menu menu-fixed menu-dark menu-accordion menu-shadow">
      <!-- main menu header-->
      <div class="main-menu-header">
      </div>
      <!-- / main menu header-->
      
      
      <!-- 대쉬보드 설정 -->
      <div class="main-menu-content">
        <ul id="main-menu-navigation" data-menu="menu-navigation" class="navigation navigation-main">
        <%if(user_type.equals("1")){ %>
         <li class=" nav-item"><a href="/home.do"><i class="icon-home3"></i><span class="menu-title">홈</span></a>
        </li>
         <li class=" nav-item"><a href="/notice/NoticeList.do"><i class="icon-home3"></i><span class="menu-title">공지사항</span></a>
        </li>
          <li class=" nav-item"><a href="#"><i class="icon-android-funnel"></i><span data-i18n="nav.menu_levels.main" class="menu-title">마이페이지</span></a>
            <ul class="menu-content">
              <li><a href="/myPage/MyInfo.do" class="menu-item">개인정보</a></li>
              <li><a href="#" class="menu-item">조율 일정</a></li>
              <li><a href="#" class="menu-item">조율 내역</a>
                <ul class="menu-content">
                  <li><a href="/deal/TunerPastDeals.do" class="menu-item">과거 조율 내역</a></li>
                  <li><a href="/deal/TunerBidList.do" class="menu-item">입찰 현황</a></li>
                  <li><a href="#" class="menu-item">조율 현황</a></li>
                </ul>
              </li>
              <li><a href="#" class="menu-item">단골 고객</a></li>
              <li><a href="/myPage/MyRepu.do" class="menu-item">내 평판 조회</a></li>
            </ul>
          </li>
          <li class=" nav-item"><a href="#"><i class="icon-android-funnel"></i><span class="menu-title">조율하기</span></a>
            <ul class="menu-content">
              <li><a href="/req/TunerPublicReqList.do" class="menu-item">내 주변에서 찾기</a></li>
              <li><a href="#" class="menu-item">1:1 요청</a></li>
            </ul>
          </li>
          <%} else if(user_type.equals("0")){%>
          <li class=" nav-item"><a href="/main.do"><i class="icon-home3"></i><span data-i18n="nav.form_layouts.form_layout_basic" class="menu-title">홈</span></a>
          </li>
          <li class=" nav-item"><a href="/notice/NoticeList.do"><i class="icon-home3"></i><span data-i18n="nav.form_layouts.form_layout_basic" class="menu-title">공지사항</span></a>
          </li>
          <li class=" nav-item"><a href="index.html"><i class="icon-home3"></i><span class="menu-title">마이 페이지</span></a>
            <ul class="menu-content">
              <li><a href="/myPage/MyInfo.do" data-i18n="nav.dash.main" class="menu-item">회원 정보</a>
              </li>
              <li><a href="/piano/MyPianoList.do" data-i18n="nav.dash.main" class="menu-item">내 피아노 정보</a>
              </li>
              <li><a href="#" data-i18n="nav.dash.main" class="menu-item">자주 찾는 조율사</a>
              </li>
              <li><a href="/deal/UserDealList.do" data-i18n="nav.dash.main" class="menu-item">조율 현황</a>
              </li>
              <li><a href="#" data-i18n="nav.dash.main" class="menu-item">내 리뷰</a>
              </li>
            </ul>
          </li>
          <li class=" nav-item"><a href="index.html"><i class="icon-home3"></i><span data-i18n="nav.dash.main" class="menu-title">조율하기</span></a>
            <ul class="menu-content">
              <li><a href="/req/UserPublicReqList.do" data-i18n="nav.dash.main" class="menu-item">공개 요청</a>
              </li>
              <li><a href="#" data-i18n="nav.dash.main" class="menu-item">1:1 요청</a>
              </li>
              <li><a href="#" data-i18n="nav.dash.main" class="menu-item">리뷰 등록</a>
              </li>
            </ul>
          </li>
          <%}else{ %>
          <li class=" nav-item"><a href="/home.do"><i class="icon-home3"></i><span class="menu-title">요약 정보</span></a>
        </li>
         <li class=" nav-item"><a href="#"><i class="icon-home3"></i><span class="menu-title">회원 관리</span></a>
        </li>
          <li class=" nav-item"><a href="#"><i class="icon-android-funnel"></i><span data-i18n="nav.menu_levels.main" class="menu-title">조율사 관리</span></a>
            <ul class="menu-content">
              <li><a href="#" class="menu-item">조율사 조회</a>
              </li>
              <li><a href="#" class="menu-item">조율사 가입요청 조회</a>
              </li>
            </ul>
          </li>
          <li class=" nav-item"><a href="#"><i class="icon-android-funnel"></i><span data-i18n="nav.menu_levels.main" class="menu-title">조율 요청/견적 관리</span></a>
            <ul class="menu-content">
              <li><a href="#" class="menu-item">조율 요청 관리</a>
              </li>
              <li><a href="#" class="menu-item">조율 견적 관리</a>
              </li>
            </ul>
          </li>
          <li class=" nav-item"><a href="#"><i class="icon-android-funnel"></i><span data-i18n="nav.menu_levels.main" class="menu-title">게시판 관리</span></a>
            <ul class="menu-content">
              <li><a href="/notice/NoticeList.do" class="menu-item">공지사항 관리</a>
              </li>
              <li><a href="#" class="menu-item">리뷰 관리</a>
              </li>
            </ul>
          </li>
          <li class=" nav-item"><a href="#"><i class="icon-android-funnel"></i><span class="menu-title">조율하기</span></a>
            <ul class="menu-content">
              <li><a href="" class="menu-item">내 주변에서 찾기</a>
              </li>
              <li><a href="#" class="menu-item">1:1 요청</a>
              </li>
            </ul>
          </li>
          <%} %>
        </ul>
      </div>
      </div>
      <!-- /main menu content-->
      <!-- main menu footer-->
      <!-- include includes/menu-footer-->
      <!-- main menu footer-->


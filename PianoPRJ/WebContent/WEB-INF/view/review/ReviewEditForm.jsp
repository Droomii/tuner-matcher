<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ReviewDTO revDTO = (ReviewDTO)request.getAttribute("revDTO");
%>
<div class="card-block">
<h5 class="form-section text-bold-600">고객 리뷰</h5>
<hr>
<p class="card-title text-muted text-truncate">리뷰 등록은 서비스 품질 향상에 도움이 됩니다</p>
<form onsubmit="return submitReview('수정');" autocomplete="off" data-toggle="validator" role="form" name="reviewForm" class="form" action="/review/ReviewEditProc.do" method="post" autocomplete="off">
<!-- 별점 -->
<div style="font-size:1.5rem;color:gray;letter-spacing:-0.3rem;">
<div style="display:inline-block">
<%
int stars = Integer.parseInt(revDTO.getReview_star());
for(int i=0; i<5; i++){ %>
<span id="star-<%=i+1 %>" role="button" onclick="clickStar(this);" class="<%=i<stars ? "checked" : "" %>"><i class="icon-android-star"></i></span>
<%} %>
</div>
<div id="star-msg" style="font-size:1rem;letter-spacing:0;display:inline-block;vertical-align:middle;height:2rem">&nbsp;별을 클릭하면 별점이 선택됩니다.</div>
<input hidden="hidden" name="review_star" id="review_star" value="<%=revDTO.getReview_star()%>">
<input hidden="hidden" name="deal_seq" id="reviewDealSeq" value="<%=revDTO.getDeal_seq()%>">
</div>
<!-- 리뷰 내용 -->
<div class="form-group">
	<input hidden="hidden" id="review_content" name="review_content">
	<textarea onchange="checkBytes(this, 500);" onKeyUp="checkBytes(this, 500);" id="temp_content" rows="5" class="form-control" placeholder="리뷰 내용을 작성해주세요"><%=CmmUtil.nvl(revDTO.getReview_content(), true) %></textarea>
		<div class="float-xs-right"><span class="byte">0</span>/500 bytes</div>
	</div>
	<div class="row">
	<div class="form-group col-sm-12 col-lg-4">
	<%
	String tech = revDTO.getReview_tech();
	String punctual = revDTO.getReview_punctual();
	String kindness = revDTO.getReview_kindness();
	%>
	<div>기술 만족도</div>
		<select id="projectinput6" name="review_tech" class="form-control">
			<option disabled>선택</option>
			<option value="2" <%=tech.equals("2") ? "selected" : ""%>>만족</option>
			<option value="1" <%=tech.equals("1") ? "selected" : ""%>>보통</option>
			<option value="0" <%=tech.equals("0") ? "selected" : ""%>>불만족</option>
		</select>
	</div>
	<div class="form-group col-sm-12 col-lg-4">
	<div>시간 엄수 만족도</div>
		<select id="projectinput6" name="review_punctual" class="form-control">
			<option selected disabled>선택</option>
			<option value="2" <%=punctual.equals("2") ? "selected" : ""%>>만족</option>
			<option value="1" <%=punctual.equals("1") ? "selected" : ""%>>보통</option>
			<option value="0" <%=punctual.equals("0") ? "selected" : ""%>>불만족</option>
		</select>
	</div>
	<div class="form-group col-sm-12 col-lg-4">
	<div>친절 만족도</div>
		<select id="projectinput6" name="review_kindness" class="form-control">
			<option selected disabled>선택</option>
			<option value="2" <%=kindness.equals("2") ? "selected" : ""%>>만족</option>
			<option value="1" <%=kindness.equals("1") ? "selected" : ""%>>보통</option>
			<option value="0" <%=kindness.equals("0") ? "selected" : ""%>>불만족</option>
		</select>
	</div>
	</div>
    <div class="col-xs-12 text-xs-center">
     <button type="submit" class="button btn btn-success">리뷰 수정</button>
    </div>
                   
	</form>
</div>
<script src="/resources/js/bytechecker.js" type="text/javascript"></script>
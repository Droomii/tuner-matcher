<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_seq = (String)session.getAttribute("user_seq");
	String user_type = (String)session.getAttribute("user_type");
%>
<%if(user_seq==null){ %>
<script>
alert("로그인이 필요합니다");
location.href = "/user/UserLogin.do";
</script>
<%}%>
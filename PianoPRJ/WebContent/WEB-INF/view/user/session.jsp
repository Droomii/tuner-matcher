<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_seq = CmmUtil.nvl((String)session.getAttribute("user_seq"));
	String user_type = CmmUtil.nvl((String)session.getAttribute("user_type"));
	String user_nick = CmmUtil.nvl((String)session.getAttribute("user_nick"));
%>
<%if(user_seq.equals("")){ %>
<script>
alert("로그인이 필요합니다");
location.href = "/index.do";
</script>
<%}%>
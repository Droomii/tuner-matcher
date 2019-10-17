<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String msg = CmmUtil.nvl((String)request.getAttribute("msg"));
    	String url = (String)request.getAttribute("url");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<script>
	window.onload = function() {
		var redirectUrl = '<%=url %>';
		console.log(redirectUrl)
		var msg = '<%=msg%>' 
		if(msg !=""){
			alert(msg);
		}
		location.href = redirectUrl;

	};
</script>
</body>

</html>
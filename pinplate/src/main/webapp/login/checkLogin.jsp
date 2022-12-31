<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	/* include될 jsp이므로 변수명 겹치지않게 */
	String l_login=(String)session.getAttribute("mem_id");
	if(l_login==null || l_login.isEmpty()){ %>
		<script type="text/javascript">
			alert('먼저 로그인하세요');
			location.href="<%=request.getContextPath()%>/index.jsp";
		</script>
	<% return; 
	} %>
</body>
</html>
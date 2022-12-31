<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="resService"
		class="com.pinplate.restaurant.model.RestaurantService"
		scope="session"></jsp:useBean>
	<%
	String resno = request.getParameter("no");
	int cnt = 0;
	try {
		cnt = resService.deleteRes(Integer.parseInt(resno));
	} catch (SQLException e) {
		e.printStackTrace();
	}
	if (cnt == 1) {
	%>
	<script type="text/javascript">
		alert('삭제처리완료');
		location.href = document.referrer;
	</script>
	<%
	} else {
	%>
	<script type="text/javascript">
		alert('삭제처리실패');
		location.href = document.referrer;
	</script>
	<%
	}
	%>
</body>
</html>
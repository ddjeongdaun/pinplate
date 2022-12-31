<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="resService" class="com.pinplate.restaurant.model.RestaurantService" scope="session"></jsp:useBean>
<%
	
	String no=request.getParameter("no");
	int cnt=0;
	String result="";
	try{
		cnt=resService.updateAgree(Integer.parseInt(no));
		if(cnt>0){
			result="변경완료";
		}else{
			result="변경실패";
		}
		%>
		<script type="text/javascript">
			alert('<%=result%>');
			location.href='<%=request.getContextPath()%>/restaurant/resAgree.jsp';
		</script>
		<%
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
</body>
</html>
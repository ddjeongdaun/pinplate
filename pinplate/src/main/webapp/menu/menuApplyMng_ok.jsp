<%@page import="java.sql.SQLException"%>
<%@page import="com.menu.model.MenuService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>menuApplyMng_ok.jsp</title>
</head>
<body>
<%
	//1. 요청 파라미터 가져오기
	String menuNo = request.getParameter("no");
	MenuService menuService = new MenuService();
	int LoginUserNo = (Integer)session.getAttribute("mem_no");

	try{
		//2. 
		int cnt=menuService.menuApplyAppr(Integer.parseInt(menuNo), LoginUserNo);
	
		//3.
		if(cnt>0){%>
		<script type="text/javascript">
			alert('메뉴등록을 승인하였습니다.');
			location.href="<%=request.getContextPath()%>/menu/menuApplyMng.jsp";
		</script>
	<%}else{%>
		<script type="text/javascript">
			alert('메뉴등록에 실패하였습니다.');
			history.back();
		</script>
	<%}
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
</body>
</html>
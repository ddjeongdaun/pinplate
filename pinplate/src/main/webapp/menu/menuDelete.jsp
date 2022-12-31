<%@page import="com.menu.model.MenuService"%>
<%@page import="com.menu.model.MenuVO"%>
<%@page import="com.image.model.ImageVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="menuService" class="com.menu.model.MenuService" scope="session"></jsp:useBean>
<jsp:useBean id="menuDetailVo" class="com.menu.model.MenuDetailVO" scope="page"></jsp:useBean>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete.jsp</title>
</head>
<body>
<%
	//delete.jsp에서 [삭제]를 눌러 get방식으로 이동
	//1 요청 파라미터값 읽어오기
	String menuNo=request.getParameter("no");	

	if(menuNo==null||menuNo.isEmpty()){%>
	<script type="text/javascript">
		alert('잘못된 url입니다.');
		location.href="<%=request.getContextPath()%>/menu/menuList.jsp";
	</script>
	<% 	return;
	}	
	MenuVO menuVo = new MenuVO(); 	
	ImageVO imageVo = new ImageVO();
	menuVo.setMenu_no(Integer.parseInt(menuNo));

	try{
		//2 db연결 - 넘버의 menu_use 를 N으로 수정하는 업데이트실행
		menuDetailVo=menuService.selectByMenuNo(Integer.parseInt(menuNo));
		int tb_no = menuDetailVo.getMenu_no();
		imageVo.setTb_no(tb_no);
		int cnt=menuService.deleteMenu(imageVo, menuVo);	
		
		//3
		if(cnt>0){%>
			<script type="text/javascript">
				alert('메뉴가 삭제되었습니다.');
				location.href="<%=request.getContextPath()%>/menu/menuList.jsp";
			</script>
		<%}else{%>
			<script type="text/javascript">
				alert('메뉴 삭제 실패');
				history.back();
			</script>
		<%}
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
</body>
</html>
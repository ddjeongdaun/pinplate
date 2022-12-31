<%@page import="com.common.Utility"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.pinplate.restaurant.model.RestaurantVO"%>
<%@page import="java.util.List"%>
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
<jsp:useBean id="resService" class="com.pinplate.restaurant.model.RestaurantService" scope="session"></jsp:useBean>
<jsp:useBean id="resVo" class="com.pinplate.restaurant.model.RestaurantVO"></jsp:useBean>
<%
	
	String search=request.getParameter("search");
	System.out.println(search);
	
	List<RestaurantVO> list=null;
	String imgPath="C:\\lecture\\workspace_list\\proj_ws\\pinplate\\src\\main\\webapp\\img_upload";
	
	try{
		if(search==null||search.isEmpty()){
			list=resService.resimgselect();
		}else{
			list=resService.resSelectByKeyword(search);
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
	<script type="text/javascript">
	$(function(){
		<%if(search==null||search.isEmpty()){%>
		<%}else{%>
			$('input[name=search]').val(<%=search%>);	
		<%}%>
	});
	</script>
	<main class="main grid2">
		
		<%if(list==null||list.isEmpty()){ %>
			<span>검색결과없음</span>
		<%}else{ 
			for(int i=0;i<list.size();i++){
			resVo=list.get(i);
			%>
		<div class="item" id="item<%=i+1%>">
			<img src='<%=request.getContextPath()+"/img_upload/"+ resVo.getImgone() %>' class=item_image>
			<div class="item_title hover" id="item_title" onclick="location.href='<%=request.getContextPath()%>/detail/detail.jsp?no=<%=resVo.getRes_no()%>'" ><%=resVo.getRes_name() %></div>
		</div>
			
		<%}
	}%>
	</main>
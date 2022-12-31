<%@page import="com.teg.TegVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/sidebars/">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="<%=request.getContextPath()%>/css/main2.css?no=30" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/contentStyle.css" rel="stylesheet" type="text/css"/>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">

<title>PinPlate</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('main div').hover(function(){
			$(this).find('#item_title').removeClass('hover');
		},function(){
			$(this).find('#item_title').addClass('hover');
		});
		
		
		$('#search').submit(function(){
			if($('input[name=search]').val()==""){
				alert("겁색어를 입력하세요");
				return false;
			}
		});
	});
</script>
</head>
<body>
<div class="grid container">
	<header class="header">
		<div class="title">
			<a href="<%=request.getContextPath()%>/index.jsp">
				<img src="<%=request.getContextPath()%>/images/logo/logo_1.png">
			</a>
		</div>
		<!-- 검색바 -->
		<div class="container-fluid d-grid center" style="grid-template-columns: 1fr 1fr 1fr;">
			<div></div>
			<form class="w-100 center" id="search" name="search" action="<%=request.getContextPath()%>/index.jsp">
				<input type="search" name="search" class="form-control searchBar" placeholder="Search..." aria-label="Search">
			</form>
			<div></div>
		</div>
		<!-- 태그라인 -->
		<jsp:useBean id="tegService" class="com.teg.TegService" scope="session"></jsp:useBean>
		<div class="container-fluid d-grid center" style="grid-template-columns: 1fr;">
			<div></div>
			<%
				List<TegVO> teglist=tegService.selectTeg();
				TegVO tegVo=null;	
				int[] tegNo=new int[5];
				for(int i=0;i<5;i++){
					tegNo[i]=(int)(Math.random()*teglist.size());
					for(int j=0;j<i;j++){
						if(tegNo[i]==tegNo[j]){
							i--;
							break;
						}
					}
				}
			%>
			<div class="tegBar">
				<%for(int i=0;i<5;i++){
				tegVo=teglist.get(tegNo[i]);%> 
					<a href="<%=request.getContextPath()%>/index.jsp?search=<%=tegVo.getTeg_name()%>"><div class="teg mr-2" id="teg1"><%=tegVo.getTeg_name() %></div></a>
				<%}%>
			</div>
			
			<div></div>
		</div>
	</header>
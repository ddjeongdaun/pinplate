<%@page import="com.menu.model.MenuDetailVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/Top.jsp"%>

<script type="text/javascript">
	$(function(){
		$('#menuGr > div').hover(function(){
			$(this).find('#menuCnt').removeClass('hover');
		},function(){
			$(this).find('#menuCnt').addClass('hover');
		});
	});
</script>
<jsp:useBean id="resService" class="com.pinplate.restaurant.model.RestaurantService" scope="session"></jsp:useBean>
<jsp:useBean id="resVo" class="com.pinplate.restaurant.model.RestaurantVO"></jsp:useBean>
<jsp:useBean id="menuService" class="com.menu.model.MenuService"></jsp:useBean>
<jsp:useBean id="menuDetailVo" class="com.menu.model.MenuDetailVO"></jsp:useBean>	
<%
	String no=request.getParameter("no");
	resVo=resService.resSelectByNo(Integer.parseInt(no));
%>

<main class="detail grid3">
	<div class="resImg item2">
		<img src="<%=request.getContextPath()+"/img_upload/"+ resVo.getImgone() %>"
			class="detail_mainImg">
	</div>
	<!-- 식당 블럭 시작 -->
	<div class="resCts item2 p-2">
		<div class="resInfo">
			<p class="resInfo_title b" style="padding-left:10px;padding-top:3px;">
				<%=resVo.getRes_name() %>
			</p>
			<hr>
			<p class="resInfo_cnt d">
				<span>전화번호 : </span>
				<span><%=resVo.getRes_tel() %></span>
			</p>
			<p class="resInfo_cnt d">
				<span>주소 : </span>
				<span><%=resVo.getRes_addr() %></span>
			</p>
			<p class="resInfo_cnt d">
				<span>업종 : </span>
				<span><%=resVo.getRes_type() %></span>
			</p>
		</div>
	</div>
	<!-- 식당 블럭 종료 -->
	
<%@ include file="/menu/menuListForUser.jsp"%>
	
	<!-- 태그 블럭 시작 -->
	<div class="resTeg item2">
		<div class="tegbox">
			<a href="#"><div class="teg2" id="teg1">#태그1</div></a>
			<a href="#"><div class="teg2" id="teg1">#태그2</div></a>
			<a href="#"><div class="teg2" id="teg1">#태그3</div></a>
			<a href="#"><div class="teg2" id="teg1">#태그4</div></a>
			<a href="#"><div class="teg2" id="teg1">#태그5</div></a>
		</div>
	</div>
	<!-- 태그 블럭 끝 -->
	
	<!-- 지도 블럭 시작 -->
	<div class="resMap item2">
	
	
	<div id="map" class="detail_tempMap"></div>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b09b1236d9b8273da3a250306575a025&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	   		 mapOption = { 
	       	 center: new kakao.maps.LatLng(<%=resVo.getRes_x()%>,<%=resVo.getRes_y()%>), // 지도의 중심좌표
	       	draggable: false,
	       	 level: 3 // 지도의 확대 레벨
	    };
	
		
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		var markerPosition  = new kakao.maps.LatLng(<%=resVo.getRes_x()%>,<%=resVo.getRes_y()%>); 

				var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		
		marker.setMap(map);
		
	</script>
	</div>
	<!-- 지도 블럭 끝 -->

	<!-- 리뷰 블럭 시작 -->
	
<%@ include file="/review/reviewList.jsp"%>
	
	<!-- 리뷰 블럭 끝 -->
	<div class="resDummy"></div>
</main>

<%@ include file="/inc/Bottom.jsp"%>
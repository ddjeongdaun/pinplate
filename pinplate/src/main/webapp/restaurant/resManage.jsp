<%@page import="java.sql.SQLException"%>
<%@page import="com.pinplate.restaurant.model.RestaurantVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/Top.jsp"%>  
<jsp:useBean id="resService" class="com.pinplate.restaurant.model.RestaurantService"></jsp:useBean>
<%
List<RestaurantVO> list=null;
RestaurantVO resvo=null;
	try{
		list=resService.selectManageRes();
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
<main class="mainDiv" class="center">
	<div class="mainDivGr7 center">
		<div class="center">
		<p class="p c">음식점 관리 페이지</p>
		<table class="box2" width="100%">
			<tr style="font-size:14px;" class="center" >
				<th>번호</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>업종</th>
				<th>등록여부</th>
				<th>음식점등록날짜</th>
				<th>음식점등록자번호</th>
				<th>수정,삭제버튼</th>
			</tr>
		<%if(list==null||list.isEmpty()){ %>
			<tr>
				<td colspan="9">등록된 음식점이 없습니다.</td>
			</tr>
		<%} %>
		
		<%for(int i=0;i<list.size();i++){ 
			resvo=list.get(i);%>	
			<tr style="font-size:14px" class="center">
				<td><%=resvo.getRes_no() %></td>
				<td><%=resvo.getRes_name() %></td>
				<td><%=resvo.getRes_tel() %></td>
				<td><%=resvo.getRes_type() %></td>
				<td><%=resvo.getRes_yn() %></td>
				<td><%=resvo.getRes_regdate() %></td>
				<td><%=resvo.getApp_userno() %></td>
				<td>
					<button id="resEdit"
						onclick="location.href='<%=request.getContextPath()%>/restaurant/resEdit.jsp?no=<%=resvo.getRes_no()%>'">
						수정
					</button>
					<button id="resDelete" onclick="delfunc(<%=resvo.getRes_no()%>);">
						삭제
					</button>
				</td>
			</tr>
		
		<%} %>
		</table>
		<input type="button" value="음식점 등록" id="regBtn"
				class="btn btn-sm btn-block loginBt mt-1" style="margin-top:10px;"
				onClick="location.href='<%=request.getContextPath()%>/restaurant/resRegister.jsp'">
				
		</div>
	</div>
</main>
<script type="text/javascript">
	function delfunc(no){
		if(confirm('삭제하시겠습니까?')){
			alert(no);
			location.href="<%=request.getContextPath()%>/restaurant/resDelete.jsp?no="+no;
		}
	}
</script>
<%@ include file="/inc/Bottom.jsp"%>

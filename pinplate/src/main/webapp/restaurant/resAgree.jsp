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
		list=resService.selectDisAgreeRes();
	}catch(SQLException e){
		e.printStackTrace();
	}

%>

<main class="mainDiv">
	<div class="mainDivGr6 center">
		<div class="center">
		<p class="p c">음식점 신청 관리</p>
		<table class="box2 center" >
			<tr style="font-size:12px;">
				<th>음식점번호</th>
				<th>음식점이름</th>
				<th>음식점 전화번호</th>
				<th>음식점종류</th>
				<th>음식점승인여부</th>
				<th>음식점사용여부</th>
				<th>음식점등록날짜</th>
				<th>음식점등록자번호</th>
				<th>등록,삭제버튼</th>
			</tr>
		<%if(list==null||list.isEmpty()){ %>
			<tr style="font-size:12px;">
				<td colspan="9">신청온 음식점이 없습니다.</td>
			</tr>
		<%} %>
		<%for(int i=0;i<list.size();i++){ 
		resvo=list.get(i);%>	
			<tr style="font-size:12px;">
				<td><%=resvo.getRes_no() %></td>
				<td><%=resvo.getRes_name() %></td>
				<td><%=resvo.getRes_tel() %></td>
				<td><%=resvo.getRes_type() %></td>
				<td><%=resvo.getRes_yn() %></td>
				<td><%=resvo.getRes_use() %></td>
				<td><%=resvo.getRes_regdate() %></td>
				<td><%=resvo.getApp_userno() %></td>
				<td>
					<button id="resEdit" onclick="location.href='<%=request.getContextPath()%>/restaurant/resAgree_ok.jsp?no=<%=resvo.getRes_no()%>'">등록</button>
					<button id="resDelete" onclick="delfunc(<%=resvo.getRes_no()%>);">삭제</button>
				</td>
			</tr>
		<%} %>
		</table>
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
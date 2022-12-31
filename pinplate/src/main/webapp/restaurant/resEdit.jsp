<%@page import="com.pinplate.restaurant.model.RestaurantVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/Top.jsp"%> 
<script type="text/javascript">
$(function(){
	$('#btnAddr').click(function(){
		
	 	open('../map/openMap.jsp','map',
	 		'width=550,height=600,left=1000,top=50,location=yes,resizable=yes');	
	});
	
	$('#btnSub').click(function(){
		
		if($('#resName').val()==""){
			alert("음식점이름을입력하세요");
			$('#resName').focus();
			return false;
		}
		if($('#resTel').val()==""){
			alert("음식점 전화번호를 입력하세요");
			$('#resTel').focus();
			return false;
		}
		if($('#hiddenAddr').val()==""){
			alert("음식점 주소를 검색을 하셔야합니다.");
			open('../map/openMap.jsp','map',
	 		'width=550,height=600,left=1000,top=50,location=yes,resizable=yes');	
			
			return false;
		}
		if($('#resType').val()==""){
			alert("음식점 종류를 입력하세요");
			$('#resType').focus();
			return false;
		}
		
		$('#resfrm').submit();
		
	});
	
	
});
</script>
<jsp:useBean id="resService" class="com.pinplate.restaurant.model.RestaurantService" scope="session"></jsp:useBean>
<main class="mainDiv">
	<div class="mainDivGr2 center">
	<%
String name=(String)session.getAttribute("mem_name");
String auth=(String)session.getAttribute("mem_auth");
int no=(int)session.getAttribute("mem_no");
String resno=request.getParameter("no");
if(auth==null){%>
	<script type="text/javascript">
		alert('관리자만 들어올수있습니다');
	location.href='<%=request.getContextPath()%>/index.jsp';
	</script>
<%}else if(auth.equals("1")){%>
	<!-- <script type="text/javascript">
		alert('관리자님 어서오세요');
	</script> -->
	<p class="p c">음식점 수정 페이지</p>
<%}else{%>
	<script type="text/javascript">
		alert('관리자만 들어올수있습니다');
	location.href='<%=request.getContextPath()%>/index.jsp';
	</script>
	
<%}
RestaurantVO resvo=null;
try{	
	resvo=resService.resSelectByNo(Integer.parseInt(resno));
	System.out.println(resvo.getRes_no());
}catch(SQLException e){
	e.printStackTrace();
}		
%>
		<form name="frm" id="resfrm" method="post"
			action="<%=request.getContextPath() %>/restaurant/resEdit_ok.jsp"
			enctype="multipart/form-data" >
			
			<input type="hidden" id="resNo" name="resNo" value="<%=resvo.getRes_no()%>">
			
			<input type="text" id="resName" name="resName" placeholder="음식명을 입력하세요"
					class="form-control inputbox2" value="<%=resvo.getRes_name()%>">
			<input type="text" id="resTel" name="resTel" placeholder="음식점 전화번호를 입력하세요"
					class="form-control inputbox2" value="<%=resvo.getRes_tel()%>">
			
			<input type="text" id="resType" name="resType" placeholder="음식점 업종을 입력하세요"
					class="form-control inputbox2" value="<%=resvo.getRes_type()%>" >
    
			<input type="text" id="resAddr" name="resAddr" disabled="disabled" placeholder="음식점 주소를 검색하세요"
					class="form-control inputbox2" style="margin-top:30px;"
					value="<%=resvo.getRes_addr()%>">
			
	        <input type="button" id="btnAddr" value="주소 검색" 
	        	class="btn btn-sm btn-block loginBt mt-1"><br>
	            
	        <hr>    
	        <p class="p c">기존 이미지 파일명</p>
	            <input type="text" id="resType" name="oriImg" value="<%=resvo.getImgone()%>"
	            	class="form-control inputbox2">
	        <br>
	        <hr>
	        <p class="p c">수정할 이미지를 첨부하세요</p>
	            <input type="file" name="resImg" id="resImg" size="30" accept="image/*"><br><br>
	            
	      		<input type="hidden" id="resContent" name="resContent" value=".1"/>
	            <input type="hidden" id="resX" name="resX" value="<%=resvo.getRes_x()%>"/>
	            <input type="hidden" id="resY" name="resY" value="<%=resvo.getRes_y()%>"/>
	            <input type="hidden" id="hiddenAddr" name="hiddenAddr" value="<%=resvo.getRes_addr()%>">
	            
		<input type="button" id="btnSub" value="수정 완료"
			class="btn btn-sm btn-block loginBt mt-1">
		
		<input type="button" value="수정 취소"
					onclick="history.back()"
					class="btn btn-sm btn-block regist mt-2">
		
		</form>
	</div>
</main>
<%@ include file="/inc/Bottom.jsp"%>
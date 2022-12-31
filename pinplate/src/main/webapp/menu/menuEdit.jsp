<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/Top.jsp"%>   
<jsp:useBean id="menuService" class="com.menu.model.MenuService" scope="session"></jsp:useBean>
<jsp:useBean id="menuDetailVo" class="com.menu.model.MenuDetailVO" scope="page"></jsp:useBean>

<%
	//menuDetail.jsp에서 [수정]을 클릭하면 get방식으로 이동
	//=> http://localhost:9090/pinplate/menu/menuEdit.jsp?no=4
	//1. 요청 파라미터 읽어오기
	String no = request.getParameter("no");
	int loginUserNo = (Integer)session.getAttribute("mem_no");
	
	//2. db 연동
	try{
		menuDetailVo=menuService.selectByMenuNo(Integer.parseInt(no));
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3. 결과 처리	
%>
<script type="text/javascript">
$(function(){
	var imgFile = $('#fileName').val();
	var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf|JPG|JPEG|PNG|GIF|BMP|PDF)$/;
	var maxSize = 5*1024*1024;
	var fileSize;	
	$('#resName').click(function(){
		alert('음식점명은 변경할 수 없습니다.');
	});
	
	$('#menuName').click(function(){
		$('#menuName').val("");
	})
	
	$('#menuPrice').click(function(){
		$('#menuPrice').val("");
	})

	$('#frmMenu').submit(function(){
		if($('#menuName').val().length<1){
			alert('메뉴명을 입력하세요.');
			$('#menuName').focus();
			event.preventDefault();
		}else if($('#menuPrice').val().length<1){
			alert('가격을 입력하세요.');
			$('#menuPrice').focus();
			event.preventDefault();
		}else if($('#fileName').val() != "" && $('#fileName').val() != null){
			fileSize=document.getElementById("fileName").files[0].size;
			if(!$('#fileName').val().match(fileForm)){
				alert("이미지 파일만 업로드 가능");
				event.preventDefault();
			}else if(fileSize > maxSize){
				alert("파일 사이즈는 5MB까지 가능");
				event.preventDefault();
			}
		}
	}); 
});
</script>

<main class="mainDiv">
	<div class="mainDivGr5 center">
		<p class="p c">수정할 메뉴 정보를 입력하세요</p>
	<form id="frmMenu" name="frmMenu" method="post" action="<%=request.getContextPath() %>/menu/menuEdit_ok.jsp"
		enctype="multipart/form-data"> <!-- 이거잊지말기 -->
		<input type="hidden" name="tb_type_no" value="2"> <!-- menu -->
		<input type="hidden" name="menuNo" value="<%=no%>">
		<input type="hidden" name="imgNo" value="<%=menuDetailVo.getImg_no()%>">
		<input type="hidden" name="resNo" id="resNo" value="<%=menuDetailVo.getRes_no() %>">
		<input type="hidden" name="resAdm" id="resAdm" value="<%=loginUserNo%>"> <!-- value에 현재 로그인한 관리자 번호가 들어가야함 -->			
		<input type="text" id="resName" name="resName" placeholder="음식점을 선택하세요"
				class="form-control inputbox2" value="<%=menuDetailVo.getRes_name() %>" readonly>
		<input type="text" id="menuName" name="menuName" placeholder="메뉴를 입력하세요"
				class="form-control inputbox2" value="<%=menuDetailVo.getMenu_name() %>" >
		<input type="text" id="menuPrice" name="menuPrice" placeholder="가격을 입력하세요"
				class="form-control inputbox2" value="<%=menuDetailVo.getMenu_price()%>">
		<hr>
		<p class="p c">메뉴 이미지를 첨부하세요</p>
		<hr>
		<input type="file" name="fileName" id="fileName" size="30" accept="image/*" value="<%=menuDetailVo.getImg_filename()%>"><br><br>
		
			<input type="submit" value="수정"
				class="btn btn-sm btn-block loginBt mt-1">
			<input type="button" value="취소"
				onClick="history.back()";
				class="btn btn-sm btn-block regist mt-2">	
	</form>
	</div>
</main>

<%@ include file="/inc/Bottom.jsp"%>
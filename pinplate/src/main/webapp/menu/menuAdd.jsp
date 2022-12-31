<%@page import="com.pinplate.restaurant.model.RestaurantVO"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.menu.model.MenuDetailVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/Top.jsp"%>   
<jsp:useBean id="menuService" class="com.menu.model.MenuService" scope="session"></jsp:useBean>
<jsp:useBean id="menuDetailVo" class="com.menu.model.MenuDetailVO" scope="page"></jsp:useBean>
<jsp:useBean id="restaurantService" class="com.pinplate.restaurant.model.RestaurantService" scope="session"></jsp:useBean>
<jsp:useBean id="restaurantVo" class="com.pinplate.restaurant.model.RestaurantVO" scope="page"></jsp:useBean>

<%
	//[1] menuList.jsp에서 메뉴추가를 클릭하면 get방식으로 이동
	
	//1 요청 파라미터값 읽어오기
	request.setCharacterEncoding("utf-8");
	int loginUserNo = (Integer)session.getAttribute("mem_no");
	
	
	//2 db 연결
	List<RestaurantVO> list=null;

	try{
		list=restaurantService.selectAllresName();
		
	}catch(SQLException e){
		e.printStackTrace();
	}	
		
	//3 결과 처리	
%>

<script type="text/javascript">
	$(function(){
		$('tbody > tr').hover(function(){
			$(this).css('background','pink');
		},function(){
			$(this).css('background','');
		});
		
		
		$('tbody > tr').click(function(){
			var tdResName=$(this).find('#tdResName').text();
			var tdResNo=$(this).find('#tdResNo').text();
			$('#resName').val(tdResName);
			$('#resNo').val(tdResNo);
		});
		
		$('#menuList').click(function(){
			location.href="<%=request.getContextPath()%>/menu/menuList.jsp";
		});
		
		var imgFile = $('#fileName').val();
		var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf|JPG|JPEG|PNG|GIF|BMP|PDF)$/;
		var maxSize = 5*1024*1024;
		var fileSize;		
		
		$('#frmMenu').submit(function(){
			if($('#resName').val().length<1){		
				alert('음식점을 선택하세요.');
				event.preventDefault();				
			}else if($('#menuName').val().length<1){
				alert('메뉴명을 입력하세요.');
				$('#menuName').focus();
				event.preventDefault();
			}else if($('#menuPrice').val().length<1){
				alert('가격을 입력하세요.');
				$('#menuPrice').focus();
				event.preventDefault();
			}else if($('#fileName').val()==""){
				alert('이미지를 첨부하세요.');
				$('#fileName').focus();
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
	<div class="mainDivGr center" style="margin-right:5px">
		<p class="p c">메뉴 추가를 신청할 음식점을 선택하세요</p>
		<table class="box2" id="seletRes">
			<thead>
				<tr style="font-size:12px;">
					<th>번호</th>
					<th>음식점</th>
				</tr>
			</thead>
			<tbody>
			<!-- 목록을 띄워 식당을 먼저 선택 : 이거 식당리스트 식당에서 가져와야할듯/다지우면 데이터못찾음 -->
					<%if(list==null || list.isEmpty()){ %>
				  		<tr><td colspan="6">데이터가 없습니다.</td></tr>
				  	<%}else{
						for(int i=0;i<list.size();i++){			  
							restaurantVo=list.get(i);
							int resNo = restaurantVo.getRes_no();
							String resName = restaurantVo.getRes_name();
							%>		
							<tr id="resInfo" style="text-align:center;font-size:12px">
								<td id="tdResNo" width="100px"><%=resNo %></td>
								<td id="tdResName" width="300px"><%=resName %>
								</td>
							<tr>
				  		<%}//for%>
					<%}//if %>
			</tbody>
		</table>
	</div>
	
		<form id="frmMenu" name="frmMenu" method="post" action="<%=request.getContextPath() %>/menu/menuAdd_ok.jsp"
			enctype="multipart/form-data"> <!-- 이거잊지말기 -->
			<div class="mainDivGr5 center">
			<p class="p c">메뉴 정보를 입력하세요</p>
			<input type="hidden" name="tb_type_no" value="2"> <!-- menu -->
			<input type="hidden" name="resNo" id="resNo">
			<input type="hidden" name="resAdm" id="resAdm" value="<%=loginUserNo%>">
			<input type="text" id="resName" name="resName" placeholder="음식점을 선택하세요"
					class="form-control inputbox2" readonly>
			<input type="text" id="menuName" name="menuName" placeholder="메뉴를 입력하세요"
					class="form-control inputbox2">
			<input type="text" id="menuPrice" name="menuPrice" placeholder="가격을 입력하세요"
					class="form-control inputbox2">
			<br>
			<hr>
			<p class="p c">메뉴 이미지를 첨부하세요</p>
			<hr>
			<input type="file" name="fileName" id="fileName" size="30" accept="image/*"><br><br>
			
			<input type="submit" value="등록" id="joinBtn"
				class="btn btn-sm btn-block loginBt mt-1">
			<input type="button" value="메인페이지로 이동"
				onClick="location.href='<%=request.getContextPath()%>/index.jsp'"
				class="btn btn-sm btn-block regist mt-2">	
		</div>
	</form>
</main>

<%@ include file="/inc/Bottom.jsp"%>
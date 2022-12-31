<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/Top.jsp"%>    
       
<jsp:useBean id="menuService" class="com.menu.model.MenuService" scope="session"></jsp:useBean>
<jsp:useBean id="menuDetailVo" class="com.menu.model.MenuDetailVO" scope="page"></jsp:useBean>

<%
	//테스트용 경로설정 - 현재설정
	String loadDir="C:\\lecture\\workspace_list\\proj_ws\\pinplate\\src\\main\\webapp\\img_upload";
	System.out.println("3. loadDir="+loadDir);

	//[1] menuList.jsp에서 메뉴명을 클릭하면 get방식으로 이동
	
	//1 요청 파라미터값 읽어오기
	request.setCharacterEncoding("utf-8");
	String menuNo=request.getParameter("no");
	
	//2 db 연결
	try{
		menuDetailVo=menuService.selectByMenuNo(Integer.parseInt(menuNo));
	}catch(SQLException e){
		e.printStackTrace();
	}
	//3 결과 처리
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("#,###");

%>

<script type="text/javascript">
	$(function(){
		$('#menuEdit').click(function(){
			location.href="<%=request.getContextPath()%>/menu/menuEdit.jsp?no=<%=menuDetailVo.getMenu_no() %>";
		});
		$('#menuDel').click(function(){
			if(confirm('메뉴를 삭제하시겠습니까?')){
				location.href="<%=request.getContextPath()%>/menu/menuDelete.jsp?no=<%=menuDetailVo.getMenu_no() %>";	
			}
			event.preventDefault();	
		});
		$('#menuList').click(function(){
			location.href="<%=request.getContextPath()%>/menu/menuList.jsp";
		});	
	});
</script>


<main class="mainDiv">
	<div class="mainDivGr5 center">
		<p class="p c">메뉴 상세 페이지</p>
		<img src="<%=request.getContextPath() %>/img_upload/<%=menuDetailVo.getImg_filename() %>" width="300px" style="border-radius: 10px;margin-bottom:20px;">
		<p>음식점 : <%=menuDetailVo.getRes_name() %></p>
		<p>메뉴명 : <%=menuDetailVo.getMenu_name() %></p>
		<p>가격 : <%=df.format(menuDetailVo.getMenu_price()) %></p>
		<p>등록일 : <%=menuDetailVo.getMenu_regdate() %></p>
		<p>등록자 : <%=menuDetailVo.getMem_id() %></p>
		<input type="submit" value="수정" id="menuEdit" name="menuEdit"
				class="btn btn-sm btn-block loginBt mt-1">
		<input type="button" value="삭제"
				class="btn btn-sm btn-block regist mt-2" id="menuDel" name="menuDel">	
		<input type="button" value="메인페이지로 이동"
				onClick="location.href='<%=request.getContextPath()%>/menu/menuList.jsp'"
				class="btn btn-sm btn-block regist mt-2" id="menuList" name="menuList">	
	</div>
</main>

<%@ include file="/inc/Bottom.jsp"%>

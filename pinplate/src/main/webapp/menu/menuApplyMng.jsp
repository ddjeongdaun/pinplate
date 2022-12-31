<%@page import="com.common.PagingVO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.menu.model.MenuService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.menu.model.MenuDetailVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/Top.jsp"%>    
<jsp:useBean id="menuService" class="com.menu.model.MenuService" scope="session"></jsp:useBean>
<jsp:useBean id="menuDetailVo" class="com.menu.model.MenuDetailVO" scope="page"></jsp:useBean>

<%
	//[1] AsideForUser.jsp에서 메뉴신청 클릭하면 get방식으로 이동

	//1 요청 파라미터값 읽어오기
	request.setCharacterEncoding("utf-8");
	String Condition = request.getParameter("searchCondition");
	String Keyword = request.getParameter("searchKeyword");
	
	if(Keyword==null) Keyword="";
	
	//2 db 연결
	List<MenuDetailVO> list=null;
	try{
		list=menuService.selectApplyMenu(Condition, Keyword);
	}catch(SQLException e){
		e.printStackTrace();
	}

	//3 결과 처리
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("#,###");
	
	//페이징 처리
	int currentPage=1;
	
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//현재 페이지와 무관한 변수들
	int totalRecord=0;
	if(list!=null && !list.isEmpty()){
		totalRecord=list.size();				
	}
	
	int pageSize=30;  //한페이지에 보여줄 레코드 개수
	int blockSize=5; //한 블럭에 보여줄 페이지 수
	
	PagingVO pageVo = new PagingVO(currentPage, totalRecord, pageSize, blockSize);
%>
<script type="text/javascript">
	$(function(){
		$('tbody #applyItem').hover(function(){
			$(this).css('background','pink');
		},function(){
			$(this).css('background','');
		});
		
		$('tbody #applyItem').click(function(){
			var resName = $(this).find('td').eq(1).text();
			var menuName = $(this).find('td').eq(2).text();
			var menuNo = $(this).find('td').eq(0).text();
			if(!confirm('음식점 : '+resName+'\n메뉴명 : '+menuName+'\n메뉴 추가를 승인하겠습니까?')){
				even.preventDefault();
			};
			location.href="<%=request.getContextPath()%>/menu/menuApplyMng_ok.jsp?no="+menuNo;			
		});
	});
</script>

<main class="mainDiv">
	<div class="mainDivGr3 center">
		<div class="center">
		<p class="p c">메뉴신청 관리, 선택하여 승인여부 결정</p>
			<%
			if(Keyword!=null && !Keyword.isEmpty()){%>
				<p>검색 결과 : <%=list.size()%> 건 검색되었습니다.</p>
			<%}
			%>
	<table class="box2" width="100%">
		<colgroup>
			<col style="width:5%;"/>
			<col style="width:30%;"/>
			<col style="width:30%;"/>
			<col style="width:10%;"/>
			<col style="width:15%;"/>	
			<col style="width:10%;"/>		
		</colgroup>
		<thead>
			<tr style="font-size:12px;">
				<th>번호</th>
				<th>음식점</th>
				<th>메뉴명</th>
				<th>가격</th>
				<th>등록일</th>
				<th>등록자</th>
			</tr>
		</thead>
		<tbody>
			<%if(list==null || list.isEmpty()){ %>
		  		<tr><td colspan="6">데이터가 없습니다.</td></tr>
		  	<%}else{ %>
				<!-- 반복되어 리스트출력하는 시작 -->
				<%
				int num=pageVo.getNum();
				int curPos=pageVo.getCurPos();
				
				for(int i=0;i<pageVo.getPageSize();i++){
					if(num<1) break;
					
					menuDetailVo = list.get(curPos++); 
					num--;
				%>
				
				<tr id="applyItem" style="text-align:center;font-size:12px;">
					<td><%=menuDetailVo.getMenu_no() %></td>
					<td><%=menuDetailVo.getRes_name() %></td>
					<td><%=menuDetailVo.getMenu_name() %></td>
					<td><%=df.format(menuDetailVo.getMenu_price()) %></td>
					<td><%=sdf.format(menuDetailVo.getMenu_regdate()) %></td>
					<td><%=menuDetailVo.getMem_id() %></td>
				<tr>
				
				<!-- 반복되어 리스트출력하는 종료 -->
				<%}//for%>
			<%}//if %>
		</tbody>
	</table>
	</div>
	<div class="divPage center">
	<!-- 이전블럭으로 이동 -->
	<%
		if(pageVo.getFirstPage()>1){ %>
			<a href="<%=request.getContextPath()%>/menu/menuList.jsp?currentPage=<%=pageVo.getFirstPage()-1 %>&searchCondition=<%=Condition%>&searchKeyword=<%=Keyword%>">
				<img src="<%=request.getContextPath()%>/images/first.JPG">
			</a>
	<%	}	 %>
	<!-- 페이지 번호 추가 -->		
	<!-- [1][2][3][4][5][6][7][8][9][10] -->
	<% for(int i=pageVo.getFirstPage();i<=pageVo.getLastPage();i++){
		  if(i>pageVo.getTotalPage()) break;
		  
		  if(i==currentPage){ %>
				<span style="color:blue;font-weight: bold;font-size:1.0em">
					<%=i %>
				</span>
		<%}else{%>
				<a href="<%=request.getContextPath()%>/menu/menuList.jsp?currentPage=<%=i%>&searchCondition=<%=Condition%>&searchKeyword=<%=Keyword%>">[<%=i %>]</a>	
		<%} %>
			
	<%	}%>
	<!--  페이지 번호 끝 -->
	<!--  다음 블럭으로 이동 -->
	<%	if(pageVo.getLastPage()<pageVo.getTotalPage()) { %>
		<a href="<%=request.getContextPath()%>/menu/menuList.jsp?currentPage=<%=pageVo.getLastPage()+1 %>&searchCondition=<%=Condition%>&searchKeyword=<%=Keyword%>">
				<img src="<%=request.getContextPath()%>/images/last.JPG">
			</a>
	<%	} %>
	</div>
	
	<div class="divSearch center">
   	<form name="frmSearch" method="post" action='<%=request.getContextPath()%>/menu/menuList.jsp'>
        <select name="searchCondition">
            <option value="res_name" 
            	<%if("res_name".equals(Condition)){%>
            		selected="selected"
            	<%}%>
            >가게명</option>
            <option value="menu_name"
            	<%if("menu_name".equals(Condition)){%>
            		selected="selected"
            	<%}%>                       
            >메뉴명</option>
            <option value="mem_id"
            	<%if("mem_id".equals(Condition)){%>
            		selected="selected"
            	<%}%>           
            >등록자</option>
        </select>   
        
        <input type="text" name="searchKeyword" title="검색어 입력" value="<%=Keyword%>">   
		<input type="submit" value="검색">
    </form>
    </div>
    </div>
</main>

<%@ include file="/inc/Bottom.jsp"%>
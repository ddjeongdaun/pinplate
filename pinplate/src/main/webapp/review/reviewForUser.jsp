<%@page import="com.pinplate.restaurant.model.RestaurantService"%>
<%@page import="com.pinplate.restaurant.model.RestaurantVO"%>
<%@page import="com.common.PagingVO"%>
<%@page import="com.member.model.memberService"%>
<%@page import="org.apache.catalina.tribes.MembershipService"%>
<%@page import="com.review.model.ReviewVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.review.model.ReviewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="memberService" class="com.member.model.memberService"/>
<jsp:useBean id="memberVo" class="com.member.model.memberVO"/>
<%@ include file="/inc/Top.jsp"%>
<%
	//1 요청 파라미터 읽어오기
	int mem_noForlist = (Integer)session.getAttribute("mem_no");	
	ReviewService reviewService = new ReviewService();	
	RestaurantService resService = new RestaurantService();
	
	List<ReviewVO> list=null;
	ReviewVO reviewVo=new ReviewVO();
	RestaurantVO resVo=new RestaurantVO();

	try{
		list=reviewService.selectReviewByUserNo(mem_noForlist);		
	}catch(SQLException e){
		e.printStackTrace();
	}

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
		$('#addMenu').click(function(){
			location.href="<%=request.getContextPath()%>/menu/menuAdd.jsp";
		});
		$('#menuList').click(function(){
			location.href="<%=request.getContextPath()%>/menu/menuList.jsp";
		});	
	});
</script>


<main class="mainDiv">
	<div class="mainDivGr4">
		<p class="p c center">내 리뷰 페이지</p>
		<table class="box2 center">
			<colgroup>
				<col style="width:5%;"/>
				<col style="width:30%;"/>
				<col style="width:30%;"/>		
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>음식점</th>
					<th>리뷰내용</th>
				</tr>
			</thead>
			<tbody>
				<%
				int resNoForSelect=0;
				if(list==null || list.isEmpty()){ %>
			  		<tr><td colspan="6">데이터가 없습니다.</td></tr>
			  	<%}else{ %>
					<!-- 반복되어 리스트출력하는 시작 -->
					<%
					int num=pageVo.getNum();
					int curPos=pageVo.getCurPos();
					
					for(int i=0;i<pageVo.getPageSize();i++){
						if(num<1) break;
						
						reviewVo = list.get(curPos++); 
						num--;
						
						resNoForSelect = reviewVo.getRes_no();
						try{
							resVo = resService.resSelectByNo(resNoForSelect);
						}catch(SQLException e){
							e.printStackTrace();
						}%>
					
					<tr style="text-align:center">
						<td><%=reviewVo.getRes_no() %></td>
						<td><a href="<%=request.getContextPath()%>/detail/detail.jsp?no=<%=resNoForSelect%>">
						<%=resVo.getRes_name() %>
						</a></td>
						<td><%=reviewVo.getRev_content() %></td>
					<tr>	
					<!-- 반복되어 리스트출력하는 종료 -->
					<%}//for%>
				<%}//if %>
			</tbody>
		</table>
		<div class="divPage center">
		<!-- 이전블럭으로 이동 -->
		<%
			if(pageVo.getFirstPage()>1){ %>
				<a href="<%=request.getContextPath()%>/menu/menuList.jsp?currentPage=<%=pageVo.getFirstPage()-1 %>">
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
					<a href="<%=request.getContextPath()%>/menu/menuList.jsp?currentPage=<%=i%>">[<%=i %>]</a>	
			<%} %>
				
		<%	}%>
		<!--  페이지 번호 끝 -->
		<!--  다음 블럭으로 이동 -->
		<%	if(pageVo.getLastPage()<pageVo.getTotalPage()) { %>
			<a href="<%=request.getContextPath()%>/menu/menuList.jsp?currentPage=<%=pageVo.getLastPage()+1 %>">
					<img src="<%=request.getContextPath()%>/images/last.JPG">
				</a>
		<%	} %>
		</div>
	</div>
</main>

<%@ include file="/inc/Bottom.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<!-- 메뉴 블럭 시작 -->
	<div class="resMenu item2 grid4" id="menuGr">
	<%
		List<MenuDetailVO> imgList=null;	
		try{
			imgList=menuService.selectByResNo(Integer.parseInt(no));
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
		<%if(imgList==null || imgList.isEmpty()){ %>
	  		데이터가 없습니다.
	  	<%}else{ %>
			<!-- 반복되어 리스트출력하는 시작 -->
			<%
			if(imgList.size()<3){
				for(int i=0;i<imgList.size();i++){ 
					menuDetailVo=imgList.get(i);%>
				<div class="menu" id="menu">
					<img src="<%=request.getContextPath()+"/img_upload/"+menuDetailVo.getImg_filename()%>"
						class="menu_image">
					<div class="menu_title hover" id="menuCnt">
						<p><%=menuDetailVo.getMenu_name() %></p>
						<p><%=menuDetailVo.getMenu_price() %></p>
					</div>
				</div>
			<!-- 반복되어 리스트출력하는 종료 -->
			<%}//for
			}else if(imgList.size()>=3){
				for(int i=0;i<3;i++){ 
					menuDetailVo=imgList.get(i);%>
				<div class="menu" id="menu">
					<img src="<%=request.getContextPath()+"/img_upload/"+menuDetailVo.getImg_filename()%>"
						class="menu_image">
					<div class="menu_title hover" id="menuCnt">
						<p><%=menuDetailVo.getMenu_name() %></p>
						<p><%=menuDetailVo.getMenu_price() %></p>
					</div>
				</div>
			<%}//if
			}//for	
		}//if %>
	</div>
	<!-- 메뉴 블럭 종료 -->
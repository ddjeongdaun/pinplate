<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.menu.model.MenuService"%>
<%@page import="com.menu.model.MenuVO"%>
<%@page import="com.image.model.ImageVO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>menuEdit_ok.jsp</title>
</head>
<body>
<%
	//MultipartRequest 객체 생성 성공 => 업로드 완료
	//실패 =? IOException 발생(파일 용량 초과 등)
	
	String upDir="img_upload";	//업로드할 폴더, 톰캣 업로드하여 배포시는 이렇게 작성
	//업로드할 폴더의 절대 경로 구하기
	String saveDir = application.getRealPath(upDir);
	System.out.println("1. savdDir="+saveDir);
	
	saveDir = config.getServletContext().getRealPath(upDir);
	System.out.println("2. savdDir="+saveDir);
	
	//테스트용 경로설정 - 현재설정
	saveDir="C:\\lecture\\workspace_list\\proj_ws\\pinplate\\src\\main\\webapp\\img_upload";
	System.out.println("3. savdDir="+saveDir);
	
	int maxSize=5*1024*1024;	//업로드 최대용량, 5M로 제한
	
	//업로드시 동일한 파일명이 있을 경우 나중에 업로드한 파일에 번호를 붙여 구분해줌
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();	
	
	ImageVO imageVo = new ImageVO();
	MenuVO menuVo = new MenuVO(); 	
	MenuService menuService = new MenuService();

try{
	//menuEdit.jsp에서 post 방식으로 서브밋됨
	File savefile=new File(saveDir);
	if(!savefile.exists()){
		savefile.mkdirs();
	}
	MultipartRequest mr = new MultipartRequest(request, saveDir, maxSize,
			"utf-8", policy);			
	out.print("업로드 완료!<br>");
	//이시점에서 파일은 저장되어있음
	//mr이 들고있는값: [음식점이름,메뉴이름,가격,업로드할때파일명,업로드되어저장된파일명, 타입명]
		
	//1.요청 파라미터 가져오기
	File file = null;
	file = mr.getFile("fileName");
	
	//메뉴
	String menuNo=mr.getParameter("menuNo");
	String resNo=mr.getParameter("resNo");
	String menuName=mr.getParameter("menuName");
	String menuPrice=mr.getParameter("menuPrice");
	String resAdm=mr.getParameter("resAdm");
	
	//세팅
	menuVo.setRes_no(Integer.parseInt(resNo));
	menuVo.setMenu_no(Integer.parseInt(menuNo));
	menuVo.setMenu_name(menuName);
	menuVo.setMenu_price(Integer.parseInt(menuPrice));
	menuVo.setReg_adm(Integer.parseInt(resAdm));
	
	//이미지
	if(file!=null){	
		String tb_type_no=mr.getParameter("tb_type_no");
		String fileName = mr.getFilesystemName("fileName");	//업로드된 파일명
		String originalFName = mr.getOriginalFileName("fileName");//변경전 파일명
		long fileSize=file.length();
		
		//세팅
		imageVo.setTb_type(Integer.parseInt(tb_type_no));
		imageVo.setImg_filename(fileName);
		imageVo.setImg_originalfilename(originalFName);
		
		String img_no=mr.getParameter("imgNo");
		imageVo.setImg_no(Integer.parseInt(img_no));
		
		imageVo.setTb_no(Integer.parseInt(menuNo)); //수정시에는 현재 메뉴의 기본키를 가져옮
	}

	//2
	int cnt=menuService.updateMenu(imageVo, menuVo);

	//3
	if(cnt>0){ %>
	<script type="text/javascript">
		alert('메뉴가 수정되었습니다');
		location.href="<%=request.getContextPath()%>/menu/menuList.jsp";
	</script>
	<%}else{%>
		<script type="text/javascript">
			alert('메뉴 수정 실패');
			history.back();
		</script>
	<%}	
}catch(IOException e){
	System.out.println("5M 이상의 파일은 업로드 불가!");
	e.printStackTrace();
}		
%>

</body>
</html>
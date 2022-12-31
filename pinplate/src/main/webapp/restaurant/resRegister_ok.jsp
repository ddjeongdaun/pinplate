<%@page import="com.member.model.memberVO"%>
<%@page import="com.pinplate.restaurant.model.RestaurantVO"%>
<%@page import="com.image.model.ImageVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.common.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="resService" class="com.pinplate.restaurant.model.RestaurantService" scope="session"></jsp:useBean>
<%
	String uploadFile=Utility.UPLOAD_DIR;
	//String saveDir=config.getServletContext().getRealPath(uploadFile);
	String saveDir=uploadFile;
	System.out.println("saveDir="+saveDir);
	
	saveDir="C:\\lecture\\workspace_list\\proj_ws\\pinplate\\src\\main\\webapp\\img_upload";
	
	System.out.println("3. savdDir="+saveDir);
	
	
	int maxSize=8*1024*1024;
	
	File savefile=new File(saveDir);
	if(!savefile.exists()){
		savefile.mkdirs();
	}
	
	
	MultipartRequest mr
		=new MultipartRequest(request,saveDir,maxSize,"utf-8",new DefaultFileRenamePolicy());
	//파일업로드됨

	Enumeration fnames = mr.getFileNames();
	//=>여러개 파일을 업로드하는 경우 파일이름 목록을 리턴함
	
	List<ImageVO>fileList=new ArrayList<>();
	ImageVO imgVo=new ImageVO();
	int tb_type=1;
	int res_cur_seq=resService.res_seq_curr();
	
	while(fnames.hasMoreElements()){
				String fname=(String)fnames.nextElement();
				//=>  upfile1, upfile2, upfile3
						
				String fileName=mr.getFilesystemName(fname);
				//=> 업로드된 파일의 이름(변경된 파일 이름)
				String originalFName = mr.getOriginalFileName(fname);
				//=> 변경전 원래 파일 이름
				File file = mr.getFile(fname);
				
				//테이블 타입,타입에 맞는 테이블(레스토랑)의 시퀸스마지막번호,저장된 이름,원래이름저장
				imgVo.setTb_type(tb_type);
				imgVo.setTb_no(res_cur_seq);
				imgVo.setImg_filename(fileName);
				imgVo.setImg_originalfilename(originalFName);
				
				fileList.add(imgVo);
				out.print("업로드된 파일명:"+ fileName+"<br>");
				out.print("원래 파일명:"+ originalFName+"<br>");
							
			}//while
			//현재 지점에서 파일은 모두 fileList에 vo형태로 저장되어있음
			
			//회원의 세션에 있는 기본키,권한조회
			String mem_id=(String)session.getAttribute("mem_id");
			int mem_no=(int)session.getAttribute("mem_no");
			String mem_auth=(String)session.getAttribute("mem_auth");
			
			System.out.println(mem_id);
			System.out.println(mem_no);
			System.out.println(mem_auth);
			
			
			memberVO memvo=new memberVO();
			memvo.setMem_no(mem_no);
			memvo.setMem_auth(mem_auth);
			
			//사진을 제외한 모든 정보 받아오기
			//mr로 받아야함
			String res_name=mr.getParameter("resName");
			String res_tel=mr.getParameter("resTel");
			String res_addr=mr.getParameter("hiddenAddr");
			String res_type=mr.getParameter("resType");
			String res_content=mr.getParameter("resContent");
			String res_x=mr.getParameter("resX");
			String res_y=mr.getParameter("resY");
			
			RestaurantVO resVo=new RestaurantVO();
			resVo.setRes_name(res_name);
			resVo.setRes_tel(res_tel);
			resVo.setRes_addr(res_addr);
			resVo.setRes_type(res_type);
			resVo.setRes_content(res_content);
			resVo.setRes_x(Double.parseDouble(res_x));
			resVo.setRes_y(Double.parseDouble(res_y));
			int cnt=
			resService.insertRes(resVo, memvo, fileList);
			if(cnt==fileList.size()){
				System.out.println("인서트성공");
				%>
				<script type="text/javascript">
				alert('음식점이 등록되었습니다');
				location.href="<%=request.getContextPath()%>/index.jsp";
			</script>
			<%
			}else{
				System.out.println("인서트 실패 cnt="+cnt+"fileList.size()="+fileList.size());
				%>
				<script type="text/javascript">
				alert('음식점 등록 실패');
				history.back();
			</script>
			<%}
			
	%>
</body>
</html>
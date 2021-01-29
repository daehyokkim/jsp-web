<!-- 로그인 시도 페이지  dao 응용-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="bbs.bbsDAO" %>
<%@ page import ="bbs.bbs" %>
<%@ page import ="java.io.PrintWriter" %> <!-- 자바 코드를 사용할 수 있도록 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터를 UTF-8형식으로 출력 --> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("alert('로그인을 하시오.')");
			script.println("location.href='login.jsp'"); //main.jsp요청
			script.println("</script>");
		
		}
		//spring MVC패턴으로 치면  ,@RequestParam("bbsNum")int bbsNum 이랑 같은 것 URL에 추가적인 데이터 전송
		int bbsNum = 0;
		if(request.getParameter("bbsNum") != null){
			bbsNum = Integer.parseInt(request.getParameter("bbsNum"));
		}
		if(bbsNum == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'"); //main.jsp요청
			script.println("</script>");
		}
		//반드시 존재 시 가능 , 받아온 글 담기
		bbs bbs = new bbsDAO().getbbs(bbsNum);
		if(!userID.equals(bbs.getBbsUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("alert('권한이 없습니다..')");
			script.println("location.href='bbs.jsp'"); //main.jsp요청
			script.println("</script>");
			
		} else{
			//빈을 사용하지 않기 떄문에 요청한 데이터가 정상적으로 넘어오는지 확인 해줘야한다.
			if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent")==null||
				request.getParameter("bbsTitle").equals("")|| request.getParameter("bbsContent").equals("")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('제목과 내용을 모두입력하십시오.')");
				script.println("<history.back()");				
				script.println("</script>");
			}
			bbsDAO bbsDAO = new bbsDAO();
			int result = bbsDAO.update(bbsNum,request.getParameter("bbsTitle"),request.getParameter("bbsContent") );
			
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글수정에 실패하였습니다.')");
				script.println("<history.back()");				
				script.println("</script>");

			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('수정 완료')");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}
		}
		
	%>
</body>
</html>
<!-- 로그인 시도 페이지  dao 응용-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="bbs.bbsDAO" %>
<%@ page import ="java.io.PrintWriter" %> <!-- 자바 코드를 사용할 수 있도록 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터를 UTF-8형식으로 출력 --> 
<jsp:useBean id="bbs" class="bbs.bbs" scope="page"/> <!-- 현재 페이지 안에서만 빈 사용 -->
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>
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
		else{
			
			if(bbs.getBbsTitle() == null || bbs.getBbsContent()==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력하지 않는 사항이 있습니다.')");
				script.println("<history.back()");				
				script.println("</script>");
			}
			bbsDAO bbsDAO = new bbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패하였습니다.')");
				script.println("<history.back()");				
				script.println("</script>");

			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기 완료')");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}
		}
		
	%>
</body>
</html>
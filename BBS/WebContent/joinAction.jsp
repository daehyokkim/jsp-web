<!-- 로그인 시도 페이지  dao 응용-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.userDAO" %>
<%@ page import ="java.io.PrintWriter" %> <!-- 자바 코드를 사용할 수 있도록 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터를 UTF-8형식으로 출력 --> 
<jsp:useBean id="user" class="user.user" scope="page"/> <!-- 현재 페이지 안에서만 빈 사용 -->
<jsp:setProperty name="user" property="id"/>
<jsp:setProperty name="user" property="pw"/>
<jsp:setProperty name="user" property="name"/>
<jsp:setProperty name="user" property="email"/>
<jsp:setProperty name="user" property="sex"/>
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
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.print("alert('이미 로그인이 되었습니다.')");
			script.println("location.href= 'main.jsp'"); //main.jsp요청
			script.println("</script>");
		
		}
		userDAO userDAO = new userDAO();
		int result = userDAO.join(user);
		if(user.getId()==null || user.getPw()==null||user.getEmail()==null||user.getName()==null||user.getSex()==null)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력하지 않은 정보가 있는지 확인하시오.')");
			script.println("history.back()");
			script.println("</script>");
			
		}
		else if(result == -1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("alert('이미 존재하는 아이디입니다..')");
			script.println("history.back()"); //로그인 페이지로 돌려보내기
			script.println("</script>");
		}
		else
		{
			PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("alert('회원가입 완료.')");
			script.println("location.href = 'login.jsp'"); //로그인 페이지로 돌려보내기
			script.println("</script>");
		}
	%>
</body>
</html>
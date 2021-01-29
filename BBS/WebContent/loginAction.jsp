<!-- 로그인 시도 페이지  dao 응용-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.userDAO" %>
<%@ page import ="java.io.PrintWriter" %> <!-- 자바 코드를 사용할 수 있도록 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터를 UTF-8형식으로 출력 --> 
<jsp:useBean id="user" class="user.user" scope="page"/> <!-- 현재 페이지 안에서만 빈 사용 -->
<jsp:setProperty name="user" property="id"/>
<jsp:setProperty name="user" property="pw"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		userDAO userDAO = new userDAO();
		int result = userDAO.login(user.getId(), user.getPw());
		if(result == 1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("location.href= 'main.jsp'"); //main.jsp요청
			script.println("</script>");
		}
		else if(result == 0)
		{
					PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("alert('비밀번호가 틀립니다.')"); //비밀번호 오류
			script.println("history.back()"); //로그인 페이지로 돌려보내기
			script.println("</script>");
		}
	
		else if(result == -1)
		{
					PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("alert('존재하지 않는 아이디입니다.')"); //아이디 오류
			script.println("history.back()"); //로그인 페이지로 돌려보내기
			script.println("</script>");
		}
		else if(result == -2)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("alert('데이터베이스 오류가 발생했습니다.')"); //데이터베이스 오류
			script.println("history.back()"); //로그인 페이지로 돌려보내기
			script.println("</script>");
		}
		else
		{
			PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("alert('error.')"); //데이터베이스 오류
			script.println("history.back()"); //로그인 페이지로 돌려보내기
			script.println("</script>");
		}
	%>
</body>
</html>
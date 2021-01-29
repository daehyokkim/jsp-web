<!-- 로그인 시도 페이지  dao 응용-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.userDAO" %>
<%@ page import ="java.io.PrintWriter" %> <!-- 자바 코드를 사용할 수 있도록 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
			session.invalidate();
			PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("alert('로그아웃')");//
			script.println("location.href= 'main.jsp'"); //main.jsp요청
			script.println("</script>");
	%>
</body>
</html>
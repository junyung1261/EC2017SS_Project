<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ec.member.memberDao" %>
<%
    request.setCharacterEncoding("euc-kr");
     int rst = 0;
     memberDao mdao = new memberDao();
     
     String id = (String)request.getParameter("mem_user_id");
     String pass = (String)request.getParameter("mem_password");
     rst = mdao.loginCheck(id, pass);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<body>
<%
 	if(rst == 2){
		session.setAttribute("loginId", id);
		session.setMaxInactiveInterval(60*60);
%>
		<script type="text/javascript">
		location.href="../adm_index.jsp";
		</script>
		
<%  }else if(rst == 1){ %>
		<script type="text/javascript">
		alert("잘못된 비밀번호 입니다.");
		history.go(-1);
		</script>
		
<%  }else{ %>
		<script type="text/javascript">
		alert("존재하지 않는 계정입니다.");
		history.go(-1);
		</script>
<%  } %>
</body>
</html>
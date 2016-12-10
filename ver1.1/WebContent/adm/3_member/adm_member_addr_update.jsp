<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "ec.member.*, ec.member_address.*" %>
<%
	request.setCharacterEncoding("EUC-kr");
	String loginId = (String)session.getAttribute("loginId");
	
	memberDao mdao = new memberDao();
	memberVo mvo = mdao.selectMember(loginId);
	
	int rst = 0;
%>    

<jsp:useBean id="madao" class="ec.member_address.member_addressDao" />
<jsp:useBean id="mavo" class="ec.member_address.member_addressVo" />
<jsp:setProperty property="*" name="mavo" />

<%	rst = madao.updateMemberAddress(mavo, mvo.getMem_id());

	if (rst > 0) {
%>
	<script type="text/javascript">
		alert("회원 정보 변경 성공");
		history.go(-1);
	</script>
<%
	} else {
%>
	<script type="text/javascript">
		alert("회원 정보 변경 중 오류가 발생하였습니다.");
		history.go(-1);
	</script>
<%
   }
%>
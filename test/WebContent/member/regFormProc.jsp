
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
     <%request.setCharacterEncoding("euc-kr"); %>  
    <jsp:useBean id="dao" class="my.member.MemberDao"/>
    <jsp:useBean id="vo" class="my.member.MemberVo"/>
 <jsp:setProperty property="*" name="vo"/>
<%
 int rst = 0;
 request.setCharacterEncoding("euc-kr");
 rst = dao.insertMember(vo);
 if(rst>0){
%>
<script type="text/javascript">
alert("회원가입 성공");
</script>
<%}else{ %>
<script type="text/javascript">
alert("회원가입 실패");
history.go(-1);
</script>
<%} %>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="dao" class="ec.company.companyDao" />
<jsp:useBean id="vo" class="ec.company.companyVo" />
<jsp:setProperty property="*" name="vo" />
<%
	int rst = 0;
	rst = dao.insertCompany(vo);
	if (rst > 0) {
%>
<script type="text/javascript">
	alert("��ü �߰� ����");
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("ȸ������ ����");
	history.go(-1);
</script>
<%
	}
%>

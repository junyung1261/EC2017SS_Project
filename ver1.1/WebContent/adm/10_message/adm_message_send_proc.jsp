<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="msgdao" class="ec.message.messageDao" />
<jsp:useBean id="msgvo" class="ec.message.messageVo" />
<jsp:setProperty property="*" name="msgvo" />
    
<%
	int[] rst = new int[2];
	
	rst[0] = msgdao.insertMessageSend(msgvo);
	rst[1] = msgdao.insertMessageReceive(msgvo);

	if (rst[0]*rst[1] > 0) {
%>
	<script type="text/javascript">
		alert("�޼����� �����Ͽ����ϴ�.");
		history.go(-1);
	</script>
<%
	} else {
%>
	<script type="text/javascript">
		alert("�޼��� ���� �� ������ �߻��Ͽ����ϴ�.");
		history.go(-1);
	</script>
<%
   }
%>
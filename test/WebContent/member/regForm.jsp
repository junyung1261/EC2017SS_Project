<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	function regChk() {
		document.form.submit();
	}
</script>

<script type="text/javascript">
function passchk(){
	 var pass = document.form.pass.value;
	 var pass2 = document.form.pass2.value;
	 if (pass2.length == 0 || pass2 == null) {
	  document.form.chk.value = "��й�ȣ�� �Է��ϼ���";
	 } else if (pass != pass2) {
	  document.form.chk.value = "��й�ȣ�� �ٸ��ϴ�.";
	 } else {   
	  document.form.chk.value = "��й�ȣ�� �����մϴ�.";
	 }
	 return;
	}
	
</script>


<link href="style/memberStyle.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ȸ������ â</title>
</head>
<body>
	<form action="regFormProc.jsp" name="form" method="post">
		<table width="1400" height="650">
			<tr>
				<td width="100%" height="10%"><span style="padding-left: 160px"><img
						src="../log/image/itbanklogo.png" width="200" height="60"
						border="0" align="middle"></span>&nbsp;ȸ������</td>
			</tr>
			<tr>
				<td height="15%"><span style="padding-left: 160px"> <img
						src="image/regTitle2.png" width="500" height="100" border="0">
				</span></td>
			</tr>
			<tr>
				<td height="60%" align="center" valign="top">
					<hr> <br>
					<p align="left" style="padding-left: 160px">
						<b>ITBANK ���������Է�</b> <br> <br> ID : <input type="text"
							size="10" maxlength="15" name="id"><br> <br>
						��й�ȣ : <input type="password" size="15" maxlength="20" name="pass"><br>
						<br>��й�ȣ Ȯ�� : <input type="password" size="15" maxlength="20"
							name="pass2" onblur="passchk()">&nbsp; <input type="text"
							style="border-width: 0px" size="20" name="chk"
							value="��й�ȣ�� �Է��ϼ���" readonly="readonly"> <br>
						<br> �̸��� : <input type="text" size="15" name="email1">@<input
							type="text" size="15" name="email2"><br> <br>
						�̸��� ���ſ��� : <input type="radio" name="sent" value="ok">
						������&nbsp;&nbsp; <input type="radio" name="sent" value="no">
						���Ű���<br> <br> �޴��� : <select name="ph1">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="019">019</option>
						</select> - <input type="text" name="ph2" size="5" maxlength="4"> -
						<input type="text" name="ph3" size="5" maxlength="4"><br>
						<br> ���� : <input type="radio" name="gender" value="����">
						����&nbsp;&nbsp; <input type="radio" name="gender" value="����">
						����<br> <br> ������� : <select name="birth1">
							<%
								for (int i = 2013; i >= 1900; i--) {
							%>
							<option value="<%=i%>"><%=i%></option>
							<%
								}
							%>
						</select>��&nbsp; <select name="birth2">
							<%
								for (int i = 1; i <= 12; i++) {
							%>
							<option value="<%=i%>"><%=i%></option>
							<%
								}
							%>
						</select> <select name="birth3">
							<%
								for (int i = 1; i <= 31; i++) {
							%>
							<option value="<%=i%>"><%=i%></option>
							<%
								}
							%>
						</select>��<br> <br> �ּ� : <input type="text" name="address"
							size="15" maxlength="15"><br> *�ּҴ� (��/��)�� �Է����ּ��� (��:
						��⵵, ����Ư����, ��󳲵� ��)
					</p>
				</td>
			</tr>
			<tr>
				<td align="center">
					<hr> <br> <input type="submit" value="���Խ�û"
					onclick="regChk()">&nbsp; <input type="reset" value="�ٽ��Է�">&nbsp;
					<input type="button" value="���">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>


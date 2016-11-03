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
	  document.form.chk.value = "비밀번호를 입력하세요";
	 } else if (pass != pass2) {
	  document.form.chk.value = "비밀번호가 다릅니다.";
	 } else {   
	  document.form.chk.value = "비밀번호가 동일합니다.";
	 }
	 return;
	}
	
</script>


<link href="style/memberStyle.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원가입 창</title>
</head>
<body>
	<form action="regFormProc.jsp" name="form" method="post">
		<table width="1400" height="650">
			<tr>
				<td width="100%" height="10%"><span style="padding-left: 160px"><img
						src="../log/image/itbanklogo.png" width="200" height="60"
						border="0" align="middle"></span>&nbsp;회원가입</td>
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
						<b>ITBANK 개인정보입력</b> <br> <br> ID : <input type="text"
							size="10" maxlength="15" name="id"><br> <br>
						비밀번호 : <input type="password" size="15" maxlength="20" name="pass"><br>
						<br>비밀번호 확인 : <input type="password" size="15" maxlength="20"
							name="pass2" onblur="passchk()">&nbsp; <input type="text"
							style="border-width: 0px" size="20" name="chk"
							value="비밀번호를 입력하세요" readonly="readonly"> <br>
						<br> 이메일 : <input type="text" size="15" name="email1">@<input
							type="text" size="15" name="email2"><br> <br>
						이메일 수신여부 : <input type="radio" name="sent" value="ok">
						수신함&nbsp;&nbsp; <input type="radio" name="sent" value="no">
						수신거절<br> <br> 휴대폰 : <select name="ph1">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="019">019</option>
						</select> - <input type="text" name="ph2" size="5" maxlength="4"> -
						<input type="text" name="ph3" size="5" maxlength="4"><br>
						<br> 성별 : <input type="radio" name="gender" value="남자">
						남자&nbsp;&nbsp; <input type="radio" name="gender" value="여자">
						여자<br> <br> 생년월일 : <select name="birth1">
							<%
								for (int i = 2013; i >= 1900; i--) {
							%>
							<option value="<%=i%>"><%=i%></option>
							<%
								}
							%>
						</select>년&nbsp; <select name="birth2">
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
						</select>일<br> <br> 주소 : <input type="text" name="address"
							size="15" maxlength="15"><br> *주소는 (시/도)만 입력해주세요 (예:
						경기도, 서울특별시, 경상남도 등)
					</p>
				</td>
			</tr>
			<tr>
				<td align="center">
					<hr> <br> <input type="submit" value="가입신청"
					onclick="regChk()">&nbsp; <input type="reset" value="다시입력">&nbsp;
					<input type="button" value="취소">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>


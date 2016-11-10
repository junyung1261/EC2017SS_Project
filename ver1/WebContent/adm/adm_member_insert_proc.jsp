
<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page import = "java.util.*"%>
<%@ page import = "ec.member.*" %>
<%@ page import = "ec.member_address.*" %>
<%@ page import = "ec.mileage_charge.*" %>
<%@ page import = "ec.member_ec_charge.*" %>
<%@ page import = "ec.rel.*" %>

<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="mdao" class="ec.member.memberDao" />
<jsp:useBean id="mvo" class="ec.member.memberVo" />
<jsp:setProperty property="*" name="mvo" />

<jsp:useBean id="madao" class="ec.member_address.member_addressDao" />
<jsp:useBean id="mavo" class="ec.member_address.member_addressVo" />
<jsp:setProperty property="*" name="mavo" />

<jsp:useBean id="mcdao" class="ec.mileage_charge.mcDao" />
<jsp:useBean id="mcvo" class="ec.mileage_charge.mcVo" />
<jsp:setProperty property="*" name="mcvo" />

<jsp:useBean id="mecdao" class="ec.member_ec_charge.mecDao" />
<jsp:useBean id="mecvo" class="ec.member_ec_charge.mecVo" />
<jsp:setProperty property="*" name="mecvo" />

<%	int mem_id = mdao.nextInsertMemberId();
    System.out.println(mvo.getMem_user_id());
	int rst = 0;  //total error
	int rst1 = 0; //insert member error
   	int rst2 = 0; //insert memer_delivery error
   	int rst3 = 0; //insert member_mileage_charge error
   	int rst4 = 0; //insert member_ec_charge error
	///////////////////////////////////////////////////////////////////////////
	System.out.println("member ����");
	rst1 = mdao.insertMember(mvo);  
	///////////////////////////////////////////////////////////////////////////
	System.out.println("member_address ����");
	rst2 = madao.insertMemberAddress(mavo, mem_id); 
	///////////////////////////////////////////////////////////////////////////
	System.out.println("member_mileage_charge ����");	//���� �� ���ϸ��� ���� 0�� ����
   	rst3 = mcdao.mileageCharge(mcvo, mem_id);
	///////////////////////////////////////////////////////////////////////////
	System.out.println("member_ec_charge ����");	//���� �� ���� 0�� ����
   	rst4 = mecdao.insertMemberECCharge(mecvo, mem_id);
	///////////////////////////////////////////////////////////////////////////
	
	rst = rst1 * rst2 * rst3 * rst4  ;
   
	if (rst > 0) {
%>
<script type="text/javascript">
	alert("ȸ�� �߰� ����");
	history.go(-1);
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("ȸ�� �߰� �� ������ �߻��Ͽ����ϴ�.");
	history.go(-1);
</script>
<%
   }
%>
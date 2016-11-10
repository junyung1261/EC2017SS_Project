
<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page import = "java.util.*"%>
<%@ page import = "ec.member.*" %>
<%@ page import = "ec.member_address.*" %>
<%@ page import = "ec.member_mileage_charge.*" %>
<%@ page import = "ec.member_ec_charge.*" %>
<%@ page import = "ec.rel.*" %>

<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="mdao" class="ec.member.memberDao" />
<jsp:useBean id="mvo" class="ec.member.memberVo" />
<jsp:setProperty property="*" name="mvo" />

<jsp:useBean id="madao" class="ec.member_address.member_addressDao" />
<jsp:useBean id="mavo" class="ec.member_address.member_addressVo" />
<jsp:setProperty property="*" name="mavo" />

<jsp:useBean id="mmcdao" class="ec.member_mileage_charge.mmcDao" />
<jsp:useBean id="mmcvo" class="ec.member_mileage_charge.mmcVo" />
<jsp:setProperty property="*" name="mmcvo" />

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
	System.out.println("member 진입");
	rst1 = mdao.insertMember(mvo);  
	///////////////////////////////////////////////////////////////////////////
	System.out.println("member_address 진입");
	rst2 = madao.insertMemberAddress(mavo, mem_id); 
	///////////////////////////////////////////////////////////////////////////
	System.out.println("member_mileage_charge 진입");	//가입 시 마일리지 최초 0원 설정
   	rst3 = mmcdao.insertMemberMileageCharge(mmcvo, mem_id);
	///////////////////////////////////////////////////////////////////////////
	System.out.println("member_ec_charge 진입");	//가입 시 최초 0원 설정
   	rst4 = mecdao.insertMemberECCharge(mecvo, mem_id);
	///////////////////////////////////////////////////////////////////////////
	
	rst = rst1 * rst2 * rst3 * rst4  ;
   
	if (rst > 0) {
%>
<script type="text/javascript">
	alert("회원 추가 성공");
	history.go(-1);
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("회원 추가 중 오류가 발생하였습니다.");
	history.go(-1);
</script>
<%
   }
%>
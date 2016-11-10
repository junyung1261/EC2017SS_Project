
<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page import = "java.util.*"%>
<%@ page import = "ec.date.*" %>
<%@ page import = "ec.member.*,ec.member_address.*" %>
<%@ page import = "ec.mileage_charge.*, ec.mileage_pay.*, ec.mileage_total.*" %>
<%@ page import = "ec.ec_charge.*,ec.ec_pay.*,ec.ec_refund.*,ec.ec_total.*" %>
<%@ page import = "ec.rel.*" %>

<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="mdao" class="ec.member.memberDao" />
<jsp:useBean id="mvo" class="ec.member.memberVo" />
<jsp:setProperty property="*" name="mvo" />

<jsp:useBean id="madao" class="ec.member_address.member_addressDao" />
<jsp:useBean id="mavo" class="ec.member_address.member_addressVo" />
<jsp:setProperty property="*" name="mavo" />

<%	int mem_id = mdao.nextInsertMemberId();
	dateDao d = new dateDao();
	dateVo v = d.getToday();
	String now = v.getMonth()+"/"+v.getDate()+"/"+v.getYear()+" "+v.getHour()+":"+v.getMinute()+":"+v.getSecond();
	
    System.out.println(mvo.getMem_user_id());
    
	int rst = 0;  //total error
	int rst1 = 0; //insert member error
   	int rst2 = 0; //insert memer_delivery error
   	int rst3 = 0; //insert mileage_charge initialize error
   	int rst4 = 0; //insert mileage_pay initialize error
   	int rst5 = 0; //insert mileage_total initialize error
   	int rst6 = 0; //insert ec_charge initialize error
   	int rst7 = 0; //insert ec_pay initialize error
   	int rst8 = 0; //insert ec_refund initialize error
   	int rst9 = 0; //insert ec_total initialize error
   	
	///////////////////////////////////////////////////////////////////////////
	System.out.println("member 진입");
	rst1 = mdao.insertMember(mvo);  
	///////////////////////////////////////////////////////////////////////////
	System.out.println("member_address 생성");
	rst2 = madao.insertMemberAddress(mavo, mem_id); 
	///////////////////////////////////////////////////////////////////////////
	System.out.println("mileage_charge 생성");	//가입 시 마일리지 최초 0원 설정
	mcDao mcdao = new mcDao();
   	rst3 = mcdao.mileageChargeInitial(mem_id,now);
	///////////////////////////////////////////////////////////////////////////
	System.out.println("mileage_pay 생성");	//가입 시 마일리지 최초 0원 설정
	mpDao mpdao = new mpDao();
	rst4 = mpdao.mileagePayInitial(mem_id,now);
	///////////////////////////////////////////////////////////////////////////
	System.out.println("mileage_total 생성");	//가입 시 마일리지 최초 0원 설정
	mtDao mtdao = new mtDao();
	rst5 = mtdao.mileageTotalInitial(mem_id,now);
	///////////////////////////////////////////////////////////////////////////
	System.out.println("ec_charge 생성");	    //가입 시 최초 0원 설정
	ecDao ecdao = new ecDao();
   	rst6 = ecdao.ecChargeInitial(mem_id, now);
	///////////////////////////////////////////////////////////////////////////
	System.out.println("ec_charge 생성");	    //가입 시 최초 0원 설정
	epDao epdao = new epDao();
   	rst7 = epdao.ecPayInitial(mem_id, now);
	///////////////////////////////////////////////////////////////////////////
	System.out.println("ec_total 생성");	//가입 시 최초 0원 설정
	erDao erdao = new erDao();
	rst8 = erdao.ecRefundInitial(mem_id, now); 
	///////////////////////////////////////////////////////////////////////////
	System.out.println("ec_total 생성");	//가입 시 최초 0원 설정
	etDao etdao = new etDao();
   	rst9 = etdao.ecTotalInitial(mem_id, now); 
	///////////////////////////////////////////////////////////////////////////
	rst = rst1 * rst2 * rst3 * rst4 * rst5 * rst6 * rst7 * rst8 * rst9 ;
   
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
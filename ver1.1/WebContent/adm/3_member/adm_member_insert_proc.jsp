
<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page import = "java.util.*"%>
<%@ page import = "ec.date.*" %>
<%@ page import = "ec.member.*,ec.member_address.*, ec.member_account.*, ec.member_grade.*" %>
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

<jsp:useBean id="macdao" class="ec.member_account.member_accountDao" />
<jsp:useBean id="macvo" class="ec.member_account.member_accountVo" />
<jsp:setProperty property="*" name="macvo" />

<%	int mem_id = mdao.nextInsertMemberId();
	dateDao d = new dateDao();
	dateVo v = d.getToday();
	String now = v.getMonth()+"/"+v.getDate()+"/"+v.getYear()+" "+v.getHour()+":"+v.getMinute()+":"+v.getSecond();

	int[] rst = new int[12];

	rst[0]=1;
	///////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("member 柳涝");
	rst[1] = mdao.insertMember(mvo);											  //insert member error
	///////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("member_address 积己");
	rst[2] = madao.insertMemberAddress(mavo, mem_id);					  //insert member_address error
	///////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("member_account 积己");
	rst[3] = macdao.insertMemberAccount(macvo, mem_id, now);			  //insert member_account error
	///////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("member_grade 积己");
	member_gradeDao mgdao = new member_gradeDao();
	rst[4] = mgdao.memberGradeInitial(mem_id, now);						  //insert member_account error
	///////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("mileage_charge 积己");
	mcDao mcdao = new mcDao();
   	rst[5] = mcdao.mileageChargeInitial(mem_id,now);		   //insert mileage_charge initialize error
	///////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("mileage_pay 积己");
	mpDao mpdao = new mpDao();
	rst[6] = mpdao.mileagePayInitial(mem_id,now);			      //insert mileage_pay initialize error
	///////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("mileage_total 积己");	
	mtDao mtdao = new mtDao();
	rst[7] = mtdao.mileageTotalInitial(mem_id,now);				//insert mileage_total initialize error
	///////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("ec_charge 积己");	 
	ecDao ecdao = new ecDao();
   	rst[8] = ecdao.ecChargeInitial(mem_id, now);					//insert ec_charge initialize error
	///////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("ec_pay 积己");	 
	epDao epdao = new epDao();
   	rst[9] = epdao.ecPayInitial(mem_id, now);						   //insert ec_pay initialize error
	///////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("ec_refund 积己");	
	erDao erdao = new erDao();
	rst[10] = erdao.ecRefundInitial(mem_id, now);					//insert ec_refund initialize error
	///////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("ec_total 积己");
	etDao etdao = new etDao();
   	rst[11] = etdao.ecTotalInitial(mem_id, now);					 //insert ec_total initialize error
	///////////////////////////////////////////////////////////////////////////////////////////////////
	
	for(int i=1;i==11;i++){
		rst[0] = rst[0]*rst[i];
	}

   
	if (rst[0] > 0) {
%>
<script type="text/javascript">
	alert("雀盔 眠啊 己傍");
	history.go(-1);
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("雀盔 眠啊 吝 坷幅啊 惯积窍看嚼聪促.");
	history.go(-1);
</script>
<%
   }
%>
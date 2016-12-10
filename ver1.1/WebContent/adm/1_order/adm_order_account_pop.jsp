<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="ec.date.*"%>
<%@ page import="ec.product.*,ec.product_detail.*"%>
<%@ page import="ec.member_address.*"%>
<%@ page import="ec.mileage_total.*"%>
<%@ page import="ec.ec_total.*"%>
<%@ page import="ec.color.*"%>
<%@ page import="ec.member.*"%>
<%@ page import="ec.order.*"%>
<%@ page import="ec.cart.*"%>
<%@ page import="ec.rel.*"%>
<%@ page import="ec.company.*"%>

<%
	request.setCharacterEncoding("euc-kr");
	dateDao ddao = new dateDao();
	member_addressDao madao = new member_addressDao();
	member_addressVo mavo = madao.getMemberInfo(1);
		
	String now =  ddao.now();
	
			
	int mem_id = mavo.getMa_id(); // 로그인 회원 1이라고 가정.
	ArrayList<String> co_id_list = new ArrayList<String>();
		
	productDao pdao = new productDao();
	product_detailDao pddao = new product_detailDao();
	relDao rdao = new relDao();
	companyDao cdao = new companyDao();	

	ArrayList<product_detailVo> pdd_id_list = new ArrayList<product_detailVo>();

	if (request.getHeader("referer").contains("order_insert_pop")) {

		productVo pvo = new productVo();
		product_detailVo pdvo = new product_detailVo();

		pvo = pdao.getProductInfo(Integer.parseInt(request.getParameter("pd_id")));
		pdvo = pddao.getPdd_info(pvo.getPd_id(), request.getParameter("opt_col"), request.getParameter("opt_size"));
		pdvo.setPdd_stk_count(Integer.parseInt(request.getParameter("opt_count")));

		pdd_id_list.add(pdvo);

	} else {
		String[] set = request.getParameterValues("table_records[]");

		for (int i = 0; i < set.length; i++) {
			String[] parse = set[i].split(",");
			product_detailVo pdvo = new product_detailVo();
			pdvo = pddao.selectByPdd_id(Integer.parseInt(parse[1]));
	
			pdvo.setPdd_stk_count(Integer.parseInt(parse[2]));
			co_id_list.add(parse[3].replace("\"", ""));
			pdd_id_list.add(pdvo);
		}
	}
	
	HashSet<String> hs = new HashSet<String>(co_id_list);
	ArrayList<String> co_list = new ArrayList<String>(hs);

	for(String str : co_list) System.out.println(str);
	
	ArrayList<Integer> initial_ord_total = new ArrayList<Integer>();
	ArrayList<Integer> delPrice = new ArrayList<Integer>();
	int totalPrice = 0;
	int total_mileage = 0;
	int total_deliveryPay = 0;
	
	etDao etdao = new etDao();
	mtDao mtdao = new mtDao();
	int avail_ec = etdao.getTotal(mem_id);
	int avail_mil = mtdao.getTotal(mem_id);
	int avail = avail_ec + avail_mil;
	
	
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-kr">
<!-- Meta, title, CSS, favicons, etc. -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">


<!-- Bootstrap -->
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<!-- NProgress -->
<link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
<!-- Select2 -->
<link href="../vendors/select2/dist/css/select2.min.css" rel="stylesheet">
<!-- Custom Theme Style -->
<link href="../build/css/custom.min.css" rel="stylesheet">
</head>

<body class="" style="overflow-x: hidden; overflow-y: auto">
	<div class="container body">
		<div class="main_container">
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="row">
						<div class="col-md-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>상품주문</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<br />
									<form name="orderInfo" action="adm_order_admission_proc.jsp" method="post" class="form-horizontal form-label-left">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<div class="x_panel">
												<div class="x_title">
													<h2>상품정보 <small></small></h2>
													<div class="clearfix"></div>
												</div>
												<div class="x_content">
												<%	int i=0;
													if(co_list.size()==0) co_list.add("one_set");
													for(String str: co_list) {%> 배송그룹 <%=i+1 %>
													<table class="table table-bordered">
														<thead>
														<tr>
															<th>상품정보</th>
															<th>상품금액/수량</th>
															<th>주문금액/적립금</th>
														</tr>
														</thead>
														<tbody>
													<%	int groupPrice=0;
														String co_id = null;
														int pd_count_in_co=0;
														for (product_detailVo pdvo : pdd_id_list) {
															
															productVo pvo = pdao.getProductInfo(pddao.selectByPdd_id(pdvo.getPdd_id()).getPd_id());
															co_id = rdao.getCoByPd(pdvo.getPd_id());
															if(co_id.equalsIgnoreCase(str) || co_list.size()==1){
																totalPrice += pvo.getPd_price() * pdvo.getPdd_stk_count();
																pd_count_in_co++;
													%>
														<tr>
														<td><%=co_id%>/<%=pvo.getPd_name()%><br />
															옵션&nbsp;:&nbsp;<%=pdvo.getCol_id()%>/ <%=pdvo.getSz_id()%>
															<input type="hidden" name="co_id" value="<%=co_id%>">
															<input type="hidden" name="pd_id" value="<%=pvo.getPd_id()%>">
															<input type="hidden" name="pdd_id" value="<%=pdvo.getPdd_id()%>">
														</td>
														<td><%=pvo.getPd_price()%>원 <br /><%=pdvo.getPdd_stk_count()%>&nbsp;개&nbsp;
															<input type="hidden" name="ord_count" value="<%=pdvo.getPdd_stk_count()%>">
														</td>	
														<td rowspan=2>
															<input type="text" id="ord_total_price" name="ord_price" value="<%=pvo.getPd_price() * pdvo.getPdd_stk_count()%>" class="form-control" readonly>원 
															<input type="hidden" name="ord_total_price" value="<%=pvo.getPd_price() * pdvo.getPdd_stk_count()%>">
															<br /> <%=pvo.getPd_price() * pdvo.getPdd_stk_count() * 0.02%>
															<br />
														</td>
															<%	groupPrice += pvo.getPd_price() * pdvo.getPdd_stk_count();
																initial_ord_total.add(pvo.getPd_price() * pdvo.getPdd_stk_count());
															%>
														</tr>
														<tr>
														<td colspan=2>EC_Money사용
															<input type="text" id="ord_use_mileage" name="ord_use_mileage" class="form-control" value=0 onkeyup="calTotal()" placeholder="<%=avail%>">
														</td>
														</tr>
														<%}
														}%><input type="hidden" name="pro_index" value="<%=pd_count_in_co%>">
														<tr><%
															int deliveryPay=0;
															companyVo cvo = cdao.getCompanyInfo(co_id);
															if(cvo.getCo_delivery()==0) deliveryPay=0;
															else {
																if(groupPrice >= cvo.getCo_delivery_condition()) deliveryPay=0;
																//else if(exceptionChk==1) deliveryPay = cvo.getCo_delivery_exception();
																else deliveryPay = cvo.getCo_delivery_base();
																delPrice.add(deliveryPay);
																total_deliveryPay += deliveryPay;
															}
															%>
														<td colspan=2>
														<input type="radio" id="ord_delivery_method<%=i %>" name="ord_delivery_method<%=i %>" onclick="delChange(<%=i %>, this.value)" value="0" checked>선결제
														<input type="radio" id="ord_delivery_method<%=i %>" name="ord_delivery_method<%=i %>" onclick="delChange(<%=i %>, this.value)" value="1" >착불
														</td>
														<td>배송비<input type="text" id="ord_delivery_pay" name="ord_delivery_pay" value="<%=deliveryPay%>" class="form-control" readonly>원</td>
														</tr>
														</tbody>
													</table>
												<%i++;}%>
												<input type="hidden" name="del_index" value="<%=i%>">
											</div>
										</div>
										</div>

										<div class="col-md-12 col-sm-12 col-xs-12">
											<div class="x_panel">
												<div class="x_title">
													<h2>
														할인/EC-money 사용 <small></small>
													</h2>

													<div class="clearfix"></div>
												</div>
												<div class="x_content">

													<table class="table table-bordered">

														<tbody>

															<tr>

																<td>쿠폰 할인</td>
																
															</tr>
															<tr>

																<td>EC-money 사용<input type="text"
																	id="or_total_mileage" name="or_total_mileage"
																	class="form-control" value=0 readonly>원
																</td>

															</tr>
															<tr>

																<td>상품금액: <input type="text"
																	id="or_price"  class="form-control"
																	value="<%=totalPrice%>" readonly>원 <input
																	type="hidden" name="or_total_price"
																	value="<%=totalPrice%>">
																</td>
															</tr>
															<tr>

																<td>총 배송금액: <input type="text"
																	id="or_del_price" name="or_total_delivery_price"" class="form-control"
																	value="<%=total_deliveryPay%>" readonly>원 
																
																</td>
															</tr>
															<tr>

																<td>총 주문금액: <input type="text"
																	id="or_final_price" name="or_account_value" class="form-control"
																	value="<%=total_deliveryPay + totalPrice%>" readonly>
																	
																</td>
															</tr>
														</tbody>
													</table>

												</div>
											</div>
										</div>

										<div class="col-md-12 col-sm-12 col-xs-12">
											<div class="x_panel">
												<div class="x_title">
													<h2>
														주문 정보<small></small>
													</h2>

													<div class="clearfix"></div>
												</div>
												<div class="x_content">

													<table class="table table-bordered">

														<tbody>

															<tr>

																<td>수령인/배송지명
																<input type="text"
																	 class="form-control"
																	value="<%=mavo.getMa_name_recipient()%>">
																</td>
																
																
															</tr>
															<tr>

																<td>휴대전화 <input type="text"
																	class="form-control"
																	value="<%=mavo.getMa_phone_recipient()%>"></td>
															</tr>
															<tr>

																<td colspan=2>전화번호</td>

															</tr>
															<tr>

																<td>이메일</td>
																
															</tr>

														</tbody>
													</table>

												</div>
											</div>
										</div>

										<div class="col-md-12 col-sm-12 col-xs-12">
											<div class="x_panel">
												<div class="x_title">
													<h2>
														배송지<small></small>
													</h2>

													<div class="clearfix"></div>
												</div>
												<div class="x_content">

													<table class="table table-bordered">

														<tbody>
															<tr>

																<td colspan=2>배송지 선택</td>

															</tr>
															<tr>

																<td>수령인
																<input type="text"
																	id="mem_name" name="mem_name" class="form-control"
																	value="<%=mavo.getMa_name_recipient()%>">
																</td>
															</tr>
															<tr>

																<td>휴대전화 <input type="text"
																	id="mem_phone" name="mem_phone" class="form-control"
																	value="<%=mavo.getMa_phone_recipient()%>"></td>
															</tr>
															<tr>

																<td colspan=2>전화번호</td>

															</tr>
															<tr>

																<td>배송지 주소
																<input type="text" name="mem_zipcode" class="form-control" value="<%=mavo.getMa_addr_zipcode()%>">
																 <input type="text" name="mem_address" class="form-control" value="<%=mavo.getMa_addr_base()%>">
																</td>
																
															</tr>

															<tr>

																<td>배송메모
																<input type="text" name="or_msg" class="form-control" value="">
																</td>
															</tr>

														</tbody>
													</table>

												</div>
											</div>
										</div>

										<div class="col-md-12 col-sm-12 col-xs-12">
											<div class="x_panel">
												<div class="x_title">
													<h2>
														결제 정보<small></small>
													</h2>

													<div class="clearfix"></div>
												</div>
												<div class="x_content">

													<table class="table table-bordered">

														<tbody>
															<tr>
															
																
																<td><label>결제수단</label>
																 <div class="col-md-10 col-sm-10 col-xs-12">
												                    <div class="radio">
												                      <label><input type="radio" value="0" id="or_account_method" name="or_account_method" onClick="calTotal();" checked>EC 결제&nbsp;&nbsp;</label>
											                          <label><input type="radio" value="1" id="or_account_method" name="or_account_method" onClick="calTotal();">휴대폰 소액결제</label>
											                          <label><input type="radio" value="2" id="or_account_method" name="or_account_method" onClick="calTotal();">신용카드</label>
											                          <label><input type="radio" value="3" id="or_account_method" name="or_account_method" onClick="calTotal();">실시간 계좌이체</label>
											                          <label><input type="radio" value="4" id="or_account_method" name="or_account_method" onClick="calTotal();">무통장 입금</label>
											                        </div>
												                  </div>
												                  
																</td>
																
															</tr>
															<tr>

																<td>주문자 동의</td>
																
															</tr>
														</tbody>
													</table>

												</div>
											</div>
										</div>

 <div class="ln_solid"></div>
                    <div class="form-group">
                      <div class="col-md-12 col-sm-12 col-xs-12" >
                        <input type="submit" class="btn btn-primary pull-right" value="결제하기">
                        <input type="hidden" name="or_account_time" value=<%=now %>>
                      </div>
                    </div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /page content -->

		</div>
	</div>

	<!-- jQuery -->
	<script src="../vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- FastClick -->
	<script src="../vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="../vendors/nprogress/nprogress.js"></script>
	<!-- Select2 -->
	<script src="../vendors/select2/dist/js/select2.full.min.js"></script>
	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>


	<script language="javascript">
		function calTotal() {

			var or_total = document.getElementById("or_price");
			var or_mileage = document.getElementById("or_total_mileage");
			var ord_total = document.getElementsByName("ord_price");
			var mil_value = document.getElementsByName("ord_use_mileage");
			var final_price = document.getElementById("or_final_price");
			var total_del = document.getElementById("or_del_price");

			var initialPrice = <%=initial_ord_total%>;
			var finalPrice = 0;
			var totalPrice = 0;
			var totalMileage = 0;

			for (i = 0; i < initialPrice.length; i++) {

				finalPrice = initialPrice[i] - mil_value[i].value;
				ord_total[i].value = finalPrice;
				totalPrice += finalPrice;
				totalMileage += parseInt(mil_value[i].value);
			}

			or_mileage.value = totalMileage;
			or_total.value = totalPrice;
			final_price.value = totalPrice + parseInt(total_del.value);
		}
	</script>
<script>
function delChange(index, check){
	
	
	
	var x = index;
	var val = check;
	var original_price = <%=delPrice%>;
	var final_del = 0;
	var del_price = document.getElementsByName("ord_delivery_pay");
	var total_del = document.getElementById("or_del_price");
	var total_price = document.getElementById("or_final_price");
	var order_price = document.getElementById("or_price");
	
	
	if(check == 0){
		
		del_price[x].value = original_price[x];	
	}
	else{
		
		del_price[x].value = 0;
	}
	
	for(i=0; i<del_price.length; i++){
		final_del += parseInt(del_price[i].value);
	}
	
	total_del.value = final_del;
	
	total_price.value = parseInt(order_price.value) + final_del;
	
}


</script>
	<script language="javascript">
	function ec_check
	
	
	
	</script>


</body>
</html>
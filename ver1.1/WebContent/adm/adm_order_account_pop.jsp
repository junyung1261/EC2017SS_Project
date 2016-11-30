<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="ec.date.*"%>
<%@ page import="ec.product.*,ec.product_detail.*"%>
<%@ page import="ec.member_address.*"%>
<%@ page import="ec.delivery.*"%>
<%@ page import="ec.mileage_total.*"%>
<%@ page import="ec.color.*"%>
<%@ page import="ec.member.*"%>
<%@ page import="ec.order.*"%>
<%@ page import="ec.cart.*"%>
<%@ page import="ec.rel.*"%>

<%
	request.setCharacterEncoding("euc-kr");
	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();

	member_addressDao madao = new member_addressDao();
	member_addressVo mavo = madao.getMemberInfo(1);

	
		
	String now =  dvo.getMonth() + "/" + dvo.getDate() + "/" + dvo.getYear() + " " + dvo.getHour() + ":"
				+ dvo.getMinute() + ":" + dvo.getSecond();
	
	
			
	int mem_id = mavo.getMa_id(); // 로그인 회원 1이라고 가정.
	ArrayList<String> co_id_list = new ArrayList<String>();
		
	productDao pdao = new productDao();
	product_detailDao pddao = new product_detailDao();

	deliveryDao dedao = new deliveryDao();
	relDao rdao = new relDao();

	ArrayList<product_detailVo> pdd_id_list = new ArrayList<product_detailVo>();

	if (request.getHeader("referer").contains("order_insert_pop")) {

		productVo pvo = new productVo();
		product_detailVo pdvo = new product_detailVo();

		pvo = pdao.getProductInfo(Integer.parseInt(request.getParameter("pd_id")));
		pdvo = pddao.getPdd_info(pvo.getPd_id(), request.getParameter("opt_col"),
				request.getParameter("opt_size"));
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
	int totalPrice = 0;
	int total_mileage = 0;
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-kr">
<!-- Meta, title, CSS, favicons, etc. -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">


<!-- Bootstrap -->
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link href="../vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
<!-- Select2 -->
<link href="../vendors/select2/dist/css/select2.min.css"
	rel="stylesheet">
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
									<form name="orderInfo" action="adm_order_admission_proc.jsp"
										method="post" class="form-horizontal form-label-left">

										<div class="col-md-12 col-sm-12 col-xs-12">
											<div class="x_panel">
												<div class="x_title">
													<h2>
														상품정보 <small></small>
													</h2>

													<div class="clearfix"></div>
												</div>
												<div class="x_content">
<%
															int i=1;
															for(String str: co_list)	{
															%>
													배송그룹 <%=i++ %>
													<table class="table table-bordered">
													
														<thead>
															<tr>
																
																<th>상품정보</th>
																<th>상품금액/수량</th>
																<th>주문금액/적립금</th>
															</tr>
														</thead>
														<tbody>
															
															<%
															for (product_detailVo pdvo : pdd_id_list) {
																	
																
																	productVo pvo = pdao.getProductInfo(pddao.selectByPdd_id(pdvo.getPdd_id()).getPd_id());

																	String co_id = rdao.getCoByPd(pdvo.getPd_id());
																	
																	
																	if(co_id.equalsIgnoreCase(str)){
																		totalPrice += pvo.getPd_price() * pdvo.getPdd_stk_count();
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
																<td rowspan=2><input type="text" id="ord_total_price" name="ord_price" value="<%=pvo.getPd_price() * pdvo.getPdd_stk_count()%>"
																	class="form-control" readonly>원 
																	<input type="hidden" name="ord_total_price" value="<%=pvo.getPd_price() * pdvo.getPdd_stk_count()%>">
																	<br /> <%=pvo.getPd_price() * pdvo.getPdd_stk_count() * 0.02%>
																</td>
																<%
																	initial_ord_total.add(pvo.getPd_price() * pdvo.getPdd_stk_count());
																%>

															</tr>
															<tr>

																<td colspan=2>EC_Money사용<input type="checkbox"
																	value="1" id="mileage_check" name="mileage_check"
																	onclick='mil_check(this)'>사용 <input type="text"
																	id="ord_use_mileage" name="ord_use_mileage"
																	class="form-control" value=0 onkeyup="calTotal()">
																</td>
															</tr>
															<%}%>
															<%}%>
															

														</tbody>

													</table>
												<%}%>
													
															
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

																<td>총 상품금액: <input type="text"
																	id="or_price" name="or_account_value" class="form-control"
																	value="<%=totalPrice%>" readonly>원 <input
																	type="hidden" name="or_total_price"
																	value="<%=totalPrice%>">
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

			var initialPrice =<%=initial_ord_total%>;
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

		}
	</script>

	<script language="javascript">
		function mil_radio(e) {
			var fm = document.orderInfo;
			if (fm.ord_mileage[0].checked == true) {
				mil_div1.style.display = "none";
				document.getElementById('or_total_mileage').value = 0;
			} else if (ord_mileage[1].checked == true) {
				mil_div1.style.display = "block";
			}
			calTotal();
		}
	</script>

	<!-- Select2 -->
	<script>
		$(document).ready(function() {
			$(".select2_single").select2({
				placeholder : "항목을 선택하세요",
				allowClear : true
			});
			$(".select2_group").select2({});
			$(".select2_multiple").select2({
				maximumSelectionLength : 6,
				placeholder : "항목을 선택하세요",
				allowClear : true
			});
		});
	</script>

</body>
</html>
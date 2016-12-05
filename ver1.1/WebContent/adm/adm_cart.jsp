<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*"%>
<%@ page import="ec.cart.*"%>
<%@ page import="ec.member.*"%>
<%@ page import="ec.rel.*"%>
<%@ page import="ec.product.*,ec.product_detail.*"%>

<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	memberDao mdao = new memberDao();
	memberVo mvo = mdao.selectMember(1);
	
	cartDao cartDao = new cartDao();
	ArrayList<cartVo> cart_list = cartDao.getCart_List(mvo.getMem_id());

	productDao pdao = new productDao();
	product_detailDao pddao = new product_detailDao();
	relDao rdao = new relDao();
%>
<html lang="en">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>EC Corporation</title>

<!-- Bootstrap -->
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<!-- NProgress -->
<link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
<!-- iCheck -->
<link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
<!-- Custom Theme Style -->
<link href="../build/css/custom.min.css" rel="stylesheet">
</head>


<body class="nav-md">
	<div class="container body">
		<div class="main_container">

			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="clearfix"></div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h3>장바구니<small>Cart</small></h3>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<form name="form_cart" class="form-horizontal form-label-left">
										<div class="table-responsive">
											<table class="table table-striped jambo_table bulk_action">
												<thead>
													<tr class="headings">
														<th><input type="checkbox" id="allCheck"
															name="check-all" class="flat" onclick="CheckAll()"></th>
														<th class="column-title">상품정보</th>
														<th class="column-title">판매가/수량</th>
														<th class="column-title">주문수량</th>
														<th class="column-title no-link last"><span
															class="nobr">총가격</span></th>


													</tr>
												</thead>
												<tbody>
													<%
														for (cartVo cartvo : cart_list) {
															productVo pdvo = pdao.getProductInfo(pddao.selectByPdd_id(cartvo.getPdd_id()).getPd_id());
															product_detailVo pddvo = pddao.selectByPdd_id(cartvo.getPdd_id());
															String co_id = rdao.getCoByPd(pdvo.getPd_id());
													%>
													<tr>
														<td class="a-center ">
														<input type="checkbox" class="flat" id="record_id" name="table_records[]" value=<%=mvo.getMem_id()%>,<%=pddvo.getPdd_id()%>,<%=cartvo.getCart_count()%>,<%=co_id%>">
														</td>
														<td><%=co_id%>/<%=pdvo.getPd_name()%><br /><%=pddvo.getCol_id()%>/ <%=pddvo.getSz_id()%></td>
														<td><%=pdvo.getPd_price()%>원 <br /><%=cartvo.getCart_count()%>개</td>
														<td><%=cartvo.getCart_count()%></td>
														<td><%=pdvo.getPd_price() * cartvo.getCart_count()%>원</td>
													</tr>
													<%}%>

												</tbody>
											</table>
										</div>
										<div class="ln_solid"></div>
										<div class="form-group">
											<div class="col-md-12 col-sm-12 col-xs-12">
											<input type="button" class="btn btn-primary pull-right" value="주문하기" onClick="getPost('01')">
											 <input type="button" class="btn btn-primary pull-right" value="선택삭제" onClick="getPost('02')">
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

			<!-- footer content -->
			<%@include file="adm_footer.jsp"%>
			<!-- /footer content -->
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


	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>

	<script type=text/javascript>
		var check = false;
		function CheckAll() {
			var chk = document.getElementsByName("table_records[]");
			if (check == false) {
				check = true;
				for (var i = 0; i < chk.length; i++) {
					chk[i].checked = true; //모두 체크
				}
			} else {
				check = false;
				for (var i = 0; i < chk.length; i++) {
					chk[i].checked = false; //모두 해제
				}
			}
		}

		function getPost(mode) {
			var theForm = document.form_cart;
			if (mode == "01") {
				theForm.method = "post";

				theForm.action = "adm_order_account_pop.jsp";

			} else if (mode == "02") {

				theForm.method = "post";

				theForm.action = "adm_cart_delete_proc.jsp";
			}

			theForm.submit();
		}
	</script>

</body>
</html>
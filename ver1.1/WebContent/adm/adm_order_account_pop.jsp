<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>    
<%@ page import="ec.date.*" %>
<%@ page import="ec.product.*,ec.product_detail.*" %>
<%@ page import="ec.member_address.*" %>
<%@ page import="ec.delivery.*" %>
<%@ page import="ec.mileage_total.*" %>
<%@ page import="ec.color.*" %>
<%@ page import="ec.member.*" %>
<%@ page import="ec.order.*" %>
<%@ page import="ec.cart.*" %>
<%@ page import="ec.rel.*" %>

<%	
	request.setCharacterEncoding("euc-kr"); 
	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	

	memberDao mdao = new memberDao();
	memberVo mvo = mdao.selectMember(1);
	
	String now = dvo.getMonth()+"/"+dvo.getDate()+"/"+dvo.getYear()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond();
	int mem_id = mvo.getMem_id();	// 로그인 회원 1이라고 가정.
	
	productDao pdao = new productDao();
	product_detailDao pddao = new product_detailDao();
	ArrayList<orderVo> order_list = new ArrayList<orderVo>();
	deliveryDao dedao = new deliveryDao();
	relDao rdao = new relDao();
	
	
	if(request.getHeader("referer").contains("order_insert_pop")){
	orderVo ovo = new orderVo();
	productVo pvo = new productVo();
	product_detailVo pdvo = new product_detailVo();
	
	pvo = pdao.getProductInfo(Integer.parseInt(request.getParameter("pd_id")));
	pdvo = pddao.getPdd_info(pvo.getPd_id(), request.getParameter("opt_col"), request.getParameter("opt_size"));
	String co_id = rdao.getCoByPd(pvo.getPd_id());
	
	ovo.setPd_id(pvo.getPd_id());
	ovo.setPdd_id(pdvo.getPdd_id());
	ovo.setOrd_count(Integer.parseInt(request.getParameter("opt_count")));
	ovo.setOrd_price(pvo.getPd_price());
	ovo.setCo_id(co_id);
	
	
	order_list.add(ovo);
	
	
	}else{
		String[] set = request.getParameterValues("table_records[]");
		ArrayList<product_detailVo> pdd_id_list = new ArrayList<product_detailVo>();
		
		
		for(int i=0; i<set.length; i++){
			String[] parse = set[i].split(",");
			product_detailVo vo = new product_detailVo();
			vo.setPdd_id(Integer.parseInt(parse[1]));
			vo.setPdd_stk_count(Integer.parseInt(parse[2]));
			pdd_id_list.add(vo);
		}
		
	}
	
	int totalPrice = 0;
	
	

		
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

  <body class="" style="overflow-x:hidden; overflow-y:auto">
    <div class="container body">
      <div class="main_container">
        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="row">
              <div class="col-md-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>상품주문 </h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                  <form name = "orderInfo" action="adm_order_admission_proc.jsp" method="post" class="form-horizontal form-label-left">
                  	
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>상품정보 <small></small></h2>
                  
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <table class="table table-bordered">
                      <thead>
                        <tr>
                          <th>#</th>
                          <th>상품정보</th>
                          <th>수량</th>
                          <th>상품금액/배송비</th>
                        </tr>
                      </thead>
                      <tbody>
                          
                            </tbody>
                    </table>

                  </div>
                </div>
              </div>
              
                <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>할인/EC-money 사용 <small></small></h2>
                   
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <table class="table table-bordered">
                      
                      <tbody>
                          <tr>
                          
                          <td>회원 할인</td>
                          <td></td>
                        </tr>
                        <tr>
                          
                          <td>쿠폰 할인</td>
                          <td></td>
                        </tr>
                        <tr>
                          
                          <td>EC-money 사용</td>
                          <td></td>
                        </tr>
                        <tr>
                          
                          <td> 할인</td>
                          <td></td>
                        </tr>
                      </tbody>
                    </table>

                  </div>
                </div>
              </div>
              
               <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>주문 정보<small></small></h2>
                   
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <table class="table table-bordered">
                      <thead>
                        <tr>
                          <th>#</th>
                          <th>상품정보</th>
                          <th>수량</th>
                          <th>상품금액/배송비</th>
                        </tr>
                      </thead>
                      <tbody>
                          
                            </tbody>
                    </table>

                  </div>
                </div>
              </div>
              
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>결제 정보<small></small></h2>
                   
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <table class="table table-bordered">
                      <thead>
                        <tr>
                          <th>#</th>
                          <th>상품정보</th>
                          <th>수량</th>
                          <th>상품금액/배송비</th>
                        </tr>
                      </thead>
                      <tbody>
                          
                            </tbody>
                    </table>

                  </div>
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
   function calTotal(){
	   
	   var target = document.getElementById("or_total_price");
	   var dePrice = document.getElementById("or_total_delivery_pay").value;
	   var milValue = document.getElementById("or_total_mileage").value;
	   var initialPrice = <%=totalPrice%>
	   var finalPrice = 0;
	   if(document.orderInfo.ord_delivery_pay_method[0].checked==true){
	   	finalPrice = parseInt(dePrice)+parseInt(initialPrice)-parseInt(milValue);
	  	
	   }
	   else if(ord_delivery_pay_method[1].checked==true){
		finalPrice = parseInt(initialPrice)-parseInt(milValue);   
	   }
	   target.value = finalPrice;
   }
   
   </script>
   
   <script language="javascript">
   function mil_radio(e){
   	var fm = document.orderInfo;
   	if(fm.ord_mileage[0].checked==true){
   		mil_div1.style.display = "none";
   		document.getElementById('or_total_mileage').value=0;
   	}
   	else if(ord_mileage[1].checked==true){
   		mil_div1.style.display = "block";
   	}
   	calTotal();
   }
   </script>
   
   <!-- Select2 -->
    <script>
      $(document).ready(function() {
        $(".select2_single").select2({
          placeholder: "항목을 선택하세요",
          allowClear: true
        });
        $(".select2_group").select2({});
        $(".select2_multiple").select2({
          maximumSelectionLength: 6,
          placeholder: "항목을 선택하세요",
          allowClear: true
        });
      });
    </script>

  </body>
</html>
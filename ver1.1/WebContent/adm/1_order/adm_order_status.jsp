<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>    
<%@ page import="ec.date.*" %>
<%@ page import="ec.member.*" %>
<%@ page import="ec.product.*, ec.product_detail.*" %>
<%@ page import="ec.order.*, ec.order_detail.*" %>
<%@ page import="ec.convert.*" %>

<% 
	int ord_id = Integer.parseInt((String)request.getParameter("odid"));
	
	oddDao oddao = new oddDao();
	oddVo odvo = oddao.getOrderDetailInfo(ord_id);
	
	orderDao odao = new orderDao();
	orderVo ovo = odao.getOrderInfo(odvo.getOr_id());
	
	productDao pdao = new productDao();
	productVo pvo = pdao.getProductInfo(odvo.getPd_id());
	
	product_detailDao pddao = new product_detailDao();
	product_detailVo pdvo = pddao.selectByPdd_id(odvo.getPdd_id());
	
	memberDao mdao = new memberDao();
	memberVo mvo = mdao.selectMember(ovo.getMem_id()) ;
	convertDao cvdao = new convertDao();
%>

<!DOCTYPE html>
<html lang="en">

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-kr">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="../../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">


    <!-- Custom Theme Style -->
    <link href="../../build/css/custom.min.css" rel="stylesheet">
  </head>

  <body>
    <div class="container body">
      <div class="main_container">
        <!-- page content -->
        <div class="right_col" role="main">
          <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
              <div class="x_title">
                <h2><i class="fa fa-shopping-cart"></i> 주문상세정보 <small>[주문번호]</small></h2>
                
                <div class="clearfix"></div>
              </div>
              <div class="x_content">

                <div class="" role="tabpanel" data-example-id="togglable-tabs">
                  <ul id="myTab1" class="nav nav-tabs bar_tabs left" role="tablist">
                    <li role="presentation" class="active"><a href="#product" id="#product-tab" role="tab" data-toggle="tab" aria-controls="product" aria-expanded="true">상품정보</a>
                    </li>
                    <li role="presentation" class=""><a href="#order" role="tab" id="#order-tab" data-toggle="tab" aria-controls="order" aria-expanded="false">주문정보</a>
                    </li>
                    <li role="presentation" class=""><a href="#delivery" role="tab" id="#delivery-tab" data-toggle="tab" aria-controls="delivery" aria-expanded="false">배송정보</a>
                    </li>
                  </ul>
                  <div id="orderContent" class="tab-content">
                    <!-- 상품정보 탭 -->
                    <div role="tabpanel" class="tab-pane fade active in" id="product" aria-labelledby="product-tab">
                    <form class="form-horizontal form-label-left input_mask">
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">상품명</label>
                        <div class="col-md-10 col-sm-10 col-xs-12">
                          <input type="text" class="form-control" value="[<%=pvo.getPd_id() %>] <%=pvo.getPd_name() %>" readonly>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">선택옵션</label>
                        <div class="col-md-10 col-sm-10 col-xs-12">
                          <input type="text" class="form-control" value="<%=pdvo.getCol_id() %> / <%=pdvo.getSz_id() %> / <%=odvo.getOrd_count() %>개" readonly>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">상품가격</label>
                        <div class="col-md-2 col-sm-2 col-xs-12">
                          <input type="text" class="form-control" value="<%=cvdao.commify(odvo.getOrd_price()) %>" readonly>
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">할인금액</label>
                        <div class="col-md-2 col-sm-2 col-xs-12">
                          <input type="text" class="form-control" value="<%=cvdao.commify(odvo.getOrd_discount()) %>" readonly>
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">배송비</label>
                        <div class="col-md-2 col-sm-2 col-xs-12">
                          <input type="text" class="form-control" value="<%=cvdao.commify(odvo.getOrd_delivery_pay()) %>" readonly>
                        </div>
                      </div>
                    </form>  
                    </div>
                    <!-- 주문정보 탭 -->
                    <div role="tabpanel" class="tab-pane fade" id="order" aria-labelledby="order-tab">
                      <form class="form-horizontal form-label-left input_mask">
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">주문번호</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text" class="form-control" value="<%=odvo.getOr_id() %>" readonly>
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">주문자</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text" class="form-control" value="<%=mvo.getMem_user_id()%>" readonly>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">수령인</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text" class="form-control" value="<%=ovo.getMem_name() %>" readonly>
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">수령인연락처</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text" class="form-control" value="<%=ovo.getMem_phone() %>" readonly>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">수령인주소</label>
                        <div class="col-md-10 col-sm-10 col-xs-12">
                          <input type="text" class="form-control" value="[<%=ovo.getMem_zipcode() %>] <%=ovo.getMem_address() %>" readonly>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">요청사항</label>
                        <div class="col-md-10 col-sm-10 col-xs-12">
                          <input type="text" class="form-control" value="" readonly>
                        </div>
                      </div>
                    </form>  
                    </div>
                    <!-- 배송정보 탭 -->
                    <div role="tabpanel" class="tab-pane fade" id="delivery" aria-labelledby="delivery-tab">
                    <form class="form-horizontal form-label-left input_mask">
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">주문번호</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text" class="form-control" value="<%=odvo.getOr_id() %>" readonly>
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">배송상태</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text" class="form-control" value="<%=odvo.getOrd_status() %>" readonly>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">배송사</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text" class="form-control" value="<%=odvo.getOrd_delivery_co_id() %>" readonly>
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">송장번호</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text" class="form-control" value="<%=odvo.getOrd_delivery_num() %>" readonly>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">결제시간</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text" class="form-control" value="<%=ovo.getOr_account_time() %>" readonly>
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">발송시간</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text" class="form-control" value="<%=odvo.getOrd_send_time()%>" readonly>
                        </div>
                      </div>
                      <div class="form-group">
                        
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">수취시간</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text" class="form-control" value="<%=odvo.getOrd_receive_time() %>" readonly>
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">구매확정</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text" class="form-control" value="<%=odvo.getOrd_decision_time() %>" readonly>
                        </div>
                      </div>
                    </form>  
                    </div>
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
    <script src="../../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../../vendors/fastclick/lib/fastclick.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="../../vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../../build/js/custom.min.js"></script>

  </body>
</html>
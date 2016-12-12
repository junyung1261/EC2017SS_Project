<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>    
<%@ page import="ec.date.*" %>
<%@ page import="ec.order.*, ec.order_detail.*" %>
<%@ page import="ec.company.*" %>
<%@ page import="ec.couriercompany.*" %>
<%@ page import="ec.product.*, ec.product_detail.*" %>
<%@ page import="ec.member.*" %>
<%@ page import="ec.convert.*" %>

<%	dateDao ddao = new dateDao();
	String now = ddao.now();
	
	oddDao oddao = new oddDao();
	ArrayList<oddVo> list = new ArrayList<oddVo>();
	
	String co_id = null;
	if(request.getParameter("co_id")!=null){
		co_id = request.getParameter("co_id");
		list = oddao.orderDetailList(101, co_id);
	}else{
		list = oddao.orderDetailList(1, null);
	}
	
	orderDao odao = new orderDao();
	
	companyDao cdao = new companyDao();
	ArrayList<companyVo> companyList = new ArrayList<companyVo>();
	companyList = cdao.companyList();
	
	ccDao ccdao = new ccDao();
	ArrayList<ccVo> courierList = new ArrayList<ccVo>();
	courierList = ccdao.CourierCompanyList();
	
	productDao pdao = new productDao();
	product_detailDao pddao = new product_detailDao();
	
	memberDao mdao = new memberDao();
	convertDao cvdao = new convertDao();

%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>EC Corporation </title>

    <!-- Bootstrap -->
    <link href="../../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Datatables -->
    <link href="../../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="../../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="../../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="../../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="../../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
    <!-- Select2 -->
    <link href="../../vendors/select2/dist/css/select2.min.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="../../build/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view"><%@include file="../adm_sidebar.jsp" %></div>
        </div>
        <%@include file = "../adm_top.jsp" %>
        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left"><h3>주문관리 <small>주문정보 및 해당 상품의 정보를 표기합니다.</small></h3></div>
              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="검색어 입력">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>배송 준비<small><%=now %> 현재</small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <form name="company_list" action="adm_order_pre.jsp" method="post" class="form-horizontal form-label-left">
                      <div class="form-group">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                          <select name="co_id" class="select2_single form-control" onChange="javascript:document.company_list.submit()">
                            <option>업체선택  </option>
                            <%for(companyVo cvo : companyList){ %>
                            <option value="<%=cvo.getCo_id()%>"><%=cvo.getCo_name() %></option>
                            <%} %>
                          </select>
                        </div>
                      </div> 
                    </form><br> 
                    <table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                      <thead>
                        <tr>
                          <th>상품명</th>
                          <th>색상</th>
                          <th>사이즈</th>
                          <th>수량</th>
                          <th>상품금액</th>
                          <th>할인금액</th>
                          <th>배송비</th>
                          <th>주문자</th>
                          <th>상태</th>
                        </tr>
                      </thead>
                      <tbody>
                 <%	
                 	  int modal_index = 0;
                 	  for(oddVo oddvo : list){ 
                      product_detailVo pdvo = pddao.selectByPdd_id(oddvo.getPdd_id());
                      String pd_name = pdao.getProductName(oddvo.getPd_id());
                      long or_id = oddvo.getOr_id();
                      orderVo ovo = odao.getOrderInfo(or_id);
                      memberVo mvo = mdao.selectMember(ovo.getMem_id());
                 %>	
                        <tr>
                          <td><%=pd_name %>&nbsp;&nbsp;<a href=""><i class="fa fa-external-link"></i></a></td>
                          <td><%=pdvo.getCol_id() %></td>
                          <td><%=pdvo.getSz_id() %></td>
                          <td><%=oddvo.getOrd_count() %></td>
                          <td><%=cvdao.commify(oddvo.getOrd_price())%></td>
                          <td><%=cvdao.commify(oddvo.getOrd_discount())%></td>
                          <td><%=cvdao.commify(oddvo.getOrd_delivery_pay())%></td>
                          <td><%=mvo.getMem_user_id()%>&nbsp;&nbsp;<i class="fa fa-external-link" data-toggle="modal" data-target=".check_order<%=modal_index%>"></i>
                          
                          <div class="modal fade check_order<%=modal_index%>" tabindex="-1" role="dialog" aria-hidden="true">
		                    <div class="modal-dialog modal-md">
		                      <div class="modal-content">
		                        <div class="modal-header">
		                          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
		                          <h4 class="modal-title" id="myModalLabel2">주문자 배송지 정보</h4>
		                          <small>주문시간 : <%=ovo.getOr_account_time() %></small>
		                        </div>
		                        <div class="modal-body">
		                          <p>수령인 : <%=ovo.getMem_name() %></p>
		                          <p>우편번호 : <%=ovo.getMem_zipcode() %></p>
		                          <p>주소 : <%=ovo.getMem_address() %></p>
		                          <p>연락처 : <%=ovo.getMem_phone() %></p>
		                        </div>
		                        <div class="modal-footer">
		                          <a href="adm_order_status_update.jsp?oid=<%=ovo.getOr_id()%>&os=1">
		                            <button type="button" class="btn btn-danger">결제확인처리</button>
		                          </a>
		                        </div>
		                      </div>
		                    </div>
		                  </div>
       
                          </td>
                          <td><button type="button" class="btn btn-danger btn-xs" data-toggle="modal" data-target=".pre_confirm<%=modal_index%>">상품준비중</button>  
                          <form action="adm_order_status_update.jsp" method="post">
                          <div class="modal fade pre_confirm<%=modal_index%>" role="dialog" aria-hidden="true">
		                    <div class="modal-dialog modal-md">
		                      <div class="modal-content">
		                        <div class="modal-header">
		                          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
		                          <h4 class="modal-title" id="myModalLabel2">배송 정보 입력</h4>
		                          <small>현재시간 : <%=now %></small>
		                        </div>
		                        <div class="modal-body">
		                          <div class="row">
				                      <div class="form-group col-md-12 col-sm-12 col-xs-12">
				                        <div class="col-md-6 col-sm-6 col-xs-6">
				                                                             배송 업체	 : 
				                          <select name="odc" class="select2_courier form-control"  width="100%" tabindex="-1" >
					                        <option></option>
					                        <%for(ccVo ccvo : courierList){ %>
				                            <option value="<%=ccvo.getCc_id()%>"><%=ccvo.getCc_name() %></option>
				                            <%} %>
				                          </select>
				                        </div>
				                        <div class="col-md-6 col-sm-6 col-xs-6">
				                                                             송장 번호	 : 
				                          <input type="text" name="odn" class="form-control" value="">
				                        </div>
				                      </div>
				                  </div>
		                        </div>
		                        <div class="modal-footer">
		                          <input type="hidden" name="oid" value="<%=ovo.getOr_id()%>">
		                          <input type="hidden" name="odid" value="<%=oddvo.getOrd_id()%>">
		                          <input type="hidden" name="os" value="2">
		                          <input type="submit" class="btn btn-danger" value="상품발송처리">
		                        </div>
		                      </div>
		                    </div>
		                  </div>
                          </form>
                          </td>
                        </tr>
                  <%	modal_index++;
                  
                 	  } 	%>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <%@include file = "../adm_footer.jsp" %>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="../../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../../vendors/nprogress/nprogress.js"></script>
    <!-- iCheck -->
    <script src="../../vendors/iCheck/icheck.min.js"></script>
    <!-- Datatables -->
    <script src="../../vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="../../vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="../../vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="../../vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="../../vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="../../vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="../../vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="../../vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="../../vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="../../vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="../../vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="../../vendors/datatables.net-scroller/js/datatables.scroller.min.js"></script>
    <script src="../../vendors/jszip/dist/jszip.min.js"></script>
    <script src="../../vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="../../vendors/pdfmake/build/vfs_fonts.js"></script>
    <!-- Select2 -->
    <script src="../../vendors/select2/dist/js/select2.full.min.js"></script>
    
    <!-- Custom Theme Scripts -->
    <script src="../../build/js/custom.min.js"></script>
    <!-- Popup -->
	
    <!-- Select2 -->
    <script>
      $(document).ready(function() {
        $(".select2_single").select2({
          placeholder: "항목을 선택하세요.",
          allowClear: true
        });
        $(".select2_courier").select2({
            placeholder: "택배사",
            allowClear: true
          });
        $(".select2_group").select2({});
        
      });
    </script>
    <!-- /Select2 -->
    
    <!-- Datatables -->
    <script>
      $(document).ready(function() {
        var handleDataTableButtons = function() {
          if ($("#datatable-buttons").length) {
            $("#datatable-buttons").DataTable({
              dom: "Bfrtip",
              buttons: [
                {
                  extend: "copy",
                  className: "btn-sm"
                },
                {
                  extend: "csv",
                  className: "btn-sm"
                },
                {
                  extend: "excel",
                  className: "btn-sm"
                },
                {
                  extend: "pdfHtml5",
                  className: "btn-sm"
                },
                {
                  extend: "print",
                  className: "btn-sm"
                },
              ],
              responsive: true
            });
          }
        };

        TableManageButtons = function() {
          "use strict";
          return {
            init: function() {
              handleDataTableButtons();
            }
          };
        }();

        $('#datatable').dataTable();

        $('#datatable-keytable').DataTable({
          keys: true
        });

        $('#datatable-responsive').DataTable();

        $('#datatable-scroller').DataTable({
          ajax: "js/datatables/json/scroller-demo.json",
          deferRender: true,
          scrollY: 380,
          scrollCollapse: true,
          scroller: true
        });

        $('#datatable-fixed-header').DataTable({
          fixedHeader: true
        });

        var $datatable = $('#datatable-checkbox');

        $datatable.dataTable({
          'order': [[ 1, 'asc' ]],
          'columnDefs': [
            { orderable: false, targets: [0] }
          ]
        });
        $datatable.on('draw.dt', function() {
          $('input').iCheck({
            checkboxClass: 'icheckbox_flat-green'
          });
        });

        TableManageButtons.init();
      });
    </script>
    <!-- /Datatables -->

    
  </body>
</html>
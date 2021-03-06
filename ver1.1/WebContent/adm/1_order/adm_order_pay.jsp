<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>    
<%@ page import="ec.date.*" %>
<%@ page import="ec.order.*" %>
<%@ page import="ec.convert.*" %>
<%@ page import="ec.product.*,ec.product_detail.*" %>
<%@ page import="ec.member.*" %>

<%	dateDao ddao = new dateDao();
	String now = ddao.now();
	
	orderDao odao = new orderDao();
	ArrayList<orderVo> list = new ArrayList<orderVo>();
	list = odao.orderList(0, null);
	
	product_detailDao pddao = new product_detailDao();
	productDao pdao = new productDao();
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
          <div class="left_col scroll-view">
            <%@include file="../adm_sidebar.jsp" %>
          </div>
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
                    <h2>결제 확인<small><%=now%> 현재 </small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                 
                  <br>
                  <div class="row">     
                    <table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                      <thead>
                        <tr>
                          <th>주문번호</th>
                          <th>주문자</th>
                          <th>주문방법</th>
                          <th>결제금액</th>
                          <th>상품금액</th>
                          <th>마일리지사용</th>
                          <th>할인금액</th>
                          <th>배송비</th>
                          <th>상태</th>
                          <th>주문시간</th>
                        </tr>
                      </thead>
                      <tbody>
                      <%
                      int modal_index = 0;
                      for(orderVo ovo : list){ 
                  	%>
                        <tr>
                          <td><%=ovo.getOr_id() %>  <a href="javascript:window.open('adm_order_pop.jsp?oid=<%=ovo.getOr_id() %>','window팝업','width=1100,height=620,menubar=no,status=no,toolbar=no,scrollbars=auto,location=0');"><i class="fa fa-external-link"></i></a></td>
                          <td><%=ovo.getMem_name()%></td>
                          <td><%if(ovo.getOr_account_method()==3){ %>무통장입금<%}
                          	else{%>오류<%}%>
                          </td>
                          <td><%=cvdao.commify(ovo.getOr_account_value())%></td>
                          <td><%=cvdao.commify(ovo.getOr_total_price())%></td>
                          <td><%=cvdao.commify(ovo.getOr_total_mileage()) %></td>
                          <td><%=cvdao.commify(ovo.getOr_total_discount())%></td>
                          <td><%=cvdao.commify(ovo.getOr_total_delivery_price())%></td>
                          <td><button type="button" class="btn btn-warning btn-xs" data-toggle="modal" data-target=".pay_confirm<%=modal_index%>">결제대기중</button>
                          <div class="modal fade pay_confirm<%=modal_index%>" tabindex="-1" role="dialog" aria-hidden="true">
		                    <div class="modal-dialog modal-sm">
		                      <div class="modal-content">
		                        <div class="modal-header">
		                          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
		                          <h4 class="modal-title" id="myModalLabel2"><%=ovo.getOr_id() %></h4>
		                          <small><%=now %></small>
		                        </div>
		                        <div class="modal-body">
		                          <p>구매자 [<%=ovo.getMem_name() %>] 의 결제를 확인하였으며</p>
		                          <p>결제금액 <%=cvdao.commify(ovo.getOr_account_value())%> 에 대한</p>
		                          <p>주문 [<%=ovo.getOr_id() %>] 을 승인합니다.</p>
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
                          <td><%=ovo.getOr_account_time() %></td>
                        </tr>
                        <%   modal_index++;
                        } %>
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
        <%@ include file="../adm_footer.jsp" %>
        <!-- /footer content -->
      </div>
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
    <!-- ECharts -->
    <script src="../../vendors/echarts/dist/echarts.min.js"></script>
    <script src="../../vendors/echarts/map/js/world.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../../build/js/custom.min.js"></script>
    
    <!-- Popup -->
	<script type="text/javascript">
	function orderPopup(){
		);
	}
	
	function companyPopup(){
		window.open('adm_company_pop.jsp?cid=00000001','window팝업','width=800,height=530,menubar=no,status=no,toolbar=no,scrollbars=no,location=0');
	}
	
	function productPopup(){
		window.open('adm_product_pop.jsp?pid=EA00000001','window팝업','width=400,height=755,menubar=no,status=no,toolbar=no,scrollbars=no,location=0');
	}
	</script>
	<!-- Popup -->
	
    <!-- Select2 -->
    <script>
      $(document).ready(function() {
        $(".select2_single").select2({
          placeholder: "Select a state",
          allowClear: true
        });
        $(".select2_group").select2({});
        $(".select2_multiple").select2({
          maximumSelectionLength: 3,
          placeholder: "업체명을 선택하세요",
          allowClear: true
        });
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
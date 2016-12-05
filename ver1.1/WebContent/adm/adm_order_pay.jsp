<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>    
<%@ page import="ec.date.*" %>
<%@ page import="ec.order.*" %>
<%@ page import="ec.company.*" %>
<%@ page import="ec.product.*,ec.product_detail.*" %>
<%@ page import="ec.member.*" %>
<%@ page import="ec.rel.*" %>
<%	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	
	orderDao odao = new orderDao();
	ArrayList<orderVo> list = new ArrayList<orderVo>();
	
	String co_id = null;
	if(request.getParameter("co_id")!=null){
		co_id = request.getParameter("co_id");
		list = odao.orderList(100, co_id);
	}else{
		list = odao.orderList(0, null);
	}
	
	companyDao cdao = new companyDao();
	ArrayList<companyVo> companyList = new ArrayList<companyVo>();
	companyList = cdao.companyList();
	
	product_detailDao pddao = new product_detailDao();
	productDao pdao = new productDao();
	memberDao mdao = new memberDao();
	
	relDao rdao = new relDao();
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
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Datatables -->
    <link href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
    <!-- Select2 -->
    <link href="../vendors/select2/dist/css/select2.min.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view"><%@include file="adm_sidebar.jsp" %></div>
        </div>
        <%@include file = "adm_top.jsp" %>
        
        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left"><h3>�ֹ����� <small>�ֹ����� �� �ش� ��ǰ�� ������ ǥ���մϴ�.</small></h3></div>
              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="�˻��� �Է�">
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
                    <h2>���� Ȯ��<small><%=dvo.getYear()+"-"+dvo.getMonth()+"-"+dvo.getDate()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond()+" ����" %></small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <form name="company_list" action="adm_order_pay.jsp" method="post" class="form-horizontal form-label-left">
                      <div class="form-group">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                          <select name="co_id" class="select2_single form-control" onChange="javascript:document.company_list.submit()">
                            <option>��ü����  </option>
                            <%for(companyVo cvo : companyList){ %>
                            <option value="<%=cvo.getCo_id()%>"><%=cvo.getCo_name() %></option>
                            <%} %>
                          </select>
                        </div>
                      </div> 
                    </form>   
                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
                      <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">���</a></li>
                        <li role="presentation" class=""><a href="#tab_content2" role="tab" id="profile-tab" data-toggle="tab" aria-expanded="false">��</a></li>
                      </ul>
                      <div id="myTabContent" class="tab-content">
                        <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">
                          <div class="col-md-4 col-sm-4 col-xs-12">
                            <div class="x_panel">
                              <div class="x_title">
                                <h2>�������� ���</h2>
                                <ul class="nav navbar-right panel_toolbox">
                                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                  <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                    <ul class="dropdown-menu" role="menu">
                                      <li><a href="#">Settings 1</a></li>
                                      <li><a href="#">Settings 2</a></li>
                                    </ul>
                                  </li>
                                  <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                                </ul>
                                <div class="clearfix"></div>
                              </div>
                              <div class="x_content">
                                <div id="echart_pie2" style="height:350px;"></div>
                              </div>
                            </div>
                          </div>
                          <div class="col-md-4 col-sm-4 col-xs-12">
                            <div class="x_panel">
                              <div class="x_title">
                                <h2>������ ����</h2>
                                <ul class="nav navbar-right panel_toolbox">
                                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                  <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                    <ul class="dropdown-menu" role="menu">
                                      <li><a href="#">Settings 1</a></li>
                                      <li><a href="#">Settings 2</a></li>
                                    </ul>
                                  </li>
                                  <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                                </ul>
                                <div class="clearfix"></div>
                              </div>
                              <div class="x_content">
                                <div id="echart_pie1" style="height:350px;"></div>
                              </div>
                            </div>
                          </div>
                          <div class="col-md-4 col-sm-4 col-xs-12">
                            <div class="x_panel">
                              <div class="x_title">
                                <h2>�����Ϸ���</h2>
                                <ul class="nav navbar-right panel_toolbox">
                                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                  <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                    <ul class="dropdown-menu" role="menu">
                                      <li><a href="#">Settings 1</a></li>
                                      <li><a href="#">Settings 2</a></li>
                                    </ul>
                                  </li>
                                  <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                                </ul>
                                <div class="clearfix"></div>
                              </div>
                              <div class="x_content">
                                <div id="echart_pie3" style="height:350px;"></div>
                              </div>
                            </div>
                          </div>
                          <div class="col-md-8 col-sm-8 col-xs-12">
                            <div class="x_panel">
                              <div class="x_title">
                              <h2>���Žð��� �м�</h2>
                              <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                <li class="dropdown">
                                  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                  <ul class="dropdown-menu" role="menu">
                                    <li><a href="#">Settings 1</a></li>
                                    <li><a href="#">Settings 2</a></li>
                                  </ul>
                                </li>
                                <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                              </ul>
                              <div class="clearfix"></div>
                              </div>
                              <div class="x_content">
                                <div id="mainb" style="height:350px;"></div>
                              </div>
                            </div>
                          </div>
                          <div class="col-md-4 col-sm-4 col-xs-12">
                            <div class="x_panel">
                              <div class="x_title">
                                <h2>ī�װ����� ���� �м�</h2>
                                <ul class="nav navbar-right panel_toolbox">
                                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                  <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                    <ul class="dropdown-menu" role="menu">
                                      <li><a href="#">Settings 1</a></li>
                                      <li><a href="#">Settings 2</a></li>
                                    </ul>
                                  </li>
                                  <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                                </ul>
                                <div class="clearfix"></div>
                              </div>
                              <div class="x_content">
                                <div id="echart_pie4" style="height:350px;"></div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profile-tab">
                          <table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                            <thead>
                              <tr>
                                <th>�ֹ���ȣ</th>
                                <th>��ü ID</th>
                                <th>��ǰ��ȣ</th>
                                <th>��ǰ��</th>
                                <th>����</th>
                                <th>������</th>
                                <th>�ֹ�����</th>
                                <th>�ֹ���</th>
                                <th>�ֹ����</th>
                                <th>�ֹ��ݾ�</th>
                                <th>����</th>
                                <th>�ֹ��ð�</th>
                              </tr>
                            </thead>
                            <tbody>
                            <%for(orderVo ovo : list){ 
                            product_detailVo pdvo = pddao.selectByPdd_id(ovo.getPdd_id());
                            productVo pvo = pdao.getProductInfo(pdvo.getPd_id());
                        	%>
                              <tr>
                                <td><%=ovo.getOr_id() %>  <a href="javascript:orderPopup();"><i class="fa fa-external-link"></i></a></td>
                                <td><%=rdao.getCoByPd(ovo.getPd_id()) %>&nbsp;&nbsp;<a href="javascript:companyPopup();"><i class="fa fa-external-link"></i></a></td>
                                <td><%=ovo.getPd_id() %>&nbsp;&nbsp;<a href="javascript:productPopup();"><i class="fa fa-external-link"></i></a></td>
                                <td><%=pvo.getPd_name() %>
                                <td><%=pdvo.getCol_id() %></td>
                                <td><%=pdvo.getSz_id() %></td>
                                <td><%=ovo.getOrd_count() %></td>
                                <td><%=ovo.getMem_name()%></td>
                                <td><%if(ovo.getOr_account_method()==0){ %>EC Pay<%}
                                	else if(ovo.getOr_account_method()==1){%>�޴��� �Ҿװ���<%}
                                	else if(ovo.getOr_account_method()==2){%>�ſ�ī��<%}
                                	else if(ovo.getOr_account_method()==3){%>�ǽð� ������ü<%}
                                	else{%>������ �Ա� <%} %>
                                </td>
                                <td><%=ovo.getOrd_price() %>��</td>
                              
                                <td><%if(ovo.getOr_status()==0){ %><button type="button" class="btn btn-warning btn-xs" onClick="javascript:orderPrePopup();">���������</button><%}
                                	else if(ovo.getOr_status()==1){%><button type="button" class="btn btn-warning btn-xs" onClick="javascript:orderPrePopup();">�����Ϸ�</button><%}
                                	else if(ovo.getOr_status()==2){%><button type="button" class="btn btn-warning btn-xs" onClick="javascript:orderPrePopup();">�����Ⱓ�ʰ�</button><%}
                                	else {%>�ǽð� ������ü<%}%>
                                
                                <td><%=ovo.getOr_account_time() %></td>
                              </tr>
                              <%} %>
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <%@ include file="adm_footer.jsp" %>
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
    <!-- iCheck -->
    <script src="../vendors/iCheck/icheck.min.js"></script>
    <!-- Datatables -->
    <script src="../vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="../vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="../vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="../vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="../vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="../vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="../vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="../vendors/datatables.net-scroller/js/datatables.scroller.min.js"></script>
    <script src="../vendors/jszip/dist/jszip.min.js"></script>
    <script src="../vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="../vendors/pdfmake/build/vfs_fonts.js"></script>
    <!-- Select2 -->
    <script src="../vendors/select2/dist/js/select2.full.min.js"></script>
    <!-- ECharts -->
    <script src="../vendors/echarts/dist/echarts.min.js"></script>
    <script src="../vendors/echarts/map/js/world.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
    
    <!-- Popup -->
	<script type="text/javascript">
	function orderPopup(){
		window.open('adm_order_pop.jsp?oid=00000001','window�˾�','width=800,height=530,menubar=no,status=no,toolbar=no,scrollbars=no,location=0');
	}
	
	function companyPopup(){
		window.open('adm_company_pop.jsp?cid=00000001','window�˾�','width=800,height=530,menubar=no,status=no,toolbar=no,scrollbars=no,location=0');
	}
	
	function productPopup(){
		window.open('adm_product_pop.jsp?pid=EA00000001','window�˾�','width=400,height=755,menubar=no,status=no,toolbar=no,scrollbars=no,location=0');
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
          placeholder: "��ü���� �����ϼ���",
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
    
    <!--  chart -->
    <script>
      var theme = {
          color: [
              '#26B99A', '#34495E', '#BDC3C7', '#3498DB',
              '#9B59B6', '#8abb6f', '#759c6a', '#bfd3b7'
          ],

          title: {
              itemGap: 8,
              textStyle: {
                  fontWeight: 'normal',
                  color: '#408829'
              }
          },

          dataRange: {
              color: ['#1f610a', '#97b58d']
          },

          toolbox: {
              color: ['#408829', '#408829', '#408829', '#408829']
          },

          tooltip: {
              backgroundColor: 'rgba(0,0,0,0.5)',
              axisPointer: {
                  type: 'line',
                  lineStyle: {
                      color: '#408829',
                      type: 'dashed'
                  },
                  crossStyle: {
                      color: '#408829'
                  },
                  shadowStyle: {
                      color: 'rgba(200,200,200,0.3)'
                  }
              }
          },

          dataZoom: {
              dataBackgroundColor: '#eee',
              fillerColor: 'rgba(64,136,41,0.2)',
              handleColor: '#408829'
          },
          grid: {
              borderWidth: 0
          },

          categoryAxis: {
              axisLine: {
                  lineStyle: {
                      color: '#408829'
                  }
              },
              splitLine: {
                  lineStyle: {
                      color: ['#eee']
                  }
              }
          },

          valueAxis: {
              axisLine: {
                  lineStyle: {
                      color: '#408829'
                  }
              },
              splitArea: {
                  show: true,
                  areaStyle: {
                      color: ['rgba(250,250,250,0.1)', 'rgba(200,200,200,0.1)']
                  }
              },
              splitLine: {
                  lineStyle: {
                      color: ['#eee']
                  }
              }
          },
          timeline: {
              lineStyle: {
                  color: '#408829'
              },
              controlStyle: {
                  normal: {color: '#408829'},
                  emphasis: {color: '#408829'}
              }
          },

          k: {
              itemStyle: {
                  normal: {
                      color: '#68a54a',
                      color0: '#a9cba2',
                      lineStyle: {
                          width: 1,
                          color: '#408829',
                          color0: '#86b379'
                      }
                  }
              }
          },
          map: {
              itemStyle: {
                  normal: {
                      areaStyle: {
                          color: '#ddd'
                      },
                      label: {
                          textStyle: {
                              color: '#c12e34'
                          }
                      }
                  },
                  emphasis: {
                      areaStyle: {
                          color: '#99d2dd'
                      },
                      label: {
                          textStyle: {
                              color: '#c12e34'
                          }
                      }
                  }
              }
          },
          force: {
              itemStyle: {
                  normal: {
                      linkStyle: {
                          strokeColor: '#408829'
                      }
                  }
              }
          },
          chord: {
              padding: 4,
              itemStyle: {
                  normal: {
                      lineStyle: {
                          width: 1,
                          color: 'rgba(128, 128, 128, 0.5)'
                      },
                      chordStyle: {
                          lineStyle: {
                              width: 1,
                              color: 'rgba(128, 128, 128, 0.5)'
                          }
                      }
                  },
                  emphasis: {
                      lineStyle: {
                          width: 1,
                          color: 'rgba(128, 128, 128, 0.5)'
                      },
                      chordStyle: {
                          lineStyle: {
                              width: 1,
                              color: 'rgba(128, 128, 128, 0.5)'
                          }
                      }
                  }
              }
          },
          gauge: {
              startAngle: 225,
              endAngle: -45,
              axisLine: {
                  show: true,
                  lineStyle: {
                      color: [[0.2, '#86b379'], [0.8, '#68a54a'], [1, '#408829']],
                      width: 8
                  }
              },
              axisTick: {
                  splitNumber: 10,
                  length: 12,
                  lineStyle: {
                      color: 'auto'
                  }
              },
              axisLabel: {
                  textStyle: {
                      color: 'auto'
                  }
              },
              splitLine: {
                  length: 18,
                  lineStyle: {
                      color: 'auto'
                  }
              },
              pointer: {
                  length: '90%',
                  color: 'auto'
              },
              title: {
                  textStyle: {
                      color: '#333'
                  }
              },
              detail: {
                  textStyle: {
                      color: 'auto'
                  }
              }
          },
          textStyle: {
              fontFamily: 'Arial, Verdana, sans-serif'
          }
      };
      
      
      
      var echartBar = echarts.init(document.getElementById('mainb'), theme);

      echartBar.setOption({
        
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['Android', 'iOS']
        },
        toolbox: {
          show: false
        },
        calculable: false,
        xAxis: [{
          type: 'category',
          data: ['01:00', '03:00', '05:00', '07:00', '09:00', '11:00', '13:00', '15:00', '17:00', '19:00', '21:00', '23:00']
        }],
        yAxis: [{
          type: 'value'
        }],
        series: [{
          name: 'Android',
          type: 'bar',
          data: [24, 12, 2, 4, 8, 22, 48, 80, 90, 110, 60, 40],
          markPoint: {
            data: [{
              type: 'max',
              name: 'MAX'
            }, {
              type: 'min',
              name: 'MIN'
            }]
          },
          markLine: {
            data: [{
              type: 'average',
              name: 'AVG'
            }]
          }
        }, {
          name: 'iOS',
          type: 'bar',
          data: [14, 2, 2, 4, 8, 12, 38, 70, 80, 100, 50, 30],
          markPoint: {
              data: [{
                type: 'max',
                name: 'MAX'
              }, {
                type: 'min',
                name: 'MIN'
              }]
            },
            markLine: {
              data: [{
                type: 'average',
                name: 'AVG'
              }]
            },
          markLine: {
            data: [{
              type: 'average',
              name: 'AVG'
            }]
          }
        }]
      });
      
      var echartPieCollapse = echarts.init(document.getElementById('echart_pie2'), theme);
      
      echartPieCollapse.setOption({
        tooltip: {
          trigger: 'item',
          formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
          x: 'center',
          y: 'bottom',
          data: ['�޴��� �Ҿװ���', '�ſ�ī��', '�������Ա�', '������ü']
        },
        toolbox: {
          show: true,
          feature: {
            magicType: {
              show: true,
              type: ['pie', 'funnel']
            },
            restore: {
              show: true,
              title: "Restore"
            },
            saveAsImage: {
              show: true,
              title: "Save Image"
            }
          }
        },
        calculable: true,
        series: [{
          name: 'Area Mode',
          type: 'pie',
          radius: [25, 90],
          center: ['50%', 170],
          roseType: 'area',
          x: '50%',
          max: 40,
          sort: 'ascending',
          data: [{
            value: 10,
            name: '�޴��� �Ҿװ���'
          }, {
            value: 5,
            name: '�ſ�ī��'
          }, {
            value: 15,
            name: '�������Ա�'
          }, {
            value: 25,
            name: '������ü'
          }]
        }]
      });
      
      var echartPieCollapse1 = echarts.init(document.getElementById('echart_pie1'), theme);
      
      echartPieCollapse1.setOption({
        tooltip: {
          trigger: 'item',
          formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
          x: 'center',
          y: 'bottom',
          data: ['����','����']
        },
        toolbox: {
          show: true,
          feature: {
            magicType: {
              show: true,
              type: ['pie', 'funnel']
            },
            restore: {
              show: true,
              title: "Restore"
            },
            saveAsImage: {
              show: true,
              title: "Save Image"
            }
          }
        },
        calculable: true,
        series: [{
          name: 'Area Mode',
          type: 'pie',
          radius: [25, 90],
          center: ['50%', 170],
          roseType: 'area',
          x: '50%',
          max: 40,
          sort: 'ascending',
          data: [{
            value: 10,
            name: '����'
          }, {
            value: 5,
            name: '����'
          }]
        }]
      });
      
      var echartPieCollapse3 = echarts.init(document.getElementById('echart_pie3'), theme);
      
      echartPieCollapse3.setOption({
        tooltip: {
          trigger: 'item',
          formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
          x: 'center',
          y: 'bottom',
          data: ['�����Ϸ�','�������']
        },
        toolbox: {
          show: true,
          feature: {
            magicType: {
              show: true,
              type: ['pie', 'funnel']
            },
            restore: {
              show: true,
              title: "Restore"
            },
            saveAsImage: {
              show: true,
              title: "Save Image"
            }
          }
        },
        calculable: true,
        series: [{
          name: 'Area Mode',
          type: 'pie',
          radius: [25, 90],
          center: ['50%', 170],
          roseType: 'area',
          x: '50%',
          max: 40,
          sort: 'ascending',
          data: [{
            value: 90,
            name: '�����Ϸ�'
          }, {
            value: 15,
            name: '�������'
          }]
        }]
      });
      
	  var echartPieCollapse4 = echarts.init(document.getElementById('echart_pie4'), theme);
      
      echartPieCollapse4.setOption({
        tooltip: {
          trigger: 'item',
          formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
          x: 'center',
          y: 'bottom',
          data: ['û����','�����','�����','������','�����ĵ�']
        },
        toolbox: {
          show: true,
          feature: {
            magicType: {
              show: true,
              type: ['pie', 'funnel']
            },
            restore: {
              show: true,
              title: "Restore"
            },
            saveAsImage: {
              show: true,
              title: "Save Image"
            }
          }
        },
        calculable: true,
        series: [{
          name: 'Area Mode',
          type: 'pie',
          radius: [25, 90],
          center: ['50%', 170],
          roseType: 'area',
          x: '50%',
          max: 40,
          sort: 'ascending',
          data: [{
              value: 90,
              name: 'û����'
            }, {
              value: 70,
              name: '�����'
            }, {
              value: 60,
              name: '�����'
            }, {
              value: 40,
              name: '������'
            }, {
              value: 25,
              name: '�����ĵ�'
          }]
        }]
      });
    </script>
    <!-- /chart end -->
    
  </body>
</html>
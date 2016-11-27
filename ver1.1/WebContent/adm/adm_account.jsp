<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ec.date.*" %>
<%	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
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
              <div class="title_left"><h3>정산관리 <small>EC Corporation의 정산처리에 대한 정보를 표시합니다.</small></h3></div>
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
                    <h2>정산 대상 주문<small><%=dvo.getYear()+"-"+dvo.getMonth()+"-"+dvo.getDate()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond()+" 현재" %></small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <form class="form-horizontal form-label-left">
                      <div class="form-group">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                          <select class="select2_group form-control">
                            <option>업체선택  </option>
                            <option>Company 1</option>
                            <option>Company 2</option>
                            <option>Company 2</option>
                            <option>Company 2</option>
                            <option>Company 2</option>
                            <option>Company 2</option>
                            <option>Company 2</option>
                          </select>
                        </div>
                      </div> 
                    </form>   
                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
                      <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">요약</a>
                        </li>
                        <li role="presentation" class=""><a href="#tab_content2" role="tab" id="profile-tab" data-toggle="tab" aria-expanded="false">상세</a>
                        </li>
                      </ul>
                      <div id="myTabContent" class="tab-content">
                        <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">
                          <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                              <div class="x_title">
                              <h2>주문일자 별 정산처리 현황</h2>
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
                                <div id="state1" style="height:350px;"></div>
                              </div>
                            </div>
                          </div>
                          
                          <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                              <div class="x_title">
                              <h2>주문일자 별 정산처리 금액 현황</h2>
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
                                <div id="state2" style="height:350px;"></div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profile-tab">
                          <table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                            <thead>
                              <tr>
                                <th>주문번호</th>
                                <th>업체 ID</th>
                                <th>상품번호</th>
                                <th>총주문금액</th>
                                <th>상품금액</th>
                                <th>배송비</th>
                                <th>마일리지발생</th>
                                <th>구매자부담금</th>
                                <th>쿠폰금액</th>
                                <th>마일리지사용</th>
                                <th>정산금액</th>
                                <th>상태</th>
                                <th>비고</th>
                              </tr>
                            </thead>
                            <tbody>
                              <tr>
                                <td>EC00000001  <a href="javascript:orderPopup();"><i class="fa fa-external-link"></i></a></td>
                                <td>MUTNAM&nbsp;&nbsp;<a href="javascript:companyPopup();"><i class="fa fa-external-link"></i></a></td>
                                <td>EA00000001&nbsp;&nbsp;<a href="javascript:productPopup();"><i class="fa fa-external-link"></i></a></td>
                                <td>￦ 30,000</td>
                                <td>￦ 27,500</td>
                                <td>￦ 2,500</td>
                                <td>￦ 275</td>
                                <td>￦ 29,800</td>
                                <td>￦ 100</td>
								<td>￦ 100</td>
								<td>￦ 29,725</td>
                                <td><button type="button" class="btn btn-warning btn-xs" onClick="accountDetailPopup()">정산대기</button></td>
                                <td></td>
                              </tr>
                              <tr>
                                <td>EC00000002  <a href="javascript:orderPopup();"><i class="fa fa-external-link"></i></a></td>
                                <td>MUTNAM&nbsp;&nbsp;<a href="javascript:companyPopup();"><i class="fa fa-external-link"></i></a></td>
                                <td>EA00000002&nbsp;&nbsp;<a href="javascript:productPopup();"><i class="fa fa-external-link"></i></a></td>
                                <td>￦ 30,000</td>
                                <td>￦ 27,500</td>
                                <td>￦ 2,500</td>
                                <td>￦ 275</td>
                                <td>￦ 30,000</td>
                                <td>￦ 0</td>
								<td>￦ 0</td>
								<td>￦ 29,725</td>
                                <td><button type="button" class="btn btn-warning btn-xs" onClick="accountDetailPopup()">정산대기</button></td>
                                <td><button type="button" class="btn btn-danger btn-xs" onClick="accountDetailPopup()">교환거절</button></td>
                              </tr>
                              <tr>
                                <td>EC00000003  <a href="javascript:orderPopup();"><i class="fa fa-external-link"></i></a></td>
                                <td>MUTNAM&nbsp;&nbsp;<a href="javascript:companyPopup();"><i class="fa fa-external-link"></i></a></td>
                                <td>EA00000002&nbsp;&nbsp;<a href="javascript:productPopup();"><i class="fa fa-external-link"></i></a></td>
                                <td>￦ 30,000</td>
                                <td>￦ 27,500</td>
                                <td>￦ 2,500</td>
                                <td>￦ 275</td>
                                <td>￦ 30,000</td>
                                <td>￦ 0</td>
								<td>￦ 0</td> 
								<td>￦ 29,725</td>
                                <td><button type="button" class="btn btn-warning btn-xs" onClick="accountDetailPopup()">정산대기</button></td>
                                <td><button type="button" class="btn btn-danger btn-xs" onClick="accountDetailPopup()">환불거절</button></td>
                              </tr>
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
        <%@include file = "adm_footer.jsp" %>
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
		window.open('adm_order_pop.jsp?oid=00000001','window팝업','width=800,height=530,menubar=no,status=no,toolbar=no,scrollbars=no,location=0');
	}
	
	function companyPopup(){
		window.open('adm_company_pop.jsp?cid=mutnam','window팝업','width=800,height=530,menubar=no,status=no,toolbar=no,scrollbars=no,location=0');
	}
	
	function productPopup(){
		window.open('adm_product_pop.jsp?pid=EA00000001','window팝업','width=400,height=755,menubar=no,status=no,toolbar=no,scrollbars=no,location=0');
	}
	
	function accountDetailPopup(){
		window.open('adm_account_detail.jsp?oid=EC00000001&cid=mutnam','window팝업','width=400,height=755,menubar=no,status=no,toolbar=no,scrollbars=no,location=0');
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
      
      
      
      var echartBar = echarts.init(document.getElementById('state1'), theme);
      echartBar.setOption({
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['정산대상', '정산완료']
        },
        toolbox: {
          show: false
        },
        calculable: false,
        xAxis: [{
          type: 'category',
          data: ['16-10-28', '16-10-29', '16-10-30', '16-10-31', '16-11-01', '16-11-02', '16-11-03',
        	  '16-11-04', '16-11-05', '16-11-06', '16-11-07', '16-11-08', '16-11-09', '16-11-10'
        	  ]
        }],
        yAxis: [{
          type: 'value'
        }],
        series: [{
          name: '정산대상',
          type: 'bar',
          data: [400, 300, 200, 400, 300, 300, 300,400, 300, 200, 400, 300, 300, 300],
          
          markLine: {
            data: [{
              type: 'average',
              name: 'AVG'
            }]
          }
        }, {
          name: '정산완료',
          type: 'bar',
          data: [400, 300, 200, 400, 300, 300, 300, 400, 300, 200, 400, 250, 192, 91],
         
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
      
      var echartBar2 = echarts.init(document.getElementById('state2'), theme);
      echartBar2.setOption({
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['정산대상', '정산완료']
        },
        toolbox: {
          show: false
        },
        calculable: false,
        xAxis: [{
          type: 'category',
          data: ['16-10-28', '16-10-29', '16-10-30', '16-10-31', '16-11-01', '16-11-02', '16-11-03',
        	  '16-11-04', '16-11-05', '16-11-06', '16-11-07', '16-11-08', '16-11-09', '16-11-10'
        	  ]
        }],
        yAxis: [{
          type: 'value'
        }],
        series: [{
          name: '정산대상',
          type: 'bar',
          data: [4000000, 3000000, 200000, 400000, 300000, 300000, 300000,400000, 300000, 200000, 400000, 300000, 300000, 300000],
          
          markLine: {
            data: [{
              type: 'average',
              name: 'AVG'
            }]
          }
        }, {
          name: '정산완료',
          type: 'bar',
          data: [4000000, 3000000, 200000, 400000, 300000, 300000, 300000,400000, 300000, 200000, 400000, 300000, 300000, 300000],
         
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
    </script>
    <!-- /chart end -->
    
  </body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ec.date.*" %>
<%	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	String product_id = (String)request.getParameter("pid");
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
	<!-- starrr -->
    <link href="../vendors/starrr/dist/starrr.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="" style="overflow-x:hidden; overflow-y:hidden">
    <div class="container body">
      <div class="main_container">
        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="row">
              <div class="col-md-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>상품정보조회 </h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                    <div class="col-md-12 col-sm-12 col-xs-12 profile_left">
                      <div class="profile_img">
                        <div id="crop-avatar">
                          <img class="img-responsive avatar-view" src="../images/picture.jpg" alt="Avatar" title="Change the avatar">
                        </div>
                      </div>
                      <br />
                      <ul class="list-unstyled user_data"> 
                        <li><i class="fa fa-info-circle user-profile-icon"></i> 상품번호 : EA00000001</li>
                      </ul><div class="ln_solid"></div>
                      <ul class="list-unstyled user_data">
                        <li><i class="fa fa-gift user-profile-icon"></i> 상품명 : 겨울 남성 스트라이프 울 가디건</li>
                        <li><i class="fa fa-spinner user-profile-icon"></i> 색상 : Red, Navy, Black, Blue</li>
                        <li><i class="fa fa-user user-profile-icon"></i> 사이즈 : S, L, XL, XXL</li>
                      </ul><div class="ln_solid"></div>
                      <ul class="list-unstyled user_data"> 
                        <li><i class="fa fa-shopping-cart user-profile-icon"></i> 판매가 : ￦ 25,000</li>
                        <li><i class="fa fa-truck user-profile-icon"></i> 배송비 : ￦ 2,500</li>
                        <li><i class="fa fa-credit-card user-profile-icon"></i> 마일리지 적립 : ￦ 250</li>
                      </ul><div class="ln_solid"></div>
                      <ul class="list-unstyled user_data"> 
                        <li><i class="fa fa-bar-chart user-profile-icon"></i> 상품 평균평점 : 
                            <div class="starrr stars-existing" data-rating='4'></div></li>
                        <li><i class="fa fa-bar-chart user-profile-icon"></i> 상품 평균배송일 : 
                            <div class="starrr stars-existing" data-rating='4'></div></li>
                      </ul>
                      <br />
				      <input type="button" class="btn btn-primary pull-right" value="Close" onClick="javascript:window.close();">
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
    <script src="../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../vendors/nprogress/nprogress.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="../vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
    <!-- starrr -->
    <script src="../vendors/starrr/dist/starrr.js"></script>
    
    <!-- Starrr -->
    <script>
      $(document).ready(function() {
        $(".stars").starrr();

        $('.stars-existing').starrr({
          rating: 4
        });

        $('.stars').on('starrr:change', function (e, value) {
          $('.stars-count').html(value);
        });

        $('.stars-existing').on('starrr:change', function (e, value) {
          $('.stars-count-existing').html(value);
        });
      });
    </script>
    <!-- /Starrr -->
  </body>
</html>
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

    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="adm_index.jsp" class="site_title"><i class="fa fa-paw"></i> <span>EC Corporation</span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile">
              <div class="profile_pic">
                <img src="../images/img.jpg" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Welcome,</span>
                <h2>David Lee</h2>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />

            <!-- sidebar menu -->
            <%@include file="adm_sidebar.jsp" %>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="Settings">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Logout">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a>
            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>
        <!-- top navigation -->
        
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="../images/img.jpg" alt="">David Lee
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <li><a href="javascript:;"> Profile</a></li>
                    <li>
                      <a href="javascript:;">
                        <span class="badge bg-red pull-right">Caution</span>
                        <span>Settings</span>
                      </a>
                    </li>
                    <li><a href="javascript:;">Help</a></li>
                    <li><a href="login.html"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                  </ul>
                </li>

                <li role="presentation" class="dropdown">
                  <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-envelope-o"></i>
                    <span class="badge bg-green">6</span>
                  </a>
                  <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                    <li>
                      <a>
                        <span class="image"><img src="../images/img.jpg" alt="Profile Image" /></span>
                        <span>
                          <span>Message Sender Name</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>
                  </ul>
                </li>
              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left"><h3>상품관리 <small>EC Corporation의 상품 리스트를 표시합니다.</small></h3></div>
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
                    <h2>MUTNAM 상품리스트<small><%=dvo.getYear()+"-"+dvo.getMonth()+"-"+dvo.getDate()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond()+" 현재" %></small></h2>
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
                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
                      <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">상의</a></li>
                        <li role="presentation" class=""><a href="#tab_content2" role="tab" id="profile-tab" data-toggle="tab" aria-expanded="false">하의</a></li>
                        <li role="presentation" class=""><a href="#tab_content3" role="tab" id="profile-tab2" data-toggle="tab" aria-expanded="false">악세서리</a></li>
                      </ul>
                      <div id="myTabContent" class="tab-content">
                        <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">
                          <div class="col-md-3 col-sm-3 col-xs-3">
			                <div class="x_panel">
			                  <div class="x_title">
			                    <h2>EA00000001 <small>BRAND NAME</small></h2>
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
			                    <div class="col-md-12 col-sm-12 col-xs-12 profile_left">
			                      <div class="profile_img">
			                        <div id="crop-avatar">
			                          <!-- Current avatar -->
			                          <img class="img-responsive avatar-view" src="../images/picture.jpg" alt="Avatar" title="Change the avatar">
			                        </div>
			                      </div>
			                      <h2>남성 100% 울 스트라이프 가디건</h2>
			
			                      <ul class="list-unstyled user_data">
			                        <li><i class="fa fa-tags user-profile-icon"></i> 상의 > 아우터 > 가디건</li>
			                        <li><i class="fa fa-image user-profile-icon"></i> RED / BLUE / GRAY / BROWN / BLACK</li>
									<li class="m-top-xs"><i class="fa fa-external-link user-profile-icon"></i>
									  <a href="http://www.kimlabs.com/profile/" target="_blank">www.kimlabs.com</a>
			                        </li>
			                      </ul>
			                      <a class="btn btn-success"><i class="fa fa-edit m-right-xs"></i>&nbsp;View Detail</a>
			                      <br />			
			                      <!-- start skills -->
			                      <h4>Skills</h4>
			                      <ul class="list-unstyled user_data">
			                        <li>
			                          <p>Web Applications</p>
			                          <div class="progress progress_sm">
			                            <div class="progress-bar bg-green" role="progressbar" data-transitiongoal="50"></div>
			                          </div>
			                        </li>
			                        <li>
			                          <p>Website Design</p>
			                          <div class="progress progress_sm">
			                            <div class="progress-bar bg-green" role="progressbar" data-transitiongoal="70"></div>
			                          </div>
			                        </li>
			                        <li>
			                          <p>Automation & Testing</p>
			                          <div class="progress progress_sm">
			                            <div class="progress-bar bg-green" role="progressbar" data-transitiongoal="30"></div>
			                          </div>
			                        </li>
			                        <li>
			                          <p>UI / UX</p>
			                          <div class="progress progress_sm">
			                            <div class="progress-bar bg-green" role="progressbar" data-transitiongoal="50"></div>
			                          </div>
			                        </li>
			                      </ul>
			                      <!-- end of skills -->
			
			                    </div>
			                  </div>
                            </div>
                          </div>
                        </div>
                        <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profile-tab">
                        
                        
                        </div>
                        <div role="tabpanel" class="tab-pane fade" id="tab_content3" aria-labelledby="profile-tab">
                        
                        
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
        <footer>
          <div class="pull-right">
            Gentelella - Bootstrap Admin Template by <a href="https://colorlib.com">Colorlib</a>
          </div>
          <div class="clearfix"></div>
        </footer>
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
	<!-- bootstrap-progressbar -->
    <script src="../vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
  </body>
</html>
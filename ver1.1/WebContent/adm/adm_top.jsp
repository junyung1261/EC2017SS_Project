<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	
	request.setCharacterEncoding("EUC-kr");
	String tid = (String)session.getAttribute("loginId");
	
	if(tid==null){
		session.invalidate();
%>
	<script>
	location.href="/ver1.1/adm/0_session/adm_login.jsp";
	
	
	</script>	
	<%} %>
	
	
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
            <img src="/ver1.1/images/img.jpg" alt=""><%=tid %>
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
            <li><a href="/ver1.1/adm/10_message/adm_message.jsp">Messages</a></li>
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

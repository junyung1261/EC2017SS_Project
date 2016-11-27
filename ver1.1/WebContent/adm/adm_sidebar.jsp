<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!-- sidebar menu -->
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
            
<div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
  <div class="menu_section">
    <h3>CEO</h3><!-- Position -->
    <ul class="nav side-menu">
      <li><a href="adm_index.jsp"><i class="fa fa-home"></i> ����ȭ��</a></li>
      <li><a><i class="fa fa-shopping-cart"></i> �ֹ����� <span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="adm_order_pay.jsp">����Ȯ��</a></li>
          <li><a href="adm_order_pre.jsp">����غ�</a></li>
          <li><a href="adm_order_send.jsp">��ǰ�߼�</a></li>
          <li><a href="adm_order_cancel.jsp">�ֹ����</a></li>
          <li><a href="adm_order_exchange.jsp">��ȯ����</a></li>
          <li><a href="adm_order_refund.jsp">ȯ������</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-suitcase"></i> ���¾�ü<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="adm_company.jsp">��ü �⺻����</a></li>
          <li><a href="adm_company_insert.jsp">��ü �űԵ��</a></li>
          <li><a href="adm_company_reg.jsp">��ü ������</a></li>
          <li><a href="adm_company_grade.jsp">��ü ��ް���</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-user-plus"></i> ȸ������<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="adm_member_insert.jsp">ȸ�� �űԵ��</a></li>
          <li><a href="adm_member.jsp">ȸ�� ����Ʈ</a></li>
          <li><a href="adm_member_grade.jsp">ȸ�� ��ް���</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-gift"></i> ��ǰ����<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="#">��ǰ ����Ʈ</a>
            <ul class="nav child_menu">
              <li class="sub_menu"><a href="adm_productlist_com.jsp">��ü��</a></li>
              <li><a href="adm_productlist_cat.jsp">ī�װ���</a></li>
            </ul>
          </li>
          <li><a href="adm_product_insert.jsp">��ǰ �������</a></li>
          <li><a href="adm_productInsertAll.jsp">��ǰ �ϰ����</a></li>
          <li><a href="adm_productCategory.jsp">��ǰ ī�װ� ����</a></li>
          <li><a href="adm_productSearch.jsp">��ǰ �̹����˻�</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-money"></i> ĳ������<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a>ĳ�� ��Ȳ</a>
            <ul class="nav child_menu">
              <li class="sub_menu"><a href="adm_cash.jsp">ĳ�� ��������</a></li>
              <li><a href="adm_cash_refund.jsp">ĳ�� ȯ��ó��</a></li>
              <li><a href="adm_cash_account.jsp">������ ���°���</a></li>
            </ul>
          </li>
          <li><a href="adm_mileage.jsp">���ϸ��� ��Ȳ</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-credit-card"></i> �������<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="adm_account.jsp">������ó��</a></li>
          <li><a href="adm_account_finish.jsp">����Ϸ᳻��</a></li>
          <li><a href="adm_account_manual.jsp">����ó�� �Ŵ���</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-desktop"></i> �������<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="adm_advertisement.jsp">������Ȳ</a></li>
          <li><a href="adm_adv_manual.jsp">���� �Ŵ���</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-street-view"></i> ��������<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="adm_employee.jsp">���� ����Ʈ</a></li>
          <li><a href="adm_employee.jsp">�μ�����</a></li>
        </ul>
      </li>
    </ul>
  </div>
</div>
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
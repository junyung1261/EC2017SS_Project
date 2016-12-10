<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%	
	request.setCharacterEncoding("EUC-kr");
	String id = (String)session.getAttribute("loginId");
	String abs = "/ver1.1/adm/";
	%>
<!-- sidebar menu -->
<div class="navbar nav_title" style="border: 0; text-align:center; padding-top:20px;">
  <a href="<%=abs %>adm_index.jsp" class="site_title"><img src="<%=abs %>../images/logo.png" width="80%" border="0"></a>
</div>

<div class="clearfix"></div>


<br />
            
<div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
  <div class="menu_section">

    <ul class="nav side-menu">
      <li><a href="<%=abs %>adm_index.jsp"><i class="fa fa-home"></i> 메인화면</a></li>
      <li><a><i class="fa fa-shopping-cart"></i> 주문관리 <span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="<%=abs %>1_order/adm_order_cart_list.jsp">장바구니</a></li>
          <li><a href="<%=abs %>1_order/adm_order_pay.jsp">결제확인</a></li>
          <li><a href="<%=abs %>1_order/adm_order_pre.jsp">배송준비</a></li>
          <li><a href="<%=abs %>1_order/adm_order_send.jsp">상품발송</a></li>
          <li><a href="<%=abs %>1_order/adm_order_cancel.jsp">주문취소</a></li>
          <li><a href="<%=abs %>1_order/adm_order_exchange.jsp">교환접수</a></li>
          <li><a href="<%=abs %>1_order/adm_order_refund.jsp">환불접수</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-suitcase"></i> 협력업체<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="<%=abs %>2_company/adm_company.jsp">업체 기본정보</a></li>
          <li><a href="<%=abs %>2_company/adm_company_insert.jsp">업체 신규등록</a></li>
          <li><a href="<%=abs %>2_company/adm_company_reg.jsp">업체 계약관리</a></li>
          <li><a href="<%=abs %>2_company/adm_company_grade.jsp">업체 등급관리</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-user-plus"></i> 회원관리<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="<%=abs %>3_member/adm_member_insert.jsp">회원 신규등록</a></li>
          <li><a href="<%=abs %>3_member/adm_member.jsp">회원 리스트</a></li>
          <li><a href="<%=abs %>3_member/adm_member_grade.jsp">회원 등급관리</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-gift"></i> 상품관리<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="<%=abs %>4_product/adm_productlist_com.jsp">상품 리스트</a></li>
          <li><a href="<%=abs %>4_product/adm_product_insert.jsp">상품 개별등록</a></li>
          <li><a href="<%=abs %>4_product/adm_productInsertAll.jsp">상품 일괄등록</a></li>
          <li><a href="<%=abs %>4_product/adm_productCategory.jsp">상품 카테고리 관리</a></li>
          <li><a href="<%=abs %>4_product/adm_productSearch.jsp">상품 이미지검색</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-money"></i> 캐쉬관리<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="<%=abs %>5_cash/adm_cash.jsp">회원 캐쉬현황</a></li>
          <li><a href="<%=abs %>5_cash/adm_cash_charge.jsp">캐쉬 충전내역</a></li>
          <li><a href="<%=abs %>5_cash/adm_cash_pay.jsp">캐쉬 사용내역</a></li>
          <li><a href="<%=abs %>5_cash/adm_cash_refund.jsp">캐쉬 환불처리</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-money"></i> 마일리지관리<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="<%=abs %>6_mileage/adm_mileage.jsp">회원 마일리지 현황</a></li>
          <li><a href="<%=abs %>6_mileage/adm_mileage_charge.jsp">마일리지 적립내역</a></li>
          <li><a href="<%=abs %>6_mileage/adm_mileage_pay.jsp">마일리지 사용내역</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-credit-card"></i> 정산관리<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="adm_account.jsp">정산대상처리</a></li>
          <li><a href="adm_account_finish.jsp">정산완료내역</a></li>
          <li><a href="adm_account_manual.jsp">정산처리 매뉴얼</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-desktop"></i> 광고관리<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="adm_advertisement.jsp">광고현황</a></li>
          <li><a href="adm_adv_manual.jsp">광고 매뉴얼</a></li>
        </ul>
      </li>
      <li><a><i class="fa fa-street-view"></i> 직원관리<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
          <li><a href="adm_employee.jsp">직원 리스트</a></li>
          <li><a href="adm_employee.jsp">부서관리</a></li>
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
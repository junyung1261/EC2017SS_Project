<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import = "ec.member.*, ec.member_address.*" %>
<%@ page import = "ec.product.*, ec.product_detail.*, ec.product_discount.*" %>    
<%@ page import = "ec.company.*" %>
<%@ page import = "ec.order_cart.*" %>
<%@ page import = "ec.convert.*" %>
<%@ page import = "java.util.*" %>
<%   request.setCharacterEncoding("EUC-kr");

   String loginId = (String)session.getAttribute("loginId");
   memberDao mdao = new memberDao();
   memberVo mvo = mdao.selectMember(loginId);
   
   int index_co = Integer.parseInt(request.getParameter("index_co"));   //�� ȸ�� ����
   String[] pdd_id = request.getParameterValues("pdd_id");         //��ǰ ��ü����
   String[] opt_count = request.getParameterValues("opt_count");   //����
   String[] index_pdd_co = request.getParameterValues("index_pdd_co");    //ȸ�� �� ��ǰ ����
   

   int price = 0;      //���� ��ǰ ����
   int discount = 0;   //��ǰ��ü ���αݾ�
   int delivery = 0;   //��ǰ��ü ��۱ݾ�
   int price_for_delivery = 0;  //ȸ�纰 �ݾ�
   int mileage = 0;   //���ϸ��� ���ݾ�
   int total = 0;      //�� �ݾ�
   
   product_detailDao pddao = new product_detailDao();
   productDao pdao = new productDao();
   discountDao disdao = new discountDao();
   companyDao cdao = new companyDao();
   convertDao cvdao = new convertDao();
   ocDao ocdao = new ocDao();
   
   //////////////////////////////////////////////////////////////////////////////////////////
   member_addressDao madao = new member_addressDao();
   member_addressVo mavo = madao.getMemberInfo(mvo.getMem_id());            //ȸ�� ����� ���� ����
   //////////////////////////////////////////////////////////////////////////////////////////

   ArrayList<ocVo> companyList = new ArrayList<ocVo>();
   companyList = ocdao.getCartCompany(mvo.getMem_id()); 
   
   int pdd_index = 0;
    for(int i=0;i<index_pdd_co.length;i++){
       price_for_delivery = 0;
       String co_id = null;
       for(int j=0; j<Integer.parseInt(index_pdd_co[i]);j++){ 
          
         product_detailVo pddvo = pddao.selectByPdd_id(Integer.parseInt(pdd_id[pdd_index]));
         int pd_id = pddvo.getPd_id();
         productVo pdvo = pdao.getProductInfo(pd_id);
         co_id = pdvo.getPd_co_id();
         
         discountVo disvo = disdao.selectDiscount(pd_id);

         price += pdvo.getPd_price() * Integer.parseInt(opt_count[pdd_index]);
         price_for_delivery += pdvo.getPd_price() * Integer.parseInt(opt_count[pdd_index]);
         
         if(disvo.getDis()==0){
            discount = 0;
         }else{
            if(disvo.getDis_method()==0){
               discount += (int)(pdvo.getPd_price() * disvo.getDis_rate() * 0.01* Integer.parseInt(opt_count[pdd_index]));
            }else{
               discount += disvo.getDis_value()* Integer.parseInt(opt_count[pdd_index]);
            }
         }
         pdd_index++;
         
       }
       companyVo cvo = cdao.getCompanyInfo(co_id);
       if(cvo.getCo_delivery()==0){
          delivery += 0;
       }else{
          if(price_for_delivery>=cvo.getCo_delivery_condition()){
             delivery += 0;
          }
          else{
             delivery += cvo.getCo_delivery_base();
          }
       }
   }
   total = price - discount + delivery;

%>    
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-kr">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ȸ�� ��ٱ��� ����Ʈ</title>
    <!-- Bootstrap -->
    <link href="../../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="../../build/css/custom.min.css" rel="stylesheet">
    
    <style>
    .count {
       border:none;
       background:transparent; 
       width:25px; 
       text-align:center; 
    }
    
    .price_each{
       border:none;
       width:80px;
       background:transparent; 
    }
    .color, .size{
       border:none;
       width:50px;
       background:transparent;
    }
   
   .delivery_small{
      border:none;
      background:transparent;
      width:100px;
   }
   .delivery_large{
      border:none;
      background:transparent;
      width:200px;
   }
    </style>
  </head>

  <body class="nav-md" onload = "document.refresh();">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view"><%@include file="../adm_sidebar.jsp" %></div>
        </div>
        <%@include file = "../adm_top.jsp" %>

        <!-- page content -->
        <form action="adm_order_account_proc.jsp" method="post">
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>�ֹ����� <small>�ֹ����� �� �ش� ��ǰ�� ������ ǥ���մϴ�.</small></h3>
              </div>

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
              <div class="col-sm-12 col-md-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>��ٱ���</h2>
                    <input type="button" class="btn btn-primary pull-right" data-toggle="modal" data-target=".acc_method" value="�����ϱ�">
                    <div class="modal fade acc_method" tabindex="-1" role="dialog" aria-hidden="true">
                      <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">��</span></button>
                            <h4 class="modal-title" id="myModalLabel2">���� ��� ����</h4>
                          </div>
                          <div class="modal-body">
                            <p><input type="radio" name="or_account_method" value="0">&nbsp;EC���� </p>
                            <p><input type="radio" name="or_account_method" value="1">&nbsp;�ſ�ī��</p>
                            <p><input type="radio" name="or_account_method" value="2">&nbsp;������ü</p>
                            <p><input type="radio" name="or_account_method" value="3">&nbsp;�������Ա�</p>
                          </div>
                          <div class="modal-footer">
                            <input type="submit" class="btn btn-primary" value="���� �Ϸ�">
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content col-md-12">
                    <!-- start project list -->
                    <div class="col-sm-8 col-md-8 col-xs-8">
                    <%
                    pdd_index = 0;
                    int i=0;
                    for(ocVo cvo : companyList){ 
                      companyVo cvo2 = cdao.getCompanyInfo(cvo.getOc_co_id());
                       
                    %>  
                    <p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">��۱׷�<%=i+1 %>[<%=cvo2.getCo_name() %>]</p>
                    <table class="table table-striped projects">
                      <thead>
                        <tr>
                          <th colspan="2">��ǰ��ȣ</th>
                          <th>��ǰ��</th>
                          <th>����</th>
                          <th>������</th>
                          <th>����</th>
                          <th>����</th>
                          <th>���ϸ���</th>
                        </tr>
                      </thead>
                      <tbody>
                      <%for(int j=0; j<Integer.parseInt(index_pdd_co[i]);j++){ 
                         product_detailVo pddvo = pddao.selectByPdd_id(Integer.parseInt(pdd_id[pdd_index]));
                         int pd_id = pddvo.getPd_id();
                         productVo pvo = pdao.getProductInfo(pd_id);
                         discountVo disvo = disdao.selectDiscount(pd_id);
                      %>
                        <tr>
                          <td><%=pd_id %></td>
                          <td><ul class="list-inline"><li><img src="<%=pvo.getPd_main_img() %>" class="avatar" alt="Avatar"></li></ul></td>
                          <td><a><%=pvo.getPd_name() %></a><br /><small>��ٱ��� 2016 �߰�</small></td>
                          <td><%=pddvo.getCol_id() %></td>
                          <td><%=pddvo.getSz_id() %></td>
                          <td><%=opt_count[pdd_index] %><td>
                          
                          <%if(disvo.getDis()==0){ %>�� <%=pvo.getPd_price() %><%} 
                          else{
                             if(disvo.getDis_method()==0){%>�� <%=pvo.getPd_price()-(int)(pvo.getPd_price()*disvo.getDis_rate()*0.01) %><%}
                           else{%>�� <%=pvo.getPd_price()-disvo.getDis_value() %><%}
                          }
                          %>
                          <br /><small>( �� <%=pvo.getPd_price() %> )</small></td>
                          <td>�� <input type="text" style="border:none;background:transparent;width:100px" name="mileage" value="0" onKeyup="setTotal()">
                          
                          <!-- ���ۿ� ���� (������) -->
                          <input type="hidden" name="pdd_id" value="<%=pdd_id[pdd_index] %>">
                          <input type="hidden" name="col_id" value="<%=pddvo.getCol_id() %>">
                          <input type="hidden" name="sz_id" value="<%=pddvo.getSz_id() %>">
                          <input type="hidden" name="opt_count" value="<%=opt_count[pdd_index] %>">
                          </td>
                  </tr>
                 <%
                 
                 pdd_index++;
                      } %>
  
                      </tbody>
                      
                    </table>
                  <!-- ���ۿ� ���� (������) -->
                 
                    <input type="hidden" name="index_pdd_co" value="<%=index_pdd_co[i] %>">
                  <%i++;
                  } %>
                   <input type="hidden" name="index_co" value="<%=index_co %>">
                  </div> 
                  <div class="col-xs-4">
                    <p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">�������
                    <button type="button" class="btn btn-warning btn-xs pull-right" data-toggle="modal" data-target=".mem_address">����</button></p>
                    <div class="table-responsive">
                      <table class="table">
                        <tbody>
                          <tr>
                            <th style="width:30%">�����θ� *</th>
                            <td><input type="text" class="delivery_small" value="<%=mavo.getMa_name_recipient() %>"> </td>
                          </tr>
                          <tr>
                            <th>�����ȣ *</th>
                            <td><input type="text" class="delivery_small" value="<%=mavo.getMa_addr_zipcode()%>">
                            </td>
                          </tr>
                          <tr>
                            <th>�ּ� *</th>
                            <td><input type="text" class="delivery_large" value="<%=mavo.getMa_addr_base()%>"></td>
                          </tr>
                          <tr>
                            <th>����ó *</th>
                            <td><input type="text" class="delivery_small" value="<%=mavo.getMa_phone_recipient()%>"></td>
                          </tr>
                          <tr>
                            <th>��û���� </th>
                            <td><input type="text" class="delivery_large"></td>
                          </tr>
                        </tbody>
                      </table>
                    </div><br/>
                    <p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">�����ݾ�</p>
                    <div class="table-responsive">
                      <table class="table">
                        <tbody>
                          <tr>
                            <th style="width:50%">��ǰ���� (A)</th>
                            <td><%=cvdao.commify(price) %></td>
                          </tr>
                          <tr>
                            <th>���αݾ� (B)</th>
                            <td><%=cvdao.commify(discount) %></td>
                          </tr>
                          <tr>
                            <th>��ۺ� (C)</th>
                            <td><%=cvdao.commify(delivery) %></td>
                          </tr>
                          <tr>
                            <th>���ϸ��� ��� (D)</th>
                            <td>�� <input type="text" style="border:none;background:transparent;width:100px" id="mileage" value="0" onKeyup="setTotal()"></td>
                          </tr>
                          <tr>
                            <th>�� �����ݾ� (A-B+C-D)</th>
                            <td>�� <input type="text" style="border:none;background:transparent;width:100px" id="total" value="<%=total%>"></td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                    
                  </div>
                    <!-- end project list -->
                </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        </form>
        <!-- MODAL _ ADDRESS -->
        <form action="../3_member/adm_member_addr_update.jsp" name="change_addr" method="post">
        <div class="modal fade mem_address" tabindex="-1" role="dialog" aria-hidden="true">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">��</span></button>
                <h4 class="modal-title" id="myModalLabel2">��� �ּ� ����</h4>
              </div>
              <div class="modal-body">
                <div class="form-group col-md-6 col-sm-6 col-xs-12">
                  <label class="control-label col-md-4 col-sm-4 col-xs-4">�����θ� <span class="required">*</span></label>
                  <div class="col-md-8 col-sm-8 col-xs-12">
                    <input type="text" name="ma_name_recipient" value="<%=mavo.getMa_name_recipient() %>"required="required" class="form-control col-md-12 col-xs-12" >
                  </div>
                </div>
                <div class="form-group col-md-6 col-sm-6 col-xs-12">
                  <label class="control-label col-md-4 col-sm-4 col-xs-12">����ó <span class="required">*</span></label>
                  <div class="col-md-8 col-sm-8 col-xs-12">
                    <input type="text" name="ma_phone_recipient" value="<%=mavo.getMa_phone_recipient() %>"required="required" class="form-control col-md-12 col-xs-12" >
                  </div> 
                </div>
                <div class="form-group col-md-6 col-sm-6 col-xs-12">  
                  <label class="control-label col-md-4 col-sm-4 col-xs-12">�����ȣ <span class="required">*</span></label>
                  <div class="col-md-8 col-sm-8 col-xs-12"> 
                    <input type="text" name="ma_addr_zipcode" value="<%=mavo.getMa_addr_zipcode() %>"required="required" class="form-control col-md-9 col-xs-12" >
                  </div>
                </div>
                <div class="form-group col-md-6 col-sm-6 col-xs-12">    
                  <div class="col-md-12 col-sm-12 col-xs-12">   
                    <button type="button" class="btn btn-warning btn-sm">�˻�</button>
                  </div>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">   
                  <label class="control-label col-md-2 col-sm-2 col-xs-12">�ּ� <span class="required">*</span></label>
                  <div class="col-md-10 col-sm-10 col-xs-12">
                    <input type="text" name="ma_addr_base" value="<%=mavo.getMa_addr_base() %>"required="required" class="form-control col-md-12 col-xs-12" > 
                  </div>
                </div>  
                 <p><br><br><br><br><br><br></p>
             </div>
             <div class="modal-footer">
               <input type="submit" class="btn btn-primary" value="�����ϱ�">
             </div>
             
           </div>
         </div>
       </div>
       </form>
       <!-- MODAL _ ADDRESS -->          
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
    <!-- bootstrap-progressbar -->
    <script src="../../vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../../build/js/custom.min.js"></script>
    
    <script>
    function setTotal(){
       var mileage = document.getElementsByName("mileage");
       var target_total = document.getElementById("total");
       var mileage_total = document.getElementById("mileage");
       var temp=0;

      for(i=0; i<mileage.length; i++) {
          if(isNaN(parseInt(mileage[i].value))) mileage[i].value = 0;
          temp += parseInt(mileage[i].value);
       }
       mileage_total.value = parseInt(temp);
       target_total.value = parseInt(<%=total%>) - parseInt(temp);
    }
    </script>
  </body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>    
<%@ page import="ec.date.*" %>
<%@ page import="ec.product.*,ec.product_detail.*" %>
<%@ page import="ec.member_address.*" %>
<%@ page import="ec.delivery.*" %>
<%@ page import="ec.mileage_total.*" %>
<%	
	request.setCharacterEncoding("euc-kr"); 
	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	
	String now = dvo.getMonth()+"/"+dvo.getDate()+"/"+dvo.getYear()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond();
	int mem_id = 1;	// �α��� ȸ�� 1�̶�� ����.
	int pd_id = Integer.parseInt((String)request.getParameter("pd_id"));
	String pd_name = (String)request.getParameter("pd_name");
	String[] opt = request.getParameterValues("opt");
	String[] count = request.getParameterValues("count");
	
	String[] opt_color = new String[opt.length];
	String[] opt_size = new String[opt.length];
	String[] opt_count = new String[opt.length];

	for(int i=0;i<opt.length;i++){
		StringTokenizer str1 = new StringTokenizer(opt[i],",");
		opt_color[i] = str1.nextToken();
		opt_size[i] = str1.nextToken();
	}
	
	for(int i=0;i<opt.length;i++){
		StringTokenizer str2 = new StringTokenizer(count[i],",");
		opt_count[i] = str2.nextToken();
	}
	
	productDao pdao = new productDao();
	productVo pvo = pdao.getProductInfo(pd_id);
	int totalPrice = 0;
	
	for(int i=0;i<opt.length;i++){
		totalPrice = pvo.getPd_price() * Integer.parseInt(opt_count[i]) + totalPrice;
	}
	
	deliveryDao dedao = new deliveryDao();
	deliveryVo devo = dedao.selectDelivery(pd_id);
	
	member_addressDao madao = new member_addressDao();
	member_addressVo mavo = madao.getMemberInfo(mem_id);
	
	mtDao mtdao = new mtDao();
	mtVo mtvo = mtdao.getMileageInfo(pd_id);
		
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
	<!-- Select2 -->
    <link href="../vendors/select2/dist/css/select2.min.css" rel="stylesheet">
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
                    <h2>��ǰ�ֹ� </h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                  <form name = "orderInfo" action="adm_order_admission_proc.jsp" method="post" class="form-horizontal form-label-left">
                  	<input type="hidden" id="ord_mem_id" name="ord_mem_id" value="<%=mem_id%>">
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">��ǰ��ȣ</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <input type="text" id="ord_pd_id" name="ord_pd_id" class="form-control" value="<%=pd_id%>"readonly>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">���û�ǰ��</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <input type="text" class="form-control" value="<%=pd_name%>"readonly>
                      </div>
                    </div>
                    <div class="form-group">
                    <%for(int i=0;i<opt.length;i++){ %>
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">���ÿɼ� <%=i %></label>
                      <div class="col-md-5 col-sm-5 col-xs-12">
                        <input type="text" class="form-control" value="[����] <%=opt_color[i]%> [������] <%=opt_size[i] %> [����] <%=opt_count[i] %>�� "readonly>
                        <input type="hidden" name="ord_opt_color" value="<%=opt_color[i]%>"> 
                        <input type="hidden" name="ord_opt_size" value="<%=opt_size[i]%>"> 
                        <input type="hidden" name="ord_opt_count" value="<%=opt_count[i]%>">
                      </div>
                      <div class="col-md-5 col-sm-5 col-xs-12">
                        <input type="text" class="form-control" value="<%=Integer.parseInt(opt_count[i])*pvo.getPd_price()%>" readonly>
                      </div>
                    <%} %>  
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">��ǰ ����</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <input type="text" class="form-control" value="<%=totalPrice%>" readonly>
                      </div>
                    </div>
                    <div class="ln_solid"></div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">�������</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
	                    <div class="radio">
	                      <label><input type="radio" value="0" id="ord_account_method" name="ord_account_method" onClick="calTotal();" checked>EC ����&nbsp;&nbsp;</label>
                          <label><input type="radio" value="1" id="ord_account_method" name="ord_account_method" onClick="calTotal();">�޴��� �Ҿװ���</label>
                          <label><input type="radio" value="2" id="ord_account_method" name="ord_account_method" onClick="calTotal();">�ſ�ī��</label>
                          <label><input type="radio" value="3" id="ord_account_method" name="ord_account_method" onClick="calTotal();">�ǽð� ������ü</label>
                          <label><input type="radio" value="4" id="ord_account_method" name="ord_account_method" onClick="calTotal();">������ �Ա�</label>
                        </div>
	                  </div>
                    </div>
                    <div class="ln_solid"></div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">��ۺ�</label>
                      <%if(devo.getDe_method()==0){%>
                      <div class="col-md-5 col-sm-5 col-xs-12">
                        <input type="text" id = "ord_delivery_pay" class="form-control" value=<%=devo.getDe_price()%> readonly>
                      </div>
                      <div class="col-md-5 col-sm-5 col-xs-12">
                        <input type="text"class="form-control" value="�⺻��ۻ�ǰ" readonly>
                      </div>
                      <%}
                      else if(devo.getDe_method()==1){%>
                      <div class="col-md-5 col-sm-5 col-xs-12">
                      	<input type="text" id = "ord_delivery_pay" class="form-control" value=0 readonly>
                      </div>
                      <div class="col-md-5 col-sm-5 col-xs-12">
                        <input type="text"class="form-control" value="�����ۻ�ǰ" readonly>
                      </div>
                      <%}
                      else{ %>
                      <div class="col-md-5 col-sm-5 col-xs-12">
                      	<%if(totalPrice>=devo.getDe_price_condition()){ %>
                        	<input type="text" id = "ord_delivery_pay" class="form-control" value=0 readonly>
                        <%}else{ %>
                        	<input type="text" id = "ord_delivery_pay" class="form-control" value=<%=devo.getDe_price() %> readonly>
                        <%} %>
                      </div>
                      <div class="col-md-5 col-sm-5 col-xs-12">
                        <input type="text"class="form-control" value="���Ǻ� �����ۻ�ǰ" readonly>
                      </div>
                      <%} %>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">��ۺ� ���ҹ��</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <div class="radio" >
	                      <label><input type="radio" value="0" id="ord_delivery_pay_method" name="ord_delivery_pay_method" onClick="calTotal()" checked>������&nbsp;&nbsp;</label>
                          <label><input type="radio" value="1" id="ord_delivery_pay_method" name="ord_delivery_pay_method" onClick="calTotal()" >����</label>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">�����θ�</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                      <%if(mavo.getMa_name_recipient()==null){ %>
                        <input type="text" id="ord_name_recipient" name="ord_name_recipient" class="form-control">
                      <%}else{ %> 
                        <input type="text" id="ord_name_recipient" name="ord_name_recipient" class="form-control" value="<%=mavo.getMa_name_recipient()%>"> 
                      <%} %>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">�����ο���ó</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                    <%if(mavo.getMa_phone_recipient()==null){ %>                      
                        <input type="text" id="ord_phone_recipient" name="ord_phone_recipient" class="form-control">
                    <%}else{ %>
                        <input type="text" id="ord_phone_recipient" name="ord_phone_recipient" class="form-control" value="<%=mavo.getMa_phone_recipient()%>">
                    <%} %>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">����� �����ȣ</label>
                      <div class="col-md-5 col-sm-5 col-xs-12">
                      	<%if(mavo.getMa_addr_zipcode()==null){ %>
                        <input type="text" name="ord_zipcode" class="form-control" >
                        <%}else{ %>
                        <input type="text" name="ord_zipcode" class="form-control" value="<%=mavo.getMa_addr_zipcode()%>">
                        <%} %>
                      </div>
                      <div class="col-md-5 col-sm-5 col-xs-12">  
                        <button type="button" class="btn btn-warning">�ּҰ˻�</button>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">����� �ּ�</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                      <%if(mavo.getMa_addr_base()==null){ %>
                        <input type="text" name="ord_address" class="form-control">
                      <%}else{ %>
                        <input type="text" name="ord_address" class="form-control" value="<%=mavo.getMa_addr_base()%>">
                      <%} %>  
                      </div>
                    </div>
                    <div class="ln_solid"></div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">���ϸ������</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <div class="radio" >
	                      <label><input type="radio" value="0" id="ord_mileage" name="ord_mileage" onclick = 'mil_radio(this)' checked>�̻��&nbsp;&nbsp;</label>
                          <label><input type="radio" value="1" id="ord_mileage" name="ord_mileage" onclick = 'mil_radio(this)'>���</label>
                        </div>
                      </div>
                    </div>
                    <div id = "mil_div1" class="form-group" style="display:none">  
	                  <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">���ݾ�<span class="required">*</span></label>
	                  <div class="col-md-5 col-sm-5 col-xs-12">
	                    <input type="text" id="ord_mileage_value" name="ord_mileage_value" class="form-control col-md-12 col-xs-12" value=0 onkeyup="calTotal()">
	                  </div>
	                  <div class="col-md-5 col-sm-5 col-xs-12">
	                  	<input type="text" class="form-control col-md-12 col-xs-12" placeholder="��밡�ɱݾ� : <%=mtvo.getMt_value()%>" readonly>
	                  </div>
	                </div>
                    <div class="ln_solid"></div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">�� ���� ����</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <input type="text" id="ord_total_value" class="form-control" value=- readonly>
                        <input type="hidden" name="ord_account_time" value="<%=now %>">
                        
                      </div>
                    </div>
                    <div class="ln_solid"></div>
                    <div class="form-group">
                      <div class="col-md-12 col-sm-12 col-xs-12" >
                        <input type="submit" class="btn btn-primary pull-right" value="��������/�ֹ��ϱ�">
                      </div>
                    </div>
                  </form>
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
	<!-- Select2 -->
    <script src="../vendors/select2/dist/js/select2.full.min.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
   
   
   <script language="javascript">
   function calTotal(){
	   
	   var target = document.getElementById("ord_total_value");
	   var dePrice = document.getElementById("ord_delivery_pay").value;
	   var milValue = document.getElementById("ord_mileage_value").value;
	   var initialPrice = <%=totalPrice%>
	   var finalPrice = 0;
	   if(document.orderInfo.ord_delivery_pay_method[0].checked==true){
	   	finalPrice = parseInt(dePrice)+parseInt(initialPrice)-parseInt(milValue);
	   }
	   else if(ord_delivery_pay_method[1].checked==true){
		finalPrice = parseInt(initialPrice)-parseInt(milValue);   
	   }
	   target.value = finalPrice;
   }
   
   </script>
   
   <script language="javascript">
   function mil_radio(e){
   	var fm = document.orderInfo;
   	if(fm.ord_mileage[0].checked==true){
   		mil_div1.style.display = "none";
   		document.getElementById('ord_mileage_value').value=0;
   	}
   	else if(ord_mileage[1].checked==true){
   		mil_div1.style.display = "block";
   	}
   	calTotal();
   }
   </script>
   
   <!-- Select2 -->
    <script>
      $(document).ready(function() {
        $(".select2_single").select2({
          placeholder: "�׸��� �����ϼ���",
          allowClear: true
        });
        $(".select2_group").select2({});
        $(".select2_multiple").select2({
          maximumSelectionLength: 6,
          placeholder: "�׸��� �����ϼ���",
          allowClear: true
        });
      });
    </script>

  </body>
</html>
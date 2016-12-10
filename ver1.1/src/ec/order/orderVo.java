package ec.order;



public class orderVo {
   private   long or_id;
   private   int   mem_id;
   private String mem_name;
   private String mem_phone;
   private String mem_zipcode;
   private String mem_address;
   private   int or_total_price;
   private int or_total_discount;
   private int or_total_delivery_price;
   private int or_total_mileage;
   private int or_account_method;
   private int or_account_value;
   private String or_account_time;
   private String or_msg;
   private int or_status;
   private String or_status_msg;
   //order_info
   
   private int ord_id;
   private String co_id;
   private int pd_id;
   private int pdd_id;
   private int ord_count;
   private int ord_price;
   private int ord_discount;
   private int ord_use_mileage;
   private int ord_delivery_pay;
   private int ord_delivery_co_id;
   private int ord_delivery_num;
   private String ord_send_time;
   private String ord_receive_time;
   private String ord_decision_time;
   private String ord_exchange_time;
   private String ord_refund_time;
   private int ord_status;
   public long getOr_id() {
      return or_id;
   }
   public void setOr_id(long or_id) {
      this.or_id = or_id;
   }
   public int getMem_id() {
      return mem_id;
   }
   public void setMem_id(int mem_id) {
      this.mem_id = mem_id;
   }
   public String getMem_name() {
      return mem_name;
   }
   public void setMem_name(String mem_name) {
      this.mem_name = mem_name;
   }
   public String getMem_phone() {
      return mem_phone;
   }
   public void setMem_phone(String mem_phone) {
      this.mem_phone = mem_phone;
   }
   public String getMem_zipcode() {
      return mem_zipcode;
   }
   public void setMem_zipcode(String mem_zipcode) {
      this.mem_zipcode = mem_zipcode;
   }
   public String getMem_address() {
      return mem_address;
   }
   public void setMem_address(String mem_address) {
      this.mem_address = mem_address;
   }
   public int getOr_total_price() {
      return or_total_price;
   }
   public void setOr_total_price(int or_total_price) {
      this.or_total_price = or_total_price;
   }
   public int getOr_total_discount() {
      return or_total_discount;
   }
   public void setOr_total_discount(int or_total_discount) {
      this.or_total_discount = or_total_discount;
   }
   public int getOr_total_delivery_price() {
      return or_total_delivery_price;
   }
   public void setOr_total_delivery_price(int or_total_delivery_price) {
      this.or_total_delivery_price = or_total_delivery_price;
   }
   public int getOr_total_mileage() {
      return or_total_mileage;
   }
   public void setOr_total_mileage(int or_total_mileage) {
      this.or_total_mileage = or_total_mileage;
   }
   public int getOr_account_method() {
      return or_account_method;
   }
   public void setOr_account_method(int or_account_method) {
      this.or_account_method = or_account_method;
   }
   public int getOr_account_value() {
      return or_account_value;
   }
   public void setOr_account_value(int or_account_value) {
      this.or_account_value = or_account_value;
   }
   public String getOr_account_time() {
      return or_account_time;
   }
   public void setOr_account_time(String or_account_time) {
      this.or_account_time = or_account_time;
   }
   public String getOr_msg() {
      return or_msg;
   }
   public void setOr_msg(String or_msg) {
      this.or_msg = or_msg;
   }
   public int getOr_status() {
      return or_status;
   }
   public void setOr_status(int or_status) {
      this.or_status = or_status;
   }
   public String getOr_status_msg() {
      return or_status_msg;
   }
   public void setOr_status_msg(String or_status_msg) {
      this.or_status_msg = or_status_msg;
   }
   public int getOrd_id() {
      return ord_id;
   }
   public void setOrd_id(int ord_id) {
      this.ord_id = ord_id;
   }
   public String getCo_id() {
      return co_id;
   }
   public void setCo_id(String co_id) {
      this.co_id = co_id;
   }
   public int getPd_id() {
      return pd_id;
   }
   public void setPd_id(int pd_id) {
      this.pd_id = pd_id;
   }
   public int getPdd_id() {
      return pdd_id;
   }
   public void setPdd_id(int pdd_id) {
      this.pdd_id = pdd_id;
   }
   public int getOrd_count() {
      return ord_count;
   }
   public void setOrd_count(int ord_count) {
      this.ord_count = ord_count;
   }
   public int getOrd_price() {
      return ord_price;
   }
   public void setOrd_price(int ord_price) {
      this.ord_price = ord_price;
   }
   public int getOrd_discount() {
      return ord_discount;
   }
   public void setOrd_discount(int ord_discount) {
      this.ord_discount = ord_discount;
   }
   public int getOrd_use_mileage() {
      return ord_use_mileage;
   }
   public void setOrd_use_mileage(int ord_use_mileage) {
      this.ord_use_mileage = ord_use_mileage;
   }
   public int getOrd_delivery_pay() {
      return ord_delivery_pay;
   }
   public void setOrd_delivery_pay(int ord_delivery_pay) {
      this.ord_delivery_pay = ord_delivery_pay;
   }
   public int getOrd_delivery_co_id() {
      return ord_delivery_co_id;
   }
   public void setOrd_delivery_co_id(int ord_delivery_co_id) {
      this.ord_delivery_co_id = ord_delivery_co_id;
   }
   public int getOrd_delivery_num() {
      return ord_delivery_num;
   }
   public void setOrd_delivery_num(int ord_delivery_num) {
      this.ord_delivery_num = ord_delivery_num;
   }
   public String getOrd_send_time() {
      return ord_send_time;
   }
   public void setOrd_send_time(String ord_send_time) {
      this.ord_send_time = ord_send_time;
   }
   public String getOrd_receive_time() {
      return ord_receive_time;
   }
   public void setOrd_receive_time(String ord_receive_time) {
      this.ord_receive_time = ord_receive_time;
   }
   public String getOrd_decision_time() {
      return ord_decision_time;
   }
   public void setOrd_decision_time(String ord_decision_time) {
      this.ord_decision_time = ord_decision_time;
   }
   public String getOrd_exchange_time() {
      return ord_exchange_time;
   }
   public void setOrd_exchange_time(String ord_exchange_time) {
      this.ord_exchange_time = ord_exchange_time;
   }
   public String getOrd_refund_time() {
      return ord_refund_time;
   }
   public void setOrd_refund_time(String ord_refund_time) {
      this.ord_refund_time = ord_refund_time;
   }
   public int getOrd_status() {
      return ord_status;
   }
   public void setOrd_status(int ord_status) {
      this.ord_status = ord_status;
   }
   
   
   
   
}
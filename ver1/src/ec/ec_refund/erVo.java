package ec.ec_refund;

public class erVo {
	private int er_id;
	private int er_mem_id;
	private int er_why;		//환불 사유 (0:최초 관리자 설정, 1: 상품품절, 2:상품없음..)
	private int er_value;
	private int er_state;	//환불 처리상태 (0: 환불요청, 1: 환불승인)
	private String er_time;
	
	public int getEr_id() {
		return er_id;
	}
	public void setEr_id(int er_id) {
		this.er_id = er_id;
	}
	public int getEr_mem_id() {
		return er_mem_id;
	}
	public void setEr_mem_id(int er_mem_id) {
		this.er_mem_id = er_mem_id;
	}
	public int getEr_why() {
		return er_why;
	}
	public void setEr_why(int er_why) {
		this.er_why = er_why;
	}
	public int getEr_value() {
		return er_value;
	}
	public void setEr_value(int er_value) {
		this.er_value = er_value;
	}
	public int getEr_state() {
		return er_state;
	}
	public void setEr_state(int er_state) {
		this.er_state = er_state;
	}
	public String getEr_time() {
		return er_time;
	}
	public void setEr_time(String er_time) {
		this.er_time = er_time;
	}
	
	
}

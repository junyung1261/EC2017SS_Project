package ec.ec_pay;

public class epVo {
	private int ep_id;
	private int ep_mem_id;
	private int ep_where;		//ec 사용처 (0:최초 관리자 설정 , 1: 상품구매 ..)
	private int ep_value;
	private String ep_time;
	
	public int getEp_id() {
		return ep_id;
	}
	public void setEp_id(int ep_id) {
		this.ep_id = ep_id;
	}
	public int getEp_mem_id() {
		return ep_mem_id;
	}
	public void setEp_mem_id(int ep_mem_id) {
		this.ep_mem_id = ep_mem_id;
	}
	public int getEp_where() {
		return ep_where;
	}
	public void setEp_where(int ep_where) {
		this.ep_where = ep_where;
	}
	public int getEp_value() {
		return ep_value;
	}
	public void setEp_value(int ep_value) {
		this.ep_value = ep_value;
	}
	public String getEp_time() {
		return ep_time;
	}
	public void setEp_time(String ep_time) {
		this.ep_time = ep_time;
	}
	
}

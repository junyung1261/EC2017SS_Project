package ec.product_detail;

public class product_detailVo {
	private int pdd_id;
	private int pd_id;
	private int pdd_stk_count;
	private String col_id;
	private String sz_id;
	
	public int getPdd_id() {
		return pdd_id;
	}
	public void setPdd_id(int pdd_id) {
		this.pdd_id = pdd_id;
	}
	public int getPd_id() {
		return pd_id;
	}
	public void setPd_id(int pd_id) {
		this.pd_id = pd_id;
	}
	public String getCol_id() {
		return col_id;
	}
	public void setCol_id(String col_id) {
		this.col_id = col_id;
	}
	public String getSz_id() {
		return sz_id;
	}
	public void setSz_id(String sz_id) {
		this.sz_id = sz_id;
	}
	public int getPdd_stk_count() {
		return pdd_stk_count;
	}
	public void setPdd_stk_count(int pdd_stk_count) {
		this.pdd_stk_count = pdd_stk_count;
	}
}

package ec.product_mileage;

public class mileageVo {
	private int mil_id;		//mileage 고유식별번호 auto_increment
	private int mil_pd_id;	//제품 식별 번호
	private int mil;		//마일리지 지급 여부  (0 : 미지급 , 1: 지급)
	private int mil_rate;	//마일리지 지급 비율  (int%)
	
	public int getMil_id() {
		return mil_id;
	}
	public void setMil_id(int mil_id) {
		this.mil_id = mil_id;
	}
	public int getMil_pd_id() {
		return mil_pd_id;
	}
	public void setMil_pd_id(int mil_pd_id) {
		this.mil_pd_id = mil_pd_id;
	}
	public int getMil() {
		return mil;
	}
	public void setMil(int mil) {
		this.mil = mil;
	}
	public int getMil_rate() {
		return mil_rate;
	}
	public void setMil_rate(int mil_rate) {
		this.mil_rate = mil_rate;
	}
	
}

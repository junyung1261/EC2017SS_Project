package ec.delivery;

public class deliveryVo {

	private int de_id;
	private int de_method;			//0 기본배송   1무료배송  2조건부무료
	private int de_price;
	private int de_price_exception;
	private int de_price_condition;
	
	public int getDe_id() {
		return de_id;
	}
	public void setDe_id(int de_id) {
		this.de_id = de_id;
	}
	public int getDe_method() {
		return de_method;
	}
	public void setDe_method(int de_method) {
		this.de_method = de_method;
	}
	public int getDe_price() {
		return de_price;
	}
	public void setDe_price(int de_price) {
		this.de_price = de_price;
	}
	public int getDe_price_exception() {
		return de_price_exception;
	}
	public void setDe_price_exception(int de_price_exception) {
		this.de_price_exception = de_price_exception;
	}
	public int getDe_price_condition() {
		return de_price_condition;
	}
	public void setDe_price_condition(int de_price_condition) {
		this.de_price_condition = de_price_condition;
	}
}

package ec.discount;

public class discountVo {
private int dis_id;   // PK
private int dis;     	 // 0 : 미할인    1: 할인
private int dis_method;  // 0 : 정률       1: 정액
private int dis_rate;	 // 할인비율 (%)
private int dis_value;	 // 할인금액 (￦)

public int getDis_id() {
	return dis_id;
}
public void setDis_id(int dis_id) {
	this.dis_id = dis_id;
}
public int getDis() {
	return dis;
}
public void setDis(int dis) {
	this.dis = dis;
}
public int getDis_method() {
	return dis_method;
}
public void setDis_method(int dis_method) {
	this.dis_method = dis_method;
}
public int getDis_rate() {
	return dis_rate;
}
public void setDis_rate(int dis_rate) {
	this.dis_rate = dis_rate;
}
public int getDis_value() {
	return dis_value;
}
public void setDis_value(int dis_value) {
	this.dis_value = dis_value;
}
}

package ec.discount;

public class discountVo {
private int dis_id;   // PK
private int dis;     	 // 0 : ������    1: ����
private int dis_method;  // 0 : ����       1: ����
private int dis_rate;	 // ���κ��� (%)
private int dis_value;	 // ���αݾ� (��)

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

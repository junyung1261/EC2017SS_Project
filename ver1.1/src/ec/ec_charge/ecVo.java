package ec.ec_charge;

public class ecVo {
	private int ec_id;			//�⺻ id PK, AUTO
	private int ec_mem_id;		//ȸ�� id
	private int ec_how;			//ec ������� (0:��������  1:�޴����Ҿװ��� 2: ..)
	private int ec_value;		//ec �����ݾ�
	private String ec_time;		//ec �����ð�
	
	public int getEc_id() {
		return ec_id;
	}
	public void setEc_id(int ec_id) {
		this.ec_id = ec_id;
	}
	public int getEc_mem_id() {
		return ec_mem_id;
	}
	public void setEc_mem_id(int ec_mem_id) {
		this.ec_mem_id = ec_mem_id;
	}
	public int getEc_how() {
		return ec_how;
	}
	public void setEc_how(int ec_how) {
		this.ec_how = ec_how;
	}
	public int getEc_value() {
		return ec_value;
	}
	public void setEc_value(int ec_value) {
		this.ec_value = ec_value;
	}
	public String getEc_time() {
		return ec_time;
	}
	public void setEc_time(String ec_time) {
		this.ec_time = ec_time;
	}
	

}

package ec.member_grade;

public class member_gradeVo {
	private int mg_id;				//�ĺ� ��ȣ
	private String mg_mem_id;		//ȸ�� id (mem_id)
	private int mg_before_buy;		//���� ȸ�� ���űݾ�
	private int mg_before_order;	//���� ȸ�� ���ż���
	private int mg_before_confirm;	//���� ȸ�� ����Ȯ������
	private String mg_reg;			//���� ��������
	
	public int getMg_id() {
		return mg_id;
	}
	public void setMg_id(int mg_id) {
		this.mg_id = mg_id;
	}
	public String getMg_mem_id() {
		return mg_mem_id;
	}
	public void setMg_mem_id(String mg_mem_id) {
		this.mg_mem_id = mg_mem_id;
	}
	public int getMg_before_buy() {
		return mg_before_buy;
	}
	public void setMg_before_buy(int mg_before_buy) {
		this.mg_before_buy = mg_before_buy;
	}
	public int getMg_before_order() {
		return mg_before_order;
	}
	public void setMg_before_order(int mg_before_order) {
		this.mg_before_order = mg_before_order;
	}
	public int getMg_before_confirm() {
		return mg_before_confirm;
	}
	public void setMg_before_confirm(int mg_before_confirm) {
		this.mg_before_confirm = mg_before_confirm;
	}
	public String getMg_reg() {
		return mg_reg;
	}
	public void setMg_reg(String mg_reg) {
		this.mg_reg = mg_reg;
	}
	

}

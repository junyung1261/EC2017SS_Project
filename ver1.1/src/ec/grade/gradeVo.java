package ec.grade;

public class gradeVo {
	private int grd_id;					//��� ���� �ĺ���ȣ
	private String grd_name;			//��� �ѱ� �̸�
	private String grd_name_eng;		//��� ���� �̸�
	private String grd_reg;				//������� ������
	private int grd_score;				//��޻����� ���� �ּ����� (���űݾ� * ����Ȯ����, ����Ȯ���� = ȸ����������Ȯ�μ��� / ȸ�����ż���)
	
	public int getGrd_id() {
		return grd_id;
	}
	public void setGrd_id(int grd_id) {
		this.grd_id = grd_id;
	}
	public String getGrd_name() {
		return grd_name;
	}
	public void setGrd_name(String grd_name) {
		this.grd_name = grd_name;
	}
	public String getGrd_name_eng() {
		return grd_name_eng;
	}
	public void setGrd_name_eng(String grd_name_eng) {
		this.grd_name_eng = grd_name_eng;
	}
	public String getGrd_reg() {
		return grd_reg;
	}
	public void setGrd_reg(String grd_reg) {
		this.grd_reg = grd_reg;
	}
	public int getGrd_score() {
		return grd_score;
	}
	public void setGrd_score(int grd_score) {
		this.grd_score = grd_score;
	}
	
}

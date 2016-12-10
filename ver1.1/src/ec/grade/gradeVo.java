package ec.grade;

public class gradeVo {
	private int grd_id;					//등급 고유 식별번호
	private String grd_name;			//등급 한글 이름
	private String grd_name_eng;		//등급 영문 이름
	private String grd_reg;				//등급정보 갱신일
	private int grd_score;				//등급산정을 위한 최소점수 (구매금액 * 구매확정율, 구매확정율 = 회원직접구매확인수량 / 회원구매수량)
	
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

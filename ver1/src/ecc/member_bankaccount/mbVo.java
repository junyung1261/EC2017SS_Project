package ecc.member_bankaccount;

public class mbVo {
	private int mb_id;
	private int mb_mem_id;
	private int mb_name;	//예금주
	private String mb_bank;	//은행
	private String mb_account;//계좌번호
	private String mb_reg;	//정보수정일자
	
	public int getMb_id() {
		return mb_id;
	}
	public void setMb_id(int mb_id) {
		this.mb_id = mb_id;
	}
	public int getMb_mem_id() {
		return mb_mem_id;
	}
	public void setMb_mem_id(int mb_mem_id) {
		this.mb_mem_id = mb_mem_id;
	}
	public int getMb_name() {
		return mb_name;
	}
	public void setMb_name(int mb_name) {
		this.mb_name = mb_name;
	}
	public String getMb_bank() {
		return mb_bank;
	}
	public void setMb_bank(String mb_bank) {
		this.mb_bank = mb_bank;
	}
	public String getMb_account() {
		return mb_account;
	}
	public void setMb_account(String mb_account) {
		this.mb_account = mb_account;
	}
	public String getMb_reg() {
		return mb_reg;
	}
	public void setMb_reg(String mb_reg) {
		this.mb_reg = mb_reg;
	}
}

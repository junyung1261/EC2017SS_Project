package ec.message;

public class messageVo {
	private int msg_id;				//�޼��� �ĺ���ȣ
	private String msg_writer;		//�޼��� �ۼ���
	private String msg_receiver;	//�޼��� ������
	private String msg_title;		//�޼��� ����
	private String msg_contents;	//�޼��� ����
	private int msg_type;			//�޼��� Ÿ�� (0:���� 1:���)
	private int msg_state;			//�޼��� ���� (0:������ 1: ����)
	private String msg_time;		//�޼��� ���۽ð�
	
	public int getMsg_id() {
		return msg_id;
	}
	public void setMsg_id(int msg_id) {
		this.msg_id = msg_id;
	}
	public String getMsg_writer() {
		return msg_writer;
	}
	public void setMsg_writer(String msg_writer) {
		this.msg_writer = msg_writer;
	}
	public String getMsg_receiver() {
		return msg_receiver;
	}
	public void setMsg_receiver(String msg_receiver) {
		this.msg_receiver = msg_receiver;
	}
	public String getMsg_title() {
		return msg_title;
	}
	public void setMsg_title(String msg_title) {
		this.msg_title = msg_title;
	}
	public String getMsg_contents() {
		return msg_contents;
	}
	public void setMsg_contents(String msg_contents) {
		this.msg_contents = msg_contents;
	}
	public int getMsg_type() {
		return msg_type;
	}
	public void setMsg_type(int msg_type) {
		this.msg_type = msg_type;
	}
	public int getMsg_state() {
		return msg_state;
	}
	public void setMsg_state(int msg_state) {
		this.msg_state = msg_state;
	}
	public String getMsg_time() {
		return msg_time;
	}
	public void setMsg_time(String msg_time) {
		this.msg_time = msg_time;
	}
}	

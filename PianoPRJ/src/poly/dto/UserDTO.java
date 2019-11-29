package poly.dto;

public class UserDTO {
	private String user_seq; 
	private String user_type;
	private String id;
	private String email;
	private String password;
	private String user_name;
	private String user_sex;
	private String user_nick;
	private int user_state;
	private String user_tel;
	private String regdate;
	private String upddate;
	private String updater_seq;
	private String suspend_reason;
	
	
	
	public int getUser_state() {
		return user_state;
	}
	public void setUser_state(int user_state) {
		this.user_state = user_state;
	}
	public String getSuspend_reason() {
		return suspend_reason;
	}
	public void setSuspend_reason(String suspend_reason) {
		this.suspend_reason = suspend_reason;
	}
	
	public String getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(String user_seq) {
		this.user_seq = user_seq;
	}
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmail(int admin) {
		return email;
	}
	
	public String getEmail() {
		if(user_state==4) {
			return "-";
		}
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUser_name() {
		if(user_state==4) {
			return "(탈퇴 회원)";
		}
		return user_name;
	}
	public String getUser_name(int admin) {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_sex() {
		return user_sex;
	}
	public void setUser_sex(String user_sex) {
		this.user_sex = user_sex;
	}
	public String getUser_nick() {
		if(user_state==4) {
			return "(탈퇴 회원)";
		}
		return user_nick;
	}
	public String getUser_nick(int admin) {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public String getUser_tel() {
		if(user_state==4) {
			return "-";
		}
		return user_tel;
	}
	public String getUser_tel(int admin) {
		return user_tel;
	}
	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getUpddate() {
		return upddate;
	}
	public void setUpddate(String upddate) {
		this.upddate = upddate;
	}
	public String getUpdater_seq() {
		return updater_seq;
	}
	public void setUpdater_seq(String updater_seq) {
		this.updater_seq = updater_seq;
	}
	
	
}

package poly.dto;

public class FollowDTO {
	private String user_seq;
	private String tuner_seq;
	private String add_date;
	private String user_nick;
	private String deals;
	
	
	
	
	public String getDeals() {
		return deals;
	}
	public void setDeals(String deals) {
		this.deals = deals;
	}
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public String getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(String user_seq) {
		this.user_seq = user_seq;
	}
	public String getTuner_seq() {
		return tuner_seq;
	}
	public void setTuner_seq(String tuner_seq) {
		this.tuner_seq = tuner_seq;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	
	
}

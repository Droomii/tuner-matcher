package poly.dto;

public class ReviewDTO {
	private String deal_seq;
	private String writer_seq;
	private String tuner_seq;
	private String review_tech;
	private String review_punctual;
	private String review_kindness;
	private String review_content;
	private String regdate;
	private String upddate;
	private String updater_seq;
	private String user_nick;
	private String review_star;
	private int user_state;
	
	
	public int getUser_state() {
		return user_state;
	}
	public void setUser_state(int user_state) {
		this.user_state = user_state;
	}
	public String getReview_star() {
		return review_star;
	}
	public void setReview_star(String review_star) {
		this.review_star = review_star;
	}
	public String getDeal_seq() {
		return deal_seq;
	}
	public void setDeal_seq(String deal_seq) {
		this.deal_seq = deal_seq;
	}
	public String getWriter_seq() {
		return writer_seq;
	}
	public void setWriter_seq(String writer_seq) {
		this.writer_seq = writer_seq;
	}
	public String getTuner_seq() {
		return tuner_seq;
	}
	public void setTuner_seq(String tuner_seq) {
		this.tuner_seq = tuner_seq;
	}
	public String getReview_tech() {
		return review_tech;
	}
	public void setReview_tech(String review_tech) {
		this.review_tech = review_tech;
	}
	public String getReview_punctual() {
		return review_punctual;
	}
	public void setReview_punctual(String review_punctual) {
		this.review_punctual = review_punctual;
	}
	public String getReview_kindness() {
		return review_kindness;
	}
	public void setReview_kindness(String review_kindness) {
		this.review_kindness = review_kindness;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
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
	public String getUser_nick() {
		if(user_state>2)
			return "(탈퇴회원)";
		return user_nick;
	}
	
	public String getUser_nick(boolean admin) {
		if(admin)
			return user_nick;
		return getUser_nick();
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	
	
	
	
	
}

package poly.dto;

public class TunerDTO {
	private String tuner_name;
	private String tuner_seq;
	private int user_state;
	private String reject_reason;
	private String id_photo_dir;
	private String cert_dir;
	private String tuner_comment;
	private String tuner_level;
	private String tuner_exp;
	private String follower_num;
	private String feedback_score;
	private String deals_num;
	private String addr;
	private String detail_addr;
	private String sgg_code;
	private String affiliation;
	private String x_pos;
	private String y_pos;
	private String sido_name;
	private String sgg_name;
	private String emd_name;
	private String li_name;
	private String score;
	private String regdate;
	
	
	
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getTuner_name() {
		if(user_state==4) {
			return "(탈퇴한 조율사)";
		}
		return tuner_name;
	}
	public String getTuner_name(int admin) {
		return tuner_name;
	}
	
	public void setTuner_name(String tuner_name) {
		this.tuner_name = tuner_name;
	}
	public String getSido_name() {
		if(user_state==4) {
			return "";
		}
		return sido_name;
	}
	public String getSido_name(int admin) {
		return sido_name;
	}
	public void setSido_name(String sido_name) {
		this.sido_name = sido_name;
	}
	public String getSgg_name() {
		if(user_state==4) {
			return "";
		}
		return sgg_name;
	}
	public String getSgg_name(int admin) {
		return sgg_name;
	}
	public void setSgg_name(String sgg_name) {
		this.sgg_name = sgg_name;
	}
	public String getEmd_name() {
		return emd_name;
	}
	public void setEmd_name(String emd_name) {
		this.emd_name = emd_name;
	}
	public String getLi_name() {
		return li_name;
	}
	public void setLi_name(String li_name) {
		this.li_name = li_name;
	}
	public String getX_pos() {
		return x_pos;
	}
	public void setX_pos(String x_pos) {
		this.x_pos = x_pos;
	}
	public String getY_pos() {
		return y_pos;
	}
	public void setY_pos(String y_pos) {
		this.y_pos = y_pos;
	}
	public String getTuner_seq() {
		return tuner_seq;
	}
	public void setTuner_seq(String tuner_seq) {
		this.tuner_seq = tuner_seq;
	}
	public int getUser_state() {
		return user_state;
	}
	public void setUser_state(int user_state) {
		this.user_state = user_state;
	}
	public String getReject_reason() {
		return reject_reason;
	}
	public void setReject_reason(String reject_reason) {
		this.reject_reason = reject_reason;
	}
	public String getId_photo_dir() {
		return id_photo_dir;
	}
	public void setId_photo_dir(String id_photo_dir) {
		this.id_photo_dir = id_photo_dir;
	}
	public String getCert_dir() {
		return cert_dir;
	}
	public void setCert_dir(String cert_dir) {
		this.cert_dir = cert_dir;
	}
	public String getTuner_comment() {
		if(user_state==4) {
			return "-";
		}
		return tuner_comment;
	}
	public String getTuner_comment(int admin) {
		return tuner_comment;
	}
	public void setTuner_comment(String tuner_comment) {
		this.tuner_comment = tuner_comment;
	}
	public String getTuner_level() {
		return tuner_level;
	}
	public void setTuner_level(String tuner_level) {
		this.tuner_level = tuner_level;
	}
	public String getTuner_exp() {
		if(user_state==4) {
			return "-";
		}
		return tuner_exp;
	}
	public String getTuner_exp(int admin) {
		return tuner_exp;
	}
	public void setTuner_exp(String tuner_exp) {
		this.tuner_exp = tuner_exp;
	}
	public String getFollower_num() {
		if(user_state==4) {
			return "0";
		}
		return follower_num;
	}

	public String getFollower_num(int admin) {
		return follower_num;
	}
	public void setFollower_num(String follower_num) {
		this.follower_num = follower_num;
	}
	public String getFeedback_score() {
		if(user_state==4) {
			return "0";
		}
		return feedback_score;
	}
	public String getFeedback_score(int admin) {
		return feedback_score;
	}
	public void setFeedback_score(String feedback_score) {
		this.feedback_score = feedback_score;
	}
	public String getDeals_num() {
		if(user_state==4) {
			return "0";
		}
		return deals_num;
	}
	public String getDeals_num(int admin) {
		return deals_num;
	}
	public void setDeals_num(String deals_num) {
		this.deals_num = deals_num;
	}
	public String getAddr() {
		if(user_state==4) {
			return "-";
		}
		return addr;
	}
	public String getAddr(int admin) {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getDetail_addr() {
		if(user_state==4) {
			return "-";
		}
		return detail_addr;
	}
	public String getDetail_addr(int admin) {
		return detail_addr;
	}
	public void setDetail_addr(String detail_addr) {
		this.detail_addr = detail_addr;
	}
	public String getSgg_code() {
		return sgg_code;
	}
	public void setSgg_code(String sgg_code) {
		this.sgg_code = sgg_code;
	}
	public String getAffiliation() {
		if(user_state==4) {
			return "-";
		}
		return affiliation;
	}
	public String getAffiliation(int admin) {
		return affiliation;
	}
	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
	}
	
	
}

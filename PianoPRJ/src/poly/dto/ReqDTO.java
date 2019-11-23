package poly.dto;

public class ReqDTO implements Comparable<ReqDTO>{
	private String req_seq;
	private String requester_nick;
	private String user_seq;
	private String piano_seq;
	private String req_title;
	private String req_content;
	private String photo_dir;
	private String pref_date;
	private String regdate;
	private String upddate;
	private String updater_seq;
	private String piano_name;
	private String bids;
	private String private_seq;
	private String sido_name;
	private String sgg_name;
	private String x_pos;
	private String y_pos;
	private String dist;
	private String addr;
	private String private_tuner_name;
	private String req_state;
	
	
	public String getReq_state() {
		return req_state;
	}
	public void setReq_state(String req_state) {
		this.req_state = req_state;
	}
	public String getRequester_nick() {
		return requester_nick;
	}
	public void setRequester_nick(String requester_nick) {
		this.requester_nick = requester_nick;
	}
	public String getPrivate_tuner_name() {
		return private_tuner_name;
	}
	public void setPrivate_tuner_name(String private_tuner_name) {
		this.private_tuner_name = private_tuner_name;
	}
	public String getPrivate_seq() {
		return private_seq;
	}
	public void setPrivate_seq(String private_seq) {
		this.private_seq = private_seq;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getDist() {
		return dist;
	}
	public void setDist(String dist) {
		this.dist = dist;
	}
	public String getBids() {
		return bids;
	}
	public void setBids(String bids) {
		this.bids = bids;
	}
	public String getPiano_name() {
		return piano_name;
	}
	public void setPiano_name(String piano_name) {
		this.piano_name = piano_name;
	}
	public String getReq_seq() {
		return req_seq;
	}
	public void setReq_seq(String req_seq) {
		this.req_seq = req_seq;
	}
	public String getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(String user_seq) {
		this.user_seq = user_seq;
	}
	public String getPiano_seq() {
		return piano_seq;
	}
	public void setPiano_seq(String piano_seq) {
		this.piano_seq = piano_seq;
	}
	public String getReq_title() {
		return req_title;
	}
	public void setReq_title(String req_title) {
		this.req_title = req_title;
	}
	public String getReq_content() {
		return req_content;
	}
	public void setReq_content(String req_content) {
		this.req_content = req_content;
	}
	public String getPhoto_dir() {
		return photo_dir;
	}
	public void setPhoto_dir(String photo_dir) {
		this.photo_dir = photo_dir;
	}
	public String getPref_date() {
		return pref_date;
	}
	public void setPref_date(String pref_date) {
		this.pref_date = pref_date;
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
	public String getSido_name() {
		return sido_name;
	}
	public void setSido_name(String sido_name) {
		this.sido_name = sido_name;
	}
	public String getSgg_name() {
		return sgg_name;
	}
	public void setSgg_name(String sgg_name) {
		this.sgg_name = sgg_name;
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
	public void setUpdater_seq(String updater_seq) {
		this.updater_seq = updater_seq;
	}
	@Override
	public int compareTo(ReqDTO arg0) {
		double thisDist = Double.parseDouble(this.getDist()); 
		double otherDist = Double.parseDouble(arg0.getDist()); 
		double diff = thisDist - otherDist;
		if(diff>0) {
			return 1;
		}else if(diff<0) {
			return -1;
		}else {
			return 0;
		}
	}
	
	
}

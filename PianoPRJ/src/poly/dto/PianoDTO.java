package poly.dto;

public class PianoDTO {

	private String piano_seq;
	private String owner_seq;
	private String piano_name;
	private String piano_desc;
	private String brand;
	private String serial;
	private String addr;
	private String piano_type;
	private String player_type;
	private String last_tuned_date;
	private String piano_photo_dir;
	private String sgg_code;
	private String x_pos;
	private String y_pos;
	private String sido_name;
	private String sgg_name;
	private String emd_name;
	private String li_name;
	private String regdate;
	private String regseq;
	private String upddate;
	private String updseq;

	public String getPiano_type() {
		return piano_type;
	}

	public void setPiano_type(String piano_type) {
		this.piano_type = piano_type;
	}

	public String getPiano_seq() {
		return piano_seq;
	}

	public void setPiano_seq(String piano_seq) {
		this.piano_seq = piano_seq;
	}

	public String getOwner_seq() {
		return owner_seq;
	}

	public void setOwner_seq(String owner_seq) {
		this.owner_seq = owner_seq;
	}

	public String getPiano_name() {
		return piano_name;
	}

	public void setPiano_name(String piano_name) {
		this.piano_name = piano_name;
	}

	public String getPiano_desc() {
		return piano_desc;
	}

	public void setPiano_desc(String piano_desc) {
		this.piano_desc = piano_desc;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getSerial() {
		return serial;
	}

	public void setSerial(String serial) {
		this.serial = serial;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getPlayer_type() {
		return player_type;
	}

	public void setPlayer_type(String player_type) {
		this.player_type = player_type;
	}

	public String getLast_tuned_date() {
		return last_tuned_date;
	}

	public void setLast_tuned_date(String last_tuned_date) {
		this.last_tuned_date = last_tuned_date;
	}

	public String getPiano_photo_dir() {
		return piano_photo_dir;
	}

	public void setPiano_photo_dir(String piano_photo_dir) {
		this.piano_photo_dir = piano_photo_dir;
	}

	public String getsgg_code() {
		return sgg_code;
	}

	public void setsgg_code(String sgg_code) {
		this.sgg_code = sgg_code;
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

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getRegseq() {
		return regseq;
	}

	public void setRegseq(String regseq) {
		this.regseq = regseq;
	}

	public String getUpddate() {
		return upddate;
	}

	public void setUpddate(String upddate) {
		this.upddate = upddate;
	}

	public String getUpdseq() {
		return updseq;
	}

	public void setUpdseq(String updseq) {
		this.updseq = updseq;
	}
	
	@Override
	public String toString() {
		return "piano name : " + this.piano_name;
	}

}

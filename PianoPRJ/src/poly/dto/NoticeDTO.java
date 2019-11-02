package poly.dto;

/**
 * @author 이협건
 * @version 1.1 공지사항 DTO
 */
public class NoticeDTO {
	private String notice_seq;
	private String writer_seq;
	private String notice_title;
	private String notice_content;
	private String notice_count;
	private String regdate;
	private String upddate;
	private String updater_seq;
	private String top;
	
	public String getTop() {
		return top;
	}
	public void setTop(String top) {
		this.top = top;
	}
	public String getNotice_seq() {
		return notice_seq;
	}
	public void setNotice_seq(String notice_seq) {
		this.notice_seq = notice_seq;
	}
	public String getWriter_seq() {
		return writer_seq;
	}
	public void setWriter_seq(String writer_seq) {
		this.writer_seq = writer_seq;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public String getNotice_count() {
		return notice_count;
	}
	public void setNotice_count(String notice_count) {
		this.notice_count = notice_count;
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

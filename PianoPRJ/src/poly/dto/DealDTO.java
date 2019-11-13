package poly.dto;

import org.apache.log4j.Logger;

public class DealDTO {
	
	Logger log = Logger.getLogger(this.getClass());
	public String deal_seq;
	public String req_seq;
	public String requester_seq;
	public String requester_nick;
	public String tuner_seq;
	public String possible_date;
	public String diagnosis_content;
	public String tuning_price;
	public String regul_price;
	public String voicing_price;
	public String transport_price;
	public String other_price;
	public String regdate;
	public String upddate;
	public String updater_seq;
	public String deal_state;
	public String deal_type;
	public String tuning_ea;
	public String regul_ea;
	public String voicing_ea;
	public String transport_ea;

	public String getTotal() {
		int total = 0;
		int price;
		String[] prices = {
				this.tuning_price,
				this.regul_price,
				this.voicing_price,
				this.transport_price
		};
		
		String[] ea = {
				this.tuning_ea,
				this.regul_ea,
				this.voicing_ea,
				this.transport_ea
		};
		
		for(int i=0; i<4; i++) {
			if(prices[i]!=null) {
				price = Integer.parseInt(prices[i]) * Integer.parseInt(ea[i]);
				total += price;
			}
		}
		if(this.other_price!=null) {
			total += Integer.parseInt(this.other_price);
		}
		return String.format("%,d", total);
		
	}

	public String getTransport_ea() {
		return transport_ea;
	}
	public void setTransport_ea(String transport_ea) {
		this.transport_ea = transport_ea;
	}
	public String getRequester_nick() {
		return requester_nick;
	}
	public void setRequester_nick(String requester_nick) {
		this.requester_nick = requester_nick;
	}
	public String getDeal_seq() {
		return deal_seq;
	}
	public void setDeal_seq(String deal_seq) {
		this.deal_seq = deal_seq;
	}
	public String getReq_seq() {
		return req_seq;
	}
	public void setReq_seq(String req_seq) {
		this.req_seq = req_seq;
	}
	public String getRequester_seq() {
		return requester_seq;
	}
	public void setRequester_seq(String requester_seq) {
		this.requester_seq = requester_seq;
	}
	public String getTuner_seq() {
		return tuner_seq;
	}
	public void setTuner_seq(String tuner_seq) {
		this.tuner_seq = tuner_seq;
	}
	public String getPossible_date() {
		return possible_date;
	}
	public void setPossible_date(String possible_date) {
		this.possible_date = possible_date;
	}
	public String getDiagnosis_content() {
		return diagnosis_content;
	}
	public void setDiagnosis_content(String diagnosis_content) {
		this.diagnosis_content = diagnosis_content;
	}
	public String getTuning_price() {
		return tuning_price;
	}
	public void setTuning_price(String tuning_price) {
		this.tuning_price = tuning_price;
	}
	public String getRegul_price() {
		return regul_price;
	}
	public void setRegul_price(String regul_price) {
		this.regul_price = regul_price;
	}
	public String getVoicing_price() {
		return voicing_price;
	}
	public void setVoicing_price(String voicing_price) {
		this.voicing_price = voicing_price;
	}
	public String getTransport_price() {
		return transport_price;
	}
	public void setTransport_price(String transport_price) {
		this.transport_price = transport_price;
	}
	public String getOther_price() {
		return other_price;
	}
	public void setOther_price(String other_price) {
		this.other_price = other_price;
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
	public String getDeal_state() {
		return deal_state;
	}
	public void setDeal_state(String deal_state) {
		this.deal_state = deal_state;
	}
	public String getDeal_type() {
		return deal_type;
	}
	public void setDeal_type(String deal_type) {
		this.deal_type = deal_type;
	}
	public String getTuning_ea() {
		return tuning_ea;
	}
	public void setTuning_ea(String tuning_ea) {
		this.tuning_ea = tuning_ea;
	}
	public String getRegul_ea() {
		return regul_ea;
	}
	public void setRegul_ea(String regul_ea) {
		this.regul_ea = regul_ea;
	}
	public String getVoicing_ea() {
		return voicing_ea;
	}
	public void setVoicing_ea(String voicing_ea) {
		this.voicing_ea = voicing_ea;
	}
	
	
}

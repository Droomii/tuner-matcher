package poly.dto;

public class PriceDTO {
	private String deal_date;
	private String tuning_avg;
	private String regul_avg;
	private String voicing_avg;
	private String transport_avg;

	public PriceDTO() {
		
	}
	
	public PriceDTO(String deal_date) {
		this.deal_date = deal_date;
	}
	
	
	public String getDeal_date() {
		return deal_date;
	}

	public void setDeal_date(String deal_date) {
		this.deal_date = deal_date;
	}

	public String getTuning_avg() {
		return tuning_avg;
	}

	public void setTuning_avg(String tuning_avg) {
		this.tuning_avg = tuning_avg;
	}

	public String getRegul_avg() {
		return regul_avg;
	}

	public void setRegul_avg(String regul_avg) {
		this.regul_avg = regul_avg;
	}

	public String getVoicing_avg() {
		return voicing_avg;
	}

	public void setVoicing_avg(String voicing_avg) {
		this.voicing_avg = voicing_avg;
	}

	public String getTransport_avg() {
		return transport_avg;
	}

	public void setTransport_avg(String transport_avg) {
		this.transport_avg = transport_avg;
	}

	public void setEmpty(String deal_date) {
		this.deal_date = deal_date;
		this.tuning_avg = "0";
		this.regul_avg = "0";
		this.voicing_avg = "0";
		this.transport_avg = "0";
	}
	

	public void copyPrices(PriceDTO target) {
		this.tuning_avg = this.tuning_avg == null ? target.getTuning_avg() : this.tuning_avg;
		this.regul_avg = this.regul_avg == null ? target.getRegul_avg() : this.regul_avg;
		this.voicing_avg = this.voicing_avg == null ? target.getVoicing_avg() : this.voicing_avg;
		this.transport_avg = this.transport_avg == null ? target.getTransport_avg() : this.transport_avg;
	}

}

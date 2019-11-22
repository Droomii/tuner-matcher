package poly.dto;

public class RepuDTO {
	
	private String tuner_name;
	private String tech_pos;
	private String tech_neutral;
	private String tech_neg;
	private String punctual_pos;
	private String punctual_neutral;
	private String punctual_neg;
	private String kindness_pos;
	private String kindness_neutral;
	private String kindness_neg;
	private String score;
	private String total_deals;
	private String success_deals;
	private String total_reviews;
	
	public String getTuner_name() {
		return tuner_name;
	}


	public void setTuner_name(String tuner_name) {
		this.tuner_name = tuner_name;
	}
	
	public int getSuccessRate() {
		int total_deals = Integer.parseInt(this.total_deals);
		int success_deals = Integer.parseInt(this.success_deals);
		int successRate = Math.round((float)success_deals / total_deals * 100);
		return successRate;
	}
	
	
	public String getTotal_reviews() {
		return total_reviews;
	}

	public void setTotal_reviews(String total_reviews) {
		this.total_reviews = total_reviews;
	}

	public int getPositive_rate() {
		int tech_pos = Integer.parseInt(this.tech_pos);
		int tech_neg = Integer.parseInt(this.tech_neg);
		int punctual_pos = Integer.parseInt(this.punctual_pos);
		int punctual_neg = Integer.parseInt(this.punctual_neg);
		int kindness_pos = Integer.parseInt(this.kindness_pos);
		int kindness_neg = Integer.parseInt(this.kindness_neg);
		int total = 0;
		total +=tech_pos; 
		total +=tech_neg;
		total +=punctual_pos; 
		total +=punctual_neg;
		total +=kindness_pos;
		total +=kindness_neg;
		int posTotal = tech_pos + punctual_pos + kindness_pos;
		int positiveRate = Math.round((float)posTotal / total * 100);
		return positiveRate;
	}
	
	public int[] getTechRates() {
		int kindness_neg = Integer.parseInt(this.kindness_neg);
		int kindness_neutral = Integer.parseInt(this.kindness_neutral);
		int kindness_pos = Integer.parseInt(this.kindness_pos);
		int total = kindness_neg + kindness_neutral + kindness_pos;
		int[] rates = new int[3];
		rates[0] = Math.round((float)kindness_pos / total * 100);
		rates[1] = Math.round((float)kindness_neutral / total * 100);
		rates[2] = Math.round((float)kindness_neg / total * 100);
		return rates;
	}
	public int[] getPunctualRates() {
		int punctual_neg = Integer.parseInt(this.punctual_neg);
		int punctual_neutral = Integer.parseInt(this.punctual_neutral);
		int punctual_pos = Integer.parseInt(this.punctual_pos);
		int total = punctual_neg + punctual_neutral + punctual_pos;
		int[] rates = new int[3];
		rates[0] = Math.round((float)punctual_pos / total * 100);
		rates[1] = Math.round((float)punctual_neutral / total * 100);
		rates[2] = Math.round((float)punctual_neg / total * 100);
		return rates;
	}
	public int[] getKindnessRates() {
		int kindness_neg = Integer.parseInt(this.kindness_neg);
		int kindness_neutral = Integer.parseInt(this.kindness_neutral);
		int kindness_pos = Integer.parseInt(this.kindness_pos);
		int total = kindness_neg + kindness_neutral + kindness_pos;
		int[] rates = new int[3];
		rates[0] = Math.round((float)kindness_pos / total * 100);
		rates[1] = Math.round((float)kindness_neutral / total * 100);
		rates[2] = Math.round((float)kindness_neg / total * 100);
		return rates;
	}
	
	public String getTech_pos() {
		return tech_pos;
	}
	public void setTech_pos(String tech_pos) {
		this.tech_pos = tech_pos;
	}
	public String getTech_neutral() {
		return tech_neutral;
	}
	public void setTech_neutral(String tech_neutral) {
		this.tech_neutral = tech_neutral;
	}
	public String getTech_neg() {
		return tech_neg;
	}
	public void setTech_neg(String tech_neg) {
		this.tech_neg = tech_neg;
	}
	public String getPunctual_pos() {
		return punctual_pos;
	}
	public void setPunctual_pos(String punctual_pos) {
		this.punctual_pos = punctual_pos;
	}
	public String getPunctual_neutral() {
		return punctual_neutral;
	}
	public void setPunctual_neutral(String punctual_neutral) {
		this.punctual_neutral = punctual_neutral;
	}
	public String getPunctual_neg() {
		return punctual_neg;
	}
	public void setPunctual_neg(String punctual_neg) {
		this.punctual_neg = punctual_neg;
	}
	public String getKindness_pos() {
		return kindness_pos;
	}
	public void setKindness_pos(String kindness_pos) {
		this.kindness_pos = kindness_pos;
	}
	public String getKindness_neutral() {
		return kindness_neutral;
	}
	public void setKindness_neutral(String kindness_neutral) {
		this.kindness_neutral = kindness_neutral;
	}
	public String getKindness_neg() {
		return kindness_neg;
	}
	public void setKindness_neg(String kindness_neg) {
		this.kindness_neg = kindness_neg;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getTotal_deals() {
		return total_deals;
	}
	public void setTotal_deals(String total_deals) {
		this.total_deals = total_deals;
	}
	public String getSuccess_deals() {
		return success_deals;
	}
	public void setSuccess_deals(String success_deals) {
		this.success_deals = success_deals;
	}
	
	
	
	
}

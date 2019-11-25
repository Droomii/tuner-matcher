package poly.service;

import java.util.List;

import poly.dto.DealDTO;
import poly.dto.RescheduleDTO;

public interface IDealService {

	int insertDeal(DealDTO dDTO) throws Exception;

	List<DealDTO> getBiddingList(String user_seq) throws Exception;

	DealDTO getDealDetail(String deal_seq) throws Exception;

	int bidCancel(String deal_seq) throws Exception;

	List<DealDTO> getPastDeals(String user_seq) throws Exception;

	List<DealDTO> getReqBid(String req_seq) throws Exception;

	int auctionOff(String deal_seq, String req_seq, String user_seq) throws Exception;

	List<DealDTO> getUserDealList(String user_seq) throws Exception;

	int dealCancel(String deal_seq, String user_seq, int user_type) throws Exception;

	int dealConfirm(String deal_seq, String user_seq, int user_type) throws Exception;

	DealDTO getPrivateEstimate(String req_seq) throws Exception;

	int declineDeal(String deal_seq, String req_seq, String user_seq) throws Exception;

	List<DealDTO> getTunerDealList(String user_seq) throws Exception;

	int insertReschedule(RescheduleDTO rDTO) throws Exception;

}

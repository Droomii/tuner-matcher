package poly.service;

import java.util.List;

import poly.dto.DealDTO;

public interface IDealService {

	int insertDeal(DealDTO dDTO) throws Exception;

	List<DealDTO> getBiddingList(String user_seq) throws Exception;

}

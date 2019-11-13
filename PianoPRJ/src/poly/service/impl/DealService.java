package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.DealDTO;
import poly.persistance.mapper.IDealMapper;
import poly.service.IDealService;

@Service("DealService")
public class DealService implements IDealService{

	@Resource(name="DealMapper")
	IDealMapper dealMapper;
	
	@Override
	public int insertDeal(DealDTO dDTO) throws Exception {
		return dealMapper.insertDeal(dDTO);
	}

	@Override
	public List<DealDTO> getBiddingList(String user_seq) throws Exception {
		return dealMapper.getBiddingList(user_seq);
	}

}

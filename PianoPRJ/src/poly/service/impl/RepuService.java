package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.RepuDTO;
import poly.persistance.mapper.IRepuMapper;
import poly.service.IRepuService;

@Service("RepuService")
public class RepuService implements IRepuService{
	
	@Resource(name = "RepuMapper")
	IRepuMapper repuMapper;
	
	@Override
	public RepuDTO getRepu(String user_seq) throws Exception {
		RepuDTO rDTO = repuMapper.getRepu(user_seq); 
		return null;
	}

}

package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.ReqDTO;
import poly.persistance.mapper.IReqMapper;
import poly.service.IReqService;

@Service("ReqService")
public class ReqService implements IReqService {

	@Resource(name = "ReqMapper")
	private IReqMapper reqMapper;

	@Override
	public int insertReq(ReqDTO rDTO) throws Exception {
		return reqMapper.insertReq(rDTO);
	}

}

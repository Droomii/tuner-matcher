package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.SggDTO;
import poly.persistance.mapper.ISggMapper;
import poly.service.ISggService;

@Service("SggService")
public class SggService implements ISggService{

	@Resource(name="ISggMapper")
	private ISggMapper sggMapper;

	public List<SggDTO> getSido() throws Exception{
		return sggMapper.getSido();
	}

	@Override
	public List<SggDTO> getSgg(String sidoCode) throws Exception {
		return sggMapper.getSgg(sidoCode);
	}

	@Override
	public SggDTO getTunerSgg(String user_seq) throws Exception {
		return sggMapper.getTunerSgg(user_seq);
	}

}

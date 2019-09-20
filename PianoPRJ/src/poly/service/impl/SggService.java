package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.SggDTO;
import poly.persistance.mapper.SggMapper;
import poly.service.ISggService;

@Service("SggService")
public class SggService implements ISggService{

	@Resource(name="SggMapper")
	private SggMapper sggMapper;

	public List<SggDTO> getSido() throws Exception{
		return sggMapper.getSido();
	}

	@Override
	public List<SggDTO> getSgg(String sidoCode) throws Exception {
		return sggMapper.getSgg(sidoCode);
	}

}

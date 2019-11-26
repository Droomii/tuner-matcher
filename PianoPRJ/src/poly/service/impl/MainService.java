package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.MainDTO;
import poly.persistance.mapper.IMainMapper;
import poly.service.IMainService;

@Service("MainService")
public class MainService implements IMainService{

	@Resource(name = "MainMapper")
	IMainMapper mainMapper;
	
	@Override
	public MainDTO getTunerMain(String user_seq) throws Exception {
		return mainMapper.getTunerMain(user_seq);
	}

}

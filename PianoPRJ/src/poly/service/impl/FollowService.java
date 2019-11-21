package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.persistance.mapper.IFollowMapper;
import poly.service.IFollowService;

@Service("FollowService")
public class FollowService implements IFollowService{

	@Resource(name="FollowMapper")
	private IFollowMapper followMapper;
	
	public void followTuner(String user_seq, String tuner_seq) throws Exception{
		followMapper.followTuner(user_seq, tuner_seq);
	}

}

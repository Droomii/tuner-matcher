package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.TunerDTO;
import poly.persistance.mapper.IFollowMapper;
import poly.service.IFollowService;

@Service("FollowService")
public class FollowService implements IFollowService{

	@Resource(name="FollowMapper")
	private IFollowMapper followMapper;
	
	public void followTuner(String user_seq, String tuner_seq) throws Exception{
		followMapper.followTuner(user_seq, tuner_seq);
	}

	@Override
	public List<TunerDTO> getFollowingList(String user_seq) throws Exception {
		return followMapper.getFollowingList(user_seq);
	}

	@Override
	public int removeFollow(String user_seq, String tuner_seq) throws Exception {
		return followMapper.removeFollow(user_seq, tuner_seq);
	}

	@Override
	public int verifyFollow(String tuner_seq, String user_seq) throws Exception {
		return followMapper.verifyFollow(tuner_seq, user_seq);
	}

}

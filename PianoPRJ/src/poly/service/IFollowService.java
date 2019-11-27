package poly.service;

import java.util.List;

import poly.dto.TunerDTO;

public interface IFollowService {

	void followTuner(String user_seq, String tuner_seq) throws Exception;

	List<TunerDTO> getFollowingList(String user_seq) throws Exception;

	int removeFollow(String user_seq, String tuner_seq) throws Exception;

	int verifyFollow(String tuner_seq, String user_seq) throws Exception;

}

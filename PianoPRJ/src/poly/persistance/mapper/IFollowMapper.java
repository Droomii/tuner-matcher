package poly.persistance.mapper;

import config.Mapper;

@Mapper("FollowMapper")
public interface IFollowMapper {

	void followTuner(String user_seq, String tuner_seq) throws Exception;

}

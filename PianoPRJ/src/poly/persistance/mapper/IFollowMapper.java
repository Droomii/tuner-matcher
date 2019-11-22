package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.TunerDTO;

@Mapper("FollowMapper")
public interface IFollowMapper {

	void followTuner(String user_seq, String tuner_seq) throws Exception;

	List<TunerDTO> getFollowingList(String user_seq) throws Exception;

	int removeFollow(String user_seq, String tuner_seq) throws Exception;

}

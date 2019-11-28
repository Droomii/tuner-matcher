package poly.persistance.mapper;

import config.Mapper;
import poly.dto.MainDTO;

@Mapper("MainMapper")
public interface IMainMapper {

	MainDTO getTunerMain(String user_seq) throws Exception;

	MainDTO getUserMain(String user_seq) throws Exception;

}

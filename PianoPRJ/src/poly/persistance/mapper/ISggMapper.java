package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.SggDTO;

@Mapper("ISggMapper")
public interface ISggMapper {

	List<SggDTO> getSido() throws Exception;

	List<SggDTO> getSgg(String sidoCode) throws Exception;

	List<SggDTO> getTunerSgg(String user_seq) throws Exception;


}

package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.SggDTO;

@Mapper("SggMapper")
public interface SggMapper {

	List<SggDTO> getSido() throws Exception;

	List<SggDTO> getSgg(String sidoCode);


}

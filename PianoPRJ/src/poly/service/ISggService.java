package poly.service;

import java.util.List;

import poly.dto.SggDTO;

public interface ISggService {

	List<SggDTO> getSido() throws Exception;

	List<SggDTO> getSgg(String sidoCode) throws Exception;

	SggDTO getTunerSgg(String user_seq) throws Exception;

}

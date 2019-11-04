package poly.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import poly.dto.SggDTO;

public interface ISggService {

	List<SggDTO> getSido() throws Exception;

	List<SggDTO> getSgg(String sidoCode) throws Exception;

	Map<String, ArrayList<String>> getTunerSgg(String user_seq) throws Exception;

}

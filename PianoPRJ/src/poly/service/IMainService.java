package poly.service;

import poly.dto.MainDTO;

public interface IMainService {

	MainDTO getTunerMain(String user_seq) throws Exception;

}

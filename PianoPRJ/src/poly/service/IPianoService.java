package poly.service;

import java.util.List;

import poly.dto.PianoDTO;

public interface IPianoService {

	int insertPiano(PianoDTO pDTO) throws Exception;

	List<PianoDTO> getMyPianoList(String user_seq) throws Exception;

}

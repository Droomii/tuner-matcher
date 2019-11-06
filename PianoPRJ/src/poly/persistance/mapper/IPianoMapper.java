package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.PianoDTO;

@Mapper("PianoMapper")
public interface IPianoMapper {

	int insertPiano(PianoDTO pDTO) throws Exception;

	List<PianoDTO> getMyPianoList(String user_seq) throws Exception;
	
}

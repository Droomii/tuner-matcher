package poly.persistance.mapper;

import config.Mapper;
import poly.dto.PianoDTO;

@Mapper("PianoMapper")
public interface IPianoMapper {

	int insertPiano(PianoDTO pDTO) throws Exception;
	
}

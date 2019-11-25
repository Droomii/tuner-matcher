package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.PianoDTO;

@Mapper("PianoMapper")
public interface IPianoMapper {

	int insertPiano(PianoDTO pDTO) throws Exception;

	List<PianoDTO> getMyPianoList(String user_seq) throws Exception;

	PianoDTO getPianoDetail(String piano_seq) throws Exception;

	int deletePiano(String piano_seq) throws Exception;

	int updatePiano(PianoDTO pDTO) throws Exception;

	PianoDTO getPianoEditInfo(String piano_seq) throws Exception;

	int getPianoCurrVal() throws Exception;

	
}

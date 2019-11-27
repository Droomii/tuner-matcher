package poly.persistance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.PianoDTO;

@Mapper("PianoMapper")
public interface IPianoMapper {

	int insertPiano(PianoDTO pDTO) throws Exception;

	List<PianoDTO> getMyPianoList(String user_seq) throws Exception;

	PianoDTO getPianoDetail(@Param("piano_seq")String piano_seq, @Param("user_seq") String user_seq) throws Exception;

	int deletePiano(@Param("piano_seq")String piano_seq, @Param("user_seq") String user_seq) throws Exception;

	int updatePiano(PianoDTO pDTO) throws Exception;

	PianoDTO getPianoEditInfo(@Param("piano_seq")String piano_seq, @Param("user_seq") String user_seq) throws Exception;

	int getPianoCurrVal() throws Exception;

	
}

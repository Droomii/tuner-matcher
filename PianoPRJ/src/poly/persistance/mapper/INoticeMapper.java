package poly.persistance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.NoticeDTO;

@Mapper("INoticeMapper")
public interface INoticeMapper {

	//게시판 리스트
	List<NoticeDTO> getNoticeList(@Param("start")int start, @Param("end")int end) throws Exception;
	
	//게시판 글 등록
	void insertNoticeInfo(NoticeDTO pDTO) throws Exception;
	
	//게시판 상세보기
	NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception;

	//게시판 조회수 업데이트
	void updateNoticeReadCnt(NoticeDTO pDTO) throws Exception;
	
	//게시판 글 수정
	void updateNoticeInfo(NoticeDTO pDTO) throws Exception;
	
	//게시판 글 삭제
	void deleteNoticeInfo(NoticeDTO pDTO) throws Exception;

	//상단공지 불러오기
	List<NoticeDTO> getTopNoticeList() throws Exception;

	int getNoticeListCnt() throws Exception;
	
}

package poly.service;

import java.util.List;

import poly.dto.NoticeDTO;

public interface INoticeService {

	List<NoticeDTO> getNoticeList(int start, int end) throws Exception;
	
	void insertNoticeInfo(NoticeDTO pDTO) throws Exception;

	NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception;
	
	void updateNoticeReadCnt(NoticeDTO pDTO) throws Exception;
	
	void updateNoticeInfo(NoticeDTO pDTO) throws Exception;
	
	void deleteNoticeInfo(NoticeDTO pDTO) throws Exception;

	List<NoticeDTO> getTopNoticeList() throws Exception;

	int getNoticeListCnt() throws Exception;
	
}

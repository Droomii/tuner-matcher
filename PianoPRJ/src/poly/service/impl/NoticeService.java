package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.NoticeDTO;
import poly.persistance.mapper.INoticeMapper;
import poly.service.INoticeService;

@Service("NoticeService")
public class NoticeService implements INoticeService{
	
	@Resource(name="INoticeMapper")
	private INoticeMapper noticeMapper;
	
	@Override
	public List<NoticeDTO> getNoticeList(int start, int end) throws Exception {
		return noticeMapper.getNoticeList(start, end);
		
	}
	
	@Override
	public void insertNoticeInfo(NoticeDTO pDTO) throws Exception {
		noticeMapper.insertNoticeInfo(pDTO);
		
	}
	
	@Override
	public NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception {
		return noticeMapper.getNoticeInfo(pDTO);
		
	}
	
	@Override
	public void updateNoticeReadCnt(NoticeDTO pDTO) throws Exception {
		noticeMapper.updateNoticeReadCnt(pDTO);;
		
	}
	
	@Override
	public void updateNoticeInfo(NoticeDTO pDTO) throws Exception {
		noticeMapper.updateNoticeInfo(pDTO);
		
	}
	
	@Override
	public void deleteNoticeInfo(NoticeDTO pDTO) throws Exception {
		noticeMapper.deleteNoticeInfo(pDTO);
		
	}

	@Override
	public List<NoticeDTO> getTopNoticeList() throws Exception {
		
		return noticeMapper.getTopNoticeList();
	}

	@Override
	public int getNoticeListCnt() throws Exception {
		return noticeMapper.getNoticeListCnt();
	}
}

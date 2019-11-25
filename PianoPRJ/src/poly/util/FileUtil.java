package poly.util;

import java.io.File;
import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

public class FileUtil {
	/**이미지 파일 저장
	 * @param mf : 받은 멀티파트 파일
	 * @param name : 파일 저장될 이름
	 * @param path : 파일 저장될 경로
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	public static String saveImage(MultipartFile mf, String name, String path) throws IllegalStateException, IOException {
		String origFileName = mf.getOriginalFilename();
		String ext = origFileName.substring(origFileName.lastIndexOf(".")+1).toLowerCase();
		
		// 이미지 확장자 확인
		if(ext.matches("^jpg$|^gif$|^jpeg$|^png$")) {
			
			File folder = new File(path);
			if(!folder.exists()) {
				folder.mkdirs();
			}
			
			File fullPath = new File(path + name + "." + ext);
			if(fullPath.exists()) {
				fullPath.delete();
			}
			mf.transferTo(fullPath);
			
		}else {
			throw new IOException("Invalid Image File");
		}
		
		return ext;
	}
	
	public static boolean isImage(MultipartFile mf) {
		String origFileName = mf.getOriginalFilename();
		String ext = origFileName.substring(origFileName.lastIndexOf(".")+1).toLowerCase();
		
		// 이미지 확장자 확인
		if(ext.matches("^jpg$|^gif$|^jpeg$|^png$")) {
			return true;
		}else {
			return false;
		}
	}
	public static String getExt(MultipartFile mf) {
		String origFileName = mf.getOriginalFilename();
		String ext = origFileName.substring(origFileName.lastIndexOf(".")+1).toLowerCase();
		
		return ext;
	}
	
}

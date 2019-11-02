package poly.util;

public class EncryptTest {

	public static void main(String[] args) throws Exception{
		
		System.out.println("-------------------------");
		System.out.println("해시 암호화 알고리즘");
		
		String str = "12394812397841236789041236784678912346789123467891234678912367894123678941236789412367894123678941236789467891234678912346789";
		
		String hashEnc = EncryptUtil.encHashSHA256(str);
		
		System.out.println("hashEnd : " + hashEnc);
		
		System.out.println("-------------------------");
		
		System.out.println("-------------------------");
		System.out.println("AES암호화 알고리즘");
		
		String str2 = "1234";
		
		String aesEnc = EncryptUtil.encAES128CBC(str2);
		System.out.println("처음 문구 :" + str2);
		System.out.println("암호화된 문구 : " + aesEnc);
		
		String aesDec = EncryptUtil.decAES128CBC(aesEnc);
		
		System.out.println("복호화된 문구 : " + aesDec);
		
		System.out.println("-------------------------");
		
	}
	
}

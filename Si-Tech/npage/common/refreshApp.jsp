<%
  /*
   * ����:ˢ��Ȩ��Applicationҳ��
   * �汾: 1.0
   * ����: 2014/11/13 14:12:32
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>

<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.*;" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 

%>
<%!
	public String readValue(String param1,String param2,String param3,String paths) {//����keyֵ��·����ѯproperties�ļ���rdmessage��Ϣ
  String returnValues=null;
  Properties props = new Properties();
  String key = param1+"."+param2+"."+param3;
        try {
       
        InputStream in = new BufferedInputStream(new FileInputStream(paths));
         props.load(in);
          returnValues =new String(props.getProperty(key).getBytes("ISO-8859-1"),"gbk"); 
        
            return returnValues;
        } catch (FileNotFoundException ex) {
         ex.printStackTrace();
         
         return null;
         
        }catch (Exception e) {
         e.printStackTrace();
         
         return null;
         
        }
        
 }
 
 //���·���Ϊ���ܷ���
private String encrypt(String host){
	if (host==null || "".equals(host)){
		return ""; 
	}
	try{
		Cipher encryptCipher = null;
		String strDefaultKey = "www.si-tech.com.cn";
		//Security.addProvider(new com.sun.crypto.provider.SunJCE());
		Key key = getKey(strDefaultKey.getBytes());

		encryptCipher = Cipher.getInstance("DES");
		encryptCipher.init(Cipher.ENCRYPT_MODE, key);

		return byteArr2HexStr(encryptCipher.doFinal(host.getBytes()));
	}
	catch(Exception e){
		e.printStackTrace();
		return "";
	}
}


private static String byteArr2HexStr(byte[] arrB) throws Exception {
	int iLen = arrB.length;
	//ÿ��byte�������ַ����ܱ�ʾ�������ַ����ĳ��������鳤�ȵ�����
	StringBuffer sb = new StringBuffer(iLen * 2);
	for (int i = 0; i < iLen; i++) {
		int intTmp = arrB[i];
		//�Ѹ���ת��Ϊ����
		while (intTmp < 0) {
			intTmp = intTmp + 256;
		}
		//С��0F������Ҫ��ǰ�油0
		if (intTmp < 16) {
			sb.append("0");
		}
		sb.append(Integer.toString(intTmp, 16));
	}
	return sb.toString();
}

private Key getKey(byte[] arrBTmp) throws Exception {
	//����һ���յ�8λ�ֽ����飨Ĭ��ֵΪ0��
	byte[] arrB = new byte[8];
	//��ԭʼ�ֽ�����ת��Ϊ8λ
	for (int i = 0; i < arrBTmp.length && i < arrB.length; i++) {
		arrB[i] = arrBTmp[i];
	}
	//������Կ
	Key key = new javax.crypto.spec.SecretKeySpec(arrB, "DES");
	return key;
}

%>

<%!
	/*2014/10/16 10:46:16 gaopeng ���¼���properties����*/
	public static boolean ResetApplication(HttpServletRequest req,HttpSession sen){
			
			ServletContext application = sen.getServletContext();	
			boolean is = false;
			try{
				Map appPFListMap = (Map) application.getAttribute("powerFuncList");
				System.out.println("old---appPFListMap----- gaopeng appPFListMap[" + appPFListMap);
				/* ���¼���һ�� */
				String Readpaths = req.getRealPath("npage/properties")
						+ "/exceedPower.properties";
				Map powerFuncList = readValues(Readpaths);
				application.setAttribute("powerFuncList", powerFuncList);
				appPFListMap = (Map) application.getAttribute("powerFuncList");
				System.out.println("new---appPFListMap----- gaopeng appPFListMap[" + appPFListMap);
				if(appPFListMap != null){
					is = true;
				}else{
					is = false;
				}
				
			}catch(Exception e){
				is = false;
			}
			return is;
		
	}
	
	public static Map readValues(String filePath) {
		/* ����URL��ȡproperties�ļ�������������Ϣ */
		System.out.println("����URL��ȡproperties�ļ�������������Ϣ" + filePath);
		Properties props = new Properties();
		Map resultMap = new HashMap();
		InputStream in = null;
		try {
			 in = new BufferedInputStream(new FileInputStream(
					filePath));
			props.load(in);
			Enumeration en = props.propertyNames();
			while (en.hasMoreElements()) {
				String key = (String) en.nextElement();
				String Property = props.getProperty(key).trim();
				resultMap.put(key, Property);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally{
			try{
				System.out.println("gaopengSeeLog========׼���ر���---in="+in);
				in.close();
				System.out.println("gaopengSeeLog========�ر����ɹ�=");
			}catch(Exception e){
				e.printStackTrace();
				System.out.println("gaopengSeeLog========�ر���ʧ��=");
			}
		}
		return resultMap;
	}

%>
<%
	/*2015/3/12 14:36:28 gaopeng ��ȡǰ��ҳ�洫��������������*/
	String passWordC = (String)request.getParameter("passWordC");
	
	
	boolean issss = false;
	/*�����ﴦ���߼�У��*/
	/*1.�ж�������ܺ��������ļ��е������Ƿ�ƥ��*/
	
	String encPass = "ENC("+encrypt(passWordC)+")";
	System.out.println("gaopengSeeLog====encPass==="+encPass);
	
	/*��ȡ�����ļ��е���������*/
	String Readpaths = request.getRealPath("npage/properties")
						+ "/exceedPower.properties";
	String encPassPro = readValue("application" , "passWord" ,"applicationPass",Readpaths);	
	System.out.println("gaopengSeeLog====encPassPro="+encPassPro);
		
	if(encPassPro.equals(encPass)){
		issss = ResetApplication(request,session);
	}else{
		issss = false;
	}
	
	
%>
<html>
<head>
	<title>ˢ��application</title>
	<script language="javascript">
		
		function myalert(){
			if("<%=issss%>" == "true"){
				alert("ˢ��Application�ɹ���");
				window.close();
			}else{
				alert("���벻��ȷ��ˢ��ʧ�ܣ���������");
				window.close();
			}
		}
		
	
	</script>
	</head>
<body onload="myalert();">
	<form action="" method="post" name="f1">
	<table align="center">
		<tr align="center">
			<td align="center"></td>	
		</tr>	
	</table>
</form>
</body>


</html>

<%
  /*
   * 功能:刷新权限Application页面
   * 版本: 1.0
   * 日期: 2014/11/13 14:12:32
   * 作者: gaopeng
   * 版权: si-tech
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
	public String readValue(String param1,String param2,String param3,String paths) {//根据key值和路径查询properties文件中rdmessage信息
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
 
 //以下方法为加密方法
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
	//每个byte用两个字符才能表示，所以字符串的长度是数组长度的两倍
	StringBuffer sb = new StringBuffer(iLen * 2);
	for (int i = 0; i < iLen; i++) {
		int intTmp = arrB[i];
		//把负数转换为正数
		while (intTmp < 0) {
			intTmp = intTmp + 256;
		}
		//小于0F的数需要在前面补0
		if (intTmp < 16) {
			sb.append("0");
		}
		sb.append(Integer.toString(intTmp, 16));
	}
	return sb.toString();
}

private Key getKey(byte[] arrBTmp) throws Exception {
	//创建一个空的8位字节数组（默认值为0）
	byte[] arrB = new byte[8];
	//将原始字节数组转换为8位
	for (int i = 0; i < arrBTmp.length && i < arrB.length; i++) {
		arrB[i] = arrBTmp[i];
	}
	//生成密钥
	Key key = new javax.crypto.spec.SecretKeySpec(arrB, "DES");
	return key;
}

%>

<%!
	/*2014/10/16 10:46:16 gaopeng 重新加载properties方法*/
	public static boolean ResetApplication(HttpServletRequest req,HttpSession sen){
			
			ServletContext application = sen.getServletContext();	
			boolean is = false;
			try{
				Map appPFListMap = (Map) application.getAttribute("powerFuncList");
				System.out.println("old---appPFListMap----- gaopeng appPFListMap[" + appPFListMap);
				/* 重新加载一下 */
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
		/* 根据URL获取properties文件中所有配置信息 */
		System.out.println("根据URL获取properties文件中所有配置信息" + filePath);
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
				System.out.println("gaopengSeeLog========准备关闭流---in="+in);
				in.close();
				System.out.println("gaopengSeeLog========关闭流成功=");
			}catch(Exception e){
				e.printStackTrace();
				System.out.println("gaopengSeeLog========关闭流失败=");
			}
		}
		return resultMap;
	}

%>
<%
	/*2015/3/12 14:36:28 gaopeng 获取前面页面传过来的名文密码*/
	String passWordC = (String)request.getParameter("passWordC");
	
	
	boolean issss = false;
	/*在这里处理逻辑校验*/
	/*1.判断密码加密后与配置文件中的密码是否匹配*/
	
	String encPass = "ENC("+encrypt(passWordC)+")";
	System.out.println("gaopengSeeLog====encPass==="+encPass);
	
	/*获取配置文件中的密文密码*/
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
	<title>刷新application</title>
	<script language="javascript">
		
		function myalert(){
			if("<%=issss%>" == "true"){
				alert("刷新Application成功！");
				window.close();
			}else{
				alert("密码不正确或刷新失败！，请重试");
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

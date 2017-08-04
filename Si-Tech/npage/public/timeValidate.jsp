<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.*;" %>
<%!
private String getHostE(String host){
	if (host==null || "".equals(host)){
		return "";
	}
	try{
		Cipher encryptCipher = null;
		String strDefaultKey = "sunzx";
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
<%
     String retType = WtcUtil.repNull(request.getParameter("retType"));
	   String targetUrl = WtcUtil.repNull(request.getParameter("targetUrl"));
	   
	   System.out.println("liubo targetUrl=="+targetUrl);
	   
	   String workNo =(String)session.getAttribute("workNo");
	   String sqlStr ="select to_char(sysdate,'yyyymmddhh24miss') from dual";	   	
	   
	   System.out.println("  liubo   sqlStr==="+sqlStr);						
	   
	   String timestamp="";
%>
			<wtc:pubselect name="sPubSelect" outnum="1" retcode="retCode1" retmsg="retMsg1">
			 <wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" />	
<%
			if( result.length > 0 ){
	       timestamp=result[0][0]+"#"+workNo;   
	       System.out.println("  liubo  timestamp1==="+timestamp);						
			}else{
				 retCode1="99999";
			}
			
		  timestamp=getHostE(timestamp);
	
      System.out.println("liubo   timestamp2==="+timestamp);
      if(targetUrl.indexOf("chncard") != -1){
		      targetUrl=targetUrl.substring(0,targetUrl.indexOf("#"));
		      targetUrl=targetUrl+"&v99="+timestamp+"#";
		      System.out.println("liubo targetUrl3333=="+targetUrl);
		      String encrystr=targetUrl.substring(targetUrl.indexOf("?")+1,targetUrl.length());		  
		      System.out.println("liubo targetUrl4444=="+targetUrl);
				  targetUrl = targetUrl.substring(0,targetUrl.indexOf("?"));
					String encrytemp=getHostE(encrystr);
					targetUrl =targetUrl+"?encrytemp="+encrytemp;
					System.out.println("liubo targetUrl555=="+targetUrl);
			}
  
%>


	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode1%>");
	response.data.add("targetUrl","<%=targetUrl%>");
	response.data.add("timestamp","<%=timestamp%>");
	core.ajax.receivePacket(response);
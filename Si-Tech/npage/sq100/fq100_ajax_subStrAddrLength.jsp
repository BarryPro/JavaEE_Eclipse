<%
  /*
   * 功能: 1100 截取证件地址长度
   * 版本: 1.0
   * 日期: 2015/3/10 
   * 作者: diling
   * 版权: si-tech
  */
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<% 
	String endWith = "";
	String str=(String)request.getParameter("str");
  String idAddr=(String)request.getParameter("idAddr");
  if(idAddr.getBytes("GBK").length>60){
		idAddr =subString(idAddr,60,endWith);
	}
%>
<%!
	public static String subString(String text, int length, String endWith) {
		int textLength = text.length();
		int byteLength = 0;
		StringBuffer returnStr = new StringBuffer();
		for (int i = 0; i < textLength && byteLength < length ; i++) {
			String str_i = text.substring(i, i + 1);
			if (str_i.getBytes().length == 1) {// 英文
				byteLength++;
			} else  {// 中文
				if(byteLength>length-2){
					break;
				}else{
					byteLength += 2;
				}
			}
			returnStr.append(str_i);
		}
		try {
			if (byteLength < text.getBytes("GBK").length) {// getBytes("GBK")每个汉字长2，getBytes("UTF-8")每个汉字长度为3
				returnStr.append(endWith);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return returnStr.toString();
	}
%>
var response = new AJAXPacket();
response.data.add("str","<%=str%>");
response.data.add("idAddr","<%=idAddr%>");
core.ajax.receivePacket(response);
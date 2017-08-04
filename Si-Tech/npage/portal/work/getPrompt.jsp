<%
   /*
   * 功能: 查询待办任务
　 * 版本: v1.0
　 * 日期: 2011-7-27 
　 * 版权: sitech
   * 作者：hejwa
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%!
public static String javaScriptEscape(String input) {
System.out.println("---------------getPrompt.jsp----javaScriptEscape----------------");
		if (input == null) {
			return input;
		}
		StringBuffer filtered = new StringBuffer(input.length());
		char prevChar = '\u0000';
		char c;
		for (int i = 0; i < input.length(); i++) {
			c = input.charAt(i);
			if (c == '"') {
				filtered.append("\\\"");
			} else if (c == '\'') {
				filtered.append("\\'");
			} else if (c == '\\') {
				filtered.append("\\\\");
			} else if (c == '\t') {
				filtered.append("\\t");
			} else if (c == '\n') {
				if (prevChar != '\r') {
					filtered.append("\\n");
				}
			} else if (c == '\r') {
				filtered.append("\\n");
			} else if (c == '\f') {
				filtered.append("\\f");
			} else if (c == '/') {
				filtered.append("\\/");
			} else {
				filtered.append(c);
			}
			prevChar = c;
		}
		return filtered.toString();
	}
%>
<%
System.out.println("---------------getPrompt.jsp--------------------");
 	//禁止IE缓存页面
	 response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	 response.setHeader("Pragma","no-cache"); //HTTP 1.0
	 response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	  String org_code = (String)session.getAttribute("orgCode");
		String regionCode=org_code.substring(0,2);
		String workNo = (String)session.getAttribute("workNo");
		//查询出温馨提醒，尚未提醒的信息
%>	
<wtc:pubselect name="sPubSelect" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
<wtc:sql>select  to_char(t.login_accept),t.title,t.content,to_char(t.selDate,'yyyy-mm-dd hh24:mi:ss'),to_char(t.op_time,'yyyy-mm-dd'),t.login_no from dTaskmsg t where sysdate<t.end_time and login_no='<%=workNo%>' order by t.selDate
</wtc:sql>
</wtc:pubselect>
<wtc:array id ="prompt_result" scope = "end"/>
	
var promptTime = new Array();
var promptTitle = new Array();
var promptContent = new Array();
<%
System.out.println("retCode------>"+retCode+"////retMsg=="+retMsg+"//prompt_result.length="+prompt_result.length);
if(retCode.equals("000000"))
{
	for(int i = 0; i<prompt_result.length; i++){
	//for(int i = 0; i<2; i++){
System.out.println("转换后值-------："+prompt_result[i][3]);
	%>
		promptTime[<%=i%>]= "<%=prompt_result[i][3]%>";
		promptTitle[<%=i%>]= "<%=prompt_result[i][1]%>";
		promptContent[<%=i%>] = "<%=javaScriptEscape(prompt_result[i][2])%>";
	<%
	}
}
%>

var response = new AJAXPacket();

response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("promptTime",promptTime);
response.data.add("promptTitle",promptTitle);
response.data.add("promptContent",promptContent);

core.ajax.receivePacket(response);
	
		
		
		
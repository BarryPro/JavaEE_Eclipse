<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-16
********************/
%>


<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>

<%
		
	String func_code = request.getParameter("func_code");     
	String func_code_v = "v"+func_code;   //huangrong add �����Ż�Ȩ�� 2011-6-24 
	String rpcType = request.getParameter("rpcType");     

  String errCode="-1";
  String errMsg="�˹��ܴ���ϵͳ���Ѵ��ڣ�";
  String regionCode = (String)session.getAttribute("regCode");
  String sqlStr = "select count(function_code) from sfunccode where function_code =:func_code ";
  String [] paraIn = new String[2];
  paraIn[0] = sqlStr;
  paraIn[1]="func_code="+func_code;
  //huangrong add �ж����������Ż�Ȩ���Ƿ�ռ�� 2011-6-24 
  String sqlStr_v = "select count(function_code) from sfunccode where function_code =:vfunc_code";
  String [] paraIn_v = new String[2];
  paraIn_v[0] = sqlStr_v;
  paraIn_v[1]="vfunc_code="+func_code_v;  
//	retList = impl.sPubSelect("1",sqlStr); 	
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="code" retmsg="msg" outnum="1">
		<wtc:param value="<%=paraIn[0]%>"/>
		<wtc:param value="<%=paraIn[1]%>"/>
		</wtc:service>
	  <wtc:array id="result_t2" scope="end"/>

		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="code_v" retmsg="msg_v" outnum="1">
		<wtc:param value="<%=paraIn_v[0]%>"/>
		<wtc:param value="<%=paraIn_v[1]%>"/>
		</wtc:service>
	  <wtc:array id="result_tv" scope="end"/>
<% 	
 	String[][] retArry = result_t2;	
 	String[][] retArry_v=result_tv;
 	System.out.println("retArry.length=="+retArry.length);	
 	System.out.println("retArry[0][0]=="+retArry[0][0]);	
	if(!retArry_v[0][0].equals("0"))
	{
		errCode="-1";
		errMsg="�����Ż�Ȩ�޴��뱻ռ�ã����޸Ĺ��ܴ��룡";	
	}	 	
	if (retArry[0][0].equals("0") && retArry_v[0][0].equals("0")) 
	{
		retArry = null;
	}
	if(retArry==null)
	{
		errCode="0";
		errMsg="��֤ͨ����";
	}
		
%>
var response = new AJAXPacket();

response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("rpcType","<%=rpcType%>");

core.ajax.receivePacket(response);
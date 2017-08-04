<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-18
********************/
%>
             
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%
	//读取用户session信息
	String regionCode = (String)session.getAttribute("regCode");
	
	String sm_code = request.getParameter("sm_code");     
	String mode_flag = request.getParameter("mode_flag");     
	String mode_type = request.getParameter("mode_type");     
	String region_code = request.getParameter("region_code");   
	String rpcType = request.getParameter("rpcType");   
	String 	qryStr="";
	
 
	//qryStr=sm_code.trim()+mode_flag.trim();
	qryStr=sm_code.trim()+mode_flag.trim()+ mode_type.trim().substring(2,3);
	
  String sqlStr="";
	sqlStr ="select max(trim(mode_code)) from sbillmodecode where region_code='"+region_code+"' and mode_code like '"+qryStr+"%' ";
	//retList = impl.sPubSelect("1",sqlStr,"region",regionCode);
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%	
String[][] maxProCode = new String[][]{};
	if(result_t.length>0&&code.equals("000000"))
	 maxProCode = result_t;
	String maxR =maxProCode[0][0];
	int errCode=0;
	String errMsg="success";
	if (maxProCode != null)
	{
		if (maxProCode[0][0].equals("")) 
		{
			maxProCode =null;
			errCode =-1;
			errMsg="生成产品代码错误！";
		}
	}
	
	if (errCode == -1)
	{
 
		maxR = qryStr + "0000";	

				errCode=0;
				errMsg="success";
	}
%>

var response = new AJAXPacket();
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("rpcType","<%=rpcType%>");
response.data.add("proCode","<%=maxR%>");
core.ajax.receivePacket(response);
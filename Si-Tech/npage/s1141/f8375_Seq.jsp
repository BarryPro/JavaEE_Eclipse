<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%

	String regionCode = (String)session.getAttribute("regCode");	//地市 
	String project_type="",retMsg="";
  
	String inputParsm1 [] = new String[1];	
	String StrSql="select lpad(to_char(nvl(sMaxTypeCode.nextVal,0)+1),4,'0') from dual";
	inputParsm1[0]=StrSql;
%>
	<wtc:service name="sPubSelect" routerKey="regioncode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inputParsm1[0]%>"/>	
	</wtc:service>	
	<wtc:array id="retResult"  scope="end"/>
<%	
	String errCode = retCode1;
	String errMsg = retMsg1;
	
	if(retResult == null)
  	{
	   retMsg = "调用服务sPubSelect 查询序列失败" + errCode + "<br>errMsg+" + errMsg;  
  	}else
  	{
		if(errCode.equals("000000")&&retResult.length>0 )
		{
			project_type=retResult[0][0];
		 	System.out.println("project_type="+project_type);
		 	System.out.println("调用服务sPubSelect 查询序列成功...............");
		 }
	}
%>
var project_type = "<%=project_type%>";

var response = new AJAXPacket(); 
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>"); 
response.data.add("project_type",project_type); 	

core.ajax.receivePacket(response);






  

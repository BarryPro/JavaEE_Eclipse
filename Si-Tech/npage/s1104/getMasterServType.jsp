<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
System.out.println("----------------------------getMasterServType.jsp-------------------------------------");  
System.out.println("--------查询主体服务类型--------");
	String majorProductId = WtcUtil.repNull(request.getParameter("majorProductId"));
	System.out.println("~~~~~~~~~~~~~~~~~~~~~~~111   "+ majorProductId);
	String errCode = "";	
	String errMsg = "";
	int valid = 1;
	int recordNum = 0; //查询结果记录数量
	String masterServId = "";
%>

<wtc:utype name="sGetMastServer" id="retVal" scope="end">
	<wtc:uparam value="<%=majorProductId%>" type="LONG"/> 
</wtc:utype>

<%
	errCode = String.valueOf(retVal.getValue(0));
	
	if(!errCode.equals("0")){
		valid = 1;
		errMsg = retVal.getValue(1);
	}
	else{
		recordNum = retVal.getUtype("2").getSize();
		if(recordNum == 0)
		{
			valid = 2;
      errMsg = "没有查询到相关信息";
		}
		else
		{
			valid = 0;
		}
	}	
%>
var mastServerType = "";
var masterServId = "";
<% 
if( valid == 0 ){ 
	if(retVal.getUtype("2").getSize() > 2){
	System.out.println("mastServerType========================"+retVal.getValue("2.2"));
	System.out.println("masterServId========================"+retVal.getValue("2.0"));
		masterServId = retVal.getValue("2.0");
%>
		mastServerType = "<%=retVal.getValue("2.2")%>";	 
		masterServId = "<%=retVal.getValue("2.0")%>";	 
//		if(masterServId==null||masterServId.equals(""))
//			masterServId ="0";
<%
	}
}	
//	String sqlStr = "select nvl(SERVICE_TYPE,'01') from sServiceType where MASTER_SERV_ID = "+masterServId;
	String sqlStr = "select nvl(SERVICE_TYPE,'01') from sServiceType" ;
	String serviceType = "";
%>
<wtc:pubselect name="sPubSelect" outnum="1">
  <wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="rows" scope="end"/>
<%
	if(retCode.equals("000000") && rows.length >0){
		serviceType = rows[0][0];
	}
	serviceType = "01";
System.out.println("serviceType========================"+serviceType);	

System.out.println("----------------errMsg-----------------"+errMsg);
%>


var response = new AJAXPacket();

response.data.add("errorCode","<%= errCode %>");
response.data.add("errorMsg","<%= errMsg %>");
response.data.add("mastServerType",mastServerType);
response.data.add("masterServId",masterServId);
response.data.add("serviceType","<%=serviceType%>");
core.ajax.receivePacket(response);

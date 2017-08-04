   <%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String orgCode = (String)session.getAttribute("orgCode");
	  String regionCode = orgCode.substring(0,2);
    String cctId = request.getParameter("cctId");
    System.out.println("cctid2222=========="+cctId);
    String cctname="";
    String cctNameSql="select cct_name from DBCHNADN.DCHNCCTGROUPMSG where cct_id='"+cctId+"'";
    String retcode="000000";
    String retmsg="";
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=cctNameSql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>

<%
if (result!=null && result.length > 0 ){
	System.out.println("result is " +result[0][0] );
     cctname=result[0][0];
}else{
    retcode=retCode2;
    retmsg="查询用户电信局错误！";
    cctname="";
}
System.out.println("retcode=========="+retcode);
System.out.println("retmsg=========="+retmsg);
System.out.println("cctname=========="+cctname);
%>


var response = new AJAXPacket();
var returnCode= "<%=retcode%>";
var returnMsg="<%=retmsg%>";
var cctName = "<%=cctname%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
response.data.add("cctName",cctName);
core.ajax.receivePacket(response);

 
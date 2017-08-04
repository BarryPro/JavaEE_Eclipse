<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
Update :  huangrong 20101014
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
 	String org_Code = (String)session.getAttribute("orgCode");
 	String group_id = (String)session.getAttribute("groupId");
 	String regionCode = (String)session.getAttribute("regCode");
   	
	String projectType = WtcUtil.repStr(request.getParameter("projectType")," ");
	String code = WtcUtil.repStr(request.getParameter("code")," ");


	String regionCode1 = org_Code.substring(0,2);
	String active_note="";

	System.out.println("projectType====="+projectType);
	System.out.println("code===="+code);

	String sqlStr = "";
	sqlStr="select nvl(ACTIVE_NOTE,' ') from sactivecode where region_code='"+regionCode+"' and project_code='"+code+"' and is_valid='Y' and project_type='"+projectType+"' and to_char(sysdate,'YYYYMMDD') >=begin_time and to_char(sysdate,'YYYYMMDD') <=end_time ";	   
	System.out.println("****************************************************************8="+sqlStr);
	System.out.println("sqlStr="+sqlStr);
%>         
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode1%>"  retcode="retResult" retmsg="retMsg" outnum="1">
<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
           
<%         
	if(retResult.equals("0") || retResult.equals("000000"))
	{
		if(result.length>0)
		{
			active_note = result[0][0];
			System.out.println("active_note======="+active_note);
		}
	
 	}	
%>
var response = new AJAXPacket();
var active_note = "<%=active_note%>";
response.data.add("active_note","<%=active_note%>");
core.ajax.receivePacket(response);
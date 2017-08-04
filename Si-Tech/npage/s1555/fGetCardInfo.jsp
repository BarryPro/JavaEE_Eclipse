<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%	
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
%>

<%!
Logger logger = Logger.getLogger("fGetCardInfo.jsp");
%>

<%
//String org_code = (String) session.getAttribute("orgCode");
//String regionCode = org_code.substring(0, 2);
String regionCode="01";
String res_code = request.getParameter("res_code");
String oldNewFlag = request.getParameter("oldNewFlag") == null? "":request.getParameter("oldNewFlag");
String isPackage = request.getParameter("isPackage") == null? "":request.getParameter("isPackage");
System.out.println("~~fGetCardInfo.jsp~~" + oldNewFlag + "|" + isPackage);
String sql ="";
String parameter = "";
String result = "false";
String card_type = "";
String res_sum = "";

System.out.println("res_code = "+res_code);

if( "1".equals(oldNewFlag) && "1".equals(isPackage)){
	sql = "SELECT res_type,TO_CHAR(a.res_sum) res_sum FROM dbgiftrun.RS_PROGIFT_PACKAGE_DETAIL a,dbgiftrun.RS_PROGIFT_PT_INFO b " +
			"WHERE a.package_code = :res_code AND a.res_code = b.res_code ";
		
}
else if(res_code.startsWith("P"))      //礼品包
{
	sql = "SELECT res_type,TO_CHAR(a.res_sum) res_sum FROM dbgiftrun.RS_PROGIFT_PACKAGE_DETAIL a,dbgiftrun.RS_PROGIFT_PT_INFO b " +
			"WHERE a.package_code = :res_code AND a.res_code = b.res_code ";
	res_code = res_code.substring(1);
}
else if(res_code.startsWith("D"))  //动态包
{
	//待处理
}
else
{
	sql = "SELECT res_type,to_char(-1) res_sum from dbgiftrun.RS_PROGIFT_PT_INFO a WHERE a.res_code = :res_code ";
}

parameter = "res_code="+res_code;
System.out.println("~~fGetCardInfo.jsp~~sql:" + sql + "|res_code:" + res_code);
	if(sql.equals("")) {
%>
	  <wtc:service name="s2266GetResQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="29">
		<wtc:param value="<%=isPackage%>"/>
		<wtc:param value="<%=res_code%>"/>
	</wtc:service>
	<wtc:array id="tempArr"  scope="end"/>	
<%
			if(retCode2.equals("000000")) {
				if(tempArr.length>0) {
								card_type = tempArr[0][0];
								res_sum = tempArr[0][2];
								result = "true";
				}else {
								result = "false";
					}
			}else {
						result = "false";
				}
	
}else{
%>		
<wtc:service name="TlsPubSelCrm" routerKey="regionCode" routerValue="<%=regionCode%>" outnum="2">
<wtc:param value="<%=sql%>"/>
<wtc:param value="<%=parameter%>"/>
</wtc:service>
<wtc:array id="resultArr" scope="end"/>
	
<%
if(resultArr != null && resultArr.length != 0)
{
	System.out.println(resultArr[0][0]+"----"+resultArr[0][1]);
	card_type = resultArr[0][0];
	res_sum = resultArr[0][1];
	result = "true";
}
else
{
	result = "false";
}
}
%>
	

var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("result","<%=result%>");
response.data.add("card_type","<%=card_type%>");
response.data.add("card_num","<%=res_sum%>");
core.ajax.receivePacket(response);

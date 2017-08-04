<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String orgCode = (String) session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0, 2);
  
  String itemid =  request.getParameter("codes");//礼品编码
	String retType = request.getParameter("retType");
	String hs = request.getParameter("hs");
	String isPaperFlag="0";
	String isPaperStr="select count(*) from SITEMCORRECFG where itemid='"+itemid+"' and flag='0'";//flag='0',代表所选择的礼品为手机报业务 
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="retMsg" retcode="retCode" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=isPaperStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
<%
 System.out.println("retCode======================"+retCode);
  System.out.println("retMsg======================"+retMsg);
	if(retCode.equals("000000"))
  {
		if(result.length>0)
		{
		isPaperFlag=result[0][0];	
		System.out.println("_____________________________________________---"+isPaperFlag);
		}
  }
String cd=result.length+"";
%>	
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("hs","<%=hs%>");
response.data.add("isPaperFlag","<%=isPaperFlag%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMessage","<%=retMsg%>");
core.ajax.receivePacket(response);



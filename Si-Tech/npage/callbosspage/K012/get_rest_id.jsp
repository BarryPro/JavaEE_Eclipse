<%
  /*
   * 功能: 获得请假流水
　 * 版本: 1.0.0
　 * 日期: 2008/10/21
　 * 作者: mixh
　 * 版权: sitech
   *update:
　 */
%>
<%
	//String opCode = "K012";
	//String opName = "获得请假流水";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

   System.out.println("############################################");
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String sqlStr = "select seq_rest.nextval keyno from dual ";
    System.out.println(sqlStr);
   System.out.println("############################################");
   
%>
<wtc:pubselect name="sPubSelect" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="resultList" scope="end" />
<%
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
System.out.println(resultList[0][0]);
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
%>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("restId","<%=resultList[0][0]%>");
core.ajax.receivePacket(response);

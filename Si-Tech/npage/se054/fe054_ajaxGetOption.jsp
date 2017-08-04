<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*
*create:wanglma@2011-05-18 
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>

<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
  String group_name = request.getParameter("group_name");
  String hotarea = request.getParameter("hotarea");
  String hotname = request.getParameter("hotname");
  String hot_addr = request.getParameter("hot_addr");
  
  String opSelect = request.getParameter("opSelect");
  String sql = "";
  System.out.println("====wanghfa====fe054_ajaxGetOption.jsp==== group_name = " + group_name);
  System.out.println("====wanghfa====fe054_ajaxGetOption.jsp==== hotarea = " + hotarea);
  System.out.println("====wanghfa====fe054_ajaxGetOption.jsp==== hotname = " + hotname);
  System.out.println("====wanghfa====fe054_ajaxGetOption.jsp==== hot_addr = " + hot_addr);
	if ("region".equals(opSelect)) {
	  sql = "select distinct hotarea from dWlanCoverAreaMsg where group_name = '" + group_name + "'";
	} else if ("hotArea".equals(opSelect)) {
	  sql = "select distinct hotname from dWlanCoverAreaMsg where group_name = '" + group_name + "' and hotarea = '" + hotarea + "'";
	} else if ("hotName".equals(opSelect)) {
	  sql = "select distinct hot_addr from dWlanCoverAreaMsg where group_name = '" + group_name + "' and hotarea = '" + hotarea + "' and hotname = '" + hotname + "'";
	} else if ("hotAddr".equals(opSelect)) {
	  sql = "select distinct hot_area1 from dWlanCoverAreaMsg where group_name = '" + group_name + "' and hotarea = '" + hotarea + "' and hotname = '" + hotname + "' and hot_addr = '" + hot_addr + "'";
	}
  System.out.println("====wanghfa====fe054_ajaxGetOption.jsp==== sql = " + sql);
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1" >
		<wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result" scope="end"/>
	<%
	if(retCode.equals("000000")) {
  %>
  	var resultArray = new Array();
  <%
  	for (int i = 0; i < result.length; i ++) {
		  System.out.println("====wanghfa====fe054_ajaxGetOption.jsp==== result["+i+"][0] = " + result[i][0]);
  		%>
  			resultArray[<%=i%>] = "<%=result[i][0]%>";
  		<%
  	}
	}
%>

var response = new AJAXPacket();
response.data.add("resultArray", resultArray);
response.data.add("opSelect", "<%=opSelect%>");
core.ajax.receivePacket(response);

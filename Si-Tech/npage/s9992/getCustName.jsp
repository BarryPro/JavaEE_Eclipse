<%

/********************

 version v2.0

开发商: si-tech

*

*create:wanghfa@2010-8-17

*

********************/

%>

<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page contentType="text/html; charset=GBK" %>



<%

	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
	System.out.println("============9994============= phoneNo = " + phoneNo);
	//lj. 绑定参数
	String srv_params = "phoneNo=" + phoneNo;
    String sql_cust = "select cust_name from dcustdoc where cust_id = (select cust_id from dcustmsg where phone_no = :phoneNo)";

	String password = (String)session.getAttribute("password");	
	String work_no = (String)session.getAttribute("workNo");
	String custName = "";
	String ssss = "根据phoneno[" + phoneNo + "]进行查询";
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>
  
  <wtc:service name="sUserCustInfo" outnum="40" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="9994"/>
      <wtc:param value="<%=work_no%>"/>
      <wtc:param value="<%=password%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=ssss%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
    
	<wtc:array id="result_cust">
  <%
      custName = result_cust[0][5];
      System.out.println("====zhouby==9992== = " + result_cust.length);
	System.out.println("====zhouby==9992== = " + result_cust[0][5]);
  %>
  </wtc:array>


var response = new AJAXPacket();

var custName = "<%=custName%>";

response.data.add("custName",custName);



core.ajax.receivePacket(response);




<%
   /*
   * 功能: 修改
　 * 版本: v1.0
　 * 日期: 2013/10/17
　 * 作者: wangjxc
　 * 版权: sitech
  */
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

 <%
  	String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	String orgCode  = (String)session.getAttribute("orgCode");
	String groupId  = (String)session.getAttribute("groupId");
	String orgId    = (String)session.getAttribute("orgId");
	
	String taxpayerId = request.getParameter("taxpayerId");
	String taxpayerType = request.getParameter("taxpayerType");
	String billType = request.getParameter("billType");
	String unitName = request.getParameter("unitName");
	String address = request.getParameter("address");
	String phoneNo = request.getParameter("phoneNo");
	String bankName = request.getParameter("bankName");
	String bankAccount = request.getParameter("bankAccount");
	String valid_date = request.getParameter("valid_date");
	String expire_date = request.getParameter("expire_date");
	String remark = request.getParameter("remark");
	String bankNameList = request.getParameter("bankNameList");
	String bankNumList = request.getParameter("bankNumList");
	String bankNameMsg = request.getParameter("bankNameMsg");
	String bankNumMsg = request.getParameter("bankNumMsg");
	String UpCustId = request.getParameter("UpCustId");
	String list_name = request.getParameter("list_name");
	if(!"undefined".equals(list_name)&&!"".equals(list_name))
    {
    	list_name = list_name+"|";
    }
	else
	{
		list_name = "";
	}	
	
	String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
%>

<wtc:service name="so001TaxUpt" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	      <wtc:param value="<%=loginAccept%>"/>
	      <wtc:param value="01"/>
	      <wtc:param value="o003"/>
	      <wtc:param value="<%=workNo%>"/>
	      <wtc:param value="<%=password%>"/>
	      <wtc:param value=""/>
	      <wtc:param value=""/>
	      <wtc:param value="<%=taxpayerId%>"/>
	      <wtc:param value="<%=taxpayerType%>"/>
	      <wtc:param value="<%=billType%>"/>
	      <wtc:param value="<%=unitName%>"/>
	      <wtc:param value="<%=address%>"/>
	      <wtc:param value="<%=phoneNo%>"/>
	      <wtc:param value="<%=bankName%>"/>
	      <wtc:param value="<%=bankAccount%>"/>
	      <wtc:param value="<%=valid_date%>"/>
	      <wtc:param value="<%=expire_date%>"/>
	      <wtc:param value="<%=remark%>"/>
	      <wtc:param value="<%=UpCustId%>"/>
	      <wtc:param value="<%=list_name%>"/>
	      <wtc:param value="<%=bankNameList%>"/>
	      <wtc:param value="<%=bankNumList%>"/>
	      <wtc:param value="<%=bankNameMsg%>"/>
	      <wtc:param value="<%=bankNumMsg%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
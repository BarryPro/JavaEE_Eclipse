<%
   /*
   * 功能: 纳税人资质信息处理页面
　 * 版本: v1.0
　 * 日期: 2013-08-30
　 * 作者: wangjxc
　 * 版权: sitech
   * 修改历史
   * 修改日期:2013/10/15      	修改人:wangjxc      修改目的:纳税人识别号改为手动填写,增加审批人信息
 　*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	String orgCode  = (String)session.getAttribute("orgCode");
	String groupId  = (String)session.getAttribute("groupId");
	String orgId    = (String)session.getAttribute("orgId");

	String custId = request.getParameter("custId")==null ? "" : request.getParameter("custId").toString();
	String taxpayerId = request.getParameter("taxpayerId")==null ? "" : request.getParameter("taxpayerId").toString();
	String approveLogin = request.getParameter("approveLogin")==null ? "" : request.getParameter("approveLogin").toString();
	String approveLoginOne = request.getParameter("approveLoginOne")==null ? "" : request.getParameter("approveLoginOne").toString();
	String taxpayerType = request.getParameter("taxpayerType")==null ? "" : request.getParameter("taxpayerType").toString();
	String billType  = request.getParameter("billType")==null ? "" : request.getParameter("billType").toString();
	String taxpayerFlag    = request.getParameter("taxpayerFlag")==null ? "" : request.getParameter("taxpayerFlag").toString();
	String unitName    = request.getParameter("unitName")==null ? "" : request.getParameter("unitName").toString();
	String address= request.getParameter("address")==null ? "" : request.getParameter("address").toString();
	String phoneNo = request.getParameter("phoneNo")==null ? "" : request.getParameter("phoneNo").toString();
	String typeCode = request.getParameter("typeCode")==null ? "" : request.getParameter("typeCode").toString();
	String bankName   = request.getParameter("bankName")==null ? "" : request.getParameter("bankName").toString();
	String bankAccount   = request.getParameter("bankAccount")==null ? "" : request.getParameter("bankAccount").toString();
	String valid_date   = request.getParameter("valid_date")==null ? "" : request.getParameter("valid_date").toString();
	String expire_date   = request.getParameter("expire_date")==null ? "" : request.getParameter("expire_date").toString();
	String remark = request.getParameter("remark")==null ? "" : request.getParameter("remark").toString();
	String bankNameList = request.getParameter("bankNameList")==null ? "" : request.getParameter("bankNameList").toString();
	String bankNumList = request.getParameter("bankNumList")==null ? "" : request.getParameter("bankNumList").toString();
	
	String bankNameMsg = request.getParameter("bankNameMsg")==null ? "" : request.getParameter("bankNameMsg").toString();
	String bankNumMsg = request.getParameter("bankNumMsg")==null ? "" : request.getParameter("bankNumMsg").toString();
	
	//认证材料附件
	String list_name =  request.getParameter("list_name")==null ? "" : request.getParameter("list_name").toString();
    if(!"undefined".equals(list_name)&&!"".equals(list_name))
    {
    	list_name = list_name+"|";
    }
	else
	{
		list_name = "";
	}	
         

%>
<wtc:service name="so001Add" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	      <wtc:param value=""/>
	      <wtc:param value="01"/>
	      <wtc:param value="o001"/>
	      <wtc:param value="<%=workNo%>"/>
	      <wtc:param value="<%=password%>"/>
	      <wtc:param value=""/>
	      <wtc:param value=""/>
	      <wtc:param value="<%=custId%>"/>
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
          <wtc:param value="<%=taxpayerFlag%>"/> 
          <wtc:param value="<%=typeCode%>"/>  
          <wtc:param value="<%=remark%>"/>  
          <wtc:param value="<%=approveLogin%>"/>   
          <wtc:param value="<%=approveLoginOne%>"/>
		  <wtc:param value="<%=list_name%>"/>
		  <wtc:param value="<%=bankNameList%>"/> 
		  <wtc:param value="<%=bankNumList%>"/> 
		  <wtc:param value="<%=bankNameMsg%>"/> 
		  <wtc:param value="<%=bankNumMsg%>"/>  
</wtc:service>	

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode %>");
response.data.add("retMsg","<%=retMsg %>");
core.ajax.receivePacket(response);
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page import="com.sitech.crmpd.kf.dto.dcallcall.Dcallcallyyyymm"%> 
<%@page import="com.sitech.crmpd.kf.cache.DCallCacheManager"%> 
<%@ page import="java.net.InetAddress"%>
<%
	
	String curIpTmp = InetAddress.getLocalHost().getHostAddress();
	//String curIp = curIpTmp.substring(curIpTmp.length()-2,curIpTmp.length());
	//curIp="10.110.0.124";
	/*midify by yinzx 20091113 公共查询服务替换*/
	String myParams="";
	String org_code = (String)session.getAttribute("orgCode");
 	String regionCode = org_code.substring(0,2);
	String contactId = WtcUtil.repNull(request.getParameter("contactId"));
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String nowYYYYMM =contactId.substring(0, 6);
	String table_name="dcallcall"+nowYYYYMM;
	String cust_name = "";
	String iLoginNo =(String)session.getAttribute("workNo"); //操作工号
	//System.out.println("sunbya    iLoginNo "+iLoginNo);
	String iLoginPwd =(String)session.getAttribute("password"); //工号密码

%>
	<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6">
		<wtc:param value="" />
		<wtc:param value="01" />
		<wtc:param value="1500" />
		<wtc:param value="<%=iLoginNo%>" /> 
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=phoneNo%>" />	
		<wtc:param value="" />
		<wtc:param value="<%=curIpTmp%>" />
		<wtc:param value="客服查询cust_name" />
		<wtc:param value="" />
		<wtc:param value="" />
		<wtc:param value="" />
		<wtc:param value="" />
</wtc:service>
<wtc:array id="queryLista" scope="end" />
	
<%
//System.out.println("sunbya    queryLista --->>   "+queryLista.length+"  curIp   "+curIpTmp);
  if(queryLista.length>0){
	  for(int i=0 ; i< queryLista.length ;i++){
		  for(int j=0 ; j<queryLista[i].length;j++){
	      //System.out.println("sunbya   result["+i +"]["+j+ "] : "  + queryLista[i][j]);
	      cust_name=queryLista[i][5];
	      //System.out.println("sunbya     --->>   "+cust_name);
		  }
		}
  }
%>


<%
Dcallcallyyyymm upatePhonePage=DCallCacheManager.getInstance().getValue(contactId);
upatePhonePage.setAccept_phone(phoneNo);
upatePhonePage.setCust_name(cust_name);
%>


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);


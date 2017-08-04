<%
    /*************************************
    * 功  能: 成员服务号码是按号码输入，还是文件录入 7896
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-2-21
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String v_smCode = WtcUtil.repStr(request.getParameter("v_smCode"), "");
	String regCode = (String)session.getAttribute("regCode");
	String isMemberFileShow = "";
	String  inParams [] = new String[2];
  inParams[0] = "select field_code3 from dbvipadm.scommoncode where common_code='1007' and field_code1=:iSmCode";
  inParams[1] = "iSmCode="+v_smCode;

%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="3"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
 System.out.println("---7896--f7896_ajax_chkMemberShow.jsp--retCode="+retCode);
 if("000000".equals(retCode)){
  if(ret.length>0){
    isMemberFileShow = ret[0][0];
  }
 }
  System.out.println("---7896--f7896_ajax_chkMemberShow.jsp--isMemberFileShow="+isMemberFileShow);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
response.data.add("isMemberFileShow","<%=isMemberFileShow%>");
core.ajax.receivePacket(response);
 
	    
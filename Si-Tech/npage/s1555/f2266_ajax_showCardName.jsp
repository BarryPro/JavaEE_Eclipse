<%
  /*
   * 功能: 获取展示的卡号的名字
   * 版本: 1.0
   * 日期: 20130610
   * 作者: diling
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String rescode = WtcUtil.repStr(request.getParameter("rescode"), "");//奖品名称
	String regCode = (String)session.getAttribute("regCode");
	String showName = "";
  String  inParams [] = new String[2];
  inParams[0] = "SELECT CASE "
               +" WHEN a.res_type LIKE 'w%' THEN "
               +" 'WLAN充值卡卡号' when a.res_type like 'd%' then '手机充值卡卡号' when a.res_type like 'l%' then '流量卡充值卡卡号'  "
               +" ELSE "
               +" '卡折卡号' "
               +" END "
               +" FROM dbgiftrun.RS_PROGIFT_PT_INFO a "
               +" WHERE a.res_Code =:rescode  ";

  inParams[1] = "rescode="+rescode;
  //inParams[1] = "rescode=10001450";
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
  if("000000".equals(retCode1)){
    if(ret.length>0){
      showName = ret[0][0];
    }
  }
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode1%>");
response.data.add("retMsg","<%=retMsg1%>");
response.data.add("showName","<%=showName%>");
core.ajax.receivePacket(response);
 
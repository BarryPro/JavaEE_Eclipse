<%
    /*************************************
    * 功  能: 验证用户139邮箱
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: wanghyd @ 2012-8-1
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    String loginNo= (String)session.getAttribute("workNo");
    
	String emailphone= WtcUtil.repStr(request.getParameter("emailphone"), "");
	String[] inParamsss1 = new String[2];
	inParamsss1[0] = "select to_char(id_no) from dcustmsg where phone_no=:phonesNO";
	inParamsss1[1] = "phonesNO="+emailphone;
	String erroscode="010000";
	String ids_nos="";
	String tablesd="ddsmpordermsg";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust" scope="end" />
<%
if(dcust.length>0) {
	ids_nos=dcust[0][0];
	erroscode="000000";
}else {
	erroscode="010000";
}
%>
var response = new AJAXPacket();
response.data.add("errCode","<%=erroscode%>");
response.data.add("errMsg","<%=retMsg1ss%>");
core.ajax.receivePacket(response);
 
	    
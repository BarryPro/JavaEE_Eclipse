<%
    /*************************************
    * 功  能: 获取免填单备注信息 d076
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2014/12/2 
    **************************************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
  String loginNo= (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
	String _getUnitId = WtcUtil.repStr(request.getParameter("_getUnitId"), "");
	String _getUnitName = WtcUtil.repStr(request.getParameter("_getUnitName"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String type_flag = WtcUtil.repStr(request.getParameter("type_flag"), "");
	
	String  inParams [] = new String[2];
	inParams[0] = "select offer_name,offer_comments from product_offer where offer_id =:offer_id";
	inParams[1] = "offer_id="+type_flag;
	
	String note1 = "";
	String note2 = "";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2"> 
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service>  
	<wtc:array id="ret"  scope="end"/>
<%
	if("000000".equals(retCode)){
		if(ret.length > 0){
			note1 = ret[0][0];
			note2 = ret[0][1];
		}
	}
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("note1","<%=note1%>");
response.data.add("note2","<%=note2%>");
core.ajax.receivePacket(response);
 
	    
<%
    /*************************************
    * 功  能: 获取最大赠送比例 3691
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
	String v_fieldCode = WtcUtil.repStr(request.getParameter("v_fieldCode"), "");
	String v_limitNum = WtcUtil.repStr(request.getParameter("v_limitNum"), "");
	String currValue = WtcUtil.repStr(request.getParameter("currValue"), "");
	String currObj = WtcUtil.repStr(request.getParameter("currObj"), "");
	
	String  inParams [] = new String[2];
	inParams[0] = "SELECT proportionmax "+
								" FROM SGRPLLOFFERCODE "+
								" WHERE region_code = '00' "+
								" AND limit_lower <= :v_limitNum "+
								" AND limit_upper >= :v_limitNum "+
								" AND field_code =:v_fieldCode";
	inParams[1] = "v_limitNum="+v_limitNum+",v_fieldCode="+v_fieldCode;
	String v_maxScale = "0";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2"> 
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service>  
	<wtc:array id="ret"  scope="end"/>
<%
	if("000000".equals(retCode)){
		if(ret.length > 0){
			v_maxScale = ret[0][0];
		}
	}
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("v_maxScale","<%=v_maxScale%>");
response.data.add("currValue","<%=currValue%>");
response.data.add("currObj","<%=currObj%>");
core.ajax.receivePacket(response);
 
	    
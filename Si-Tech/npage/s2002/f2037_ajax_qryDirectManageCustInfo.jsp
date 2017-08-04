<%
  /*
   * 功能: 直管客户信息查询 2037
   * 版本: 1.0
   * 日期: 2014/10/13 
   * 作者: diling
   * 版权: si-tech
  */
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<% 
	String unitId = WtcUtil.repStr(request.getParameter("unitId"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	
	String regCode = (String)session.getAttribute("regCode");
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String password = WtcUtil.repNull((String)session.getAttribute("password"));
	String v_isDirectManageCust = "0";
	String v_directManageCustNo = "";
	String v_groupNo = "";
	
	String  inParams [] = new String[2];
	inParams[0] = "SELECT a.field_value, to_char(b.field_value),to_char(c.field_value) "+
								 " FROM dbvipadm.dgrpcustmsgadd a, dbvipadm.dgrpcustmsgadd b,dbvipadm.dgrpcustmsgadd c, dgrpcustmsg d "+
								 "	WHERE a.cust_id = d.cust_id "+
								 "  AND b.cust_id = a.cust_id   "+
								 "  AND c.cust_id = a.cust_id   "+
								 "  AND d.unit_id = :vUnit_id   "+
								 "  AND a.field_code = 'ZGKH'   "+
								 "  AND b.field_code = 'ZGID'   "+
								 "  AND c.field_code = 'ZZJG'";
	inParams[1] = "vUnit_id="+unitId;
%>
		
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="3"> 
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service>  
	<wtc:array id="ret"  scope="end"/>
		
	
<%
  if(retCode.equals("000000")) {
  	if(ret.length > 0){
  		for(int i=0;i<ret.length;i++){
  			v_isDirectManageCust = ret[i][0];
  			v_directManageCustNo = ret[i][1];
  			v_groupNo = ret[i][2];
  			
  		}
  	}
  }
%>

var response = new AJAXPacket();

response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("v_isDirectManageCust","<%=v_isDirectManageCust%>");
response.data.add("v_directManageCustNo","<%=v_directManageCustNo%>");
response.data.add("v_groupNo","<%=v_groupNo%>");
core.ajax.receivePacket(response);


<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
		String opCode = WtcUtil.repNull(request.getParameter("opCode"));
		String filFlag = WtcUtil.repNull(request.getParameter("filFlag"));
		String offer_id = WtcUtil.repNull(request.getParameter("dgMoffer"));
		String workNo = (String)session.getAttribute("workNo");
		String strArray="var retAry;";  
		String sqlStr="select a.offer_attr_type, a.name from offer_CateGory a , PRODUCT_OFFER_SCENE_CFG b where  instr(b.role_limit, a.offer_attr_type) > 0  and    b.op_code ='"+opCode+"' and exists (select 1 from product_offer_detail c,product_offer d where   c.ELEMENT_TYPE='10C' and c.ELEMENT_ID = d.offer_id and a.offer_attr_type = d.offer_attr_type and c.offer_id ='"+offer_id+"') union select a.offer_attr_type, a.name from offer_CateGory a,product_offer c where substr(c.user_range,2,1) = '2' and a.offer_attr_type = c.offer_attr_type ";

		
		System.out.println("sqlStr====="+sqlStr);
%>
<wtc:service name="sPubSelect"  retCode="retCode"  retMsg="retMsg" outnum="2" >
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="resPosc" scope="end"/>

<%

	if(retCode.equals("000000")){
	  int retValNum=resPosc.length;
	  System.out.println("@@@@sPubSelect===="+retValNum);	
	  strArray = WtcUtil.createArray("retAry",retValNum);
%>
		<%=strArray%>
<%	  
		for(int i=0;i<retValNum;i++){
			for(int j=0;j<2;j++){
%>
			retAry[<%=i%>][<%=j%>] = "<%=resPosc[i][j]%>";
<%			
			}
		}
	}else{
%>
		<%=strArray%>
<%		
	}
%>

var response = new AJAXPacket();
response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("retAry",retAry);
core.ajax.receivePacket(response);
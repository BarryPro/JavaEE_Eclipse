<%
   /*
   * 功能: 获取品牌代码
　 * 版本: v1.0
　 * 日期: 2007/01/17
　 * 作者: hanfa
　 * 版权: sitech
   * 修改历史
	 *
	 *update:zhanghonga@2008-09-18 页面改造,修改样式
	 *
 　*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String modeCode = request.getParameter("modeCode");
	System.out.println("modeCode = " + modeCode);
	System.out.println("regionCode = " + regionCode);
	
	String sqlStr = "select a.sm_code from band a , product_offer b where a.band_id=b.band_id and b.offer_id="+modeCode;
	System.out.println("##############querySmcode_rpc.jsp->sqlStr->" + sqlStr);	
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%	
System.out.println(retCode+"   :   "+retMsg);
	String errCode=retCode;
	String errMsg=retMsg; 
	String m_smCode = "";
	if(result1 != null && result1.length>0 && errCode.equals("000000"))
	{
		m_smCode = result1[0][0];
		System.out.println("m_smCode = " + m_smCode);
	}
%>
	var response = new AJAXPacket();
	response.data.add("rpc_page","querySmcode");
	response.data.add("m_smCode","<%=m_smCode%>");
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	core.ajax.receivePacket(response);

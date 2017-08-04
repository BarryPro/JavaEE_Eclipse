<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String prodId     =  request.getParameter("prodId");//"10277661";//产品标识
	String phoneNo    =  request.getParameter("phoneNo");
	String idNo       =  request.getParameter("idNo");
	String offerId    =  request.getParameter("offerId");
	String opCode     =  request.getParameter("opCode");
	String brandId    =  request.getParameter("brandId");//品牌
	String workNo     = (String)session.getAttribute("workNo");
  String orgCode    = (String)session.getAttribute("orgCode");
  String CustId     = request.getParameter("CustId");
	String regionCode = orgCode.substring(0,2);	
%>
<wtc:utype name="sGetServCode" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
      <wtc:uparam value="0" type="INT"/>
      <wtc:uparam value="<%=prodId%>" type="LONG"/>
      <wtc:uparam value="<%=idNo%>" type="LONG"/>
      <wtc:uparam value="<%=workNo%>" type="String"/>
</wtc:utype>

<%
	  String retCode = retVal.getValue(0);
	  String retMsg  = retVal.getValue(1);
 
		int size = retVal.getSize("2");
		String opcode = null;
		String opName = null;
		String servBusiId = null;
		for(int i=0;i<size;i++)
		{
			opcode     = retVal.getValue("2."+i+".5");
			opName     = retVal.getValue("2."+i+".1");
			servBusiId = retVal.getValue("2."+i+".0");
			if(opcode.trim().equals(opCode)){
				//主资费变更(客服) 可选资费变更(客服) 直接调用LK函数
					out.print("LK('"+opcode+"','"+opName+"','"+phoneNo+"','"+idNo+"','"+servBusiId+"','"+offerId+"','"+brandId+"');");
			}		
		}
%>
	 
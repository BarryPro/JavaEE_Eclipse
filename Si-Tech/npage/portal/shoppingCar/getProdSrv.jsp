<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String  prodId =  request.getParameter("prodId");//"10277661";//产品标识
	String  phoneNo =  request.getParameter("phoneNo");
	String  idNo =  request.getParameter("idNo");
	String  offerId =  request.getParameter("offerId");
	String  brandId =  request.getParameter("brandId");//品牌
	String  workNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String CustId = request.getParameter("CustId");
	String regionCode = orgCode.substring(0,2);	
%>
<wtc:utype name="sGetServCode" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
      <wtc:uparam value="0" type="INT"/>
      <wtc:uparam value="<%=prodId%>" type="LONG"/>
      <wtc:uparam value="<%=idNo%>" type="LONG"/>
      <wtc:uparam value="<%=workNo%>" type="String"/>
</wtc:utype>

<%
	  String retCode=retVal.getValue(0);
	  String retMsg=retVal.getValue(1);
	  
	  StringBuffer logBuffer = new StringBuffer(80);
		WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
		System.out.println(logBuffer.toString());
	
	  if(retCode.equals("0"))
	  {
%>
$("#rootTree1").html("");
	treeCS = new stdTree("treeCS","rootTree1");
	treeCS.imgSrc="<%=request.getContextPath()%>/nresources/default/images/mztree/"
	with(treeCS)
	{
<%
		int size = retVal.getSize("2");
		%>
		parent.parent.document.getElementById("<%=CustId%>").phone_no = "<%=phoneNo%>";
		parent.parent.iPhoneNo = "<%=phoneNo%>";
		<%
		String opcode = null;
		String opName = null;
		String servBusiId = null;
		for(int i=0;i<size;i++)
		{
			opcode = retVal.getValue("2."+i+".5");
			opName = retVal.getValue("2."+i+".1");
			servBusiId = retVal.getValue("2."+i+".0");
			if(opcode.trim().equals("1104"))
			{
	%>
				N["1104"]="1104;1104-<%=opName%>;000;0;funCheck()";
				<%
			}else if(opcode.trim().equals("4977")){
%>
				N["4977"] = "4977"+";"+"4977"+"-宽带入网;000;0;funCheck4977()";
				
<%
			}else if(opcode.trim().equals("g629")){
%>
				N["g629"] = "g629"+";"+"g629"+"-家庭开户;000;0;funCreFamily()";
<%
			}else{
				%>
				N["<%=opcode%>"]="<%=opcode%>;<%=opcode%>-<%=opName%>;000;0;LK('<%=opcode%>','<%=opName%>','<%=phoneNo%>','<%=idNo%>','<%=servBusiId%>','<%=offerId%>','<%=brandId%>')";
				<%
			}
		}
%>
	}
	treeCS.writeTree();
	treeCS=null;
	
	<%}
	else
		{
		%>
	alert('[<%=retCode%>]<%=retMsg%>');
	<%
		}%>
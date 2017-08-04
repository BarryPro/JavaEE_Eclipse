<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	System.out.println("<<--------------查询复合产品构成信息开始--------------------->>"); 
	System.out.println("-----------------------------getProdCompDet.jsp--------------------------------------");  
	String majorProductId = request.getParameter("majorProductId") == null?"":request.getParameter("majorProductId");
	String selOfferType = request.getParameter("selOfferType") == null?"":request.getParameter("selOfferType");
	String sopcodes = request.getParameter("sopcodes") == null?"":request.getParameter("sopcodes");
	System.out.println("---------majorProductId--->>"+majorProductId); 
	String offerId=WtcUtil.repNull(request.getParameter("offerId"));
	String strArray="var prodCompInfo; ";  //复合产品构成信息
	String errCode = "";
	String errMsg = "";
	int valid = 1;	//0:正确，1：系统错误，2：业务错误
	int recordNum = 0; //查询结果记录数量
	String workNo = (String)session.getAttribute("workNo");
	String groupId =  request.getParameter("groupId");
	String opCode = "q001";
	String goodNo = WtcUtil.repNull(request.getParameter("goodNo"));
	System.out.println("---------------------------------goodNo-------------------------------------"+goodNo);
	System.out.println("------------------------groupId-----------------------------"+groupId);
	System.out.println("------------------------majorProductId----------------------"+majorProductId);
	System.out.println("------------------------offerId-----------------------------"+offerId);
	System.out.println("------------------------selOfferType-----------------------------"+selOfferType);
%>

<wtc:utype name="sProdCompDet" id="retVal" scope="end">
	<wtc:uparam value="<%=majorProductId%>" type="long"/> 
	<wtc:uparam value="<%=offerId%>" type="long"/>   	  
	<wtc:uparam value="<%=workNo%>" type="string"/>   	  
	<wtc:uparam value="<%=opCode%>" type="string"/> 
	<wtc:uparam value="<%=selOfferType%>" type="string"/>
	<wtc:uparam value="<%=sopcodes%>" type="string"/>
</wtc:utype>

<%
	errCode = String.valueOf(retVal.getValue(0));
	
	if(!errCode.equals("0")){
		valid = 1;
		errMsg = retVal.getValue(1);
	}
	else{
		recordNum = retVal.getUtype("2").getSize();
		if(recordNum == 0)
		{
			valid = 2;
      errMsg = "没有查询到相关信息";
		}
		else
		{
			valid = 0;
			strArray = CreatePlanerArray.createArray("prodCompInfo",retVal.getUtype("2").getSize()); 
		}
	}	
%>

<%=strArray%>
<% 
if( valid == 0 ){ 
	for(int i=0;i<retVal.getUtype("2").getSize();i++)
	 {
	 	for(int j=0;j<retVal.getUtype("2."+i).getSize();j++)
	 	{
%>
			prodCompInfo[<%=i%>][<%=j%>] = "<%=retVal.getUtype("2."+i).getValue(j)%>";	 
<%
		}
	}
}	
%>
var response = new AJAXPacket();

response.data.add("errorCode","<%= errCode %>");
response.data.add("errorMsg","<%= errMsg %>");
response.data.add("prodCompInfo",prodCompInfo);
core.ajax.receivePacket(response);
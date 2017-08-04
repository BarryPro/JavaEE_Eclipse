<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
    String opCode = WtcUtil.repNull(request.getParameter("opCode"));
		String servId = WtcUtil.repNull(request.getParameter("servId"));
		String offerId = WtcUtil.repNull(request.getParameter("offerId"));
		String offerType = WtcUtil.repNull(request.getParameter("offerType"));
		String offerName = WtcUtil.repNull(request.getParameter("offerName"));
		String relMainOfferId = WtcUtil.repNull(request.getParameter("relMainOfferId"));
		String loginCollect = WtcUtil.repNull(request.getParameter("loginCollect"));
		String hotOffer = WtcUtil.repNull(request.getParameter("hotOffer"));
		String bandId = WtcUtil.repNull(request.getParameter("bindId"));
		String custType = WtcUtil.repNull(request.getParameter("custType"));
		String workNo = (String)session.getAttribute("workNo");
		String strArray="var retAry;";  
		String regionCode = (String)session.getAttribute("regCode");
		String qryBandAttrSql = "select band_id,offer_attr_type from product_offer where offer_id = '"+offerId+"'";

		
		//System.out.println("------------------qryBandAttrSql----------"+qryBandAttrSql);
		//System.out.println("liub   bandId===["+bandId+"]--offerName---["+offerName+"]---offerType---["+offerType+"]"+"]---opCode---["+opCode+"]");
%>

 		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=qryBandAttrSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
<%
	if(result_t.length>0&&code.equals("000000")){
		bandId = result_t[0][0];
		offerType = result_t[0][1];
	}




%>
<wtc:utype name="sQryChgMOffer" id="retVal" scope="end">
  <wtc:uparam value="<%=servId%>" type="LONG"/>
  <wtc:uparam value="<%=workNo%>" type="STRING"/>	
  <wtc:uparam name="opCode" type="STRING"/>
  <wtc:uparam value="<%=relMainOfferId%>" type="LONG"/>	
  <wtc:uparams name="conditioinList" iMaxOccurs="1">
  	<%
  		if(!offerId.equals("")){
  	%>	
  	<wtc:uparams name="conditions" iMaxOccurs="-1">	
  		<wtc:uparam value="OFFERID" type="STRING"/>
  		<wtc:uparam value="<%=offerId%>" type="STRING"/>
  	</wtc:uparams>
  	<%
  		}
  		if(!offerType.equals("")){
  	%>
  	<wtc:uparams name="conditions" iMaxOccurs="-1">	
  		<wtc:uparam value="OFFERATTRTYPE" type="STRING"/>
  		<wtc:uparam value="<%=offerType%>" type="STRING"/>
  	</wtc:uparams>	
  	<%
  		}
  		if(!offerName.equals("")){
  	%>
  	<wtc:uparams name="conditions" iMaxOccurs="-1">	
  		<wtc:uparam value="OFFERNAME" type="STRING"/>
  		<wtc:uparam value="<%=offerName%>" type="STRING"/>
  	</wtc:uparams>	
  	<%
  		}
  		if(!loginCollect.equals("")){
  	%>
  	<wtc:uparams name="conditions" iMaxOccurs="-1">	
  		<wtc:uparam value="LOGINCOLLECT" type="STRING"/>
  		<wtc:uparam value="<%=loginCollect%>" type="STRING"/>
  	</wtc:uparams>	
  	<%
  		}
  		if(!hotOffer.equals("")){
  	%>
  	<wtc:uparams name="conditions" iMaxOccurs="-1">	
  		<wtc:uparam value="HOTOFFER" type="STRING"/>
  		<wtc:uparam value="<%=hotOffer%>" type="STRING"/>
  	</wtc:uparams>	
  	<%
  		}
  		if(!bandId.equals("")){
  	%>
  	<wtc:uparams name="conditions" iMaxOccurs="-1">	
  		<wtc:uparam value="BANDID" type="STRING"/>
  		<wtc:uparam value="<%=bandId%>" type="STRING"/>
  	</wtc:uparams>	
  	<%
  		}
  		if(!custType.equals("")){
  	%>
  	<wtc:uparams name="conditions" iMaxOccurs="-1">	
  		<wtc:uparam value="CUSTTYPE" type="STRING"/>
  		<wtc:uparam value="<%=custType%>" type="STRING"/>
  	</wtc:uparams>	
  	<%
  		}
  	%>				
  </wtc:uparams>									
</wtc:utype>

<%
	String retCode = retVal.getValue(0);
	String retMsg  = retVal.getValue(1).replaceAll("\\n"," ");
	
	StringBuffer logBuffer = new StringBuffer(80);
	

	
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	System.out.println(logBuffer.toString());
	
	
	if(retCode.equals("0")){
		int retValNum = retVal.getUtype("2").getSize();
	  //System.out.println("@@@@---sSearShortMsgHis---------------retValNum------"+retValNum);	
	  strArray = WtcUtil.createArray("retAry",retValNum);
%>
		<%=strArray%>
<%	  
		for(int i=0;i<retValNum;i++){
			UType uType = retVal.getUtype("2."+i);
			for(int j=0;j<uType.getSize();j++){
%>
			retAry[<%=i%>][<%=j%>] = "<%=uType.getValue(j)%>";
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
core.ajax.receivePacket(response);;
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
		String offerdetRolecd = WtcUtil.repNull(request.getParameter("roleId"));
		String workNo = (String)session.getAttribute("workNo");
		/* liujian add workNo and password 2012-4-5 15:59:15 begin */
		String password = (String) session.getAttribute("password");
		/* liujian add workNo and password 2012-4-5 15:59:15 end */
		String strArray="var retAry;";  
		
		

		
		
		
		String regionCode = (String)session.getAttribute("regCode");
		String qryBandAttrSql = "select band_id,offer_attr_type from product_offer where offer_id = '"+offerId+"'";
		
		System.out.println("---------#---------qryBandAttrSql------#----"+qryBandAttrSql);

	  System.out.println("liubo  relMainOfferId===["+relMainOfferId+"]--workNo---["+workNo+"]---opCode---["+opCode+"]");		
%>
 		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=qryBandAttrSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
<%
	if(result_t.length>0&&code.equals("000000")){
		offerdetRolecd = result_t[0][1];
	}
		System.out.println("------------------opCode------------------"+opCode);
		System.out.println("------------------offerType---------------"+offerType);
		System.out.println("------------------servId------------------"+servId);
		System.out.println("------------------offerId-----------------"+offerId);
		System.out.println("------------------offerName---------------"+offerName);
		System.out.println("------------------relMainOfferId----------"+relMainOfferId);
		System.out.println("------------------loginCollect------------"+loginCollect);
		System.out.println("------------------hotOffer----------------"+hotOffer);
		System.out.println("------------------offerdetRolecd----------"+offerdetRolecd);

		
%>

<wtc:utype name="sQryChgAddOffer" id="retVal" scope="end">
  <wtc:uparam value="<%=servId%>" type="long"/>
  <wtc:uparam value="<%=workNo%>" type="string"/>	
  <wtc:uparam name="opCode" type="string"/>
  <wtc:uparam value="<%=relMainOfferId%>" type="long"/>	
  <wtc:uparams name="conditioinList" iMaxOccurs="1">	
  	<%
  		if(!offerId.equals("")){
  	%>	
  	<wtc:uparams name="conditions" iMaxOccurs="-1">	
  		<wtc:uparam value="OFFERID" type="string"/>
  		<wtc:uparam value="<%=offerId%>" type="string"/>
  	</wtc:uparams>
  	<%
  		}
  		if(!offerType.equals("")){
  	%>
  	<wtc:uparams name="conditions" iMaxOccurs="-1">	
  		<wtc:uparam value="OFFERTYPE" type="string"/>
  		<wtc:uparam value="<%=offerType%>" type="string"/>
  	</wtc:uparams>	
  	<%
  		}
  		if(!offerName.equals("")){
  	%>
  	<wtc:uparams name="conditions" iMaxOccurs="-1">	
  		<wtc:uparam value="OFFERNAME" type="string"/>
  		<wtc:uparam value="<%=offerName%>" type="string"/>
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
  		if(!offerdetRolecd.equals("")){
  	%>
  	<wtc:uparams name="conditions" iMaxOccurs="-1">	
  		<wtc:uparam value="OFFERATTRTYPE" type="STRING"/>
  		<wtc:uparam value="<%=offerdetRolecd%>" type="STRING"/>
  	</wtc:uparams>	
  	<%
  		}
  	%>			
  </wtc:uparams>	
  <wtc:uparam value="<%=password%>" type="string"/>											
</wtc:utype>

<%
	String retCode = retVal.getValue(0);
	String retMsg  = retVal.getValue(1).replaceAll("\\n"," ");
	
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
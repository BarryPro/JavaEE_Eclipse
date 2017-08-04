<%
/********************
 *version v2.0
 *开发商: si-tech
 *update by qidp @ 2008-12-25
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
    String loginAccept      	= request.getParameter("loginAccept");
    String opCode  				= request.getParameter("opCode");
    String workNo 				= request.getParameter("workNo");
    String noPass  				= (String)session.getAttribute("password");
    String orgCode  			= request.getParameter("orgCode");
    String idNo 			 	= request.getParameter("idNo");
    String roamCountryCode 	 	= request.getParameter("roamCountryCode");
    String custType  			= request.getParameter("custType");
    String roamType  			= request.getParameter("roamType");
    String phoneRent  			= request.getParameter("phoneRent");
    String travelFlag  			= request.getParameter("travelFlag");
    String travelName  			= request.getParameter("travelName");
    String opTime  				= request.getParameter("opTime");
    String returnTime  			= request.getParameter("returnTime");
    String openTime  			= request.getParameter("openTime");
    String closeTime 			= request.getParameter("closeTime");
    String machType 			= request.getParameter("machType");
    String machIccid  			= request.getParameter("machIccid");
    String machBodyNum  		= request.getParameter("machBodyNum");
    String machBodyFee  		= request.getParameter("machBodyFee");
    String batteriesNum 		= request.getParameter("batteriesNun");
    String batteriesFee 		= request.getParameter("batteriesFee");
    String chargerNum 			= request.getParameter("chargerNum");
    String chargerFee 		 	= request.getParameter("chargerFee");
    String accountBook 			= request.getParameter("accountBook");
    String otherComponent 		= request.getParameter("otherComponent");
    String additionFee 		 	= request.getParameter("additionFee");
    String rentType  			= request.getParameter("rentType");
    String rentFee 		 		= request.getParameter("rentFee");
    String visaName  			= request.getParameter("visaName");
    String deposit  			= request.getParameter("deposit");
    String chandFee 			= request.getParameter("chandFee");
    String handFee 				= request.getParameter("handFee");
    String phoneFee  			= request.getParameter("phoneFee");
    String systemNote  			= request.getParameter("systemNote");
    String opNote				= request.getParameter("opNote");
    String ipAddr 				= request.getParameter("ipAddr");
    String asCustName 			= request.getParameter("asCustName");
    String asCustPhone 			= request.getParameter("asCustPhone");
    String asIdType 			= request.getParameter("asIdType");
    String asIdIccid 			= request.getParameter("asIdIccid");
    String asIdAddress 			= request.getParameter("asIdAddress");
    String asContractAddress 	= request.getParameter("asContractAddress");
    String asNotes 				= request.getParameter("asNotes");
    /** ningtn 异制租机 **/
    String bookingTime 			= request.getParameter("bookingTime");
    System.out.println("loginAccept           is : " + loginAccept           );
    System.out.println("opCode  			  is : " + opCode  			     );
    System.out.println("workNo 			      is : " + workNo 			     );
    System.out.println("noPass  			  is : " + noPass  			     );
    System.out.println("orgCode  		      is : " + orgCode  		     );
    System.out.println("idNo 			      is : " + idNo 			     );
    System.out.println("roamCountryCode 	  is : " + roamCountryCode 	     );
    System.out.println("custType  		      is : " + custType  		     );
    System.out.println("roamType  		      is : " + roamType  		     );
    System.out.println("phoneRent  		      is : " + phoneRent  		     );
    System.out.println("travelFlag  		  is : " + travelFlag  		     );
    System.out.println("travelName  		  is : " + travelName  		     );
    System.out.println("opTime  			  is : " + opTime  			     );
    System.out.println("returnTime  		  is : " + returnTime  		     );
    System.out.println("openTime  		      is : " + openTime  		     );
    System.out.println("closeTime 		      is : " + closeTime 		     );
    System.out.println("machType 		      is : " + machType 		     );
    System.out.println("machIccid  		      is : " + machIccid  		     );
    System.out.println("machBodyNum  	      is : " + machBodyNum  	     );
    System.out.println("machBodyFee  	      is : " + machBodyFee  	     );
    System.out.println("batteriesNum 	      is : " + batteriesNum 	     );
    System.out.println("batteriesFee 	      is : " + batteriesFee 	     );
    System.out.println("chargerNum 		      is : " + chargerNum 		     );
    System.out.println("chargerFee 		      is : " + chargerFee 		     );
    System.out.println("accountBook 		  is : " + accountBook 		     );
    System.out.println("otherComponent 	      is : " + otherComponent 	     );
    System.out.println("additionFee 	      is : " + additionFee 	     );
    System.out.println("rentType  		      is : " + rentType  		     );
    System.out.println("rentFee 		 	  is : " + rentFee 		 	     );
    System.out.println("visaName  		      is : " + visaName  		     );
    System.out.println("chandFee 			  is : " + chandFee 			     );
    System.out.println("deposit  		      is : " + deposit  		     );
    System.out.println("handFee 			  is : " + handFee 			     );
    System.out.println("phoneFee  		      is : " + phoneFee  		     );
    System.out.println("systemNote  		  is : " + systemNote  		     );
    System.out.println("opNote			      is : " + opNote			     );
    System.out.println("ipAddr 			      is : " + ipAddr 			     );
	System.out.println("bookingTime 	      is : " + bookingTime 			     );











    String phoneNo=request.getParameter("phoneNo");
    System.out.println("phoneNo!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@##########="+phoneNo);
    
    //F1222Wrapper impl = new F1222Wrapper();
    //ArrayList arr = impl.CallF1222Cfm(loginAccept,opCode,workNo,noPass,
    //orgCode,idNo,roamCountryCode,custType,
    //roamType,phoneRent,travelFlag,travelName,
    //opTime,returnTime,openTime,closeTime,
    //machType,machIccid,machBodyNum,
    //machBodyFee,batteriesNum,batteriesFee,
    //chargerNum,chargerFee,accountBook,
    //otherComponent,additionFee,rentType,rentFee,
    //visaName,chandFee,deposit,handFee,phoneFee,
    //systemNote,opNote,ipAddr,asCustName,asCustPhone,asIdType,asIdIccid,
    //asIdAddress,asContractAddress,asNotes);

%>
    <wtc:service name="s1222Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s1222CfmCode" retmsg="s1222CfmMsg" outnum="1" >
        <wtc:param value="<%=loginAccept%>"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=noPass%>"/>
            
        <wtc:param value="<%=orgCode%>"/>
        <wtc:param value="<%=idNo%>"/>
        <wtc:param value="<%=roamCountryCode%>"/>
        <wtc:param value="<%=custType%>"/>
            
        <wtc:param value="<%=roamType%>"/>
        <wtc:param value="<%=phoneRent%>"/>
        <wtc:param value="<%=travelFlag%>"/>
        <wtc:param value="<%=travelName%>"/>
            
        <wtc:param value="<%=opTime%>"/>
        <wtc:param value="<%=returnTime%>"/>
        <wtc:param value="<%=openTime%>"/>
        <wtc:param value="<%=closeTime%>"/>
            
        <wtc:param value="<%=machType%>"/>
        <wtc:param value="<%=machIccid%>"/>
        <wtc:param value="<%=machBodyNum%>"/>
        <wtc:param value="<%=machBodyFee%>"/>
            
        <wtc:param value="<%=batteriesNum%>"/>
        <wtc:param value="<%=batteriesFee%>"/>
        <wtc:param value="<%=chargerNum%>"/>
        <wtc:param value="<%=chargerFee%>"/>
            
        <wtc:param value="<%=accountBook%>"/>
        <wtc:param value="<%=otherComponent%>"/>
        <wtc:param value="<%=additionFee%>"/>
        <wtc:param value="<%=rentType%>"/>
            
        <wtc:param value="<%=rentFee%>"/>
        <wtc:param value="<%=visaName%>"/>
        <wtc:param value="<%=deposit%>"/>
        <wtc:param value="<%=chandFee%>"/>
                
        <wtc:param value="<%=handFee%>"/>
        <wtc:param value="<%=phoneFee%>"/>
        <wtc:param value="<%=systemNote%>"/>
        <wtc:param value="<%=opNote%>"/>
            
        <wtc:param value="<%=ipAddr%>"/>
        <wtc:param value="<%=asCustName%>"/>
        <wtc:param value="<%=asCustPhone%>"/>
        <wtc:param value="<%=asIdType%>"/>
            
        <wtc:param value="<%=asIdIccid%>"/>
        <wtc:param value="<%=asIdAddress%>"/>
        <wtc:param value="<%=asContractAddress%>"/>
        <wtc:param value="<%=asNotes%>"/>
        <wtc:param value="<%=bookingTime%>"/>
    </wtc:service>
    <wtc:array id="backInfo" scope="end" />

<%   
    System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+s1222CfmCode+"&opName="+"异制租机申请"+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+s1222CfmMsg+"&opBeginTime="+opBeginTime+"&contactId="+phoneNo+"&contactType=user";
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
	System.out.println("url"+url);
    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");

    //String[][] backInfo = (String[][])arr.get(0);
    //String[][] errInfo = (String[][])arr.get(1);
    String[][] errInfo = new String[][]{{s1222CfmCode,s1222CfmMsg}};
    if(errInfo[0][1].equals("")){
        errInfo[0][1] = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errInfo[0][0]));
        if( errInfo[0][1].equals("null")){
            errInfo[0][1] ="未知错误信息";
        }
    }
    //System.out.println(backInfo.length);
    //System.out.println(errInfo.length);
    //System.out.println(errInfo[0][0]);
    //System.out.println(errInfo[0][1]);

%>


<%
    String strArray = CreatePlanerArray.createArray("backInfo",backInfo.length);

%>
    <%=strArray%>
<%

    for(int i = 0 ; i < backInfo.length ; i ++){
        for(int j = 0 ; j < backInfo[i].length ; j ++){
        
            System.out.println("backInfo=   "+backInfo[i][j]);
%>

            backInfo[<%=i%>][<%=j%>] = "<%=backInfo[i][j].trim()%>";
<%
        }
    }
%>

var response = new AJAXPacket();



response.data.add("backString",backInfo);
response.data.add("flag","1");
response.data.add("errCode","<%=errInfo[0][0]%>");
response.data.add("errMsg","<%=errInfo[0][1]%>");




core.ajax.receivePacket(response);
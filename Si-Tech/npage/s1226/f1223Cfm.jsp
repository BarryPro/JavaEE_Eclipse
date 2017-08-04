<%

/********************

 *version v2.0

 *开发商: si-tech

 *update by qidp @ 2008-12-26

 ********************/

%>

<%@ page contentType= "text/html;charset=GBK" %>

<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="java.util.ArrayList"%>

<%@ page import="com.sitech.boss.pub.util.*" %>

<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>



<%

    String	errCode = "";

    String  errMsg = "";

    String[][] backInfo = new String[][]{{"0","0"}};

    String loginAccept      	= request.getParameter("loginAccept");

    String opCode  				= request.getParameter("opCode");

    String workNo 				= request.getParameter("workNo");

    String noPass  				= (String)session.getAttribute("password");

    String orgCode  			= request.getParameter("orgCode");

    String idNo 			 	= request.getParameter("idNo");

    String returnTime  			= request.getParameter("returnTime");

    String closeTime 			= request.getParameter("closeTime");

    String chandFee 			= request.getParameter("chandFee");

    String handFee  			= request.getParameter("handFee");

    String systemNote  			= request.getParameter("systemNote");

    String opNote				= request.getParameter("opNote");

    String ipAddr 				= request.getParameter("ipAddr");

    String asCustName 			= request.getParameter("asCustName");

    String asCustPhone 			= request.getParameter("asCustPhone");

    String asIdType 			= request.getParameter("asIdType");

    String asIdIccid 			= request.getParameter("asIdIccid");

    String asIdAddress 			= request.getParameter("asIdAddress");

    String asContractAddress 		= request.getParameter("asContractAddress");

    String asNotes 				= request.getParameter("asNotes");

    String phoneNo              = request.getParameter("phoneNo");



try

{

%>

    <wtc:service name="s1223Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s1223CfmCode" retmsg="s1223CfmMsg" outnum="1" >

        <wtc:param value="<%=loginAccept%>"/>

        <wtc:param value="<%=opCode%>"/>

        <wtc:param value="<%=workNo%>"/>

        <wtc:param value="<%=noPass%>"/>

        <wtc:param value="<%=orgCode%>"/>

        <wtc:param value="<%=idNo%>"/>

        <wtc:param value="<%=returnTime%>"/>

        <wtc:param value="<%=closeTime%>"/>

        <wtc:param value="<%=chandFee%>"/>

        <wtc:param value="<%=handFee%>"/>

        <wtc:param value="<%=systemNote%>"/>

        <wtc:param value="<%=opNote%>"/>

        <wtc:param value="<%=ipAddr%>"/>

    </wtc:service>

    <wtc:array id="s1223CfmArr" scope="end" />

    

<%



    System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");

    String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+s1223CfmCode+"&opName="+"异制租机续租"+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+s1223CfmMsg+"&opBeginTime="+opBeginTime;

    System.out.println("#######################"+url);

%>

    <jsp:include page="<%=url%>" flush="true" />

<%



    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");

    if(errCode.equals("000000"))

    {

     	backInfo = s1223CfmArr;

    }

	//errCode = String.valueOf(callWrapper.getErrCode());

	//errMsg = callWrapper.getErrMsg();

	errCode = s1223CfmCode;

	errMsg = s1223CfmMsg;

	System.out.println("retCode = " + errCode);

	System.out.println("retMessage = " + errMsg);

}catch(Exception e){

    System.out.println("1223 Call s1223Cfm  is Failed!");

}  









String strArray = CreatePlanerArray.createArray("backInfo",backInfo.length);



%>

<%=strArray%>

<%



for(int i = 0 ; i < backInfo.length ; i ++){

      for(int j = 0 ; j < backInfo[i].length ; j ++){

%>



backInfo[<%=i%>][<%=j%>] = "<%=backInfo[i][j].trim()%>";

<%

}

}

%>



var response = new AJAXPacket();



response.guid = '<%= request.getParameter("guid") %>';



response.data.add("backString",backInfo);

response.data.add("flag","1");

response.data.add("errCode","<%=errCode%>");

response.data.add("errMsg","<%=errMsg%>");



core.ajax.receivePacket(response);
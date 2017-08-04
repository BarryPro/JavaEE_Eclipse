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
    String loginAccept      	 = request.getParameter("loginAccept");
    String opCode  				= request.getParameter("opCode");
    String workNo 				 = request.getParameter("workNo");
    String noPass  				= (String)session.getAttribute("password");
    String orgCode  			= request.getParameter("orgCode");
    String newLoginAccept       = request.getParameter("newLoginAccept");
    String systemNote  			= request.getParameter("systemNote");
    String opNote						 = request.getParameter("opNote");
    String ipAddr 				 = request.getParameter("ipAddr");
    String idNo 				 = request.getParameter("idNo");
    String asCustName = request.getParameter("asCustName");
    String asCustPhone = request.getParameter("asCustPhone");
    String asIdType = request.getParameter("asIdType");
    String asIdIccid = request.getParameter("asIdIccid");
    String asIdAddress = request.getParameter("asIdAddress");
    String asContractAddress = request.getParameter("asContractAddress");
    String asNotes = request.getParameter("asNotes");
        //System.out.println("loginAccept           is : " + loginAccept           );
        //System.out.println("opCode  			  is : " + opCode  			     );
        //System.out.println("workNo 			      is : " + workNo 			     );    
        //System.out.println("noPass  			  is : " + noPass  			     );
        //System.out.println("orgCode  		      is : " + orgCode  		     );    
        //System.out.println("newLoginAccept 			      is : " + newLoginAccept 			     );    
        //System.out.println("systemNote  		  is : " + systemNote  		     );
        //System.out.println("opNote			      is : " + opNote			     );    
        //System.out.println("ipAddr 			      is : " + ipAddr 			     );    
        //System.out.println("idNo 			      is : " + idNo 			     );    

    String phoneNo=request.getParameter("phoneNo");
    System.out.println("phoneNo="+phoneNo);
    
    System.out.println("@@@@@@@@@@@@@@@@@@@@CallF1224Cfm");	
        //ArrayList arr = F1224Wrapper.CallF1224Cfm(newLoginAccept,opCode,workNo,noPass,orgCode,loginAccept,systemNote,
        //					  opNote,ipAddr,idNo,asCustName,asCustPhone,asIdType,
        //                                  	  asIdIccid,asIdAddress,asContractAddress,asNotes);
%>
    <wtc:service name="s1224Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s1224CfmCode" retmsg="s1224CfmMsg" outnum="1" >
        <wtc:param value="<%=newLoginAccept%>"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=noPass%>"/>
        <wtc:param value="<%=orgCode%>"/>
        
        <wtc:param value="<%=loginAccept%>"/>
        <wtc:param value="<%=systemNote%>"/>
        <wtc:param value="<%=opNote%>"/>
        <wtc:param value="<%=ipAddr%>"/>
        <wtc:param value="<%=idNo%>"/>
        
        <wtc:param value="<%=asCustName%>"/>
        <wtc:param value="<%=asCustPhone%>"/>
        <wtc:param value="<%=asIdType%>"/>
        <wtc:param value="<%=asIdIccid%>"/>
        <wtc:param value="<%=asIdAddress%>"/>
        
        <wtc:param value="<%=asContractAddress%>"/>
        <wtc:param value="<%=asNotes%>"/>
    </wtc:service>
    <wtc:array id="backInfo" scope="end" />
    
<%   
    System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+s1224CfmCode+"&opName="+"异制租机申请冲正"+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+s1224CfmMsg+"&opBeginTime="+opBeginTime;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%

    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");

        //String[][] backInfo = (String[][])arr.get(0);
        //String[][] errInfo = (String[][])arr.get(1);
    String[][] errInfo = new String[][]{{s1224CfmCode,s1224CfmMsg}};
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
response.data.add("errCode","<%=errInfo[0][0]%>");
response.data.add("errMsg","<%=errInfo[0][1]%>");




core.ajax.receivePacket(response);

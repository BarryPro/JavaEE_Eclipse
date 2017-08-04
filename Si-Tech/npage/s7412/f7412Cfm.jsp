<%request.setCharacterEncoding("GBK");%>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%

String opName="动力100业务包订购";
String url ="";
try {
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String[][] otherInfoSession = (String[][])arrSession.get(2);
    String loginNo = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String powerCode= otherInfoSession[0][4];
    String powerRight= baseInfoSession[0][5];
    String orgCode = baseInfoSession[0][16];
    String ip_Addr = request.getRemoteAddr();
    String[][] pass = (String[][])arr.get(4);
    String nopass  = pass[0][0];

    String login_accept=request.getParameter("login_accept");
    String regionName = otherInfoSession[0][5];
    
    String loginAccept    ="";
	
	System.out.println("login_accept="+login_accept);
	String iOpCode         = "7421" ;     
	String iIpAddr         = request.getRemoteAddr();
	String iCust_Id        = request.getParameter("cust_id");
	String iGrp_Id         = request.getParameter("grp_id");
	String iGrp_No         = request.getParameter("grp_no"); 
	String iGrp_Name       = request.getParameter("grp_name");
	String iUser_Passwd    = request.getParameter("user_passwd");
    String iCredit_Code    = request.getParameter("credit_code");
    String iCredit_Value   = request.getParameter("credit_value");
    String iAccount_Id     = request.getParameter("account_id");
    String iAccount_Passwd = request.getParameter("account_passwd");
    String iProduct_Type   = request.getParameter("product_type");
    String iProduct_Code   = request.getParameter("motive_code");
    String iProvince       = request.getParameter("province");
     
    
    String iSrv_Start      = request.getParameter("srv_start");
    String iSrv_Stop       = request.getParameter("srv_stop");
    String iOp_Note        = request.getParameter("tonote");
    iOp_Note="工号"+loginNo+"进行"+iOp_Note;
    String iPayCode        = request.getParameter("pay_code");         //集团帐户付款方式	
	String vFee_Type 	   ="";
	
	String iTry_Srv       = request.getParameter("tmptrysrv");
	String belong_codenew =request.getParameter("belong_codeNew");
	String group_id=request.getParameter("group_id");
	String regionCode = belong_codenew.substring(0,2);
	String iDistrict_Code  = belong_codenew.substring(2,4);
    String iTown_Code      = belong_codenew.substring(4,7);
    
    String retCodeAttr="";
	
	System.out.println("iCust_Id="+iCust_Id);
	System.out.println("iGrp_Id="+iGrp_Id);
	System.out.println("iGrp_No="+iGrp_No);
	System.out.println("iGrp_Name="+iGrp_Name);
	System.out.println("iUser_Passwd="+iUser_Passwd);
	System.out.println("iAccount_Id="+iAccount_Id);
	System.out.println("iAccount_Passwd="+iAccount_Passwd);
	System.out.println("iProduct_Type="+iProduct_Type);
	System.out.println("iProduct_Code="+iProduct_Code);
	System.out.println("iProvince="+iProvince);
	System.out.println("iProvince="+iProvince);
	System.out.println("regionCode="+regionCode);
	System.out.println("iDistrict_Code="+iDistrict_Code);
	System.out.println("iTown_Code="+iTown_Code);
	System.out.println("iSrv_Start="+iSrv_Start);
	System.out.println("iSrv_Stop="+iSrv_Stop);
	System.out.println("iOp_Note="+iOp_Note);
	System.out.println("iTry_Srv="+iTry_Srv);
	System.out.println("belong_codenew="+belong_codenew);
	System.out.println("group_id="+group_id);
	System.out.println("nopass="+nopass);
	
	
	
	
	iUser_Passwd = Encrypt.encrypt(iUser_Passwd); 
	/*业务包信息*/
	System.out.println("iUser_Passwd="+iUser_Passwd);
	String iCommfee	       = request.getParameter("motive_commfee");
	/*业务包资费优惠信息*/
	String iSrvCode        = request.getParameter("motive_srvcode");
	/*String iPriceCode	   = request.getParameter("motive_price");*/
	/*业务包子产品信息*/
	String iProdStr		   = request.getParameter("motive_prdcode");
	String iProdSrvStr	   = request.getParameter("motive_prdsrv");
	/*String iProdPriceStr   = request.getParameter("motive_prdpric");*/
	String iProdSmCode	   = request.getParameter("motive_prdsmd");
	/*String iprodsvrmode    =request.getParameter("motive_prodsvrmode");*/
	System.out.print("iCommfee is " +iCommfee+"\n");
	System.out.print("iSrvCode is " +iSrvCode+"\n");
	System.out.print("iProdStr is " +iProdStr+"\n");
	System.out.print("iProdSrvStr is " +iProdSrvStr+"\n");
	System.out.print("iProdSmCode is " +iProdSmCode+"\n");
	System.out.print("iCredit_Code is " +iCredit_Code+"\n");
	System.out.print("orgCode is "+orgCode);
%>
<wtc:service name="s7412Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="Code" retmsg="Msg" >
 <wtc:param value="<%=orgCode%>"/>
 <wtc:param value="<%=loginNo%>"/>
 <wtc:param value="<%=iOpCode%>"/>
 <wtc:param value="<%=nopass%>"/>
 <wtc:param value="<%=iIpAddr%>"/>
 <wtc:param value="<%=iCust_Id%>"/>
 <wtc:param value="<%=iGrp_Id%>"/>
 <wtc:param value="<%=iGrp_No%>"/>	
 <wtc:param value="<%=iGrp_Name%>"/> 	
 <wtc:param value="<%=iUser_Passwd%>"/>	 	
 <wtc:param value="<%=iAccount_Id%>"/>	
 <wtc:param value="<%=iUser_Passwd%>"/>	
 <wtc:param value="<%=iProduct_Type%>"/>	
 <wtc:param value="<%=iProduct_Code%>"/>	
 <wtc:param value="<%=regionCode%>"/>
 <wtc:param value="<%=iDistrict_Code%>"/>	
 <wtc:param value="<%=iTown_Code%>"/>
 <wtc:param value="<%=group_id%>"/>
 	 
 <wtc:param value="<%=iSrv_Start%>"/>	
 <wtc:param value="<%=iSrv_Stop%>"/>
 <wtc:param value="<%=iOp_Note%>"/>	

	
 <wtc:param value="<%=iCommfee%>"/> 
 <wtc:param value="<%=iSrvCode%>"/>	
 <wtc:param value="<%=iTry_Srv%>"/>
 <wtc:param value="<%=iProdStr%>"/>
 <wtc:param value="<%=iProdSrvStr%>"/>	
 <wtc:param value="<%=iProdSmCode%>"/> 	
 <wtc:param value="<%=iProvince%>" />
 <wtc:param value="<%=belong_codenew%>" />		
 	 		 	 	
</wtc:service>
<wtc:array id="result" scope="end"/>
 
<script>
<%
System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
String retCodeForCntt = Code ;
	if(Code.equals("0")||Code.equals("000000")){
		if(result.length>0){
				  loginAccept=result[0][2];
				  retCodeAttr=result[0][0];
				  System.out.println("loginAccept="+loginAccept);
				  System.out.println("retCodeAttr="+retCodeAttr);
				}
	}
	url = "/npage/contact/onceCnttInfo.jsp?opCode="+iOpCode +"&retCodeForCntt="+retCodeAttr+"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept+"&pageActivePhone="+iGrp_No+"&retMsgForCntt="+Msg+"&opBeginTime="+opBeginTime+"&contactId="+iGrp_Id+"&contactType=grp";
	System.out.println("url="+url);
%>
<%
	System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");
	
	if( retCodeAttr.equals("0")||retCodeAttr.equals("000000"))
	{
%>	 
	rdShowMessageDialog("动力100业务包订购成功！");
	window.location.replace("f7412_1.jsp");
<%
	}else{
%>
	rdShowMessageDialog("错误信息：<%=Msg%>"+" 错误代码：<%=retCodeAttr%>");
	history.go(-1);
<%
	}
%>
</script>

<%
}catch(Exception ex){
%>
<script>
	rdShowMessageDialog("调用服务异常!:<%=ex.getMessage()%>");	
	history.go(-1);
</script>
<%
}
%>
 <jsp:include page="<%=url%>" flush="true"/>	    					

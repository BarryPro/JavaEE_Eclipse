<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-11-07
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));

    String iWorkNo = WtcUtil.repNull((String)request.getParameter("workNo"));
    String iOpCode = WtcUtil.repNull((String)request.getParameter("opCode"));
    String iIdNo = WtcUtil.repNull((String)request.getParameter("idNo"));
    String iSmCode = WtcUtil.repNull((String)request.getParameter("smCode"));
    String iProductId = WtcUtil.repNull((String)request.getParameter("productId"));
    String iServiceNo = WtcUtil.repNull((String)request.getParameter("serviceNo"));
    String iRegionCode = WtcUtil.repNull((String)request.getParameter("regionCode"));
    String iSinglePhoneNo = WtcUtil.repNull((String)request.getParameter("singlePhoneNo"));
    String iRequestType = WtcUtil.repNull((String)request.getParameter("requestType"));
    
    String retCode = "";
    String retMessage = "";
    int phoneNoNum = 0;
    String memberUse = "";
    String singlePhoneno  = "";
    String singlephoneTypes="";
    
    /*
    if( iSinglePhoneNo.length() > 5 
    	&& iSinglePhoneNo.substring(0,5).equals("10648")) {
		iSinglePhoneNo = iSinglePhoneNo.replaceFirst("10648", "205");
	}	
	
    if( iSinglePhoneNo.length() > 3 
    	&& iSinglePhoneNo.substring(0,3).equals("147")) {
		iSinglePhoneNo = iSinglePhoneNo.replaceFirst("147", "206");
	} */   
    String sqlStr = "";
	try{
	    /* modify by qidp for [修改SQL为服务]
	    sqlStr = "select a.id_no,f.phone_no,e.sm_name"
              +" from dCustMsgAdd a,dGrpUserMsg b,dAccountIdInfo c,"
              +" sBusiTypeSmCode d,sSmCode e ,dCustMsg f"
              +" where a.FIELD_VALUE=to_char(b.id_no)"
              +" and a.field_code ='1004'"
              +" and f.id_no = a.id_no"
              +" and b.user_no=c.msisdn"
              +" and b.sm_code=c.service_type"
              +" and c.service_no='"+iServiceNo+"'"
              +" and c.service_type=d.sm_code"
              +" and c.service_type=e.sm_code"
              +" and e.region_code='"+iRegionCode+"'"
              +" and rownum < 100 "
              +" and f.phone_no = '"+iSinglePhoneNo+"'";
         */
%>
    <wtc:service name="sGetPhoneInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="4" >
    	<wtc:param value="0"/>
    	<wtc:param value=""/>
    	<wtc:param value="<%=iOpCode%>"/>
    	<wtc:param value="<%=iWorkNo%>"/>
    	<wtc:param value="<%=workPwd%>"/>
    	<wtc:param value="<%=iSinglePhoneNo%>"/>
    	<wtc:param value=""/>
        <wtc:param value="<%=iIdNo%>"/>
        <wtc:param value="<%=iSmCode%>"/>
        <wtc:param value="<%=iProductId%>"/>
        <wtc:param value="m04"/>
        <wtc:param value="<%=iRequestType%>"/>
    </wtc:service>
    <wtc:array id="result" scope="end"/>
<%
System.out.println("# result = "+result.length);
        retCode = retCode2;
        retMessage = retMsg2;
        if("000000".equals(retCode)){
            if(result.length>0){
                phoneNoNum = result.length;
                memberUse = result[0][0];
                singlePhoneno = result[0][1];
                singlephoneTypes = result[0][3];
            }else{
                phoneNoNum = 0;
            }
        }
    }catch(Exception e){
        e.printStackTrace();
        retCode="999999";
        retMessage="查询集团成员信息失败！";
    }
    System.out.println("# phoneNoNum = "+phoneNoNum);
%>
var response = new AJAXPacket();
var retMessage="<%=retMessage%>";
var retCode= "<%=retCode%>";
var vPhoneNoNum = "<%=phoneNoNum%>";
var vMemberUse = "<%=memberUse%>";
var vSinglePhoneno = "<%=singlePhoneno%>";

response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("retPhoneNoNum",vPhoneNoNum);
response.data.add("retMemberUse",vMemberUse);
response.data.add("retSinglePhoneno",vSinglePhoneno);
response.data.add("singlephoneTypes",'<%=singlephoneTypes%>');
core.ajax.receivePacket(response);

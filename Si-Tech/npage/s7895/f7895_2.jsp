<%
    /********************
     * @ OpCode    :  7895
     * @ OpName    :  集团成员删除
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2009-10-16
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<form name="frm" action="" method="post" >
    <input type="hidden" id="errPhoneList" name="errPhoneList" value="" />
    <input type="hidden" id="errMsgList" name="errMsgList" value="" />
    <input type="hidden" id="unitId" name="unitId" value="" />
    <input type="hidden" id="loginAccept" name="loginAccept" value="" />
    <input type="hidden" id="grpName" name="grpName" value="" />
</form>
</body>
<%
    String opCode = "7895";
    String opName = "集团成员删除";
    
    String workNo           = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workName         = WtcUtil.repNull((String)session.getAttribute("workName"));
    String orgCode          = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String regionCode       = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String loginPasswd      = WtcUtil.repNull((String)session.getAttribute("password"));
    String ipAddr           = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
    String orgId            = WtcUtil.repNull((String)session.getAttribute("orgId"));
    
    String iLoginAccept     = WtcUtil.repNull((String)request.getParameter("sys_accept"));
    String iSysNote         = WtcUtil.repNull((String)request.getParameter("opNote"));
	String iOpNote          = WtcUtil.repNull((String)request.getParameter("opNote"));
	String iGrpId           = WtcUtil.repNull((String)request.getParameter("id_no"));
	String iExpectTime      = WtcUtil.repNull((String)request.getParameter("expect_time"));
	String iGrpOutNo        = WtcUtil.repNull((String)request.getParameter("service_no"));
	String iNumType         = WtcUtil.repNull((String)request.getParameter("updateNoType"));
	String iUnitId          = WtcUtil.repNull((String)request.getParameter("unit_id"));
	String iSmCode          = WtcUtil.repNull((String)request.getParameter("sm_code"));
	String iRequestType     = WtcUtil.repNull((String)request.getParameter("request_type"));
	String iGrpName         = WtcUtil.repNull((String)request.getParameter("grp_name"));
	if(!"AD".equals(iSmCode) && !"ML".equals(iSmCode) && !"MA".equals(iSmCode)){
	    iRequestType = "";
	}
	
	String feeList          = "0~0~0~0~0~0~0~";
	String iPayFlag         = "3";
	String iAddmodeflag     = "0";
	String iModeCode        = "0";
	String iPhoneType       = "no";
	String iFileIpAddr      = "";
	String iOpType          = "m04";
	
	String iPhoneNo         = "";
	String iInputType       = WtcUtil.repNull((String)request.getParameter("input_type"));
	String iInputFlag = "";
	/*diling update
	  if(!("vp".equals(iSmCode) || "j1".equals(iSmCode))){
	*/
	  if(!("j1".equals(iSmCode))){
	      System.out.println("------------------7895----------vpmn，彩铃----提交页面");
        if("single".equals(iInputType)){
	        iPhoneNo = WtcUtil.repNull((String)request.getParameter("single_phoneno")) + "|";
	        iInputFlag = "no";
    	}else if("multi".equals(iInputType)){
    	    iPhoneNo = WtcUtil.repNull((String)request.getParameter("multi_phoneNo"));
    	    iInputFlag = "no";
	    }else if("file".equals(iInputType)){
	        iInputFlag = "file";
	    }
    }else{
        /* vpmn,其他修改时,取数据 */
        String tmpR1 = WtcUtil.repNull((String)request.getParameter("tmpR1"));
        System.out.println("#   增加号码 = "+tmpR1);
        /* end of vpmn 取数据 */
        iPhoneNo = tmpR1;
        iInputFlag = "no";
    }
    
    String iInputFile           = WtcUtil.repNull((String)request.getParameter("inputFile"));
    String iServerIpAddr        = realip;   // 0.100主机隐藏ip用上面方法得到的是0.100非真实ip
    
    String retCodeForCntt = "";
    String retMsgForCntt = "";
    
    try{
    String s_srv_name="s7895Cfm";
    //iSmCode="PA";
    String iPhoneNo_PA="";
    if ( iSmCode.equals("PA") )
    {
    	s_srv_name="s7895PACfm";
    	/*
    	for ( int i=0;i<iPhoneNo.split("\\|").length;i++ )
    	{
		    if( iPhoneNo.split("\\|")[i].length() > 5 && iPhoneNo.split("\\|")[i].substring(0,5).equals("10648")) {
		    	System.out.println("@@@"+iPhoneNo.split("\\|")[i]);
				iPhoneNo_PA += iPhoneNo.split("\\|")[i].replaceFirst("10648", "205")+"|";
			}	
			
		    if( iPhoneNo.split("\\|")[i].length() > 3 && iPhoneNo.split("\\|")[i].substring(0,3).equals("147")) {
				iPhoneNo_PA += iPhoneNo.split("\\|")[i].replaceFirst("147", "206")+"|";
			}	
    	}
    	*/
		//iPhoneNo.split("|");
		//iPhoneNo=iPhoneNo_PA;
   	}

    %>
        <wtc:service name="<%=s_srv_name%>" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="4" >
            <wtc:param value="<%=iLoginAccept%>"/>
            <wtc:param value="<%=opCode%>"/>
            <wtc:param value="<%=workNo%>"/>
            <wtc:param value="<%=loginPasswd%>"/>
            <wtc:param value="<%=orgCode%>"/>
                
            <wtc:param value="<%=iSysNote%>"/>
            <wtc:param value="<%=iOpNote%>"/>
            <wtc:param value="<%=ipAddr%>"/>
            <wtc:param value="<%=iGrpId%>"/>
            <wtc:param value="<%=feeList%>"/>
                
            <wtc:param value="<%=iPayFlag%>"/>
            <wtc:param value="<%=iPhoneNo%>"/>
            <wtc:param value="<%=iGrpOutNo%>"/>
            <wtc:param value="<%=iAddmodeflag%>"/>
            <wtc:param value="<%=iModeCode%>"/>
                
            <wtc:param value="<%=iExpectTime%>"/>
            <wtc:param value="<%=iInputFlag%>"/>
            <wtc:param value="<%=iInputFile%>"/>
            <wtc:param value="<%=iServerIpAddr%>"/>
            <wtc:param value="<%=iNumType%>"/>
                
            <wtc:param value="<%=orgId%>"/>
            <wtc:param value="<%=iOpType%>"/>
            <wtc:param value="<%=iRequestType%>"/>
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%
    	retCodeForCntt = retCode;
    	retMsgForCntt = retMsg;
        if("000000".equals(retCode)){
            String errPhoneList = retArr[0][2];
            String errMsgList   = retArr[0][3];
        /* 成功后转到错误展示页面 */
        %>
            <script type=text/javascript>
                $("#errPhoneList").val("<%=errPhoneList%>");
                $("#errMsgList").val("<%=errMsgList%>");
                $("#unitId").val("<%=iUnitId%>");
                $("#loginAccept").val("<%=iLoginAccept%>");
                $("#grpName").val("<%=iGrpName%>");
                
                frm.action="f7895_3.jsp";
            	frm.method="post";
            	frm.submit();
            	
            	//用location批量时有可能URL超长。
                //window.location="f7895_3.jsp?errPhoneList=<%=errPhoneList%>&errMsgList=<%=errMsgList%>&unitId=<%=iUnitId%>&loginAccept=<%=iLoginAccept%>&grpName=<%=iGrpName%>";
            </script>
        <%
            System.out.println("# return from f7895_2.jsp -> Call Service s7895Cfm Success !");
        }else{
        %>
            <script language='jscript'>
                rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
                window.location="f7895_1.jsp";
            </script>
        <%
            System.out.println("# return from f7895_2.jsp by Service[s7895Cfm] -> retCode = " + retCode + " , retMsg = " + retMsg);
        }
    }catch(Exception e){
    %>
        <script type=text/javascript>
            rdShowMessageDialog("调用服务s7895Cfm失败！",0);
            window.location="f7895_1.jsp";
        </script>
    <%
    	e.printStackTrace();
    	System.out.println("# return from f7895_2.jsp -> Call Service s7895Cfm Failed !");
    }
    
System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
%>
<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&retMsgForCntt="+retMsgForCntt+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+iUnitId+"&contactType=grp";%>
<jsp:include page="<%=url%>" flush="true" />
<%
System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
%>
</html>
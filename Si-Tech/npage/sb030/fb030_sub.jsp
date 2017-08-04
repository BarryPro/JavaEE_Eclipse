<%
    /********************
     * @ OpCode    :  b030
     * @ OpName    :  跨省VPMN设置
     * @ CopyRight :  si-tech
     * @ Author    :  zhangyan
     * @ Date      :  2010-7-17 21:14:11
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<form name="frm" action="" method="post" >
    <input type="hidden" id="errPhoneList" name="errPhoneList" value="" />
    <input type="hidden" id="errMsgList" name="errMsgList" value="" />
</form>
</body>
<%
    
    String regionCode = request.getParameter("regionCode");
    
    String groupNo = request.getParameter("group_no");
    String arcGroupNo = request.getParameter("acr_group_no");
    String memFee = request.getParameter("member_append_fee");
    String opType = request.getParameter("op_type");
    System.out.println("--------groupNo"+groupNo);
    System.out.println("--------arcGroupNo"+arcGroupNo);
    System.out.println("--------memFee"+memFee);
    System.out.println("--------opType"+opType);
  
    String workNo = request.getParameter("workno");
    String iOrgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String iLoginPwd = WtcUtil.repNull((String)session.getAttribute("password"));
    String iIpAddr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
    String iMulti_phoneNo = WtcUtil.repNull((String)request.getParameter("multi_phoneNo"));
                   
    System.out.println("--------iMulti_phoneNo"+iMulti_phoneNo);
%>

<wtc:service name="sb030Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg"  outnum="2" >
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=opType%>"/>
	<wtc:param value="<%=groupNo%>"/>
	<wtc:param value="<%=arcGroupNo%>"/>
	<wtc:param value="<%=memFee%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
    <wtc:param value="<%=iOrgCode%>"/>
    <wtc:param value="<%=iIpAddr%>"/>
    <wtc:param value = "<%=iMulti_phoneNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
if("000000".equals(retCode)){
    String errPhoneList = result[0][0];
    String errMsgList   = result[0][1];
    System.out.println("# errPhoneList = " + errPhoneList);
    System.out.println("# errMsgList   = " + errMsgList  );
/* 成功后转到错误展示页面 */
%>
    <script language='jscript'>
        $("#errPhoneList").val("<%=errPhoneList%>");
        $("#errMsgList").val("<%=errMsgList%>");
        
        frm.action="fb030_return.jsp";
    	frm.method="post";
    	frm.submit();
    </script>
<%
}else{
    %>
    <script type=text/javascript>
        rdShowMessageDialog("操作失败！<br/>错误代码：<%=retCode%>，错误信息:<%=retMsg%>",0);
        window.location="fb030.jsp";
    </script>
    <%
}
%>
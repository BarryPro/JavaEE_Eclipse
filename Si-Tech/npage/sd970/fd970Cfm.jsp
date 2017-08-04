<%
/*****************************
 * 模块名称：批量增加集团网外号码
 * 程序版本：version 1.0 4890
 * 开 发 商: SI-TECH
 * 作    者: yuanqs
 * 创建时间: 2011-06-28
 *****************************/
%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html; charset=GBK"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  String opCode = WtcUtil.repNull((String)request.getParameter("op_code"));
  String opName = WtcUtil.repNull((String)request.getParameter("op_name"));
%>
<body>
<form name="frm" action="" method="post" >
	<input type="hidden" id="opCode" name="opCode" value="<%=opCode%>" />
	<input type="hidden" id="opName" name="opName" value="<%=opName%>" />
    <input type="hidden" id="errPhoneList" name="errPhoneList" value="" />
    <input type="hidden" id="errMsgList" name="errMsgList" value="" />
</form>
</body>
<%
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);

  String workNo    = WtcUtil.repNull((String)session.getAttribute("workNo"));
  String workName  = WtcUtil.repNull((String)session.getAttribute("workName"));
  String regionCode= WtcUtil.repNull((String)session.getAttribute("regCode"));
  String orgCode   = WtcUtil.repNull((String)session.getAttribute("orgCode"));
  String ipAddr    = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
  String workPwd   = WtcUtil.repNull((String)session.getAttribute("password"));
  String iOpType = WtcUtil.repNull((String)request.getParameter("opType"));           //操作类型
  String iVpmnGrpNo = WtcUtil.repNull((String)request.getParameter("vpmnGrpNo"));     //智能网集团编码
  String phoneNo	= WtcUtil.repNull((String)request.getParameter("phoneNo"));		  //电话号码
  String phoneNoOut	= WtcUtil.repNull((String)request.getParameter("phoneNoOut"));	  //网外号码列表

%>
    <wtc:service name="sd970Cfm" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
      <wtc:param value=""/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=workPwd%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>

      <wtc:param value="<%=iVpmnGrpNo%>"/>
      <wtc:param value="<%=phoneNoOut%>"/>
      <wtc:param value="<%=ipAddr%>"/>
    </wtc:service>
    <wtc:array id="result" scope="end" />
<%
try{
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

        frm.action="fd970_return.jsp";
    	frm.method="post";
    	frm.submit();
    </script>
<%
    }else{
        System.out.println("From fd970Cfm.jsp 调用服务sd970Cfm操作失败!retCode = "+retCode+" retMsg = "+retMsg);
 %>
    <script type=text/javascript>
        rdShowMessageDialog("操作失败！<br/>错误代码：<%=retCode%>，错误信息:<%=retMsg%>",0);
        window.location="fd970.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    </script>
    <%
    }
}catch(Exception e){
    System.out.println("From sd970Cfm.jsp 调用服务sd970Cfm操作失败");
    e.printStackTrace();
%>
    <script type="text/javascript">
        rdShowMessageDialog("调用服务sd970Cfm操作失败!",0);
        history.go(-1);
    </script>
<%
}
%>
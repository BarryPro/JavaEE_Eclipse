<%
/*****************************
 * 模块名称：智能网闭合群管理
 * 程序版本：version 1.0
 * 开 发 商: SI-TECH
 * 作    者: shengzd
 * 创建时间: 2010-05-10
 *****************************/
%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html; charset=GBK"%>
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

  String opCode = WtcUtil.repNull((String)request.getParameter("op_code"));
  String opName = WtcUtil.repNull((String)request.getParameter("op_name"));
  
  String iOpType = WtcUtil.repNull((String)request.getParameter("opType"));           //操作类型
  String iUnitId = WtcUtil.repNull((String)request.getParameter("unitId"));           //集团编号
  String iUnitName = WtcUtil.repNull((String)request.getParameter("unitName"));       //集团名称
  String iVpmnGrpNo = WtcUtil.repNull((String)request.getParameter("vpmnGrpNo"));     //智能网集团编码
  
  String iCloseNo = WtcUtil.repNull((String)request.getParameter("closeNo"));         //闭合群号
  String iCloseName = WtcUtil.repNull((String)request.getParameter("closeName"));     //闭合群名称
  String iFeeIndex = WtcUtil.repNull((String)request.getParameter("feeIndex"));       //费率索引
  String iMaxUserNum = WtcUtil.repNull((String)request.getParameter("maxUserNum"));   //最大用户数
%>
    <wtc:service name="s4890Cfm" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=workPwd%>"/>
      <wtc:param value="<%=orgCode%>"/>
      <wtc:param value="<%=ipAddr%>"/>
      <wtc:param value="<%=opCode%>"/> 
      <wtc:param value="<%=iOpType%>"/>
      <wtc:param value="<%=iUnitId%>"/>
      <wtc:param value="<%=iVpmnGrpNo%>"/>
      <wtc:param value="<%=iCloseNo%>"/>
      <wtc:param value="<%=iCloseName%>"/>
      <wtc:param value="<%=iFeeIndex%>"/>
      <wtc:param value="<%=iMaxUserNum%>"/>
    </wtc:service>
<%
try{
    if("000000".equals(retCode)){
%>
    <script type="text/javascript">
        rdShowMessageDialog("操作成功!",2);
        window.location = "f4890.jsp";
    </script>
<%
    }else{
        System.out.println("From f4890Cfm.jsp 调用服务s4890Cfm操作失败!retCode = "+retCode+" retMsg = "+retMsg);
%>
    <script type="text/javascript">
        rdShowMessageDialog("错误代码：<%=retCode%><br>错误信息：<%=retMsg%>",0);
        history.go(-1);
    </script>
<%
    }
}catch(Exception e){
    System.out.println("From f4890Cfm.jsp 调用服务s4890Cfm操作失败");
    e.printStackTrace();
%>
    <script type="text/javascript">
        rdShowMessageDialog("调用服务s4890Cfm操作失败!",0);
        history.go(-1);
    </script>
<%
}
%>
<%
/*****************************
 * 模块名称：智能网闭合群成员管理
 * 程序版本：version 1.0
 * 开 发 商: SI-TECH
 * 作    者: shengzd
 * 创建时间: 2010-05-10
 *****************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html; charset=GBK"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<form name="frm" action="" method="post" >
    <input type="hidden" id="errPhoneList" name="errPhoneList" value="" />
    <input type="hidden" id="errMsgList" name="errMsgList" value="" />
</form>
<%
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);
	
	String opCode = WtcUtil.repNull((String)request.getParameter("op_code"));
	String opName = WtcUtil.repNull((String)request.getParameter("op_name"));
	
  String workNo    = WtcUtil.repNull((String)session.getAttribute("workNo"));
  String workName  = WtcUtil.repNull((String)session.getAttribute("workName"));
  String regionCode= WtcUtil.repNull((String)session.getAttribute("regCode"));
  String orgCode   = WtcUtil.repNull((String)session.getAttribute("orgCode"));
  String ipAddr    = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
  String workPwd   = WtcUtil.repNull((String)session.getAttribute("password"));
	
	String iOpType = WtcUtil.repNull((String)request.getParameter("opType"));           //操作类型
	String iUnitId = WtcUtil.repNull((String)request.getParameter("unitId"));           //集团编号
	String iUnitName = WtcUtil.repNull((String)request.getParameter("unitName"));       //集团名称
	String iVpmnGrpNo = WtcUtil.repNull((String)request.getParameter("vpmnGrpNo"));     //智能网集团编码
	
	String iCloseNo = WtcUtil.repNull((String)request.getParameter("closeNo"));         //闭合群号
	String iCloseName = WtcUtil.repNull((String)request.getParameter("closeName"));     //闭合群名称
	String iFeeIndex = WtcUtil.repNull((String)request.getParameter("feeIndex"));       //费率索引
	String iMaxUserNum = WtcUtil.repNull((String)request.getParameter("maxUserNum"));   //最大用户数
	
	String iCloseNo2 = WtcUtil.repNull((String)request.getParameter("newClose"));        //变更后的新的闭合群号
	
	String iNoType = WtcUtil.repNull((String)request.getParameter("noType"));
	String iNoList = WtcUtil.repNull((String)request.getParameter("multi_phoneNo"));
	
	String iFeeIndex2 = WtcUtil.repNull((String)request.getParameter("feeIndex2"));       //新费率索引 wuxy add 20110711
	System.out.println("\n### iNoList = ["+iNoList+"]/n");
	System.out.println("\n### iNoList = ["+iFeeIndex2+"]/n");
	
	try{
%>
    <wtc:service name="s4891Cfm" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=workPwd%>"/>
      <wtc:param value="<%=orgCode%>"/>
      <wtc:param value="<%=ipAddr%>"/>
      <wtc:param value="<%=opCode%>"/> 
      <wtc:param value="<%=iOpType%>"/>
      <wtc:param value="<%=iUnitId%>"/>
      <wtc:param value="<%=iVpmnGrpNo%>"/>
      <wtc:param value="<%=iCloseNo%>"/>
      <wtc:param value="<%=iCloseNo2%>"/>
      <wtc:param value="<%=iCloseName%>"/>
      <wtc:param value="<%=iFeeIndex%>"/>
      <wtc:param value="<%=iMaxUserNum%>"/>
      <wtc:param value="<%=iNoType%>"/>
      <wtc:param value="<%=iNoList%>"/>
      <wtc:param value="<%=iFeeIndex2%>"/>
    </wtc:service>
    <wtc:array id="retArr" scope="end"/>
<%
    	System.out.println("retCode = "+retCode);
    	System.out.println("retMsg  = "+retMsg);
    	
        if("000000".equals(retCode)){
            String errPhoneList = retArr[0][0];
            String errMsgList   = retArr[0][1];
        /* 成功后转到错误展示页面 */
            System.out.println("############### SUCCESS ################");
            System.out.println("errPhoneList = " + errPhoneList);
            System.out.println("errMsgList = "+ errMsgList);
        %>
            <script type="text/javascript">
                $("#errPhoneList").val("<%=errPhoneList%>");
                $("#errMsgList").val("<%=errMsgList%>");
                
                frm.action="f4891ResultList.jsp";
            	frm.method="post";
            	frm.submit();
            </script>
        <%
        }else{
            %>
            <script type="text/javascript">
                rdShowMessageDialog("操作失败！<br/>错误代码：<%=retCode%>，错误信息:<%=retMsg%>",0);
                window.location="f4891.jsp";
            </script>
            <%
        }
    }catch(Exception e){
        %>
        <script type="text/javascript">
            rdShowMessageDialog("调用服务s4891Cfm失败！",0);
            window.location="f4891.jsp";
        </script>
        <%
        System.out.println("# return from f4891Cfm.jsp -> Call Service s4891Cfm Failed!");
        e.printStackTrace();
    }
%>
</body>
</html>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.io.*" %>
<%@ page import="com.sitech.util.page.*" %>

<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  int errCode = 0;
  String errMsg = "";
  int iPageSize = 15;
  int iQuantity = 0;
  String rowCount = "0";
  String workName = (String)session.getAttribute("workName");
  String workNo = (String)session.getAttribute("workNo");
  String op_name = "接触维护日志查询";

  String cSubmitFlag = request.getParameter("cSubmitFlag") == null ? "" : request.getParameter("cSubmitFlag");
  String cApplyWorkId = request.getParameter("cApplyWorkId")==null?"":request.getParameter("cApplyWorkId");
  String cApproveWorkId = request.getParameter("cApproveWorkId")==null?"":request.getParameter("cApproveWorkId");
  String cApplyTimeB = request.getParameter("cApplyTimeB")==null?"":request.getParameter("cApplyTimeB");
  String cApplyTimeE = request.getParameter("cApplyTimeE")==null?"":request.getParameter("cApplyTimeE");
  String cApplyNo = request.getParameter("cApplyNo")==null?"":request.getParameter("cApplyNo");
  int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
  int iStartPos = (iPageNumber-1)*iPageSize;
  int iEndPos = iPageNumber*iPageSize;
%>
<HTML>
<HEAD>
  <TITLE>接触信息维护日志查询</TITLE>
  <META http-equiv=Content-Type content="text/html; charset=gb2312" />
  <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" type="text/css" />
</HEAD>
<Script Language="JavaScript" src="<%=request.getContextPath()%>/callcenter/js/PublicDate.js"></script>
<SCRIPT language=JavaScript>
//Init parameters
var startIndex = 0;
var endIndex = 19;

  function init(){
  }

  function ValidateForm(){
    return true;
  }

  function submitPage(){
  	if(ValidateForm()){
	    //self.status = "正在提交数据，请稍候...";
    	//document.frm.cSubmitFlag.value="1";
	  	//document.frm._submitButton.disabled = true;
		 	document.frm.submit();
	  }
  }

  var subWin1;
  function openViewPage(applyNo){
  	var s = "<%=request.getContextPath()%>/page/sqsp/case/sqsp_view.jsp?cApplyNo="+applyNo;
	  if(!subWin1 || subWin1.closed)
		  subWin1 = window.open(s,"查看申请","height=500,width=850,scrollbars=yes");
	  else
		  subWin1.focus();
  }
</SCRIPT>
<BODY text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 onload="init()" marginwidth="0" marginheight="0" onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<%@ include file="/page/public/head.jsp" %>
<FORM name="frm" action="f3792_2.jsp" method="get">
<div id="Operation_Table">
<%

%>
<TABLE width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
  <TBODY>
    <TR>
      <TD vAlign=top width="100%">
        <table width="100%" border="0" cellpadding="4" cellspacing="1">
          <tr bgcolor="#F0FAFF">
            <td width="20%" align="right">操作员工标识</td>
            <td width="30%"><input type="text" name="cApplyWorkId" value="<%=cApplyWorkId%>" size="20"></td>
            <td width="20%" align="right">接触操作类型</td>
            <td width="30%"><input type="text" name="cApproveWorkId" value="<%=cApproveWorkId%>" size="20"></td>
          </tr>
          <tr bgcolor="#F0FAFF">
            <td width="20%" align="right">开始时间</td>
            <td width="30%"><input type="text" name="cApplyTimeB" value="<%=cApplyTimeB%>" size="20" style="cursor:hand"></td>
            <td width="20%" align="right">结束时间</td>
            <td width="30%"><input type="text" name="cApplyTimeE" value="<%=cApplyTimeE%>" size="20" style="cursor:hand"></td>
          </tr>
          <tr bgcolor="#F0FAFF">
            <td width="20%" align="right">操作渠道</td>
            <td width="30%"><input type="text" name="cApplyNo" value="<%=cApplyNo%>" size="20"></td>
            <td width="20%" align="right"></td>
            <td width="30%"></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
    	<td><%@ include file = "/npage/pub/commonOperate.jsp" %></td>
    </tr>
    <tr>
    </tr>
    <tr>
      <td>
  
      </td>
    </tr>
  </TBODY>
</TABLE>
</div>
<input type="hidden" name="cSubmitFlag" value="0">
</FORM>
<%@ include file="/page/public/foot.jsp" %>
</BODY>
</HTML>

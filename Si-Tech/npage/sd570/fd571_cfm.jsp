<%
/********************
 version v2.0
 开发商: si-tech
 模块: 欢乐家庭冲正
 add by wanglma 2011-05-17
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
	String workNo = (String)session.getAttribute("workNo");
	String passWord = (String)session.getAttribute("password");
	String regCode = (String)session.getAttribute("regCode");
	String workName = (String)session.getAttribute("workName");
	String ip = request.getRemoteAddr();
	String opName = "欢乐家庭冲正";
	String opCode = request.getParameter("opCode");
    String phoneNo = request.getParameter("phoneNo");
    String backaccept = request.getParameter("backaccept");
    String custName = request.getParameter("custName");
    String custAddr = request.getParameter("custAddr");
    String tdMoney = request.getParameter("tdMoney");
    String tdNo = request.getParameter("tdNo");
    String tdImei = request.getParameter("tdImei");
    String tdName = request.getParameter("tdName");
    /* 流水 */
    String printAccept="";
    printAccept = getMaxAccept();

%>
	<wtc:service name="sd571Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>	
	<wtc:param value="<%=opCode%>"/>	
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=passWord%>"/>	
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>							
	<wtc:param value=""/>
	<wtc:param value="<%=backaccept%>"/>		
	<wtc:param value="<%=ip%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>

<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000"))
	{
        String chinaFee = "";
		int i = 0;
		if(!"".equals(tdMoney)){
			%>
				<script language="javascript">
					rdShowMessageDialog("业务办理申请成功！打印发票......", 2);
			
				<wtc:service name="sToChinaFee" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCodeCf" retmsg="retMsgCf" outnum="3" >
					<wtc:param value="<%=tdMoney%>"/>
				</wtc:service>
				<wtc:array id="chinaFeeArr" scope="end"/>
			<%
				if(("000000".equals(retCodeCf) || ("0".equals(retCodeCf))) && chinaFeeArr != null && chinaFeeArr.length > 0) {
					chinaFee = chinaFeeArr[0][2];
				}
			%>
				var infoStr="";
				infoStr+="<%=workNo%>  <%=printAccept%>"+"       <%=opName%>"+"|";
				infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
				infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				infoStr+='<%=custName%>'+"|";//用户名称
				infoStr+=""+"|";//合同号码
				infoStr+="<%=phoneNo%>"+"|";//移动号码
				infoStr+="<%=custAddr%>"+"|";//用户地址
				infoStr+=""+"|";
				
				infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
				infoStr+="<%=tdMoney%>"+"|";//小写 
				infoStr += "备注：欢乐家庭冲正，退回TD固话一部。~";
				
				infoStr += "TD固话品牌型号：<%=tdName%>~";
				infoStr += "TD固话号码：<%=tdNo%>~";
				infoStr += "IMEI码：<%=tdImei%>|";
				infoStr+="<%=workName%>"+"|";//开票人
				infoStr+=" "+"|";//收款人
				location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/sd570/fd570.jsp?opCode=<%=opCode%>%26opName=<%=opName%>%26activePhone=<%=phoneNo%>";
			</script>
<%
      }
      %>
      <script language="JavaScript">
	    rdShowMessageDialog("业务办理成功!",2);
	    window.location="fd570.jsp?opCode=d571&activePhone=<%=phoneNo%>&opName=<%=opName%>";
      </script>
      <%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("业务办理失败!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	window.location="fd570.jsp?opCode=d571&activePhone=<%=phoneNo%>&opName=<%=opName%>";
</script>
<%}%>

<%
/********************
version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<head>
	<title>代理商空中选号交易明细查询</title>
<%
	String opCode = "b789";
	String opName = "代理商空中选号交易明细查询";
	String regionCode= (String)session.getAttribute("regCode");
	String loginAccept = "0";
	String chnSource = "01";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String phoneNo = (String)request.getParameter("phoneNo");
	String userPwd = "";
	String beginTime = (String)request.getParameter("beginTime");;
	String endTime   = (String)request.getParameter("endTime");;
	
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	
	String paraAray[] = new String[11];
	paraAray[0] = loginAccept;
	paraAray[1] = chnSource;
	paraAray[2] = opCode;
	paraAray[3] = workNo;
	paraAray[4] = password;
	paraAray[5] = phoneNo;
	paraAray[6] = userPwd;
	paraAray[7] = beginTime;
	paraAray[8] = endTime;
	paraAray[9] = "" + iPageNumber;
	paraAray[10] = "" + iPageSize;
	
	System.out.println("================ lichaoa =========" + phoneNo);
%>
<wtc:service name="s5265Qry" routerKey="regionCode" routerValue="<%=regionCode%>" 
			retcode="errCode" retmsg="errMsg"  outnum="10">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
</wtc:service>
<wtc:array id="result" scope="end" start="2" length="6"/>
<wtc:array id="result2" scope="end" start="8" length="1"/>
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("================ lichaoa =========查询成功" + errCode);
		String[][] allNumStr = result2;
		System.out.println("================ lichaoa =========" + result.length);
		for(int i = 0; i < result.length ; i++){
			System.out.println("====== " + result[i][0]);
			System.out.println("====== " + result[i][1]);
			System.out.println("====== " + result[i][2]);
			System.out.println("====== " + result[i][3]);
			System.out.println("====== " + result[i][4]);
			System.out.println("====== " + result[i][5]);
		}
%>
</head>
<script language="javascript">
	$(document).ready(function(){
		var msgNode = $("#msgDiv").css("border","1px solid #999").width("360px")
            .css("position","absolute").css("z-index","99")
            .css("background-color","#dff6b3").css("padding","8");
        msgNode.hide();
		
		var as = $("a[@space='bindBag']");
        as.css("cursor","hand").css("font-weight","600");
	});
	
</script>
<body>
<form name="getMoreFrm" method="POST" action="">
<div id="Operation_Table">
	<div style="height:340px;">
	<div class="title">
		<div id="title_zi">代理商空中选号交易明细查询</div>
	</div>
	<table cellspacing="0" id="queryMsgTab">
		<tr>
			<th>序号</th>
			<th>流水号</th>
			<th>空中选号开户手机号码</th>
			<th>客户姓名</th>
			<th>预存款金额</th>
			<th>操作时间</th>
		</tr>
		<%
			for(int i = 0; i < result.length; i++){
		%>
		<tr>
			<td><%=result[i][0]%></td>
			<td><%=result[i][1]%></td>
			<td><%=result[i][2]%></td>
			<td><%=result[i][3]%></td>
			<td><%=result[i][4]%></td>
			<td><%=result[i][5]%></td>
		</tr>
		<%
			}
		%>
	</table>
    </div>
    <%
	    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
	    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	    PageView view = new PageView(request,out,pg);
	%>
	
	<div style="position:relative;font-size:12px;" align="center">
	<%
	   	view.setVisible(true,true,0,0);
	%>
	</div>
</div>
</form>
</body>
</html>
<%
	}else{
		System.out.println("=========== lichaoa ===== " + errCode + " : " + errMsg);
%>
	<script language="JavaScript">
	rdShowMessageDialog("代理商空中选号明细查询失败!(<%=errCode%><%=errMsg%>",0);
	parent.closeDiv();
	</script>
<%
	}
%>

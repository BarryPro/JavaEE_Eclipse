<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String opCode = "7516";
  String opName = "促销品统一付奖查询";

  String loginNo = (String)session.getAttribute("workNo");
  String loginNoPass = (String)session.getAttribute("password");

  String IccId = "";
  String retFlag="";
  String f6842QueryHistoryRetMsg="";//用于判断页面刚进入时的正确性
	String regionCode= (String)session.getAttribute("regCode");
  String strPhoneNo = request.getParameter("phone_no");
  String passwordFromSer="";
  String cust_address = "";
  String bp_name = "";
%>
		<!-- 2013/07/23 14:12:23 gaopeng 关于BOSS系统查询客户资料相关功能优化的需求  -->
  	<wtc:service name="sUserCustInfo" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCodeGetCust" retmsg="errMsgGetCust"  outnum="41" >
      <wtc:param value="0"/>
      <wtc:param value="01"/>
      <wtc:param value="7516"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=loginNoPass%>"/>
      <wtc:param value="<%=strPhoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="根据phone_no:[<%=strPhoneNo%>]进行查询"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  	</wtc:service>
    
		<wtc:array id="resultGetCust" scope="end" >
		</wtc:array>
<%
	if(resultGetCust!=null&&resultGetCust.length>0){
          bp_name = (resultGetCust[0][5]).trim();
          IccId = (resultGetCust[0][13]).trim();
          cust_address = (resultGetCust[0][11]).trim();
          passwordFromSer = (resultGetCust[0][40]).trim();
          System.out.println("gaopeng@@@@@@@@@bp_name="+bp_name);
          System.out.println("gaopeng@@@@@@@@@IccId="+IccId);
          System.out.println("gaopeng@@@@@@@@@cust_address="+cust_address);
          System.out.println("gaopeng@@@@@@@@@passwordFromSer="+passwordFromSer);
    }

  if (bp_name.equals("")){
		retFlag = "1";
	  f6842QueryHistoryRetMsg = "用户号码基本信息为空或不存在!<br>";
 	}

  String[] paraAray = new String[7];
  paraAray[0] = strPhoneNo;		/* 手机号码   */
  paraAray[1] = opCode; 				/* 操作代码*/
  paraAray[2] = loginNo; 			/* 操作工号   */
  paraAray[3] = loginNoPass; 	/* 操作工号密码   */
  paraAray[4] = request.getParameter("queryaward"); /*奖品类别 (ssaleprojecttype#type_code)*/
  paraAray[5] = request.getParameter("detailcode");/*营销案代码*/
  paraAray[6] = request.getParameter("grade_code");/*等级代码*/

	System.out.print(paraAray[0]+"~"+paraAray[1]+"~"+paraAray[2]+"~"+paraAray[3]+"~"+paraAray[4]+"~"+paraAray[5]+"~"+paraAray[6]);
%>
 	<wtc:service name="s6842Sel" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="13" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
	</wtc:service>
	<wtc:array id="s7516InitArr" scope="end"/>
<%
 	int errCode = retCode==""?999999:Integer.parseInt(retCode);
  String errMsg = retMsg;

  if(s7516InitArr == null)
  {
		retFlag = "1";
	  f6842QueryHistoryRetMsg = "s6842Sel查询号码基本信息为空!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
  }else if (errCode != 0){
  	retFlag = "1";
    f6842QueryHistoryRetMsg = "s6842Sel查询用户促销品统一付奖历史信息失败!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
  }

  /****得到打印流水****/
  String printAccept="";
%>
	 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=strPhoneNo%>" id="sLoginAccept"/>
<%
  	printAccept = sLoginAccept;
		System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
  	String cnttActivePhone = strPhoneNo;
  	String url = "/npage/contact/upCnttInfo.jsp?opCode=2253&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+printAccept+"&pageActivePhone="+cnttActivePhone+"&opBeginTime="+opBeginTime+"&contactId="+cnttActivePhone+"&contactType=user";
%>
		<%--增加统一接触--%>
		<jsp:include page="<%=url%>" flush="true" />
<%
		System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");
%>
<html>
<head>
<title>促销品统一付奖查询</title>

<script language="JavaScript">
  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=f6842QueryHistoryRetMsg%>");
    window.location.href="f6842.jsp?activePhone=<%=strPhoneNo%>&opt_flag=search";
  <%}%>
</script>
</head>


<body>
<form name="frm" method="post"    >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">用户信息</div>
</div>
<table cellspacing="0">
    <tr>
        <td class="blue">服务号码</td>
        <td><input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=strPhoneNo%>" readonly></td>
        <td class="blue">客户名称</td>
        <td><input name="bp_name" type="text" class="InputGrey" id="bp_name" size="60" value="<%=bp_name%>" readonly></td>
    </tr>
</table>
<table cellspacing="0">
    <tr>
        <td class="blue">身份证号</td>
        <td><input name="IccId" type="text" class="InputGrey" id="IccId" value="<%=IccId%>" readonly></td>
        <td class="blue">客户地址</td>
        <td><input name="cust_address" type="text" class="InputGrey" id="cust_address" size="60" value="<%=cust_address%>" readonly></td>
    </tr>
</table>
</div>
 <div id="Operation_Table">
	<div class="title">
		<div id="title_zi">付奖明细</div>
	</div>
	<TABLE cellSpacing="0">
   	<TBODY>
		  <tr align="center">
	  		<!--<th>礼品代码</th>-->
			  <th>营销案名称</th>
			  <th>等级名称</th>
			  <th>数量</th>
			  <th>礼包名称</th>
			  <th>领取标志</th>
			  <th>中奖日期</th>
			  <th>操作流水</th>
			  <th>领奖工号</th>
			  <th>领奖日期</th>
			  <th>领奖地点</th>
		  </tr>
  <%
  		String tbclass="";
		  for(int j=0;j<s7516InitArr.length;j++){
		  	tbclass = j%2==0 ? "Grey" : "";
	%>
			<tr align="center">
				<!--<td class="<%=tbclass%>">&nbsp;<%=s7516InitArr[j][0]%></td>-->
				<td class="<%=tbclass%>">&nbsp;<%=s7516InitArr[j][1]%></td>
				<td class="<%=tbclass%>">&nbsp;<%=s7516InitArr[j][2]%></td>
				<td class="<%=tbclass%>">&nbsp;<%=s7516InitArr[j][3]%></td>
				<td class="<%=tbclass%>">&nbsp;<%=s7516InitArr[j][4]%></td>
				<td class="<%=tbclass%>">&nbsp;<%="Y".equals(s7516InitArr[j][5])?"已领取":"未领取"%></td>
				<td class="<%=tbclass%>">&nbsp;<%=s7516InitArr[j][6]%></td>
				<td class="<%=tbclass%>">&nbsp;<%=s7516InitArr[j][7]%></td>
				<td class="<%=tbclass%>">&nbsp;<%=s7516InitArr[j][8]%></td>
				<td class="<%=tbclass%>">&nbsp;<%=s7516InitArr[j][9]%></td>
				<td class="<%=tbclass%>">&nbsp;<%=s7516InitArr[j][10].substring(0, s7516InitArr[j][10].length()-1)%></td>
				<input name="awardId<%=j%>" type="hidden" value="<%=s7516InitArr[j][0]%>">
				<input name="ressum<%=j%>" type="hidden" value="<%=s7516InitArr[j][3]%>">
				<input name="awardidname<%=j%>" type="hidden" value="<%=s7516InitArr[j][5]%>">
				<input name="flag<%=j%>" type="hidden" value="<%=s7516InitArr[j][6]%>">
				<input name="payAccept<%=j%>" type="hidden" value="<%=s7516InitArr[j][8]%>">
			</tr>
			<%}%>
 		</TBODY>
	</TABLE>
  <table cellspacing="0">
    <tr>
    	<td colspan="4" id="footer">
				<div align="center">
				<input name="back" onClick="window.location.href='f6842.jsp?activePhone=<%=strPhoneNo%>&opt_flag=search'" type="button" class="b_foot" value="返回">
				</div>
			</td>
   	</tr>
	</TABLE>
  <%@ include file="/npage/include/footer.jsp" %>
  <input type="hidden" name="awardId" value="">
  <input type="hidden" name="flag" value="">
  <input type="hidden" name="inTotal" value="">
  <input type="hidden" name="payAccept" value="">
  <input type="hidden" name="awardcode" value="<%=paraAray[4]%>">
  <input type="hidden" name="awarddetailcode" value="<%=paraAray[5]%>">
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
</form>
</body>
</html>


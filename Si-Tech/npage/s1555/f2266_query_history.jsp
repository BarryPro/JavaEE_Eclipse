<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-03 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%		
  String opCode = "2253";
  String opName = "促销品统一付奖查询";
  
  String loginNo = (String)session.getAttribute("workNo");
  String ip_Addr = request.getRemoteAddr();  
  String loginNoPass = (String)session.getAttribute("password");  
  	   
  String IccId = ""; 
  String retFlag="",f2266QueryHistoryRetMsg="";//用于判断页面刚进入时的正确性

  String strPhoneNo = request.getParameter("phone_no");
  String strAwardCode = request.getParameter("awardcode");
  String strAwardDetailCode = request.getParameter("detailcode");
  String strUserPasswd = request.getParameter("cus_pass");//用户密码
  String passwordFromSer="";
  String cust_address = "";
  String bp_name = "";
  String ipAddrss = (String)session.getAttribute("ipAddr");
  String orgCode = (String)session.getAttribute("orgCode");
  String strRegionCode = orgCode.substring(0,2);
  
String beizhussdese="根据phoneNo=["+strPhoneNo+"]进行查询";					
%>
			
<wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=strRegionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="2253" />	
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=loginNoPass%>" />
			<wtc:param value="<%=strPhoneNo%>" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
</wtc:service>
		<wtc:array id="baseArr" scope="end"/>			
<%					
	if(baseArr!=null&&baseArr.length>0){
		if(baseArr[0][0].equals("00")) {
		  bp_name = (baseArr[0][5]).trim();
		  IccId = (baseArr[0][13]).trim();
		  cust_address = (baseArr[0][11]).trim();
		  passwordFromSer = (baseArr[0][40]).trim();	
		 }
	}
  
  if (bp_name.equals("")){
		retFlag = "1";
	  f2266QueryHistoryRetMsg = "用户号码基本信息为空或不存在!<br>";
 	}
  
  String[] paraAray1 = new String[8];
  paraAray1[0] = loginNo; 			/* 操作工号   */
  paraAray1[1] = loginNoPass; 	/* 操作工号   */
  paraAray1[2] = "2253"; 				/* 操作代码*/
  paraAray1[3] = strPhoneNo;		/* 手机号码   */ 
  paraAray1[4] = strAwardCode;
  paraAray1[5] = strAwardDetailCode;
  paraAray1[6] = "2";
  paraAray1[7] = strUserPasswd;

  for(int i=0; i<paraAray1.length; i++)
  {		
		if( paraAray1[i] == null )
		{
	  	paraAray1[i] = "";
		}
  }
  //retList = impl.callFXService("s2266Init", paraAray1, "12","phone",strPhoneNo);
%>
 	<wtc:service name="s2266Init" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="13" >
	<wtc:param value="<%=paraAray1[0]%>"/>
	<wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[3]%>"/>
	<wtc:param value="<%=paraAray1[4]%>"/>
	<wtc:param value="<%=paraAray1[5]%>"/>
	<wtc:param value="<%=paraAray1[6]%>"/>
	<wtc:param value="<%=paraAray1[7]%>"/>
	</wtc:service>
	<wtc:array id="s2266InitArr" scope="end"/>
<% 
 	int errCode = retCode==""?999999:Integer.parseInt(retCode);
  String errMsg = retMsg;
  
  if(s2266InitArr == null)
  {
		retFlag = "1";
	  f2266QueryHistoryRetMsg = "s2266Init查询号码基本信息为空!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
  }else if (errCode != 0){
	  	retFlag = "1";
	    f2266QueryHistoryRetMsg = "s2266Init查询用户促销品统一付奖历史信息失败!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
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
    rdShowMessageDialog("<%=f2266QueryHistoryRetMsg%>");
    window.location.href="f2266.jsp?activePhone=<%=strPhoneNo%>";
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
        <td>
            <input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=strPhoneNo%>" readonly>
        <td class="blue">客户名称</td>
        <td>
            <input name="bp_name" type="text" class="InputGrey" id="bp_name" size="60" value="<%=bp_name%>" readonly>
        </td>
    </tr>
</table>
<table cellspacing="0">
    <tr>
        <td class="blue">身份证号</td>
        <td>
            <input name="IccId" type="text" class="InputGrey" id="IccId" value="<%=IccId%>" readonly>
        </td>
        <td class="blue">客户地址</td>
        <td>
            <input name="cust_address" type="text" class="InputGrey" id="cust_address" size="60" value="<%=cust_address%>" readonly>
        </td>
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
	  		<th>选择</td>
			  <th>奖品类别</th>
			  <th>营销案名称</th>
			  <th>数量</th>
			  <th>奖品名称</th>
			  <th>领取标志</th>
			  <th>中奖日期</th>
			  <th>操作流水</th>
			  <th>领奖工号</th>
			  <th>领奖日期</th>
			  <th>备注</th>
		  </tr>
  <% 
  		String tbclass="";
		  for(int j=0;j<s2266InitArr.length;j++){
		  	if(j%2==0){
		  		tbclass="Grey";
		  	}else{
		  		tbclass="";	
		  	}
	%>
			<tr align="center">		
				<td class="<%=tbclass%>"><%=s2266InitArr[j][0]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][1]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][2]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][3]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][4]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][5]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][6]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][7]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][8]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][9]%></td>
				<td class="<%=tbclass%>"><%=s2266InitArr[j][12]%></td>
				<input name="awardId<%=j%>" type="hidden" value="<%=s2266InitArr[j][0]%>">
				<input name="ressum<%=j%>" type="hidden" value="<%=s2266InitArr[j][3]%>">
				<input name="awardidname<%=j%>" type="hidden" value="<%=s2266InitArr[j][5]%>">
				<input name="flag<%=j%>" type="hidden" value="<%=s2266InitArr[j][6]%>">
				<input name="payAccept<%=j%>" type="hidden" value="<%=s2266InitArr[j][8]%>">
			</tr>				
			<%}%>  		
 		</TBODY>
	</TABLE>			 
  <table cellspacing="0">
    <tr> 
    	<td colspan="4" id="footer"> 
				<div align="center"> 
				<input name="back" onClick="window.location.href='f2266.jsp?activePhone=<%=strPhoneNo%>'" type="button" class="b_foot" value="返回">
				</div>
			</td>
   	</tr>
	</TABLE>    
  <%@ include file="/npage/include/footer.jsp" %>
  <input type="hidden" name="awardId" value="">
  <input type="hidden" name="flag" value="">
  <input type="hidden" name="inTotal" value="">
  <input type="hidden" name="payAccept" value="">
  <input type="hidden" name="awardcode" value="<%=strAwardCode%>">
  <input type="hidden" name="awarddetailcode" value="<%=strAwardDetailCode%>">
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
</form>
</body>
</html>


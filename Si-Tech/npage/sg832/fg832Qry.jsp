<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:宽带营销案绑定信息查询(g832)
   * 版本: 1.0
   * 日期: 2013/07/15 10:09:54
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/**			 
				 输入参数：
         iLoginAccept                	流水
         iChnSource              	   	渠道标识
         iOpCode                 		操作代码
         iLoginNo              	   	工号
         iLoginPwd                   	工号密码
         iPhoneNo              	   	手机号码
         iUserPwd                 	号码密码
         iOpNote                 		操作备注
         iCfmLogin                 	宽带号码
		*/

	/*===========获取参数============*/
  String  iLoginAccept = (String)request.getParameter("iLoginAccept");  
  String  iChnSource = (String)request.getParameter("iChnSource");  
  String  iOpCode = (String)request.getParameter("iOpCode");
  String  iopName = (String)request.getParameter("iOpName");
  String  iLoginNo = (String)request.getParameter("iLoginNo");
  String  iLoginPwd = (String)request.getParameter("iLoginPwd");
  String  iPhoneNo = (String)request.getParameter("iPhoneNo");
  String  iUserPwd = (String)request.getParameter("iUserPwd");
  String  iOpNote = (String)request.getParameter("iOpNote");
  String  iCfmLogin = (String)request.getParameter("iCfmLogin");
  String 	regionCode = (String)session.getAttribute("regCode");
  
   String paraAray[] = new String[9];
		 paraAray[0]=iLoginAccept;
		 paraAray[1]=iChnSource;
		 paraAray[2]=iOpCode;
		 paraAray[3]=iLoginNo;
		 paraAray[4]=iLoginPwd;
		 paraAray[5]=iPhoneNo;
		 paraAray[6]=iUserPwd;
		 paraAray[7]=iOpNote;
		 paraAray[8]=iCfmLogin;
%>
<wtc:service name="sG832Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="10">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />
		<wtc:param value="<%=paraAray[8]%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务sG832Qry in fg832Qry.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
	}else{
		System.out.println("调用服务sG832Qry in fg832Qry.jsp errCode| errMsg失败@@@@@@@@@@@@@@@@@@@@@@@@@@"+errCode+errMsg);
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.location = 'fg832Main.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>';
	</script>
<%
	}	
%>
<body>
	<%
	if(errCode.equals("0")||errCode.equals("000000")){
	%>
  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">宽带营销案绑定信息</div>
			</div>
	<table cellspacing="0">
		<tr>
			<td width="15%" class="blue">手机号码</td>
			<td width="35%">
				<%=result1[0][0]%>
			</td>
			<td width="15%" class="blue">宽带号码</td>
			<td width="35%">
				<%=result1[0][1]%>
			</td>
		</tr>
		<tr>
			<td width="15%" class="blue">营销案名称</td>
			<td width="35%">
				<%=result1[0][2]%>
			</td>
			<td width="15%" class="blue">营销活动办理时间</td>
			<td width="35%">
				<%=result1[0][3]%>
			</td>
		</tr>
		<tr>
			<td width="15%" class="blue">宽带折扣</td>
			<td width="35%">
				<%=result1[0][4]%>&nbsp;折
			</td>
			<td width="15%" class="blue">宽带资费名称</td>
			<td width="35%">
				<%=result1[0][5]%>
			</td>
		</tr>
		<tr>
			<td width="15%" class="blue">宽带办理时间</td>
			<td width="35%">
				<%=result1[0][6]%>
			</td>
			<td width="15%" class="blue">宽带当前状态</td>
			<td width="35%">
				<%=result1[0][7]%>
			</td>
		</tr>
		<tr>
			<td width="15%" class="blue">宽带竣工时间</td>
			<td width="35%">
				<%=result1[0][8]%>
			</td>
			<td width="15%" class="blue">宽带包年结束时间</td>
			<td width="35%">
				<%=result1[0][9]%>
			</td>
		</tr>
		
	</table>
	<%}%>
</body>
</html>	
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:R_CMI_HLJ_xueyz_2014_1365513@关于开发批量添加vip功能的需求
   * 版本: 1.0
   * 日期: 2014/03/12 16:22:30
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**	0 iLoginAccept 流水
		1 iChnSource  渠道代码
		2 iOpCode    操作代码
		3 iLoginNo    工号
		4 iLoginPwd   工号密码
		5 iPhoneNo   用户手机号码
		6 iUserPwd   用户手机密码
		7 sOfferId    资费代码
		8 sSchool     学校名称
		9 sClass      班级名称
*/

	/*===========获取参数============*/
 	String iLoginAccept = 	(String)request.getParameter("iLoginAccept");
 	String iChnSource = 	(String)request.getParameter("iChnSource");
 	String iOpCode = 	(String)request.getParameter("iOpCode");
 	String iLoginNo = 	(String)request.getParameter("iLoginNo");
 	String iLoginPwd = 	(String)request.getParameter("iLoginPwd");
 	String iPhoneNo = 	(String)request.getParameter("iPhoneNo");
 	String iUserPwd = 	(String)request.getParameter("iUserPwd");
 	String iFileNo = 	(String)request.getParameter("iFileNo");
 	String iFileName = 	(String)request.getParameter("iFileName");
 	String iOpNote = 	(String)request.getParameter("iOpNote");
 	String iOpSource = 	(String)request.getParameter("iOpSource");
 	String iInputFile = 	(String)request.getParameter("iInputFile");
 	String iFileIpAddr = 	(String)request.getParameter("iFileIpAddr");
 	String opName = 	(String)request.getParameter("opName");
 	String opCode = iOpCode;
 	
  String regionCode = (String)session.getAttribute("regCode");			
  
  String inParam[] = new String[13];
  inParam[0] = iLoginAccept;
  inParam[1] = iChnSource;
  inParam[2] = iOpCode;          
  inParam[3] = iLoginNo;
  inParam[4] = iLoginPwd;
  inParam[5] = iPhoneNo;
  inParam[6] = iUserPwd;
  inParam[7] = iFileNo;
  inParam[8] = iFileName;
  inParam[9] = iOpNote;
  inParam[10] = iOpSource;
  inParam[11] = iInputFile;
  inParam[12] = iFileIpAddr;
%>
<%
			/********************************************
				*@服务名称：sm051Cfm
				*@编码日期：2014/03/12
				*@服务版本：Ver1.0
				*@编码人员：liuminga
				*@功能描述：
				*@输入参数：
				*@ iLoginAccept 业务流水
				*@ iChnSource 渠道标识
				*@ iOpCode 操作代码
				*@ iLoginNo 操作工号
				*@ iLoginPwd 工号密码
				*@ iPhoneNo 服务号码
				*@ iUserPwd 号码密码
				*@ iFileNo 文件编号
				*@ iFileName 文件名称
				*@ iOpNote 操作备注
				*@ iOpSource 操作来源：地市/省公司
				*@ iInputFile 文件路径
				*@ iFileIpAddr 文件IP地址
				
				*@返回参数：
				*@ oRetCode 返回代码
				*@ oRetMsg 返回信息
			*********************************************/
		%>
<wtc:service name="sm051Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="3">
		<wtc:param value="<%=inParam[0]%>" />
		<wtc:param value="<%=inParam[1]%>" />
		<wtc:param value="<%=inParam[2]%>" />
		<wtc:param value="<%=inParam[3]%>" />
		<wtc:param value="<%=inParam[4]%>" />
		<wtc:param value="<%=inParam[5]%>" />
		<wtc:param value="<%=inParam[6]%>" />
		<wtc:param value="<%=inParam[7]%>" />
		<wtc:param value="<%=inParam[8]%>" />
		<wtc:param value="<%=inParam[9]%>" />
		<wtc:param value="<%=inParam[10]%>" />
		<wtc:param value="<%=inParam[11]%>" />
		<wtc:param value="<%=inParam[12]%>" />
	</wtc:service>
	<wtc:array id="result1" start="0" length="1"  scope="end"/>
	<wtc:array id="result2" start="1" length="2"  scope="end"/>
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务 sm051Cfm in fm051Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("处理成功！现在将展示处理信息");
		
	</script>
<%
	}else{
		System.out.println("调用服务 sm051Cfm in fm051Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		
	</script>
<%
	}		
%>	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
	</script>
</head>
<body>
	<form >
		<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">错误结果列表</div>
	</div>
	<div>
	<table>
		<%if(errCode.equals("0")||errCode.equals("000000")){%>
			<tr>
				<td class="blue" width="30%">执行成功数量</td>
				<td><%=result1[0][0]%></td>
			</tr>
		<%}%>
		<tr>
			<th>手机号码</th>
			<th>错误信息</th>
		</tr>
		<%if(errCode.equals("0")||errCode.equals("000000")){
				for(int i=0;i<result2.length;i++){
		%>
			<tr>
				<td><%=result2[i][0]%></td>
				<td><%=result2[i][1]%></td>
			</tr>
		<%}
		}%>
	</table>
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="返回" onclick="history.go(-1)" id="submitr" >&nbsp;&nbsp;
							
							<input  name="back1"  class="b_foot" type="button" value=关闭 id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
	</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
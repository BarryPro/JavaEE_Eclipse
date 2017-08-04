
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "zg57";
	String opName = "不良信息投诉关机_单个号码查询";
	String work_no = (String) session.getAttribute("workNo");
	String loginNoPass = (String)session.getAttribute("password");
	String org_code = (String) session.getAttribute("orgCode");
	String regionCode = org_code.substring(0, 2);
	
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));

	String s_flag="Y";
	String s_souce="否";
	String s_souce_name="否";
	String s_op_flag="否";
	String s_login_no="否";
	String s_op_time="否";
	String s_note="否";

	String[] inParamS = new String[2];
	inParamS[0] = "select a.OPR_CODE,a.MESSAGE_FLAG,a.LOGIN_NO,a.REASON_NOTE,a.OP_TIME,a.REASON_NOTE "
								+" from "
								+" (select  DECODE(OPR_CODE,'01','已加黑','02','已解黑','03','已加黑','04','已解黑','05','已加黑','06','已解黑') OPR_CODE,DECODE(MESSAGE_FLAG,'01','垃圾短信','02','骚扰电话','03','垃圾彩信') MESSAGE_FLAG, LOGIN_NO,REASON_NOTE, to_char(OP_TIME,'yyyymmdd hh24:mi:ss') OP_TIME "
								+" 	from WINFORMATIONSAFEMSG "
								+" 	where PHONE_NO =:phone_no "
								+" 	order by OP_TIME desc "
								+" ) a "
								+" WHERE ROWNUM = 1  ";
	inParamS[1] = "phone_no=" + phoneNo;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeS" retmsg="retMsgS" outnum="6">
	<wtc:param value="<%=inParamS[0]%>"/>
	<wtc:param value="<%=inParamS[1]%>"/>
</wtc:service>
<wtc:array id="resultS"  scope="end"/>
<%
	if("000000".equals(retCodeS)){
		if(resultS.length==0){
			s_flag="N";
		}else{
			s_flag="Y";
			s_op_flag=resultS[0][0]; //黑名单状态
			s_souce=resultS[0][1]; //加入黑名单的类型
			s_login_no=resultS[0][2]; //黑名单的操作工号
			s_souce_name=resultS[0][3]; //加入黑名单的原因
			s_op_time=resultS[0][4]; //黑名单的操作时间
			s_note=resultS[0][5]; //黑名单的操作备注
		}
	}
%>
<html>
	<META http-equiv=Content-Type content="text/html; charset=GBK">
	<head>
		<title><%=opName%></title>
		<script language=javascript>
			function add(){
				frm.action="zg57_1_add.jsp";
				frm.submit();
			}

			function change(){
				frm.action="f6945_chg.jsp?";
				frm.submit();
			}
			
			function goBack(){
				window.location.href="zg57.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			}
		</script>
	</head>
	<body>
		<form name="frm" method="POST" action="">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">用户信息</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td class="blue" width="15%" nowrap>手机号码</td>
				    <td colspan="3">
				    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" size="30" readonly>
				    </td>
				</tr>
				<tr>
					<td class="blue" width="15%" nowrap>黑名单状态</td>
					<td width="35%">
						<input class="InputGrey" type="text" name="isBlack" id="isBlack" value="<%=s_op_flag%>" size="30" readonly>
					</td>
					<td class="blue" width="15%" nowrap>加入黑名单的原因</td>
					<td width="35%">
						<input class="InputGrey" type="text" name="blackReason" id="blackReason" value="<%=s_souce_name%>" size="30" readonly>
					</td>
				</tr>
					<tr>
					<td class="blue" width="15%" nowrap>加入黑名单的类型</td>
					<td width="35%">
						<input class="InputGrey" type="text" name="blackLogin" id="blackLogin" value="<%=s_souce%>" size="30" readonly>
					</td>
					<td class="blue" width="15%" nowrap>黑名单的操作时间</td>
					<td width="35%">
						<input class="InputGrey" type="text" name="blackTime" id="blackTime" value="<%=s_op_time%>" size="30" readonly>
					</td>
				</tr>
				<tr>
					<td class="blue" width="15%" nowrap>黑名单的操作工号</td>
					<td width="35%">
						<input class="InputGrey" type="text" name="isGsms" id="isGsms" value="<%=s_login_no%>" size="30" readonly>
					</td>
					<td class="blue" width="15%" nowrap>黑名单的操作备注</td>
					<td width="35%">
						<input class="InputGrey" type="text" name="gsmsCancle" id="gsmsCancle" value="<%=s_note%>" size="30" readonly>
					</td>
				</tr>
    		<tr>
        	<td colspan="4" id="footer">
					<%if(s_flag.equals("N")){ //无结果%>	
					    <input class="b_foot" type="button" name="b_add" value="添加" onClick="add();" />
					<%}else{ //有结果
							if(!"已加黑".equals(s_op_flag)){
					%>
								<input class="b_foot" type="button" name="b_add" value="添加" onClick="add();" />
					<%	}
						}
					%>
            &nbsp;
            <input class="b_foot" type="button" name="b_back" value="返回" onClick="goBack()">
            &nbsp;
            <input class="b_foot" type="button" name="b_close" value="关闭" onClick="removeCurrentTab();">
        	</td>
    		</tr>
			</table>
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<input type="hidden" name="opName" value="<%=opName%>">
    	<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>
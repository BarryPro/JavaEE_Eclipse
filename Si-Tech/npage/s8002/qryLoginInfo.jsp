<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-25 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>
<%
	String opCode = "8002";
	String opName = "工号管理";	
	String regionCode2= (String)session.getAttribute("regCode");
	
	System.out.println("<------------详细信息--------------->");
	String dWorkNo = (String)session.getAttribute("workNo");
	String dNopass = (String)session.getAttribute("password");
	
	ArrayList arr1 = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr1.get(0);
	
	ArrayList powerRightArr = RoleManageWrapper.getPowerRight();
	ArrayList regionArr = RoleManageWrapper.getRegionCode();
	ArrayList rptArr = RoleManageWrapper.getRptCode();
	ArrayList typeArr = RoleManageWrapper.getLoginType();
	
	String[][] loginTypeStr = (String[][])typeArr.get(0);
	String[][] powerRight = (String[][])powerRightArr.get(0);
	String[][] regionCode = (String[][])regionArr.get(0);	
	String[][] rptCode = (String[][])rptArr.get(0);
	
	String loginNo = request.getParameter("workNo");
	String accountType = request.getParameter("accountType");
	
	String SEQ_MailCode	= request.getParameter("SEQ_MailCode");//20100317 add
  String MailCodeAddr	= loginNo + SEQ_MailCode +"@hl.chinamobile.com";//20100317 add
  String reject_flag	= request.getParameter("reject_flag");//2014/3/12 add
	
	String accTypeName = "营业类BOSS帐号";
	if(accountType.equals("2"))
	{
		accTypeName = "客服帐号";
	}
	else if(accountType.equals("3"))
	{
		accTypeName = "管理类BOSS帐号";
	}
	
	String contractPhone = request.getParameter("contractPhone");
	String loginName     = request.getParameter("loginName");
	String powerCode     = request.getParameter("powerCode");
	String powerName     = request.getParameter("powerName");
	String power_right   = request.getParameter("powerRight");
	String loginFlag     = request.getParameter("loginFlag");
	String opTime        = request.getParameter("opTime");
	String rptRight      = request.getParameter("rptRight");
	String allowBegin    = request.getParameter("allowBegin");
	String allowEnd      = request.getParameter("allowEnd");
	String passTime      = request.getParameter("passTime");
	String expireTime    = request.getParameter("expireTime");
	String tryTimes      = request.getParameter("tryTimes");
	String vilidFlag     = request.getParameter("vilidFlag");
	String maintainFlag  = request.getParameter("maintainFlag");
	String orgCode       = request.getParameter("orgCode");
	StringBuffer sb      = new StringBuffer(orgCode);
	String region_code   = sb.substring(0,2);
	String dis_code      = sb.substring(2,4);
	String town_code     = sb.substring(4,7);
	String orgNo         = sb.substring(7,orgCode.length());
	String deptCode      = request.getParameter("deptCode");
	String loginStatus   = request.getParameter("loginStatus");
	String ipAddress     = request.getParameter("ipAddress");
	String runTime       = request.getParameter("runTime");
	String reloginFlag   = request.getParameter("reloginFlag");
	String otherFlag     = request.getParameter("otherFlag");
	String sendFlag      = request.getParameter("sendFlag");
	String ipFlag        = request.getParameter("ipFlag");
	String maxErr        = request.getParameter("maxErr");
	String groupId       = request.getParameter("groupId");
  String accountName   = request.getParameter("accountName");	
	
	ArrayList disArrInit = RoleManageWrapper.getDisCode(region_code);
	String[][] disCodeInit = (String[][])disArrInit.get(0);
	ArrayList townArrInit = RoleManageWrapper.getTownCode(region_code,dis_code);
	String[][] townCodeInit = (String[][])townArrInit.get(0);
	String groupName=" ";
	
	if(!accountType.equals("1"))
	{
		//comImpl co=new comImpl();
		String strSql = "select group_name from dChnGroupMsg where group_id = " + groupId;
		//ArrayList arrGrpName = co.spubqry32("1",strSql);
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode2%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=strSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="arrGrpName" scope="end" />
	<%
		
		System.out.println("++++++++"+strSql+"++++++++");
		String[][] strGroupName = arrGrpName;
		groupName=strGroupName[0][0];
		System.out.println("++++++++"+groupName+"++++++++");
	}
%>

<HTML><HEAD>
<TITLE>工号管理</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>	
	onload=function()
	{		
	}
	function doProcess(packet)
	{
		//返回处理
		var backString = packet.data.findValueByName("backString");
		var flag = packet.data.findValueByName("flag");
		
		 var temLength = backString.length+1;
		 var arr = new Array(temLength);
		 
		 for(var i = 0 ; i < backString.length ; i ++)
		 {
			arr[i] = "<OPTION value="+backString[i][0]+">" + backString[i][1] + "</OPTION>";
		 }
		 if(flag=="0")
		 {
			disCodeDiv.innerHTML = "<select id=disCode size=1 name=disctrictCode onchange=callTownCode()>" + arr.join() + "</SELECT>";
			callTownCode();
		 }
		 if(flag=="1")
		 {
		   	townCodeDiv.innerHTML = "<select id=tCode size=1 name=townCode>" + arr.join() + "</SELECT>";
		 }
	}
	
	//根据地区代码查询地市代码
	function callDisCode(){
		var i = 0;
		var regionCode = 0;
		for(i = 0 ; i < document.frm.regionCode.length ; i ++)
		{
			if(document.frm.regionCode.options[i].selected)
			{
				regionCode = document.frm.regionCode.options[i].value;
			}
		}
		
		var myPacket = new AJAXPacket("callDisCode.jsp","正在查询，请稍候......");
		myPacket.data.add("region_code",regionCode);
		
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
	
	function callTownCode()
	{
		var i = 0;
		var regionCode = 0;
		for(i = 0 ; i < document.frm.regionCode.length ; i ++)
		{
			if(document.frm.regionCode.options[i].selected)
			{
				regionCode = document.frm.regionCode.options[i].value;
			}
		}
		var j = 0;
		var disctrictCode = 0;
		for(j = 0 ; j < document.frm.disctrictCode.length ; j ++)
		{
			if(document.frm.disctrictCode.options[j].selected)
			{
				disctrictCode = document.frm.disctrictCode.options[j].value;
			}
		}
		
	    var myPacket = new AJAXPacket("callTownCode.jsp","正在查询，请稍候......");
		myPacket.data.add("region_code",regionCode);
		myPacket.data.add("dis_code",disctrictCode);
			
	    core.ajax.sendPacket(myPacket);
	    myPacket=null;
	}

</script>
</HEAD>
<body>
	<form name="frm">
		<%@ include file="/npage/include/header_pop.jsp" %>
		<div class="title">
			<div id="title_zi">详细信息</div>
		</div>		
		<table id=tbs9 cellspacing=0>		
			<tr> 
				<td width="18%" class="blue">&nbsp;帐号代码</td>
				<td width="32%"> 
					<input  id=part1 type=text size=20 name=loginNo value="<%=loginNo%>" disabled >
				</td>
				<td width="18%" class="blue">&nbsp;帐号类型 </td>
				<td width="32%"> 					
					<select id=idAccountType size=1 name=accountType disabled>
						<option value="<%=accountType%>" selected > <%=accountName%> </option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="18%"  class="blue">&nbsp;工号名称</td>
				<td width="32%"> 
					<input  id=part2  type=text size=20 name=loginName value="<%=loginName%>" disabled >
				</td>
				<td width="18%" class="blue">&nbsp;工号类型</td>
				<td width="32%" > 
					<select id=part3 size=1 name=loginFlag  disabled >
					<%for(int i = 0 ; i < loginTypeStr.length ; i ++)
					{%>
						<option value="<%=loginTypeStr[i][0]%>" type_value="<%=loginTypeStr[i][2]%>" 
							<%if(loginFlag.equals(loginTypeStr[i][0]))
							{%> selected <%}%>><%=loginTypeStr[i][1]%>
						</option>
					<%}%>
					</select>
				</td>
			</tr>	
		  <!--20100317 add-->
			<%if(accountType.equals("1"))
	    {
	    %>
			<tr>
				<td width="18%"  class="blue">&nbsp;邮箱地址</td>
				<td colspan='3' >
					<input id=part37 type=text size=40 name=MailCodeAddr value="<%=MailCodeAddr%>" readonly class="InputGrey" >
				</td>
			</tr>
			<%
			}
			%>
			<!--20100317 end-->
		</TABLE>
		
		<div id=mainTable>		
			<TABLE  cellSpacing=0>
			<TBODY> 
				<tr > 
					<td width="18%" class="blue">&nbsp;角色代码</td>
					<td colspan="3" >
						<input type=text  v_type="string"  v_must=1   
							name=power_code  maxlength=10 size="10" value="<%=powerCode%>" disabled>
						<input type=text  name=power_name value="<%=powerName%>" size=22 maxlength=10 disabled>			
					</td>					
				</tr>
				<tr >
					<td width="18%" class="blue">&nbsp;权限值</td>
					<td width="32%" > 
						<select id=part7 size=1 name=powerRight disabled >
						<%for(int i = 0 ; i<powerRight.length; i ++)
						{%>
							<option value="<%=powerRight[i][0]%>" <%if(power_right.trim().equals(powerRight[i][0].trim())){%> selected <%}%>>
							<%=powerRight[i][1]%>
							</option>
						<%}%>
						</select>
					</td>
					<td  width="18%" class="blue">报表权限</td>
					<td width="32%" >&nbsp; 
						<select id=part8 size=1 name=rptRight disabled >
						<%for(int i = 0 ; i < rptCode.length; i ++){%>
							<option value="<%=rptCode[i][0]%>" 
								<%if(rptRight.trim().equals(rptCode[i][0].trim())){%> selected <%}%>>
								<%=rptCode[i][1]%></option>
						<%}%>
						</select>
					</td>
				</tr>
			</TBODY> 
			</TABLE>
			<TABLE  cellSpacing=0>
			<TBODY> 
				<tr > 
					<td width="18%" class="blue">&nbsp;登陆允许时间</td>
					<td width="32%" > 
						<input  id=part9 type=text size=20 name=allowBegin value="<%=allowBegin%>" disabled >
						<input  id=part20 type=hidden size=2 name=allowBeginMonth>
						<input  id=part21 type=hidden size=2 name=allowBeginDate>
						<input  id=part22 type=hidden size=2 name=allowBeginHour
						<input  id=part23 type=hidden size=2 name=allowBeginMinute>
						<input  id=part24 type=hidden size=2 name=allowBeginSecond>
					</td>
					<td width="18%"  class="blue">登陆允许结束时间&nbsp; </td>
					<td width="32%" > 
						<input  id=part10 type=text size=20 name=allowEnd value="<%=allowEnd%>" disabled >
						<input  id=part25 type=hidden size=2 name=allowEndMonth>
						<input  id=part26 type=hidden size=2 name=allowEndDate>
						<input  id=part27 type=hidden size=2 name=allowEndHour>
						<input  id=part28 type=hidden size=2 name=allowEndMinute>
						<input  id=part29 type=hidden size=2 name=allowEndSecond>
					</td>
				</tr>
			</TBODY> 
			</TABLE>
			<TABLE  cellSpacing=0>
			<TBODY> 
				<tr > 
					<td width="18%" class="blue">&nbsp;密码到期时间</td>
					<td width="32%" > 
						<input  id=part11 type=text size=20 name=expireTime value="<%=expireTime%>" disabled >
						<input  id=part30 type=hidden size=2 name=expireTimeMonth>
						<input  id=part31 type=hidden size=2 name=expireTimeDate>
						<input  id=part32 type=hidden size=2 name=expireTimeHour>
						<input  id=part33 type=hidden size=2 name=expireTimeMinute>
						<input  id=part34 type=hidden size=2 name=expireTimeSecond>
					</td>
					<td width="18%"  class="blue">当前登陆次数</td>
					<td width="32%"  > 
						<input  id=part12 type=text size=20 name=tryTimes disabled value="<%=tryTimes%>">
					</td>
				</tr>
			</TBODY> 
			</TABLE>
			<TABLE  cellSpacing=0>
			<TBODY> 
				<tr > 
					<td width="18%" class="blue">&nbsp;工号有效标志</td>
					<td width="16%" > 
					  <input id=radio1 type=radio name=validFlag value=1 
					  <%if(vilidFlag.trim().equals("1")){%> checked <%}%>>
					  有效 </td>
					<td width="16%" > 
					  <input id=radio1 type=radio
					name=validFlag value=0 <%if(vilidFlag.trim().equals("0")){%> checked <%}%>>
					  &nbsp; 无效 </td>
					<td width="18%" class="blue">系统维护标志&nbsp; </td>
					<td width="16%" > 
					  <input id=radio type=radio
					name=maintainFlag value=1 <%if(maintainFlag.trim().equals("1")){%> checked <%}%>>
					  &nbsp; 维护工号 </td>
					<td width="16%" > 
					  <input id=radio type=radio
					name=maintainFlag value=0 <%if(maintainFlag.trim().equals("0")){%> checked <%}%>>
					  &nbsp; 非维护工号 </td>
				</tr>
			</TBODY> 
			</TABLE>
			<TABLE cellSpacing=0>
			<TBODY>
			<%
			if(accountType.equals("1"))
			{
			%>
			<tr id="trOrgCode" > 
				<td width="18%" nowrap class="blue">&nbsp;地&nbsp;&nbsp;&nbsp;&nbsp;区</td>
				<td width="32%" nowrap >
					<select id=part13 size=1 name=regionCode onchange="callDisCode()" disabled > 
	            	<%
	            	for(int i = 0 ; i < regionCode.length; i ++)
	            	{
					%>
						<option value="<%=regionCode[i][0]%>" 
							<%if(region_code.trim().equals(regionCode[i][0]))
							{%> selected <%}%>>	<%=regionCode[i][1]%>
						</option>
					<%
					}
					%>
					</select>
				</td>
				<td width="18%" nowrap class="blue">市&nbsp;&nbsp;&nbsp;&nbsp;县</td>
				<td width="32%" > 
					<div id=disCodeDiv>
						<select id=disCode size=1 name=disctrictCode onchange="callTownCode()" disabled >
						<%
						for(int i = 0 ; i < disCodeInit.length ; i ++)
						{
						%>
							<option value="<%=disCodeInit[i][1]%>" 
								<%if(dis_code.trim().equals(disCodeInit[i][1]))
								{%> selected <%}%>><%=disCodeInit[i][2]%></option>
						<%
						}
						%>
						</select>
					</div>
				</td>
			</tr>
			</tbody>
			</table>
			<TABLE  cellSpacing=0>
			<TBODY>
			<tr >
				<td width="18%" nowrap class="blue">&nbsp;营业厅 </td>
				<td colspan="3" >
					<div id=townCodeDiv>
						<select id=tCode size=1 name=townCode disabled > 
						<%
						for(int i = 0 ; i < townCodeInit.length ; i ++)
						{%>
							<option value="<%=townCodeInit[i][0]%>" 
								<%if(town_code.trim().equals(townCodeInit[i][0]))
								{%> selected <%}%>><%=townCodeInit[i][1]%></option>
						<%
						}%>
						</select>
					</div>
					<input  id=part14  type=hidden size=10 name=orgNo value="<%=orgNo%>" disabled >
				</td>			
			</tr>
			<%
			}
			else //if(accType == 2)
			{
			%>
			<tr id="trGroupId" >
				<td width="18%" class="blue"> &nbsp;组织节点名称</td>
				<td width="32%">
					<input  id=part36 type=text size=32 name=groupName value="<%=groupName%>" disabled > 
				</td>
				<td width="18%"></td>
				<td width="32%"></td>
			</tr>
			<%
			}
			%>
			</tbody>
			</table>
			<TABLE cellSpacing=0>
			<TBODY> 
			<tr > 
				<td width="18%" class="blue"> &nbsp;工号归属部门编码</td>
				<td width="32%" > 
					<input  id=part15 type=text size=20 name=deptCode value="<%=deptCode%>" disabled >
				</td>
				<td width="18%" class="blue"> 身份证号</td>
				<td width="32%" > 
					<input  id=part15 type=text maxlength=18 size=20 name=contractPhoneNo 
						value="<%=contractPhone%>" disabled  />
				</td>
			</tr>
			</TBODY> 
			</TABLE>
			<TABLE  cellSpacing=0>
			<TBODY> 
				<tr > 
					<td width="18%" class="blue"> &nbsp;登录IP地址</td>
					<td width="32%"  > 
						<input  id=part16 type=text size=16 name=lastIpAdd1 disabled value="<%=ipAddress%>">
					</td>
					<td width="18%" class="blue">异地受理标志</td>
					<td width="32%" > 
						<select name=otherflag id=part35 disabled >
							<option value="N" <%if(otherFlag.trim().equals("N")){%> selected <%}%>>不允许</option>
							<option value="Y" <%if(otherFlag.trim().equals("Y")){%> selected <%}%>>允许</option>
						</select>
					</td>
				</tr>
			</TBODY> 
			</TABLE>
			<TABLE cellSpacing=0>
			<TBODY> 
				<tr > 
					<td width="18%" class="blue"> &nbsp;重复登陆标志</td>
					<td width="32%" > 
						<select name=reFlag id=part17 disabled >
							<option value="1" <%if(reloginFlag.trim().equals("1")){%> selected <%}%>>不允许</option>
							<option value="0" <%if(reloginFlag.trim().equals("0")){%> selected <%}%>>允许</option>
						</select>
					</td>
					<td width="18%" class="blue">登陆状态</td>
					<td width="32%"> 
						<select name=loginStatus id=part18 disabled >
							<option value="1" <%if(loginStatus.trim().equals("1")){%> selected <%}%>>签到</option>
							<option value="2" <%if(loginStatus.trim().equals("2")){%> selected <%}%>>签退</option>
						</select>
					</td>
				</tr>
	 			<tr > 
	 				<td width="18%" class="blue">&nbsp;绑定IP标志</td>
	 				<td width="32%" > 
	 					<select name=select id=part35 disabled >
	 						<option value="N" <%if(sendFlag.trim().equals("N")){%> selected <%}%>>否</option>
	 						<option value="Y" <%if(sendFlag.trim().equals("Y")){%> selected <%}%>>是</option>
	 					</select>
	 				</td>
	 				<td width="18%" class="blue">发送密码标志</td>
	 				<td width="32%" > 
	 					<select name=select2 id=part35 disabled >
	 						<option value="N" <%if(ipFlag.trim().equals("N")){%> selected <%}%>>否</option>
	 						<option value="Y" <%if(ipFlag.trim().equals("Y")){%> selected <%}%>>是</option>
	 					</select>
	 				</td>
	 			</tr>
	 			<tr> 
	 				<td width="18%" class="blue">&nbsp;最大错误次数</td>
	 				<td colspan="3" > 
	 			    	<input  id=part16 type=text size=16 name=lastIpAdd123 disabled 
	 			    		value="<%=maxErr%>">
					</td>
				</tr>
				<tr> 
	 				<td width="18%" class="blue">&nbsp;工号操作在实收报表中剔除</td>
	 				<td colspan="3" > 
		 			    <select name=reject_flag id=part19 disabled >
		 						<option value="0" <%if("".equals(reject_flag)){%> selected <%}%>>否</option>
		 						<option value="1" <%if(!"".equals(reject_flag)){%> selected <%}%>>是</option>
		 					</select>
					</td>
				</tr>
			</TBODY> 
			</TABLE>
		
		
		<TABLE  cellSpacing=0>
		<TBODY>
			<TR >
				<TD id="footer" >
					<input class="b_foot" name=back1  type=button value=关闭 id=Button2 onclick="window.close()">
				</TD>
			</TR>
		</TBODY>
		</TABLE>
		

	
	<input type=hidden name=op_code value="111">
	<input type=hidden name=op_type value="">
	<input type=hidden name=login_flag value="">
	<input type=hidden name=power_code value="">
	<input type=hidden name=power_right value="">
	<input type=hidden name=rpt_right value="">
	<input type=hidden name=valid_flag value="">
	<input type=hidden name=maintain_flag value="">
	<input type=hidden name=orgCode value="">
	<input type=hidden name=region_code value="">
	<input type=hidden name=disctrict_code value="">
	<input type=hidden name=town_code value="">
	<input type=hidden name=org_code value="">
	<input type=hidden name=re_flag value="">
	<input type=hidden name=login_status value="">
	<input type=hidden name=lastIpAdd value="">
	<%@ include file="/npage/include/footer_pop.jsp" %> 
</FORM>
</BODY>
</HTML>

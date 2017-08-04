<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.config.INIT_DATA"%>

<script type="text/javascript" src="date.js"></script>

<%

		ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfoSession = (String[][])arrSession.get(0);
		String[][] otherInfoSession = (String[][])arrSession.get(2);
        String loginNo =(String)session.getAttribute("workNo");
        String loginName = (String)session.getAttribute("workName");
        String orgCode = (String)session.getAttribute("orgCode");
        String ip_Addr = (String)session.getAttribute("ipAddr");
 		String regionCode = (String)session.getAttribute("regCode");
		String regionName = otherInfoSession[0][5];

		String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
		String GroupId = baseInfoSession[0][21];
		String ProvinceRun = baseInfoSession[0][22];
		String OrgId = baseInfoSession[0][23];

		int recordNum = 0;
		String tok = "~";
		ArrayList retArray = new ArrayList();
		String[][] result = new String[][]{};
%>

<%
	int valid = 1;  //0:正确，1：系统错误，2：业务错误
	String[] retInfos = null;

	String[] ParamsIn = new String[8];
	String op_code = request.getParameter("opCode");
	String no_type = request.getParameter("noType");
	String inOrgCode = request.getParameter("orgCode");	 /* 机构编码   */
	String iRegion_Code = inOrgCode.substring(0,2);

	ParamsIn[0] = request.getParameter("loginNo");  /* 操作工号   */
	ParamsIn[1] = request.getParameter("orgCode");  /* 机构编码   */
	ParamsIn[2] = request.getParameter("opCode");   /* 操作代码   */
	ParamsIn[3] = request.getParameter("opNote");   /* 操作备注   */
	ParamsIn[4] = request.getParameter("GRPID");	/* 集团号	 */
	ParamsIn[5] = request.getParameter("PHONENO");  /* 短号码	 */
	ParamsIn[6] = request.getParameter("ISDNNO");   /* 真实号码   */
	ParamsIn[7] = request.getParameter("qryType");  /* 查询类型   */

	for(int i=0; i<ParamsIn.length; i++){
		if( ParamsIn[i] == null ){
			ParamsIn[i] = "";
		}
		//System.out.println("["+i+"]="+ParamsIn[i]);
	}

	//retArray = callView.callFXService("s3216Cfm", ParamsIn, "3", "region", iRegion_Code);
  %>
	<wtc:service name="s3216Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="errorCode" retmsg="errorMsg" outnum="3">
		<wtc:param value="<%=ParamsIn[0]%>" />
		<wtc:param value="<%=ParamsIn[1]%>" />
		<wtc:param value="<%=ParamsIn[2]%>" />
		<wtc:param value="<%=ParamsIn[3]%>" />
		<wtc:param value="<%=ParamsIn[4]%>" />
		<wtc:param value="<%=ParamsIn[5]%>" />		
		<wtc:param value="<%=ParamsIn[6]%>" />
		<wtc:param value="<%=ParamsIn[7]%>" />				
	</wtc:service>
	<wtc:array id="callData" start="2" length="1" scope="end" />		  
  <% 
	if( callData == null )
	{
		valid = 1;
	}
	else
	{
		if( !errorCode.equals("000000")){
		{
			valid = 2;
		}
		else
		{
			valid = 0;
			retInfos = callData[0][0].split(tok, 32);
/*
			for(int i = 0; i < retInfos.length; i ++)
			{
				System.out.println("retInfos[" + i + "]=[" + retInfos[i] + "];");
			}
*/
			if( retInfos.length != 32 )
			{
				valid = 2;
				errorCode=444444;
				errorMsg="数据项缺少!!";
			}
		}
	}
%>

<%
if( valid != 0 )
{
	System.out.println("===111valid=="+valid); 
	response.sendRedirect("smapError.jsp?ReqPageName=f3216&errCode="+errorCode+"&errMsg="+errorMsg);%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<br>错误代码:"+"<%=errorCode%></br>"+"错误信息:"+"<%=errorMsg%>");
	history.go(-1);

//-->
</script>
<%}%>


<head>
<title>查询:基本信息</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<script language="JavaScript">
	function fillSelectUseValue_noArr(fillObject,indValue)
	{
			for(var i=0;i<document.all(fillObject).options.length;i++){
				if(document.all(fillObject).options[i].value == indValue){
					document.all(fillObject).options[i].selected = true;
					break;
				}
			}
	}

	function init()
	{
		with(document.frm)
		{
			GRPID.value = "<%=retInfos[0]%>";
			PHONENO.value = "<%=retInfos[1]%>";
			ISDNNO.value = "<%=retInfos[2]%>";
	    	
			USERNAME.value = "<%=retInfos[3]%>";
			IDCARD.value = "<%=retInfos[4]%>";
			DEPT.value = "<%=retInfos[5]%>";
			PCOMMENT.value ="<%=retInfos[6]%>";
	    	
			CLOSENO1.value = "<%=retInfos[7]%>";
			CLOSENO2.value = "<%=retInfos[8]%>";
			CLOSENO3.value = "<%=retInfos[9]%>";
			CLOSENO4.value = "<%=retInfos[10]%>";
			CLOSENO5.value = "<%=retInfos[11]%>";
			//inuserFlag.value="";
			fillSelectUseValue_noArr("LOCKFLAG","<%=retInfos[12]%>" );
	    	
			FLAGS.value =  "<%=retInfos[13]%>";
			var statusDB =  "<%=retInfos[14]%>";
			if(  statusDB.length >=3 )
			{
				fillSelectUseValue_noArr("STATUS1",statusDB.substring(0,1) );
				fillSelectUseValue_noArr("STATUS2",statusDB.substring(1,2) );
				fillSelectUseValue_noArr("STATUS3",statusDB.substring(2,3) );
			}
	
			fillSelectUseValue_noArr("USERTYPE","<%=retInfos[15].trim()%>");
	    	
			MAXOUTNUM.value = "<%=retInfos[16]%>";
			CUROUTNUM.value = "<%=retInfos[17]%>";
			OUTGRP.value = "<%=retInfos[18]%>";
	    	
			var feeflagDB = "<%=retInfos[19]%>";
			if( feeflagDB.length >=4 )
			{
				fillSelectUseValue_noArr("FEEFLAG1",feeflagDB.substring(0,1) );
				fillSelectUseValue_noArr("FEEFLAG2",feeflagDB.substring(1,2) );
				fillSelectUseValue_noArr("FEEFLAG3",feeflagDB.substring(2,3) );
				fillSelectUseValue_noArr("FEEFLAG4",feeflagDB.substring(3,4) );
			}
	    	
			LMTFEE.value = "<%=retInfos[20]%>";
			CURPKG.value ="<%=retInfos[21]%>";
			CPKGNAME.value = "<%=retInfos[22]%>";
			NEXTPKG.value ="<%=retInfos[25]%>";
			NPKGNAME.value = "<%=retInfos[26]%>";
	    	
			fillSelectUseValue_noArr("ISDNTYPE","<%=retInfos[27].trim()%>" );
	    	
			STARTTIME.value = "<%=retInfos[28]%>";
			fillSelectUseValue_noArr("CURFEETYPE", "<%=retInfos[23]%>" );
			fillSelectUseValue_noArr("FEETYPE","<%=retInfos[24]%>" );
		}
	}

	function call_FLAGS()
	{

	   var h=480;
	   var w=750;
	   var t=screen.availHeight/2-h/2;
	   var l=screen.availWidth/2-w/2;
	   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

	   var str=window.showModalDialog('user_flags.jsp?flags='+document.frm.FLAGS.value,"",prop);


		return true;

	}

//-->
</script>

</head>

<body onLoad="init()" >
<form name="frm" method="post" action="">
<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">查询:基本信息</div>
	</div>	

		<table cellspacing="0" >
		  <tr >
			<td class="blue">集团号</td>
			<td><input name="GRPID" type="text" class="button" id="GRPID"></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr >
			<td class="blue">短号</td>
			<td ><input name="qryNo" type="text" class="button" id="PHONENO" readonly></td>
			<td class="blue">真实号码</td>
			<td><input name="ISDNNO" type="text" class="button" id="ISDNNO" readonly></td>
		  </tr>
		  <tr >
			<td class="blue">用户姓名</td>
			<td><input name="USERNAME" type="text" class="button" id="USERNAME" maxlength="18"></td>
			<td>证件号码:</td>
			<td><input name="IDCARD" type="text" class="button" id="IDCARD" maxlength="36"></td>
		  </tr>
		  <tr >
			<td class="blue">用户部门</td>
			<td ><input name="DEPT" type="text" class="button" id="DEPT" maxlength="36">
			</td>
			<td class="blue">描述信息</td>
			<td ><input name="PCOMMENT" type="text" class="button" id="PCOMMENT2" maxlength="36"></td>
		  </tr>
		  <tr >
			<td class="blue" >闭合群号1</td>
			<td  ><input name="CLOSENO1" type="text" class="button" id="CLOSENO1" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="闭合群号1">
			</td>
			<td>闭合群号2</td>
			<td ><input name="CLOSENO2" type="text" class="button" id="CLOSENO2" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="闭合群号2">
			</td>
		  </tr>
		  <tr >
			<td class="blue">闭合群号3</td>
			<td ><input name="CLOSENO3" type="text" class="button" id="CLOSENO3" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="闭合群号3">
			</td>
			<td class="blue">闭合群号4</td>
			<td><input name="CLOSENO4" type="text" class="button" id="CLOSENO4" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="闭合群号4">
			</td>
		  </tr>
		  <tr >
			<td class="blue" >闭合群号5</td>
			<td  ><input name="CLOSENO5" type="text" class="button" id="CLOSENO5" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="闭合群号5">
			</td>
			<td>&nbsp;</td>
			<td >&nbsp;</td>
		  </tr>
		  <tr >
			<td class="blue" >用户封锁标志</td>
			<td ><select name="LOCKFLAG" class="button" id="LOCKFLAG">
				<option value="00" selected>00--&gt;去封锁</option>
				<option value="10">10--&gt;封锁</option>
			  </select></td>
			<td>用户功能权限集</td>
			<td><input name="FLAGS" type="text"  class="button" id="FLAGS" size="36" maxlength="36">
			<input name="updateFlags" type="button" class="button" id="updateFlags" value="详细信息" onClick="call_FLAGS()">
			</td>
		  </tr>
		  <tr >
			<td colspan="4" class="blue">状态变量集</td>
		  </tr>
		  <tr >
			<td colspan="4" >
				<table>
				<tr>
				  <td>个人付费放音标志</td>
				  <td><select name="STATUS1" id="STATUS1">
					  <option value="0">0--&gt;未放音</option>
					  <option value="1">1--&gt;已放音</option>
					</select></td>
				  <td>语言种类</td>
				  <td><select name="STATUS2" id="STATUS2">
					  <option value="0">0--&gt;未设置语种</option>
					  <option value="1">1--&gt;普通话</option>
					  <option value="2">2--&gt;英语</option>
					  <option value="3">3--&gt;地方话</option>
					</select></td>
				  <td>主叫号码显示方式</td>
				  <td><select name="STATUS3" id="STATUS3">
					  <option value="1">1--&gt;显示短号</option>
					  <option value="2">2--&gt;显示真实号码</option>
					  <option value="3">3--&gt;PBX主叫显示真实号码</option>
					  <option value="4">4--&gt;其余主叫显示短号</option>
					</select></td>
				</tr>
			  </table></td>
		  </tr>
		  <tr >
			<td class="blue">用户类型</td>
			<td><select name="USERTYPE" id="USERTYPE">
				<option value="0" selected>0--&gt;普通用户</option>
				<option value="1">1--&gt;管理员</option>
				<option value="2">2--&gt;话务员</option>
				<option value="3">3--&gt;管理员+话务员</option>
			  </select></td>
			<td class="blue">网外号码组</td>
			<td><input name="OUTGRP" type="text" class="button" id="OUTGRP" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="网外号码组">
			</td>
		  </tr>
		  <tr >
			<td class="blue" >最大网外号码数</td>
			<td ><input name="MAXOUTNUM" type="text" class="button" id="MAXOUTNUM" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="最大网外号码数">
			</td>
			<td>当前网外号码数:</td>
			<td><input name="CUROUTNUM" type="text" class="button" id="CUROUTNUM"></td>
		  </tr>
		  <tr >
			<td colspan="4">费用限额标志</td>
		  </tr>
		  <tr >
			<td colspan="4" ><table>
				<tr>
				  <td>网内</td>
				  <td><select name="FEEFLAG1" id="FEEFLAG1">
					  <option value="0" selected>0--&gt;集团付费且限额</option>
					  <option value="1">1--&gt;个人付费不限额</option>
					</select></td>
				  <td>网间</td>
				  <td><select name="FEEFLAG2" id="FEEFLAG2">
					  <option value="0">0--&gt;集团付费且限额</option>
					  <option value="1" selected>1--&gt;个人付费不限额</option>
					</select></td>
				  <td>网外主叫</td>
				  <td><select name="FEEFLAG3" id="FEEFLAG3">
					  <option value="0">0--&gt;集团付费且限额</option>
					  <option value="1" selected>1--&gt;个人付费不限额</option>
					</select></td>
				  <td>网外号码组</td>
				  <td><select name="FEEFLAG4" id="FEEFLAG4">
					  <option value="0">0--&gt;集团付费且限额</option>
					  <option value="1" selected>1--&gt;个人付费不限额</option>
					</select></td>
				</tr>
			  </table></td>
		  </tr>
		  <tr >
			<td class="blue">月费用限额</td>
			<td><input name="LMTFEE" type="text" class="button" id="LMTFEE" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="月费用限额">
			</td>
			<td>&nbsp;</td>
			<td>&nbsp; </td>
		  </tr>
		  <tr  id="SHOWADD3">
			<td class="blue" >当月资费套餐类型</td>
			<td ><input name="CURPKG" type="text" class="button" id="CURPKG">
			</td>
			<td class="blue">当月资费套餐名称</td>
			<td><input name="CPKGNAME" type="text" class="button" id="CPKGNAME"></td>
		  </tr>
		  <tr >
			<td class="blue">下月资费套餐类型</td>
			<td ><input name="NEXTPKG" type="text" class="button" id="NEXTPKG2">
			</td>
			<td class="blue">下月资费套餐名称</td>
			<td ><input name="NPKGNAME" type="text" class="button" id="NPKGNAME"></td>
		  </tr>
		  <tr >
			<td class="blue">电话类型</td>
			<td><select name="ISDNTYPE" id="ISDNTYPE">
				<option value="1">1--&gt;固定电话</option>
				<option value="2">2--&gt;移动PPS</option>
				<option value="3">3--&gt;全球通PPS</option>
				<option value="4">4--&gt;全球通普通帐户</option>
				<option value="5">5--&gt;联通PPS</option>
				<option value="6">6-&gt;联通普通帐户</option>
				<option value="7">7--&gt;联通CDMA </option>
				<option value="8">8--&gt;PBX</option>
				<option value="9">9--&gt;寻呼机</option>
				<option value="10">10--&gt;联通CDMA PPC用户</option>
			  </select></td>
			<td class="blue">开户时间</td>
			<td><input name="STARTTIME" type="text" class="button" id="STARTTIME"></td>
		  </tr>
		  <tr >
			<td class="blue">当月用户品牌</td>
			<td ><select name="CURFEETYPE" id="CURFEETYPE">
				<option value="0">0--&gt;没有品牌</option>
				<option value="1">1--&gt;全球通</option>
				<option value="2">2--&gt;金卡神州行</option>
				<option value="3">3--&gt;品牌3</option>
				<option value="4">4--&gt;品牌4 </option>
				<option value="5">5--&gt;品牌5</option>
			  </select></td>
			<td class="blue">下月用户品牌</td>
			<td ><select name="FEETYPE" id="FEETYPE">
				<option value="0">0--&gt;没有品牌</option>
				<option value="1">1--&gt;全球通</option>
				<option value="2">2--&gt;金卡神州行</option>
				<option value="3">3--&gt;品牌3</option>
				<option value="4">4--&gt;品牌4 </option>
				<option value="5">5--&gt;品牌5</option>
			  </select></td>
		  </tr>
		  <tr >
			<td colspan="4" id="footer"> <div align="center"> &nbsp; &nbsp; &nbsp;
				<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
				&nbsp; </div></td>
		  </tr>
		</table>


	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
	<input type="hidden" name="loginName" id="loginName" value="">
	<input type="hidden" name="opCode" id="opCode" value="">
	<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">
	<input type="hidden" name="org_id"  value="<%=OrgId%>">
	<input type="hidden" name="group_id"  value="<%=GroupId%>">
			<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>


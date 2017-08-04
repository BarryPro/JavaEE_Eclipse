<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-25 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%
comImpl comResult = new comImpl();
	String opCode = "8002";
	String opName = "工号管理";

	String regionCode2= (String)session.getAttribute("regCode");
	String workNo1 = (String)session.getAttribute("workNo");

	String dWorkNo = (String)session.getAttribute("workNo");
	String dNopass = (String)session.getAttribute("password");
	ArrayList arr1 = (ArrayList)session.getAttribute("allArr");
	
	String sql2 = "SELECT power_right,right_name FROM spowervaluecode";
//	ArrayList powerRightArr = RoleManageWrapper.getPowerRight();
	ArrayList powerRightArr = comResult.spubqry32("2",sql2);
//	ArrayList powerRightArr = RoleManageWrapper.getPowerRight();

	String sql1 = "SELECT region_code,region_name,login_region FROM sregioncode";
	

	ArrayList regionArr     = comResult.spubqry32("2",sql1);
//	ArrayList regionArr     = RoleManageWrapper.getRegionCode();
	
	
	String sql4 = "SELECT rpt_right,right_name FROM srptright";
//	ArrayList rptArr = RoleManageWrapper.getRptCode();
	ArrayList rptArr = comResult.spubqry32("2",sql4);
	//ArrayList rptArr        = RoleManageWrapper.getRptCode();
	
	String sql3 = "SELECT login_flag,flag_name,login_name,config_flag FROM slogintype where config_flag = 'Y'";
//	ArrayList typeArr = RoleManageWrapper.getLoginType();
	ArrayList typeArr = comResult.spubqry32("2",sql3);
//	ArrayList typeArr       = RoleManageWrapper.getLoginType();

	String[][] loginTypeStr = (String[][])typeArr.get(0);
	String powerCode      = (String)session.getAttribute("powerCode");
	String[][] powerRight = (String[][])powerRightArr.get(0);
	String[][] regionCode = (String[][])regionArr.get(0);
	String[][] rptCode    = (String[][])rptArr.get(0);

	String loginNo        = request.getParameter("workNo");
	String contractPhone  = request.getParameter("contractPhone");
	String loginName      = request.getParameter("loginName");
	String power_code     = request.getParameter("powerCode");
	String powerName      = request.getParameter("powerName");
	String power_right    = request.getParameter("powerRight");
	String loginFlag      = request.getParameter("loginFlag");
	String opTime         = request.getParameter("opTime");
	String rptRight       = request.getParameter("rptRight");
	String allowBegin     = request.getParameter("allowBegin");
	String allowEnd       = request.getParameter("allowEnd");
	String passTime       = request.getParameter("passTime");
	String expireTime     = request.getParameter("expireTime");
	String tryTimes       = request.getParameter("tryTimes");
	String vilidFlag      = request.getParameter("vilidFlag");
	String maintainFlag   = request.getParameter("maintainFlag");
	String orgCode        = request.getParameter("orgCode");

	StringBuffer sb       = new StringBuffer(orgCode);
	String region_code    = sb.substring(0,2);
	String dis_code       = sb.substring(2,4);
	String town_code      = sb.substring(4,7);
	String orgNo          = sb.substring(7,orgCode.length());
	String deptCode       = request.getParameter("deptCode");
	String loginStatus    = request.getParameter("loginStatus");
	String ipAddress      = request.getParameter("ipAddress");
	String runTime        = request.getParameter("runTime");
	String reloginFlag    = request.getParameter("reloginFlag");
	String otherFlag      = request.getParameter("otherFlag");
	String sendFlag       = request.getParameter("sendFlag");
	String ipFlag         = request.getParameter("ipFlag");
	String maxErr         = request.getParameter("maxErr");
	String accountType    = request.getParameter("accountType");
	String groupId        = request.getParameter("groupId");
	String SEQ_MailCode   = request.getParameter("SEQ_MailCode"); //20100317 add
  String MailCodeAddr   = loginNo + SEQ_MailCode +"@hl.chinamobile.com";//20100317 add
  String accountName   = request.getParameter("accountName"); //liyan 20100103 自助缴费机
  String reject_flag    	 = request.getParameter("reject_flag");//add 工号操作在实收报表中剔除@2014/3/10 
  
	String accTypeName = "营业类BOSS帐号";


	if(accountType.equals("2"))
	{
		accTypeName = "客服类BOSS帐号";
	}
	else
	{
		accTypeName = "管理类BOSS帐号";
	}
	
	String sql5 = "SELECT region_code,district_code,district_name,login_district FROM sdiscode WHERE region_code='"+region_code+"'";
//	ArrayList disArrInit = RoleManageWrapper.getDisCode(region_code);
	ArrayList disArrInit = comResult.spubqry32("2",sql5);
	String[][] disCodeInit = (String[][])disArrInit.get(0);
	
	String sql6 = "SELECT town_code,town_name,login_town,region_code,district_code FROM stowncode WHERE district_code='"+dis_code+"' and region_code='"+region_code+"'";
//	ArrayList townArrInit = RoleManageWrapper.getTownCode(region_code,dis_code);
	
	ArrayList townArrInit = comResult.spubqry32("2",sql6);
	String[][] townCodeInit = (String[][])townArrInit.get(0);

	String groupName="";

	if(!accountType.equals("1"))
	{
		//comImpl comim=new comImpl();
		String strSql = "select group_name from dChnGroupMsg where group_id = '" + groupId + "'";
		//ArrayList arrGrpName = comim.spubqry32("1",strSql);
		%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode2%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=strSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="arrGrpName" scope="end" />
	<%
		//System.out.println("++++++++"+strSql+"++++++++");
		String[][] strGroupName = arrGrpName;
		groupName=strGroupName[0][0];
	}
/*	System.out.println("-----------------liyan--------------");
	System.out.println("power_code="+power_code);
	System.out.println("powerCode="+powerCode);
*/
	int	powerFlag = power_code.trim().length() - powerCode.trim().length();
	//System.out.println("powerFlag="+powerFlag);
	boolean	regionFlag = false;
	/* 20090922 liyan modify
	if( ! powerCode.trim().equals("01"))
	{
		//System.out.println("workNo1.substring(0,2)="+workNo1.substring(0,2));
		//System.out.println("region_code="+region_code);
		if(!workNo1.substring(0,2).equals(region_code))
			regionFlag = true;
	}
	 */
	System.out.println("liyan----------regionCode2="+regionCode2 + ",orgCode="+orgCode+",region_code="+region_code);
	if( ! powerCode.trim().equals("01"))
	{
		if(regionCode2.equals(region_code))
			regionFlag = false;
	}

	 System.out.println("-----------------liyan-----regionFlag="+regionFlag);
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
		for(var i = 0 ; i < backString.length ; i ++){
			arr[i] = "<OPTION value="+backString[i][0]+">" + backString[i][1] + "</OPTION>";
		}
		if(flag=="0"){
			disCodeDiv.innerHTML = "<select id=disCode size=1 name=disctrictCode onchange=callTownCode()>" + arr.join() + "</SELECT>";
			callTownCode();
		}
		if(flag=="1"){
		  	townCodeDiv.innerHTML = "<select id=tCode size=1 name=townCode>" + arr.join() + "</SELECT>";
		}
		if(flag=="9"){
			rdShowMessageDialog(backString[1][0]);
			//opener.top.location="f8002.jsp";
			window.close();
		}
	}
	//根据地区代码查询地市代码
	function callDisCode()
	{
		var i = 0;
		var regionCode = 0;
		for(i = 0 ; i < document.frm.regionCode.length ; i ++){
			if(document.frm.regionCode.options[i].selected){
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

	function submitt()
	{
		if(!checkElement(document.frm.contractPhoneNo)){
			return false;
		}
		if(document.frm.loginName.value.length=="0")
		{
			rdShowMessageDialog("请输入工号名称!");
			return;
		}
		if(forDate(document.frm.allowBegin)==false)
		{
			return;
		}
		if(forDate(document.frm.expireTime)==false)
		{
			return;
		}
		if(forDate(document.frm.allowEnd)==false)
		{
			return;
		}

		if(document.frm.ydeptCode.value.length==0)
		{
			document.frm.ydeptCode.value="";
		}

		var radioJ = 0;
		for(radioJ = 0 ; radioJ < document.frm.validFlag.length ; radioJ ++)
		{
			if(document.frm.validFlag[radioJ].checked)
			{
				document.frm.valid_flag.value = document.frm.validFlag[radioJ].value;
			}
		}
		var radioK = 0;
		for(radioK = 0 ; radioK < document.frm.maintainFlag.length ; radioK++)
		{
			if(document.frm.maintainFlag[radioK].checked)
			{
				document.frm.maintain_flag.value = document.frm.maintainFlag[radioK].value;
			}
		}
		var flagI = 0 ;
		for(flagI = 0 ; flagI < document.frm.loginFlag.length ; flagI ++)
		{
			if(document.frm.loginFlag.options[flagI].selected)
			{
				document.frm.login_flag.value = document.frm.loginFlag.options[flagI].value;
			}
		}

		var powerRightI = 0 ;
		for(powerRightI = 0 ; powerRightI < document.frm.powerRight.length ; powerRightI ++)
		{
			if(document.frm.powerRight.options[powerRightI].selected)
			{
				document.frm.power_right.value = document.frm.powerRight.options[powerRightI].value;
			}
		}
		var rptRightI = 0 ;
		for(rptRightI = 0 ; rptRightI < document.frm.rptRight.length ; rptRightI ++)
		{
			if(document.frm.rptRight.options[rptRightI ].selected)
			{
				document.frm.rpt_right.value = document.frm.rptRight.options[rptRightI ].value;
			}
		}
		if(document.frm.accType.value=="1")
		{
			if(document.frm.orgNo.value.length==0)
			{
				rdShowMessageDialog("请输入编号！");
				return;
			}
			var regionCodeI = 0 ;
			for(regionCodeI = 0 ; regionCodeI < document.frm.regionCode.length ; regionCodeI ++)
			{
				if(document.frm.regionCode.options[regionCodeI].selected)
				{
					document.frm.region_code.value = document.frm.regionCode.options[regionCodeI].value;
				}
			}
			var disctrictCodeI = 0 ;
			for(disctrictCodeI = 0 ; disctrictCodeI < document.frm.disctrictCode.length ; disctrictCodeI ++)
			{
				if(document.frm.disctrictCode.options[disctrictCodeI].selected)
				{
					document.frm.disctrict_code.value = document.frm.disctrictCode.options[disctrictCodeI].value;
				}
			}
			var townCodeI = 0 ;
			for(townCodeI = 0 ; townCodeI < document.frm.townCode.length ; townCodeI ++)
			{
				if(document.frm.townCode.options[townCodeI].selected)
				{
					document.frm.town_code.value = document.frm.townCode.options[townCodeI].value;
				}
			}
			document.frm.org_code.value=document.frm.region_code.value+document.frm.disctrict_code.value+
				document.frm.town_code.value+document.frm.orgNo.value;
		}

		var reFlagI = 0 ;
		for(reFlagI = 0 ; reFlagI < document.frm.reFlag.length ; reFlagI ++){
			if(document.frm.reFlag.options[reFlagI].selected){
				document.frm.re_flag.value = document.frm.reFlag.options[reFlagI].value;
			}
		}
		var otherFlagI = 0 ;
		for(otherFlagI = 0 ; otherFlagI < document.frm.otherFlag.length ; otherFlagI ++)
		{
			if(document.frm.otherFlag.options[otherFlagI].selected)
			{
				document.frm.other_flag.value = document.frm.otherFlag.options[otherFlagI].value;
			}
		}
		var loginStatusI = 0 ;
		for(loginStatusI = 0 ; loginStatusI < document.frm.loginStatus.length ; loginStatusI ++)
		{
			if(document.frm.loginStatus.options[loginStatusI].selected)
			{
			 document.frm.login_status.value = document.frm.loginStatus.options[loginStatusI].value;
			}
		}
		
		var reject_flagI = 0 ;
		for(reject_flagI = 0 ; reject_flagI < document.frm.reject_flag.length ; reject_flagI ++)
		{
			if(document.frm.reject_flag.options[reject_flagI].selected)
			{
			 document.frm.reject_flag.value = document.frm.reject_flag.options[reject_flagI].value;
			}
		}
		
		if(!forDate(document.frm.allowBegin)){
			rdShowMessageDialog("开始时间格式不正确");
			return false;
	    }
	    if(!forDate(document.frm.allowEnd)){
	    	rdShowMessageDialog("结束时间格式不正确");
			return false;
	    }
	    if(compareDates(document.frm.allowBegin,document.frm.allowEnd) != 0){
	    	rdShowMessageDialog("开始时间不能大于结束时间");
			return false;
        }
	    if($("#oaNumber").val()==""){
			rdShowMessageDialog("请输入OA编号！");
			return;
		}
		if($("#oaTitle").val()==""){
			rdShowMessageDialog("请输入OA标题！");
			return;
		}
		document.frm.submit.disabled=true;
		var myPacket = new AJAXPacket("newSubmit.jsp?loginName="+document.frm.loginName.value+"&remark="+document.frm.remark.value,"正在提交，请稍候......");
		myPacket.data.add("workNo",document.frm.work_no.value);
		myPacket.data.add("nopass",document.frm.nopass.value);
		myPacket.data.add("opCode",document.frm.op_code.value);
		myPacket.data.add("opType",document.frm.op_type.value);
		myPacket.data.add("loginNo",document.frm.loginNo.value);
		myPacket.data.add("loginFlag",document.frm.login_flag.value);
		myPacket.data.add("contractPhoneNo",document.frm.contractPhoneNo.value);
		myPacket.data.add("loginPass",document.frm.loginPass.value);
		myPacket.data.add("powerCode",document.frm.power_code.value);
		myPacket.data.add("powerRight",document.frm.power_right.value);
		myPacket.data.add("rptRight",document.frm.rpt_right.value);
		myPacket.data.add("allowBegin",document.frm.allowBegin.value);
		myPacket.data.add("allowEnd",document.frm.allowEnd.value);
		myPacket.data.add("expireTime",document.frm.expireTime.value);
		myPacket.data.add("tryTimes",document.frm.tryTimes.value);
		myPacket.data.add("maintainFlag",document.frm.maintain_flag.value);
		myPacket.data.add("validFlag",document.frm.valid_flag.value);
		myPacket.data.add("orgCode",document.frm.org_code.value);
		myPacket.data.add("deptCode",document.frm.ydeptCode.value);
		myPacket.data.add("lastIpAdd",document.frm.selfIpAddr.value);
		myPacket.data.add("reFlag",document.frm.re_flag.value);
		myPacket.data.add("otherFlag",document.frm.other_flag.value);
		myPacket.data.add("loginStatus",document.frm.login_status.value);
		myPacket.data.add("ipFlag",document.frm.ipFlag.value);
		myPacket.data.add("sendFlag",document.frm.sendFlag.value);
		myPacket.data.add("maxErr",document.frm.maxErr.value);
		myPacket.data.add("AccountNo",document.frm.loginNo.value);
		myPacket.data.add("regionChar",document.frm.otherFlag.value);
		myPacket.data.add("AccountType",document.frm.accountType.value);
		myPacket.data.add("groupId",document.frm.groupId.value);
		myPacket.data.add("reject_flag",document.frm.reject_flag.value);
		myPacket.data.add("oaNumber",$("#oaNumber").val());
		myPacket.data.add("oaTitle",$("#oaTitle").val());
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}

	/* the follow function is created by wangxj on 2004/02/25 */
	function getDptCode()
	{
		var regionCode = document.frm.regionCode.value;
		var townCode = document.frm.townCode.value;
		var typeCode = document.frm.loginFlag.value;
		if(typeCode=="3")
		{
			townCode="005";
			regionCode="00";
		}
		if(regionCode!="0x")
			window.open("../../../callcenter/ccpage/pub/dptTreeToYY.jsp?regionCode="+regionCode+"&townCode="+townCode,"","height=500,width=500,scrollbars=yes");
	}
	/* created end */
	function ifModifyLoginType()
	{
		var flagJ = 0 ;
		for(flagJ = 0 ; flagJ < document.frm.loginFlag.length ; flagJ ++)
		{
			if(document.frm.loginFlag.options[flagJ].selected)
			{
				var modifyTypeValue = document.frm.loginFlag.options[flagJ].type_value;
				if(modifyTypeValue=="k")
				{
					document.frm.loginFlag.options[0].selected=true;
					rdShowMessageDialog("该工号类型不能修改为'客服中心'！");
					return;
				}
			}
		}
	}

	function setPowerInfo()
	{
		var loginNo1 = document.frm.loginNo.value;
		var roleCode = document.frm.power_code.value;
		var roleName = document.frm.power_name.value;
		var win = window.open('f8058_setpdmain.jsp?loginNo1='+loginNo1+'&roleCode='+roleCode+'&roleName='+roleName,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}

	//选择角色
	function queryPowerCode(str)
	{
		var path = "roletree.jsp?formFlag="+str+"&CodeType=power_code&NameType=power_name";
		window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	}
</script>
</HEAD>
<body>
      <form name="frm">
      		<%@ include file="/npage/include/header_pop.jsp" %>
		<div class="title">
			<div id="title_zi">修改信息</div>
		</div>
		<table id=tbs9  cellspacing=0>
			<tr>
			 	<td width="18%" class="blue">&nbsp;帐号代码</td>
				<td width="32%">
					<input  id=part1 type=text size=24 name=loginNo value="<%=loginNo%>" disabled >
				</td>
				<td width="18%" class="blue">&nbsp;帐号类型</td>
				<td width="32%">
					<select id=idAccountType size=1 name=accountType>
						<option value="<%=accountType%>" selected >
							<!--%=accTypeName%--><%=accountName%><!--20100613 modify wangyua-->
						</option>
					</select>

				</td>
			</tr>
			<tr>
				<td width="18%"  class="blue">&nbsp;工号名称</td>
				<td width="32%" >
					<input  id=part2  type=text size=24 name=loginName value="<%=loginName%>"  >
				</td>
				<td width="18%" class="blue">&nbsp;工号类型</td>
				<td width="32%" >
					<select id=part3 size=1 name=loginFlag onchange=ifModifyLoginType()>
					<%-- <%for(int i = 0 ; i < loginTypeStr.length ; i ++){%>
					<option value="<%=loginTypeStr[i][0]%>" type_value="<%=loginTypeStr[i][2]%>"
						<%if(loginFlag.equals(loginTypeStr[i][0])){%> selected <%}%>><%=loginTypeStr[i][1]%></option>
					<%}%> --%>
						<option value="2" type_value="UnKnown">功号签退</option>
						<option value="3" type_value="UnKnown">功号平帐</option>
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
		<script>
			var flagZ = 0 ;
			for(flagZ = 0 ; flagZ < document.frm.loginFlag.length ; flagZ ++)
			{
				if(document.frm.loginFlag.options[flagZ].selected)
				{
					var typeValueZ = document.frm.loginFlag.options[flagZ].type_value;
					if(typeValueZ == "k")
					{
						document.frm.loginFlag.disabled=true;
					}
				}
			}
		</script>

	<div id=mainTable>
		<TABLE  cellSpacing=0>
			<TBODY>
				<tr  <%if(accountType.equals("2")){%> style=display='none' <%}%>>
					<td width="18%" class="blue">&nbsp;角色代码</td>
					<td colspan="2" >
						<input type=text  v_type="string"  v_must=1  v_name="角色代码"
							name=power_code  maxlength=10 size="10" value="<%=power_code%>" readonly class="InputGrey">
						<input type=text  name=power_name value="<%=powerName%>" size=22 maxlength=10 readonly class="InputGrey">
					</td>
					<td width="18%">
						<input class="b_text" type="button" name="query_powercode" onclick="queryPowerCode('frm')" value="选择"> &nbsp;
						<input class="b_text" type=button  name=creatNo value="分配权限" <% if(accountType.equals("2")) {%> style="display:none'"<%}%> onclick="setPowerInfo()">
					</td>
				</tr>
				<tr>
					<td width="18%" class="blue">&nbsp;权限值</td>
					<td width="32%" >
						<select id=part7 size=1 name=powerRight  >
						<%for(int i = 0 ; i<powerRight.length; i ++)
						{
						%>
						<option value="<%=powerRight[i][0]%>"
							<%if(power_right.trim().equals(powerRight[i][0].trim())){%> selected <%}%>>
							<%=powerRight[i][0]+"->"+powerRight[i][1]%>
						</option>
						<%}%>
						</select>
					</td>
					<td  width="18%" class="blue">报表权限</td>
					<td width="32%">
						<select id=part8 size=1 name=rptRight  >
							<%for(int i = 0 ; i < rptCode.length; i ++){%>
							<option value="<%=rptCode[i][0]%>"
								<%if(rptRight.trim().equals(rptCode[i][0].trim())){%> selected <%}%>><%=rptCode[i][1]%></option>
							<%}%>
						</select>
		            		</td>
		          	</tr>
	          	</TBODY>
        	</TABLE>
	        <TABLE cellSpacing=0>
	          <TBODY>
		          <tr>
			            <td width="18%" class="blue">&nbsp;登陆允许时间</td>
			            <td width="32%" >
			              <input  id=part9 type=text size=20 name=allowBegin v_format="yyyyMMdd HH:mm:ss" onblur="forDate(this)" value="<%=allowBegin%>"  >
			              <input  id=part20 type=hidden size=2 name=allowBeginMonth>
			              <input 1 id=part21 type=hidden size=2 name=allowBeginDate>
			              <input 1 id=part22 type=hidden size=2 name=allowBeginHour>
			              <input 1 id=part23 type=hidden size=2 name=allowBeginMinute>
			              <input 1 id=part24 type=hidden size=2 name=allowBeginSecond>
			            </td>
			            <td width="18%" class="blue" >登陆允许结束时间&nbsp; </td>
			            <td width="32%"  >
			              <input  id=part10 type=text size=20 name=allowEnd v_format="yyyyMMdd HH:mm:ss" onblur="forDate(this)" value="<%=allowEnd%>" >
			              <input 1 id=part25 type=hidden size=2 name=allowEndMonth>
			              <input 1 id=part26 type=hidden size=2 name=allowEndDate>
			              <input 1 id=part27 type=hidden size=2 name=allowEndHour>
			              <input 1 id=part28 type=hidden size=2 name=allowEndMinute>
			              <input 1 id=part29 type=hidden size=2 name=allowEndSecond>
			            </td>
		          </tr>
	          </TBODY>
	        </TABLE>
	        <TABLE cellSpacing=0>
		          <TBODY>
			          <tr>
				            <td width="18%" class="blue">&nbsp;密码到期时间</td>
				            <td width="32%" >
				              <input  id=part11 type=text size=20 v_format="yyyyMMdd HH:mm:ss" name=expireTime value="<%=expireTime%>"  readonly class="InputGrey">
				             <input 1 id=part30 type=hidden size=2 name=expireTimeMonth>
				             <input 1 id=part31 type=hidden size=2 name=expireTimeDate>
				             <input 1 id=part32 type=hidden size=2 name=expireTimeHour>
				             <input 1 id=part33 type=hidden size=2 name=expireTimeMinute>
				             <input 1 id=part34 type=hidden size=2 name=expireTimeSecond>
				            </td>
				            <td width="18%"  class="blue">当前登陆次数</td>
				            <td width="32%">
				              <input  id=part12 type=text size=20 name=tryTimes disabled value="<%=tryTimes.trim()%>">
				            </td>
			          </tr>
		          </TBODY>
	        </TABLE>
	        <TABLE cellSpacing=0>
		          <TBODY>
		          <tr >
		            <td width="18%" class="blue">&nbsp;工号有效标志</td>
		            <td width="16%" >
		              <input id=radio1 type=radio name=validFlag value=1
		              	<%if(vilidFlag.trim().equals("1")){%> checked <%}%>> 有效 </td>
		            <td width="16%" >
		              <input id=radio1 type=radio name=validFlag value=0
		              	<%if(vilidFlag.trim().equals("0")){%> checked <%}%>> &nbsp; 无效 </td>
		            <td width="18%" class="blue">系统维护标志&nbsp; </td>
		            <td width="16%" >
		              <input id=radio type=radio name=maintainFlag value=1
		              	<%if(maintainFlag.trim().equals("1")){%> checked <%}%>>&nbsp; 维护工号 </td>
		            <td width="16%" >
		              <input id=radio type=radio name=maintainFlag value=0
		              	<%if(maintainFlag.trim().equals("0")){%> checked <%}%>>&nbsp; 非维护工号 </td>
		          </tr>
		          </TBODY>
	        </TABLE>

		<TABLE  cellSpacing=0>
			<tbody>
			<%
			if(accountType.equals("1"))
			{
			%>
			<tr >
				<td width="18%" nowrap class="blue">&nbsp;地&nbsp;&nbsp;区</td>
				<td width="32%" nowrap >
					<select id=part13 size=1 name=regionCode onchange="callDisCode()"  disabled >
				<%for(int i = 0 ; i < regionCode.length; i ++)
				{
				%>
					<option value="<%=regionCode[i][0]%>"
						<%if(region_code.trim().equals(regionCode[i][0])){%> selected <%}%>><%=regionCode[i][1]%>
					</option>
				<%}%></select>
				</td>
				<td width="18%" nowrap class="blue">市&nbsp;&nbsp;县</td>
				<td width="32%" >
				<div id=disCodeDiv><select id=disCode size=1 name=disctrictCode onchange="callTownCode()"  disabled >
				            <%-- <%for(int i = 0 ; i < disCodeInit.length ; i ++)
				            {%>
								<option value="<%=disCodeInit[i][1]%>" <%if(dis_code.trim().equals(disCodeInit[i][1])){%> selected <%}%>><%=disCodeInit[i][2]%></option>
					   <%}%> --%>
					   <option value="02" pvalue="b">呼兰 </option>
									<option value="03" pvalue="c">阿城</option>
				</select>
				</div>
				</td>
			</tbody>
		</table>
		<table id="tbRegion2" style="display"  cellSpacing=0>
		<tbody>
			<tr>
				<td width="18%" nowrap class="blue">&nbsp;营业厅</td>
	            		<td width="56%" >
					<div id=townCodeDiv>
						<select id=tCode size=1 name=townCode  disabled >
						<%for(int i = 0 ; i < townCodeInit.length ; i ++)
						{%>
							<option value="<%=townCodeInit[i][0]%>"
								<%if(town_code.trim().equals(townCodeInit[i][0])){%> selected <%}%>><%=townCodeInit[i][1]%></option>
						<%}%>
						</select>
					</div>

				</td>
				<td wodth="26%">
					<input  id=part14  type=hidden size=10 name=orgNo value="<%=orgNo%>"  >
					<input type="hidden" name="groupId" value="<%=groupId%>">
				</td>
			</tr>
		<%
		}
		else
		{
		%>
		<table width="100%" height=27 border=0 align="center" cellpadding="3" cellSpacing=1>
		<tbody>
			<tr id="trGroupId" >
				<td width="18%" nowrap class="blue"> &nbsp;组织节点名称</td>
				<td width="32%" nowrap>
					<input type="hidden" name="groupId" value="<%=groupId%>">
					<input  id=part36 type=text size=30 name=groupName value="<%=groupName%>" disabled >
				</td>
				<td width="18%" nowrap > &nbsp;</td>
				<td width="32%" nowrap > &nbsp;</td>
			</tr>
		<%}%>
	        </tbody>
	        </table>

	        <TABLE  cellSpacing=0>
	          <TBODY>
	          <tr>
	            <td width="18%" class="blue">&nbsp;工单归属部门</td>
	            <td width="32%" >
					<input  id=part15 type=text size=20 name=ydeptName value=" "   maxlength=5
						title="请点击文本框选择工单归属部门" onclick="getDptCode()" readonly class="InputGrey">
					<input type=hidden name=ydeptCode value="<%=deptCode%>">
				<td width="18%" class="blue"> 身份证号</td>
				<td width="32%" >
					<input  id=part15 type=text maxlength=18 size=20 name=contractPhoneNo
						value="<%=contractPhone%>" v_must="1" v_type="idcard" onblur="checkElement(this)" />
					<font class="orange">*</font>
				</td>
			</tr>
	          </TBODY>
	        </TABLE>

	        <TABLE cellSpacing=0>
	          <TBODY>
	          <tr>
	                  <td width="18%"  class="blue">&nbsp;绑定IP标志</td>
	                  <td width="32%" >
	                    <select name="ipFlag"  <%if(powerFlag <= 0 || regionFlag) out.print(" disabled");%>>
	                      <option value="Y" <%if(ipFlag.trim().equals("Y")){%> selected <%}%>>是</option>
	                      <option value="N" <%if(ipFlag.trim().equals("N")){%> selected <%}%>>否</option>
	                    </select>
	                  </td>
	                  <td width="18%" class="blue">登录IP地址</td>
	                  <td width="32%">
	                    <input  id=part16 type=text size=16 name=lastIpAdd value="<%=ipAddress%>"
	                    <%if(powerFlag <= 0 || regionFlag) out.print(" disabled");%>>
	                  </td>
	          </tr>
	          </TBODY>
	        </TABLE>

              <TABLE  cellSpacing=0>
                <TBODY>
                <tr >
                  <td width="18%" class="blue"> &nbsp;重复登陆标志</td>
                  <td width="32%">
                    <select name=reFlag id=part17  <%if(powerFlag <= 0 || regionFlag) out.print(" disabled");%>>
                      <option value="1" <%if(reloginFlag.trim().equals("1")){%> selected <%}%>>不允许</option>
                      <option value="0" <%if(reloginFlag.trim().equals("0")){%> selected <%}%>>允许</option>
                    </select>
                    <select name=loginStatus id=part18  style="display='none'">
                      <option value="1" <%if(loginStatus.trim().equals("1")){%> selected <%}%>>签到</option>
                      <option value="2" <%if(loginStatus.trim().equals("2")){%> selected <%}%>>签退</option>
                    </select>
                  </td>
                  <td width="18%" class="blue">异地受理标志</td>
                  <td width="32%" >
                    <select name=otherFlag id=part35 <%if(powerFlag <= 0 || regionFlag) out.print(" disabled");%>>
                      <option value="N" <%if(otherFlag.trim().equals("N")){%> selected <%}%>>不允许</option>
                      <option value="Y" <%if(otherFlag.trim().equals("Y")){%> selected <%}%>>允许</option>
                    </select>
                  </td>
                </tr>
                <tr >
                  <td width="18%" height="26" class="blue">&nbsp;发送密码标志</td>
                  <td width="32%"  height="26" >
                    <select name="sendFlag"  <%if(powerFlag <= 0 || regionFlag) out.print(" disabled");%>>
                      <option value="Y" <%if(sendFlag.trim().equals("Y")){%> selected <%}%>>是</option>
                      <option value="N" <%if(sendFlag.trim().equals("N")){%> selected <%}%>>否</option>
                    </select>
                  </td>
                  <td width="18%" height="26" class="blue">最大错误次数</td>
                  <td width="32%" height="26">
                    <input  id=maxErr type=text size=8 maxlength=6 name=maxErr value="<%=maxErr%>"
                    <%if(powerFlag <= 0 || regionFlag) out.print(" disabled");%>>
                  </td>
                </tr>
                </TBODY>
              </TABLE>
        </table>
				
				 <TABLE cellSpacing=0>
	          <TBODY>
	          <tr>
              <td width="22%"  class="blue">&nbsp;工号操作在实收报表中剔除</td>
              <td colspan='3' >
                <select name="reject_flag" id=part39 >
			 						<option value="0" <%if("".equals(reject_flag)){%> selected <%}%>>否</option>
			 						<option value="1" <%if(!"".equals(reject_flag)){%> selected <%}%>>是</option>
			 					</select>
              </td>
	          </tr>
	          </TBODY>
	          <tbody>
					<tr  type=hidden>
						<td width="18%" nowrap class="blue">OA编号</td>
						<td width="32%" >
							<input type="text" id="oaNumber" name="oaNumber" maxlength="30"/><font color="orange">*</font>
						</td>
						<td width="18%" nowrap class="blue">OA标题</td>
						<td width="32%" >
							<input type="text" id="oaTitle" name="oaTitle" maxlength="30"/><font color="orange">*</font>
						</td>
					</tr>
				</tbody>
	        </TABLE>
				
        <table cellspacing="0" >
          <tr>
            <td height="2">
		<tr>
			<td class="blue">&nbsp;&nbsp;备注</td>
			<td colspan="3">
				<input  id=part19 type=text readonly class="InputGrey" size=88 name=remark value=""></td>
			</td>
		</tr>
		</table>
        <TABLE  cellSpacing=0>
          <TBODY>
            <TR>
              <TD  id="footer" >
              	<input  name=submit  class="b_foot" type=button value="确认" onclick="submitt()" id=Button1>&nbsp;&nbsp;
                <input  name=back1  class="b_foot" type=button value=关闭 id=Button2 onclick="window.close()"></TD>
            </TR>
          </TBODY>
        </TABLE>


	<input type=hidden name=loginPass value="">
	<input type=hidden name=work_no value="<%=dWorkNo%>">
	<input type=hidden name=nopass value="<%=dNopass%>">
	<input type=hidden name=op_code value="8002">
	<input type=hidden name=op_type value="1">
	<input type=hidden name=login_flag value="">
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
	<input type=hidden name=other_flag value="">
	<input type=hidden name=login_status value="">
	<input type=hidden name=selfIpAddr value="<%=request.getRemoteAddr()%>">
	<input type=hidden name=accType value="<%=accountType%>">

	<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>
<%
if(accountType.equals("2"))
{
%>
<script>
	document.frm.powerRight.disabled = true;
	document.frm.rptRight.disabled = true;
	document.frm.powerRight.value = "2";
	document.frm.rptRight.value = "9";
</script>
<%
}
%>

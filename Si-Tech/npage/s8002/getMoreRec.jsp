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
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	String opCode = "8002";
	String opName = "工号管理";
	String regionCode= (String)session.getAttribute("regCode");

	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

	String workNo = (String)session.getAttribute("workNo");
	String powerCode = (String)session.getAttribute("powerCode");/* liyan add 20090922 */
	//System.out.println("8002---------------powerCode="+powerCode+",powerCode.length()="+powerCode.trim().length());
	String loginNo = request.getParameter("loginNo");
	String orgCode = request.getParameter("orgCode");
	String validFlag = request.getParameter("validFlag");
	String AccountNo = request.getParameter("AccountNo");
	String groupId = request.getParameter("groupId");
	
	//comImpl co=new comImpl();

	String sq1 = "";
	String sq2 = "";
	if(groupId.length()==0)
	{
		sq1 = "select nvl(count(*), 0) num from dLoginMsg "
			+ "where login_no like '"+loginNo+"%' "
			+ "and account_no like '"+AccountNo+"%' "
			+ "and org_code like '"+orgCode+"%' "
			+ "and vilid_flag like '"+validFlag+"%'";
		sq2 = "select * from (select my_table.*, rownum as my_rownum from "
			+ "(select a.login_no,a.login_name,a.password,a.power_code,"
			+ "a.power_right,a.login_flag,to_char(a.op_time,'yyyymmdd hh24:mi:ss'),a.rpt_right, "
			+ "to_char(a.allow_begin,'yyyymmdd hh24:mi:ss'),"
			+ "to_char(a.allow_end,'yyyymmdd hh24:mi:ss'), "
			+ "to_char(a.pass_time,'yyyymmdd hh24:mi:ss'), "
			+ "to_char(a.expire_time,'yyyymmdd hh24:mi:ss'),"
			+ "a.try_times,a.vilid_flag,a.maintain_flag,a.org_code,a.region_char,"
			+ "a.district_char,a.relogin_flag,a.dept_code,a.login_status,a.ip_address,"
			+ "to_char(a.run_time,'yymmdd hh24:mi:ss'),a.contract_phone, "
			+ "a.SENDPWD_FLAG,a.IPBIND_FLAG,a.MAX_ERRNUM,"
			+ "a.Account_no,a.account_type,a.group_id,nvl(b.power_name,'未定义'),c.Mail_Code,d.account_name,e.reject_flag "
			+ "from dLoginMsg a,sPowerCode b,dloginmsgmail c,sAccType d,(select reject_flag,reject_msg from srejectcfg where reject_type= 'RJBB' or reject_type is null) e  where a.power_code = b.power_code(+) and a.login_no = c.login_no "
			+ " and a.account_type = d.account_type " /*wangyua 2010-06-13 modify for 自助计费账号*/
			+ " and a.login_no = e.reject_msg(+) " ;/*add for 工号操作在实收报表中剔除@2014/3/12*/

		if(workNo.substring(0,1).equals("8") || workNo.substring(0,1).equals("9"))
		{
			sq2 = sq2 + " and a.account_type = '2' ";
		}

		sq2 = sq2 + "and a.login_no like '"+loginNo+"%' "
			+ "and a.account_no like '"+AccountNo+"%' and a.org_code like '"+orgCode+"%' "
			+ "and a.vilid_flag like '"+validFlag+"%' order by login_no ) my_table "
			+ "where rownum <"+iEndPos+") where my_rownum>="+iStartPos;
	}
	else
	{
		sq1 = "select nvl(count(*), 0) num from dLoginMsg where group_id = '"+groupId+"'";
		sq2 = "select * from (select my_table.*, rownum as my_rownum from "
			+ "(select a.login_no,a.login_name,a.password,a.power_code,a.power_right,a.login_flag,"
			+ "to_char(a.op_time,'yyyymmdd hh24:mi:ss'),a.rpt_right,"
			+ "to_char(a.allow_begin,'yyyymmdd hh24:mi:ss'),"
			+ "to_char(a.allow_end,'yyyymmdd hh24:mi:ss'),"
			+ "to_char(a.pass_time,'yyyymmdd hh24:mi:ss'),"
			+ "to_char(a.expire_time,'yyyymmdd hh24:mi:ss'),"
			+ "a.try_times,a.vilid_flag,a.maintain_flag,a.org_code,a.region_char,a.district_char,"
			+ "a.relogin_flag,a.dept_code,a.login_status,a.ip_address,"
			+ "to_char(a.run_time,'yymmdd hh24:mi:ss'),a.contract_phone,"
			+ "a.SENDPWD_FLAG,a.IPBIND_FLAG,a.MAX_ERRNUM,a.Account_no,a.account_type,"
			+ "a.group_id,nvl(b.power_name, '未定义'),c.Mail_Code,d.account_name,e.reject_flag "
			+ "from dLoginMsg a, sPowerCode b ,dloginmsgmail c,sAccType d, (select reject_flag,reject_msg from srejectcfg where reject_type= 'RJBB' or reject_type is null) e  "
			+ "where group_id = '" + groupId + "' and vilid_flag = "+ validFlag + " and a.login_no = c.login_no "
			+ " and a.account_type = d.account_type " /*wangyua 2010-06-13 modify for 自助计费账号*/
			+ " and a.login_no = e.reject_msg(+) " ;/*add for 工号操作在实收报表中剔除@2014/3/12*/

		if(workNo.substring(0,1).equals("8") || workNo.substring(0,1).equals("9"))
		{
			sq2 = sq2 + " and a.account_type = '2' ";
		}

		sq2 = sq2 + " and a.POWER_CODE = b.POWER_CODE(+) "
			+ "order by login_no ) my_table where rownum <"+iEndPos+") "
			+ "where my_rownum >= "+iStartPos;
	}

	//ArrayList noArr = co.spubqry32("32",sq2);
	//ArrayList allNum = co.spubqry32("1",sq1);
 	//20100317 fengry add dloginmsgmail in sq2 for 营业员邮箱需求
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="34"><!--wangyua 2010-06-13 modify for 自助计费账号*/-->
		<wtc:sql><%=sq2%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="noArr" scope="end" />

	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=sq1%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="allNum" scope="end" />
<%
	String[][] nott = noArr;
	String[][] allNumStr = allNum;

	if(workNo.substring(0,1).equals("8") || workNo.substring(0,1).equals("9"))
	{
		sq1 = sq1 + " and account_type = '2' ";
	}

%>
<html>
<script>
function qryInfoDetail(i)
{
	var tempWorkNo         = "account_no"+i;
	var temWorkNo          = document.frm(tempWorkNo).value;
	var tempAccountType    = "account_type"+i;
	var temAccountType     = document.frm(tempAccountType).value;
	var tempGroupId        = "group_id"+i;
	var temGroupId         = document.frm(tempGroupId).value;
	var tempLoginName      = "login_name"+i;
	var temLoginName       = document.frm(tempLoginName).value;
	var tempPowerCode      = "powerCodeInfo"+i;
	var temPowerCode       = document.frm(tempPowerCode).value;
	var tempPowerRight     = "powerRightInfo"+i;
	var temPowerRight      = document.frm(tempPowerRight).value;
	var tempLoginFlag      = "loginFlagInfo"+i;
	var temLoginFlag       = document.frm(tempLoginFlag).value;
	var tempOpTime         = "opTimeInfo"+i;
	var temOpTime          = document.frm(tempOpTime).value;
	var tempRptRight       = "rptRightInfo"+i;
	var temRptRight        = document.frm(tempRptRight).value;
	var tempAllowBegin     = "allowBeginInfo"+i;
	var temAllowBegin      = document.frm(tempAllowBegin).value;
	var tempAllowEnd       = "allowEndInfo"+i;
	var temAllowEnd        = document.frm(tempAllowEnd).value;
	var tempPassTime       = "passTimeInfo"+i;
	var temPassTime        = document.frm(tempPassTime).value;
	var tempExpireTime     = "expireTimeInfo"+i;
	var temExpireTime      = document.frm(tempExpireTime).value;
	var tempTryTimes       = "tryTimesInfo"+i;
	var temTryTimes        = document.frm(tempTryTimes).value;
	var tempVilidFlag      = "validFlagInfo"+i;
	var temVilidFlag       = document.frm(tempVilidFlag).value;
	var tempMainTainFlag   = "mainTainFlagInfo"+i;
	var temMainTainFlag    = document.frm(tempMainTainFlag).value;
	var tempOrgCode        = "orgCodeInfo"+i;
	var temOrgCode         = document.frm(tempOrgCode).value;
	var tempDeptCode       = "deptCodeInfo"+i;
	var temDeptCode        = document.frm(tempDeptCode).value;
	var tempLoginStatus    = "loginStatusInfo"+i;
	var temLoginStatus     = document.frm(tempLoginStatus).value;
	var tempReloginFlag    = "reloginFlagInfo"+i;
	var temReloginFlag     = document.frm(tempReloginFlag).value;
	var tempotherloginFlag = "otherFlagInfo"+i;
	var temotherFlag       = document.frm(tempotherloginFlag).value;
	var tempIpAddress      = "ipAddressInfo"+i;
	var temIpAddress       = document.frm(tempIpAddress).value;
	var tempRunTime        = "runTimeInfo"+i;
	var temRunTime         = document.frm(tempRunTime).value;
	var tempContractPhone  = "contractPhone"+i;
	var temContractPhone   = document.frm(tempContractPhone).value;
	var tempSendFlag       = "sendFlag"+i;
	var temSendFlag        = document.frm(tempSendFlag).value;
	var tempIpFlag         = "ipFlag"+i;
	var temIpFlag          = document.frm(tempIpFlag).value;
	var tempMaxErr         = "maxErr"+i;
	var temMaxErr          = document.frm(tempMaxErr).value;
	var tempPowerName      = "powerName"+i;
	var temPowerName       = document.frm(tempPowerName).value;
	var tempSEQ_MailCode   ="SEQ_MailCode"+i;	<!--20100317 add-->
	var temSEQ_MailCode    =document.frm(tempSEQ_MailCode).value;	<!--20100317 add-->
	var tempReject_flag   ="reject_flag"+i;	<!--2014/3/12 add-->
	var temReject_flag    =document.frm(tempReject_flag).value;	<!--2014/3/12 add-->
  // liyan 20100103
	var tempAccountName      = "account_name"+i;
	var temAccountName       = document.frm(tempAccountName).value;
	var strPath = "accountType="+temAccountType+"&otherFlag="+temotherFlag
				+"&contractPhone="+temContractPhone+"&reloginFlag="+temReloginFlag
				+"&workNo="+temWorkNo+"&loginName="+temLoginName
				+"&powerCode="+temPowerCode+"&powerRight="+temPowerRight
				+"&loginFlag="+temLoginFlag+"&opTime="+temOpTime
				+"&rptRight="+temRptRight+"&allowBegin="+temAllowBegin
				+"&allowEnd="+temAllowEnd+"&passTime="+temPassTime
				+"&expireTime="+temExpireTime+"&tryTimes="+temTryTimes
				+"&vilidFlag="+temVilidFlag+"&maintainFlag="+temMainTainFlag
				+"&orgCode="+temOrgCode+"&deptCode="+temDeptCode
				+"&loginStatus="+temLoginStatus+"&ipAddress="+temIpAddress
				+"&runTime="+temRunTime+"&sendFlag="+temSendFlag
				+"&ipFlag="+temIpFlag+"&maxErr="+temMaxErr
				+"&accountName="+temAccountName/*wangyua add 20100613 */
				+"&groupId="+temGroupId+"&powerName="+temPowerName+"&SEQ_MailCode="+temSEQ_MailCode <!--20100317 add-->
				+"&reject_flag="+temReject_flag;<!--2014/3/12 add-->

	window.open('qryLoginInfo.jsp?'+strPath,'','width=800,height=600,left=0,top=0,resizable=yes,scrollbars=yes,status=yes,menubar=yes');
}

function getPowerInfo(i)
{
	var tempWorkNo = "loginNo"+i;
	var temWorkNo=document.frm(tempWorkNo).value;

	var url = "popedomtree.jsp?loginNo1="+temWorkNo;
	window.open(url,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');

}

function modifyInfoDetail(i)
{

	var tempWorkNo         = "account_no"+i;
	var temWorkNo          = document.frm(tempWorkNo).value;
	var tempAccountType    = "account_type"+i;
	var temAccountType     = document.frm(tempAccountType).value;
	var tempPowerCode      = "powerCodeInfo"+i;
	var temPowerCode       = document.frm(tempPowerCode).value;
	<% if(workNo.substring(0,1).equals("8") || workNo.substring(0,1).equals("9"))
	{%>
		if(temAccountType != "2")
		{
			rdShowMessageDialog("客服工号管理员只能修改客服工号信息！");
			return;
		}
	<%}%>

	<% if(powerCode.trim().length()==4)
	{%>
		//rdShowMessageDialog(temPowerCode.length);
		if(temPowerCode.length <= 4  )
		{
			//rdShowMessageDialog("角色为4位代码不可修改4位代码的角色，只可查看");
			qryInfoDetail(i);
			return;
		}
	<%}%>

	var tempGroupId        = "group_id"+i;
	var temGroupId         = document.frm(tempGroupId).value;
	var tempLoginName      = "login_name"+i;
	var temLoginName       = document.frm(tempLoginName).value;
/*	var tempPowerCode      = "powerCodeInfo"+i;
	var temPowerCode       = document.frm(tempPowerCode).value;*/
	var tempPowerRight     = "powerRightInfo"+i;
	var temPowerRight      = document.frm(tempPowerRight).value;
	var tempLoginFlag      = "loginFlagInfo"+i;
	var temLoginFlag       = document.frm(tempLoginFlag).value;
	var tempOpTime         = "opTimeInfo"+i;
	var temOpTime          = document.frm(tempOpTime).value;
	var tempRptRight       = "rptRightInfo"+i;
	var temRptRight        = document.frm(tempRptRight).value;
	var tempAllowBegin     = "allowBeginInfo"+i;
	var temAllowBegin      = document.frm(tempAllowBegin).value;
	var tempAllowEnd       = "allowEndInfo"+i;
	var temAllowEnd        = document.frm(tempAllowEnd).value;
	var tempPassTime       = "passTimeInfo"+i;
	var temPassTime        = document.frm(tempPassTime).value;
	var tempExpireTime     = "expireTimeInfo"+i;
	var temExpireTime      = document.frm(tempExpireTime).value;
	var tempTryTimes       = "tryTimesInfo"+i;
	var temTryTimes        = document.frm(tempTryTimes).value;
	var tempVilidFlag      = "validFlagInfo"+i;
	var temVilidFlag       = document.frm(tempVilidFlag).value;
	var tempMainTainFlag   = "mainTainFlagInfo"+i;
	var temMainTainFlag    = document.frm(tempMainTainFlag).value;
	var tempOrgCode        = "orgCodeInfo"+i;
	var temOrgCode         = document.frm(tempOrgCode).value;
	var tempDeptCode       = "deptCodeInfo"+i;
	var temDeptCode        = document.frm(tempDeptCode).value;
	var tempLoginStatus    = "loginStatusInfo"+i;
	var temLoginStatus     = document.frm(tempLoginStatus).value;
	var tempReloginFlag    = "reloginFlagInfo"+i;
	var temReloginFlag     = document.frm(tempReloginFlag).value;
	var tempotherloginFlag = "otherFlagInfo"+i;
	var temotherFlag       = document.frm(tempotherloginFlag).value;
	var tempIpAddress      ="ipAddressInfo"+i;
	var temIpAddress       =document.frm(tempIpAddress).value;
	var tempRunTime        ="runTimeInfo"+i;
	var temRunTime         =document.frm(tempRunTime).value;
	var tempContractPhone  ="contractPhone"+i;
	var temContractPhone   =document.frm(tempContractPhone).value;
	var tempSendFlag       ="sendFlag"+i;
	var temSendFlag        =document.frm(tempSendFlag).value;
	var tempIpFlag         ="ipFlag"+i;
	var temIpFlag          =document.frm(tempIpFlag).value;
	var tempMaxErr         ="maxErr"+i;
	var temMaxErr          =document.frm(tempMaxErr).value;
	var tempPowerName      ="powerName"+i;
	var temPowerName       =document.frm(tempPowerName).value;
	var tempSEQ_MailCode   ="SEQ_MailCode"+i;	<!--20100317 add-->
	var temSEQ_MailCode    =document.frm(tempSEQ_MailCode).value;	<!--20100317 add-->
	var tempReject_flag   ="reject_flag"+i;	<!--2014/3/12 add-->
	var temReject_flag    =document.frm(tempReject_flag).value;	<!--2014/3/12 add-->

	// liyan 20100103
	var tempAccountName      = "account_name"+i;
	var temAccountName       = document.frm(tempAccountName).value;

	var strPath = "accountType="+temAccountType+"&otherFlag="+temotherFlag
				+"&contractPhone="+temContractPhone+"&reloginFlag="+temReloginFlag
				+"&workNo="+temWorkNo+"&loginName="+temLoginName
				+"&powerCode="+temPowerCode+"&powerRight="+temPowerRight
				+"&loginFlag="+temLoginFlag+"&opTime="+temOpTime
				+"&rptRight="+temRptRight+"&allowBegin="+temAllowBegin
				+"&allowEnd="+temAllowEnd+"&passTime="+temPassTime
				+"&expireTime="+temExpireTime+"&tryTimes="+temTryTimes
				+"&vilidFlag="+temVilidFlag+"&maintainFlag="+temMainTainFlag
				+"&orgCode="+temOrgCode+"&deptCode="+temDeptCode
				+"&loginStatus="+temLoginStatus+"&ipAddress="+temIpAddress
				+"&runTime="+temRunTime+"&sendFlag="+temSendFlag
				+"&ipFlag="+temIpFlag+"&maxErr="+temMaxErr
				+"&accountName="+temAccountName/*wangyua add 20100613 */
				+"&groupId="+temGroupId+"&powerName="+temPowerName+"&SEQ_MailCode="+temSEQ_MailCode <!--20100317 add-->
				+"&reject_flag="+temReject_flag;<!--2014/3/12 add-->

	window.open("modifyLoginInfo.jsp?"+strPath,"","width=800,height=600,left=0,top=0,resizable=yes,scrollbars=yes,status=yes,menubar=yes");
}
</script>
<body>
<form name=frm>
<div id="Main">

   <DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">符合条件工号信息列表</div>
	</div>

	<TABLE cellSpacing=0  vColorTr='set'>
		<TBODY>
			<tr>
				<th width="10%" nowrap>帐号代码</th>
				<th width="10%" nowrap>帐号类型</th>
				<th width="16%" nowrap>工号名称</th>
				<th width="18%" nowrap>角色信息</th>
				<th width="8%" nowrap>权限值</th>
				<th width="8%" nowrap>有效性</th>
				<th width="10%">&nbsp;</th>
				<th width="10%">&nbsp;</th>
				<th width="10%">&nbsp;</th>
			</tr>
		<% 	for(int i = 0 ; i < nott.length ; i ++)
			{
				String accTypeName = "营业类BOSS帐号";
				if(nott[i][28].equals("2"))
				{
					accTypeName = "客服帐号";
				}
				else if(nott[i][28].equals("3"))
				{
					accTypeName = "管理类BOSS帐号";
				}
				else if(nott[i][28].equals("0"))
				{
					accTypeName = "管理类BOSS帐号";
				}
			%>
				<td width="8%">
					<input  id=Text2 type=hidden size=10 name=account_no<%=i%> maxlength=6 value=<%=nott[i][27]%> disabled ><%=nott[i][27]%>
				</td>
				<td width="14%">
					<input type="hidden" name=account_name<%=i%> value="<%=nott[i][32]%>">
					<input  type=hidden size=10 name=account_type<%=i%> maxlength=6 value=<%=nott[i][28]%> disabled ><%=accTypeName%>
				</td>

				<td width="10%">
					<input  type=hidden size=10 name=login_name<%=i%> maxlength=6 value=<%=nott[i][1]%> disabled ><%=nott[i][1]%>
				</td>

	 	    <%
				String  validFlagValue="";
				if(nott[i][13].equals("1"))
				{
					validFlagValue="有效";
				}
				if(nott[i][13].equals("0"))
				{
					validFlagValue="无效";
				}
				%>

				<td width="30%"><input  id=Text2 type=hidden size=10 name=login_Flag<%=i%> maxlength=32 value=<%=nott[i][3]%> disabled ><%=nott[i][30]+"("+nott[i][3]+")"%></td>
				<td width="5%"><input  id=Text2 type=hidden size=10 name=login_status<%=i%> maxlength=6 value=<%=nott[i][4]%> disabled ><%=nott[i][4]%></td>
				<td width="5%"><input  id=Text2 type=hidden size=10 name=valid_flag<%=i%> maxlength=6 value=<%=nott[i][18]%> disabled ><%=validFlagValue%></td>

				<td><input  type=button name=inp<%=i%>  class="b_text"value="详细信息" onclick="qryInfoDetail(<%=i%>)"></td>
				<td><input  type=button name=pdom<%=i%> class="b_text" value="权限信息" onclick="getPowerInfo(<%=i%>)"></td>
				<td><input  type=button name=mod<%=i%>  class="b_text" value="修改" onclick="modifyInfoDetail(<%=i%>)"></td>

				<input type=hidden name=powerCodeInfo<%=i%> value="<%=nott[i][3]%>"></input>
				<input type=hidden name=powerRightInfo<%=i%> value="<%=nott[i][4]%>"></input>
				<input type=hidden name=loginFlagInfo<%=i%> value="<%=nott[i][5]%>"></input>
				<input type=hidden name=opTimeInfo<%=i%> value="<%=nott[i][6]%>"></input>
				<input type=hidden name=rptRightInfo<%=i%> value="<%=nott[i][7]%>"></input>
				<input type=hidden name=allowBeginInfo<%=i%> value="<%=nott[i][8]%>"></input>
				<input type=hidden name=allowEndInfo<%=i%> value="<%=nott[i][9]%>"></input>
				<input type=hidden name=passTimeInfo<%=i%> value="<%=nott[i][10]%>"></input>
				<input type=hidden name=expireTimeInfo<%=i%> value="<%=nott[i][11]%>"></input>
				<input type=hidden name=tryTimesInfo<%=i%> value="<%=nott[i][12]%>"></input>
				<input type=hidden name=validFlagInfo<%=i%> value="<%=nott[i][13]%>"></input>
				<input type=hidden name=maintainFlagInfo<%=i%> value="<%=nott[i][14]%>"></input>
				<input type=hidden name=orgCodeInfo<%=i%> value="<%=nott[i][15]%>"></input>
				<input type=hidden name=reloginFlagInfo<%=i%> value="<%=nott[i][18]%>"></input>
				<input type=hidden name=deptCodeInfo<%=i%> value="<%=nott[i][19]%>"></input>
				<input type=hidden name=loginStatusInfo<%=i%> value="<%=nott[i][20]%>"></input>
				<input type=hidden name=ipAddressInfo<%=i%> value="<%=nott[i][21]%>"></input>
				<input type=hidden name=runTimeInfo<%=i%> value="<%=nott[i][22]%>"></input>
				<input type=hidden name=contractPhone<%=i%> value="<%=nott[i][23]%>"></input>
				<input type=hidden name=otherFlagInfo<%=i%> value="<%=nott[i][16]%>"></input>
				<input type=hidden name=sendFlag<%=i%> value="<%=nott[i][24]%>"></input>
				<input type=hidden name=ipFlag<%=i%> value="<%=nott[i][25]%>"></input>
				<input type=hidden name=maxErr<%=i%> value="<%=nott[i][26]%>"></input>
				<input type=hidden name=group_id<%=i%> value="<%=nott[i][29]%>"></input>
				<input type=hidden name=loginNo<%=i%> value="<%=nott[i][0]%>"></input>
				<input type=hidden name=powerName<%=i%> value="<%=nott[i][30]%>"></input>
				<input type=hidden name=SEQ_MailCode<%=i%> value="<%=nott[i][31]%>"></input><!--20100317 add-->
				<input type=hidden name=reject_flag<%=i%> value="<%=nott[i][33]%>"></input><!--2014/3/12  add-->
				
				<input type=hidden name="opCode" value="<%=opCode%>"></input>
				<input type=hidden name="opName" value="<%=opName%>"></input>
			</tr>
		<%}%>
		</TBODY>
	</TABLE>

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
</form>
</body>
</html>

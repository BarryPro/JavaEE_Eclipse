   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-27
********************/
%>
            
              
<%
  String opCode = "8054";
  String opName = "角色权限管理";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 


<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
    //得到输入参数
    String return_code,return_message;
    String[][] result = new String[][]{};
		String[][] allNumStr =  new String[][]{};
		String regionCode = (String)session.getAttribute("regCode");
%> 	

<%
/*
SQL语句        sql_content
选择类型       sel_type   
标题           title      
字段1名称      field_name1
*/
    String fieldNum 	= "5";
	String roleCode 	= request.getParameter("roleCode");
	int 	iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 20;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

    String sqlStr = "select nvl(count(*),0) num from sLoginRoalRelation a "
    	+ "where  a.role_code = '"+roleCode+"'";
	String sqlStr1 = "select * from (select a.account_NO,"
			+ "decode(a.account_type,1,'BOSS帐号',2,'客服帐号','BOSS帐号'),"
			+ "a.LOGIN_NAME ,decode(a.maintain_flag,'0','业务类','1','维护类','管理类'),"
			+ "decode(a.vilid_flag,'1','有效','无效'), a.power_code,a.power_right,"
			+ "a.login_flag,to_char(a.op_time,'yyyymmdd hh24:mi:ss'),a.rpt_right,"
			+ "to_char(a.allow_begin,'yyyymmdd hh24:mi:ss'),"
			+ "to_char(a.allow_end,'yyyymmdd hh24:mi:ss'),"
			+ "to_char(a.pass_time,'yyyymmdd hh24:mi:ss'),"
			+ "to_char(a.expire_time,'yyyymmdd hh24:mi:ss'),"
			+ "a.try_times,a.vilid_flag,a.maintain_flag,a.org_code,a.region_char,"
			+ "a.relogin_flag,a.dept_code,a.login_status,a.ip_address,"
			+ "to_char(a.run_time,'yymmdd hh24:mi:ss'),a.contract_phone,"
			+ "a.SENDPWD_FLAG,a.IPBIND_FLAG,a.MAX_ERRNUM,a.account_type,"
			+ "a.group_id, rownum id from dloginmsg a, sLoginRoalRelation b "
			+ "where a.login_no = b.login_no and b.role_code = '" + roleCode + "' order by a.login_no) "
			+ "where id <"+iEndPos+" and id>="+iStartPos;
    //System.out.print("..........sqlStr="+sqlStr);
    //System.out.print("..........sqlStr1="+sqlStr1);
   
%>

<HTML>
<HEAD>
<TITLE>查询<%=roleCode%>角色下所有工号</TITLE>
<script>
function qryInfoDetail(i)
{	
	var tempWorkNo = "accountNo"+i;
	var temWorkNo=document.fPubSimpSel(tempWorkNo).value;
	var tempAccountType = "accountType"+i;
	var temAccountType = document.fPubSimpSel(tempAccountType).value;
	var tempGroupId = "groupId"+i;
	var temGroupId = document.fPubSimpSel(tempGroupId).value;
	var tempLoginName="accountName"+i;
	var temLoginName=document.fPubSimpSel(tempLoginName).value;
	var tempPowerCode="powerCode"+i;
	var temPowerCode=document.fPubSimpSel(tempPowerCode).value;
	var tempPowerRight="powerRight"+i;
	var temPowerRight=document.fPubSimpSel(tempPowerRight).value;
	var tempLoginFlag="loginFlag"+i;
	var temLoginFlag=document.fPubSimpSel(tempLoginFlag).value;
	var tempOpTime="opTime"+i;
	var temOpTime=document.fPubSimpSel(tempOpTime).value;
	var tempRptRight="rptRight"+i;
	var temRptRight=document.fPubSimpSel(tempRptRight).value;
	var tempAllowBegin="allowBegin"+i;
	var temAllowBegin=document.fPubSimpSel(tempAllowBegin).value;
	var tempAllowEnd="allowEnd"+i;
	var temAllowEnd=document.fPubSimpSel(tempAllowEnd).value;
	var tempPassTime="passTime"+i;
	var temPassTime=document.fPubSimpSel(tempPassTime).value;
	var tempExpireTime="expireTime"+i;
	var temExpireTime=document.fPubSimpSel(tempExpireTime).value;
	var tempTryTimes="tryTimes"+i;
	var temTryTimes=document.fPubSimpSel(tempTryTimes).value;
	var tempVilidFlag="vilidFlag"+i;
	var temVilidFlag=document.fPubSimpSel(tempVilidFlag).value;
	var tempMainTainFlag="maintainFlag"+i;
	var temMainTainFlag=document.fPubSimpSel(tempMainTainFlag).value;
	var tempOrgCode="orgCode"+i;
	var temOrgCode=document.fPubSimpSel(tempOrgCode).value;
	var tempDeptCode="deptCode"+i;
	var temDeptCode=document.fPubSimpSel(tempDeptCode).value;
	var tempLoginStatus="loginStatus"+i;
	var temLoginStatus=document.fPubSimpSel(tempLoginStatus).value;
	var tempReloginFlag = "reloginFlag"+i;
	var temReloginFlag=document.fPubSimpSel(tempReloginFlag).value;
	var tempotherloginFlag = "otherFlag"+i;
	var temotherFlag=document.fPubSimpSel(tempotherloginFlag).value;
	var tempIpAddress="ipAddress"+i;
	var temIpAddress=document.fPubSimpSel(tempIpAddress).value;
	var tempRunTime="runTime"+i;
	var temRunTime=document.fPubSimpSel(tempRunTime).value;
	var tempContractPhone="contractPhone"+i;
	var temContractPhone=document.fPubSimpSel(tempContractPhone).value;
	var tempSendFlag="sendFlag"+i;
	var temSendFlag=document.fPubSimpSel(tempSendFlag).value;
	var tempIpFlag="ipFlag"+i;
	var temIpFlag=document.fPubSimpSel(tempIpFlag).value;
	var tempMaxErr="maxErr"+i;
	var temMaxErr=document.fPubSimpSel(tempMaxErr).value;
	
	window.open('../s8002/qryLoginInfo.jsp?accountType='+temAccountType+'&otherFlag='+temotherFlag+'&contractPhone='+temContractPhone+'&reloginFlag='+temReloginFlag+'&workNo='+temWorkNo+'&loginName='+temLoginName+'&powerCode='+temPowerCode+'&powerRight='+temPowerRight+'&loginFlag='+temLoginFlag+'&opTime='+temOpTime+'&rptRight='+temRptRight+'&allowBegin='+temAllowBegin+'&allowEnd='+temAllowEnd+'&passTime='+temPassTime+'&expireTime='+temExpireTime+'&tryTimes='+temTryTimes+'&vilidFlag='+temVilidFlag+'&maintainFlag='+temMainTainFlag+'&orgCode='+temOrgCode+'&deptCode='+temDeptCode+'&loginStatus='+temLoginStatus+'&ipAddress='+temIpAddress+'&runTime='+temRunTime+'&sendFlag='+temSendFlag+'&ipFlag='+temIpFlag+'&maxErr='+temMaxErr+'&groupId='+temGroupId,'','width=800,height=600,left=0,top=0,resizable=yes,scrollbars=yes,status=yes,menubar=yes');
}
</script>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">   
	<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi"><script language="javascript">document.write(document.title);</script></div>
	</div>
 
	<table cellspacing="0">
		<tr>
			<TR  height=25>
				<Th>&nbsp;&nbsp;人员帐号</Th>
				<Th>&nbsp;&nbsp;帐号类型</Th>
				<Th>&nbsp;&nbsp;人员名称</Th>
				<Th>&nbsp;&nbsp;工号类型</Th>
				<Th>&nbsp;&nbsp;有效标识</Th>
			</TR> 

<%
	//根据传人的Sql查询数据库，得到返回结果
	try
	{
		//retArray1 = callView.sPubSelect("1",sqlStr);
		//retArray = callView.sPubSelect("31",sqlStr1);
		%>
		
		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="allNumStr_t" scope="end"/>


		<wtc:pubselect name="sPubSelect" outnum="31" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="result_t" scope="end"/>		
		
		<%
		result = result_t;
		allNumStr = allNumStr_t;
		int recordNum = Integer.parseInt(allNumStr[0][0].trim());
		String typeStr = "";
		String inputStr = "";
		for(int i=0;i<recordNum;i++)
		{
			typeStr = "";
			inputStr = "";
			out.print("<TR>");
			for(int j=0;j<Integer.parseInt(fieldNum);j++)
			{
				if(j==0)
				{
					typeStr = "<TD height = 20 >&nbsp;<a href=javascript:qryInfoDetail('"+i+"')>";
					typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
						" id='Rinput" + i + j + "'  value='" + 
						(result[i][j]).trim() + "'readonly></a></TD>";
				}
				else
				{
					inputStr = inputStr + "<TD height = 20 >&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
						" id='Rinput" + i + j + "'  value='" + 
						(result[i][j]).trim() + "'readonly></TD>";
				}
			}%>
			<input type=hidden name=accountNo<%=i%> value="<%=result[i][0]%>"></input>
			<input type=hidden name=accountType<%=i%> value="<%=result[i][1]%>"></input>
			<input type=hidden name=accountName<%=i%> value="<%=result[i][2]%>"></input>
			<input type=hidden name=powerCode<%=i%> value="<%=result[i][5]%>"></input>
			<input type=hidden name=powerRight<%=i%> value="<%=result[i][6]%>"></input>
			<input type=hidden name=loginFlag<%=i%> value="<%=result[i][7]%>"></input>
			<input type=hidden name=opTime<%=i%> value="<%=result[i][8]%>"></input>
			<input type=hidden name=rptRight<%=i%> value="<%=result[i][9]%>"></input>
			<input type=hidden name=allowBegin<%=i%> value="<%=result[i][10]%>"></input>
			<input type=hidden name=allowEnd<%=i%> value="<%=result[i][11]%>"></input>
			<input type=hidden name=passTime<%=i%> value="<%=result[i][12]%>"></input>
			<input type=hidden name=expireTime<%=i%> value="<%=result[i][13]%>"></input>
			<input type=hidden name=tryTimes<%=i%> value="<%=result[i][14]%>"></input>
			<input type=hidden name=vilidFlag<%=i%> value="<%=result[i][15]%>"></input>
			<input type=hidden name=maintainFlag<%=i%> value="<%=result[i][16]%>"></input>
			<input type=hidden name=orgCode<%=i%> value="<%=result[i][17]%>"></input>
			<input type=hidden name=otherFlag<%=i%> value="<%=result[i][18]%>"></input>
			<input type=hidden name=reloginFlag<%=i%> value="<%=result[i][19]%>"></input>
			<input type=hidden name=deptCode<%=i%> value="<%=result[i][20]%>"></input>
			<input type=hidden name=loginStatus<%=i%> value="<%=result[i][21]%>"></input>
			<input type=hidden name=ipAddress<%=i%> value="<%=result[i][22]%>"></input>
			<input type=hidden name=runTime<%=i%> value="<%=result[i][23]%>"></input>
			<input type=hidden name=contractPhone<%=i%> value="<%=result[i][24]%>"></input>
			<input type=hidden name=sendFlag<%=i%> value="<%=result[i][25]%>"></input>
			<input type=hidden name=ipFlag<%=i%> value="<%=result[i][26]%>"></input>
			<input type=hidden name=maxErr<%=i%> value="<%=result[i][27]%>"></input>
			
			<input type=hidden name=groupId<%=i%> value="<%=result[i][29]%>"></input>
			<%
			out.print(typeStr + inputStr);
			out.print("</TR>");
		}
	}
	catch(Exception e)
	{
		
	}          
%>
<%


%>   
				</tr>
			</table>
<%	
	int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	PageView view = new PageView(request,out,pg); 
%>
		<div style="position:relative;font-size:12px" align="center">
<%
    view.setVisible(true,true,0,0);      
%>
		</div>
<!------------------------------------------------------>
		<TABLE cellSpacing="0">
			<TBODY>
				<TR> 
					<TD align=center id="footer">
						<input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=关闭>&nbsp;        
					</TD>
				</TR>
			</TBODY>
		</TABLE>

		<!------------------------> 
		<input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
		<!------------------------>  
		<%@ include file="/npage/include/footer_pop.jsp" %>
	</FORM>
	</BODY>
</HTML>    

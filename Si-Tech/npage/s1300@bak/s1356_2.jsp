<%
/********************
 version v2.0
 开发商: si-tech
 模块：陈帐.死帐回收回退
 update zhaohaitao at 2008.12.30
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	String phoneNo = request.getParameter("phoneNo");
	String loginaccept = request.getParameter("water_number").trim();//流水号
	String select = request.getParameter("busyType");
	String totaldate  = request.getParameter("billdate").trim();//帐务日期
	
	String nopass = (String)session.getAttribute("password");
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String orgcode = (String)session.getAttribute("orgCode");//机构代码
	String op_code = "";
	String busyName="";

if ( select.equals("1") )
{
	op_code="1356";
	busyName="陈帐回收回退";
}
else
{
	op_code="1360";
	busyName="死帐回收回退";
}
	opCode = op_code;
	opName = busyName;
	String[] inParas = new String[5];
	inParas[0] = totaldate;
	inParas[1] = loginaccept;
	inParas[2] = workno;
	inParas[3] = nopass;
	inParas[4] = op_code;
 
	//CallRemoteResultValue  value  = viewBean.callService("1", orgcode.substring(0,2) ,  "s1356Query", "17"  ,  lens , inParas) ;
%>
	<wtc:service name="s1356Query" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="17">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	</wtc:service>
	<wtc:array id="result" start="0" length="12" scope="end"/>
	<wtc:array id="result2" start="12" length="5" scope="end"/>
<%
	String return_code = result[0][0];
	String return_msg = result[0][1];
	
	String return_money = "";
	String v_name = "";
	String user_number = "";
	String payfee_time = "";
	String login_no = "";
	String pay_total = "";
	String pay_type = "";
	String nopay_water = "";
	String pay_account = "";

 	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
    
	if (return_code.equals("000000")) 
  {
	if(result.length>0){
		return_money =result[0][2].trim();
		v_name =result[0][3].trim();
		user_number =result[0][4];
		payfee_time =result[0][5];
		login_no =result[0][6];
		pay_total =result[0][7].trim();
		pay_type =result[0][8];
		nopay_water = result[0][9];
		pay_account = result[0][11];
  /* chenhu add */
  			double PayMoney = 0-Double.parseDouble(return_money);
  			String sPayMoney = String.valueOf(PayMoney);
%>
    <wtc:service name="bs_ChnPayLimit" routerKey="region" routerValue="<%=orgcode.substring(0,2)%>" outnum="5">
        <wtc:param value="<%=workno%>"/>
        <wtc:param value="<%=sPayMoney%>"/>
    </wtc:service>
    <wtc:array id="result4"   scope="end" />
    <wtc:array id="result5"  scope="end" /> 	
    <wtc:array id="result6"  scope="end" />
    <wtc:array id="result7"  scope="end" />
    <wtc:array id="result8"  scope="end" />
<%      
				String t_return_code = result4[0][0].trim();
				String t_return_msg = result5[0][0].trim();
				String flag_status  = result6[0][0].trim(); 
				String pledge_fee  = result7[0][0].trim(); 
				String total_money = result8[0][0].trim(); 
				System.out.println("chenhu test ############################ test t_return_code is "+t_return_code);
				System.out.println("chenhu test ############################ test t_return_msg is "+t_return_msg);
				System.out.println("chenhu test ############################ test flag_status is "+flag_status);
				if(!t_return_code.equals("000000")){
%>
 <script language='jscript'>			
						rdShowMessageDialog("查代理商错误！<br>错误代码：'<%=t_return_code%>'。<br>错误信息：'<%=t_return_msg%>'。",0);
						history.go(-1);
	</script>	    		
<%
				}
	}
%>


<HEAD><TITLE>黑龙江BOSS-陈帐.死帐回收回退</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">

function form_load()
{
 document.form.remark.value="陈帐.死帐回收回退操作";
}
function DoCheck()
{
	getAfterPrompt();
	with ( document.form )
	{
		sure.disabled = true;
		return1.disabled = true;
		close1.disabled = true;
		submit();
	}
}
</script>
</HEAD>
<BODY onLoad="form_load();">
<FORM action="s1356_3.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>  
	
	<div class="title">
		<div id="title_zi">客户信息</div>
	</div>
<INPUT TYPE="hidden" name="OpCode" value="<%=op_code%>">
<input type="hidden" name="busyName" value="<%=busyName%>">
<input type="hidden" name="phoneNo" value="<%=result2[0][0]%>">
<INPUT TYPE="hidden" name="pay_account" value="<%=pay_account%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="opCode" value="<%=opCode%>">

<table cellspacing="0">
	<tr> 
		<td class="blue">操作类型</td>
		<td><%=busyName%></td>
		<td class="blue">部门</td>
		<td><%=orgcode%></td>
	</tr>
	<tr> 
		<td class="blue">帐务日期</td>
		<td> 
			<input type="text" readonly name="billdate" class="InputGrey" value="<%=totaldate%>">
		</td>
		<td class="blue">缴费流水</td>
		<td> 
			<input type="text" readonly name="water_number" class="InputGrey" value="<%=loginaccept%>">
		</td>
	</tr>
	<tr> 
		<td class="blue">付费帐户</td>
		<td> 
			<input type="text" readonly name="pay_account" class="InputGrey" value="<%=v_name%>">
		</td>
		<td class="blue">工号</td>
		<td> 
			<input type="text" readonly name="textfield5" class="InputGrey"  value="<%=login_no%>">
		</td>
	</tr>
	<tr> 
		<td class="blue">用户名称</td>
		<td> 
			<input type="text" readonly name="user" class="InputGrey" value="<%=v_name%>">
		</td>
		<td class="blue">金额</td>
		<td>
			<input type="text" readonly name="textfield8" class="InputGrey" value="<%=pay_total%>">
		</td>
	</tr>
	<tr> 
		<td class="blue">用户数量</td>
		<td class="blue"> 
			<input type="text" readonly name="textfield6" class="InputGrey" value="<%=user_number%>">
		</td>
		<td class="blue">缴费时间</td>
		<td> 
			<input type="text" readonly name="paytime" class="InputGrey" value="<%=payfee_time%>">
		</td>
	</tr>
</table>
</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">缴费信息</div>
</div>
     
<table cellspacing="0">
<tbody> 
	<tr> 
		<th> 
			<div align="center">服务号码</div>
		</th>
		<th> 
			<div align="center">缴费金额</div>
		</th>
		<th> 
			<div align="center">预存款</div>
		</td>
		<th> 
			<div align="center">话费</div>
		</th>
		<th> 
			<div align="center">滞纳金</div>
		</th>
	</tr>
		<%
		String tdClass="";
for(int y=0;y<result2.length;y++){
	if ((y%2)==1)
	{	
		tdClass="";
%>

		<tr>
<%
	}	
	else{
		tdClass="Grey";
%>
    	<tr> 
<%  
	}
	for(int j=0;j<result2[0].length;j++){
		System.out.println("result2["+y+"]["+j+"]="+result2[y][j]);
%>
          <td class="<%=tdClass%>"> 
            <div align="center"><%= result2[y][j]%></div></td>
<%	}
%>
</tr>
<%
}
%>
</tbody> 
</table>
</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">操作信息</div>
</div>
<table cellspacing="0">
<tbody> 
	<tr> 
	<td class="blue">退费金额</td>
		<td> 
		<input class="button" readonly name=remark2 value="<%=return_money%>">
		</td>
		</tr>
	<tr> 
		<td class="blue">用户备注</td>
		<td> 
		<input name=remark size=60 maxlength="60" onkeydown="if(event.keyCode==13) DoCheck();">
		</td>
	</tr>
</tbody> 
</table>
<table cellspacing="0">
<tbody> 
	<tr> 
		<td id="footer"> 
		<input class="b_foot" name="sure" type="button" value="确认" onclick="DoCheck()"> 
		<input class="b_foot" name="return1" type="button" value="返回" onclick="window.history.go(-1);">
		<input class="b_foot" name="close1" type="button" value="关闭" onClick="removeCurrentTab()">
	</td>
	</tr>
</tbody> 
</table>
      <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<%
 }
 else{
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
	rdShowMessageDialog("查询错误！<br>错误代码：'<%=return_code%>'。<br>错误信息：'<%=return_msg%>'。",0);
	history.go(-1);
//-->
</SCRIPT>
 <%}%>

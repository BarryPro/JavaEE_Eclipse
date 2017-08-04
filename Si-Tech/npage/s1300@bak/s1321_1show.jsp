<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:兑换发票1321
   * 版本: 1.0
   * 日期: 2009/1/16
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
 
 <%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String groupId = (String)session.getAttribute("groupId");
	String workno = (String)session.getAttribute("workNo");				//操作工号
	String opCode = (String)request.getParameter("opCode");					//操作代码
	String opName = (String)request.getParameter("opName");					//模块名
	String regionCode = (String)session.getAttribute("regCode");			//地市
	String i_contract_no = request.getParameter("contract_no");				//账户号码
    String i_login_accept = request.getParameter("login_accept");			//缴费流水
	String i_year_month = request.getParameter("year_month");				//缴费月份
   
    // xl add for 发票号码 begin
	//String s_invoice_tmp="";
	String return_flag="";
	String return_note="";
	String ocpy_begin_no="";
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code="";
	String bill_accept="";//bill_accept

	String check_seq="";
	String s_flag="";
	String result_check[][]=new String[][]{};
	String[] inParam2 = new String[2];
	//inParam2[0]="select to_char(S_INVOICE_NUMBER),flag from WLOGININVOICE where LOGIN_NO = :workNo";
	//inParam2[1]="workNo="+workno;
	


	String[] inParas = new String[4];
	inParas[0] = i_contract_no;
	inParas[1] = i_login_accept;
	inParas[2] = i_year_month;
	inParas[3] = workno;

%>
	<wtc:service name="s1321Init" routerKey="region" routerValue="<%=regionCode%>" outnum="24" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String return_code = retCode;
	String return_msg  = retMsg;
	if (!return_code.equals("000000")) {%>
	  <script language="JavaScript">
		    rdShowMessageDialog("收据兑换等额发票查询失败!(<%=return_msg%>)",0);
		    window.location="s1321_1.jsp";
	  </script>
	<% } else { %>


<!--xl add 发票预占-->
	<wtc:service name="scancelInDB" routerKey="phone" routerValue="<%=result[0][2]%>"  outnum="8" >
			 
			<wtc:param value="<%=i_login_accept%>"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value=""/><!--op_time-->
			<wtc:param value="<%=result[0][2].trim()%>"/>
			<wtc:param value="0"/><!--id_no-->
			<wtc:param value="<%=i_contract_no%>"/>
			<wtc:param value=""/><!--s_check_num-->
			<wtc:param value=""/><!--发票号码 第一次调用时 传空 我在服务里tpcallBASD的接口取得-->
			<wtc:param value=""/><!--发票代码 空-->
			<wtc:param value=""/><!--sm_code-->
			<wtc:param value="<%=result[0][6].trim()%>"/><!--小写金额-->
			<wtc:param value=""/><!--大写金额-->
			<wtc:param value=""/><!--备注-->
		 
			<wtc:param value="6"/><!--预占是6 取消是5即未打印-->
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/><!--账期-->
			<wtc:param value="<%=result[0][1].trim()%>"/><!--后面的：-->
			<wtc:param value="0"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=regionCode%>"/>
			<wtc:param value="<%=groupId%>"/>	
			<wtc:param value="3"/>
	</wtc:service>
		
	<wtc:array id="bill_opy" scope="end" />
	<%
		if(bill_opy!=null&&bill_opy.length>0)
		{
			return_flag=bill_opy[0][0];
			if(return_flag.equals("000000"))
			{
				 ocpy_begin_no=bill_opy[0][2];
				 ocpy_end_no=bill_opy[0][3];
				 ocpy_num=bill_opy[0][4];
				 res_code=bill_opy[0][5];
				 bill_code=bill_opy[0][6];
				 bill_accept=bill_opy[0][7];
			}
			else
			{
				return_note=bill_opy[0][1];
				%>
					<script language="javascript">
						alert("发票预占失败!错误原因:"+"<%=return_note%>");
						history.go(-1);
					</script>
				<%
			}
		}
	%>
	
 

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>黑龙江BOSS-兑换发票</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<SCRIPT LANGUAGE="JavaScript">

function doPrintSubmit() {
	getAfterPrompt();
		if(rdShowConfirmDialog("当前发票号码是"+"<%=ocpy_begin_no%>"+",是否打印发票?")==1)
		{
		document.form.action="s1321_1print.jsp?check_seq="+"<%=ocpy_begin_no%>"+"&s_flag="+"N"+"&bill_code="+"<%=bill_code%>";
		document.form.submit();
		}
    else
		{
			return false;
		}
}

</SCRIPT>

</HEAD>
<BODY>
<FORM action="" method=post name=form>
  <INPUT TYPE="hidden" name="contract_no" value="<%=i_contract_no%>">
  <INPUT TYPE="hidden" name="login_accept" value="<%=i_login_accept%>">
  <INPUT TYPE="hidden" name="year_month" value="<%=i_year_month%>">
  <%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">兑换发票</div>
	</div>
<table cellspacing="0">
	<tr> 
		<th width=20%>兑换类型</th>
		<th colspan="3">收据兑换等额发票</th>
	</tr>
	<tr align="center"> 
		<td bgcolor="orange" colspan="4"><font size="4"><b>收据兑换等额发票</b></font></td>
	</tr>
	<tr> 
		<td class="blue" nowrap width=20%>客户名称</td>
		<td nowrap colspan="3"><%=result[0][1]%></td>
	</tr>
            
	<tr> 
		<td class="blue" nowrap width=20%>手机号码</td>
		<td nowrap colspan="3"><%=result[0][2]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap width=20%>帐户号码</td>
		<td colspan="3" nowrap><%=result[0][3]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap width=20%>支票号码</td>
		<td colspan="3" nowrap><%=result[0][4]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap width=20%>大写金额</td>
		<td colspan="3" nowrap><%=result[0][5]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap width=20%>小写金额</td>
		<td colspan="3" nowrap><%=result[0][6]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap width=20%>现金</td>
		<td nowrap><%=result[0][7]%></td>
		<td class="blue" nowrap>支票</td>
		<td nowrap><%=result[0][8]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap>信息栏 </td>
		<td colspan="3" nowrap><%=result[0][9]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap width=20%>收款员 </td>
		<td colspan="3" nowrap><%=result[0][10]%></td>
    </tr> 
    
    <tr>
    	<td id="footer" align="center" colspan="4">           
	        <input class="b_foot" name=sure type=button value=打印 onclick="doPrintSubmit()">
			&nbsp;
	        <input class="b_foot" name=reset type=reset value=返回 onclick="history.go(-1)">
      	</td>
    </tr>
  </table>
  	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<% } %>
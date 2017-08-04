<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode ="g090"; //"d223";
	String opName = "集团信用等级调整";//"退费统计";
 	String[][] result = new String[][]{}; 

	String workno = (String)session.getAttribute("workNo");	 
	String unit_id = request.getParameter("unit_id");
	String id_No="";
 
 
	String inParas[] = new String[2];
//  String phoneNo = request.getParameter("phoneNo");
    int i_count=1;
	//首先取 dbcustadm.dgrpCreditOpr的记录 无记录 展示请选择
	int i_count_first=0;
	String now_date="";
	String now_time="";
	String inParasfirsttime[] = new String[1];
	inParasfirsttime[0]="select to_char(sysdate,'YYYYMM'), to_char(sysdate,'YYYYMMDD hh24:mi:ss') from dual ";
	String inParasfirst[] = new String[2];
	inParasfirst[0] ="select d.unit_id, nvl(d.credit_code,'0'), nvl(d.begin_time,to_char(sysdate,'YYYYMM')),  d.end_time,  d.OP_code,  d.LOGIN_NO,  to_char(d.OP_TIME,'YYYYMMDD hh24:mi:ss') from dbcustadm.dgrpCreditOpr d where d.unit_id=:unit_id ";
	inParasfirst[1] ="unit_id="+unit_id;

	//判断N的 优先取判断N 的 
	inParas[0] ="select d.unit_id, d.credit_code, d.begin_time,  d.end_time,  d.OP_code,  d.LOGIN_NO,  to_char(d.OP_TIME,'YYYYMMDD hh24:mi:ss'),to_char(sysdate,'YYYYMM') from (select to_char(a.unit_id) unit_id, nvl(c.credit_code,'0') credit_code,  c.begin_time,  c.end_time,  c.OP_code,  c.LOGIN_NO,  c.OP_TIME from dgrpcustmsg a, dbcustadm.dgrpCreditOpr c  where a.unit_id =:unit_id and trim(c.begin_time) <= to_char(sysdate, 'YYYYMM') and trim(c.end_time) >= to_char(sysdate, 'YYYYMM')   and auto_flag = 'N'  and a.unit_id = c.unit_id(+)) d, dbcustadm.sgrpcreditcode e where d.credit_code = e.credit_code";
	inParas[1] ="unit_id="+unit_id;

	//不判断N
	String inParasnew[] = new String[2];
	inParasnew[0] ="select d.unit_id, d.credit_code, d.begin_time,  d.end_time,  d.OP_code,  d.LOGIN_NO,  to_char(d.OP_TIME,'YYYYMMDD hh24:mi:ss'),to_char(sysdate,'YYYYMM') from (select to_char(a.unit_id) unit_id, nvl(c.credit_code,'0') credit_code,  c.begin_time,  c.end_time,  c.OP_code,  c.LOGIN_NO,  c.OP_TIME from dgrpcustmsg a, dbcustadm.dgrpCreditOpr c  where a.unit_id =:unit_id and trim(c.begin_time)<=to_char(sysdate,'YYYYMM') and trim(c.end_time)>=to_char(sysdate,'YYYYMM')   and a.unit_id = c.unit_id(+)) d, dbcustadm.sgrpcreditcode e where d.credit_code = e.credit_code";
	inParasnew[1] ="unit_id="+unit_id; 
	 
%> 
<wtc:service name="TlsPubSelBoss" retcode="sConMoreQryCodefirsttime" retmsg="sConMoreQryMsgfirslttime" outnum="2">
    <wtc:param value="<%=inParasfirsttime[0]%>"/>  
</wtc:service>
<wtc:array id="ret_valfirsttime" scope="end" />


<wtc:service name="TlsPubSelBoss" retcode="sConMoreQryCodefirst" retmsg="sConMoreQryMsgfirslt" outnum="7">
    <wtc:param value="<%=inParasfirst[0]%>"/> 
    <wtc:param value="<%=inParasfirst[1]%>"/>
</wtc:service>
<wtc:array id="ret_valfirst" scope="end" />
<wtc:service name="TlsPubSelBoss" retcode="sConMoreQryCode" retmsg="sConMoreQryMsg" outnum="8">
    <wtc:param value="<%=inParas[0]%>"/> 
    <wtc:param value="<%=inParas[1]%>"/>
 
</wtc:service>
<wtc:array id="ret_val" scope="end" />

<wtc:service name="TlsPubSelBoss" retcode="sConMoreQryCodenew" retmsg="sConMoreQryMsgnew" outnum="8">
    <wtc:param value="<%=inParasnew[0]%>"/> 
    <wtc:param value="<%=inParasnew[1]%>"/>
 
</wtc:service>
<wtc:array id="ret_valnew" scope="end" />

<%
//System.out.println("QQQQQQQQQQQQQQQQQQQQQQQQQQ test inParas[0] is "+inParas[0]+" and inParas[1] is "+inParas[1]);
//add new begin
if(ret_valfirst==null||ret_valfirst.length==0)
{
	%><HEAD><TITLE>查询结果</TITLE>
</HEAD>

<body>
 <script language="javascript">//alert("1 ");</script>
 <!--此处增加： 查询全部的红黑名单值 下拉框-->
 <%
		String inParas2[] = new String[2]; 
		inParas2[0]="select credit_code,credit_name from dbcustadm.sgrpcreditcode";
 %>
 <wtc:service name="TlsPubSelBoss" retcode="sRedCode" retmsg="sRedMsg" outnum="2">
    <wtc:param value="<%=inParas2[0]%>"/>  
 
</wtc:service>
<wtc:array id="red_val" scope="end" />
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title" >
		<div id="title_zi" colspan=10> 集团信用等级调整</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>集团编码</th> 
		<th nowrap>信用等级</th>
		<th nowrap>开始时间(YYYYMM)</th>
		<th nowrap>结束时间(YYYYMM)</th>
		<th nowrap>业务代码</th>
		<th nowrap>操作工号</th>
		<th nowrap>办理时间</th>
	    <th nowrap>操作</th>
	 
	<tr>
		<tr>
     	    <td height="25" nowrap>&nbsp;<%=unit_id%></td>
			<input type="hidden" name="s_value" value="0">
				  <td height="25" nowrap>&nbsp; 
					<select name="s_red" id="s_redId0" value="0" onchange="check_type()">
						<%for(int i=0; i<red_val.length; i++){
							%>
							<option value="<%=red_val[i][0]%>">
						
									<%=red_val[i][0]%>--><%=red_val[i][1]%></option>
							<%}%>
 
					</select>  </td>
					 
				  <td height="5" nowrap>&nbsp;<input type="text" class="InputGrey" id="beginYm0" value="<%=ret_valfirsttime[0][0]%>" onKeyPress="return isKeyNumberdot(0)" maxlength=6 size=10 readonly ></td>
				  <td height="5" nowrap>&nbsp;<input type="text" id="endYm0"   onKeyPress="return isKeyNumberdot(0)" maxlength=6 size=10></td>
				  <td height="25" nowrap>&nbsp; g090</td>
				  <td height="25" nowrap>&nbsp;<%=workno%> </td>
				  <td height="25" nowrap>&nbsp; <%=ret_valfirsttime[0][1]%>  </td>
				  
				  <td height="25" nowrap>&nbsp;
				  <input type="button" value="更新" onclick="doCfm('0')">
				   </td>
 
			</tr>

	<%
		  for(int y=0;y<ret_valfirst.length;y++)
		  { 
	%>
			<tr>
     	    <td height="25" nowrap>&nbsp;<%=unit_id%></td>
			<input type="hidden" name="s_value" value="<%=ret_valfirst[y][1]%>">
				  <td height="25" nowrap>&nbsp; 
					<select name="s_red" id="s_redId<%=y%>" value="<%=ret_valfirst[y][1]%>" >
						<%for(int i=0; i<red_val.length; i++){
								if(red_val[i][0].equals(ret_valfirst[y][1])){
									%>
									<option value="<%=red_val[i][0]%>" selected >
						
						<%=red_val[i][0]%>--><%=red_val[i][1]%></option>
									<%
								}else{
									%>
									<option value="<%=red_val[i][0]%>">
						
									<%=red_val[i][0]%>--><%=red_val[i][1]%></option>
									<%
									}
							%>
							
						
						<%}%>
 
					</select>  </td>
					 
				  <td height="5" nowrap>&nbsp;<input type="text" class="InputGrey" id="beginYm<%=y%>" value="<%= ret_valfirst[y][7]%>" onKeyPress="return isKeyNumberdot(0)" maxlength=6 size=10 readonly></td>
				  <td height="5" nowrap>&nbsp;<input type="text" id="endYm<%=y%>" value="<%= ret_valfirst[y][3]%>" onKeyPress="return isKeyNumberdot(0)" maxlength=6 size=10></td>
				  <td height="25" nowrap>&nbsp;<%= ret_valfirst[y][4]%></td>
				  <td height="25" nowrap>&nbsp;<%= ret_valfirst[y][5]%></td>
				  <td height="25" nowrap>&nbsp;<%= ret_valfirst[y][6]%></td>
				  
				  <td height="25" nowrap>&nbsp;
				  <input type="button" value="更新" onclick="doCfm('<%=y%>')">
				   </td>
 
			</tr>
	<%	   }
	%>
		<td align="center" id="footer" colspan="10">
		 
		&nbsp;&nbsp; <input class="b_foot" name=back onClick="window.location='g090_1.jsp'" type="button" value="返回">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
}
//add new end
else if(ret_val==null||ret_val.length==0 && ret_valnew==null||ret_valnew.length==0 && ret_valfirst==null||ret_valfirst.length==0)
{
	%><HEAD><TITLE>集团信用等级调整</TITLE>
</HEAD>
<script language="javascript">//alert("2");</script>
<body >
<FORM method=post name="form">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">集团信用等级调整</div>
	</div>
	<table cellspacing="0" id="tabList">
 
	<tr>
		<td colspan=6 align=center><font color=red border>无查询结果</font></td>
	</tr>


		<td align="center" id="footer" colspan="8">
		   <input class="b_foot" name=back onClick="window.location='g090_1.jsp?opCode=g090&opName=集团信用等级调整'" type="button" value="返回">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%
}
else if(ret_val!=null&&ret_val.length>0)
{
	%><HEAD><TITLE>查询结果</TITLE>
</HEAD>

<body>
 <script language="javascript">//alert("3 ");</script>
 <!--此处增加： 查询全部的红黑名单值 下拉框-->
 <%
		String inParas2[] = new String[2]; 
		inParas2[0]="select credit_code,credit_name from dbcustadm.sgrpcreditcode";
 %>
 <wtc:service name="TlsPubSelBoss" retcode="sRedCode" retmsg="sRedMsg" outnum="2">
    <wtc:param value="<%=inParas2[0]%>"/>  
 
</wtc:service>
<wtc:array id="red_val" scope="end" />
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title" >
		<div id="title_zi" colspan=10> 集团信用等级调整</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>集团编码</th> 
		<th nowrap>信用等级</th>
		<th nowrap>开始时间(YYYYMM)</th>
		<th nowrap>结束时间(YYYYMM)</th>
		<th nowrap>业务代码</th>
		<th nowrap>操作工号</th>
		<th nowrap>办理时间</th>
	    <th nowrap>操作</th>
	 
	<tr>
	<%
		  for(int y=0;y<ret_val.length;y++)
		  { 
	%>
			<tr>
     	    <td height="25" nowrap>&nbsp;<%= ret_val[y][0]%></td>
			<input type="hidden" name="s_value" value="<%=ret_val[y][1]%>">
				  <td height="25" nowrap>&nbsp; 
					<select name="s_red" id="s_redId<%=y%>" value="<%=ret_val[y][1]%>"  onchange="check_type()">
						<%for(int i=0; i<red_val.length; i++){
								if(red_val[i][0].equals(ret_val[y][1])){
									%>
									<option value="<%=red_val[i][0]%>" selected >
						
						<%=red_val[i][0]%>--><%=red_val[i][1]%></option>
									<%
								}else{
									%>
									<option value="<%=red_val[i][0]%>">
						
									<%=red_val[i][0]%>--><%=red_val[i][1]%></option>
									<%
									}
							%>
							
						
						<%}%>
 
					</select>  </td>
					 
				  <td height="5" nowrap>&nbsp;<input type="text" class="InputGrey" id="beginYm<%=y%>" value="<%= ret_val[y][7]%>" onKeyPress="return isKeyNumberdot(0)" maxlength=6 size=10 readonly></td>
				  <td height="5" nowrap>&nbsp;<input type="text" id="endYm<%=y%>" value="<%= ret_val[y][3]%>" onKeyPress="return isKeyNumberdot(0)" maxlength=6 size=10></td>
				  <td height="25" nowrap>&nbsp;<%= ret_val[y][4]%></td>
				  <td height="25" nowrap>&nbsp;<%= ret_val[y][5]%></td>
				  <td height="25" nowrap>&nbsp;<%= ret_val[y][6]%></td>
				  
				  <td height="25" nowrap>&nbsp;
				  <input type="button" value="更新" onclick="doCfm('<%=y%>')">
				   </td>
 
			</tr>
	<%	   }
	%>
		<td align="center" id="footer" colspan="10">
		 
		&nbsp;&nbsp; <input class="b_foot" name=back onClick="window.location='g090_1.jsp'" type="button" value="返回">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
}
else 
{
	%><HEAD><TITLE>查询结果</TITLE>
</HEAD>

<body>
 <script language="javascript">//alert("4");</script>
 <!--此处增加： 查询全部的红黑名单值 下拉框-->
 <%
		String inParas2[] = new String[2]; 
		inParas2[0]="select credit_code,credit_name from dbcustadm.sgrpcreditcode";
 %>
 <wtc:service name="TlsPubSelBoss" retcode="sRedCode" retmsg="sRedMsg" outnum="2">
    <wtc:param value="<%=inParas2[0]%>"/>  
 
</wtc:service>
<wtc:array id="red_val" scope="end" />
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title" >
		<div id="title_zi" colspan=10> 集团信用等级调整</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>集团编码</th> 
		<th nowrap>信用等级</th>
		<th nowrap>开始时间(YYYYMM)</th>
		<th nowrap>结束时间(YYYYMM)</th>
		<th nowrap>业务代码</th>
		<th nowrap>操作工号</th>
		<th nowrap>办理时间</th>
	    <th nowrap>操作</th>
	 
	<tr>
	<%
		  for(int y=0;y<ret_valnew.length;y++)
		  { 
	%>
			<tr>
     	    <td height="25" nowrap>&nbsp;<%= ret_valnew[y][0]%></td>
			<input type="hidden" name="s_value" value="<%=ret_valnew[y][1]%>">
				  <td height="25" nowrap>&nbsp; 
					<select name="s_red" id="s_redId<%=y%>" value="<%=ret_valnew[y][1]%>"  onchange="check_type()">
						<%for(int i=0; i<red_val.length; i++){
								if(red_val[i][0].equals(ret_valnew[y][1])){
									%>
									<option value="<%=red_val[i][0]%>" selected >
						
						<%=red_val[i][0]%>--><%=red_val[i][1]%></option>
									<%
								}else{
									%>
									<option value="<%=red_val[i][0]%>">
						
									<%=red_val[i][0]%>--><%=red_val[i][1]%></option>
									<%
									}
							%>
							
						
						<%}%>
 
					</select>  </td>
					 
				  <td height="5" nowrap>&nbsp;<input type="text" class="InputGrey" id="beginYm<%=y%>" value="<%= ret_valnew[y][7]%>" onKeyPress="return isKeyNumberdot(0)" maxlength=6 size=10 readonly></td>
				  <td height="5" nowrap>&nbsp;<input type="text" id="endYm<%=y%>" value="<%= ret_valnew[y][3]%>" onKeyPress="return isKeyNumberdot(0)" maxlength=6 size=10></td>
				  <td height="25" nowrap>&nbsp;<%= ret_valnew[y][4]%></td>
				  <td height="25" nowrap>&nbsp;<%= ret_valnew[y][5]%></td>
				  <td height="25" nowrap>&nbsp;<%= ret_valnew[y][6]%></td>
				  
				  <td height="25" nowrap>&nbsp;
				  <input type="button" value="更新" onclick="doCfm('<%=y%>')">
				   </td>
 
			</tr>
	<%	   }
	%>
		<td align="center" id="footer" colspan="10">
		 
		&nbsp;&nbsp; <input class="b_foot" name=back onClick="window.location='g090_1.jsp'" type="button" value="返回">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
}
		 
%>	 
<script language="javascript">
	function check_type()
	{
		
		var unit_id="<%=unit_id%>";
		//alert("1 "+unit_id+" and i is "+i);
		var myPacket = new AJAXPacket("getCheck.jsp","请稍候......");
		myPacket.data.add("unit_id",unit_id);
		core.ajax.sendPacket(myPacket);
		myPacket = null;

	}
	function doProcess(packet)
	{
		var counts = packet.data.findValueByName("counts");
		//alert("counts is "+counts);
		if(counts<1)
		{
			rdShowMessageDialog("只有属性为A1、A2、B1、B2、C1才可以进行调整!页面将关闭，请重新登录!");
			//return false;
			window.location='g090_1.jsp';
			//removeCurrentTab();
		}
	}
	function doCfm(i)
	{
		var beginYmId = "beginYm"+i;
		var endYmId = "endYm"+i;
		 
		var s_redIds = "s_redId"+i;
		var red_value="";
	 
		//alert(idno_new);
		var beginYm_new = document.getElementById(beginYmId).value;
		var end_new = document.getElementById(endYmId).value;
		var objSel = document.getElementById(s_redIds);
		red_value=objSel.value;
		if(beginYm_new=="" ||end_new=="")
		{
			rdShowMessageDialog("请输入开始、结束时间!");
			return false;
		} 
		if(beginYm_new>end_new)
		{
			rdShowMessageDialog("开始时间不能大于结束时间!");
			return false;
		}
		//xl add new 结束时间不可大于三个月
		  var year1 =  beginYm_new.substr(0,4);
		  var year2 =  end_new.substr(0,4); 
		  var month1 = beginYm_new.substr(4,2);
		  var month2 = end_new.substr(4,2);
		  var len=(year2-year1)*12+(month2-month1)+1;
		  if(len>3)
		  {
			rdShowMessageDialog("开始时间、结束时间间隔不可大于三个月!");
			return false;
		  }
		//end
		//alert("red_value is "+red_value+" and beginYm_new is "+beginYm_new);
		var url="g090_Cfm.jsp?beginYm="+beginYm_new+"&endYm="+end_new+"&unit_id="+<%=unit_id%>+"&credit_code="+red_value;

		var url_new =url;//URLencode(url);
	 
		document.frm1507_2.action=url;
		var	prtFlag = rdShowConfirmDialog("是否确定本次操作？");
		if (prtFlag==1)
		{
			document.frm1507_2.submit();  
		}
		else
		{
			return false;
		} 
	}

	function checkDate(value)
	{
		if((/^\d{4}-\d{1,2}-\d{1,2}$/).test(value) == false)
			return false;
		
		 
		monthPerDays = new Array(31,28,31,30,31,30,31,31,30,31,30,31);    
		year = value.substring(0,4);
		month = value.substring(4,2);
		day = value.substring(6,2);
		alert(year+month+day);
		if(month >12 || month<0)
			return false;

		if(day>31 || day<0 )
			return false;
	 

		return true;
	}
 

</script> 
 	
 


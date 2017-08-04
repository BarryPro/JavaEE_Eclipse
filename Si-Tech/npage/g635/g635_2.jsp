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
	String opCode ="g635"; //"d223";
	String opName = "担保开机";//"退费统计";
	String regionCode= (String)session.getAttribute("regCode"); 
	String phone_no = request.getParameter("phone_no");	
	String cust_name="";
	String cust_level="";
	String s_hours="";
	//xl add 查询办理担保记录
	String bdb_phone="";
	String bdb_cust_name="";
	String dbsj="";
	String kjsj="";
	String s_qf="";
	String workNo = (String)session.getAttribute("workNo");

	String bdb = request.getParameter("bdb");	
	String[] inParas0_jl = new String[2];
	//inParas0_jl[0]="select a.Assure_phone,a.Phone_no ,c.cust_name, (case  when substr(b.RUN_CODE,2,1)='K' then a.expire_time  else b.RUN_TIME  end ) as mymid, case   when substr(b.RUN_CODE,2,1)='A' then '0' else to_char(a.cur_owe) end ,op_time from wSpecial_offon_log a,dcustmsg b,dcustdoc c where Assure_phone=:phone_no1 and a.phone_no=b.PHONE_NO and b.CUST_ID=c.cust_id union all select  a.Assure_phone,a.Phone_no , c.cust_name, case when substr(b.RUN_CODE,2,1)='K' then a.expire_time  else b.RUN_TIME end ,'0',op_time from dSpecial_offon a,dcustmsg b,dcustdoc c where a.phone_no=b.PHONE_NO and a.assure_phone=:phone_no2 and b.CUST_ID=c.cust_id order by mymid desc";
	inParas0_jl[0]="select to_char(a.op_time,'YYYYMMDD hh24:mi'),to_char(a.Phone_no) ,c.cust_name, to_char(a.deal_time,'YYYYMMDD hh24:mi') as times, case  when substr(b.RUN_CODE,2,1)='A' then '0'  else to_char(a.cur_owe) end  from wSpecial_offon_log a,dcustmsg b,dcustdoc c where Assure_phone=:phone_no1 and a.id_no=b.id_no and b.CUST_ID=c.cust_id union all select  to_char(a.op_time,'YYYYMMDD hh24:mi'),to_char(a.Phone_no) , c.cust_name, to_char(a.expire_time,'YYYYMMDD hh24:mi') as times ,'0' from dSpecial_offon a,dcustmsg b,dcustdoc c where a.assure_phone=:phone_no2 and b.CUST_ID=c.cust_id and a.id_no=b.id_no";
	inParas0_jl[1]="phone_no1="+phone_no+",phone_no2="+phone_no;
%>
	<%@ include file="/npage/include/header.jsp" %>
	<wtc:service name="TlsPubSelBoss"  outnum="5" >
			<wtc:param value="<%=inParas0_jl[0]%>"/>
			<wtc:param value="<%=inParas0_jl[1]%>"/>
	</wtc:service>
	<wtc:array id="result0_jl" scope="end" />
<%
	
	if(result0_jl!=null&&result0_jl.length>0)
	{
		%>
		<DIV id="Operation_Table">
				<div class="title">
					<div id="title_zi">担保开机</div>
				</div>
		<table cellspacing="0" id="tabList">
			<tr>
				<th>担保时间</th>
				<th>被担保手机</th>
				<th>被担保人姓名</th>
				<th>开机时间</th>
				<th>欠费</th>
			</tr>
			<%
				for(int i =0;i<result0_jl.length;i++)
				{
					%>
						<tr>
							<td><%=result0_jl[i][0]%></td>
							<td><%=result0_jl[i][1]%></td>
							<td><%=result0_jl[i][2]%></td>
							<td><%=result0_jl[i][3]%></td>
							<td><%=result0_jl[i][4]%></td>
						</tr>
					<%
				}
			%>
		</table>
		<%
	}
	else
	{
		%>
		<DIV id="Operation_Table">
				<div class="title">
					<div id="title_zi">担保开机</div>
				</div>
		<table cellspacing="0" id="tabList">
			<tr>
				<th>担保时间</th>
				<th>被担保手机</th>
				<th>被担保人姓名</th>
				<th>开机时间</th>
				<th>欠费</th>
			</tr>
		</table>
		<%
	}
	//xl end of 查询担保记录
	
	String[] inParas0 = new String[2];
	inParas0[0]="select to_char(b.phone_No),trim(a.cust_name),to_char(b.ilevel),to_char(d.hours) from dcustdoc a,dCustLevel b,dcustmsg c,cAssure_offon d where a.cust_id = c.cust_id and b.id_no=c.id_no and c.phone_No=:phone_no and b.ilevel = d.ilevel ";
	inParas0[1]="phone_no="+phone_no;
	String s_idNo="";


	%>


<script language="javascript">
	//定义全局变量
  var project_code = new Array();
  var transin_fee = new Array();//where条件 是 projectCode 要查询显示的是 fee
  var op_notes=new Array();
  
	function doCfms()
	{
		var prtFlag=0;
		var ilevel = document.getElementById("i_level").value;
		var hours = document.getElementById("dqsj").value;
		prtFlag = window.confirm("是否确认办理担保开机?");
		var actions = "g635_3.jsp?phone_no=<%=phone_no%>"+"&iLevel="+ilevel+"&hours="+hours+"&bdbr="+<%=bdb%>;
		//alert("actions is "+actions);
		if (prtFlag==1)
		{
			document.all.frm1507_3.action=actions;
			document.all.frm1507_3.submit();
		}
		else
		{
			return false;
		}
		
	}
	 

</script>
		
		<wtc:service name="sAssureInit" retcode="s_code" retmsg="s_msg" outnum="6" >
			<wtc:param value="<%=bdb%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="g635"/>
			<wtc:param value="<%=phone_no%>"/>
		</wtc:service>
		<wtc:array id="sid_arr" scope="end" />
	<%
		if(sid_arr!=null&&sid_arr.length>0)
		{
		 
				%><HEAD><TITLE>紧急开机</TITLE>
			</HEAD>

			<body>
			<!--
			<DIV><img class='hideEl' src='jia.gif'   style='cursor:hand' width='15' height='15' onclick="show()">&nbsp;&nbsp;<img class='hideEl' src='jian.gif'   style='cursor:hand' width='15' height='15' onclick="hide()"></DIV>
			-->
			<FORM method=post name="frm1507_3">
			
				<DIV id="Operation_Table">
				<div class="title">
					<div id="title_zi">担保开机</div>
				</div>
				<table cellspacing="0" id="tabList">
				<%
					//for(int i =0;i<sid_arr.length;i++)
					//{
						%>
							<tr>
								<td>担保人手机号码</td><td><%=phone_no%></td>
								<td>担保人姓名</td><td><%=sid_arr[0][4]%></td>
							</tr>
							<tr>
								<td>担保人星级</td>
								<td ><%=sid_arr[0][5]%></td>
								<input type="hidden" id="i_level" value="<%=sid_arr[0][0]%>">
								<td>担保开机时长（小时</td>
								<td><input type="text" id="dqsj" onKeyPress="return isKeyNumberdot(0)">
									<font color="red">(最长<%=sid_arr[0][1]%>小时)</font>
								</td>
							</tr>
							<tr>
								<td>已办理次数</td>
								<td><%=sid_arr[0][2]%></td>
								<td>最多可办理次数</td>
								<td><%=sid_arr[0][3]%></td>
							</tr>
						<%
					//}
				%>
				
				 
				 
					<td align="center" id="footer" colspan="9">
					&nbsp; <input class="b_foot" name=doCfm onClick="doCfms()" type="button" value="确认">	 
					&nbsp; <input class="b_foot" name=back onClick="window.location='g635_1.jsp'" type="button" value="返回">
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
			%>
				<script language="javascript">
						rdShowMessageDialog("服务报错!错误代码"+"<%=s_code%>"+",错误信息"+"<%=s_msg%>");
						history.go(-1);
				</script>
			<%
			 
				
		}
	

 %>

 
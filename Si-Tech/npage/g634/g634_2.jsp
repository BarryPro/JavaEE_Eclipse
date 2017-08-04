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
	String workNo = (String)session.getAttribute("workNo");
	String opCode ="g634"; //"d223";
	String opName = "紧急开机";//"退费统计";
	String regionCode= (String)session.getAttribute("regCode"); 
	String phone_no = request.getParameter("phone_no");	
	String cust_name="";
	String cust_level="";
	String s_hours="";
	String[] inParas0 = new String[2];
	inParas0[0]="select to_char(b.phone_No),trim(a.cust_name),to_char(b.ilevel),to_char(d.hours) from dcustdoc a,dCustLevel b,dcustmsg c,cUrgent_offon d where a.cust_id = c.cust_id and b.id_no=c.id_no and c.phone_No=:phone_no and b.ilevel = d.ilevel ";
	inParas0[1]="phone_no="+phone_no;
	String s_idNo="";

	//xl add 等级判断
	String[] inParas_check = new String[1];
	inParas_check[0]="select to_char(ILEVEL),to_char(hours),op_note from cUrgent_offon";
	%>
	<wtc:service name="TlsPubSelBoss"  outnum="3" >
			<wtc:param value="<%=inParas_check[0]%>"/>
	</wtc:service>
	<wtc:array id="result0" scope="end" />
	<%
		if(result0==null||result0.length==0){
		System.out.println("888888888888888888888888weikong");
		 
		%>
		<script language="javascript">
			 
			rdShowMessageDialog("服务未能成功,错误信息：查询配置信息为空!");
			//history.go(-1); 
		</script>
	<%}
 
	%>
<script language="javascript">
	//定义全局变量
  var project_code = new Array();
  var transin_fee = new Array();//where条件 是 projectCode 要查询显示的是 fee
  var op_notes=new Array();
	 
<%
	System.out.println("qweqwe1888888888888888888888888888881111111111111");
	if(result0.length >0){
		for(int m=0;m<result0.length;m++)
		  {
			out.println("project_code["+m+"]='"+result0[m][0]+"';\n");
			out.println("transin_fee["+m+" ]='"+result0[m][1]+"';\n");
			out.println("op_notes["+m+" ]='"+result0[m][2]+"';\n");
		  }
	}
	else{
	System.out.println("qweqwe9888800000000000000000111");
	}
%>
	 
	function doCfms()
	{
		var prtFlag=0;
		var ilevel = document.getElementById("i_level").value;
		var hours = document.getElementById("dqsj").value;
		prtFlag = window.confirm("是否确认办理紧急开机?");

		var actions = "g634_3.jsp?phone_no=<%=phone_no%>"+"&iLevel="+ilevel+"&hours="+hours;

		if (prtFlag==1)
		{
			document.all.frm1507_2.action=actions;
			document.all.frm1507_2.submit();
		}
		else
		{
			return false;
		}
		
	}
</script>
		

<!--xl add for zhaorh sEmergencyInit-->
<wtc:service name="sEmergencyInit" retcode="s_code" retmsg="s_msg"  outnum="6" >
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="g634"/>
			<wtc:param value="01"/>
</wtc:service>
<wtc:array id="s_eme_id" scope="end" />

	<%
		if(s_eme_id!=null &&s_eme_id.length>0 )
		{
			cust_name=s_eme_id[0][4];
			cust_level=s_eme_id[0][0];
			s_hours=s_eme_id[0][1];
				%><HEAD><TITLE>紧急开机</TITLE>
			</HEAD>

			<body>
			<!--
			<DIV><img class='hideEl' src='jia.gif'   style='cursor:hand' width='15' height='15' onclick="show()">&nbsp;&nbsp;<img class='hideEl' src='jian.gif'   style='cursor:hand' width='15' height='15' onclick="hide()"></DIV>
			-->
			<FORM method=post name="frm1507_2">
				<%@ include file="/npage/include/header.jsp" %>
				<DIV id="Operation_Table">
				<div class="title">
					<div id="title_zi">紧急开机</div>
				</div>
				<table cellspacing="0" id="tabList">
				<%
					//for(int i =0;i<sid_arr.length;i++)
					{
						%>
							<tr>
								<td>手机号码</td><td><%=phone_no%></td>
								<td>姓名</td><td><%=cust_name%></td>
							</tr>
							<tr>
								<td>客户等级</td><td><%=s_eme_id[0][5]%></td>
								<input type="hidden" id="i_level" value="<%=cust_level%>">
								<td>紧急开机时长（小时）</td>
								<td><input type="text" name="dqsj" onKeyPress="return isKeyNumberdot(0)"  ><font color="red">(最长<%=s_eme_id[0][1]%>小时)</font></td>
								<input type="hidden" id="i_hour" value="<%=s_eme_id[0][1]%>">
							</tr>
							<tr>
								<td>已办理次数</td><td><%=s_eme_id[0][2]%></td>
								<td>每月允许办理次数</td><td><%=s_eme_id[0][3]%></td>
							</tr>
						<%
					}
				%>
				
				 
				 
					<td align="center" id="footer" colspan="9">
					&nbsp; <input class="b_foot" name=doCfm onClick="doCfms()" type="button" value="确认">	 
					&nbsp; <input class="b_foot" name=back onClick="window.location='g634_1.jsp'" type="button" value="返回">
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
			if(s_eme_id==null || s_eme_id.length==0)
			{
				%>
					<script language="javascript">
						rdShowMessageDialog("服务报错!错误代码"+"<%=s_code%>"+",错误信息"+"<%=s_msg%>");
						history.go(-1);
					</script>
				<%
			}			
				
		}
	

 %>

 
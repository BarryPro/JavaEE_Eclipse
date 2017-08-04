<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%
String opCode = "g468";
String opName = "终端刷码/二码拆包不认可充值";
String workno = (String)session.getAttribute("workNo");
String workname =(String)session.getAttribute("workName");
String orgcode =(String)session.getAttribute("orgCode");//机构代码
String nopass =(String)session.getAttribute("password");
String regionCode = orgcode.substring(0,2);
String op_code = "g468"  ;
String remark = request.getParameter("remark");
String sSaveName = request.getParameter("sSaveName");
String filename = request.getParameter("filename"); 
 
//System.out.println("seed====="+seled);
//String serverIp=request.getServerName();
String serverIp=realip.trim();
System.out.println("serverIp:"+serverIp);
//System.out.println("3_SBillItem:"+billitem);
String total_fee = "";
String total_no = "";
	int flag = 0;
//xl add for zhaoyy date textarea两个字段
String beginDate = request.getParameter("beginDate"); 
String phones = request.getParameter("phones"); 
String out_flag="";//根据他判断是否展示报错信息 a文件 b直接页面不展示错误信息
String s_wrong_phone_0="";
String s_wrong_msg_0="";
String s_wrong_phone_1="";
String s_wrong_msg_1="";
String s_wrong_phone_2="";
String s_wrong_msg_2="";

//直接录入报错的
String s_wrong_phone_input_0="";
String s_wrong_msg_input_0="";
String s_wrong_phone_input_1="";
String s_wrong_msg_input_1="";
String s_wrong_phone_input_2="";
String s_wrong_msg_input_2="";
%>
	<wtc:service name="s247cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="17" >
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=orgcode%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=sSaveName%>"/>
		<wtc:param value="<%=serverIp%>"/>
 		<wtc:param value="<%=beginDate%>"/>
		<wtc:param value="<%=phones%>"/>
	</wtc:service>
	<wtc:array id="result" start="0" length="5" scope="end"/>
	<wtc:array id="wrong_msg" start="5" length="2" scope="end"/>
	<wtc:array id="wrong_input" start="7" length="2" scope="end"/>
<%   
	sReturnCode = result[0][0];
	sErrorMessage = result[0][1];
	if(!sReturnCode.equals("000000")){
		flag = -1;
		System.out.println(" 错误信息 : " + sErrorMessage);
	}
	System.out.println("AAAAAAAAAAAAAAAAAAAa teat flag is: " + flag +" and sReturnCode is "+sReturnCode);	
	if (flag == 0)
	{	
		total_fee = result[0][2];
		total_no = result[0][3];
		out_flag= result[0][4];
	}
	else
	{
		//System.out.println("failed, 请检查 !");
	}
	/*xl add for excel导出*/
	
%>
<HEAD><TITLE>黑龙江BOSS-二码合一返费</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
<!--
function gohome()
{
document.location.replace("g468_1.jsp");
}
-->
</script>
</HEAD>
<BODY>
<FORM action="g468_1.jsp" method=post name=form>
	
   <%@ include file="/npage/include/header.jsp" %>
		<table cellspacing="0">
		  <tbody> 
		  <tr> 
		    <td class="blue">操作类型</td>
		    <td >
		         二码合一返费录入
		    </td>
		    <td ></td>
		    <td class="blue">部门 <%=orgcode%></td>
		  </tr>
		  </tbody> 
		</table> 
		<table cellspacing="0">
		   <tbody> 
		    <tr > 
		      <td colspan="2">
		        <div align="center">二码合一返费录入完成。
					
					<br> 					
					   <% if (flag == 0){%>成功数量：<%=total_no%>。
		           <% } else { 
					  		
					   %>
		             
		           <% } %>
						<%
						   if(out_flag=="a" ||out_flag.equals("a"))
						   {
						   %>
						   <!-- 
						   <br>失败的号码，请检查<a target="_blank" href="/npage/tmp/<%=filename%>.err"><%=filename%>.err</a>文件。
						    -->
						   <%
						   }   
					    %>
					      
						  
					 </div>
		      </td>
		    </tr>
			
		    </tbody> 
		</table>
		<!--xl add for excel导出-->
	<%
		if(wrong_msg.length>0)
		{
			%>
				<br> 
			<table cellspacing="0" id="tabList">
				
				<tr>
					<th nowrap>错误号码</th>
					<th nowrap>错误信息</th>
				</tr>
				<%
					if(wrong_msg.length>0)
					{
						System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA wrong_msg.length is "+wrong_msg.length);
						for(int i=0;i<wrong_msg.length;i++)
						{
							s_wrong_phone_0=wrong_msg[i][0];
							s_wrong_msg_0=wrong_msg[i][1];
					 
							System.out.println("DDDDDDDDDDDDDDDDDDDDDd s_wrong_phone_0 is "+s_wrong_phone_0+" and s_wrong_msg_0 is "+s_wrong_msg_0+" and s_wrong_phone_1 is "+s_wrong_phone_1+" and s_wrong_msg_1 is "+s_wrong_msg_1+" and s_wrong_phone_2 is "+s_wrong_phone_2+" and s_wrong_msg_2 is "+s_wrong_msg_2);
							%>
								<%
									if(s_wrong_phone_0!=null &&s_wrong_msg_0!=null)
									{	
											%>
											<tr>
									<td><%=s_wrong_phone_0%></td>
									<td><%=s_wrong_msg_0%></td>
											</tr>
											<%
									}
								%>
								<%
									 
								%>
								 
								<%
									 
								%> 
							<%
							
							 
						}	
					}
				%>
				<tr>
				<!--
					<td colspan=2 align=center><input class="b_foot" name="sure" type="button" value="导出XLS" onClick="printTable(tabList);"></td>-->
				</tr>
			</table>
		<br>
			<%
		}
		//xl add for 页面直接录入时报错 导出
		if(wrong_input.length>0)
		{
			System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAssssssssssssssssssssssssss test wrong_input.length is "+wrong_input.length);
			%>
			<table cellspacing="0" id="tabList2">
			<br>页面录入报错信息-EXCEL导出
			
				
				<tr>
					<th nowrap>错误号码</th>
					<th nowrap>错误信息</th>
				</tr>
			<%
			for(int i=0;i<wrong_input.length;i++)
			{
				s_wrong_phone_input_0=wrong_input[i][0];
				s_wrong_msg_input_0=wrong_input[i][1];
			 
				%>
				
				<%
					if(s_wrong_phone_input_0!=null &&s_wrong_msg_input_0!=null)
					{	
							%>
							<tr>
					<td><%=s_wrong_phone_input_0%></td>
					<td><%=s_wrong_msg_input_0%></td>
							</tr>
							<%
					}
					 
				 
			}
			%>
			<tr>
					<td colspan=2 align=center><input class="b_foot" name="sure" type="button" value="导出XLS" onClick="printTable2(tabList2);"></td>
			</tr>
			</table><% 
		}
	%>
		
		<table cellspacing="0">
		  <tbody> 
		  <tr id="footer"> 
		    <td align=center bgcolor="F5F5F5" width="100%"> 
		      <input class="b_foot" name=sure disabled type=submit value=确认>
		      <input class="b_foot" name=reset type=reset value=返回 onClick="gohome()">
		      &nbsp; </td>
		  </tr>
		  </tbody> 
		</table>
		<%@ include file="/npage/include/footer.jsp" %>
</FORM>

<script language="javascript">
	var excelObj;
function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.tabList.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 excelObj.WorkBooks.Add;
		for(a=0;a<document.all.tabList.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						for(j=0;j<cells;j++)
							excelObj.Cells(i+1+(total_row),j+1).Value=obj[a].rows[i].cells[j].innerText;
					}
				}
				catch(e)
				{
					//alert('生成excel失败!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
	}
	else
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 excelObj.WorkBooks.Add;
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					for(j=0;j<cells;j++)
						excelObj.Cells(i+1,j+1).Value=obj.rows[i].cells[j].innerText;
				}
			}
			catch(e)
			{
				//alert('生成excel失败!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
}
</script>

<script language="javascript">
	var excelObj;
function printTable2(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.tabList2.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 excelObj.WorkBooks.Add;
		for(a=0;a<document.all.tabList2.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						for(j=0;j<cells;j++)
							excelObj.Cells(i+1+(total_row),j+1).Value=obj[a].rows[i].cells[j].innerText;
					}
				}
				catch(e)
				{
					//alert('生成excel失败!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
	}
	else
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 excelObj.WorkBooks.Add;
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					for(j=0;j<cells;j++)
						excelObj.Cells(i+1,j+1).Value=obj.rows[i].cells[j].innerText;
				}
			}
			catch(e)
			{
				//alert('生成excel失败!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
}
</script>


</BODY></HTML>




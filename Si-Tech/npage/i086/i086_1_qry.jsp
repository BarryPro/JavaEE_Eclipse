<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
      String opCode = "i086";
	  String opName = "专款及账目项查询";
	  String s_paytype=request.getParameter("s_paytype");
	  String workno = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  //开始 结束
	 
	  String ret_val[][];
	  String ret_val_new[][];
	 /* int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 10;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;
		int recordcount=0;
	*/
//拼接sql 使用stringBuffer where 1=1 and~~   sbuffer.append("");
/*
设计： 这里应该是for循环,分别取出每个月的分表的记录，然后展现?
	   for循环的条件是 YYYYMM取出月数。
	   for(k=vBeginTime;k<=vEndTime;)
	   int iBegin = Integer.parseInt(print_begin);
int iEnd = Integer.parseInt(print_end);
int vYear=0;
int vMonth = 0;
vYear = iBegin/100;
vMonth=iBegin%100;	
int k = 0;
*/
 
%>
<wtc:service name="bi086Qry" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="14">
		    <wtc:param value="<%=s_paytype%>"/>
			<wtc:param value="<%=workno%>"/>
</wtc:service>
<wtc:array id="mainInfo1" start="2" length="5" scope="end"/>
<wtc:array id="mainInfo2" start="7" length="3" scope="end"/>
<wtc:array id="mainInfo3" start="10" length="4" scope="end"/>    

<%
		String errCode = retCode2;
		String errMsg = retMsg2;
	 
		String[][] result1  = null ;
		String[][] result2  = null ;
		String[][] result3  = null ;
		result1 = mainInfo1;
		result2 = mainInfo2;
		result3 = mainInfo3;
		if(retCode2.equals("0")||retCode2.equals("000000"))
		{
			System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCC 成功");
			%>
				<script language = "javascript">
					function toExcel(){
						 var oXL = new ActiveXObject("Excel.Application"); 
					　　 var oWB = oXL.Workbooks.Add(); 
					　　 var oSheet = oWB.ActiveSheet; 
					　　 var Lenr = PrintA.rows.length;
					　　 for (i=0;i<Lenr;i++) 
					　　 { 
					　　 var Lenc = PrintA.rows(i).cells.length; 
					　　 for (j=0;j<Lenc;j++) 
					　　 { 
					　　 oSheet.Cells(i+1,j+1).value = PrintA.rows(i).cells(j).innerText; 
					　　 } 
					　　 } 
					　　 oXL.Visible = true; 
					}
				</script>
				<html xmlns="http://www.w3.org/1999/xhtml">
				<HEAD><TITLE>查询结果</TITLE>
				</HEAD>
				<body>


				<FORM method=post name="frm1508_2">
				<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">查询结果</div>
				</div>

					  <table cellspacing="0" id = "PrintA">
								<tr> 
									<th>专款名称</th>
									<th>专款是否可转</th>
									<th>专款是否可退</th>
									<th>专款前台是否可见</th>
									<th>专款冲销优先级</th>
									
								</tr>
						<%
							for(int i=0;i<result1.length;i++)
							{
								%>
									<tr>
										<td>
											<%=result1[i][0]%>
										</td>
										<td>
											<%=result1[i][1]%>
										</td>
										<td>
											<%=result1[i][2]%>
										</td>
										<td>
											<%=result1[i][3]%>
										</td>
										<td>
											<%=result1[i][4]%>
										</td>
									</tr>
								<%
							}
					    %>	
						<tr id="footer"> 
							<td colspan="9">
							  <input class="b_foot" name=back onClick="window.location = 'i086_1.jsp' " type=button value=返回>
							  <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
							</td>
						</tr>
						<tr >
						<th colspan=5 align="left">专款到期回收落账的账目项</th>
						</tr>
						<%
							if(result2.length==0)
							{
								%>
								<tr>
									<td colspan=5>
										无此专款回收落帐记录。						
									</td>
								</tr>
								<%
							}
							else
							{
								for(int j =0;j<result2.length;j++)
								{
									if(result2[j][0]==""||result2[j][0].equals(""))
									{
										%>
										<tr>
											<td colspan=5>
												无此专款回收落帐记录。						
											</td>
										</tr>
										<%
									}
									else
									{
										%>
										<tr>
											<td colspan=5>
												回收款落账到已有账目项:<p>
												一级账目项：<%=result2[j][0]%><p>
												二级账目项：<%=result2[j][1]%><p>
												三级账目项：<%=result2[j][2]%>						
											</td>
										</tr>
										<%
									}			
									
								}
							}
						%>
						<tr >
						<th colspan=5 align="left">专款可冲销账目项
						</th>
						</tr>
						<tr>
							<th>一级账目项代码</th>
							<th>一级账目项名称</th>
							<th>二级账目项代码</th>
							<th colspan=2>二级账目项名称</th>
						</tr>
						<%
							for(int k=0;k<result3.length;k++)
							{
								%>
									<tr>
										<td><%=result3[k][0]%></td>
										<td><%=result3[k][1]%></td>
										<td><%=result3[k][2]%></td>
										<td colspan=2><%=result3[k][3]%></td>
									</tr>
								<%
							}
						%>

						  <tr id="footer"> 
							<td colspan="9">
							  <input class="b_foot" name=back onClick="window.location = 'i086_1.jsp' " type=button value=返回>
							  <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
							</td>
						  </tr>
						  
					  </table>
					  <tr id="footer"> 
						   
						  </tr>
					
						
							
						

				<%@ include file="/npage/include/footer.jsp" %>
				</FORM>
				</BODY></HTML>
			<%
		}
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("查询结果为空！");
					window.location.href="i086_1.jsp";
				</script>
			<%
		}
%>	 
 



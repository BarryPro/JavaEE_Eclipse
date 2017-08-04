<% 
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-12 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String work_no = (String)session.getAttribute("workNo");
	
	String opCode = "zgah";
    String opName = "剩余流量转赠业务查询";
	String year_month = request.getParameter("yearmonth");
	String phoneNo  = request.getParameter("phoneNo");
	String work_name=request.getParameter("workName");
	String nopass = (String)session.getAttribute("password");
	//year_month="201603";//先固定
    
 
%>
	<wtc:service name="bs_QueryGprsZY" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="19" >
		<wtc:param value="0"/>
		<wtc:param value="02"/>
		<wtc:param value="zgah"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=year_month%>"/>
	</wtc:service>   
	<wtc:array id="cussidArr0" scope="end" start="0"  length="4"/> 
	<wtc:array id="cussidArr1" scope="end" start="4"  length="3"/>
	<wtc:array id="cussidArr2" scope="end" start="7"  length="1"/>
	<wtc:array id="cussidArr3" scope="end" start="8"  length="5"/>
	<wtc:array id="cussidArr4" scope="end" start="13"  length="3"/>
	<wtc:array id="cussidArr5" scope="end" start="16"  length="3"/>
<%
	if(retCode1=="000000" ||retCode1.equals("000000"))
	{
		%>
			<HTML>
				<HEAD>
				<title>剩余流量转赠业务查询</title>
				</HEAD>
			<BODY>
			<FORM method=post name="frm5186">
				<%@ include file="/npage/include/header.jsp" %>     	
					<div class="title">
						<div id="title_zi">剩余流量转赠业务查询</div>
					</div>
					<div class="title">
						<div id="title_zi">剩余可转赠流量信息(国内流量)</div>
				   </div>
				   <TABLe cellSpacing="0">
					<tr>
							<td class="blue">应优惠流量</TD>
							<TD><input class="InputGrey" name="totalFav" value="<%=cussidArr0[0][2]%>" maxlength="25" size=20 readonly>MB</TD>
							<td class="blue">已使用流量</TD>
							<TD><input class="InputGrey" value="<%=cussidArr0[0][3]%>" maxlength="25" size=20 readonly>MB</TD>
					</tr>
					<tr>
							<td class="blue">剩余可转赠流量国内流量</TD>
							<td colspan="3"><input class="InputGrey" value="<%=cussidArr2[0][0]%>" readonly>MB</td>
							
						</tr>
					</table>
					 
					<div class="title">
						<div id="title_zi">剩余可转赠流量明细信息(国内流量)</div>
				    </div>
					<TABLe cellSpacing="0">
						<%
							for(int i=0;i<cussidArr1.length;i++)
							{
								%>
									<tr>
										<td class="blue">套餐名称 <input class="InputGrey" value="<%=cussidArr1[i][0]%>" readonly size="50"></td>
										<td class="blue">套餐内应优惠 <input class="InputGrey" value="<%=cussidArr1[i][1]%>" readonly>Mb</td>
										<td class="blue">套餐内已使用 <input class="InputGrey" value="<%=cussidArr1[i][2]%>" readonly>Mb</td>
									</tr>
								<%
							}
						%>
						</table>
						
					<!--新增的出参-->
				 
					<div class="title">
							<div id="title_zi">剩余可转赠流量(省内流量)</div>
					</div>
					<TABLe cellSpacing="0">
					<tr>
							<td class="blue">应优惠流量</TD>
							<TD><input class="InputGrey" name="totalFav" value="<%=cussidArr4[0][0]%>" maxlength="25" size=20 readonly>MB</TD>
							<td class="blue">已使用流量</TD>
							<TD><input class="InputGrey" value="<%=cussidArr4[0][1]%>" maxlength="25" size=20 readonly>MB</TD>
					</tr>
					<tr>
							<td class="blue">剩余可转赠流量省内流量</TD>
							<td colspan="3"><input class="InputGrey" value="<%=cussidArr4[0][2]%>" readonly>MB</td>
							
						</tr>
					</TABLe>
					<div class="title">
						<div id="title_zi">剩余可转赠流量明细信息(省内流量)</div>
				    </div>
					<TABLe cellSpacing="0">
					<tr>
								<td class="blue">可转赠套餐名称</td>
								<td class="blue">可转赠套餐内应优惠流量</td>
								<td class="blue">可转赠套餐已使用流量</td>
					 
							</tr>
						<%
							for(int i=0;i<cussidArr5.length;i++)
							{
								%>
									<tr>
										<td class="blue"><input class="InputGrey" value="<%=cussidArr5[i][0]%>" readonly></td>
										<td class="blue"><input class="InputGrey" size="35" value="<%=cussidArr5[i][1]%>" readonly></td>
										<td class="blue"><input class="InputGrey" value="<%=cussidArr5[i][2]%>" readonly>Mb</td>
									</tr>
								<%
							}
						%>
					</table>
					<div class="title">
							<div id="title_zi">剩余流量信息展示</div>
						</div>
						<TABLe cellSpacing="0">
							<tr>
								<td class="blue">gprs资费代码</td>
								<td class="blue">gprs资费名称</td>
								<td class="blue">gprs套餐内应优惠</td>
								<td class="blue">gprs套餐内已使用</td>
								<td class="blue">gprs套餐内剩余</td>
							</tr>
						<%
							for(int i=0;i<cussidArr3.length;i++)
							{
								%>
									<tr>
										<td class="blue"><input class="InputGrey" value="<%=cussidArr3[i][0]%>" readonly></td>
										<td class="blue"><input class="InputGrey" size="35" value="<%=cussidArr3[i][1]%>" readonly></td>
										<td class="blue"><input class="InputGrey" value="<%=cussidArr3[i][2]%>" readonly>Mb</td>
										<td class="blue"><input class="InputGrey" value="<%=cussidArr3[i][3]%>" readonly>Mb</td>
										<td class="blue"><input class="InputGrey" value="<%=cussidArr3[i][4]%>" readonly>Mb</td>
									</tr>
								<%
							}
						%>
					</TABLe>
				  <TABLE cellSpacing="0">
					<TR> 
					  <TD id="footer"> 
						  <input type="button"  name="back"  class="b_foot" value="返回" onClick="history.go(-1)">
						  <input type="button"  name="back"  class="b_foot" value="关闭" onClick="removeCurrentTab()">
					  </TD>
					</TR>
					 
				  </TABLE>
				<%@ include file="/npage/include/footer.jsp" %>
				</FORM>
				</body>
			</html>
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("剩余流量转赠业务查询失败,错误代码:"+"<%=retCode1%>"+",错误信息:"+"<%=retMsg1%>");
				history.go(-1);
			</script>
		<%
	}
%>
 
 




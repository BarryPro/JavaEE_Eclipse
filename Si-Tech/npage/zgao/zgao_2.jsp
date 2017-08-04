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
	
	String opCode = "zgao";
    String opName = "家庭优惠资源查询";
	String year_month = request.getParameter("yearmonth");
	String open_time  ="";
	String cust_name  ="";
	String phoneNo  = request.getParameter("phoneNo");
	String work_name=request.getParameter("workName");
	String nopass = (String)session.getAttribute("password");
	//String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String  dateStr= year_month;

	String totalFav = "无";
	String usedFav = "无";
	String totalCmwap = "无";
	String usedCmwap = "无";
	String totalMessFav = "无";
	String usedMessFav = "无";
	String totalGprsFav = "无";
	String usedGprsFav = "无";
	String otherGprsFav ="无";
    String partGprsFav ="无";
	String partUsedGprsFav ="无";
	String sqlStr = "";
	
	//xl add 新需求 增加"套餐名称 应优惠 已优惠"等信息
	int rownum0=0;

	//String [] cussidArr=co.callService("sGetUserFavMsg",inputParsm,"6","phone",phoneNo);
	//增加省内的 下标20-23
%>
	<wtc:service name="sGetFamFavAll" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="24" >
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=dateStr%>"/>
	</wtc:service>   
	<wtc:array id="r_ret1" scope="end" start="0"  length="4" />	
	<wtc:array id="r_ret2" scope="end" start="4"  length="4" />
	<wtc:array id="r_ret3" scope="end" start="8"  length="4" />
	<wtc:array id="r_retyj" scope="end" start="12"  length="2" />
	<wtc:array id="r_retivr" scope="end" start="14"  length="6" />
	<wtc:array id="r_retsn" scope="end" start="20"  length="4" />
<%
	if(retCode1=="000000"||retCode1.equals("000000"))
	{
		if(retCode1=="000000"||retCode1.equals("000000"))
		{
			System.out.println("ccccccccccccccccccccccccccccccccccccc r_ret2 is "+r_ret2+" and r_ret2.length is "+r_ret2.length+" and r_ret1 is "+r_ret1.length+" and r_ret3 is "+r_ret3.length+" and r_retyj is "+r_retyj.length);
			%>
				 <HTML>
			<HEAD>
			<title>优惠信息查询</title>
			</HEAD>
		<BODY>
		<FORM method=post name="frm5186">
			<%@ include file="/npage/include/header.jsp" %>     	
				<div class="title">
					<div id="title_zi">优惠信息查询</div>
				</div>
				<TABLe cellSpacing="0">
				<TR> 
					<td class="blue">服务号码</TD>
				  <td>
					<input type="text" readonly class="InputGrey" name="phoneNo" size="20" maxlength="11" value=<%=phoneNo%>
				  </td>
				  <td class="blue">查询年月</td>
		   
				  <td class="blue"><%=dateStr%></td>
				   <input type="hidden" readonly class="InputGrey" name="nopass" size="20" maxlength="11" value=<%=nopass%>
				  </td>
				   
				</table> 
			   <div class="title">
					<div id="title_zi">家庭优惠信息查询</div>
			   </div>
			   <TABLe cellSpacing="0">
				<!--xl add 查分多组进行展示-->
			   <%
					for(int i=0;i<r_ret1.length;i++)
					{
						//r_ret1[i][2]=null;
						float f_yy=0.00f;
						float f_yy1=0.00f;
						if(r_ret1[i][2]!=null &&r_ret1[i][3] !=null)
						{
							f_yy = Float.parseFloat(r_ret1[i][2])-Float.parseFloat(r_ret1[i][3]);
							BigDecimal b_yy = new BigDecimal(f_yy);
							f_yy1 = b_yy.setScale(2,BigDecimal.ROUND_HALF_UP).floatValue();
						}
						
						
						%>
						<tr>
								<td class="blue">语音基本资费名称</TD>
								<TD><%=r_ret1[i][0]==null?"无":r_ret1[i][0]%></TD>
								<td class="blue">语音基本资费代码</TD>
								<TD><%=r_ret1[i][1]==null?"无":r_ret1[i][1]%></TD>
						</tr>
						<tr>
								<td class="blue" colspan=4>语音基本应优惠量<%=r_ret1[i][2]==null?"无":r_ret1[i][2]%>分钟,语音基本已优惠量<%=r_ret1[i][3]==null?"无":r_ret1[i][3]%>分钟,语音剩余<%=f_yy1%>分钟</TD>
						</tr>
						<%
					}
					
					for(int j=0;j<r_ret2.length;j++)
					{
						float f_yy3=0.00f;
						f_yy3 = Float.parseFloat(r_ret2[j][2])-Float.parseFloat(r_ret2[j][3]);
						BigDecimal b_yy3 = new BigDecimal(f_yy3);
						float f_ct = b_yy3.setScale(2,BigDecimal.ROUND_HALF_UP).floatValue();
						%>
						<tr>
								<td class="blue">语音长途资费名称</TD>
								<TD><%=r_ret2[j][0]==null?"无":r_ret2[j][0]%></TD>
								<td class="blue">语音长途资费代码</TD>
								<TD><%=r_ret2[j][1]==null?"无":r_ret2[j][1]%></TD>
						</tr>
						<tr>
								<td class="blue" colspan=3>语音长途应优惠量<%=r_ret2[j][2]==null?"无":r_ret2[j][2]%>分钟,语音长途已优惠量<%=r_ret2[j][3]==null?"无":r_ret2[j][3]%>分钟,语音长途剩余<%=f_ct%>分钟</TD>
						</tr>
						<%
					}
					for(int m=0;m<r_ret3.length;m++)
					{
						float f_min=0.00f;
						f_min = Float.parseFloat(r_ret3[m][2])-Float.parseFloat(r_ret3[m][3]);
						BigDecimal b = new BigDecimal(f_min);
						float f1 = b.setScale(2,BigDecimal.ROUND_HALF_UP).floatValue();
						%>
							<tr>
								<td class="blue" colspan=4>
								【gprs资费名称】: <%=r_ret3[m][0]%>&nbsp;&nbsp;&nbsp;&nbsp;
								Gprs资费代码:<%=r_ret3[m][1]%>,&nbsp;&nbsp;&nbsp;&nbsp;
								Gprs应优惠量<%=r_ret3[m][2]%>M,&nbsp;&nbsp;&nbsp;&nbsp;Gprs已优惠量<%=r_ret3[m][3]%>M
								,Gprs剩余量<%=f1%>M
								</td>
							</tr>
						<%
					}
					//xl add 展示省内的
					for(int h=0;h<r_retsn.length;h++)
					{
						float f_min1=0.00f;
						//f_min1 = (float)(Math.round(Float.parseFloat(r_retsn[h][2])-Float.parseFloat(r_retsn[h][3]))*100/100);
						f_min1 =Float.parseFloat(r_retsn[h][2])-Float.parseFloat(r_retsn[h][3]);
						//f_min1 = (Float.parseFloat(r_retsn[h][2])-Float.parseFloat(r_retsn[h][3]))*100/100;
						BigDecimal b2 = new BigDecimal(f_min1);
						float f2 = b2.setScale(2,BigDecimal.ROUND_HALF_UP).floatValue();
						%>
							<tr>
								<td class="blue" colspan=4>
								【省内gprs资费名称】: <%=r_retsn[h][0]==null?"无":r_retsn[h][0]%>&nbsp;&nbsp;&nbsp;&nbsp;
								省内Gprs资费代码:<%=r_retsn[h][1]==null?"无":r_retsn[h][1]%>,&nbsp;&nbsp;&nbsp;&nbsp;
								省内Gprs应优惠量<%=r_retsn[h][2]==null?"无":r_retsn[h][2]%>M,&nbsp;&nbsp;&nbsp;&nbsp;省内Gprs已优惠量<%=r_retsn[h][3]==null?"无":r_retsn[h][3]%>M,省内Gprs剩余量<%=f2%>M</td>
							</tr>
						<%
					}
				%>
			   </table>
			 <TABLE cellSpacing="0">
				<TR> 
				  <TD id="footer"> 
					  <input type="button"  name="back"  class="b_foot" value="返回" onClick="location='zgao_1.jsp?activePhone=<%=phoneNo%>'">
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
					rdShowMessageDialog("查询结果为空,请重新输入查询条件进行查询!");
					history.go(-1);
				</script>
			<%
		}		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("家庭优惠资费查询报错!错误代码:"+"<%=retCode1%>"+",错误原因:"+"<%=retMsg1%>");
					history.go(-1);
			</script>
		<%
	}
	 
	
%> 
 




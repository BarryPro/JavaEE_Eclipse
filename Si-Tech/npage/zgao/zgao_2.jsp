<% 
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-12 ҳ�����,�޸���ʽ
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
    String opName = "��ͥ�Ż���Դ��ѯ";
	String year_month = request.getParameter("yearmonth");
	String open_time  ="";
	String cust_name  ="";
	String phoneNo  = request.getParameter("phoneNo");
	String work_name=request.getParameter("workName");
	String nopass = (String)session.getAttribute("password");
	//String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String  dateStr= year_month;

	String totalFav = "��";
	String usedFav = "��";
	String totalCmwap = "��";
	String usedCmwap = "��";
	String totalMessFav = "��";
	String usedMessFav = "��";
	String totalGprsFav = "��";
	String usedGprsFav = "��";
	String otherGprsFav ="��";
    String partGprsFav ="��";
	String partUsedGprsFav ="��";
	String sqlStr = "";
	
	//xl add ������ ����"�ײ����� Ӧ�Ż� ���Ż�"����Ϣ
	int rownum0=0;

	//String [] cussidArr=co.callService("sGetUserFavMsg",inputParsm,"6","phone",phoneNo);
	//����ʡ�ڵ� �±�20-23
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
			<title>�Ż���Ϣ��ѯ</title>
			</HEAD>
		<BODY>
		<FORM method=post name="frm5186">
			<%@ include file="/npage/include/header.jsp" %>     	
				<div class="title">
					<div id="title_zi">�Ż���Ϣ��ѯ</div>
				</div>
				<TABLe cellSpacing="0">
				<TR> 
					<td class="blue">�������</TD>
				  <td>
					<input type="text" readonly class="InputGrey" name="phoneNo" size="20" maxlength="11" value=<%=phoneNo%>
				  </td>
				  <td class="blue">��ѯ����</td>
		   
				  <td class="blue"><%=dateStr%></td>
				   <input type="hidden" readonly class="InputGrey" name="nopass" size="20" maxlength="11" value=<%=nopass%>
				  </td>
				   
				</table> 
			   <div class="title">
					<div id="title_zi">��ͥ�Ż���Ϣ��ѯ</div>
			   </div>
			   <TABLe cellSpacing="0">
				<!--xl add ��ֶ������չʾ-->
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
								<td class="blue">���������ʷ�����</TD>
								<TD><%=r_ret1[i][0]==null?"��":r_ret1[i][0]%></TD>
								<td class="blue">���������ʷѴ���</TD>
								<TD><%=r_ret1[i][1]==null?"��":r_ret1[i][1]%></TD>
						</tr>
						<tr>
								<td class="blue" colspan=4>��������Ӧ�Ż���<%=r_ret1[i][2]==null?"��":r_ret1[i][2]%>����,�����������Ż���<%=r_ret1[i][3]==null?"��":r_ret1[i][3]%>����,����ʣ��<%=f_yy1%>����</TD>
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
								<td class="blue">������;�ʷ�����</TD>
								<TD><%=r_ret2[j][0]==null?"��":r_ret2[j][0]%></TD>
								<td class="blue">������;�ʷѴ���</TD>
								<TD><%=r_ret2[j][1]==null?"��":r_ret2[j][1]%></TD>
						</tr>
						<tr>
								<td class="blue" colspan=3>������;Ӧ�Ż���<%=r_ret2[j][2]==null?"��":r_ret2[j][2]%>����,������;���Ż���<%=r_ret2[j][3]==null?"��":r_ret2[j][3]%>����,������;ʣ��<%=f_ct%>����</TD>
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
								��gprs�ʷ����ơ�: <%=r_ret3[m][0]%>&nbsp;&nbsp;&nbsp;&nbsp;
								Gprs�ʷѴ���:<%=r_ret3[m][1]%>,&nbsp;&nbsp;&nbsp;&nbsp;
								GprsӦ�Ż���<%=r_ret3[m][2]%>M,&nbsp;&nbsp;&nbsp;&nbsp;Gprs���Ż���<%=r_ret3[m][3]%>M
								,Gprsʣ����<%=f1%>M
								</td>
							</tr>
						<%
					}
					//xl add չʾʡ�ڵ�
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
								��ʡ��gprs�ʷ����ơ�: <%=r_retsn[h][0]==null?"��":r_retsn[h][0]%>&nbsp;&nbsp;&nbsp;&nbsp;
								ʡ��Gprs�ʷѴ���:<%=r_retsn[h][1]==null?"��":r_retsn[h][1]%>,&nbsp;&nbsp;&nbsp;&nbsp;
								ʡ��GprsӦ�Ż���<%=r_retsn[h][2]==null?"��":r_retsn[h][2]%>M,&nbsp;&nbsp;&nbsp;&nbsp;ʡ��Gprs���Ż���<%=r_retsn[h][3]==null?"��":r_retsn[h][3]%>M,ʡ��Gprsʣ����<%=f2%>M</td>
							</tr>
						<%
					}
				%>
			   </table>
			 <TABLE cellSpacing="0">
				<TR> 
				  <TD id="footer"> 
					  <input type="button"  name="back"  class="b_foot" value="����" onClick="location='zgao_1.jsp?activePhone=<%=phoneNo%>'">
					  <input type="button"  name="back"  class="b_foot" value="�ر�" onClick="removeCurrentTab()">
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
					rdShowMessageDialog("��ѯ���Ϊ��,�����������ѯ�������в�ѯ!");
					history.go(-1);
				</script>
			<%
		}		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("��ͥ�Ż��ʷѲ�ѯ����!�������:"+"<%=retCode1%>"+",����ԭ��:"+"<%=retMsg1%>");
					history.go(-1);
			</script>
		<%
	}
	 
	
%> 
 




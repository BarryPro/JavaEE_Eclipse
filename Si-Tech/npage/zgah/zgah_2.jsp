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
	
	String opCode = "zgah";
    String opName = "ʣ������ת��ҵ���ѯ";
	String year_month = request.getParameter("yearmonth");
	String phoneNo  = request.getParameter("phoneNo");
	String work_name=request.getParameter("workName");
	String nopass = (String)session.getAttribute("password");
	//year_month="201603";//�ȹ̶�
    
 
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
				<title>ʣ������ת��ҵ���ѯ</title>
				</HEAD>
			<BODY>
			<FORM method=post name="frm5186">
				<%@ include file="/npage/include/header.jsp" %>     	
					<div class="title">
						<div id="title_zi">ʣ������ת��ҵ���ѯ</div>
					</div>
					<div class="title">
						<div id="title_zi">ʣ���ת��������Ϣ(��������)</div>
				   </div>
				   <TABLe cellSpacing="0">
					<tr>
							<td class="blue">Ӧ�Ż�����</TD>
							<TD><input class="InputGrey" name="totalFav" value="<%=cussidArr0[0][2]%>" maxlength="25" size=20 readonly>MB</TD>
							<td class="blue">��ʹ������</TD>
							<TD><input class="InputGrey" value="<%=cussidArr0[0][3]%>" maxlength="25" size=20 readonly>MB</TD>
					</tr>
					<tr>
							<td class="blue">ʣ���ת��������������</TD>
							<td colspan="3"><input class="InputGrey" value="<%=cussidArr2[0][0]%>" readonly>MB</td>
							
						</tr>
					</table>
					 
					<div class="title">
						<div id="title_zi">ʣ���ת��������ϸ��Ϣ(��������)</div>
				    </div>
					<TABLe cellSpacing="0">
						<%
							for(int i=0;i<cussidArr1.length;i++)
							{
								%>
									<tr>
										<td class="blue">�ײ����� <input class="InputGrey" value="<%=cussidArr1[i][0]%>" readonly size="50"></td>
										<td class="blue">�ײ���Ӧ�Ż� <input class="InputGrey" value="<%=cussidArr1[i][1]%>" readonly>Mb</td>
										<td class="blue">�ײ�����ʹ�� <input class="InputGrey" value="<%=cussidArr1[i][2]%>" readonly>Mb</td>
									</tr>
								<%
							}
						%>
						</table>
						
					<!--�����ĳ���-->
				 
					<div class="title">
							<div id="title_zi">ʣ���ת������(ʡ������)</div>
					</div>
					<TABLe cellSpacing="0">
					<tr>
							<td class="blue">Ӧ�Ż�����</TD>
							<TD><input class="InputGrey" name="totalFav" value="<%=cussidArr4[0][0]%>" maxlength="25" size=20 readonly>MB</TD>
							<td class="blue">��ʹ������</TD>
							<TD><input class="InputGrey" value="<%=cussidArr4[0][1]%>" maxlength="25" size=20 readonly>MB</TD>
					</tr>
					<tr>
							<td class="blue">ʣ���ת������ʡ������</TD>
							<td colspan="3"><input class="InputGrey" value="<%=cussidArr4[0][2]%>" readonly>MB</td>
							
						</tr>
					</TABLe>
					<div class="title">
						<div id="title_zi">ʣ���ת��������ϸ��Ϣ(ʡ������)</div>
				    </div>
					<TABLe cellSpacing="0">
					<tr>
								<td class="blue">��ת���ײ�����</td>
								<td class="blue">��ת���ײ���Ӧ�Ż�����</td>
								<td class="blue">��ת���ײ���ʹ������</td>
					 
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
							<div id="title_zi">ʣ��������Ϣչʾ</div>
						</div>
						<TABLe cellSpacing="0">
							<tr>
								<td class="blue">gprs�ʷѴ���</td>
								<td class="blue">gprs�ʷ�����</td>
								<td class="blue">gprs�ײ���Ӧ�Ż�</td>
								<td class="blue">gprs�ײ�����ʹ��</td>
								<td class="blue">gprs�ײ���ʣ��</td>
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
						  <input type="button"  name="back"  class="b_foot" value="����" onClick="history.go(-1)">
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
				rdShowMessageDialog("ʣ������ת��ҵ���ѯʧ��,�������:"+"<%=retCode1%>"+",������Ϣ:"+"<%=retMsg1%>");
				history.go(-1);
			</script>
		<%
	}
%>
 
 




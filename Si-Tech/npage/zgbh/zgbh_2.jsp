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
	String nopass = (String)session.getAttribute("password");
	String opCode = "zgbh";
    String opName = "��ͥ��Աδ���˲�ѯ";
	String s_flag = request.getParameter("s_flag");//1=���� 2=����
	String phone_no = request.getParameter("phone_no"); 
	String s_phone="";
	String s_fk_unbill="";
	if(s_flag=="1" ||s_flag.equals("1"))//����
	{
		%>
		<wtc:service name="sPhoneDefMsgVW" routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode1" retmsg="retMsg1" outnum="24" >
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="0"/>
		</wtc:service>   
		<wtc:array id="r_ret1" scope="end" start="0"  length="9" />
		<wtc:array id="r_ret2" scope="end" start="9"  length="1" />
		<wtc:array id="r_ret3" scope="end" start="10"  length="11" />
		<wtc:array id="r_ret4" scope="end" start="21"  length="1" />
		<wtc:array id="r_ret5" scope="end" start="22"  length="1" />
		<wtc:array id="r_ret6" scope="end" start="23"  length="1" />
		<%
			if(retCode1=="000000" ||retCode1.equals("000000"))
			{
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
								<tr>
									<td>��������:<%=phone_no%>;����δ����:<%=r_ret2[0][0]%></td>
								</tr>
								<% 
									for(int i=0;i<r_ret4.length;i++)
									{
										%>
											<tr>
												<td>��������:<%=r_ret6[i][0]%>;����δ����:<%=r_ret4[i][0]%></td>
											</tr>
										<%
									}
								%>
								<tr>
									<td>�������:<%=r_ret5[0][0]%></td>
								</tr>
								<tr>
								<td><input type="button" class="b_foot" value="����" onclick="window.location.href='zgbh_1.jsp'"></td></tr>
							</table>
						</form>
					</BODY>
				<HTML>
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
	else//����
	{
		%>
		<wtc:service name="sPhoneDefMsgVW" routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode2" retmsg="retMsg2" outnum="23" >
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="1"/>
		</wtc:service>   
		<wtc:array id="r_ret_f1" scope="end" />
	 
		<%
		if(retCode2=="000000" ||retCode2.equals("000000"))
		{
			s_phone=r_ret_f1[0][22];
			s_fk_unbill=r_ret_f1[0][21];
			%>
			<wtc:service name="sPhoneDefMsgVW" routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode1fk" retmsg="retMsg1fk" outnum="23" >
				<wtc:param value="<%=s_phone%>"/>
				<wtc:param value="0"/>
			</wtc:service>   
			<wtc:array id="r_ret1fk" scope="end" start="0"  length="9" />
			<wtc:array id="r_ret2fk" scope="end" start="9"  length="1" />
			<wtc:array id="r_ret3fk" scope="end" start="10"  length="11" />
			<wtc:array id="r_ret4fk" scope="end" start="21"  length="1" />
			<wtc:array id="r_ret5fk" scope="end" start="22"  length="1" />
			<%
			if(retCode1fk=="000000" ||retCode1fk.equals("000000"))
			{
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
								
								<tr>
									<td>��������:<%=phone_no%>;����δ����:<%=s_fk_unbill%></td>
								</tr>
								<tr>
									<td>��������:<%=s_phone%>;�������:<%=r_ret5fk[0][0]%></td>
								</tr>
								<tr>
								<td><input type="button" value="����" class="b_foot" onclick="window.location.href='zgbh_1.jsp'"></td></tr>
							</table>
						</form>
					</BODY>
				<HTML>
				<%
			}
			else
			{
				%>
					<script language="javascript">
						rdShowMessageDialog("������ѯ���Ϊ��,�����������ѯ�������в�ѯ!");
						history.go(-1);
					</script>
				<%
			}
		}
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("������������Ϣ��ѯ���Ϊ��,�����������ѯ�������в�ѯ!");
					history.go(-1);
				</script>
			<%
		}
	}
 
%>
	 
	
 
 




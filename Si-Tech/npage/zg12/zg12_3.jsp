<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String opCode = "zg12";
    String opName = "��ֵ˰��Ʊ��ӡ";
	String s_flag=request.getParameter("s_flag");
	String phone_no = request.getParameter("phone_no");
	String[] inParas2 = new String[2];
	
	//��ȡ��˰����Ϣ
	String tax_name = request.getParameter("tax_name");
	String tax_no1 = request.getParameter("tax_no1");
	String tax_address = request.getParameter("tax_address");
	String tax_phone = request.getParameter("tax_phone");
	String tax_khh = request.getParameter("tax_khh");
	String tax_contract_no = request.getParameter("tax_contract_no");
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<FORM method=post name="frm1508_2">
<html xmlns="http://www.w3.org/1999/xhtml">
		<HEAD><TITLE>��ֵ˰��Ʊ��ӡ</TITLE>
	
			<script language="javascript">
				function docheck()
				{
					alert("����ǰ���cust_id��ѯ ��Ҫ��ѯչʾ���phone_no ���û�ȥѡ ");
				}
				function sel1()
				{
					window.location.href='zg12_2.jsp';
				}
				function sel2()
				{
					window.location.href='zg12_3.jsp';
				}
		</script>
		
		</HEAD>



		<body>


		

		
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">��ѡ���ӡ��ʽ</div>
		</div>

			  <table cellspacing="0">
					<tbody>
						<tr>
							<td class="blue" width="15%">��ӡ��ʽ</td>
							<td colspan="3">
								<q vType="setNg35Attr">
								<input name="busyType1" type="radio" onClick="sel1()" value="1" >
								Ӫ����������ֵ˰רƱ��ӡ
								</q>
								<q vType="setNg35Attr">
								<input name="busyType2" type="radio" onClick="sel2()" value="2" checked>
								�½���ֵ˰רƱ��ӡ
								</q>
								 
							</td>
						</tr>
						<tr>
							<td class="blue" width="15%">�ֻ�����</td>
							<td colspan="3">
								<input type="text" name="phone_no" readonly maxlength=11 value="<%=phone_no%>">
								</q>
								 
							</td>
						</tr>
						<tr>
							<td class="blue" width="15%">��ѯ��ʼʱ��(YYYYMMDD)</td>
							<td colspan="3">
								<input type="text" name="begindate" maxlength=8 value="<%=dateStr%>">
								</q>
							</td>
						</tr>
						<tr>
							<td class="blue" width="15%">��ѯ����ʱ��(YYYYMMDD)</td>
							<td colspan="3">
								<input type="text" name="enddate" maxlength=8 value="<%=dateStr%>">
								</q>
								 
							</td>
						</tr>
					</tbody>
				</table>

				<table cellspacing="0">
					<tbody>
						<tr>
							<td class="blue" colspan=6>������λ��Ϣչʾ</td>
							 
						</tr>
						<tr>
							<td class="blue" width="15%">��˰������</td>
							<td>
								<input type="text" name="tax_name" readonly  value="<%=tax_name%>">
								</q>
								 
							</td>
							<td class="blue" width="15%">��˰��ʶ���</td>
							<td>
								<input type="text" name="tax_no1" readonly  value="<%=tax_no1%>">
								</q>
								 
							</td>
						</tr>
						<tr>
							<td class="blue" width="15%">��ַ</td>
							<td>
								<input type="text" name="tax_address" readonly  value="<%=tax_address%>">
								</q>
								 
							</td>
							<td class="blue" width="15%">�绰</td>
							<td>
								<input type="text" name="tax_phone" readonly  value="<%=tax_phone%>">
								</q>
								 
							</td>
						</tr>
						<tr>
							<td class="blue" width="15%">������</td>
							<td>
								<input type="text" name="tax_khh" readonly  value="<%=tax_khh%>">
								</q>
								 
							</td>
							<td class="blue" width="15%">�˺�</td>
							<td>
								<input type="text" name="tax_contract_no" readonly  value="<%=tax_contract_no%>">
								</q>
								 
							</td>
						</tr>
					</tbody>
				</table>

				<table cellSpacing="0">
					<tr> 
					  <td id="footer"> 
					  <input type="button" id="query_id" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >
						  &nbsp;
							<input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
						  &nbsp;
							  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
					 
					  </td>
					</tr>
				  </table>
			  <tr id="footer"> 
				   
				  </tr>
			
				
		<input type="hidden" id="id_contractNo">			
				

		<%@ include file="/npage/include/footer.jsp" %>
		
		</BODY>
	</HTML>

</FORM>

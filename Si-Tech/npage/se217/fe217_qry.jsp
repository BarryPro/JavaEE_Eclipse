<%
/********************
 * version v2.0
 * ������: si-tech
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

	<%
    String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String phoneNo = request.getParameter("phoneNo");
		String ptype = request.getParameter("ptype");
		String querysType = request.getParameter("querysType");
		String liyihname="";
		String liyihinnetname="";
		String liyiname="";
		String geshouname="";
		if(querysType.equals("lingyinhequery")) {//�����е������ѯ��֯����
				String qtypes = request.getParameter("qtypes");
				String sele = request.getParameter("sele");

				if(qtypes.trim().equals("1")) {
				liyihname = sele.trim();
				liyihinnetname="";
				}
				
				if(qtypes.trim().equals("2")) {
				liyihname = "";
				liyihinnetname=sele.trim();
				}

		}
		if(querysType.equals("lingyinquery")) {//�����������ѯ��֯����
				String qtypes = request.getParameter("qtypes");
				String sele = request.getParameter("sele");

				if(qtypes.trim().equals("1")) {
				liyiname = sele.trim();
				geshouname="";
				}
				if(qtypes.trim().equals("2")) {
				liyiname = "";
				geshouname=sele.trim();
	    	}
		}

	%>

		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			<%
			String  inputParsm [] = new String[13];
			inputParsm[0] = loginAccept;
			inputParsm[1] = "9";
			inputParsm[2] = "e217";
			inputParsm[3] = workNo;
			inputParsm[4] = password;
			inputParsm[5] = phoneNo;
			inputParsm[6] = "";
			inputParsm[7] = "";
			inputParsm[8] = ptype;
			inputParsm[9] = "";
			inputParsm[10] ="";
			inputParsm[11] ="";
			inputParsm[12] ="";
			
			if(querysType.equals("lingyinquery")) {//�����������ѯ
			inputParsm[9] = liyiname;
			inputParsm[10] =geshouname;
			}
			if(querysType.equals("lingyinhequery")) {//�����е������ѯ
			inputParsm[11] =liyihname;
			inputParsm[12] =liyihinnetname;
			}	
			for(int k = 0; k <= 12; k++ ){
				System.out.println("-------ningtn--------inputParsm[" + k + "] " + inputParsm[k]);
			}
		%>
			
		<wtc:service name="sE217Init" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="13">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
			  <wtc:param value="<%=inputParsm[10]%>"/>
				<wtc:param value="<%=inputParsm[11]%>"/>
				<wtc:param value="<%=inputParsm[12]%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"  />
			<%

if("000000".equals(retCode)){
		System.out.println(" ======== sE217Init ���óɹ� ========"  + retCode + " | " + retMsg);
		%>


<body>
          <%
					 if(querysType.equals("lingyinhe")) {//������Ĭ�ϲ�ѯ��ʾ
					 %>
						<table id="lingyinhe11" name="lingyinhe11" >
							<tr id="lingyinhetr">
								<th></th>
								<th>�����б��</th>
								<th>����������</th>
								<th>�۸�</th>
								<th>������</th>
								<th>��ע</th>
							
							</tr>
						<%for(int i=0;i<result1.length;i++) {%>
							<tr> 
								<td width="4%"><input type="radio" name="lingyinheradio" value="<%=result1[i][0]%>|<%=result1[i][3]%>"  ></td>
								<td width="15%"><%=result1[i][0]%></td>
								<td width="17%"><%=result1[i][1]%></td>
								<td width="10%"><%=result1[i][3]%>��</td>
								<td width="17%"><input type="radio" name="lingyin<%=result1[i][0]%>" value="1"  <%if(result1[i][4].trim().equals("0")) {out.print("checked");}if(result1[i][4].trim().equals("1")) {out.print("disabled");}if(result1[i][4].trim().equals("2")) {out.print("checked");}%>>����&nbsp;&nbsp;
							<input type="radio" name="lingyin<%=result1[i][0]%>" value="0" <%if(result1[i][4].trim().equals("0")) {out.print("disabled");}if(result1[i][4].trim().equals("1")) {out.print("checked");}%>>����</td>
								<td width="36%"><%=result1[i][5]%></td>
							</tr>
							<%}%>
						</table>
				<%
					}
					 if(querysType.equals("lingyin")) {//����Ĭ�ϲ�ѯ��ʾ

			 %>
					 	<table id="lingyin22" name="lingyin22" >
								<tr id="lingyintr">
									<th></th>
									<th>�������</th>
									<th>��������</th>
									<th>��������</th>
									<th>�۸�</th>
									<th>������</th>
									<th>��ע</th>
								
								</tr>
									<%for(int i=0;i<result1.length;i++) {

									%>
								<tr>
									<td width="4%"><input type="radio" name="lingyinheradio" value="<%=result1[i][0]%>|<%=result1[i][3]%>" ></td>
									<td width="17%"><%=result1[i][0]%></td>
									<td width="17%"><%=result1[i][1]%></td>
												<td width="12%"><%=result1[i][2]%></td>
									<td width="10%"><%=result1[i][3]%>��</td>
									<td idth="10%"><input type="radio" name="lingyin<%=result1[i][0]%>" value="1"  <%if(result1[i][4].trim().equals("0")) {out.print("checked");}if(result1[i][4].trim().equals("1")) {out.print("disabled");}if(result1[i][4].trim().equals("2")) {out.print("checked");}%> >����&nbsp;&nbsp;
								<input type="radio" name="lingyin<%=result1[i][0]%>" value="0" <%if(result1[i][4].trim().equals("0")) {out.print("disabled");}if(result1[i][4].trim().equals("1")) {out.print("checked");}%>>����</td>
									<td idth="30%"><%=result1[i][1]%><%=result1[i][3]%></td>
								</tr>
									<%}%>
			    </table>
			 <%
					}
					if(querysType.equals("lingyinhequery")) {//�����������ѯ��ʾ
				%>
					<th>��ѯ���Ϊ��</th>
					<table id="lingyinhe11" name="lingyinhe11">
						<tr id="lingyinhetr">
							<th></th>
							<th>�����б��</th>
							<th>����������</th>
							<th>�۸�</th>
							<th>������</th>
							<th>��ע</th>
						
						</tr>
					<%for(int i=0;i<result1.length;i++) {%>
						<tr >
							<td width="4%"><input type="radio" name="lingyinheradio" value="<%=result1[i][0]%>|<%=result1[i][3]%>"  ></td>
							<td width="15%"><%=result1[i][0]%></td>
							<td width="17%"><%=result1[i][1]%></td>
							<td width="10%"><%=result1[i][3]%>��</td>
							<td width="17%"><input type="radio" name="lingyin<%=result1[i][0]%>" value="1"   <%if(result1[i][4].trim().equals("0")) {out.print("checked");}if(result1[i][4].trim().equals("1")) {out.print("disabled");}if(result1[i][4].trim().equals("2")) {out.print("checked");}%>>����&nbsp;&nbsp;
						<input type="radio" name="lingyin<%=result1[i][0]%>" value="0"  <%if(result1[i][4].trim().equals("0")) {out.print("disabled");}if(result1[i][4].trim().equals("1")) {out.print("checked");}%>>����</td>
							<td width="36%"><%=result1[i][5]%></td>
						</tr>
						<%}%>
					</table>
				<%
				}
				  if(querysType.equals("lingyinquery")) {//���������ѯ��ʾ
				%>
					<th>��ѯ���Ϊ��</th>
					<table id="lingyin22" name="lingyin22" >
						<tr id="lingyintr">
							<th></th>
							<th>�������</th>
							<th>��������</th>
							<th>��������</th>
							<th>�۸�</th>
							<th>������</th>
							<th>��ע</th>
						
						</tr>
							<%for(int i=0;i<result1.length;i++) {%>
						<tr>
							<td width="4%"><input type="radio" name="lingyinheradio" value="<%=result1[i][0]%>|<%=result1[i][3]%>"  ></td>
							<td width="17%"><%=result1[i][0]%></td>
							<td width="17%"><%=result1[i][1]%></td>
										<td width="12%"><%=result1[i][2]%></td>
							<td width="10%"><%=result1[i][3]%>��</td>
							<td width="14%"><input type="radio" name="lingyin<%=result1[i][0]%>" value="1"  <%if(result1[i][4].trim().equals("0")) {out.print("checked");}if(result1[i][4].trim().equals("1")) {out.print("disabled");}if(result1[i][4].trim().equals("2")) {out.print("checked");}%> >����&nbsp;&nbsp;
						<input type="radio" name="lingyin<%=result1[i][0]%>" value="0"  <%if(result1[i][4].trim().equals("0")) {out.print("disabled");}if(result1[i][4].trim().equals("1")) {out.print("checked");}%>>����</td>
							<td width="30%"><%=result1[i][1]%><%=result1[i][3]%></td>
						</tr>
							<%}%>
					</table>
				<%}%>
</body>
</html>
<%
	}
else {
		System.out.println(" ======== sE217Init ����ʧ�� ========" + retCode + " | " + retMsg);
		%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode%>"+"<%=retMsg%>",0);	
					</script>
					<%
	}
%>


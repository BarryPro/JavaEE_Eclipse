<%
    /********************
     version v2.0
     ������: si-tech
     *
     *create:wanghfa@2010-9-6 �����������º���
     *
     ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="loginAccept"/>

<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String workNo = (String)session.getAttribute("workNo");
	String noPass = (String)session.getAttribute("password");
	String phone = WtcUtil.repStr(request.getParameter("phone"), "");
	
	String qryType = WtcUtil.repStr(request.getParameter("qryType"), "");
	//0:���º�����Ϣ 1������Ʒ������Ϣ 2��ҵ�������Ϣ 3�����6�����ײͰ����¼ 4�������������ҵ������¼
	
	System.out.println("===========wanghfa===0====== loginAccept = " + loginAccept);
	System.out.println("===========wanghfa===1====== ���� = 01");
	System.out.println("===========wanghfa===2====== opCode = " + opCode);
	System.out.println("===========wanghfa===3====== workNo = " + workNo);
	System.out.println("===========wanghfa===4====== noPass = " + noPass);
	System.out.println("===========wanghfa===5====== ����1 = " + phone);
	System.out.println("===========wanghfa===6====== ����1 = ");
	System.out.println("===========wanghfa===7====== ��ѯ���� = " + qryType);
	
%>
	<wtc:service name="sB553Qry" routerKey="phone" routerValue="<%=phone%>" retcode="retCode1" retmsg="retMsg1" outnum="10">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=noPass%>"/>
		<wtc:param value="<%=phone%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=qryType%>"/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>

<%
	System.out.println("==========wanghfa========== sB553Qry : " + retCode1 + "," + retMsg1);

	for (int i = 0; i < result1.length; i ++) {
		for (int j = 0; j < result1[i].length; j ++) {
			System.out.println("==========wanghfa==================== result1[" + i + "]["+j+"] = " + result1[i][j]);
		}
	}
	
	if ("0".equals(qryType)) {	//0�����º�����Ϣ
		System.out.println("==========wanghfa========== sB553Qry 0�����º�����Ϣ");
		if (!"000000".equals(retCode1)) {
%>
			<table>
				<tr>
					<td>
						<%=retMsg1%>
					</td>
				</tr>
			</table>
<%
		} else {
%>
			<table>
				<tr>
					<td class="blue" width="20%">
						�û�����
					</td>
					<td width="30%">
						<input type="text" value="<%=phone%>" class="InputGrey" readOnly>
					</td>
					<td class="blue" width="20%">
						���º���
					</td>
					<td width="30%">
						<input type="text" value="<%=result1[0][0]%>" class="InputGrey" readOnly>
					</td>
				</tr>
				<tr>
					<td class="blue" width="20%">
						��Чʱ��
					</td>
					<td width="30%">
						<input type="text" value="<%=result1[0][1]%>" class="InputGrey" readOnly>
					</td>
					<td class="blue" width="20%">
						ʧЧʱ��
					</td>
					<td width="30%">
						<input type="text" value="<%=result1[0][2]%>" class="InputGrey" readOnly>
					</td>
				</tr>
			</table>
<%
		}
	} else if ("1".equals(qryType)) {	//1������Ʒ������Ϣ
		System.out.println("==========wanghfa========== sB553Qry 1������Ʒ������Ϣ");
		if (!"000000".equals(retCode1)) {
%>
			<table>
				<tr>
					<td>
						<%=retMsg1%>
					</td>
				</tr>
			</table>
<%
		} else {
%>
			<table>
				<tr>
					<th width="20%">
						����ƷID
					</th>
					<th width="20%">
						����Ʒ����
					</th>
					<th width="20%">
						����Ʒ����
					</th>
					<th width="20%">
						��Чʱ��
					</th>
					<th width="20%">
						ʧЧʱ��
					</th>
				</tr>
<%
			for (int i = 0; i < result1.length; i ++) {
%>
				<tr>
					<td width="10%">
						<input type="text" value="<%=result1[i][0]%>" class="InputGrey" readOnly>
					</td>
					<td width="30%">
						<input type="text" size="40" value="<%=result1[i][1]%>" class="InputGrey" readOnly>
					</td>
					<td width="20%">
						<input type="text" value="<%=result1[i][4]%>" class="InputGrey" readOnly>
					</td>
					<td width="20%">
						<input type="text" value="<%=result1[i][2]%>" class="InputGrey" readOnly>
					</td>
					<td width="20%">
						<input type="text" value="<%=result1[i][3]%>" class="InputGrey" readOnly>
					</td>
				</tr>
<%			
			}
		}
%>
		</table>
<%
	} else if ("2".equals(qryType)) {	//2��ҵ�������Ϣ
		System.out.println("==========wanghfa========== sB553Qry 2��ҵ�������Ϣ");
%>
	<table>
		<tr>
			<td class="blue" width="20%">
				�ֻ�֧��ҵ��
			</td>
			<td width="30%">
<%
			if ("NO".equals(result1[0][0])) {
%>
				<input type="text" value="δ��ͨ" class="InputGrey" readOnly>
<%
			} else if ("YES".equals(result1[0][0])) {
%>
				<input type="text" value="�ѿ�ͨ" class="InputGrey" readOnly>
<%
			}
%>
			</td>
			<td class="blue" width="20%">
				���ʷ���ҵ��
			</td>
			<td width="30%">
<%
			if ("NO".equals(result1[0][1])) {
%>
				<input type="text" value="δ��ͨ" class="InputGrey" readOnly>
<%
			} else if ("YES".equals(result1[0][1])) {
%>
				<input type="text" value="�ѿ�ͨ" class="InputGrey" readOnly>
<%
			}
%>
			</td>
		</tr>
	</table>
<%
	} else if ("3".equals(qryType)) {	//3�����6�����ײͰ����¼
		System.out.println("==========wanghfa========== sB553Qry 3�����6�����ײͰ����¼");
		
		if (!"000000".equals(retCode1)) {
%>
			<table>
				<tr>
					<td>
						<%=retMsg1%>
					</td>
				</tr>
			</table>
<%
		} else {
%>
			<table>
				<tr>
					<th width="20%">
						����ʱ��
					</th>
					<th width="20%">
						ҵ�����/ҵ������
					</th>
					<th width="15%">
						�������ͣ�����/�˶���
					</th>
					<th width="25%">
						�ʷ�
					</th>
					<th width="20%">
						�ʷ�����
					</th>
				</tr>
<%
			if (result1.length == 0) {
%>
				<tr>
					<td colspan="5">
						���6�������ײͰ����¼......
					</td>
				</tr>
<%
			}
			for (int i = 0; i < result1.length; i ++) {
%>
				<tr>
					<td>
						<input type="text" value="<%=result1[i][0]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" value="<%=result1[i][1]%>-<%=result1[i][2]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" value="<%=result1[i][3]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" size="40" value="<%=result1[i][4]%>--<%=result1[i][5]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" value="<%=result1[i][6]%>" class="InputGrey" readOnly>
					</td>
				</tr>
<%
			}
		}
%>
	</table>
<%
	} else if ("4".equals(qryType)) {	//4�����6������ҵ������¼
		System.out.println("==========wanghfa========== sB553Qry 4�������������ҵ������¼");

		if (!"000000".equals(retCode1)) {
%>
			<table>
				<tr>
					<td>
						<%=retMsg1%>
					</td>
				</tr>
			</table>
<%
		} else {
%>
			<table>
				<tr>
					<th width="20%">
						ʱ��
					</th>
					<th width="30%">
						ҵ�����/ҵ������
					</th>
					<th width="20%">
						���ͣ�����/ȡ����
					</th>
					<th width="30%">
						���º���
					</th>
				</tr>
<%
			if (result1.length == 0) {
%>
				<tr>
					<td colspan="5">
						���6����������ҵ������¼......
					</td>
				</tr>
<%
			}
			for (int i = 0; i < result1.length; i ++) {
%>
				<tr>
					<td>
						<input type="text" value="<%=result1[i][0]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" size="40" value="<%=result1[i][1]%>-<%=result1[i][2]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" value="<%=result1[i][3]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" value="<%=result1[i][4]%>" class="InputGrey" readOnly>
					</td>
				</tr>
<%
			}
		}
%>
	</table>
<%
	}
%>

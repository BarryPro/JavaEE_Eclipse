<%
  /* *********************
   * ����: �ʷѸ�������ѯ��Դ��
   * �汾: 1.0
   * ����: 2012-4-10 17:51:38
   * ����: ningtn
   * ��Ȩ: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("========= ningtn in fe759PubPriceRevoMsg =====");
	String opCode = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	/*��ѯ���ͣ�3��ѯ��Դ��������Ϣ*/
	String qryType = request.getParameter("qryType");
	/* ��Դ����ѯ��ʶ  0ȫ��  1��Ч  2ԤԼ */
	String flag = request.getParameter("flag");
	String regionCode= (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
%>
		<wtc:service name="sProdTypeConQry" routerKey="region" routerValue="<%=regionCode%>"
		  retcode="retCode" retmsg="retMsg" outnum="18">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value="<%=%>"/>
				<wtc:param value="<%=qryType%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=flag%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" start="0" length="11"/>
		<wtc:array id="result2" scope="end" start="11" length="7"/>
<%
	System.out.println("ningtn pubPriceRevoMsg = [" + retCode + retMsg + "]");
	System.out.println("ningtn result1 ��ϸ = [" + result1.length + "]");

	System.out.println("ningtn result2 = [" + result2.length + "]");

%>
		<ul class="cust-tab3-line"></ul>
		<ul class="cust-tab3-link">
			<a class="on">��ǰʹ�û���</a>
			<a>��ǰʹ����ϸ</a>
			<a>ԤԼ����</a>
			<a>ԤԼ��ϸ</a>
		</ul>
		<!-- ��ǰʹ�û��� -->
		<table class="tab-con table-wrap">
			<tr>
				<th>
					��Ʒ
				</th>
				<th>
					������
				</th>
				<th>
					��ʹ������
				</th>
				<th>
					ʣ������
				</th>
			</tr>
<%
	for(int i = 0; i < result2.length; i++){
		if("1".equals(result2[i][0])){
%>
			<tr>
				<th class="bg-white">
					<span class="pubPriceProdType" typeId="<%=result2[i][1]%>"><%=result2[i][2]%><span>
				</th>
				<td style="word-break: break-all">
					<%=result2[i][3]%> <%=result2[i][6]%>
				</td>
				<td>
					<%=result2[i][4]%> <%=result2[i][6]%>
				</td>
				<td>
					<%=result2[i][5]%> <%=result2[i][6]%>
				</td>
			</tr>
<%
		}
	}
%>
		</table>
		<!-- ��ǰʹ����ϸ -->
		<table class="tab-con table-wrap" style="display:none;">
			<tr>
				<th>��Ʒ����</th>
				<th>������</th>
				<th>��ʹ������</th>
				<th>ʣ������</th>
				<th>��Чʱ��</th>
				<th>ʧЧʱ��</th>
			</tr>
<%
	for(int i = 0; i < result1.length; i++){
		if("1".equals(result1[i][0])){
%>
			<tr>
				<th class="bg-white">
					<%=result1[i][9]%>
				</th>
				<td style="word-break: break-all">
					<%=result1[i][3]%> <%=result1[i][6]%>
				</td>
				<td>
					<%=result1[i][4]%> <%=result1[i][6]%>
				</td>
				<td>
					<%=result1[i][5]%> <%=result1[i][6]%>
				</td>
				<td>
					<%=result1[i][7]%>
				</td>
				<td>
					<%=result1[i][10]%>
				</td>
			</tr>
<%
		}
	}
%>
		</table>
		<!-- ԤԼ���� -->
		<table class="tab-con table-wrap" style="display:none;">
			<tr>
				<th>����</th>
				<th>ԤԼ��</th>
			</tr>
<%
	for(int i = 0; i < result2.length; i++){
		if("2".equals(result2[i][0])){
%>
			<tr>
				<th class="bg-white">
					<%=result2[i][2]%>
				</th>
				<td style="word-break: break-all">
					<%=result2[i][3]%> <%=result2[i][6]%>
				</td>
			</tr>
<%
		}
	}
%>

		</table>
		<!-- ԤԼ��ϸ -->
		<table class="tab-con table-wrap" style="display:none;">
			<tr>
				<th>��Ʒ����</th>
				<th>ԤԼ��</th>
				<th>��Чʱ��</th>
				<th>ʧЧʱ��</th>
			</tr>
<%
	for(int i = 0; i < result1.length; i++){
		if("2".equals(result1[i][0])){
%>
			<tr>
				<th class="bg-white">
					<%=result1[i][9]%>
				</th>
				<td style="word-break: break-all">
					<%=result1[i][3]%> <%=result1[i][6]%>
				</td>
				<td>
					<%=result1[i][7]%>
				</td>
				<td>
					<%=result1[i][10]%>
				</td>
			</tr>
<%
		}
	}
%>
		</table>
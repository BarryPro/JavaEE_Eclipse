<%
	/*
	 * ����: ����ԭ���ѯ
	 * �汾: 1.0
	 * ����: 2008/10/18
	 * ����: zhangjc 
	 * ��Ȩ: sitech
	 * modify by yinzx 20091001 ȥ�������ˮ�ֶ�
	 *  
	 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
 /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String opCode = "k055";
	String opName = "�û���Ϣ";
	
	String caller_phone = request.getParameter("caller_phone");

	// ���ϵͳ��ǰ�·�
	java.util.Date current = new java.util.Date();
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMM"); 
    String curMonth=sdf.format(current);
    
    String tableName = "DCALLCALL" + curMonth;
    String accept_name = "";
     accept_name="decode(b.accept_code ,'0',	'�˹�'" ;    
		 accept_name+=                   ",'1',	'�Զ�'";     
		 accept_name+=                   ",'2',	'����'";     
		 accept_name+=                   ",'3',	'����'";     
		 accept_name+=                   ",'4',	'����'";     
		 accept_name+=                   ",'5',	'EMail'";    
		 accept_name+=                   ",'6',	'Web'";      
		 accept_name+=                   ",'7',	'����'";     
		 accept_name+=                   ",'8',	'����ͨ��'" ;
		 accept_name+=                   ",'9',	'�ڲ�����'" ;
		 accept_name+=                   ",'10','��������'" ;
		 accept_name+=                   ",'11','����'";     
		 accept_name+=                   ",'12','����'";     
		 accept_name+=                   ",'13','δ����' ),";

	
	String sqlStr = "select contact_id,to_char(begin_date,'yyyymmdd hh24:mi:ss'),callcausedescs,accept_phone,caller_phone,accept_login_no,accept_long,acceptid,"+accept_name+"call_accept_id,a.accept_kf_login_no ";
	sqlStr += "from " + tableName + " a, SCALLACCEPTCODE b ";
	sqlStr += "where accept_phone =:caller_phone and a.acceptid = b.accept_code order by a.begin_date desc";
   myParams = "caller_phone="+caller_phone ;                                     
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="13">
	<wtc:param value="<%=sqlStr%>" />
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" start="0" length="13" scope="end" />

<html>
	<head>
		<title>�û���Ϣ</title>
		<script type="text/javascript">
			function openCustomerDetainPage() {
				var url = "/npage/callbosspage/customerDetain/customerDetain.jsp";
				var iHeight = 500;
				var iWidth = 950;
			  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
			  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
				var features = "height=" + iHeight + ",width=" + iWidth + ",resizable=yes,"
										 + "top=" + iTop + ",left=" + iLeft;
				window.open(url, null, features);
				return;
			}
		</script>
	</head>

	<body>
		<%@ include file="/npage/include/header.jsp"%>
		<div id="Operation_Table">
			<a href="javascript:openCustomerDetainPage()">
				<span style="font-weight:bold;font-size:12px;text-decoration:underline;">
					�ͻ�����
				</span><br /><br />
			</a>
			<table cellSpacing="0">
				<tr>
					<th align="center" class="blue" width="8%">
						���
					</th>
					<th align="center" class="blue" width="8%">
						����ʱ��
					</th>
					<th align="center" class="blue" width="8%">
						����ԭ��
					</th>
					<th align="center" class="blue" width="8%">
						�������
					</th>
					<th align="center" class="blue" width="8%">
						���к���
					</th>
					<th align="center" class="blue" width="8%">
						������
					</th>
					<th align="center" class="blue" width="8%">
						BOSS����
					</th>
					<th align="center" class="blue" width="8%">
						����ʱ��
					</th>
					<th align="center" class="blue" width="8%">
						����ʽ
					</th>
					<th align="center" class="blue" width="8%">
						��ˮ��
					</th>
					 
				</tr>

				<%
					for (int i = 0; i < queryList.length; i++) {
						String tdClass = "";
						
						if ((i + 1) % 2 == 1) {
							tdClass = "grey";
						}
				%>
				<tr>
					<td align="center" class="<%=tdClass%>"><%=i+1%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][1]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][2]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][3]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][4]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][10]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][5]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][6]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][8]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][0]%>&nbsp;</td>
	 
				</tr>
				<%
					}
				%>
			</table>
		</div>

		<%@ include file="/npage/include/footer.jsp"%>
	</body>
</html>
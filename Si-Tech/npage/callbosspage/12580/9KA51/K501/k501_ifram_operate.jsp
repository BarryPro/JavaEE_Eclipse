
<%
  /*
   * ����: ������Ϣ
�� * �汾: 1.0.0
�� * ����: 2009/01/07
�� * ����: libin
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String loginNo = (String) session.getAttribute("workNo");

	String[][] dataRows = new String[][] {};
	int rowCount = 0;
	int pageSize = 15;
	int pageCount = 0;
	int curPage = 0;
	String strPage = "";
	String rphone = (String) request.getParameter("rphone");//Ŀ�����
	//��ѯ����
	String sqlTemp = "select to_char(count(*)) count  from SMS_PUSH_REC_LOG_12580 t where t.send_login_no = '"+loginNo+"' and t.user_phone = '"+rphone+"'";
%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlTemp %>" />
</wtc:service>
<wtc:array id="rowsC4" scope="end" />
<%
	if (rowsC4.length != 0) {
		rowCount = Integer.parseInt(rowsC4[0][0]);
	}
	strPage = request.getParameter("page");
	if (strPage == null || strPage.equals("") || strPage.trim().length() == 0) {
		curPage = 1;
	} else {
		curPage = Integer.parseInt(strPage);
		if (curPage < 1)
			curPage = 1;
	}
	pageCount = (rowCount + pageSize - 1) / pageSize;
	if (curPage > pageCount)
		curPage = pageCount;
	int beginPos = (curPage - 1) * pageSize;
	String dsql = "select to_char(t.insert_time,'yyyy-MM-dd HH24:MI:ss'),t.user_phone,t.send_content,caller_phone,'mubiao',t.success_flag "
			+ " from SMS_PUSH_REC_LOG_12580 t where t.send_login_no = '"+loginNo+"' and t.user_phone = '"+rphone+"' order by t.insert_time desc,t.user_phone";
	String querySql = PageFilterSQL.getOraQuerySQL(dsql,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
%>
<html>
	<head>
		<title>������Ϣ</title>
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/FormText.css"
			rel="stylesheet" type="text/css"></link>
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/font_color.css"
			rel="stylesheet" type="text/css"></link>
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css"
			rel="stylesheet" type="text/css"></link>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>		
	</head>

	<body>
		<wtc:service name="s151Select" outnum="7">
			<wtc:param value="<%=querySql %>" />
		</wtc:service>
		<wtc:array id="queryList" start="0" length="7" scope="end" />
		<%
		dataRows = queryList;
		%>
		<div id="Operation_Table">
			<table cellspacing="0">
				<tr>
					<td class="blue" align="left" width="720">
						<%
						if (pageCount != 0) {
						%>
						��
						<%=curPage%>
						ҳ ��
						<%=pageCount%>
						ҳ ��
						<%=rowCount%>
						��
						<%
						} else {
						%>
						<font color="orange">��ǰ��¼Ϊ�գ�</font>
						<%
						}
						%>
						<%
						if (pageCount != 1 && pageCount != 0) {
						%>
						<a href="#" onClick="doLoad('first');return false;">��ҳ</a>
						<%
						}
						%>
						<%
						if (curPage > 1) {
						%>
						<a href="#" onClick="doLoad('pre');return false;">��һҳ</a>
						<%
						}
						%>
						<%
						if (curPage < pageCount) {
						%>
						<a href="#" onClick="doLoad('next');return false;">��һҳ</a>
						<%
						}
						%>
						<%
						if (pageCount > 1) {
						%>
						<a href="#" onClick="doLoad('last');return false;">βҳ</a>
						<%
						}
						%>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" width="100%">
				<tr>
					<th>
						���
					</th>
					<th>
						����ʱ��
					</th>
					<th>
						Ŀ�����
					</th>
					<th>
						��������
					</th>
					<th>
						���к���
					</th>
					
					<th>
						����״̬
					</th>
					<th>
						����Ա����
					</th>
				</tr>
				<%
						for (int i = 0; i < dataRows.length; i++) {
						String tdClass = "";
				%>
				<%
							if ((i + 1) % 2 == 1) {
							tdClass = "grey";
				%>
				<tr onClick="parent.document.sitechform.msg_content.value+='<%=dataRows[i][3] %>'" style="cursor:pointer">
					<%
					} else {
					%>
				
				<tr onClick="parent.document.sitechform.msg_content.value+='<%=dataRows[i][3] %>'" style="cursor:pointer">
					<%
					}
					%>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][0].length() != 0) ? dataRows[i][0]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][1].length() != 0) ? dataRows[i][1]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][2].length() != 0) ? dataRows[i][2]
						: "&nbsp;"%>
					</td>
					<td align="left" class="<%=tdClass%>">
						<%=(dataRows[i][3].length() != 0) ? dataRows[i][3]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][4].length() != 0) ? dataRows[i][4]
						: "&nbsp;"%>
					</td>
					
					<td align="center" class="<%=tdClass%>">
						<%
							if(dataRows[i][6].length() != 0){
								if("Y".equals(dataRows[i][6])){
									out.println("�ɹ�");
								}else{
									out.println("ʧ��");
								}				
							}
						%>
						
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=loginNo==null?"":loginNo %>
					</td>
				</tr>
				<%
				}
				%>
			</table>
			<table cellspacing="0">
				<tr>
					<td class="blue" align="right" width="720">
						<%
						if (pageCount != 0) {
						%>
						��
						<%=curPage%>
						ҳ ��
						<%=pageCount%>
						ҳ ��
						<%=rowCount%>
						��
						<%
						} else {
						%>
						<font color="orange">��ǰ��¼Ϊ�գ�</font>
						<%
						}
						%>
						<%
						if (pageCount != 1 && pageCount != 0) {
						%>
						<a href="#" onClick="doLoad('first');return false;">��ҳ</a>
						<%
						}
						%>
						<%
						if (curPage > 1) {
						%>
						<a href="#" onClick="doLoad('pre');return false;">��һҳ</a>
						<%
						}
						%>
						<%
						if (curPage < pageCount) {
						%>
						<a href="#" onClick="doLoad('next');return false;">��һҳ</a>
						<%
						}
						%>
						<%
						if (pageCount > 1) {
						%>
						<a href="#" onClick="doLoad('last');return false;">βҳ</a>
						<%
						}
						%>
					</td>
				</tr>
			</table>
		</div>
		<form action="" name="sitechform" method="post"><input type="hidden" name="page"/><input type="hidden" name="myaction" value=""></form>
	</body>
</html>
<script language=javascript>

function doLoad(operateCode){
   var str='1';
   if(operateCode=="load")
   {
   	window.sitechform.page.value="";
   	str='0';
   }
   else if(operateCode=="first")
   {
   	window.sitechform.page.value=1;
   }
   else if(operateCode=="pre")
   {
   	window.sitechform.page.value=<%=(curPage-1) %>;
   }
   else if(operateCode=="next")
   {
   	window.sitechform.page.value=<%=(curPage+1) %>;
   }
   else if(operateCode=="last")
   {
   	window.sitechform.page.value=<%=pageCount%>;
   }
   window.sitechform.myaction.value="doLoad";									
   window.sitechform.action="k501_ifram_operate.jsp?rphone=<%=rphone %>";
   window.sitechform.method='post';
   window.sitechform.submit();
}
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	request.setCharacterEncoding("GBK");
%>
<%
	/*
	 * ����: �ۺ�V�����Ų�ѯ
	 * �汾: v1.0
	 * ����: 2009��08��12��
	 * ����: wangzn
	 * ��Ȩ: sitech
	 */
%>

<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html; charset=GBK"%>
<!--�·�ҳ�õ�����-->
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
	String opCode = WtcUtil.repNull(request.getParameter("pageOpCode"));
	String opName = WtcUtil.repNull(request.getParameter("pageOpName"));
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);
	String workName = (String) session.getAttribute("workName");
	String ipAddr = (String) session.getAttribute("ipAddr");
	String orgCode = (String) session.getAttribute("orgCode");

	String region_code = request.getParameter("region_code");
	String district_code = request.getParameter("district_code");
	String field_value = request.getParameter("field_value");
	

	String sqlStr ="select a.field_value as field_value_a,f.unit_id,b.field_value,f.service_no,decode(c.field_value,'vm','��׼','vt','����',c.field_value) from dgrpusermsgadd a,dgrpusermsgadd b,dgrpusermsgadd c,dgrpusermsgadd d,dgrpusermsgadd e,dgrpcustmsg f,dgrpusermsg g where c.id_no = a.id_no and c.id_no = b.id_no and c.id_no = d.id_no and c.id_no = e.id_no and c.id_no = g.id_no and f.cust_id=g.cust_id and a.field_code='20000' and b.field_code='10309' and c.field_code='ZHWW0' and c.field_value='"+field_value+"' and d.field_code='20002' and d.field_value='"+region_code+"' and e.field_code='20006' and e.field_value='"+district_code+"'";


			
	String tMemberProperty = "";

	/**��ҳҪ�õĴ���**/
	Map map = request.getParameterMap();
	String totalNumber = "";
	String currentPage = request.getParameter("currentPage") == null ? "1"
			: request.getParameter("currentPage");
	String pageSize = "11";
	/******************/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link href="s2002.css" rel="stylesheet" type="text/css">
			<!--************************��ҳ����ʽ��**************************-->
		<link rel="stylesheet" type="text/css"
			href="/nresources/default/css/fenye.css" media="all" />
		<script>
function gotoPage(pageId){
		document.form2.currentPage.value= pageId;
		document.form2.submit();
		return true;
}


</script>

	</head>
	<body>
		<!--************************��ҳ����ʽ��**************************-->
		<link rel="stylesheet" type="text/css"
			href="/nresources/default/css/fenye.css" media="all" />
	</HEAD>
	<FORM method=post name="fPubSimpSel">
<!--	<%@ include file="/npage/include/header_pop.jsp"%> -->
<%@ include file="/npage/include/header.jsp" %>

		<input type="hidden" name="pageOpCode" value="<%=opCode%>">
		<input type="hidden" name="pageOpName" value="<%=opName%>">
		<%
			String countSql = PageFilterSQL.getCountSQL(sqlStr);
		%>
		<wtc:pubselect name="sPubSelect" outnum="1">
			<wtc:sql><%=countSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="allNumStr" scope="end" />
		<%
			if (allNumStr != null && allNumStr.length > 0) {
				totalNumber = allNumStr[0][0];
			}

			String querySql = PageFilterSQL.getOraQuerySQL(sqlStr, currentPage,
					pageSize, totalNumber);
					
		%>

		<div id="productList">
			<div class="title">
				<div id="title_zi">
					������Ϣ�б�
				</div>
			</div>


			<wtc:pubselect name="sPubSelect" outnum="6">
				<%//outnumҪ��ȡ����������1,��Ϊ����ȡ�������к�--%>
				<wtc:sql><%=querySql%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="rows" scope="end" />
			<wtc:pubselect name="sPubSelect" outnum="2">
				<wtc:sql>select a.region_name ,b.district_name from sregioncode a,sdiscode b where a.region_code = b.region_code and a.region_code = '<%=region_code %>' and b.district_code = '<%=district_code %>'</wtc:sql>
			</wtc:pubselect>
			<wtc:array id="rows1" scope="end" />
			

			<table cellspacing="0" id="productTab">
				<tr align="center">
					<th nowrap>
						����
					</th>
					<th nowrap>
						����
					</th>
					<th nowrap>
						���ű��
					</th>
					<th nowrap>
						����ID
					</th>
					<th nowrap>
						��������
					</th>
					<th nowrap>
						�ͻ�����
					</th>
					<th nowrap>
						�ۺ�V������
					</th>
				</tr>



				<%
					for (int i = 0; i < rows.length; i++) {
						tMemberProperty = "";
				%>
				<tr align="center">
					<td nowrap><%=rows1[0][0]%></td>
					<td nowrap><%=rows1[0][1]%></td>
					<td nowrap><%=rows[i][0]%></td>
					<td nowrap><%=rows[i][1]%></td>
					<td nowrap><%=rows[i][2]%></td>
					<td nowrap><%=rows[i][3]%></td>
					<td nowrap><%=rows[i][4]%></td>
				</tr>
				<%
					}
				%>
				<tr>
					<td colspan="7" align="right">
						<%=PageListNav.pageNav(totalNumber, pageSize, currentPage)%><a>�ܼ�<B
							class="orange"><%=totalNumber%></B>����¼</a>
					</td>
				</tr>
			</table>
		</div>

		<table cellSpacing=0>
			<tr>
				<td align="center" id="footer" colspan="5">
					<input class="b_foot" name=next id=nextoper type=button value="����"
						onclick="document.URL='s4084.jsp'">
					<input class="b_foot" name=reset type=button value="�ر�"
						onClick="removeCurrentTab()" >
				</td>
			</tr>
		</table>

		<%@ include file="/npage/include/footer.jsp"%>


	</FORM>
	<form name="form2" method="post">
		<%=PageListNav.writeRequestString(map, currentPage)%>
	</form>
	</BODY>
</HTML>
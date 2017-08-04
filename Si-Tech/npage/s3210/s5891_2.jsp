<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	request.setCharacterEncoding("GBK");
%>
<%
	/*
	 * 功能: 综合V网成员查询
	 * 版本: v1.0
	 * 日期: 2009年08月06日
	 * 作者: wangzn
	 * 版权: sitech
	 */
%>

<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html; charset=GBK"%>
<!--新分页用到的类-->
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
	/////////////////////////////////////////////////////////////
	String group_no = request.getParameter("group_no");
	String phone_type = request.getParameter("phone_type");
	String[] disPropertys = request.getParameterValues("disProperty");
	
	/////////////////////////////////////////////////////////////

	//String productId = request.getParameter("productID");
	//System.out.println("productID="+productId);
	//String orderSource = request.getParameter("orderSource");
	//System.out.println("orderSource="+orderSource);
	//String operType = request.getParameter("operType");
	//String regionCode = orgCode.substring(0,2);
	String sqlStr;
	if("1".equals(phone_type)){
		sqlStr = "select phone_no from dvpmnotherusermsg where group_no = '"+group_no+"'";
	}else{
		sqlStr = "select b.phone_no from dcustmsgadd a,dcustmsg b where a.id_no = b.id_no and a.field_code = '20000' and a.field_value = '"+group_no+"'";
	}
			
			
	String tMemberProperty = "";

	/**分页要用的代码**/
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
			<!--************************分页的样式表**************************-->
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
		<!--************************分页的样式表**************************-->
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
					成员信息列表
				</div>
			</div>




			<wtc:pubselect name="sPubSelect" outnum="2">
				<%--outnum要比取出的列数大1,因为它还取出了序列号--%>
				<wtc:sql><%=querySql%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="rows" scope="end" />
			<wtc:pubselect name="sPubSelect" outnum="6">
				<wtc:sql>select b.region_name,c.district_name,d.service_no,e.field_value,f.field_value,decode(g.field_value,'vm','标准','vt','特殊',g.field_value) from dgrpusermsg a,sregioncode b,sdiscode c ,dgrpcustmsg d ,dgrpusermsgadd e,dgrpusermsgadd f,dgrpusermsgadd g where a.region_code= b.region_code and a.region_code = c.region_code and a.district_code = c.district_code  and e.id_no = a.id_no and e.id_no = f.id_no and e.id_no = g.id_no and a.cust_id = d.cust_id  and e.field_code = '20000' and e.field_value = '<%=group_no %>' and f.field_code = '10309' and g.field_code = 'ZHWW0'</wtc:sql>
			</wtc:pubselect>
			<wtc:array id="rows1" scope="end" />
			

			<table cellspacing="0" id="productTab">
				<tr align="center">
					<th nowrap>
						地市
					</th>
					<th nowrap>
						区县
					</th>
					<th nowrap>
						客户经理
					</th>
					<th nowrap>
						集团编号
					</th>
					<th nowrap>
						集团名称
					</th>
					<th nowrap>
						综合V网类型
					</th>
					<th nowrap>
						手机号码
					</th>
				</tr>



				<%
					for (int i = 0; i < rows.length; i++) {
						tMemberProperty = "";
				%>
				<tr align="center">
					<td nowrap><%=rows1[0][0]%></td>
					<td nowrap><%=rows1[0][1]%></td>
					<td nowrap><%=rows1[0][2]%></td>
					<td nowrap><%=rows1[0][3]%></td>
					<td nowrap><%=rows1[0][4]%></td>
					<td nowrap><%=rows1[0][5]%></td>
					<td nowrap><%=rows[i][0]%></td>
				</tr>
				<%
					}
				%>
				<tr>
					<td colspan="7" align="right">
						<%=PageListNav.pageNav(totalNumber, pageSize, currentPage)%><a>总计<B
							class="orange"><%=totalNumber%></B>条记录</a>
					</td>
				</tr>
			</table>
		</div>

		<table cellSpacing=0>
			<tr>
				<td align="center" id="footer" colspan="7">
					<input class="b_foot" name=next id=nextoper type=button value="返回"
						onclick="document.URL='s5891.jsp'">
					<input class="b_foot" name=reset type=button value="关闭"
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

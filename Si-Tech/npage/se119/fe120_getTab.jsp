<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wanglm 
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>  
<%
	String selType = request.getParameter("selType");
	String selCode = request.getParameter("selCode");
	String workNo = (String)session.getAttribute("workNo");
	String passWord = (String)session.getAttribute("passWord");
	String groupId = (String)session.getAttribute("groupId");
	String regionCode=(String)session.getAttribute("regCode");
	int iPageSize = 10;
%>
	<wtc:service name="se120Qry" routerKey="region" routerValue="<%=regionCode%>" 
			 retcode="retCode" retmsg="retMsg" outnum="12">
				<wtc:param value="0"/>
				<wtc:param value="01"/>
				<wtc:param value="e120"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=passWord%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=selType%>"/>
				<wtc:param value="<%=selCode%>"/>
				<wtc:param value="<%=groupId%>"/>
		</wtc:service>
	<wtc:array id="result" scope="end"/>  
<%
if ("0".equals(selType)) {
	%>
	<div class="title">
		<div id="title_zi"><%=selCode%>工号查询结果</div>
	</div>
	<%
} else if ("1".equals(selType)) {
	%>
	<div class="title">
		<div id="title_zi"><%=selCode%>角色查询结果</div>
	</div>
	<%
}
%>
	<table id="tab2">
	<tr>
		<th class='blue' nowrap width="40%" >权限名称</th>
		<th class='blue' nowrap width="10%" >功能代码</th>
		<th class='blue' nowrap width="15%" >开始时间</th>
		<th class='blue' nowrap width="15%" >结束时间</th>
		<th class='blue' nowrap width="10%" >配置工号</th>
		<th class='blue' nowrap width="10%" >
			姓名
			<input type="hidden" name="code" id="code" value="<%=retCode%>" />
			<input type="hidden" name="msg" id="msg" value="<%=retMsg%>" />
		</th>
	</tr>
	<%
	int no1 = 1;
	if(retCode.equals("000000") && result.length > 0){
		for (int i = 0; i < result.length; i ++){
			if (result[i][0] != null) {

				if (no1 % 10 == 1) {
					%>
					<tbody name='page1_<%=(no1/10+1)%>' id='page1_<%=(no1/10+1)%>' style='display:none'>
					<%
				}
				%>
				<tr>
					<td><%=result[i][0]%></td>
					<td><%=result[i][1]%></td>
					<td><%=result[i][2]%></td>
					<td><%=result[i][3]%></td>
					<td><%=result[i][4]%></td>
					<td><%=result[i][5]%></td>
				</tr>
				<%
				if (no1 % 10 == 0 || no1 == result.length) {
				%>
					</tbody>
				<%
				}
				no1 ++;
				
			}
		}
		no1 --;
  }
	%>
</table>
<table align="center">
	<tr>
		<td align="center">
			总记录数：<font name="totalPertain1" id="totalPertain1"><%=no1%></font>&nbsp;&nbsp;
			总页数：<font name="totalPage1" id="totalPage1"><%=(no1-1)/iPageSize+1%></font>&nbsp;&nbsp;
			当前页：<font name="currentPage1" id="currentPage1">1</font>&nbsp;&nbsp;
			每页行数：<%=iPageSize%>
			<a href="javascript:page1('1');">[第一页]</a>&nbsp;&nbsp;
			<a href="javascript:page1('-1');">[上一页]</a>&nbsp;&nbsp;
			<a href="javascript:page1('+1');">[下一页]</a>&nbsp;&nbsp;
			<a href="javascript:page1('<%=(no1-1)/iPageSize+1%>');">[最后一页]</a>&nbsp;&nbsp;
			跳转到指定页：
			<select name="toPage" id="toPage" style="width:80px" onchange="page1(this.value);">
				<%
				for (int i = 1; i <= (no1-1)/iPageSize+1; i ++) {
					%>
					<option value="<%=i%>">第<%=i%>页</option>
					<%
				}
				%>
			</select>
		</td>
	</tr>
</table>

<script language="javascript">
	page1("1");
	function page1(pageNo) {
		if (pageNo == "-1") {
			page1(String(parseInt(document.getElementById("currentPage1").innerText) - 1));
			return;
		} else if (pageNo == "+1") {
			page1(String(parseInt(document.getElementById("currentPage1").innerText) + 1));
			return;
		} else if (pageNo == "pageNo") {
			page1(document.getElementById("pageNo1").value);
			return;
		} else {
			pageNo = parseInt(pageNo);
			if (pageNo > parseInt(document.getElementById("totalPage1").innerText) || pageNo < 1) {
				return;
			}
			for (var a = 1; a <= <%=(no1-1)/iPageSize+1%>; a ++) {
				document.getElementById("page1_" + a).style.display = "none";
			}
			document.getElementById("currentPage1").innerText = pageNo;
			document.getElementById("page1_" + pageNo).style.display = "";
		}
		
	}
</script>


<table id="tab3">
	<tr>
		<th class='blue' nowrap width="40%" >历史权限名称</th>
		<th class='blue' nowrap width="10%" >功能代码</th>
		<th class='blue' nowrap width="15%" >开始时间</th>
		<th class='blue' nowrap width="15%" >结束时间</th>
		<th class='blue' nowrap width="10%" >配置工号</th>
		<th class='blue' nowrap width="10%" >姓名</th>
	</tr>
	<%
	int no2 = 1;
	if(retCode.equals("000000") && result.length > 0){
		for (int i = 0; i < result.length; i ++){
			if (result[i][6] != null) {

				if (no2 % 10 == 1) {
					%>
					<tbody name='page2_<%=(no2/10+1)%>' id='page2_<%=(no2/10+1)%>' style='display:none'>
					<%
				}
				%>
				<tr>
					<td><%=result[i][6]%></td>
					<td><%=result[i][7]%></td>
					<td><%=result[i][8]%></td>
					<td><%=result[i][9]%></td>
					<td><%=result[i][10]%></td>
					<td><%=result[i][11]%></td>
				</tr>
				<%
				if (no2 % 10 == 0 || no2 == result.length) {
				%>
					</tbody>
				<%
				}
				no2 ++;
				
			}
		}
		no2 --;
  }
	%>
<table align="center">
	<tr>
		<td align="center">
			总记录数：<font name="totalPertain2" id="totalPertain2"><%=no2%></font>&nbsp;&nbsp;
			总页数：<font name="totalPage2" id="totalPage2"><%=(no2-1)/iPageSize+1%></font>&nbsp;&nbsp;
			当前页：<font name="currentPage2" id="currentPage2">1</font>&nbsp;&nbsp;
			每页行数：<%=iPageSize%>
			<a href="javascript:page2('1');">[第一页]</a>&nbsp;&nbsp;
			<a href="javascript:page2('-1');">[上一页]</a>&nbsp;&nbsp;
			<a href="javascript:page2('+1');">[下一页]</a>&nbsp;&nbsp;
			<a href="javascript:page2('<%=(no2-1)/iPageSize+1%>');">[最后一页]</a>&nbsp;&nbsp;
			跳转到指定页：
			<select name="toPage" id="toPage" style="width:80px" onchange="page2(this.value);">
				<%
				for (int i = 1; i <= (no2-1)/iPageSize+1; i ++) {
					%>
					<option value="<%=i%>">第<%=i%>页</option>
					<%
				}
				%>
			</select>
		</td>
	</tr>
</table>

<script language="javascript">
	page2("1");
	function page2(pageNo) {
		if (pageNo == "-1") {
			page2(String(parseInt(document.getElementById("currentPage2").innerText) - 1));
			return;
		} else if (pageNo == "+1") {
			page2(String(parseInt(document.getElementById("currentPage2").innerText) + 1));
			return;
		} else if (pageNo == "pageNo") {
			page2(document.getElementById("pageNo2").value);
			return;
		} else {
			pageNo = parseInt(pageNo);
			if (pageNo > parseInt(document.getElementById("totalPage2").innerText) || pageNo < 1) {
				return;
			}
			for (var a = 1; a <= <%=(no2-1)/iPageSize+1%>; a ++) {
				document.getElementById("page2_" + a).style.display = "none";
			}
			document.getElementById("currentPage2").innerText = pageNo;
			document.getElementById("page2_" + pageNo).style.display = "";
		}
		
	}
</script>

		
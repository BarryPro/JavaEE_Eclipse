<%
  /* *********************
   * 功能: 资费革命，查询资源量
   * 版本: 1.0
   * 日期: 2012-4-10 17:51:38
   * 作者: ningtn
   * 版权: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("========= ningtn in fe759PubPriceRevoMsg =====");
	String opCode = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	/*查询类型，3查询资源量汇总信息*/
	String qryType = request.getParameter("qryType");
	/* 资源量查询标识  0全部  1生效  2预约 */
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
	System.out.println("ningtn result1 明细 = [" + result1.length + "]");

	System.out.println("ningtn result2 = [" + result2.length + "]");

%>
		<ul class="cust-tab3-line"></ul>
		<ul class="cust-tab3-link">
			<a class="on">当前使用汇总</a>
			<a>当前使用明细</a>
			<a>预约汇总</a>
			<a>预约明细</a>
		</ul>
		<!-- 当前使用汇总 -->
		<table class="tab-con table-wrap">
			<tr>
				<th>
					产品
				</th>
				<th>
					总数量
				</th>
				<th>
					已使用数量
				</th>
				<th>
					剩余数量
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
		<!-- 当前使用明细 -->
		<table class="tab-con table-wrap" style="display:none;">
			<tr>
				<th>产品名称</th>
				<th>总数量</th>
				<th>已使用数量</th>
				<th>剩余数量</th>
				<th>生效时间</th>
				<th>失效时间</th>
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
		<!-- 预约汇总 -->
		<table class="tab-con table-wrap" style="display:none;">
			<tr>
				<th>分类</th>
				<th>预约量</th>
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
		<!-- 预约明细 -->
		<table class="tab-con table-wrap" style="display:none;">
			<tr>
				<th>产品名称</th>
				<th>预约量</th>
				<th>生效时间</th>
				<th>失效时间</th>
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
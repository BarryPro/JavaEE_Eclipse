<%
  /* *********************
   * 功能: 资费革命，翻页用
   * 版本: 1.0
   * 日期: 2012-4-10 17:51:38
   * 作者: ningtn
   * 版权: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("========= ningtn in fe759_page =====");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("phoneNo");
	/* 0代表产品取消查询 1代表查询6个月的办理记录包括销户转来的 */
	String qryType = request.getParameter("qryType");
	
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
  String regionCode= (String)session.getAttribute("regCode");
	
%>
		<wtc:service name="sProdInsQry" routerKey="region" routerValue="<%=regionCode%>"
			  retcode="retCode" retmsg="retMsg" outnum="20">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=qryType%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	if(!"000000".equals(retCode)){
		/*查询出错了啊*/
%>
		<script language="javascript">
			rdShowMessageDialog("<%=retCode%>:<%=retMsg%>",0);
		  location="/npage/se761/fe759Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%
	}else{
%>
	<table id="tableSelect33" class="table-wrap">
		<tr>
			<%
			if("e760".equals(opCode)){
			%>
			<th>
				全选<input type="checkbox" id="chooseAll" />
			</th>
			<%}%>
			<th>产品名称</th>
			<th>产品库名</th>
			<th>产品资源量</th>
			<th>折扣后单价</th>
			<th>产品购买量</th>
			<th>合计价格</th>
			<th>生效时间</th>
			<th>失效时间</th>
			<th>操作时间</th>
			<th>操作工号</th>
			<th>操作备注</th>
		</tr>
		<%
		for(int i = 0; i < result.length; i++){
		%>
		<tr>
			<%
			if("e760".equals(opCode)){
			%>
			<td>
				<input type="checkbox" id="pubProdLibInsId_<%=result[i][0]%>" value="<%=result[i][0]%>" />
				<input type="hidden" id="pubProdOfferId_<%=result[i][0]%>" value="<%=result[i][1]%>" />
				<input type="hidden" id="pubProdFirstTime_<%=result[i][0]%>" value="<%=result[i][8]%>" />
				<input type="hidden" id="pubProdOldAccept_<%=result[i][0]%>" value="<%=result[i][15]%>" />
				<input type="hidden" id="pubProdLibDetalId_<%=result[i][0]%>" value="<%=result[i][16]%>" />
			</td>
			<%}%>
			<td>
				<span id="pubProdOfferName_<%=result[i][0]%>"><%=result[i][2]%></span>
			</td>
			<td>
				<%=result[i][19]%>
			</td>
			<td>
				<span id="pubProdSumRes_<%=result[i][0]%>"><%=result[i][5]%></span> 
				<span id="pubProdResUtil_<%=result[i][0]%>"><%=result[i][17]%></span>
			</td>
			<td><span id="pubProdDisPrice_<%=result[i][0]%>"><%=result[i][14]%></span> 元</td>
			<td>
				<span id="pubProdOffAmount_<%=result[i][0]%>"><%=result[i][3]%></span>
			</td>
			<td>
				<span id="pubProdSumPrice_<%=result[i][0]%>"><%=result[i][4]%></span> 元
			</td>
			<td>
				<span id="pubProdEffDate_<%=result[i][0]%>"><%=result[i][6]%></span>
			</td>
			<td>
				<span id="pubProdExpDate_<%=result[i][0]%>"><%=result[i][7]%></span>
			</td>
			<td>
				<span id="pubProdFirstTimeShow_<%=result[i][0]%>"><%=result[i][8]%></span>
			</td>
			<td>
				<span id="pubProdLoginNo_<%=result[i][0]%>"><%=result[i][11]%></span>
			</td>
			<td>
				<span id="pubProdOpNote_<%=result[i][0]%>"><%=result[i][9]%></span>
			</td>
		</tr>
		<%
		}
		%>
	</table>
<%
	}
%>
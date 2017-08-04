<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode = (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag = "";
	
		String bianhao = request.getParameter("bianhao");
		String cus_pass = request.getParameter("cus_pass");
		String opnote = workNo + "进行g610详细信息查询";

%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
		routerValue="<%=regionCode%>"  id="loginAccept" />
		
	<wtc:service name="sg529InfoQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="60">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="g610"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=cus_pass%>"/>
		<wtc:param value="<%=opnote%>"/>
		<wtc:param value="<%=bianhao%>"/>
	</wtc:service>
	<wtc:array id="dcust3" scope="end" />

<body>
  <div id="Main">
	<div id="Operation_Table">
		<div class="title">
			<div id="title_zi">查询信息</div>
		</div>
<%
			if(retCode2.equals("000000")) {
			   if(dcust3.length>0) {
			   for(int i=0;i<dcust3.length; i++) {
%>
			<table>
				<tr>
	    <td class="blue" width="15%">集团订单号</td>
	    <td><%=dcust3[i][0]%></td> 
	    <td width="15%" class="blue">发起请求方标识</td>
	    <td><%=dcust3[i][1]%></td>
	    <td width="15%" class="blue">发起请求方名称</td>
	    <td><%=dcust3[i][2]%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">订购时间</td>
	    <td><%=dcust3[i][3]%></td>
	    <td width="15%" class="blue">客户名称</td>
	    <td><%=dcust3[i][4]%></td>
	    <td width="15%" class="blue">证件类型</td>
	    <td><%=dcust3[i][5]%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">证件号码</td>
	    <td><%=dcust3[i][6]%></td>
	    <td width="15%" class="blue">卡号归属省</td>
	    <td><%=dcust3[i][7]%></td>
	    <td width="15%" class="blue">卡号归属地市</td>
	    <td><%=dcust3[i][8]%></td>
		</tr>
		<tr>
	    <td class="blue" width="15%">收货人姓名名称</td>
	    <td><%=dcust3[i][9]%></td>
	    <td width="15%" class="blue">联系电话</td>
	    <td><%=dcust3[i][10]%></td>
	    <td width="15%" class="blue">固定电话</td>
	    <td><%=dcust3[i][11]%></td>
		</tr>
	
		<tr>
	    <td class="blue" width="15%">送货地址</td>
	    <td><%=dcust3[i][12]%></td>
	    <td width="15%" class="blue">收货人省份名称</td>
	    <td><%=dcust3[i][13]%></td>
	    <td width="15%" class="blue">收货人地市名称</td>
	    <td><%=dcust3[i][14]%></td>
		</tr>

		<tr>
	    <td class="blue" width="15%">收货人区县名称</td>
	    <td><%=dcust3[i][15]%></td>
	    <td width="15%" class="blue">邮政编码</td>
	    <td><%=dcust3[i][16]%></td>
	    <td width="15%" class="blue">配送时间要求</td>
	    <td>
	    	<%if ("1".equals(dcust3[i][17])){
	    				out.write("只工作日送货（双休日、假日不送货）");
	    		} else if ("2".equals(dcust3[i][17])){
	    				out.write("双休日、假日送货（工作日不送货）");
	    		} else if ("3".equals(dcust3[i][17])){
	    				out.write("工作日、双休日与假日均可送货");
	    		} %></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">套餐编码</td>
	    <td><%=dcust3[i][18]%></td>
	    <td width="15%" class="blue">套餐名称</td>
	    <td><%=dcust3[i][19]%></td>
	    <td width="15%" class="blue">预存款</td>
	    <td><%=dcust3[i][20]%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">支付流水</td>
	    <td><%=dcust3[i][21]%></td>
	    <td width="15%" class="blue">支付时间</td>
	    <td><%=dcust3[i][22]%></td>
	    <td width="15%" class="blue">支付银行</td>
	    <td><%=dcust3[i][23]%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">手机支付号码</td>
	    <td><%=dcust3[i][24]%></td>
	    <td width="15%" class="blue">开户号码</td>
	    <td><%=dcust3[i][25]%></td>
	    <td width="15%" class="blue">证件地址</td>
	    <td><%=dcust3[i][26]%></td>
		</tr>
				<tr height='25' align='center'><td colspan='6'>
					<input class="b_foot" name=close  onClick="window.close()" type=button value="关闭" />
					</td>
				</tr>
					 
			</table>
<%
		    }
		 	}else {
%>
			<table >					
				<tr height='25' align='center'><td colspan='6'>查询信息为空！</td></tr>
			</table>
<%
			}}else {
%>
			<script language="JavaScript">
			  rdShowMessageDialog("<%=retCode2%>"+"<%=retMsg2%>",0);	
			</script>
<%
			}
%>
		</div>
	</div>
</body>
</html>

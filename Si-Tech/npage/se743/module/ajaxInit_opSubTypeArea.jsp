<%
  /*
   * 功能: e743 全网集团业务订单受理
   * 版本: 1.0
   * 日期: 2012-03-31
   * 作者: wanghfa
   * 版权: si-tech
  */
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
%>
<script type=text/javascript>
	//putElement("orderSourceID", interBOSS.svcCont.orderInfoReq.orderSourceID);
	
	function collectOpSubTypeAreaNodes() {
		//interBOSS.svcCont.orderInfoReq.customerNumber.eleValue = $("#customerNumber").val();
	}
</script>

<table>
	<tr>
		<td class="blue" width="20%">操作类型</td>
		<td width="80%">
			<select name="operationSubTypeID" id="operationSubTypeID">
				<option value="">请选择</option>
				<option value="1">1-新增商品订购</option>
				<option value="2">2-取消商品订购</option>
				<option value="3">3-商品暂停</option>
				<option value="4">……</option>
			</select>
		</td>
	</tr>
</table>

<%
  /*
   * ����: e743 ȫ������ҵ�񶩵�����
   * �汾: 1.0
   * ����: 2012-03-31
   * ����: wanghfa
   * ��Ȩ: si-tech
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
		<td class="blue" width="20%">��������</td>
		<td width="80%">
			<select name="operationSubTypeID" id="operationSubTypeID">
				<option value="">��ѡ��</option>
				<option value="1">1-������Ʒ����</option>
				<option value="2">2-ȡ����Ʒ����</option>
				<option value="3">3-��Ʒ��ͣ</option>
				<option value="4">����</option>
			</select>
		</td>
	</tr>
</table>

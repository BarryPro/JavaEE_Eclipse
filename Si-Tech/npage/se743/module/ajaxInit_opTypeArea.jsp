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
	getServiceMsg("se743Init","doGetOpType",1,in_ChanceId);
	function doGetOpType(data) {
		$("#json1").val(data.trim());
		var opTypeJson = eval("(" + $("#json1").val() + ")");
		
		$("#orderType").empty();
		$("#poSpec").empty();
		if (opTypeJson.orderTypes != null) {
			for (var a = 0; a < opTypeJson.orderTypes.length; a ++) {
				for(var item in opTypeJson.orderTypes[a]){
					document.getElementById("orderType").options.add(new Option(opTypeJson.orderTypes[a][item], item)); 
				}
			}
		}
		if (opTypeJson.poSpecs != null) {
			for (var a = 0; a < opTypeJson.poSpecs.length; a ++) {
				for(var item in opTypeJson.poSpecs[a]){
					document.getElementById("poSpec").options.add(new Option(opTypeJson.poSpecs[a][item], item)); 
				}
			}
		}
	}
	
	function unAvailableOpTypeArea() {
		//$("#orderType").attr("disabled", true);
		unAvailable("orderType");
		unAvailable("poSpec");
	}
	
	function collectOpSubTypeAreaNodes() {
		//interBOSS.svcCont.orderInfoReq.customerNumber.eleValue = $("#customerNumber").val();
	}
</script>

<table>
	<tr>
		<td class="blue" width="20%">��������</td>
		<td width="30%">
			<select name="orderType" id="orderType" style="width:200px">
				<option value="">�ȴ���ʼ��......</option>
			</select>
		</td>
		<td class="blue" width="20%">��Ʒ���</td>
		<td width="30%">
			<select name="poSpec" id="poSpec" style="width:200px">
				<option value="">�ȴ���ʼ��......</option>
			</select>
		</td>
	</tr>
</table>


<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: liangyl 2017/07/20 9:50:29 ���ڹ���������ҵ��У԰�Ʒ�ģʽ����ʾ
   * ����: liangyl
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ include file="/npage/bill/getMaxAccept.jsp"%>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
%>


<html>
<head>
<title><%=opName%></title>
<script language="javascript" type="text/javascript"
	src="/npage/public/knockout-2.0.0.js"></script>
<script
	src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"
	type="text/javascript"></script>
<script language="javascript">
		
		$(document).ready(function(){
			
		});
		
		function doQry(){
			var schoolname = $.trim($("#schoolname").val());
			var building = $.trim($("#building").val());
			var qsnum = $.trim($("#qsnum").val());
			var kdstate = $.trim($("#kdstate").val());
			
			if(schoolname.length == 0){
				rdShowMessageDialog("������ѧУ���ƣ�");
				return false;
			}
			if(building.length == 0){
				rdShowMessageDialog("������¥�ţ�");
				return false;
			}
			if(qsnum.length == 0){
				rdShowMessageDialog("���������Һţ�");
				return false;
			}
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("fm391Qry.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "17";
			var iOpCode = "m391";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = "";
			var iUserPwd = "";
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("iSchoolName",schoolname);
			getdataPacket.data.add("iBuildNo",building);
			getdataPacket.data.add("iHouseNo",qsnum);
			getdataPacket.data.add("iBroadStatu",kdstate);
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
			var phoneMsg = packet.data.findValueByName("phoneMsg");
			
		if(retCode == "000000"){
				$("#phoneMsg").val(phoneMsg);
				$("#resultContent").show();
				$("#appendBody").empty();
				var showOpCode = "";
				var showOpName = "";
				var appendTh = 
					"<tr>"
					+"<th width='10%'>����˺�</th>"
					+"<th width='12%'>���״̬</th>"
					+"<th>��ϸ��Ϣ</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
				for(var i=0;i<infoArray.length;i++){
					var arr0 = infoArray[i][0];
					var arr1 = infoArray[i][1];
					var arr2 = infoArray[i][2];
					var appendStr = "<tr>";
					appendStr += "<td width='10%' align='center' >"+arr0+"</td>"
									+"<td width='12%' align='center' >"+arr1+"</td>"
									+"<td align='center' >"+arr2+"</td>"
					appendStr +="</tr>";	
					$("#appendBody").append(appendStr);
				}
				if(infoArray.length==0){
					var appendStr = "<tr>";
					appendStr += "<td width='10%' align='center' colspan='4'>�޲�ѯ��Ϣ!</td>"
					appendStr +="</tr>";	
					$("#appendBody").append(appendStr);
				}
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
			}
		}
</script>
</head>
<body>
	<form action="" method="post" name="f1">
		<%@ include file="/npage/include/header.jsp"%>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<div>
			<table>
				<tr>
					<td width="20%" class="blue">ѧУ����</td>
					<td width="30%"><input type="text" id="schoolname"
						name="schoolname" value="" maxlength="30"/><font style="color: red">*</font></td>
					<td width="20%" class="blue">¥��</td>
					<td width="30%"><input type="text" id="building"
						name="building" value="" maxlength="10"/><font style="color: red">*</font></td>
				</tr>
				<tr>
					<td width="20%" class="blue">���Һ�</td>
					<td width="30%"><input type="text" id="qsnum" name="qsnum"
						value="" maxlength="10"/><font style="color: red">*</font></td>
					<td width="20%" class="blue">���״̬</td>
					<td width="30%"><select id="kdstate" name="kdstate">
							<option value="0">ȫ��</option>
							<option value="1">������</option>
							<option value="2">��������</option>
					</select></td>
				</tr>
			</table>
			<div>
				<table>
					<tr>
						<td align=center colspan="4" id="footer">
							<input class="b_foot" id="configBtn" name="configBtn" type="button" value="��ѯ" onclick="doQry();">&nbsp;&nbsp;
							<input class="b_foot" id="resetBtn" name="resetBtn" type="button" value="����" onclick="javascript:window.location.reload();">&nbsp;&nbsp;
							<input class="b_foot" name="close" onClick="removeCurrentTab()" type=button value=�ر�>&nbsp;&nbsp;
							<input class="b_foot" name="print" onClick="printTable(exportExcel);" type=button value=����></td>
					</tr>
				</table>
				<!-- ��ѯ����б� -->
				<div id="resultContent" style="display: none">
					<div class="title">
						<div id="title_zi">��Ϣ��ѯ���</div>
					</div>
					<table id="exportExcel" name="exportExcel">
						<tbody id="appendBody">


						</tbody>
					</table>
				</div>
			</div>
			<input type="hidden" name="iLoginAcceptnew" id="iLoginAcceptnew" />
			<input type="hidden" name="oCustName" id="oCustName" value="" />
			<input type="hidden" name="oIccidNo" id="oIccidNo" value="" />
			<input type="hidden" name="oCustId" id="oCustId" value="" />

			<%@ include file="/npage/include/footer.jsp"%>
	</form>
	<script>
		var excelObj;
		function printTable(object) {
			var obj = document.all.exportExcel;
			rows = obj.rows.length;
			if (rows > 0) {
				try {
					excelObj = new ActiveXObject("excel.Application");
					excelObj.Visible = true;
					excelObj.WorkBooks.Add;
					for (i = 0; i < rows; i++) {
						cells = obj.rows[i].cells.length;
						for (j = 0; j < cells; j++)
							excelObj.Cells(i + 1, j + 1).Value = "'"
									+ obj.rows[i].cells[j].innerText;
					}
				} catch (e) {
				}
			} else {

			}
		}
	</script>
</body>


</html>

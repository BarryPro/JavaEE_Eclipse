<%
  /*
   * ����: R_CMI_HLJ_guanjg_2015_2094748@����������ר��ר��ҵ�����Ż��ĺ�
   * �汾: 1.0
   * ����: 2014/08/11 9:23:54
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
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
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		function checkInv(phoneNo){
			var returnVal = false;
			var phoneHead = phoneNo.substring(0,3);
			var phoneHead10648 = phoneNo.substring(0,5);
			var pLength = phoneNo.length;
			/*
			if( (pLength == 11 && (phoneHead == "147" || phoneHead == "205" || phoneHead == "206")) ||  (pLength == 13 && phoneHead10648 == "10648")){
				returnVal = true;
			}else{
				rdShowMessageDialog("����������ԡ�205������206������147����ͷ��11λ��������ԡ�10648����ͷ��13λ���룡",1);
				returnVal = false;
			}*/
			returnVal = true;
			return returnVal;
		}
		function doQry(){
			
			if(!check(f1)){
				return false;
			}
			/*�ֻ�����*/
			var phoneNo = $.trim($("#phoneNo").val());
			
			if(phoneNo.length != 0){
				if(!checkInv(phoneNo)){
					return false;
				}
			}
			
			/*���ű���*/
			var unitCode = $.trim($("#unitCode").val());
			
			/*��ѯ����*/
			var selType = $("select[name='selType']").find("option:selected").val();
			
			var startphoneNo = $.trim($("#startphoneNo").val());
			var endphoneNo = $.trim($("#endphoneNo").val());
			
			if(selType == "2"){
				if(startphoneNo.length != 0 && endphoneNo.length == 0){
					rdShowMessageDialog("��ʼ����ͽ����������ͬʱ���룡",1);
					return false;
				}else if(startphoneNo.length == 0 && endphoneNo.length != 0){
					rdShowMessageDialog("��ʼ����ͽ����������ͬʱ���룡",1);
					return false;
				}
				
				if(startphoneNo.length != 0 && endphoneNo.length != 0){
					if(startphoneNo > endphoneNo){
						rdShowMessageDialog("��ʼ���벻�ܴ��ڽ������룡",1);
						return false;
					}
					if(!checkInv(startphoneNo)){
						return false;
					}
					if(!checkInv(endphoneNo)){
						return false;
					}
				}
			}
			
			/*��ʼʱ��*/
			var startCust = $.trim($("#startCust").val());
			/*����ʱ��*/
			var endCust = $.trim($("#endCust").val());
			
			
			if(startCust.length == 0 || endCust.length == 0){
				rdShowMessageDialog("��ѡ��ʼ����ʱ�䣡",1);
				return false;
			}
			var startMonth = startCust.substring(0,6);
			var endMonth = endCust.substring(0,6);
			
			if(startMonth != endMonth){
				rdShowMessageDialog("��ʼ����ʱ�䲻������£�",1);
				return false;
			}
			
			var acceptss = $.trim($("#accepts").val());
				
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm238/fm238Qry.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("startCust",startCust);
			getdataPacket.data.add("endCust",endCust);
			getdataPacket.data.add("unitCode",unitCode);
			getdataPacket.data.add("selType",selType);
			
			getdataPacket.data.add("startphoneNo",startphoneNo);
			getdataPacket.data.add("endphoneNo",endphoneNo);
			getdataPacket.data.add("accepts",acceptss);			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
		
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			var selType = packet.data.findValueByName("selType");
			
		if(retCode == "000000"){
	
				$("#resultContent").show();
				$("#appendBody").empty();
				
				if(selType == "0"){
					var appendTh = 
						"<tr>"
						+"<th width='10%'>��������</th>"
						+"<th width='10%'>����ʱ��</th>"
						+"<th width='10%'>���ű���</th>"
						+"<th width='10%'>��������</th>"
						+"<th width='10%'>��������</th>"
						+"<th width='10%'>�ӿڷ���ʱ��</th>"
						+"<th width='10%'>����״̬��Ϣ</th>"
						+"<th width='10%'>����pboss��ˮ</th>"
						+"<th width='10%'>PBOSS������Ϣ</th>"
						+"<th width='10%'>ʡBOSS������Ϣ</th>"
						+"</tr>";
					$("#appendBody").append(appendTh);	
				for(var i=0;i<infoArray.length;i++){
						
						var msg0 = infoArray[i][0];
						var msg1 = infoArray[i][1];
						var msg2 = infoArray[i][2];
						var msg3 = infoArray[i][3];
						var msg4 = infoArray[i][4];
						var msg5 = infoArray[i][5];
						var msg6 = infoArray[i][6];
						var msg7 = infoArray[i][7];
						var msg8 = infoArray[i][8];
						var msg9 = infoArray[i][9];
				
				
						var appendStr = "<tr>";
						
						appendStr += "<td width='10%'>"+msg0+"</td>"
												+"<td width='10%'>"+msg1+"</td>"
												+"<td width='10%'>"+msg2+"</td>"
												+"<td width='10%'>"+msg3+"</td>"
												+"<td width='10%'>"+msg4+"</td>"
												+"<td width='10%'>"+msg5+"</td>"
												+"<td width='10%'>"+msg6+"</td>"
												+"<td width='10%'>"+msg7+"</td>"
												+"<td width='10%'>"+msg8+"</td>"
												+"<td width='10%'>"+msg9+"</td>"
						appendStr +="</tr>";	
										
						$("#appendBody").append(appendStr);
					}
					
				}else if(selType == "1"){
					var appendTh = 
						"<tr>"
						+"<th width='9%'>��������</th>"
						+"<th width='9%'>����ʱ��</th>"
						+"<th width='9%'>���ű���</th>"
						+"<th width='9%'>��������</th>"
						+"<th width='9%'>��������</th>"
						+"<th width='9%'>��Ʒ����ʵ��ID</th>"
						+"<th width='9%'>�ӿڷ���ʱ��</th>"
						+"<th width='9%'>����״̬��Ϣ</th>"
						+"<th width='9%'>����pboss��ˮ</th>"
						+"<th width='9%'>PBOSS������Ϣ</th>"
						+"<th width='9%'>ʡBOSS������Ϣ</th>"
						+"</tr>";
					$("#appendBody").append(appendTh);	
				for(var i=0;i<infoArray.length;i++){
						
						var msg0 = infoArray[i][0];
						var msg1 = infoArray[i][1];
						var msg2 = infoArray[i][2];
						var msg3 = infoArray[i][3];
						var msg4 = infoArray[i][4];
						var msg5 = infoArray[i][5];
						var msg6 = infoArray[i][6];
						var msg7 = infoArray[i][7];
						var msg8 = infoArray[i][8];
						var msg9 = infoArray[i][9];
						var msg10 = infoArray[i][10];
				
				
						var appendStr = "<tr>";
						
						appendStr += "<td width='9%'>"+msg0+"</td>"
												+"<td width='9%'>"+msg1+"</td>"
												+"<td width='9%'>"+msg2+"</td>"
												+"<td width='9%'>"+msg3+"</td>"
												+"<td width='9%'>"+msg4+"</td>"
												+"<td width='9%'>"+msg5+"</td>"
												+"<td width='9%'>"+msg6+"</td>"
												+"<td width='9%'>"+msg7+"</td>"
												+"<td width='9%'>"+msg8+"</td>"
												+"<td width='9%'>"+msg9+"</td>"
												+"<td width='9%'>"+msg10+"</td>"
						appendStr +="</tr>";	
										
						$("#appendBody").append(appendStr);
					}
					
				}else if(selType == "2"){
					var appendTh = 
						"<tr>"
						+"<th width='8%'>��������</th>"
						+"<th width='8%'>����ʱ��</th>"
						+"<th width='8%'>���ű���</th>"
						+"<th width='8%'>��������</th>"
						+"<th width='8%'>��������</th>"
						+"<th width='8%'>��Ʒ����ʵ��ID</th>"
						+"<th width='8%'>��Ա����</th>"
						+"<th width='8%'>�ӿڷ���ʱ��</th>"
						+"<th width='8%'>����״̬��Ϣ</th>"
						+"<th width='8%'>����pboss��ˮ</th>"
						+"<th width='8%'>PBOSS������Ϣ</th>"
						+"<th width='8%'>ʡBOSS������Ϣ</th>"
						+"</tr>";
					$("#appendBody").append(appendTh);	
				for(var i=0;i<infoArray.length;i++){
						
						var msg0 = infoArray[i][0];
						var msg1 = infoArray[i][1];
						var msg2 = infoArray[i][2];
						var msg3 = infoArray[i][3];
						var msg4 = infoArray[i][4];
						var msg5 = infoArray[i][5];
						var msg6 = infoArray[i][6];
						var msg7 = infoArray[i][7];
						var msg8 = infoArray[i][8];
						var msg9 = infoArray[i][9];
						var msg10 = infoArray[i][10];
						var msg11 = infoArray[i][11];
				
				
						var appendStr = "<tr>";
						
						appendStr += "<td width='8%'>"+msg0+"</td>"
												+"<td width='8%'>"+msg1+"</td>"
												+"<td width='8%'>"+msg2+"</td>"
												+"<td width='8%'>"+msg3+"</td>"
												+"<td width='8%'>"+msg4+"</td>"
												+"<td width='8%'>"+msg5+"</td>"
												+"<td width='8%'>"+msg6+"</td>"
												+"<td width='8%'>"+msg7+"</td>"
												+"<td width='8%'>"+msg8+"</td>"
												+"<td width='8%'>"+msg9+"</td>"
												+"<td width='8%'>"+msg10+"</td>"
												+"<td width='8%'>"+msg11+"</td>"
						appendStr +="</tr>";	
										
						$("#appendBody").append(appendStr);
					}
					
				}else if(selType == "3"){
					var appendTh = 
						"<tr>"
						+"<th width='8%'>��������</th>"
						+"<th width='8%'>����ʱ��</th>"
						+"<th width='8%'>���ű���</th>"
						+"<th width='8%'>��������</th>"
						+"<th width='8%'>��������</th>"
						+"<th width='8%'>��Ʒ����ʵ��ID</th>"
						+"<th width='8%'>��Ա����</th>"
						+"<th width='8%'>�ӿڷ���ʱ��</th>"
						+"<th width='8%'>����״̬��Ϣ</th>"
						+"<th width='8%'>����pboss��ˮ</th>"
						+"<th width='8%'>PBOSS������Ϣ</th>"
						+"<th width='8%'>ʡBOSS������Ϣ</th>"
						+"</tr>";
					$("#appendBody").append(appendTh);	
				for(var i=0;i<infoArray.length;i++){
						
						var msg0 = infoArray[i][0];
						var msg1 = infoArray[i][1];
						var msg2 = infoArray[i][2];
						var msg3 = infoArray[i][3];
						var msg4 = infoArray[i][4];
						var msg5 = infoArray[i][5];
						var msg6 = infoArray[i][6];
						var msg7 = infoArray[i][7];
						var msg8 = infoArray[i][8];
						var msg9 = infoArray[i][9];
						var msg10 = infoArray[i][10];
						var msg11 = infoArray[i][11];
				
				
						var appendStr = "<tr>";
						
						appendStr += "<td width='8%'>"+msg0+"</td>"
												+"<td width='8%'>"+msg1+"</td>"
												+"<td width='8%'>"+msg2+"</td>"
												+"<td width='8%'>"+msg3+"</td>"
												+"<td width='8%'>"+msg4+"</td>"
												+"<td width='8%'>"+msg5+"</td>"
												+"<td width='8%'>"+msg6+"</td>"
												+"<td width='8%'>"+msg7+"</td>"
												+"<td width='8%'>"+msg8+"</td>"
												+"<td width='8%'>"+msg9+"</td>"
												+"<td width='8%'>"+msg10+"</td>"
												+"<td width='8%'>"+msg11+"</td>"
						appendStr +="</tr>";	
										
						$("#appendBody").append(appendStr);
					}
					
				}
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				//$("#export").attr("disabled","disabled");
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
		}
		/*���Ӱ���Ϣ ��ѯ����*/
		function showMsg(productId){
			//alert(productId);
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = $.trim($("#phoneNo").val());
			var iUserPwd = "";
			
			/*ƴ�����*/
			var path = "/npage/sm202/fm202Qry_2.jsp";
		  path += "?iLoginAccept="+iLoginAccept;
		  path += "&iChnSource="+iChnSource;
		  path += "&iOpCode="+iOpCode;
		  path += "&iOpName=<%=opName%>";
		  path += "&iLoginNo="+iLoginNo;
		  path += "&iLoginPwd="+iLoginPwd;
		  path += "&iPhoneNo="+iPhoneNo;
		  path += "&iUserPwd=";
		  path += "&iProductId="+productId;
		  /*��*/
		  //alert(path);
		  window.open(path,"newwindow","height=350, width=500,top=50,left=200,scrollbars=no, resizable=no,location=no, status=no");
			

		}
		
		function showAndHideFunc(){
			/*��ѯ����*/
			var selType = $("select[name='selType']").find("option:selected").val();
			if(selType == "2"){
				$("#showAndHide").show();
			}else{
				$("#showAndHide").hide();
			}
		}
	
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		<table>
			
	    <tr>
	  		<td width="20%" class="blue">�ֻ�����</td>
	  		<td width="30%" >
	  			<input type="text" id="phoneNo" name="phoneNo" v_type="0_9" maxlength = "13" value="" />
	  		</td>
	  		<td width="20%" class="blue">������ˮ</td>
	  		<td width="30%" >
	  			<input type="text" id="accepts" name="accepts" v_type="0_9" maxlength = "14" value="" />
	  		</td>
	    </tr>
	    <tr id="showAndHide" style="display:none">
	  		<td width="20%" class="blue">��ʼ����</td>
	  		<td width="30%">
	  			<input type="text" id="startphoneNo" name="startphoneNo" v_type="0_9" maxlength = "13"  value="" />
	  		</td>
	  		<td width="20%" class="blue">��������</td>
	  		<td width="30%">
	  			<input type="text" id="endphoneNo" name="endphoneNo" v_type="0_9" maxlength = "13"  value="" />
	  		</td>
	    </tr>
	    <tr>
	  		<td width="20%" class="blue">���ű���</td>
	  		<td width="30%">
	  			<input type="text" id="unitCode" name="unitCode" v_type="0_9" maxlength="10" value="" />
	  		</td>
	  		<td width="20%" class="blue">��ѯ����</td>
	  		<td width="30%">
	  			<select name="selType" onchange="showAndHideFunc();">
	  				<option value="0">0-ECͬ��PBOSS</option>
	  				<option value="1">1-���Ų�Ʒ��ҵ�����</option>
	  				<option value="2">2-���ų�Ա��ҵ�����</option>
	  				<option value="3">3-��������������ҵ�����</option>
	  			</select>
	  		</td>
	  		
	    </tr>
	    <tr>
	    	<td class="blue">��ʼʱ��</td>
				<td>
						<input type="text" id="startCust"  name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y%M%d\'}'})"/>
							<img id = "imgCustStart" 
								First. onclick="WdatePicker({el:'startCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y%M%d\'}'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			 					&nbsp;&nbsp;<font class="orange">*</font>
				</td>
				<td class="blue">����ʱ��</td>
				<td>
					<input type="text" id="endCust"  name="endCust" readOnly onclick="WdatePicker({el:'endCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')||\'%y%M\'}'})"/>
							<img id = "imgCustEnd" 
								onclick="WdatePicker({el:'endCust',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')||\'%y%M\'}'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
								&nbsp;&nbsp;<font class="orange">*</font>
				</td>
	    </tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" name="sure"  type="button" value="��ѯ"  onclick="doQry();">&nbsp;&nbsp;
				<input class="b_foot" name="sure"  type="button" value="����"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
				<input class="b_foot" name="excelExport"  type="button" value="����EXCEL���"  onclick="printTable();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
				
			</td>
		</tr>
		</table>
	</div>
	<!-- ��ѯ����б� -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">��ѯ����б�</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
	</div>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</body>


</html>

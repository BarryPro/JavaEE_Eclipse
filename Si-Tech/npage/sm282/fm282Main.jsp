<%
  /*
   * ����: R_CMI_HLJ_guanjg_2015_2303829@�����Ż�ʵ����ʶϵ�й��ܵ�����ʾ
   * �汾: 1.0
   * ����: 2015/7/13 15:00:57
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
		
		String ipAddrM = (String)session.getAttribute("ipAddr");
 		String inst = "ͨ��phoneNo[" + phoneNo + "]��ѯ";
		String custName = "";
		
%>




  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		
		
		

		
		function doQry(){
			
			var phoneNo = $.trim($("#phoneNo").val());
			
			if(phoneNo.length == 0){
				rdShowMessageDialog("�������ֻ����룡",1);
				return false;
			}
			var filedName = $.trim($("#filedName").val());
				
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm282/fm282Qry.jsp","���ڻ�����ݣ����Ժ�......");
		 	getdataPacket.data.add("phoneNo","<%=phoneNo%>");
			getdataPacket.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
			
			
			
		
		if(retCode == "000000"){
				if(infoArray.length == 0){
					rdShowMessageDialog("û�пɷ�������!",1);
					return false;
				}	
				$("#resultContent").show();
				$("#appendBody").empty();
				
				
				var appendTh = 
					"<tr>"
					+"<th width='10%'>ѡ��</th>"
					+"<th width='30%'>����ʱ��</th>"
					+"<th width='30%'>��������</th>"
					+"<th width='30%'>��������</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
				
					var appendExpTime = "";
					
					for(var i=0;i<infoArray.length;i++){
						
						appendExpTime = "<input type='text' name='expTime"+i+"' value='"+infoArray[i][2]+"' v_must='1' v_type='date'/>";
						
						var appendStr = "<tr>";
					
						appendStr += "<td width='10%'><input type='radio' name='chkSome' checked value='"+i+"'/></td>"
												+"<td width='30%'>"+infoArray[i][0]+"</td>"
												+"<td width='30%'>"+infoArray[i][1]+"</td>"
												+"<td width='30%'>"+appendExpTime+"</td>"
						appendStr +="</tr>";
						$("#appendBody").append(appendStr);	
						
					}
									
					
				
				if(infoArray.length != 0){
					//$("#export").attr("disabled","");
				}
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				//$("#export").attr("disabled","disabled");
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
		}
		
	
		function doCfm(){
			
			
			var chkSome = $("input[name='chkSome'][checked]").val();
			if(chkSome.length == 0){
				rdShowMessageDialog("��ѡ�������Ϣ��",1);
				return false;
			}
			
			$("#appendBody tr:gt(0)").each(function(){
				
					//idno           = $(this).find("td:eq(0)").text().trim();
					//ocontact_phone = $.trim($("#phoneNo").val());
					//ocontact_name  = $.trim($("#custName").val());
				
			});
			var expTimeObj = $("input[name='expTime"+chkSome+"']")[0];
			if(!checkElement(expTimeObj)){
				
				return false;
			}
			
			if(rdShowConfirmDialog("ȷ���ύô?") == 1){
				/*�ύ*/
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm282/fm282Cfm.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iOpCode = "<%=opCode%>";
			var iPhoneNo = "<%=phoneNo%>";
			var expTime = expTimeObj.value;
			
			getdataPacket.data.add("opCode",iOpCode);
			getdataPacket.data.add("phoneNo",iPhoneNo);
			getdataPacket.data.add("expTime",expTime);
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
				
			}
			
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("�����ɹ���",2);
				window.location.reload();
			}else{
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				window.location.reload();
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
	  		<td width="20%" class="blue">�������</td>
	  		<td width="30%" colspan="3">
	  			<input type="text" id="phoneNo" name="phoneNo" value="<%=phoneNo%>" class="InputGrey" readonly />
	  		</td>
	  		
	  	</tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" name="sure"  type="button" value="��ѯ"  onclick="doQry();">&nbsp;&nbsp;
				<input class="b_foot" name="sure"  type="button" value="����"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
			</td>
		</tr>
		</table>
	</div>
	<div id="OfferAttribute"></div><!--����Ʒ����-->
	<!-- ��ѯ����б� -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">��ѯ����б�</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
		<table>
			<tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="ȷ��"  onclick="doCfm();">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
				</td>
			</tr>
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

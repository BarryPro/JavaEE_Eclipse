<%
  /*
   * ����:������ͳһ�Ż�������ʡ4Gר��������
   * �汾: 1.0
   * ����: 2014/03/10 9:15:13
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
 		String regionCodeSql = "select t.region_code,t.region_code||'-'||t.region_name from sregioncode t where t.use_flag = 'Y' order by region_code";
	
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg0" retcode="code0" outnum="13">
			<wtc:param value="<%=regionCodeSql%>"/>
		</wtc:service>
<wtc:array id="resultRegion" scope="end" />
	<%
		if(resultRegion.length == 0 || !"000000".equals(code0)){
			%>
				<script language="javascript">
					rdShowMessageDialog("��ȡ������Ϣʧ�ܣ�",1);
					removeCurrentTab();
				</script>
			<%
		}
	%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		
		/*��ѯ����*/
		function doQry(){
			/*��󴫵ݵĵ����ַ���*/
			var resultSelStr = "";
			var startCust = $("#startCust").val();
			var endCust = $("#endCust").val();
			if(startCust.length == 0 ){
				rdShowMessageDialog("�����뿪ʼʱ�䣡",1);
				$("#startCust").focus();
				return false;
			}
			if(endCust.length == 0 ){
				rdShowMessageDialog("���������ʱ�䣡",1);
				$("#endCust").focus();
				return false;
			}
			var nowSelStr = $("select[name='regionCodes']").val()+"";
			/*�ÿ�*/
			resultSelStr = "";
			
			var selectedStr = $("select[name='regionCodes']").find("option:selected").val();
			
			/*�������ȫʡѡ������¸�ֵ,�������һ����ûѡ�У���Ĭ��Ϊ��ѯȫʡ*/
			if(nowSelStr.indexOf("\&") != -1 || typeof(selectedStr) == "undefined"){
				
				$("select[name='regionCodes']").find("option").each(function(i){
					if(i != 0){
						if(i == 1){
							resultSelStr += $(this).val();
						}else{
							resultSelStr += "," + $(this).val();
						}
					}
				});
			}
			else{
				resultSelStr += nowSelStr;
			}
		
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm063/fm063Qry.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo ="";
			var iUserPwd = "";
			var iOpNote = "����Ա["+iLoginNo+"]����"+iOpCode+"����";
			var iBeginTime = startCust;
			var iEndTime = endCust;
			var iRegionCode = resultSelStr;
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("iOpNote",iOpNote);
			getdataPacket.data.add("iBeginTime",iBeginTime);
			getdataPacket.data.add("iEndTime",iEndTime);
			getdataPacket.data.add("iRegionCode",iRegionCode);
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
		}
		function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var retArray = packet.data.findValueByName("retArray");
			if(retCode == "000000"){
				$("#resultContent").show();
				$("#appendBody").empty();
				var appendTh = 
					"<tr>"
					+"<th width='20%'>�ֻ�����</th>"
					+"<th width='20%'>������������</th>"
					+"<th width='20%'>�ն�Ʒ������</th>"
					+"<th width='20%'>�ն��ͺ�����</th>"
					+"<th width='20%'>����״̬</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
				for(var i=0;i<retArray.length;i++){
					var appendStr = "<tr>";
					appendStr += "<td width='20%'>"+retArray[i][0]+"</td>"
											+"<td width='20%'>"+retArray[i][1]+"</td>"
											+"<td width='20%'>"+retArray[i][2]+"</td>"
											+"<td width='20%'>"+retArray[i][3]+"</td>"
											+"<td width='20%'>"+retArray[i][4]+"</td>";
					appendStr +="</tr>";						
					$("#appendBody").append(appendStr);
				}
				$("#excelExp").attr("disabled","");
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				$("#excelExp").attr("disabled","disabled");
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
		}
		
		
	</script>
	</head>
<body>
	<form action="" method="post" name="form_m063" id="form_m063">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
	<table >
		<tr>
			<td width="20%" class="blue">��������</td>
			<td width="80%" colspan="3">
				<select name="regionCodes" multiple="multiple" size="14">
					<%if(resultRegion.length > 0 && "000000".equals(code0)){
					%>
						<option value="&&" checked>--ȫʡ--</option>
					<%
					
							for(int i=0;i<resultRegion.length;i++){
					%>
						<option value="<%=resultRegion[i][0]%>"><%=resultRegion[i][1]%></option>
					<%
							}
					}
					%>
				</select>
				&nbsp;<font color="red">��סctrl�����������б�ѡ</font>
			</td>
		</tr>
		<tr>
			<td width="20%" class="blue">��ʼʱ��</td>
				<td width="30%">
						<input type="text"  id="startCust"  name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'%y-#{%M-6}-01'})"/>
							<img id = "imgCustStart" 
								onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'%y-#{%M-6}-01'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				</td>
			<td width="20%" class="blue">����ʱ��</td>
			<td width="30%">
				<input type="text"  id="endCust"  name="endCust" readOnly onclick="WdatePicker({el:'endCust',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}',maxDate:'%y-%M-%d'})"/>
							<img id = "imgCustEnd" 
								onclick="WdatePicker({el:'endCust',startDate:'%y-%M-%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}',maxDate:'%y-%M-%d'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			</td>
		</tr>
		
	
	</table>
	
	
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="��ѯ" onclick="doQry()" id="submitr">&nbsp;&nbsp;
							<input  name="resetsd"  class="b_foot" type="button" value="����" onclick="window.location.href = '/npage/sm063/fm063Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';" id="Button3">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=�ر� id="Button2" onclick="removeCurrentTab()">
							<input  name="back1"  class="b_foot" type="button" value="����excel" id="excelExp" onclick="printTable(exportExcel)" disabled="disabled">
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

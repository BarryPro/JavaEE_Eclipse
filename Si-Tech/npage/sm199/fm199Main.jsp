<%
  /*
   * ����: �����Ż��ͷ�CRMϵͳ�������·ݵ�һ������ĺ�
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
		
		String inParamsRegion [] = new String[2];
		inParamsRegion[0] = "select t.region_code,t.region_code ||'-'|| t.region_name as recname from sregioncode t where 1=1 and t.use_flag =:useFlag order by t.region_code ";
		inParamsRegion[1] = "useFlag=Y";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_region" retmsg="retMessage_region" outnum="2"> 
    <wtc:param value="<%=inParamsRegion[0]%>"/>
    <wtc:param value="<%=inParamsRegion[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_region"  scope="end"/>
<%
	if("000000".equals(retCode_region) && result_region.length > 0){
		
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("��ȡ������Ϣʧ��!",1);
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
		
		function doQry(){
			var phoneNo = $.trim($("#phoneNo").val());
			var selRegion = $("select[name='selRegion']").find("option:selected").val();
			var startTime = $.trim($("#startTime").val());
			var endTime = $.trim($("#endTime").val());
			/*����ͬʱ����*/
			if( (startTime.length == 0 && endTime.length != 0) || (startTime.length != 0 && endTime.length == 0) ){
				rdShowMessageDialog("����ʱ��Ϳ�ʼʱ�����ͬʱ����!");
      	return false;
			}
			/*���ѡ���˵���*/
			if(startTime.length == 0 || endTime.length == 0){
				rdShowMessageDialog("�����뿪ʼʱ������ʱ��!");
    		return false;
			}
				
			/*�����ʼ����ʱ������ǿ�*/
			if(startTime.length != 0 && endTime.length != 0){
				if(startTime > endTime){
					rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��!");
      		return false;
				}
				var startYear = startTime.substring(0,4);
				var endYear = endTime.substring(0,4);
				var startMonth = startTime.substring(4,6);
				var endMonth = endTime.substring(4,6);
				/*������һ������Ƚ��·��Ƿ񳬹�������Ȼ�£������ݲ�һ�� �м������ ������*/
				if((Number(endMonth) - Number(startMonth) >= 1) && (startYear == endYear )){
					rdShowMessageDialog("ʱ���ܳ�����Ȼ��!");
      		return false;
				}
				else if(startYear != endYear){
					rdShowMessageDialog("ʱ���ܳ�����Ȼ��!");
    			return false;
				}
			}
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm199/fm199Qry.jsp","���ڻ�����ݣ����Ժ�......");
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
			getdataPacket.data.add("startTime",startTime);
			getdataPacket.data.add("endTime",endTime);
			getdataPacket.data.add("selRegion",selRegion);
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
		}
		
		function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			if(retCode == "000000"){
				$("#resultContent").show();
				$("#appendBody").empty();
				var appendTh = 
					"<tr>"
					+"<th>�ֻ�����</th>"
					+"<th>��������</th>"
					+"<th>��������</th>"
					+"<th>����ʱ�� </th>"
					+"<th>������Ϣ����</th>"
					+"<th>�ӽ������ԭ������</th>"
					+"<th>����ʽ</th>"
					+"</tr>";
					$("#appendBody").append(appendTh);
					if(infoArray.length > 0){
						for(var i=0;i<infoArray.length;i++){
							var msg0 = infoArray[i][0];
							var msg1 = infoArray[i][1];
							var showText1 = "";
							if(msg1 == "01"){
								showText1 = "��������";
							}
							if(msg1 == "02"){
								showText1 = "ɧ�ŵ绰";
							}
							if(msg1 == "03"){
								showText1 = "��������";
							}
							var msg2 = infoArray[i][2];
							var showText2 = "";
							if(msg2 == "01"){
								showText2 = "ͣ����";
							}
							if(msg2 == "03"){
								showText2 = "ͣ����";
							}
							if(msg2 == "05"){
								showText2 = "�ر����к������й���";
							}
							
							var msg3 = infoArray[i][3];
							var msg4 = infoArray[i][4];
							var msg5 = infoArray[i][5];
							var msg6 = infoArray[i][6];
							var msg7 = infoArray[i][7];
							var msg8 = infoArray[i][8];
							var appendStr = "<tr>";
							appendStr += "<td width='15%'>"+msg7+"</td>"
													+"<td width='15%'>"+msg8+"</td>"
													+"<td width='15%'>"+msg4+"</td>"
													+"<td width='15%'>"+msg5+"</td>"
													+"<td width='15%'>"+showText1+"</td>"
													+"<td width='25%'>"+msg3+"</td>"
													+"<td width='25%'>"+showText2+"</td>"
							appendStr +="</tr>";	
							$("#appendBody").append(appendStr);
						}
						$("#export").attr("disabled","");
					}else{
						var appendStr = "<tr>";
						appendStr += "<td width='15%' colspan='7' align='center'>û�в�ѯ�����</td>"
						appendStr +="</tr>";	
						$("#appendBody").append(appendStr);
					}
			}else{
					$("#resultContent").hide();
					$("#appendBody").empty();
					$("#export").attr("disabled","disabled");
					rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
					window.location.href="fm199Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
		  		<td width="20%" class="blue">����</td>
		  		<td width="80%" colspan="3">
		  			<select name="selRegion">
		  				<option value="$$" selected>00--ȫʡ--</option>
		  				<%
		  					if("000000".equals(retCode_region) && result_region.length > 0){
		  						for(int i=0;i<result_region.length;i++){
		  						%>
		  							<option value="<%=result_region[i][0]%>"><%=result_region[i][1]%></option>
		  						<%
		  						}
		  					}
		  				%>
		  			</select>
		  		</td>
		    </tr>
		    <tr>
		    	<td width="20%" class="blue">��ʼʱ��</td>
		    	<td width=30%>
		    		<input name="startTime" type="text" id="startTime"  readonly
	        		onclick="WdatePicker({el:'startTime',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
							v_type="date3" value=""  maxlength="19" />
	       		<img id = "imgCustStart" 
							onclick="WdatePicker({el:'startTime',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
	 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
						<font class="orange">(yyyymmdd)</font>	
		    	</td>
		    	<td width=20% class="blue">����ʱ��</td>
		    	<td width=30%>
		    		<input name="endTime" type="text" id="endTime"  readonly
	        		onclick="WdatePicker({el:'endTime',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
							v_type="date3" value=""  maxlength="19" />
	       		<img id = "imgCustStart" 
							onclick="WdatePicker({el:'endTime',startDate:'%y%M%d',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"
	 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
						<font class="orange">(yyyymmdd)</font>	
		    	</td>
		    </tr>
		    <tr> 
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="��ѯ"  onclick="doQry();">&nbsp;&nbsp;
					<input class="b_foot" id="export" name="export"  type="button" value="����EXCEL" disabled="disabled"  onclick="printTable();">&nbsp;&nbsp;
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
	function printTable()
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

 <%
	/********************
	 version v2.0 ���ڿ�����̬��֤�빦�ܲ�������ĺ�
	������: si-tech
	update:2015/06/02 16:15:21 gaopeng
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode=request.getParameter("opCode");	
		String opName=request.getParameter("opName");

	String workno = (String)session.getAttribute("workNo");
	String regioncode=(String)session.getAttribute("regCode");
	String noPass = (String)session.getAttribute("password");
	String orgcode = (String)session.getAttribute("orgCode");
  String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  String regionCode= (String)session.getAttribute("regCode");
	String ipAddr = (String)session.getAttribute("ipAddr");
	
	String[] inParamsss5 = new String[2];
  inParamsss5[0] = "select t.region_code,t.region_code||'-'||t.region_name from sregioncode t where t.use_flag = 'Y' order by t.region_code"; 
  
  String ifProviceNo = "";
  String regionNo = "";

%>
<wtc:service name="sm263Check" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode222" retmsg="retMsg222" outnum="2">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workno%>"/>
				<wtc:param value="<%=noPass%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				
		</wtc:service>
		<wtc:array id="infoRet1" scope="end"/>
<%
	if("000000".equals(retCode222) && infoRet1.length > 0){
		ifProviceNo = infoRet1[0][0];
		regionNo = infoRet1[0][1];
	}
%>			
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">			
	<wtc:param value="<%=inParamsss5[0]%>"/>
	</wtc:service>
<wtc:array id="result5y" scope="end" />

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="sysAccept" />

<HTML>
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<script language="JavaScript">
		/*�ϴ���־*/
		var uploadFlag = false;
		
		$(document).ready(function(){
			changeType("config");
		});
		function doCommit()
		{
			
			var checkType = $.trim($("select[name='checkType']").find("option:selected").val());
			var regionSelStr = "";
			var checkType = $.trim($("select[name='checkType']").find("option:selected").val());
			var regionSelStr = "";
			$("input[name='regionSel']").each(function(){
				var checkStatus = $(this).attr("checked");
				if(checkStatus){
					var selVal = $(this).val();
					if(regionSelStr.length == 0 ){
						regionSelStr = selVal;
					}else{
						regionSelStr += "|"+selVal;
					}
				}
			});
			
			if(checkType.length == 0 ){
				rdShowMessageDialog("��ѡ��������֤ģʽ��");
				return false;
			}
			if(regionSelStr.length == 0 ){
				rdShowMessageDialog("��ѡ����У�");
				return false;
			}
			
			if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
			{
				/*�ύ*/
				formConfirm();
			}
			
		}
		
		function formConfirm(){
			
			var checkType = $.trim($("select[name='checkType']").find("option:selected").val());
			var regionSelStr = "";
			var i = 0;
			$("input[name='regionSel']").each(function(){
				var checkStatus = $(this).attr("checked");
				if(checkStatus){
					var selVal = $(this).val();
					if(regionSelStr.length == 0 ){
						regionSelStr = selVal;
					}else{
						regionSelStr += "|"+selVal;
					}
					i++;
				}
			});
			
			/*���ܴ���*/
			var cOpCode = $.trim($("#cOpCode").val());
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm263/fm263Cfm.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=sysAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=workno%>";
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
			
			getdataPacket.data.add("opNote","<%=workno%>����������֤����");
			getdataPacket.data.add("regionSelStr",regionSelStr);
			getdataPacket.data.add("cOpCode",cOpCode);
			getdataPacket.data.add("checkType",checkType);
			getdataPacket.data.add("regionSelNum",i);
			
			
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			
			if(retCode == "000000"){
				
				rdShowMessageDialog("�����ɹ���",2);
				doclear();
				
			}else{
				
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				doclear();
				
			}
			
		}

function doclear(){
	window.location.reload();	
}

function doQueryIt(){
	
		var regionSelect = $.trim($("select[name='regionSelect']").find("option:selected").val());
		/*ajax start*/
		var getdataPacket = new AJAXPacket("/npage/sm263/fm263RegionQry.jsp","���ڻ�����ݣ����Ժ�......");
		
		getdataPacket.data.add("opCode","<%=opCode%>");
		getdataPacket.data.add("regionSelect",regionSelect);
		
		core.ajax.sendPacket(getdataPacket,doRetRegionQry);
		getdataPacket = null;
}

function doRetRegionQry(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			
			var infoArray = packet.data.findValueByName("infoArray");
			
			if(retCode == "000000"){
				
				$("#resultContent2").show();
				$("#appendBody2").empty();

				for(var i=0;i<infoArray.length;i++){
						
						var msg0 = infoArray[i][0];
						var msg1 = infoArray[i][1];
						var msg2 = infoArray[i][2];
						var msg3 = infoArray[i][3];
						var msg4 = infoArray[i][4];
						var msg5 = infoArray[i][5];
						
				
						var appendStr = "<tr>";
						
						appendStr += "<td width='13%'>"+msg0+"</td>"
												+"<td width='13%'>"+msg1+"</td>"
												+"<td width='15%'>"+msg2+"</td>"
												+"<td width='13%'>"+msg3+"</td>"
												+"<td width='13%'>"+msg4+"</td>"
												+"<td width='13%'>"+msg5+"</td>"
												
						appendStr +="</tr>";	
										
						$("#appendBody2").append(appendStr);
					}
				
			}else{
				
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				
			}
			
		}

function doQry(){
			
		
			var cOpCode = $.trim($("#cOpCode").val());
			if(cOpCode.length == 0){
				rdShowMessageDialog("�����빦�ܴ��룡");
				return false;
			}
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm263/fm263Qry.jsp","���ڻ�����ݣ����Ժ�......");
			
			
			
			getdataPacket.data.add("cOpCode",cOpCode);
			getdataPacket.data.add("opCode","<%=opCode%>");
			
			core.ajax.sendPacket(getdataPacket,doRetQry);
			getdataPacket = null;
		}
		
		function doRetQry(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			
			var function_code = packet.data.findValueByName("function_code");
			var function_name = packet.data.findValueByName("function_name");
			var infoArray = packet.data.findValueByName("infoArray");
			
			if(retCode == "000000"){
				if($.trim(function_code).length != 0){
					/*��ֵ*/
					$("#cOpName").val(function_name);
					/*ȷ�ϰ�ť�ɵ��*/
					$("#quchoose").attr("disabled","");
					/*��ѯ��ť���ɵ��*/
					$("#qryUnitBtn").attr("disabled","disabled");
					$("#cOpCode").attr("class","InputGrey");
					$("#cOpCode").attr("readonly","readonly");
				}
				$("#resultContent").show();
				$("#appendBody").empty();

				for(var i=0;i<infoArray.length;i++){
						
						var msg0 = infoArray[i][0];
						var msg1 = infoArray[i][2];
						var msg2 = infoArray[i][1];
						var msg3 = infoArray[i][4];
						var msg4 = infoArray[i][5];
						
				
						var appendStr = "<tr>";
						
						appendStr += "<td width='20%'>"+msg3+"</td>"
												+"<td width='20%'>"+msg4+"</td>"
												+"<td width='20%'>"+msg0+"</td>"
												+"<td width='20%'>"+msg1+"</td>"
												+"<td width='20%'>"+msg2+"</td>"
												
						appendStr +="</tr>";	
										
						$("#appendBody").append(appendStr);
					}
				
			}else{
				
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				$("#quchoose").attr("disabled","disabled");
				$("#qryUnitBtn").attr("disabled","");
					$("#cOpCode").attr("class","");
					$("#cOpCode").attr("readonly",false);
				
			}
			
		}
		
		function checkAll(){
			var checkStatus = $("input[name='regionSelAll']").attr("checked");
			if(checkStatus){
				$("input[name='regionSel']").each(function(){
					$(this).attr("checked","checked");
				});
			}else{
				$("input[name='regionSel']").each(function(){
					$(this).attr("checked","");
				});
			}
		}
		
		function changeType(vtype){
			if(vtype == "config"){
				$("#configContent1").show();
				$("#configContent2").show();
				$("#queryContent").hide();
				$("#queryContent2").hide();
				$("#resultContent").show();
				$("#resultContent2").hide();
			}else if(vtype == "query"){
				$("#configContent1").hide();
				$("#configContent2").hide();
				$("#queryContent").show();
				$("#queryContent2").show();
				$("#resultContent").hide();
				$("#resultContent2").show();
			}
		}
	
	</script>
</HEAD>
<BODY >
	<FORM action="" method=post name="frm" ENCTYPE="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
				
				<table id=""  cellspacing="0">      	
        	  <tr>

			        		<td width=20% class="blue">��������</td>

			        		<td width=80% colspan="3">

			        			<input type="radio" name="opType"	value="config"   onclick="changeType(this.value);" checked/>������֤���� &nbsp;&nbsp;

			        			<input type="radio" name="opType"	value="query"  onclick="changeType(this.value);"/>������֤���ò�ѯ &nbsp;&nbsp;

			        		</td>

        				</tr>
       </table>
       <table cellspacing="0" id="queryContent">
       	<tr>
       		<td width=20% class="blue">����</td>
       		<td width=80% colspan="3">
       			<select name="regionSelect">
       				<%if(result5y.length > 0){
			  					for(int i=0;i<result5y.length;i++){
			  						if("1".equals(ifProviceNo)){
			  				%>
			  				<option value="<%=result5y[i][0]%>"><%=result5y[i][1]%></option>
			  				<%
			  						}else{
			  							if(result5y[i][0].equals(regionNo)){
			  					%>
			  								<option value="<%=result5y[i][0]%>"><%=result5y[i][1]%></option>
			  					<%	
			  							}
			  						}
			  					}
			  				}
			  				%>
       			</select>	
       		</td>
       	</tr>
       </table>
				<table cellspacing="0" id="configContent1">
			    <tr>
			  		<td width="20%" class="blue">��������</td>
			  		<td width="30%">
			  			<input type="text" id="cOpCode" name="cOpCode"  maxlength="10" value="" />&nbsp;&nbsp;
			  			<input type="button" id="qryUnitBtn" class="b_text" name="qryUnitBtn" value="��ѯ" onclick="doQry();"/>
			  		</td>
			  		<td width="20%" class="blue">��������</td>
			  		<td width="30%">
			  			<input type="text" id="cOpName" name="cOpName"  value="" class="InputGrey" readonly />&nbsp;&nbsp;
			  			
			  		</td>
			    </tr>
			    <tr>
			  		<td width="20%" class="blue">������֤ģʽ</td>
			  		<td width="80%" colspan="3">
			  			<select name="checkType" >
			  				<option value="">--��ѡ��--</option>
			  				<option value="0">����������֤</option>
			  				<option value="1">�����������֤</option>
			  				<option value="2">�������������������֤</option>
			  				<%if("1".equals(ifProviceNo)){%>
			  				<option value="3">����֤</option>
			  				<%}%>
			  			</select>
			  		</td>
			    </tr>
			    <tr>
			  		<td width="20%" class="blue">����</td>
			  		<td width="80%" colspan="3">
			  				<%if("1".equals(ifProviceNo)){%>
			  				<input type="checkbox" name="regionSelAll" value="" onclick="checkAll();"/>ȫʡ
			  				<%}%>
			  				<%if(result5y.length > 0){
			  					for(int i=0;i<result5y.length;i++){
			  					if("1".equals(ifProviceNo)){
			  				%>
			  				<input type="checkbox" name="regionSel" value="<%=result5y[i][0]%>"/><%=result5y[i][1]%>&nbsp;
			  				<%
					  			}else{
						  				if(result5y[i][0].equals(regionNo)){
						  				%>
						  				<input type="checkbox" name="regionSel" value="<%=result5y[i][0]%>"/><%=result5y[i][1]%>&nbsp;
						  				<%
						  				}
					  				}
			  					}
			  				}
			  				%>
			  		</td>
			    </tr>
		    	
	  		</table>      	
     
       <table cellspacing="0" id="configContent2">
        	<tbody>
        		<tr>
          		<td id="footer">
                  <input  name="quchoose" id="quchoose" class="b_foot" type="button" value="ȷ��"  onclick="doCommit();" disabled>
                  &nbsp;
                	<input  name="clear" class="b_foot" type=reset value="����" onclick="doclear()">
                	&nbsp;                  			

          		</td>
        		</tr>
        </tbody>
      	</table>
      	
      	<table cellspacing="0" id="queryContent2">
        	<tbody>
        		<tr>
          		<td id="footer">
                  <input  name="doQuery" id="doQuery" class="b_foot" type="button" value="��ѯ"  onclick="doQueryIt();">
                  &nbsp;
                   <input  name="doExcel" id="doExcel" class="b_foot" type="button" value="����EXCEL���"  onclick="printTable();">
                  &nbsp;
                	<input  name="clear" class="b_foot" type=reset value="����" onclick="doclear()">
                	&nbsp;                  			

          		</td>
        		</tr>
        </tbody>
      	</table>
      	
      	<!-- ��ѯ����б� -->
				<div id="resultContent" style="display:block">
					<div class="title">
						<div id="title_zi">��ǰ���ý���б�&nbsp;</div>
					</div>
					<table id="exportExcel" name="exportExcel">
						<th width="20%">���б���</th>
						<th width="20%">��������</th>
						<th width="20%">������֤ģʽ</th>
						<th width="20%">���ù���</th>
						<th width="20%">����ʱ��</th>
						<tbody id="appendBody">
							
						
						</tbody>
					</table>
				</div>
				
				<!-- ��ѯ����б� -->
				<div id="resultContent2" style="display:block">
					<div class="title">
						<div id="title_zi">��ѯ����б�&nbsp;</div>
					</div>
					<table id="exportExcel2" name="exportExcel2">
						<th width="13%">��������</th>
						<th width="13%">��������</th>
						<th width="15%">������������</th>
						<th width="13%">����ʱ��</th>
						<th width="13%">��������</th>
						<th width="13%">���Ź���</th>
						<tbody id="appendBody2">
							
						
						</tbody>
					</table>
				</div>
      
	     <%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script>
var excelObj;
function printTable()
{
	var obj=document.all.exportExcel2;
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
</BODY>
</HTML>


<%
  /*
   * ����: gaopeng 2015/03/06 10:23:14 ��������ǰ̨���ͷ�����ͬ���ط�ҵ�������
   * �汾: 1.0
   * ����: 2015/02/11 14:57:30
   * ����: gaopeng
   * ��Ȩ: si-tech
   
   
    -------------------------�޸�-----------�ξ�ΰ(hejwa) 2015-4-22 16:21:35-------------------
		��������ǰ̨���ͷ�����ͬ���ط�ҵ��Ĳ�������
		��ҳ����°벿�����Ӳ�ѯ����
		
	  -------------------------��̨��Ա�����ĸ�--------------------------------------------
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
    
    String loginNo     = (String)session.getAttribute("workNo");
 		String noPass      = (String)session.getAttribute("password");
 		
		String opCode     = (String)request.getParameter("opCode");
		String opName     = (String)request.getParameter("opName");	 
		
				//��ǰʱ��
		String currentDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		//31��ǰ��ʱ��
		Calendar now =Calendar.getInstance();  
		now.setTime(new java.util.Date());  
		now.set(Calendar.DATE,now.get(Calendar.DATE)-31);  
		String b31_Date = new java.text.SimpleDateFormat("yyyyMMdd").format( now.getTime());
		
		
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
	
		
		
		/*2015/02/11 17:14:37 gaopeng ȷ�Ϸ���*/
		function doCfm(){
			
			var run_code_now = $("#run_code_now").val();
			run_code_now = run_code_now.split("-->")[0];
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm222/fm222Cfm.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = $.trim($("#phoneNo").val());
			var iUserPwd = "";
			var specialProduct = $("select[name='specialProduct']").find("option:selected").val();
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			getdataPacket.data.add("specialProduct",specialProduct);
			getdataPacket.data.add("run_code_now",run_code_now);
			
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
			
		}
		
		
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			//retMsg = retMsg.replace("SUCCESS","");
			
			var run_code_now = $("#run_code_now").val();
			run_code_now = run_code_now.split("-->")[0];
			
			if(retCode == "000000"){
				if(run_code_now == "A"){
					rdShowMessageDialog(""+retMsg,2);
				}else{
					rdShowMessageDialog("HLRͬ���ɹ�!",2);	
				}
				window.location.reload();
			}else{
				
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				window.location.reload();
				
			}
			
		}
		
		
	//ajax��ѯHLR����ͬ����¼	
	function qryFunc(){
		var beginDate = $("#beginDate").val();
		var endDate   = $("#endDate").val();
		
		
				
		if($("#phoneIn").val().trim()==""&&$("#oprLoginNo").val().trim()==""){
			rdShowMessageDialog("�ֻ��ź͹�����������һ��");
			return;
		}
		
		if($("#phoneIn").val().trim()!=""){//��Ϊ��ʱУ���ֻ���
			if(!forMobil(document.f1.phoneIn))  return false;
		}
		
		if(beginDate==""){
			rdShowMessageDialog("��ѡ��ʼʱ��");
			return;
		}
		
		if(endDate==""){
			rdShowMessageDialog("��ѡ�����ʱ��");
			return;
		}

		if(beginDate>endDate){
			rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��");
			return;
		}
		
		
		var packet = new AJAXPacket("fm222_1.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");// 
			packet.data.add("phoneNo",$("#phoneIn").val().trim());//
			packet.data.add("oprLoginNo",$("#oprLoginNo").val().trim());//
			packet.data.add("beginDate",beginDate+"000000");//
			packet.data.add("endDate",endDate+"235959");//
			core.ajax.sendPacket(packet,doQryFunc);
			packet = null; 
	}
	
	
	
//��ѯ��̬չʾIMEI�����б��ص�
function doQryFunc(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg  = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
								
				if(retArray[i][3]!="0"){
					trObjdStr += "<tr>"+
												 "<td>"+retArray[i][0]+"</td>"+  
												 "<td>"+retArray[i][1]+"</td>"+  
												 "<td>"+retArray[i][2]+"</td>"+  
												 "<td>"+retArray[i][3]+"</td>"+  
												 "<td>"+retArray[i][4]+"</td>"+  
												 "<td>"+retArray[i][5]+"</td>"+  
												 "<td>"+retArray[i][9]+"</td>"+  
												 "<td>"+retArray[i][6]+"</td>"+  
												 "<td>"+retArray[i][7]+"</td>"+  
												 "<td>"+retArray[i][8]+"</td>"+  
										 "</tr>";
				}
			}
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}

function qryUserInfo(){
		if(!forMobil(document.f1.phoneNo))  return false;
		
		if($("#phoneNo").val().trim()==""){
			rdShowMessageDialog("�������ֻ���");
			$("#phoneNo").focus();
			return;
		}
		
		var packet = new AJAXPacket("fm222_2.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");// 
			packet.data.add("opName","<%=opName%>");// 
			packet.data.add("loginAccept","<%=loginAccept%>");// 
			packet.data.add("phoneNo",$("#phoneNo").val().trim());//
			core.ajax.sendPacket(packet,doQryUserInfo);
			packet = null; 
}
function doQryUserInfo(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg  = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){ 
		  var custName      = packet.data.findValueByName("custName"); //
			var run_code      = packet.data.findValueByName("run_code"); //
			var run_code_last = packet.data.findValueByName("run_code_last"); //
			var run_name_last = packet.data.findValueByName("run_name_last"); //
			var run_code_now  = packet.data.findValueByName("run_code_now"); //
			var run_name_now  = packet.data.findValueByName("run_name_now"); //
			
			$("#custName").val(custName);
			$("#run_code_now").val(run_code_now+"-->"+run_name_now);
			if(run_code_now == "A"){
				/*�����ڿͷ�CRMϵͳ�����ӡ�VOLTEҵ�����ù��ܡ������� �û���ǰ״̬ΪAʱ������volte�ط�ѡ��*/
	  			$("select[name='specialProduct']").empty();
	  			$("select[name='specialProduct']").append("<option value='03'>����Ϣ</option>");
	  			$("select[name='specialProduct']").append("<option value='55'>GPRS</option>");
	  			$("select[name='specialProduct']").append("<option value='19'>������ʾ</option>");
	  			$("select[name='specialProduct']").append("<option value='28'>�ر�����</option>");
	  			$("select[name='specialProduct']").append("<option value='MY'>������</option>");
	  			$("select[name='specialProduct']").append("<option value='00'>���ʳ�;</option>");
	  			$("select[name='specialProduct']").append("<option value='29'>����</option>");
	  			$("select[name='specialProduct']").append("<option value='99'>VOLTE</option>");
			}else{
				$("select[name='specialProduct']").empty();
  			$("select[name='specialProduct']").append("<option value='03'>����Ϣ</option>");
  			$("select[name='specialProduct']").append("<option value='55'>GPRS</option>");
  			$("select[name='specialProduct']").append("<option value='19'>������ʾ</option>");
  			$("select[name='specialProduct']").append("<option value='28'>�ر�����</option>");
  			$("select[name='specialProduct']").append("<option value='MY'>������</option>");
  			$("select[name='specialProduct']").append("<option value='00'>���ʳ�;</option>");
  			$("select[name='specialProduct']").append("<option value='29'>����</option>");
				
			}
			
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
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
	  		<td >
	  			<input type="text" id="phoneNo" name="phoneNo"  value="" maxlength="11" />
	  			<input class="b_foot" name="qryBtn" id="qryBtn"  type="button" value="��ѯ"  onclick="qryUserInfo();" > 
				</td>
				<td width="20%" class="blue"><span id="si_show_span">�ط���Ʒ</span></td>
	  		<td  width="30%">
	  			<select name="specialProduct" >
	  				<option value="03">����Ϣ</option>
	  				<option value="55">GPRS</option>
	  				<option value="19">������ʾ</option>
	  				<option value="28">�ر�����</option>
	  				<option value="MY">������</option>
	  				<option value="00">���ʳ�;</option>
	  				<option value="29">����</option>
	  			</select>
	  		</td>
	    </tr>
	    <tr>
	  		<td width="20%" class="blue">�ͻ�����</td>
	  		<td width="30%">
	  			<input type="text" id="custName" name="custName" class="InputGrey" readonly value=""/>
	  		</td>
	  		<td width="20%" class="blue">��ǰ״̬</td>
	  		<td width="30%">
	  			<input type="text" id="run_code_now" name="run_code_now" class="InputGrey" readonly value=""/>
	  		</td>
	    </tr>
	  </table>
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
	  <table>
	    <tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="confirmBtn" id="confirmBtn"  type="button" value="ȷ��"  onclick="doCfm();" >&nbsp;&nbsp;
					<input class="b_foot" name="resetBtn" id="resetBtn"  type="button" value="����"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type="button" value="�ر�">
					
				</td>
			</tr>
		</table>
	</div>
	
	<div class="title">
		<div id="title_zi">HLR����ͬ����¼��ѯ</div>
	</div>
	<table cellSpacing="0">
	<tr>
	    <td class="blue" width="20%">�ֻ�����</td>
		  <td width="30%">
			    <input type="text" name="phoneIn" id="phoneIn"  maxlength="11"  value=""/> 
		  </td>
		  <td class="blue" width="20%">��������</td>
		  <td width="30%">
			    <input type="text" name="oprLoginNo" id="oprLoginNo" maxlength="6" value=""/> 
		  </td>
	</tr>
	<tr>
		  <td class="blue" width="20%">��ʼʱ��</td>
		  <td width="30%">
			    <input type="text" name="beginDate" id="beginDate" value="<%=b31_Date%>"  onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />  
		  </td>
		  <td class="blue" width="20%">����ʱ��</td>
		  <td width="30%"> 
			    <input type="text" name="endDate" id="endDate" value="<%=currentDate%>" onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />   
		  </td>
	</tr>
</table>
		<table>
	    <tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="qryBtn" id="qryBtn"  type="button" value="��ѯ"  onclick="qryFunc();" > 
					
				</td>
			</tr>
		</table>
	
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="12%">������ˮ</th>
        <th width="12%">�ֻ�����</th>
        <th width="8%">��������</th>
        <th width="8%">ҵ�����</th>	
        <th width="10%">ҵ������</th>
        <th width="13%">����ʱ��</th>	
        <th width="10%">����˵��</th>
        <th width="13%">����ʱ��</th>
        <th width="8%">���ش���</th>
        <th >�������</th>
    </tr>
</table>

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

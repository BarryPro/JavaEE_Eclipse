<%
   /*
   * ����: �û�������Ϣ
�� * �汾: v1.0
�� * ����: 2008/10/18
�� * ����: ranlf
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.net.InetAddress"%>
<%
    String callPhone = request.getParameter("callPhone");
    String contactId = request.getParameter("contactId");
%>




<div class="functitle">�û�������ˮ</div>
				<table>
					<tr>
						
						<td colspan="3" onClick="copyToClipBoard(this)"><%=contactId%></td>
						
					</tr>
					<tr>
						<th>���к���</th>
						<td colspan="2" id="caller_phone_no" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>���к���</th>
						<td colspan="2" id="called_phone_no" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>������</th>
						<td colspan="2" id="town" onClick="copyToClipBoard(this)"></td>
						
					</tr>	
					<tr>
						<th>�ͻ�����</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>�ͻ�����</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>�ͻ�Ʒ��</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>����ʽ</th>
						<td colspan="2" id="handleType" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th >�������</th>
						<td colspan="2" id="serviceNO" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr id="handleNo_town_tr" style="display:none">
						<th>������</th>
						<td colspan="2" id="handleNo_town" onClick="copyToClipBoard(this)"></td>
						
					</tr>	
					<tr>
						<th>��ϵ�绰</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>��ϵ��ַ</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>����״̬</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>��������</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>Ԥ���</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th>Ƿ��</th>
						<td colspan="2" onClick="copyToClipBoard(this)"></td>
						
					</tr>
					<tr>
						<th nowrap >�Ʒ����ͣ�</th>
  	  			<td colspan="2" nowrap onClick="copyToClipBoard(this)"></td>
  	  			
					</tr>
				</table>
				<div class="visitorFunc">
					<div class="functitle">������IP��<%=InetAddress.getLocalHost().getHostAddress()%></div>
					<!--
					<div class="functitle">��ǰ�ڴ棺<span id="par_curMem"></span>M</div>	
				  -->
					 <!--
					<div class="functitle">����Ա���ù���</div>
					<a href="javascript:addTab(true,'a03','�ۺϲ�ѯ','childTab_call.jsp?parentOpCode=K170')">�ۺϲ�ѯ</a>
					<a href="javascript:addTab(true,'a04','ý���ѯ','childTab_call.jsp?parentOpCode=K180')">ý���ѯ</a>
					<a href="javascript:addTab(true,'a05','�Ӵ���¼','childTab_call.jsp?parentOpCode=K190')">�Ӵ���¼</a>
					<br />
					<a href="javascript:addTab(true,'a06','������ѯ','childTab_call.jsp?parentOpCode=K220')">������ѯ</a>
					<a href="javascript:addTab(true,'a07','�ʼ��ѯ','childTab_call.jsp?parentOpCode=K200')">�ʼ��ѯ</a>
					<a href="javascript:addTab(true,'a08','�ʼ쿼��','childTab_call.jsp?parentOpCode=K210')">�ʼ쿼��</a>
				-->
				</div>
<script language="javaScript">
	
	
	//��ѯ���ĵ绰����
	var searchPhoneNo = "<%=callPhone%>";
	var callerNo = cCcommonTool.getCaller();
	var calledNo = cCcommonTool.getCalled();
	cCcommonTool.DebugLog("fget  callerNo"+callerNo);
	cCcommonTool.DebugLog("fget  calledNo"+calledNo);
	var handleNo = "";
	//д���������
	if(callerNo!=undefined)
	{
	if(callerNo.length==11){
		handleNo = callerNo;
	}
}
if(calledNo!=undefined)
	{
	if(calledNo.length==11){
		handleNo = calledNo;
	}
}
	//alert('11'+handleNo);
	document.getElementById('serviceNO').innerHTML = handleNo;
	//alert('searchPhoneNo='+searchPhoneNo);
//alert('calledNo='+calledNo);
	//�������������ͨ���û����벻ͬ(����/����)������������������
	if(searchPhoneNo!=callerNo&&searchPhoneNo!=calledNo){
		//update �������
		document.getElementById('serviceNO').innerHTML = "<%=callPhone%>";
		//show el
		document.getElementById('handleNo_town_tr').style.display = 'block';
		//��չ��ѯ����������������������
		
		getLocationEx(searchPhoneNo,updateHandleNoRegion);
	}
		
	
  var workNo=cCcommonTool.getWorkNo();
  //tancf 20090604
  /*
	var current_CurState=0;
	if(parPhone.QueryAgentStatusEx(workNo)==0){
		current_CurState=parPhone.AgentInfoEx_CurState;
	}
	//alert(cCcommonTool.getCaller()+"ss"+cCcommonTool.getCalled());
	
	//alert('callerId='+callerId+' calledId='+calledId);
	
	if(current_CurState==5){
	*/
	//cCcommonTool.DebugLog("fget  parPhone.IsTalking"+parPhone.IsTalking);
	//if(parPhone.IsTalking==1){
		document.getElementById('caller_phone_no').innerHTML=callerNo;	
		document.getElementById('called_phone_no').innerHTML=calledNo;
  
		if(cCcommonTool.getOp_code()=="K025"){
  		//20090312 fangyuan ����ʱ����ʽΪ�绰����
  		document.getElementById("handleType").innerHTML = "�绰����";
  		// by fangyuan 090324 ������кŶθ��¹�������Ϣ
  		getLocation(cCcommonTool.getCalled());
  	}else{
  		// by fangyuan 090324 ������кŶθ��¹�������Ϣ
  		getLocation(cCcommonTool.getCaller());
 	  }
  /*else{
  		getLocation('<%=callPhone%>');
  		document.getElementById('serviceNO').innerHTML='<%=callPhone%>';
  }*/
  	
  	
  //-----methods collection---------- begin
  
  //��ѯ�����������صĶ�̬�ص�����
  function updateHandleNoRegion(packet){
    	var retCode = packet.data.findValueByName("retCode");	
			if (retCode == "000000") {
				var townName ="";
				
				townName = packet.data.findValueByName("townName");
				var provice=packet.data.findValueByName("provice");
				
				// ����������������
				document.getElementById('handleNo_town').innerHTML = townName;
				document.getElementById('provice').value=provice;
				return;
			}	
  }
  
  //getLocation ��չ����
  function getLocationEx(phoneNo,callback){
  	if(phoneNo==''||phoneNo=='undefined'){
  		return;
  	}
  	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/portal/getLocation.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
		packet.data.add("callPhone",phoneNo);
		core.ajax.sendPacket(packet,callback,true);
		packet=null;
  }	
  	
  	
  	
  function getLocation(phoneNo){
  	if(phoneNo==''||phoneNo=='undefined'){
  		return;
  	}
  	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/portal/getLocation.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
		packet.data.add("callPhone",phoneNo);
		core.ajax.sendPacket(packet,doGetLocation,true);
		packet=null;
  }
  
  function doGetLocation(packet){
  	var retCode = packet.data.findValueByName("retCode");	
		if (retCode == "000000") {
			var townName ="";
			townName = packet.data.findValueByName("townName");
			// �����޸Ľڵ������
			document.getElementById('town').innerHTML = townName;
			return;
		}
  }	
  //-----methods collection---------- end 
  //��������ѡ������ by libin 2009/04/28
	  function copyToClipBoard(obj){
	  //alert("+++++++++++++++++");
			var clipBoardContent = obj.innerHTML; 		
			window.clipboardData.setData('Text',clipBoardContent);		
		}
</script>
<script>
	//by zwy 20090617 ��ʾ�ڴ�
	/*
	function displayIEMem(){
		document.getElementById("par_curMem").innerHTML=cCcommonTool.getCurrentIEMemUsed();
	}	
	setInterval("displayIEMem()",2000);
	*/
</script>	


<%
	 /*
	 * ����: 12580Ⱥ��-send����
	 * �汾: 1.0.0
	 * ����: 2009/01/12
	 * ����: xingzhan
	 * ��Ȩ: sitech
	 * update:
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<style>
#msg{
width:180px;
height:120px;
position:absolute;
right:0px;
bottom:0px;
z-index:2;
border:1px solid #555;
background:url(<%= request.getContextPath() %>/nresources/default/images/callimage/msg_bj.gif) repeat-x 0 0;
font-size:12px;
}
#msgTitle{
height:16px;
padding:8px 0px 0px 10px;
border-bottom:2px solid #b3f9ff;
position:relative;
}
#msgContent{
padding:10px;
height:1%;
color:#555;
}
#msgImg{
position:absolute;
right:5px;
top:5px;
z-index:10;
width:10px;
height:10px;
}
</style>
<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);
%>
<%
  
  String opCode = "K505";
  String opName = "Ⱥ��";

  String SERIAL_NO = request.getParameter("SERIAL_NO")==null?"":request.getParameter("SERIAL_NO"); 
  String ACCEPT_NO = request.getParameter("ACCEPT_NO")==null?"":request.getParameter("ACCEPT_NO");
  String savelist = request.getParameter("savelist")==null?"":request.getParameter("savelist");
  
  String myList[] = new String[]{};
  
  String sSql = "select a.PERSON_PHONE from DPHONLIST a,(select LIST_SERIAL_NO from DMSGGRPPHONLIST where 1=2 ";
  
  String[] sn = (String[])SERIAL_NO.split(";");
  for(int i = 0; i < sn.length; i++){
  	sSql += " or GRP_SERIAL_NO = '"+sn[i]+"'";
  }
  sSql += ")b where a.serial_no = b.LIST_SERIAL_NO";
  
%>  
<wtc:service name="s151Select" outnum="2">
	<wtc:param value="<%=sSql %>" />
</wtc:service>
<wtc:array id="queryList" scope="end" />
<% 
  int num = 0;
  
  for(int i=0;i<queryList.length;i++){
  	
  	if(queryList[i][0]!=null&&!"".equals(queryList[i][0])){
  		num++;
  	}
  }
%>
<html>
	<head>
		<title>Ⱥ��</title>
		<script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>
		<script language=javascript>
		function checkThisB(a){
		    
		    document.getElementById("ACCEPT_NOc").disabled = "";
			
		}
		function checkThisA(a){
		
			document.getElementById("ACCEPT_NOc").disabled = "disabled";
			
		}
		function addNum(){
			
			deleteNull();
			
			if(document.getElementById("Phone_num").value ==""){
				
				return;
			}
			
			if(!f_check_mobile(document.getElementById("Phone_num").value)){;
						showTip(document.getElementById("Phone_num"),"�Ÿ�ʽ����ȷ�������ѡ�������");
				    document.getElementById("Phone_num").focus();
						return;
					}
			var text = document.getElementById("Phone_num").value;
			var value = document.getElementById("Phone_num").value;
			
			var n = "1";
			
			for(var i =0;i<document.getElementById("GRP_NUM").options.length;i++){
		
				if(document.getElementById("GRP_NUM").options[i].value==text){
					n="0";
					window.opener.parent.similarMSNPop("�˺����Ѵ��ڸ��б��У�");
					//rdShowMessageDialog("�˺����Ѵ��ڸ��б��У�",1)
					return;
				}
			}
			
			if(n=="1"){
				document.getElementById("GRP_NUM").options.add(new Option(text,value));
				document.getElementById("Phone_num").value = "";
			}
		}
		function deleteAll(){
			var len = document.getElementById("GRP_NUM").options.length;
			var sel = document.getElementById("GRP_NUM").options;
		
			for(var i=len-1;i>=0;i--){
           		sel.remove(i);
        	}
			
		}
		function deleteNull(){
			var len = document.getElementById("GRP_NUM").options.length;
			var sel = document.getElementById("GRP_NUM").options;
		
			//alert(len);
			for(var i=len-1;i>=0;i--){
				//alert(sel[i].value);
				if(""==(sel[i].value.trim())){
				//	alert(sel[i].value);
					sel.remove(i);				
				}
        	}
		}
		function deleteOne(){
				
			var sel = document.getElementById("GRP_NUM").options;
			
			if(sel.selectedIndex<0){
				window.opener.parent.similarMSNPop("������ѡ��һ���绰����");
				//rdShowMessageDialog("������ѡ��һ���绰����",1);
			}
				
			while(sel.selectedIndex>=0) {
			  sel.options.remove(sel.selectedIndex);
			} 
			
		}
		
		//ȥ���ҿո�;
		function trim(s){
				return rtrim(ltrim(s));
		}
		//ȥ��ո�;
		function ltrim(s){
		  	return s.replace( /^\s*/, "");
		}
		
		//ȥ�ҿո�;
		function rtrim(s){
				return s.replace( /\s*$/, "");
		}
		function sendMessage(){
			
			var phone_number = "";
			var sel = document.getElementById("GRP_NUM").options;
			
			if(sel.length > 100){
				window.opener.parent.similarMSNPop("һ������෢��100������");
				return;
			}
			for(var i =0;i<sel.length;i++){
				
				phone_number = phone_number + "_" + sel[i].value;
			}
			
			if("" == phone_number.replace("_","")){
				window.opener.parent.similarMSNPop("֪ͨ�����б�Ϊ�գ����������һ���绰����");
				//rdShowMessageDialog("֪ͨ�����б�Ϊ�գ����������һ���绰���롣",1);
				return;
			}
			//alert(phone_number);
		
			var ACCEPT_NOb = document.getElementById("ACCEPT_NOb");
			var ACCEPT_NOc = document.getElementById("ACCEPT_NOc");
			var ACCEPT_NO = "10658088" ;
			if(ACCEPT_NOb.checked){
				
				ACCEPT_NO = ACCEPT_NOc.value;
			}
			if("" == ACCEPT_NO){
				window.opener.parent.similarMSNPop("���кŲ���Ϊ��");
				//rdShowMessageDialog("���кŲ���Ϊ��!",1);
				return;
			}
			var shortmessage = document.getElementById("shortmessage").value;
			if("" == shortmessage){
				window.opener.parent.similarMSNPop("�������ݲ���Ϊ��");
				//rdShowMessageDialog("�������ݲ���Ϊ��!",1);
				return;
			}
			if(shortmessage.length>300){
				window.opener.parent.similarMSNPop("�������ݲ��ܳ���300������");
				//rdShowMessageDialog("�������ݲ��ܳ���300������!",1);
				return;
			}
			if(rdShowConfirmDialog("�Ƿ�ȷ�����Ͷ��ţ�")!=1){
				
				return;
		  }
			var callerphone = "";
			var contactid = "";
			
			if(window.opener.top.cCcommonTool != undefined && window.opener.top.cCcommonTool.getCaller() != ""){
				callerphone = window.opener.top.cCcommonTool.getCaller();
				contactid = trim(window.opener.parent.document.getElementById("contactIdnew").innerHTML);
			}else{
				callerphone = trim(window.opener.parent.document.getElementById("caller_phone_no").innerHTML);
		  }
		  
			var myPacket = new AJAXPacket("k505_send_obj.jsp","�����ύ�����Ժ�......");
			myPacket.data.add("callerphone",callerphone);
			
			myPacket.data.add("contactid",contactid);
			myPacket.data.add("phone_number",phone_number);
			myPacket.data.add("ACCEPT_NO",ACCEPT_NO);
			myPacket.data.add("shortmessage",shortmessage);
	       	core.ajax.sendPacket(myPacket,doProcess,true);
		  	myPacket=null;
		}
		function doProcess(myPacket)
		{
		
		    var retType = myPacket.data.findValueByName("retType");
			var retCode = myPacket.data.findValueByName("retCode");
			var retMsg = myPacket.data.findValueByName("retMsg");
			if(retCode=="000000"){
				//alert("����ɹ�");
				//rdShowMessageDialog("�ɹ�",2);
				//window.dialogArguments.similarMSNPop("�ɹ�");
				//window.dialogArguments.similarMSNPop("�ɹ�");
				//similarMSNPop("�ɹ�");
				window.opener.submitMe('msgY');
			  window.close();
			    //window.close();
			}else{
				//rdShowMessageDialog("ʧ��",0);
				window.opener.submitMe('msgN');
        //window.dialogArguments.similarMSNPop("ʧ��");
				return false;
			}
		}
		
		//�ж϶��������ͷ��Ͷ�������
		function onCharsChange(varField){ 
			var leftChars = getLeftChars(varField);
			var num = 1;
	      if ( leftChars >= 0){
					document.sitechform.charsmonitor.value=leftChars;
					if(parseInt(leftChars%70)==0){
						num = leftChars/70;
					}else{
						num = parseInt(leftChars/70)+1;
					}
					
					document.sitechform.sendnum.value = num;
					return true;   
        }
    }
    function getLeftChars(varField)   {   
      var i = 0;   
      var counter = 0;
      var leftchars = varField.value.length;            
      return (leftchars);   
    }
    function contentOnKeyDownSend(){
	  	if(event.keyCode == 13){
			  sendMessage();
			}
	  }
		</script>
	</head>
	<body >
	    <form name="sitechform" id="sitechform">
		    <div id="Operation_Table">
				<div class="title">
				����֪ͨ
				</div>
				<table  cellspacing="0">
					<tr>
						<td width="40%" valign="top"  nowrap="nowrap">
							ָ���ͳ����뷽ʽ��
							<div>
								<input type="radio" name="ACCEPT_NO" id="ACCEPT_NOa" value="<%=ACCEPT_NO==null?"":ACCEPT_NO %>" checked="checked" onclick="checkThisA(this);">ϵͳĬ��<br>
								<input type="radio" name="ACCEPT_NO" id="ACCEPT_NOb" value="" onclick="checkThisB(this);">ָ������&nbsp;<input type="text" name="ACCEPT_NOc" id="ACCEPT_NOc" value="<%=ACCEPT_NO %>" disabled="disabled">
							</div>
						</td>
						<td rowspan="3">
							<input type="checkbox" name="" id="" value="">���ݴ�����Ա
							��<input name=charsmonitor style="border:none;" tabindex=100 value=0 e=5 size="2" readonly>�ַ�  ��<input name=sendnum style="border:none;" tabindex=100 value=0 e=5 size="2" readonly>�η���<br />
							<div>
								<textarea rows="20" cols="60" name="shortmessage" id="shortmessage" onpaste="return onCharsChange(this);" onkeyup="onCharsChange(this);" onkeydown="contentOnKeyDownSend();" tabIndex=1 onchange="return onCharsChange(this);"></textarea>
							</div>
							<center><input type="button" name="" class="b_foot" id="" value="����" onclick="sendMessage();">&nbsp;<input type="button" name="" class="b_foot" id="" onClick="window.close();" value="�˳�"></center>
						</td>
					</tr>
					<tr>
						<td valign="top" nowrap="nowrap">
							���֪ͨ����
							<div>
								<input type="text" name="Phone_num"  id="Phone_num" value="" onClick="hiddenTip(this);">&nbsp;<input type="button" class="b_foot" name="" id="" value="���" onclick="addNum();">
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" nowrap="nowrap" >
							֪ͨ�����б���<%=num %>����
							<div>
								<select name="GRP_NUM"  id="GRP_NUM" multiple="multiple" size="5" style="width:35mm">
									<%  
									  if(queryList.length>0){
									  	
									  	for(int i=0;i<queryList.length;i++){
									  		%>
									  		<option value="<%=queryList[i][0] %>" ><%=queryList[i][0] %></option>
									  		<%
									  	}
									  }
									%>
								</select>
								<br>
								<input type="button" name="" class="b_foot" id="" value="���" onclick="deleteAll();">&nbsp;
								<input type="button" name="" class="b_foot" id="" value="ɾ��" onclick="deleteOne();">
								
							</div>
						</td>
					</tr>
				</table>
			</div>	
	    </form>
	</body>	
</html>	

   
<%
/********************
 version v2.0
 ������ si-tech
 create hejw@2010-5-25 :10:48
********************/
%>

              
<%
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ include file="/npage/common/pwd_comm.jsp" %>	

<%@ page contentType= "text/html;charset=GBK" %>
 
<HTML><HEAD><TITLE><%=opName%></TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>



<%
String regionCode = (String)session.getAttribute("regCode");
String workNo =  (String)session.getAttribute("workNo");

%>

<wtc:utype name="sLinkOprChk" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:uparam value="<%=activePhone%>" type="STRING"/>  
	<wtc:uparam value="<%=opCode%>" type="STRING"/>  
	<wtc:uparam value="<%=workNo%>" type="STRING"/>
</wtc:utype>

<%

	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1).replaceAll("\\n"," "); 
	 

	 
	 
	 if(!retCode.equals("0")){
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=retCode%>:<%=retMsg%>",0);
	removeCurrentTab();
</script>
<%	 
	 }
	 
String checkedStr1,checkedStr2 = ""; 
if(opCode.equals("7690")){
	checkedStr1 = "checked";
	checkedStr2 = "";
}else{
	checkedStr1 = "";
	checkedStr2 = "checked";
}
%>	 	

<script language="JavaScript">
	 function sub(){
	 		document.frm1.action = "f7690_2.jsp?loverNo="+document.all.loverNo1.value;
	 		document.frm1.submit();
	 }
	 
	 function checkRa(thisValue){
	 		if(thisValue=="1"){
	 			document.all.usrPwdTr.style.display="";
	 			document.frm1.subBut.disabled = true;
	 			document.all.opCode.value="7690";
	 			document.all.opName.value="���±��س�������";
	 			$("#searchBtnSpan").hide();
	 			$("#searchContent").hide();
	 		}else if(thisValue=="0"){
	 			document.all.usrPwdTr.style.display="none";
	 			document.frm1.subBut.disabled = false;
	 			document.all.opCode.value="7691";
	 			document.all.opName.value="���±��س���ȡ��";
	 			$("#searchBtnSpan").hide();
	 			$("#searchContent").hide();
	 		}else if(thisValue=="2"){
	 			document.frm1.subBut.disabled = true;
	 			$("#searchBtnSpan").show();
	 			$("#searchContent").show();
	 			document.all.usrPwdTr.style.display="none";
	 		}
	 }
	 
	 function checkPass(){
	 		  var Pwd1 = document.all.user_passwd.value;
			  var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
				checkPwd_Packet.data.add("Pwd1",Pwd1);
				checkPwd_Packet.data.add("phone_no",document.frm1.loverNo1.value);
				core.ajax.sendPacket(checkPwd_Packet,doCheckPass);
				checkPwd_Packet = null;
	 }
	 
	 function searchContent(){
	 	var phoneNo = $("#phoneNo").val();
	 	var packet = new AJAXPacket("ajaxGetRelation.jsp","���ڲ�ѯ��Ϣ�����Ե�......");
	 	packet.data.add("phoneNo",phoneNo);
	 	core.ajax.sendPacketHtml(packet,doShowContent);
	 	packet = null;
	 }
	 
	 function doShowContent(data){
	 	$("#searchContent").html(data);
	 }
	 
	 
	 function doCheckPass(packet){
	 	  var retCode = packet.data.findValueByName("retCode");
			var retMessage=packet.data.findValueByName("retMessage");
	 		if(retCode == "000000")
	        {
	            var retResult = packet.data.findValueByName("retResult");
	           if (retResult == "false"){
	    	    	rdShowMessageDialog("���º�����У��ʧ�ܣ����������룡",0);
		        	frm1.user_passwd.value = "";
		        	document.frm1.loverNo1.disabled = false;
		        	document.frm1.subBut.disabled = true;
		        	
	    	    	return false;	        	
	            }
	            else
	            {
	            	rdShowMessageDialog("���º�����У��ɹ���",2);
	            	document.frm1.loverNo1.disabled = true;
	            	document.frm1.subBut.disabled = false;
				}
	        }
	        else
	        {
	            rdShowMessageDialog("���º�����У�����������У�飡",0);
	    				return false;
	        }
	 }
	  
</script>
</HEAD>
<BODY >
<FORM  method=post name=frm1 >
	<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div> 
            <table cellspacing="0">
 							 <tr>
 							 	<td class="blue">��������</td>
 							 	<td class="blue" colspan="3">
 							 	<input type="radio" value="1" name="ra" <%=checkedStr1%> onclick="checkRa(this.value)">����&nbsp;
 							 	<input type="radio" value="0" name="ra" <%=checkedStr2%> onclick="checkRa(this.value)">ȡ��
 							 	<input type="radio" value="2" name="ra" onclick="checkRa(this.value)"/>��ѯ�����ϵ
 							 	</td>
 							 </tr>
 							 	
 							 	<tr>
 							 			<td class="blue">�ֻ�����</td>
 							 			<td colspan="2"><input type="text" name="phoneNo" id="phoneNo" value="<%=activePhone%>" readOnly class="InputGrey"></td>
 							 			
 							 			<td >
 							 				<span id="searchBtnSpan" name="searchBtnSpan" style="display:none">
 							 					<input type="button" class="b_text" name="searchBtn" id="searchBtn" value="��ѯ" onclick="searchContent();"/>
 							 				</span>
 							 			</td>
 							 	</tr>
 							 		
 							 	 <tr id="usrPwdTr">
									<td class="blue" nowrap>���º���</td>
									<td> 
										<input type="text" name="loverNo1"  name="loverNo1" v_type="mobphone" v_must="1" maxlength="11" onblur="checkElement(this)" >
							    	</td>
									<td class="blue">���º�����</td>
									<td> 
										<jsp:include page="/npage/common/pwd_1.jsp">
									      <jsp:param name="width1" value="16%"  />
									      <jsp:param name="width2" value="34%"  />
									      <jsp:param name="pname" value="user_passwd"  />
									      <jsp:param name="pwd" value="account_passwd"  />
								        </jsp:include>
								        <input name=chkPass1 type=button onClick="checkPass();" class="b_text" style="cursor:hand" id="chkPass1" value=У��>
							            <font class="orange">*</font>
							    	</td>
								</tr>
			</table>
			<div id="searchContent"></div>
			<table>					
 							 	<tr>	
 							 		<td id="footer" colspan="4">
 							 			<input type="button" id="subBut" class="b_foot" value="��һ��" onclick="sub()" disabled>
 							 			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()">
 							 		</td>
 							 	</tr>
            </table>

			<div id="relationArea" style="display:none"></div>
				<div id="wait" style="display:none">
					<img  src="/nresources/default/images/blue-loading.gif" />
				</div>
			<div id="beforePrompt"></div>

<script>
	
	function topage(opcode,valideVal,openflag,title,targetUrl)
	{
		 if((typeof parent.L)=="function")
		 {
		 		parent.L(openflag,opcode,title,targetUrl,valideVal);
		 }else{
				parent.parent.L(openflag,opcode,title,targetUrl,valideVal);
		 }
	}
	
	$(function(){
		//$('#wait').show();
		//getBeforePrompt();
		getOpRela();
	}); 
	
	function getOpRela()
	{
		var packet = new AJAXPacket("/npage/include/getOpRela.jsp","���Ժ�...");
		packet.data.add("opCode" ,"<%=opCode%>");
	  core.ajax.sendPacketHtml(packet,doGetOpRela,true);//�첽
		packet =null;
	}
	
	function doGetOpRela(data)
	{
		if(data.trim()!="")
		{
			$('#relationArea').html(data);
			$('#relationArea').show();
		}
	}
	
	function getBeforePrompt()
	{
		var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","���Ժ�...");
		packet.data.add("opCode" ,"<%=opCode%>");
	    core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//�첽
		packet =null;
	}
	
	function doGetBeforePrompt(data)
	{
		$('#wait').hide();
		$('#beforePrompt').html(data);
	}
	
	function getAfterPrompt()
	{
		var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","���Ժ�...");
		packet.data.add("opCode" ,"<%=opCode%>");
	  core.ajax.sendPacket(packet,doGetAfterPrompt,false);//ͬ��
		packet =null;
	}
	
	function doGetAfterPrompt(packet)
	{
    var retCode = packet.data.findValueByName("retCode"); 
    var retMsg = packet.data.findValueByName("retMsg"); 
    if(retCode=="000000"){
    	promtFrame(retMsg);
    }
	}
	
	
    function getMidPrompt(classCode,classValue,id111,smCode)
	{
		var packet = new AJAXPacket("/npage/include/getMidPrompt.jsp","���Ժ�...");
		packet.data.add("opCode" ,"<%=opCode%>");
		packet.data.add("classCode" ,classCode);
		packet.data.add("classValue" ,classValue);
		packet.data.add("id" ,id111);
		packet.data.add("smCode" ,smCode);
	  core.ajax.sendPacket(packet,doGetMidPrompt,true);//�첽
		packet =null;
	}
	
	
	function doGetMidPrompt(packet)
	{
	
    var retCode = packet.data.findValueByName("retCode"); 
    var retMsg = packet.data.findValueByName("retMsg"); 
    var id111 = packet.data.findValueByName("id"); 

    if(retCode=="000000"){
				document.getElementById(id111).className = "promptBlue";
				$("#"+id111).attr("title",retMsg);
				$("#"+id111).tooltip();
		}else
			{
				document.getElementById(id111).className = "";
				$("#"+id111).attr("title","");
				$("#"+id111).tooltip();
			}
	}
</script>

<input type="hidden" name="loverNo" id="loverNo" value="">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
</FORM>
</BODY>

<script language="JavaScript">
   if("<%=opCode%>".trim()=="7691"){
	 		document.all.usrPwdTr.style.display="none";
	 		document.frm1.subBut.disabled = false;
	 	}else{
	 		document.all.usrPwdTr.style.display="";
	 		document.frm1.subBut.disabled = true;
	 	}
	 	
</script>	 	
</HTML>
						
  					

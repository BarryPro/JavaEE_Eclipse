<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��˧���±�
   * �汾: 2.0
   * ����: 2010/07/26
   * ����: weigp
   * ��Ȩ: si-tech
   * update:
   */
%>
<%
	String opCode = request.getParameter("opCode");
	String opName = "��˧���±�";

	
	String oldPhone = request.getParameter("activePhone");
	String workNo = (String)session.getAttribute("workNo");
	//��ѯ�ͻ�����
	String oldCustPwd = "";     //��˧����
	String newCustPwd = "";		//�±�����
	 
	 //begin add by diling for ������Ȩ������ @2012/3/13 
    boolean pwrf = false;
	  String pubOpCode = opCode;
%>
	  <%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
    System.out.println("==������======fb063.jsp==== pwrf = " + pwrf);
    //end add by diling for ������Ȩ������ @2012/3/13 
	 
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>��˧���±�</title>
		<script type="text/javascript">
			
			var flag1 = "true";
			
			function validateNewPwd(flag){//��֤�±�����
				getNewCustInfo();
				check_HidPwd(document.f1.chief_cus_pass2.value,"show",(document.f1.newCustPwd.value).trim(),"hid",flag);
			}
			function check_HidPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type,flag){
				/*
			  		Pwd1,Pwd2:����
			  		wd1Type:����1�����ͣ�Pwd2Type������2������      show:���룻hid������
			  	
				if((Pwd1).trim().length==0)
				{
			        rdShowMessageDialog("�ͻ����벻��Ϊ�գ�",0);
			        frm1100.custPwd.focus();
					return false;
				}
			    else 
				{
				   if((Pwd2).trim().length==0)
				   {
			         rdShowMessageDialog("ԭʼ�ͻ�����Ϊ�գ���˶����ݣ�",0);
			         frm1100.custPwd.focus();
					 return false;
				   }
				}*/
				var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
				checkPwd_Packet.data.add("retType","checkPwd"); 
				checkPwd_Packet.data.add("Pwd1",Pwd1);
				checkPwd_Packet.data.add("Pwd1Type",Pwd1Type);
				checkPwd_Packet.data.add("Pwd2",(Pwd2).trim());
				checkPwd_Packet.data.add("Pwd2Type",Pwd2Type);
				checkPwd_Packet.data.add("flag",flag);
				core.ajax.sendPacket(checkPwd_Packet,doShowValidateMsg);
				checkPwd_Packet=null;		
			}
			
			function doShowValidateMsg(packet){
				var retType = packet.data.findValueByName("retType");
			    var retCode = packet.data.findValueByName("retCode"); 
			    var retMessage = packet.data.findValueByName("retMessage");
			    var flag = packet.data.findValueByName("flag"); 
			    self.status="";
				if((retCode).trim()==""){
			       rdShowMessageDialog("����"+retType+"����ʱʧ�ܣ�");
			       flag1 = "false";
			       return false;
				}
				
				if(retType == "checkPwd"){
			        //��������У��
			        var retResult = packet.data.findValueByName("retResult");
					f1.checkPwd_Flag.value = retResult; 
				    if(f1.checkPwd_Flag.value == "false"){
				    	rdShowMessageDialog("�±�������У��ʧ�ܣ����������룡",0);
				    	f1.checkPwd_Flag.value = "false";
				    	document.all.chief_cus_pass2.value = "";
				    	flag1 = "false";
				    	return false;        	
				    }else{
				    	if(flag == "1"){
				    		rdShowMessageDialog("�ͻ�����У��ɹ���",2);	
				    	}
				    	flag1 = "true";
				    	$('#subtn').removeAttr("disabled");
					}
			     }      
			}
			
			function pwdValidate(){
				if ("true" == "<%=pwrf%>") {
				 	document.all.chief_cus_pass2.disabled = true;
					document.all.cus_pass_button.disabled = true;
					document.all.validateNew.disabled = true;
					$('#subtn').removeAttr("disabled");
				} 
			}
			
			function doCfm(obj){
				flag1 = "false";
				var radios = document.getElementsByName("opFlag");
				for(var i=0;i<radios.length;i++){
					if(radios[i].checked){
						if(radios[i].value == "forward"){
							if("false" == "<%=pwrf%>"){
								validateNewPwd("2");
								if(!validateForward()){
									return ;
								}
							}else{
								flag1 = "true";
								if(document.all.newPhone.value==""){
									rdShowMessageDialog("�������±��ֻ��ţ�");
							    	return ;
								}
							}	
							if(document.all.newPhone.value == "<%=oldPhone%>"){
									rdShowMessageDialog("�±�����˧������ͬһ�����룡");
							    	return ;
							}
							document.all.opCode.value = 'b063';
							document.f1.action = "fb063_cfm.jsp";
							
						}else if (radios[i].value =="reverse"){
							document.f1.action = 'fb063_reverse.jsp';
							document.all.opCode.value = 'b064';	
							flag1 = "true";
						}else if(radios[i].value =="search"){
							return;
						}
						if(flag1 == "true"){
							printCommit();		
						}
						
					}
				}
			}
			//��ѯ��ϵ�б�
			function getRelationList(){
				var relationObj = document.getElementById("relationList");
				relationObj.innerHTML = "";
				var myPacket = new AJAXPacket("fb063_getRelation.jsp","���ڻ�ù�ϵ�б����Ժ�......");	
				var inPhone = document.all.inPhone.value;
				myPacket.data.add("opCode","b063");
				myPacket.data.add("inPhone",inPhone);
				core.ajax.sendPacket(myPacket,doShowRelationList);
				myPacket = null;
			}
			
			function doShowRelationList(packet){
				var relationListStr = packet.data.findValueByName("relationListStr");
				var relationObj = document.getElementById("relationList");
				
				relationObj.innerHTML = relationListStr;
			}
			
			function validateForward(){

				if(document.all.newPhone.value==""){
					rdShowMessageDialog("�������±��ֻ��ţ�");
		    		return false;
				}
				if(document.all.chief_cus_pass2.value==""){
					rdShowMessageDialog("�������±����룡");
		    		return false;
				}
				return true;
			}
			
			function controlButt(subButton){
				subButt2 = subButton;
			    subButt2.disabled = true;
				setTimeout("subButt2.disabled = false",3000);
			}
			
			function opchange(){
				 if(document.all.opFlag[0].checked==true){
				 	if ("true" == "<%=pwrf%>") {
				 		$('#subtn').removeAttr("disabled");
					}else{
						$('#subtn').attr("disabled","true");
					}
				  	document.all.forward_id.style.display = "";
				  	document.all.relationList.style.display = "none";
				  	document.all.opCode.value="b063";
				  	
				 }else {
				  	document.all.forward_id.style.display = "none";
				 }
				 
				 if(document.all.opFlag[1].checked==true) {
				  	document.all.relationList.style.display = "none";
				  	document.all.opCode.value="b064";
				  	$('#subtn').removeAttr("disabled");
				 }
				 
				 if(document.all.opFlag[2].checked==true){
				 	document.all.search_id.style.display = "";
				 	document.all.base_id.style.display = "none";
				 	document.all.relationList.style.display = "";
				 }else{
				 	document.all.search_id.style.display = "none";
				 	document.all.base_id.style.display = "";
				 }
				 document.all.chief_cus_pass2.value="";
			}	
			
			
			//�ύ��
			function frmCfm(){
				document.f1.submit();
			}
			
			//��ӡ����
			function printCommit(){
			 
			  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
			  if(typeof(ret)!="undefined"){
			    if((ret=="confirm")){
			      if(rdShowConfirmDialog('ȷ�ϵ��������')==1){
				    frmCfm();
			      }
				}
				if(ret=="continueSub"){
			      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
				    frmCfm();
			      }
				}
			  }
			  else{
			     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
				   frmCfm();
			     }
			  }
			  return true;
			}
			

			function showPrtDlg(printType,DlgMessage,submitCfm)
			{  //��ʾ��ӡ�Ի���
			   var h=180;
			   var w=350;
			   var t=screen.availHeight/2-h/2;
			   var l=screen.availWidth/2-w/2;
			
			  	var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
				var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
				var sysAccept =document.all.login_accept.value;            	//��ˮ��
				var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
				var mode_code=null;           							  //�ʷѴ���
				var fav_code=null;                				 		//�ط�����
				var area_code=null;             				 		  //С������
				var opCode=document.all.opCode.value ;                   			 	//��������
				var phoneNo="<%=oldPhone%>";                  //�ͻ��绰
			
			    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+
			    		"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ 
			    			"&submitCfm=" + submitCfm;
			    path+="&mode_code="+mode_code+
						"&fav_code="+fav_code+"&area_code="+area_code+
						"&opCode="+opCode+"&sysAccept="+sysAccept+
						"&phoneNo="+phoneNo+
						"&submitCfm="+submitCfm+"&pType="+
						pType+"&billType="+billType+ "&printInfo=" + printStr;
			     var ret=window.showModalDialog(path,printStr,prop);
			     return ret;
			}
			

			function printInfo(printType){
				 
			     var cust_info="";
				 var opr_info="";
				 var note_info1="";
				 var note_info2="";
				 var note_info3="";
				 var note_info4="";
			
				 var retInfo = "";
			
				cust_info+="�ֻ����룺   <%=oldPhone%>|";
				cust_info+="�ͻ�������   "+document.all.oldCustName.value+"|";
			
				opr_info+="ҵ�����ͣ�"+(document.all.opCode.value == 'b063'?'��˧���±�':'��˧���±�����')+"|";
				opr_info+="ҵ����ˮ��"+(document.all.opCode.value == 'b063'?document.all.login_accept.value:document.all.reverse_accept.value)+"|";
				
			
			  
				note_info1+="��ע����˧����Ϊ<%=oldPhone%>,�±�����Ϊ"+(document.all.newPhone.value)+"|";
			
			  	
				
				retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			    return retInfo;
			}
			
			function loadInfo(){
				 $('#subtn').attr("disabled","true");
				var flagOpCode = document.all.opCode.value;
				if(flagOpCode == "b063"){
					document.all.opFlag[0].checked = true;
				}else{
					document.all.opFlag[1].checked = true;
				}
				opchange();
				loadCustInfo();
				//getRelationList();	//���ع�ϵ�б�
				pwdValidate();
			}
			
			function loadCustInfo(){
					var myPacket = new AJAXPacket("fb063_ajaxGetCustInfo.jsp","���ڻ�ÿͻ���Ϣ�����Ժ�......");
					myPacket.data.add("inPhone","<%=oldPhone%>");
					core.ajax.sendPacket(myPacket,doShowCustInfo);
					myPacket = null;
			}
			
			function doShowCustInfo(packet){
				var oldCustPwd = packet.data.findValueByName("custPasswd");
				var oldCustName = packet.data.findValueByName("custName");
				var oldCustAddress = packet.data.findValueByName("custAddress");
				document.all.oldCustPwd.value = oldCustPwd;
				document.all.oldCustName.value = oldCustName;
				document.all.oldCustAddress.value = oldCustAddress;
			}
			
			
			function getNewCustInfo(){
				var str = document.all.newPhone.value;
				var myPacket = new AJAXPacket("fb063_ajaxGetCustInfo.jsp","���ڻ�ÿͻ���Ϣ�����Ժ�......");
				myPacket.data.add("inPhone",str);
				core.ajax.sendPacket(myPacket,doShowNewCustInfo);
				myPacket = null;
			}
			function doShowNewCustInfo(packet){
				var newCustPwd = packet.data.findValueByName("custPasswd");
				document.all.newCustPwd.value = newCustPwd;
			}
			
			
			
			
		</script>
	</head>
	<body onload="loadInfo();">

		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="01"  id="seq"/>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="01"  id="seq2"/>
		
		<form method="post" id="f1" name="f1" onKeyUp="chgFocus(f1)">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">��˧���±�</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td width="16%" class="blue">��������</td>	
					<td colspan="3">
						<input type="radio" name="opFlag" value="forward" onclick="opchange(this)" >����&nbsp;&nbsp;
						<input type="radio" name="opFlag" value="reverse" onclick="opchange(this)" >����&nbsp;&nbsp;
						<input type="radio" name="opFlag" value="search" onclick="opchange(this)" >��ѯ��ϵ�б�
					</td>
				</tr>
				<tr style="display:block" id="base_id" >
					<td width="16%" class="blue">��˧�ֻ���</td>
					<td colspan="3"><input type="text" name="oldPhone" Class="InputGrey" value="<%=oldPhone%>" readOnly></td>
				</tr>
				<tr style="display:block" id="forward_id" name="forward_id">
					<td width="16%" class="blue">�±��ֻ���</td>
					<td><input type="text" name="newPhone" v_name="�±��绰��" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0" onblur="forMobil(this);"/><font class="orange">*</font></td>
					<td width="16%" class="blue">����</td>
					<td>
						<div align="left">
							  <jsp:include page="/npage/common/pwd_one_new.jsp">
								  <jsp:param name="width1" value="16%"  />
								  <jsp:param name="width2" value="34%"  />
								  <jsp:param name="pname" value="chief_cus_pass2"  />
								  <jsp:param name="pwd" value="12345"  />
							 </jsp:include>
							 <input type="button" name="validateNew" class="b_text" value="У��" onclick="validateNewPwd('1');"/>
							 <font class="orange">*</font>
						</div>	
					</td>
				</tr>
				<tr style="display:none" id="search_id">
					<td width="16%" class="blue">�������ֻ���</td>
					<td colspan="2">
						<input type="text" name="inPhone" v_name="�绰��" v_type="phone" value="<%=oldPhone%>" Class="InputGrey" readOnly /><font class="orange">*</font>
					</td>
					<td>
						<input type="button" class="b_text" value="��ѯ" onclick="getRelationList();"/>
					</td>
				</tr>
				<tr>
					<td class="Lable"  nowrap colspan="4">&nbsp;</td>	
				</tr>
				
			</table>
			
			<div id="relationList">
				
			</div>
			
			<table cellspacing="0">
				<tr>
					<td colspan="4" id="footer"> 
			           <div align="center"> 
			              <input class="b_foot" type="button" id="subtn" name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
			              <input class="b_foot" type="button" name=back value="���" onClick="f1.reset()">
					      <input class="b_foot" type="button" name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>');">
			            </div>
			        </td>	
				</tr>
			</table>
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<input type="hidden" name="oldPhone" value="<%=oldPhone%>">
			<input type="hidden" name="login_accept" value="<%=seq%>"/><%--������ˮ--%>
			<input type="hidden" name="reverse_accept" value="<%=seq2%>"/><%--������ˮ--%>
			<input type="hidden" name="checkPwd_Flag" value="false">		<!--����У���־-->
			<input type="hidden" name="oldCustPwd" value="<%=oldCustPwd%>"/>
			<input type="hidden" name="newCustPwd" value="<%=newCustPwd%>"/>
			<input type="hidden" name="oldCustName" />
			<input type="hidden" name="oldCustAddress" />
			<input type="hidden" name="begin_time" />
			<input type="hidden" name="end_time" /> 
			<%@ include file="/npage/include/footer.jsp" %>
			<%@ include file="/npage/common/pwd_comm.jsp" %>
		</form>
	</body>
</html>

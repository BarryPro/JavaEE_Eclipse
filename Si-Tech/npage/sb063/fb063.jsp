<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 老帅带新兵
   * 版本: 2.0
   * 日期: 2010/07/26
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>
<%
	String opCode = request.getParameter("opCode");
	String opName = "老帅带新兵";

	
	String oldPhone = request.getParameter("activePhone");
	String workNo = (String)session.getAttribute("workNo");
	//查询客户密码
	String oldCustPwd = "";     //老帅密码
	String newCustPwd = "";		//新兵密码
	 
	 //begin add by diling for 对密码权限整改 @2012/3/13 
    boolean pwrf = false;
	  String pubOpCode = opCode;
%>
	  <%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
    System.out.println("==第四批======fb063.jsp==== pwrf = " + pwrf);
    //end add by diling for 对密码权限整改 @2012/3/13 
	 
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>老帅带新兵</title>
		<script type="text/javascript">
			
			var flag1 = "true";
			
			function validateNewPwd(flag){//验证新兵密码
				getNewCustInfo();
				check_HidPwd(document.f1.chief_cus_pass2.value,"show",(document.f1.newCustPwd.value).trim(),"hid",flag);
			}
			function check_HidPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type,flag){
				/*
			  		Pwd1,Pwd2:密码
			  		wd1Type:密码1的类型；Pwd2Type：密码2的类型      show:明码；hid：密码
			  	
				if((Pwd1).trim().length==0)
				{
			        rdShowMessageDialog("客户密码不能为空！",0);
			        frm1100.custPwd.focus();
					return false;
				}
			    else 
				{
				   if((Pwd2).trim().length==0)
				   {
			         rdShowMessageDialog("原始客户密码为空，请核对数据！",0);
			         frm1100.custPwd.focus();
					 return false;
				   }
				}*/
				var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","正在进行密码校验，请稍候......");
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
			       rdShowMessageDialog("调用"+retType+"服务时失败！");
			       flag1 = "false";
			       return false;
				}
				
				if(retType == "checkPwd"){
			        //进行密码校验
			        var retResult = packet.data.findValueByName("retResult");
					f1.checkPwd_Flag.value = retResult; 
				    if(f1.checkPwd_Flag.value == "false"){
				    	rdShowMessageDialog("新兵卡密码校验失败，请重新输入！",0);
				    	f1.checkPwd_Flag.value = "false";
				    	document.all.chief_cus_pass2.value = "";
				    	flag1 = "false";
				    	return false;        	
				    }else{
				    	if(flag == "1"){
				    		rdShowMessageDialog("客户密码校验成功！",2);	
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
									rdShowMessageDialog("请输入新兵手机号！");
							    	return ;
								}
							}	
							if(document.all.newPhone.value == "<%=oldPhone%>"){
									rdShowMessageDialog("新兵和老帅不能是同一个号码！");
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
			//查询关系列表
			function getRelationList(){
				var relationObj = document.getElementById("relationList");
				relationObj.innerHTML = "";
				var myPacket = new AJAXPacket("fb063_getRelation.jsp","正在获得关系列表，请稍候......");	
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
					rdShowMessageDialog("请输入新兵手机号！");
		    		return false;
				}
				if(document.all.chief_cus_pass2.value==""){
					rdShowMessageDialog("请输入新兵密码！");
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
			
			
			//提交表单
			function frmCfm(){
				document.f1.submit();
			}
			
			//打印工单
			function printCommit(){
			 
			  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
			  if(typeof(ret)!="undefined"){
			    if((ret=="confirm")){
			      if(rdShowConfirmDialog('确认电子免填单吗？')==1){
				    frmCfm();
			      }
				}
				if(ret=="continueSub"){
			      if(rdShowConfirmDialog('确认要提交信息吗？')==1){
				    frmCfm();
			      }
				}
			  }
			  else{
			     if(rdShowConfirmDialog('确认要提交信息吗？')==1){
				   frmCfm();
			     }
			  }
			  return true;
			}
			

			function showPrtDlg(printType,DlgMessage,submitCfm)
			{  //显示打印对话框
			   var h=180;
			   var w=350;
			   var t=screen.availHeight/2-h/2;
			   var l=screen.availWidth/2-w/2;
			
			  	var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
				var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
				var sysAccept =document.all.login_accept.value;            	//流水号
				var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
				var mode_code=null;           							  //资费代码
				var fav_code=null;                				 		//特服代码
				var area_code=null;             				 		  //小区代码
				var opCode=document.all.opCode.value ;                   			 	//操作代码
				var phoneNo="<%=oldPhone%>";                  //客户电话
			
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
			
				cust_info+="手机号码：   <%=oldPhone%>|";
				cust_info+="客户姓名：   "+document.all.oldCustName.value+"|";
			
				opr_info+="业务类型："+(document.all.opCode.value == 'b063'?'老帅带新兵':'老帅带新兵冲正')+"|";
				opr_info+="业务流水："+(document.all.opCode.value == 'b063'?document.all.login_accept.value:document.all.reverse_accept.value)+"|";
				
			
			  
				note_info1+="备注：老帅号码为<%=oldPhone%>,新兵号码为"+(document.all.newPhone.value)+"|";
			
			  	
				
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
				//getRelationList();	//加载关系列表
				pwdValidate();
			}
			
			function loadCustInfo(){
					var myPacket = new AJAXPacket("fb063_ajaxGetCustInfo.jsp","正在获得客户信息，请稍候......");
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
				var myPacket = new AJAXPacket("fb063_ajaxGetCustInfo.jsp","正在获得客户信息，请稍候......");
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
				<div id="title_zi">老帅带新兵</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td width="16%" class="blue">操作类型</td>	
					<td colspan="3">
						<input type="radio" name="opFlag" value="forward" onclick="opchange(this)" >申请&nbsp;&nbsp;
						<input type="radio" name="opFlag" value="reverse" onclick="opchange(this)" >冲正&nbsp;&nbsp;
						<input type="radio" name="opFlag" value="search" onclick="opchange(this)" >查询关系列表
					</td>
				</tr>
				<tr style="display:block" id="base_id" >
					<td width="16%" class="blue">老帅手机号</td>
					<td colspan="3"><input type="text" name="oldPhone" Class="InputGrey" value="<%=oldPhone%>" readOnly></td>
				</tr>
				<tr style="display:block" id="forward_id" name="forward_id">
					<td width="16%" class="blue">新兵手机号</td>
					<td><input type="text" name="newPhone" v_name="新兵电话号" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0" onblur="forMobil(this);"/><font class="orange">*</font></td>
					<td width="16%" class="blue">密码</td>
					<td>
						<div align="left">
							  <jsp:include page="/npage/common/pwd_one_new.jsp">
								  <jsp:param name="width1" value="16%"  />
								  <jsp:param name="width2" value="34%"  />
								  <jsp:param name="pname" value="chief_cus_pass2"  />
								  <jsp:param name="pwd" value="12345"  />
							 </jsp:include>
							 <input type="button" name="validateNew" class="b_text" value="校验" onclick="validateNewPwd('1');"/>
							 <font class="orange">*</font>
						</div>	
					</td>
				</tr>
				<tr style="display:none" id="search_id">
					<td width="16%" class="blue">请输入手机号</td>
					<td colspan="2">
						<input type="text" name="inPhone" v_name="电话号" v_type="phone" value="<%=oldPhone%>" Class="InputGrey" readOnly /><font class="orange">*</font>
					</td>
					<td>
						<input type="button" class="b_text" value="查询" onclick="getRelationList();"/>
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
			              <input class="b_foot" type="button" id="subtn" name="confirm" value="确认" onClick="doCfm(this)" index="2">    
			              <input class="b_foot" type="button" name=back value="清除" onClick="f1.reset()">
					      <input class="b_foot" type="button" name=qryP value="关闭" onClick="parent.removeTab('<%=opCode%>');">
			            </div>
			        </td>	
				</tr>
			</table>
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<input type="hidden" name="oldPhone" value="<%=oldPhone%>">
			<input type="hidden" name="login_accept" value="<%=seq%>"/><%--申请流水--%>
			<input type="hidden" name="reverse_accept" value="<%=seq2%>"/><%--冲正流水--%>
			<input type="hidden" name="checkPwd_Flag" value="false">		<!--密码校验标志-->
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

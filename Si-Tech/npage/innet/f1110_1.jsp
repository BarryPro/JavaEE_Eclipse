 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-11 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	
	String opCode = "1110";		
	String opName = "一卡双号对应关系";	//header.jsp需要的参数 
	String phoneTel=request.getParameter("phoneTel");	
	if(phoneTel==null){
		phoneTel=activePhone;
	}else{
		activePhone=phoneTel;
	}
	
	String workNo = (String)session.getAttribute("workNo");  	
	String regionCode=(String)session.getAttribute("regCode");  		
	String orgCode = (String)session.getAttribute("orgCode");
	String org_id = (String)session.getAttribute("orgId");
		
		
        	String rowNum = "16";
       		String sys_Date = "";		
 	
		String printAccept="";	
		printAccept = getMaxAccept();
%>


<HTML>
	<HEAD><TITLE>一卡双号关系对应</TITLE>
	<SCRIPT type=text/javascript>

	var oprType_Add = "A";
	    var oprType_Upd = "U";
	    var oprType_Del = "D";
	    var oprType_Qry = "Q";	   
		
		onload=function()
		{		
			chg_opType();
			resetJsp();
			
		}
		
		//---------1------RPC处理函数------------------
		function doProcess(packet){
			//使用RPC的时候,以下三个变量作为标准使用.
			error_code = packet.data.findValueByName("errorCode");
			error_msg =  packet.data.findValueByName("errorMsg");
			verifyType = packet.data.findValueByName("verifyType");
			backArrMsg = packet.data.findValueByName("backArrMsg");
			id_iccid = packet.data.findValueByName("id_iccid");
			id_address = packet.data.findValueByName("id_address");
			sm_name = packet.data.findValueByName("sm_name");
	
		
			self.status="";
	
			if(verifyType=="phone_no"){
				if( parseInt(error_code) == 0 ){ 
	
				  if( backArrMsg.length > 0 ){
				    phone_type = packet.data.findValueByName("phoneType");
	
				    if( phone_type == "0"){//0--主卡；1--副卡
				    
				    	document.frm1110.oldMainPhoneNo.value = document.frm1110.mainPhoneNo.value;
				    	document.frm1110.mainCustName.value = backArrMsg[0][0];
						document.frm1110.mainSimNo.value = backArrMsg[0][1];
						document.frm1110.mainImsiNo.value = backArrMsg[0][2];
						document.frm1110.mainidIccid.value = id_iccid;
						document.frm1110.mainidAddress.value = id_address;
						document.frm1110.mainsmName.value = sm_name;
								    
				    }else{
				    	document.frm1110.oldAppendPhoneNo.value = document.frm1110.appendPhoneNo.value;
						document.frm1110.appendCustName.value = backArrMsg[0][0];
						document.frm1110.appendSimNo.value = backArrMsg[0][1];
						document.frm1110.appendImsiNo.value = backArrMsg[0][2];			    
						document.frm1110.appendidIccid.value = id_iccid;
						document.frm1110.appendidAddress.value = id_address;
						document.frm1110.appendsmName.value = sm_name;
					}
	
	
								
					document.frm1110.print.disabled = false;
				  }
	
				}else{
					rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]",0);
					document.frm1110.print.disabled = true;
					return false;
				}
			
			}
							
		}


	//---------------------------------------
	function chg_opType()
	{
	var op_type = document.frm1110.opType[document.frm1110.opType.selectedIndex].value;
	if( op_type == oprType_Add ){
		document.frm1110.appendInfoQuery.style.display="";
		document.frm1110.appendPhoneNo.readOnly = false;
	}else{
		document.frm1110.appendInfoQuery.style.display="none";
		document.frm1110.appendPhoneNo.readOnly = true;
	}
	if( op_type == oprType_Add){
		document.frm1110.opName.value = "增加";
	}else if(op_type == oprType_Upd){
		document.frm1110.opName.value = "修改";
	}else if(op_type == oprType_Del){
		document.frm1110.opName.value = "删除";
	}else{
		document.frm1110.opName.value = "查询";
	}
		resetJsp();
		document.frm1110.print.disabled = true;
	}

	//-----------------------------
	function infoQry(type)
	{
	var op_type = document.frm1110.opType[document.frm1110.opType.selectedIndex].value;
	
	
			/*
	       iOpType     操作类型：增加、删除、查询
	       iPhoneType  号码类型：0--主卡；1--副卡
	       iPhoneNo    手机号码
	       iLoginNo    操作工号
	       iOrgCode    工号机构编码
	       iOpCode     操作代码
	       */
	if( op_type == oprType_Add ){
				
				if( type == 0 ){
					if(!checkElement(document.frm1110.mainPhoneNo)) return false;
	
					document.frm1110.mainCustName.value = "";
					document.frm1110.mainSimNo.value = "";
					document.frm1110.mainImsiNo.value = "";
					
				}else{
					if(!checkElement(document.frm1110.appendPhoneNo)) return false;
					
	
					document.frm1110.appendCustName.value = "";
					document.frm1110.appendSimNo.value = "";
					document.frm1110.appendImsiNo.value = "";				
				}
				var myPacket = new AJAXPacket("f1110_rpc_phone.jsp","正在服务号码，请稍候......");			
				myPacket.data.add("verifyType","phone_no");
				
				myPacket.data.add("opType",document.frm1110.opType.value);
				if( type == 0 ){ //主服务号码
					myPacket.data.add("phoneType","0");//0--主卡；1--副卡
					myPacket.data.add("phoneNo",document.frm1110.mainPhoneNo.value);
				}else{ //副服务号码
					myPacket.data.add("phoneType","1");//0--主卡；1--副卡
					myPacket.data.add("phoneNo",document.frm1110.appendPhoneNo.value);
				}
				
				
				myPacket.data.add("workNo","<%=workNo%>");
				myPacket.data.add("orgCode",document.frm1110.orgCode.value);
				myPacket.data.add("opCode","1110");
					
				core.ajax.sendPacket(myPacket);
				myPacket=null;
		
		return false;
	}
	
	    if(checkElement(document.frm1110.mainPhoneNo))
		{
			frm1110.action="f1110_2.jsp";
			frm1110.submit();
		}
	}

	function commitJsp()
	{
		getAfterPrompt();
	var op_type = document.frm1110.opType[document.frm1110.opType.selectedIndex].value;
	
		if(!checkElement(document.frm1110.mainPhoneNo)) return false;
	
		if(!checkElement(document.frm1110.appendPhoneNo)) return false;
	
		if( document.frm1110.mainPhoneNo.value == document.frm1110.appendPhoneNo.value ){
	 	  	rdShowMessageDialog("主服务号码和副服务号码不能相同,请修改！");
	 	  	document.frm1110.appendPhoneNo.focus();
	 	  	document.frm1110.appendPhoneNo.select();
	 	  	return false;		
		}
		if( document.frm1110.mainSimNo.value == "" ){
			rdShowMessageDialog("主SIM卡号必须有数据,请重新查询！");
	 	  	document.frm1110.mainPhoneNo.focus();
	 	  	document.frm1110.mainPhoneNo.select();		
			return false;
		}
		if( document.frm1110.appendSimNo.value == "" ){
			rdShowMessageDialog("副SIM卡号必须有数据,请重新查询！");
	 	  	document.frm1110.appendPhoneNo.focus();
	 	  	document.frm1110.appendPhoneNo.select();		
			return false;	
		}	
	
		if( document.frm1110.mainPhoneNo.value != document.frm1110.oldMainPhoneNo.value  ){
			rdShowMessageDialog("主服务号码有变化,请重新查询！");
			return false;
		}
		if( document.frm1110.appendPhoneNo.value != document.frm1110.oldAppendPhoneNo.value  ){
			rdShowMessageDialog("副服务号码有变化,请重新查询！");
			return false;
		}
			
		var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	
	     if((ret=="confirm"))
	      {
	        if(rdShowConfirmDialog('确认电子免填单吗？')==1)
	        {  
				if( op_type == oprType_Add ){
					document.frm1110.bakOpType.value = document.frm1110.opType.value;
					frm1110.action="f1110_3.jsp";
					frm1110.submit();		
				}else{
					frm1110.action="f1110_2.jsp";
					frm1110.submit();
				}
	
		    }
			if(ret=="remark")
		    {
	         if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	         {
				if( op_type == oprType_Add ){
					document.frm1110.bakOpType.value = document.frm1110.opType.value;
					frm1110.action="f1110_3.jsp";
					frm1110.submit();		
				}else{
					frm1110.action="f1110_2.jsp";
					frm1110.submit();
				}
		     }
		   }
	     }
		
	    else
	    {
	       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	 	{
				if( op_type == oprType_Add ){
					document.frm1110.bakOpType.value = document.frm1110.opType.value;
					frm1110.action="f1110_3.jsp";
					frm1110.submit();		
				}else{
					frm1110.action="f1110_2.jsp";
					frm1110.submit();
				}
			}
	 
				
		}
	}

	function showPrtDlg(printType,DlgMessage,submitCfm)
	{  
			//显示打印对话框 		
			var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
		     	var billType="1";                      //  票价类型1电子免填单、2发票、3收据
			var sysAccept ="<%=printAccept%>";                       // 流水号
			var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
			var mode_code=null;                        //资费代码
			var fav_code=null;                         //特服代码
			var area_code=null;                    //小区代码
			var opCode =   "<%=opCode%>";                         //操作代码
			var phoneNo = <%=activePhone%>;                           //客户电话		
		   	var h=180;
		   	var w=350;
		   	var t=screen.availHeight/2-h/2;
		   	var l=screen.availWidth/2-w/2;
		   	
		   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
			var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);    
	}


	function printInfo(printType)
	{
	   
	 		var cust_info=""; //客户信息
		      	var opr_info=""; //操作信息
		      	var retInfo = "";  //打印内容
		      	var note_info1=""; //备注1
		      	var note_info2=""; //备注2
		      	var note_info3=""; //备注3
		      	var note_info4=""; //备注4 	    
		      	
		      	cust_info+="客户姓名：   "+document.frm1110.mainCustName.value+"|";
			cust_info+="手机号码：   "+document.frm1110.mainPhoneNo.value+"|";
			cust_info+="客户地址：   "+document.frm1110.mainidAddress.value+"|";
			cust_info+="证件号码：   "+document.frm1110.mainidIccid.value+"|";
			
			opr_info+="用户品牌："+document.frm1110.mainsmName.value+"|";
			opr_info+="办理业务：一卡双号  "+document.frm1110.opName.value+"*"+"操作流水："+"<%=printAccept%>"+"|"; 
			opr_info+="主卡号码："+document.frm1110.mainPhoneNo.value+"*"+"主卡SIM卡号："+document.frm1110.mainSimNo.value+"|";
	    		opr_info+="副卡号码："+document.frm1110.appendPhoneNo.value+"*"+"副卡SIM卡号："+document.frm1110.appendSimNo.value+"|";
	 	
			retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
	    	      	return retInfo;	
	
	}
	function resetJsp(){
		
		//document.frm1110.mainPhoneNo.value ="";
		document.frm1110.mainCustName.value = "";
		document.frm1110.mainSimNo.value = "";
		document.frm1110.mainImsiNo.value = "";
		document.frm1110.appendPhoneNo.value = "";
		document.frm1110.appendCustName.value = "";
		document.frm1110.appendSimNo.value = "";
		document.frm1110.appendImsiNo.value = "";
	}

	//========================================
	</SCRIPT>
	</HEAD>
<body>
<FORM method=post name="frm1110" action="f1110_2.jsp"  onKeyUp="chgFocus(frm1110)">
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">客户信息</div>
		</div>
              <table cellspacing="0">
                <TBODY>
                  <TR> 
                    <TD width=16% class="blue"> 操作类型</TD>
                    <TD width="34%" >
                     <select align="left" name=opType width=50 index="0" onChange="chg_opType()">
                        <option  value="A">增加</option>
                        <option  value="D">删除</option>
                        <option  value="Q">查询</option>
                      </select> 
                      </TD>
                    <TD width=16% >&nbsp;</TD>
                    <TD width="34%" >  
                    	&nbsp;
                    </TD>
                  </TR>
                  <TR> 
                    <TD  class="blue">主服务号码</TD>
                    <TD>
                    	<input  value="<%=activePhone%>" readonly class="InputGrey" name=mainPhoneNo onkeyup="if(event.keyCode==13)infoQry(0);" index="1" v_must=1 v_maxlength=11 maxlength=11 v_type=mobphone / >
                    	<font class="orange">*</font>                      
                      <input name=infoQuery type=button class="b_text" onclick="infoQry(0)" style="cursor:hand" value=查询>
                    </TD>
                    <TD  class="blue">主客户名称</TD>
                    <TD>
                    	<input  name=mainCustName size=35 readonly class="InputGrey"> 
                    </TD>
                  </TR>
                  <TR> 
                    <TD  class="blue"> 主SIM卡号</TD>
                    <TD> 
                    	<input  name=mainSimNo readonly class="InputGrey"> 
                    </TD>
                    <TD  class="blue"> 主IMSI号</TD>
                    <TD> 
                    	<input  name=mainImsiNo readonly class="InputGrey"> 
                    </TD>
                  </TR>
                  <TR> 
                    <TD  class="blue"> 副服务号码</TD>
                    <TD> 
                    	<input  name=appendPhoneNo onkeyup="if(event.keyCode==13)infoQry(1);"  v_must=1 v_maxlength=11 maxlength=11 v_type=mobphone > 
                    	<font class="orange">*</font>
                      	<input name=appendInfoQuery type=button class="b_text" id="appendInfoQuery" style="cursor:hand" onclick="infoQry(1)" value=查询> 
                    </TD>
                    <TD  class="blue"> 副客户名称</TD>
                    <TD> 
                    	<input  name=appendCustName size=35 readonly class="InputGrey"> 
                    </TD>
                  </TR>
                  <TR> 
                    <TD  class="blue"> 副SIM卡号</TD>
                    <TD> 
                    	<input  name=appendSimNo readonly class="InputGrey">
                    </TD>
                    <TD  class="blue"> 副IMSI号</TD>
                    <TD> 
                    	<input  name=appendImsiNo readonly class="InputGrey"> 
                    </TD>
                  </TR>
                </TBODY>
              </TABLE> 
              <br>   	  	
		<div class="title">
			<div id="title_zi">操作信息</div>
		</div>
        <TABLE cellSpacing="0">
          <TBODY> 
          	<TR align="center">
	          		<TH>主SIM卡</TH>
	          		<TH>主号码</TH>
	          		<TH>副号码</TH>
	          		<TH>操作工号</TH>
	          		<TH>操作流水</TH>
	          		<TH>操作时间</TH>
	          		<TH>操作模块</TH>
	          		<TH>操作类型</TH>
          	</TR>  
          </TBODY>
        </TABLE>          
        <TABLE  cellSpacing=0>
                <TBODY> 
                <TR> 
                  <TD width=16% class="blue"> 
                    系统备注
                  </TD>
                  <TD> 
                    <input  name=sysNote size=60 readonly maxlength="60" class="InputGrey">
                  </TD>
                </TR>                      
                </TBODY> 
        </TABLE>        
                                           
         <TABLE  cellSpacing=0>
          <TBODY>
            <TR> 
              <TD id="footer">
                <input  name=print class="b_foot" type=button value=确认 onmouseup="commitJsp();" onkeyup="if(event.keyCode==13) commitJsp()" disabled index="3">
              	<input  name=reset  class="b_foot" type=reset value=清除 onclick="frm1110.action='f1110_1.jsp?phoneTel=<%=phoneTel%>';frm1110.submit();" index="4">
              	<input  name=back  class="b_foot" onClick="removeCurrentTab()" type=button value=关闭 index="5">
             </TD>
            </TR>
          </TBODY>
        </TABLE>
  	<!------------------------> 
  	<! 备注信息 add by anln------------------------> 
  	<input type="hidden" name=opNote  size=60 maxlength="60" index="2">
	<input type="hidden" name="orgCode" value="<%=orgCode%>">  				<!--机构编码--> 
	<input type="hidden" name="loginNo" value="<%=workNo%>">  	
	<input type="hidden" name="phoneTel" value="<%=phoneTel%>">  	
				
	<input type="hidden" name="bakOpType" value="">   
	
	<input type="hidden" name="oldMainPhoneNo" value="">
	<input type="hidden" name="oldAppendPhoneNo" value="">  
	<input type="hidden" name="org_id" value="<%=org_id%>">
	
	<input type="hidden" name="mainidIccid" value="">
	<input type="hidden" name="mainidAddress" value="">
	<input type="hidden" name="mainsmName" value="">
	<input type="hidden" name="appendidIccid" value="">
	<input type="hidden" name="appendidAddress" value="">
	<input type="hidden" name="appendsmName" value=""> 
	<input type="hidden" name="opName" value="">
	<input type="hidden" name="login_accept" value="<%=printAccept%>">
	 <%@ include file="/npage/include/footer.jsp" %>  
	
</form>
</body>
</html>



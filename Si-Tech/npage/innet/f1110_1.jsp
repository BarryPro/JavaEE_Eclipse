 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-11 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	
	String opCode = "1110";		
	String opName = "һ��˫�Ŷ�Ӧ��ϵ";	//header.jsp��Ҫ�Ĳ��� 
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
	<HEAD><TITLE>һ��˫�Ź�ϵ��Ӧ</TITLE>
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
		
		//---------1------RPC������------------------
		function doProcess(packet){
			//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
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
	
				    if( phone_type == "0"){//0--������1--����
				    
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
					rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]",0);
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
		document.frm1110.opName.value = "����";
	}else if(op_type == oprType_Upd){
		document.frm1110.opName.value = "�޸�";
	}else if(op_type == oprType_Del){
		document.frm1110.opName.value = "ɾ��";
	}else{
		document.frm1110.opName.value = "��ѯ";
	}
		resetJsp();
		document.frm1110.print.disabled = true;
	}

	//-----------------------------
	function infoQry(type)
	{
	var op_type = document.frm1110.opType[document.frm1110.opType.selectedIndex].value;
	
	
			/*
	       iOpType     �������ͣ����ӡ�ɾ������ѯ
	       iPhoneType  �������ͣ�0--������1--����
	       iPhoneNo    �ֻ�����
	       iLoginNo    ��������
	       iOrgCode    ���Ż�������
	       iOpCode     ��������
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
				var myPacket = new AJAXPacket("f1110_rpc_phone.jsp","���ڷ�����룬���Ժ�......");			
				myPacket.data.add("verifyType","phone_no");
				
				myPacket.data.add("opType",document.frm1110.opType.value);
				if( type == 0 ){ //���������
					myPacket.data.add("phoneType","0");//0--������1--����
					myPacket.data.add("phoneNo",document.frm1110.mainPhoneNo.value);
				}else{ //���������
					myPacket.data.add("phoneType","1");//0--������1--����
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
	 	  	rdShowMessageDialog("���������͸�������벻����ͬ,���޸ģ�");
	 	  	document.frm1110.appendPhoneNo.focus();
	 	  	document.frm1110.appendPhoneNo.select();
	 	  	return false;		
		}
		if( document.frm1110.mainSimNo.value == "" ){
			rdShowMessageDialog("��SIM���ű���������,�����²�ѯ��");
	 	  	document.frm1110.mainPhoneNo.focus();
	 	  	document.frm1110.mainPhoneNo.select();		
			return false;
		}
		if( document.frm1110.appendSimNo.value == "" ){
			rdShowMessageDialog("��SIM���ű���������,�����²�ѯ��");
	 	  	document.frm1110.appendPhoneNo.focus();
	 	  	document.frm1110.appendPhoneNo.select();		
			return false;	
		}	
	
		if( document.frm1110.mainPhoneNo.value != document.frm1110.oldMainPhoneNo.value  ){
			rdShowMessageDialog("����������б仯,�����²�ѯ��");
			return false;
		}
		if( document.frm1110.appendPhoneNo.value != document.frm1110.oldAppendPhoneNo.value  ){
			rdShowMessageDialog("����������б仯,�����²�ѯ��");
			return false;
		}
			
		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
	
	     if((ret=="confirm"))
	      {
	        if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
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
	         if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
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
	       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
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
			//��ʾ��ӡ�Ի��� 		
			var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
		     	var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
			var sysAccept ="<%=printAccept%>";                       // ��ˮ��
			var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
			var mode_code=null;                        //�ʷѴ���
			var fav_code=null;                         //�ط�����
			var area_code=null;                    //С������
			var opCode =   "<%=opCode%>";                         //��������
			var phoneNo = <%=activePhone%>;                           //�ͻ��绰		
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
	   
	 		var cust_info=""; //�ͻ���Ϣ
		      	var opr_info=""; //������Ϣ
		      	var retInfo = "";  //��ӡ����
		      	var note_info1=""; //��ע1
		      	var note_info2=""; //��ע2
		      	var note_info3=""; //��ע3
		      	var note_info4=""; //��ע4 	    
		      	
		      	cust_info+="�ͻ�������   "+document.frm1110.mainCustName.value+"|";
			cust_info+="�ֻ����룺   "+document.frm1110.mainPhoneNo.value+"|";
			cust_info+="�ͻ���ַ��   "+document.frm1110.mainidAddress.value+"|";
			cust_info+="֤�����룺   "+document.frm1110.mainidIccid.value+"|";
			
			opr_info+="�û�Ʒ�ƣ�"+document.frm1110.mainsmName.value+"|";
			opr_info+="����ҵ��һ��˫��  "+document.frm1110.opName.value+"*"+"������ˮ��"+"<%=printAccept%>"+"|"; 
			opr_info+="�������룺"+document.frm1110.mainPhoneNo.value+"*"+"����SIM���ţ�"+document.frm1110.mainSimNo.value+"|";
	    		opr_info+="�������룺"+document.frm1110.appendPhoneNo.value+"*"+"����SIM���ţ�"+document.frm1110.appendSimNo.value+"|";
	 	
			retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
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
			<div id="title_zi">�ͻ���Ϣ</div>
		</div>
              <table cellspacing="0">
                <TBODY>
                  <TR> 
                    <TD width=16% class="blue"> ��������</TD>
                    <TD width="34%" >
                     <select align="left" name=opType width=50 index="0" onChange="chg_opType()">
                        <option  value="A">����</option>
                        <option  value="D">ɾ��</option>
                        <option  value="Q">��ѯ</option>
                      </select> 
                      </TD>
                    <TD width=16% >&nbsp;</TD>
                    <TD width="34%" >  
                    	&nbsp;
                    </TD>
                  </TR>
                  <TR> 
                    <TD  class="blue">���������</TD>
                    <TD>
                    	<input  value="<%=activePhone%>" readonly class="InputGrey" name=mainPhoneNo onkeyup="if(event.keyCode==13)infoQry(0);" index="1" v_must=1 v_maxlength=11 maxlength=11 v_type=mobphone / >
                    	<font class="orange">*</font>                      
                      <input name=infoQuery type=button class="b_text" onclick="infoQry(0)" style="cursor:hand" value=��ѯ>
                    </TD>
                    <TD  class="blue">���ͻ�����</TD>
                    <TD>
                    	<input  name=mainCustName size=35 readonly class="InputGrey"> 
                    </TD>
                  </TR>
                  <TR> 
                    <TD  class="blue"> ��SIM����</TD>
                    <TD> 
                    	<input  name=mainSimNo readonly class="InputGrey"> 
                    </TD>
                    <TD  class="blue"> ��IMSI��</TD>
                    <TD> 
                    	<input  name=mainImsiNo readonly class="InputGrey"> 
                    </TD>
                  </TR>
                  <TR> 
                    <TD  class="blue"> ���������</TD>
                    <TD> 
                    	<input  name=appendPhoneNo onkeyup="if(event.keyCode==13)infoQry(1);"  v_must=1 v_maxlength=11 maxlength=11 v_type=mobphone > 
                    	<font class="orange">*</font>
                      	<input name=appendInfoQuery type=button class="b_text" id="appendInfoQuery" style="cursor:hand" onclick="infoQry(1)" value=��ѯ> 
                    </TD>
                    <TD  class="blue"> ���ͻ�����</TD>
                    <TD> 
                    	<input  name=appendCustName size=35 readonly class="InputGrey"> 
                    </TD>
                  </TR>
                  <TR> 
                    <TD  class="blue"> ��SIM����</TD>
                    <TD> 
                    	<input  name=appendSimNo readonly class="InputGrey">
                    </TD>
                    <TD  class="blue"> ��IMSI��</TD>
                    <TD> 
                    	<input  name=appendImsiNo readonly class="InputGrey"> 
                    </TD>
                  </TR>
                </TBODY>
              </TABLE> 
              <br>   	  	
		<div class="title">
			<div id="title_zi">������Ϣ</div>
		</div>
        <TABLE cellSpacing="0">
          <TBODY> 
          	<TR align="center">
	          		<TH>��SIM��</TH>
	          		<TH>������</TH>
	          		<TH>������</TH>
	          		<TH>��������</TH>
	          		<TH>������ˮ</TH>
	          		<TH>����ʱ��</TH>
	          		<TH>����ģ��</TH>
	          		<TH>��������</TH>
          	</TR>  
          </TBODY>
        </TABLE>          
        <TABLE  cellSpacing=0>
                <TBODY> 
                <TR> 
                  <TD width=16% class="blue"> 
                    ϵͳ��ע
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
                <input  name=print class="b_foot" type=button value=ȷ�� onmouseup="commitJsp();" onkeyup="if(event.keyCode==13) commitJsp()" disabled index="3">
              	<input  name=reset  class="b_foot" type=reset value=��� onclick="frm1110.action='f1110_1.jsp?phoneTel=<%=phoneTel%>';frm1110.submit();" index="4">
              	<input  name=back  class="b_foot" onClick="removeCurrentTab()" type=button value=�ر� index="5">
             </TD>
            </TR>
          </TBODY>
        </TABLE>
  	<!------------------------> 
  	<! ��ע��Ϣ add by anln------------------------> 
  	<input type="hidden" name=opNote  size=60 maxlength="60" index="2">
	<input type="hidden" name="orgCode" value="<%=orgCode%>">  				<!--��������--> 
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



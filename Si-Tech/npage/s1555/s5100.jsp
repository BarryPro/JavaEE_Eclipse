 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-16 ҳ�����,�޸���ʽ
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<html>

<head>
	<title>���긶��</title>
<%
   
	 String opCode = "5100";	
	 String opName = "���긶��";	//header.jsp��Ҫ�Ĳ���   
	 String regionCode = (String)session.getAttribute("regCode");
	 String loginName =(String)session.getAttribute("workName");//��������                   
   	 String[][]  temfavStr = (String[][])session.getAttribute("favInfo");	//�Ż�Ȩ����Ϣ
   	 String[] favStr=new String[temfavStr.length];
	 for(int i=0;i<favStr.length;i++)
		favStr[i]=temfavStr[i][0].trim();
	 boolean pwrf=false;
	 if(WtcUtil.haveStr(favStr,"a272"))
		pwrf=true;
   	String printAccept="";
   	printAccept = getMaxAccept();  
%>
	<script language=javascript>
 
	//----------------��֤���ύ����-----------------
	 function verifyCust(){
	  
	    if (document.frm.srv_no.value.length == 0) {
	      rdShowMessageDialog("�ֻ����벻��Ϊ�գ����������� !!",0);
	      document.frm.srv_no.focus();
	      return false;
	     } 
		
 
		var myPacket = new AJAXPacket("custmsg.jsp","���ڲ�ѯ�ͻ���Ϣ�����Ժ�......");
		myPacket.data.add("phoneNo",document.frm.srv_no.value.trim());
		myPacket.data.add("type","0");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
		//delete(myPacket);  
	    
		
	 }	 
	function doProcess(packet)
	{
	    var retCode = packet.data.findValueByName("retCode");
	    var retMsg = packet.data.findValueByName("retMsg");
		var retResult = packet.data.findValueByName("retResult");
	    var type = packet.data.findValueByName("type");
	    var custName = packet.data.findValueByName("cust_name");
		var iccid = packet.data.findValueByName("id_iccid");
		var custAddress = packet.data.findValueByName("id_address");	    
	    if (type == "0"){
			if(custName!=""){
				document.frm.cust_name.value = custName;
				document.frm.iccid.value = iccid;
				document.frm.custAddress.value = custAddress;
			}else{
				rdShowMessageDialog("�޴˺��룡",0);
				document.frm.srv_no.focus();
				return false;
			}
			if(retResult!="0")
			{
				rdShowMessageDialog("�˺��������Ʒ��",0);
			}
	
		}else{
			if(retResult == "000000"){
				rdShowMessageDialog("��������׼ȷ��",2);
				document.frm.confirm.disabled = false;
				document.frm.infor.disabled= false;
				return true; 
			 }else{
				rdShowMessageDialog("��������������������룡",0);
				document.frm.confirm.disabled = true;
				return false;
			 
			 }
		}
			
	}	
	function printCommit()
	{          
		getAfterPrompt();
		if (document.frm.srv_no.value.length == 0) {
	      rdShowMessageDialog("�ֻ����벻��Ϊ�գ����������� !!",0);
	      document.frm.srv_no.focus();
	      return false;
	     } 
		
		if(document.frm.cust_name.value!="")
	  {
		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
	
	     if((ret=="confirm"))
	      {
	        if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
	        {  
		      frm.submit();
	        }
	
	
		    if(ret=="remark")
		    {
	         if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
	         {
		       frm.submit();
	         }
		   }
		}
	    else
	    {
	       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
	       {
		     frm.submit();
	       }
	    }
	  }
	
	    return true;  	 
	}

	function showPrtDlg(printType,DlgMessage,submitCfm)
	{ 
	 	var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     		var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
		var sysAccept ="<%=printAccept%>";                       // ��ˮ��
		var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
		var mode_code=null;                        //�ʷѴ���
		var fav_code=null;                         //�ط�����
		var area_code=null;                    //С������
		var opCode =   "<%=opCode%>";                         //��������
		var phoneNo = <%=activePhone%>;                           //�ͻ��绰	
		
		 //��ʾ��ӡ�Ի��� 
		var h=180;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
	
	   	var printStr = printInfo(printType);	   	
	    	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	    
	      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
	}


	function printInfo(printType)
	{
	   
	  if(document.frm.op_note.value==""){ 				
	  	document.frm.op_note.value="<%=loginName%>"+"���û�"+document.frm.cust_name.value+"���и�������Ʒ����Ϊ"+document.frm.award_type.value;
	  }
	  
	      var cust_info=""; //�ͻ���Ϣ
	      var opr_info=""; //������Ϣ
	      var retInfo = "";  //��ӡ����
	      var note_info1=""; //��ע1
	      var note_info2=""; //��ע2
	      var note_info3=""; //��ע3
	      var note_info4=""; //��ע4
	      
	      cust_info+="�ֻ����룺"+document.frm.srv_no.value+"|";	    
	      cust_info+="�ͻ�������"+document.frm.cust_name.value+"|";	    
	      cust_info+="֤�����룺"+document.frm.iccid.value+"|";	   
	      cust_info+="�ͻ���ַ��"+document.frm.custAddress.value+"|";
	      
	      opr_info+="ҵ�����ͣ�"+"���긶��"+"|";
	      opr_info+="������ˮ��"+"<%=printAccept%>"+"|";	
	      note_info1+="��ע:"+document.frm.op_note.value+"|";
	      
	      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	      retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
    	      return retInfo;	
	}	
	</script>
</head>
<body>
	<form name="frm" method="POST" action="s5100Cfm.jsp" >			
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">���긶��</div>
			</div>   
			<input type="hidden" name="iccid" value="">
			<input type="hidden" name="custAddress" value="">
			<table  cellspacing="0">   
				<TBODY>  
			            <tr> 
				           	<td  nowrap class="blue"> �ֻ�����</td>
					        <td nowrap  class="blue colspan="5">            
					                <input  type="text"  name="srv_no"size="12" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  v_name="�������" maxlength="11" index="0" value =<%=activePhone%>  readonly class="InputGrey" >    
					                <font class="orange">*</font>           
													<input class="b_text" type="button" name="infor" value="��ѯ" onClick="verifyCust()">				
					        </td>		 
					        <td colspan="2">&nbsp;</td>			          
			            </tr>
			          <tr>
			          		<td nowrap  class="blue"> 
			              		�û�����
			            	</td>
			            	<TD>
						<input type="text" class="InputGrey" name="cust_name"  maxlength="8" readOnly /> 		    
										</TD>
										<td  nowrap  class="blue">��������</td>
			             	<td class=Input nowrap  >
						              <select name="award_type" index="15" >
							                <option value="�������" selected >�������</option>
							                <option value="����1">����1</option>
							                <option value="����2">����2</option>
							                <option value="����3">����3</option>
															<option value="���еش������˶�ˮ��">���еش������˶�ˮ��</option>
							                <option value="���еش���˶�ˮ��">���еش���˶�ˮ��</option>
						              </select>
			            	</td>			
			         </tr>
				<tr>
					<td  class="blue" nowrap> ��ע��Ϣ</td>
					<td colspan="3"> 
						<INPUT class="InputGrey" TYPE=text NAME="op_note" size="60" readOnly />
					</td>			
				</tr>
			</TBODY>
      	</table>
    	<table cellspacing="0">
    		<TBODY>
				<tr> 
					<td id="footer"> 				
					    	<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="printCommit()" index="2">
					    	&nbsp;
					    	<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
					    	&nbsp; 
					    	<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">		               
					</td>
				</tr>
		</TBODY>
  	</table>
  	<input type="hidden" value="<%=printAccept%>" name="printAccept"/>
  	<%@ include file="/npage/include/footer.jsp" %>	 
   </form>
</body>
</html>
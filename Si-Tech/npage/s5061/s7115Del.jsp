 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-10 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%  
	   String ph_no = (String)request.getParameter("ph_no");
	
	  HashMap hm=new HashMap();
	  hm.put("1","û�пͻ�ID��");
	  hm.put("3","�������");
	  hm.put("4","�����Ѳ�ȷ���������ܽ����κβ�����");
	  
	  hm.put("2","δȡ������1����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("10","δȡ������2����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("11","δȡ������3����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("12","δȡ������4����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("13","δȡ������5����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("14","δȡ������6����˲����ݻ���ѯϵͳ����Ա��");
	  String op_name="";
	  String op_code = request.getParameter("op_code");
	  //System.out.println("op_code === "+ op_code );
	  //op_code="1250";
	 
	  if(op_code.equals("1220"))
	    op_name="�������";
	  else if(op_code.equals("1217"))
	    op_name="Ԥ���ָ�";
	  else if(op_code.equals("1260"))
	    op_name="Ԥ��ָ�";
	  else if(op_code.equals("2419"))
	    op_name="����ת��ҵ������";
	  else if(op_code.equals("1296"))
	    op_name="���еش�����ת��";
	  else if(op_code.equals("1250"))
	    op_name="���ֶҽ�";
	  else if(op_code.equals("1221"))
	    op_name="��������";
	  else if(op_code.equals("1353"))
	    op_name="��������";
	  else if(op_code.equals("1290"))
	    op_name="���֤��ʧ";
	  else if(op_code.equals("1291"))
	    op_name="�ֻ�֤ȯ����";
	  else if(op_code.equals("1295"))
	    op_name="������";
	  else if(op_code.equals("1299"))
	    op_name="���еش�Mֵ�һ�";
	  else if(op_code.equals("2420"))
	    op_name="����ת��ҵ�����";
	  else if(op_code.equals("2421"))
	    op_name="�ĺ�֪ͨҵ��";
	  else if(op_code.equals("1442"))
	    op_name="SIM��Ӫ��";
	  else if(op_code.equals("1445"))
	    op_name="ȫ��ͨǩԼ�ƻ�";
	  else if(op_code.equals("1448"))
	    op_name="�ʼ��ʵ�";
	  else if(op_code.equals("7114"))
	    op_name="�굥��ѯ��������";
	  else if(op_code.equals("1458"))
	    op_name="��Ϣ�ռ�";
	  else if(op_code.equals("1469"))
	    op_name="ȫ��spҵ���˷�";
	  else if(op_code.equals("7115"))
	    op_name="����绰��ѻ���";
	  else if(op_code.equals("2299"))
	    op_name="�������֤����������";
	  else if(op_code.equals("1499"))
	    op_name="����ҵ�񸶽�����ά��";
	  else if(op_code.equals("1451"))
	    op_name="�����ʵ�����";
	  else if(op_code.equals("1452"))
	    op_name="�������֤";
	  else if(op_code.equals("5036"))
	    op_name="�ͷ�ϵͳ�ײ�����";
	  else if(op_code.equals("5037"))
	    op_name="������ò�ѯ";
	  else if(op_code.equals("1577"))
	    op_name="���ź˼컰����ѯ";
	  else if(op_code.equals("1446"))
	    op_name="�ĺ�֪ͨ";
	  else if(op_code.equals("1440"))
	    op_name="��ҵ��ҽ�";
	  else if(op_code.equals("5118"))
	    op_name="����ҵ�񸶽�";
	  else if(op_code.equals("1449"))
	    op_name="ȫ��ͨǩԼ�ƻ�����";
	  else if(op_code.equals("1450"))
	    op_name="���ֶһ�����";
	  else if(op_code.equals("1443"))
	    op_name="�ļ�����";
	  else if(op_code.equals("2267"))
	    op_name="�ֻ��û�ʵ��Ԥ�Ǽǲ�ѯ/ȷ��";
	  else if(op_code.equals("2266"))
	    op_name="����Ʒͳһ����";
	  else if(op_code.equals("2849"))
	    op_name="�������ż��ŷ��������Ϣ��ѯ";
	  else if(op_code.equals("5303"))
	    op_name="���ŵ�½������������";
	  else if(op_code.equals("5309"))
	    op_name="���ŵ�½��������������ʷ��ѯ";
%>
<%

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	String loginName = (String)session.getAttribute("workName");
	
	String opCode = "7115";		
	String opName = "����绰��ѻ�������";	//header.jsp��Ҫ�Ĳ���     
	String regionCode= (String)session.getAttribute("regCode");  
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" /> 
<html>

<head>
	<title><%=op_name%></title>

	<script language="JavaScript">
		<!--
		  onload=function()
		  {
		  	document.all.phoneno.focus();		   	
		    	self.status="";
		  }
		 
		  //ɾ����ѯ���
		  function deleteSimChk(){		  	
		  	if(document.all.phoneno.value.trim().length<1){
		    	rdShowMessageDialog("�ֻ����벻��Ϊ�գ�");
		 	  	return;
			} 
		   	var myPacket = new AJAXPacket("7115DelQry.jsp","���ڲ�ѯ�ͻ������Ժ�......");
		   	
				myPacket.data.add("phoneNo",document.all.phoneno.value.trim());
				core.ajax.sendPacket(myPacket);
				myPacket=null;
		  }
		
		
		
		 //--------4---------doProcess����----------------
		function doProcess(packet)
		{
		  var vRetPage=packet.data.findValueByName("rpc_page");  
			var retCode = packet.data.findValueByName("retCode");
		  var retMsg = packet.data.findValueByName("retMsg");
			var cust_name = packet.data.findValueByName("cust_name");
			var strLoginAccept = packet.data.findValueByName("strLoginAccept");
			var strOldMachineType = packet.data.findValueByName("strOldMachineType");
			var strOldSimNo = packet.data.findValueByName("strOldSimNo");
			var strNewMachineType = packet.data.findValueByName("strNewMachineType");
			var strNewSimNo = packet.data.findValueByName("strNewSimNo");
		
			if(retCode == 0){
			
				document.all.cust_name.value = cust_name;
				document.all.oper_login_accept.value = strLoginAccept;
				document.all.old_machine_type.value = strOldMachineType;
				document.all.old_sim_no.value = strOldSimNo;
				document.all.new_machine_type.value = strNewMachineType;
				document.all.new_sim_no.value = strNewSimNo;
				document.all.confirm.disabled=false;
			}else
			{
				rdShowMessageDialog("����:"+ retCode + "->" + retMsg);
				return;
			}    
		    
		}
		
		//-------2---------��֤���ύ����-----------------
		
		function printCommit(){
			//У��
			getAfterPrompt();
		   if(!checkElement(document.s7115.phoneno)) return false;	
			if(!check(s7115)) return false;
			
		   //��ӡ�������ύ��
		   document.all.op_mark.value="�û�"  + document.all.phoneno.value + "����绰��ѻ�������";
		    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
		
		     if((ret=="confirm"))
		      {
		        if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
		        {  
			      s7115.submit();
		        }
		
		
			    if(ret=="remark")
			    {
		         if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		         {
			       s7115.submit();
		         }
			   }
			}
		    else
		    {
		       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		       {
			     s7115.submit();
		       }
		    }	
		    return true;
		  }
		  function showPrtDlg(printType,DlgMessage,submitCfm)
		  {  //��ʾ��ӡ�Ի��� 		  	
		  	
		  	var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
	     		var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
			var sysAccept ="<%=sysAccept%>";                       // ��ˮ��
			var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
			var mode_code=null;                        //�ʷѴ���
			var fav_code=null;                         //�ط�����
			var area_code=null;                    //С������
			var opCode =   "<%=opCode%>";                         //��������
			var phoneNo = document.all.phoneno.value                          //�ͻ��绰	
			
		    	var h=180;
		     	var w=350;
		     	var t=screen.availHeight/2-h/2;
		     	var l=screen.availWidth/2-w/2;
		     	
		   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);   
		  }
		
		  function printInfo(printType){
		
		    
		    	var cust_info=""; //�ͻ���Ϣ
	      	    	var opr_info=""; //������Ϣ
	      		var retInfo = "";  //��ӡ����
	      		var note_info1=""; //��ע1
	      		var note_info2=""; //��ע2
	      		var note_info3=""; //��ע3
	      		var note_info4=""; //��ע4 
	      		
	      		cust_info+="�ͻ�������   "+document.all.cust_name.value+"|";
      			cust_info+="�ֻ����룺   "+document.all.phoneno.value+"|";  
      			
      			if(document.all.TranType[0].checked){
				opr_info+="����绰��ѻ���: ����"+"|";
			}else{
				opr_info+="����绰��ѻ���: ��������"+"|";
			}
	      		note_info1+="ԭ�����ͺ�:"+document.all.old_machine_type.value+"|";
			note_info2+="��SIM������:"+document.all.old_sim_no.value+"|";
		    	note_info3+="�»����ͺ�:"+document.all.new_machine_type.value+"|";
		    	note_info4+="��SIM������:"+document.all.new_sim_no.value+"|";
		    	
		    	
			retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	      		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
    	      		return retInfo;	
		  }
		
		 function sel_type1() {
		            window.location.href='s7115.jsp?op_code=7115&ph_no='+document.s7115.phoneno.value;
		 }
		
		 function sel_type2(){
		           window.location.href='s7115Del.jsp?op_code=7115&ph_no='+document.s7115.phoneno.value;
		 }		
		 //-->
	  </script> 

</head>
<body> 
	<form action="7115Cfm.jsp" method="POST" name="s7115"  onKeyUp="chgFocus(s7115)">
		<%@ include file="/npage/include/header.jsp" %>  
		<div class="title">
			<div id="title_zi">����绰��ѻ���</div>
		</div>	
		<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
		<input type="hidden" name="op_type" id="op_type" value="d">
		<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">			
		<input type=hidden name=simBell value="   �ֻ�������ѡ�ײ��Żݵ�GPRS������ָCMWAP�ڵ����������.  �������أ�1.��������꿨,�ͼ�ֵ88Ԫ������ء�  2.��½������ɣ�wap.hljmonternet.com��ʹ���ֻ�����������ͼ�����ء�������Ѷ�����������������������������ʱ������,������Ϣ�ѣ�����1860��ͨGPRS ��">
		<input type=hidden name=worldSimBell value="    �������ҵ��󣬼���Ϊ�ҹ�˾ȫ��ͨǩԼ�ͻ�����ǩԼ������ʹ���ҹ�˾ҵ�񼰲�Ʒ��ͬʱִ���µ����������ߡ������ɵ�Ԥ�����������������������ϣ�ͬʱ�������Ļ����ڻ���ʹ�����޺󷽿�ʹ�á�       ��Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�       ��Ϊȫ��ͨ�ͻ������������ҹ�˾Ϊ���ṩ��������">
		<input type="hidden" name="opName" value="<%=opName%>">
		<input type="hidden" name="sysAccept" value="<%=sysAccept%>">
		
		<table  cellspacing="0">
			<tr> 
			    	<td  nowrap class="blue">��������1</td>
			    	<td  nowrap colspan="3" >
			    		<input name="TranType" type="radio" onClick="sel_type1()" value="a">���� 	
       					<input name="TranType" type="radio" onClick="sel_type2()" value="d"  checked>�������� 	
			    	</td>
		  	</tr>
		  	<tr> 
		    		<td  nowrap width="16%" class="blue">�û�����</td>
		      		<td nowrap  colspan="3" width="28%"> 
		      			<input   type="text" name="phoneno"  v_must=1  v_type="mobphone" value =<%=activePhone!=null?activePhone:ph_no%>  readonly class="InputGrey"  maxlength=11  index="6" >              
       					 <input  type="button" name="qryId_No" class="b_text" value="��ѯ" onClick="deleteSimChk()" > 
		      		</td>
			</tr>  	
		 	<tr> 
		    		<td   nowrap width="16%" class="blue">�û�����</td>
		      		<td  nowrap  width="28%"> 
		      			<input name="cust_name" type="text"    index="6" readonly class="InputGrey">
		      		</td>
		      		<td  nowrap  width="16%" class="blue">������ˮ</td>
		      		<td  nowrap  width="40%">
		      			<input  type="text" name="oper_login_accept" value="" readonly class="InputGrey"> 
		      		</td>
		    	</tr>
    			<tr> 
    				<td   nowrap width="16%" class="blue">ԭ�����ͺ�</td>
			      	<td  nowrap   width="28%"> 
			      		<input  type="text" name="old_machine_type" value="" readonly class="InputGrey">
			      	</td>
      				<td  nowrap class="blue"  width="16%">��SIM������</td>
      				<td  nowrap  width="40%"> 
      					<input  type="text" name="old_sim_no" value="" readonly class="InputGrey">
      				</td>
  			</tr>
			<tr> 
			    	<td   nowrap width="16%" class="blue">�»����ͺ�</td>
			      	<td  nowrap   width="28%"> 
			      		<input  type="text" name="new_machine_type" value="" readonly class="InputGrey">
			      </td>
			      <td  nowrap  width="16%" class="blue">��SIM������</td>
			      <td  nowrap  width="40%"> 
			      		<input  type="text" name="new_sim_no" value="" readonly class="InputGrey">
			      </td>
			</tr>
    			<tr>
    				<td valign="top" class="blue"> 
      					�û���ע
      				</td>
      				<td colspan="4" valign="top" > 
      					<input type="text"  name="op_mark"   size="100" readonly class="InputGrey"> 
      				</td>
    			</tr>
         	</table>
         	
          	<table  cellspacing="0">
          		<tr>
            			<td id="footer" >              
                			<input  type="button" name="confirm" class="b_foot_long" value="��ӡ&ȷ��"  onClick="printCommit()" index="26" disabled >
                			<input  type=reset name=back value="���" class="b_foot" onClick="document.all.confirm.disabled=true;" >
                			<input  type="button" name="b_back" class="b_foot" value="����"  onClick="removeCurrentTab()" index="28">
             
            			</td>
                      	</tr>
        	</table>
		<%@ include file="/npage/include/footer.jsp" %>	
	</form>
</body>
</html>


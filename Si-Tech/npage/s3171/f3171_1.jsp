<%
/********************
 version v2.0
������: si-tech
update:anln@2009-02-18 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");		
	
	String workNo = (String)session.getAttribute("workNo");	
	String loginPass  = (String)session.getAttribute("password");
%>

<html>
<head>
<title><%=opName%></title>
<script language=javascript>
	
	function fsubmit1() //�ύ
	{
		getAfterPrompt();
		document.all.idCard.v_must="";
		document.all.idCard.v_name="";
		document.all.idCard.v_type="";
		if(!check(document.form1)) return false;
		
		if(document.all.contractPay.value==document.all.contractPay2.value){
			rdShowMessageDialog('֧���ʺźͱ�֧���ʺŲ�����ͬ,����������!');
			return false;
		}	
		
		if(!forDate(document.all.beginDate)) return false;		
		
		if(!forDate(document.all.endDate)) return false;		
		
		if(parseInt(document.form1.beginDate.value) > parseInt(document.form1.endDate.value))
		{
			rdShowMessageDialog("��������Ӧ���ڿ�ʼ����!",0);
			return false;
		}	
		document.all.bSubmit1.disabled=true;//huangrong add for 	��ֹ����ȷ�� ��棺hrbd ����һ��֧��3171ģ����������ظ���֧���˺ŵĹ��ϴ������   2011-7-28 13:58
		document.form1.action="f3171_submit.jsp";  
		document.form1.submit();
	}
	
	//���:ֻ����������
	function isKeyNumberdot(ifdot) 
	{       
	    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
		if(ifdot==0)
			if(s_keycode>=48 && s_keycode<=57)
				return true;
			else 
				return false;
	    else
	    {
			if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
			{
			      return true;
			}
			else if(s_keycode==45)
			{
			    rdShowMessageDialog('���������븺ֵ,����������!');
			    return false;
			}
			else
				  return false;
	    }       
	}	
	//���end
	
	
	/************************** ���ù������棬��ѯ֧���ʻ�   begin *******************/
	function queryAccount()
	{		
		document.all.idCard.v_must="1";
		document.all.idCard.v_name="֤������";
		document.all.idCard.v_type="idcard";
		var pageTitle = "֧���ʻ���Ϣ";
		var fieldName = "�ʺ�|�ʻ�����|";
		var sqlStr = "";
	    	var selType = "S";    //'S'��ѡ��'M'��ѡ
	    	var retQuence = "2|0|1|";
	    	var retToField = "contractPay|accountName|";		    	
	    	if(pubSimpSelAccount(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));	
	 
	}
	
	function pubSimpSelAccount(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{	    
	    var path = "f3171_account_sel.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType+"&idCard="+document.all.idCard.value;
	    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	    return true;
	}
	
	function getvalueAccount(retInfo)
	{
	    var retToField = "contractPay|accountName|";
	    if(retInfo ==undefined)      
	    {   return false;   }
	
			var chPos_field = retToField.indexOf("|");
	    var chPos_retStr;
	    var valueStr;
	    var obj;
	    
	    while(chPos_field > -1)
	    {
	        obj = retToField.substring(0,chPos_field);
	        chPos_retInfo = retInfo.indexOf("|");
	        valueStr = retInfo.substring(0,chPos_retInfo);
	        document.all(obj).value = valueStr;
	        retToField = retToField.substring(chPos_field + 1);
	        retInfo = retInfo.substring(chPos_retInfo + 1);
	        chPos_field = retToField.indexOf("|");	        
	    }    			
	}
	// ���ù������棬��ѯ֧���ʻ�   end 
	
	
	onload=function()
	{
		
	}

	//---------------------------��ȡrpc���ص��û���Ϣ--------------------------------
	function doProcess(myPacket)
	{
		var errCode    = myPacket.data.findValueByName("errCode");
		var retMessage = myPacket.data.findValueByName("errMsg");//�������ص���Ϣ		
		var retFlag    = myPacket.data.findValueByName("retFlag");	
		
 		self.status="";
		//�����ɹ�
		
		if (errCode==000000)
		{
				var num = myPacket.data.findValueByName("num");
				if(num=="0"){
					rdShowMessageDialog("���ʻ����������������������룡",0);	
				}
				else{
					rdShowMessageDialog("��֤�ɹ���",2);	
					if(retFlag=="1"){
						document.all.checkButt2.disabled=false;
					}
					else if(retFlag=="2"){
						document.all.bSubmit1.disabled=false;
					}
				}
		}
		
		//-----������ش������-----
		if(errCode!=000000)
		{
			rdShowMessageDialog(retMessage,0);	
		}		
	}
	
	function changePay(){
		document.all.checkButt2.disabled=true;
		document.all.bSubmit1.disabled=true;
	}
	
	function changePay2(){
		document.all.bSubmit1.disabled=true;
	}
	
	
	/************************** ���ù������棬��ѯ��֧���ʻ���Ϣ   begin *******************/
	function queryAccount2()
	{	    	    
		document.all.idCard.v_must="1";
		document.all.idCard.v_name="֤������";
		document.all.idCard.v_type="idcard";	
		var pageTitle = "��֧���ʻ���Ϣ";
		var fieldName = "�ʺ�|�ʻ�����|";
		var sqlStr = "";
		    var selType = "S";    //'S'��ѡ��'M'��ѡ
		    var retQuence = "2|0|1|";
		    var retToField = "contractPay2|accountName2|";
		    var contractPay2 = document.form1.contractPay2.value;	
		    if(pubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
		  //}
	}

	function pubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{	    
	    var path = "f3171_account2_sel.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType+"&idCard="+document.all.idCard.value;
	
	    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	
		return true;
	}
	
	function getvaluecust(retInfo)
	{
	    var retToField = "contractPay2|accountName2|";
	    if(retInfo ==undefined)      
	    {   return false;   }
	
			var chPos_field = retToField.indexOf("|");
	    var chPos_retStr;
	    var valueStr;
	    var obj;
	    while(chPos_field > -1)
	    {
	        obj = retToField.substring(0,chPos_field);
	        chPos_retInfo = retInfo.indexOf("|");
	        valueStr = retInfo.substring(0,chPos_retInfo);
	        document.all(obj).value = valueStr;
	        retToField = retToField.substring(chPos_field + 1);
	        retInfo = retInfo.substring(chPos_retInfo + 1);
	        chPos_field = retToField.indexOf("|");	        
	    }
	}
	//���ù������棬��ѯ��֧���ʻ���Ϣ   end 
	
	
	function cancelAccount1() //���֧���ʻ���Ϣ
	{
		document.all.contractPay.value = "";
		document.all.contractPay1.value = "";
		document.all.accountAttr.value = "";
		document.all.levelNum.value = "";
		document.all.ECID.value = "";
		document.all.contractPay2.value = "";
		document.all.queryButt.disabled = false;
		document.all.queryButt.style.cursor = "hand";
		document.all.queryAccountMsgButt.disabled = true;
		document.all.queryAccountMsgButt.style.cursor = "";					
	}
	
	function cancelAccount2() //�����֧���ʺ�
	{
		if (document.all.contractPay2.value != "")
		{
			document.all.contractPay2.value = "";
		}		
	}
	
	function changeFlag(){
		if(document.all.allFlag.value=="1"){
			document.all.line_111.style.display="none";
			document.all.cycleMoney.value="0";
		}
		else{
			document.all.line_111.style.display="";
			document.all.cycleMoney.value="";
		}
	}
	
	function checkAccount(){
		if(!forNonNegInt(document.all.contractPay)){
			return false;
		}
		var contractPay=document.all.contractPay.value;
		var myPacket = new AJAXPacket("f3171_account_rpc.jsp","������֤�ʻ���Ϣ�����Ժ�......");		
		myPacket.data.add("contractPay",contractPay);	
		core.ajax.sendPacket(myPacket);
		delete(myPacket);myPacket=null;
	}
	
	function checkAccount2(){
		if(!forNonNegInt(document.all.contractPay2)){
			return false;
		}
		var contractPay2=document.all.contractPay2.value;
		var myPacket = new AJAXPacket("f3171_account_rpc2.jsp","������֤�ʻ���Ϣ�����Ժ�......");		
		myPacket.data.add("contractPay2",contractPay2);	
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
	
	
</script>
</head> 
<body>
<form name="form1" method="post" action="">
	<input type="hidden" name="workNo" value="<%=workNo%>">
	<input type="hidden" name="loginPass" value="<%=loginPass%>">	
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>	
     	<TABLE  id="mainOne" cellspacing="0">
          <TBODY>
          	<TR id="line_1"> 
			<TD class="blue">֤������</TD>
	            	<TD colspan="3">
	              		<input type="text"  v_must="1"  name="idCard" maxlength="18">&nbsp;&nbsp;
	              		<input type="button"  style="cursor:hand" class="b_text" name="queryButt"  value="��ѯ֧���ʻ�" onClick="queryAccount()">
	              		&nbsp;&nbsp;
	              		<input type="button" name="queryButt2" class="b_text" value="��ѯ��֧���ʻ�" onClick="queryAccount2()" >	              	
	            	</TD>
	        </TR>
        	<TR id="line_1"> 
			<TD   class="blue">֧���ʺ�</TD>
	            	<TD colspan="3" >
		              	<input type="text"  v_type="0_9"  v_must="1" v_minlength="11" v_maxlength="14"  name="contractPay" maxlength="14" onchange="changePay()">&nbsp;<font class="orange">*</font>
		              	<input type="button"  style="cursor:hand" name="checkButt" class="b_text" value="��֤" onClick="checkAccount()">
		              	<input type="hidden" name="accountName">
	            	</TD>	                       	              
          	</TR>
     
          	 <TR id="line_1"> 
				<TD class="blue" >��֧���ʺ�</TD>
				<TD colspan=3 >
					<input type="text"   v_type="0_9"  v_must="1" v_minlength="11" v_maxlength="14"   name="contractPay2" maxlength="14" onchange="changePay2()">&nbsp;<font class="orange">*</font>
					<input type="button"  style="cursor:hand" name="checkButt2"  class="b_text" value="��֤" onClick="checkAccount2()" disabled >
					<input type="hidden" name="accountName2">
				</TD>  	              
            </TR>  
            
           <TR  id="line_1"> 		  
             <TD  class="blue"  >֧��˳��</TD>
	            <TD colspan=3 >
	            <input type="text"  v_type="int"  v_must="1" v_minlength="1" v_maxlength="10" v_name="֧��˳��"  name="payOrder" maxlength="10">&nbsp;<font color="orange">*</font>
	              	(֧��˳�������ظ��������޸�֧��˳������֧����ϵ<br>
	              	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	              	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������ʹ��"�˻���ϵά��"���ܽ����޸�)
	            </TD> 
	          </TR>           
         	
            <TR id="line_1"> 		
		     	<TD   class="blue">ȫ���־</TD>
	            	<TD  colspan=3>	              	
		            	<select name="allFlag" onchange="changeFlag()">	            		
		              		<option value="0">�����</option>
		              		<option value="1">ȫ���</option>
		              	</select>&nbsp;
		              	<font class="orange">*</font>
	            	</TD>
	          </TR> 
	         <TR id="line_111">    	              
	            		<TD  class="blue">������</TD>
	            		<TD  colspan=3>  
	            			<input type="text"  v_type="money"  v_must="1" v_minlength="1" v_maxlength="14"  name="cycleMoney" maxlength="14">
	            			<font class="orange">*</font>
	           		 </TD>
	         </TR>	         
	         <TR id="line_1"> 
				<TD class="blue">��ʼ����</TD>
		           	<TD>
		              		<input type="text" v_type="date" name="beginDate" v_format="yyyymmdd" maxlength="8">&nbsp;(��ʽ:yyyymmdd)&nbsp;
		              		<font class="orange">*</font>            	
		            	</TD> 			
			    	<TD class="blue">��������</TD>
	            		<TD>
	              			<input type="text"  v_type="date" name="endDate" v_format="yyyymmdd" maxlength="8">&nbsp;(��ʽ:yyyymmdd)&nbsp;
	              			<font class="orange">*</font>  
	            		</TD> 		            	              
	         </TR>
          </TBODY>
          
        </TABLE> 
	<TABLE cellspacing="0" >
		<TR>
		       <TD id="footer"> 
		        	<input name="bSubmit1" style="cursor:hand" class="b_foot" type="button" value="ȷ��" onClick="fsubmit1()" disabled >
		         	&nbsp;
		         	<input name="cancel" style="cursor:hand" class="b_foot" type="button" value="����"  onClick="javascript:window.location.reload();">
		         	&nbsp; 
		         	<input name="" style="cursor:hand" class="b_foot" type="button" value="�ر�" onClick="removeCurrentTab()">
		         	&nbsp; 		         	     	         	   
			</TD>
		</TR>
	</TABLE>	
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

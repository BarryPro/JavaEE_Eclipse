 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-11 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%
	String opCode = "7378";		
	String opName = "����ҵ��������������-ɾ��";	//header.jsp��Ҫ�Ĳ���   
	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println(printAccept);

  	String loginNo = (String)session.getAttribute("workNo");
  	String loginName = (String)session.getAttribute("workName");  
	String regionCode= (String)session.getAttribute("regCode");
  	String loginNote="";	
    String loginPwd    = (String)session.getAttribute("password"); 
%>
<%
	String retFlag="",retMsg="";
 	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
  	//ArrayList retList = new ArrayList();
  	String[] paraAray1 = new String[3];
  	String phoneNo = request.getParameter("srv_no");
  	String passwordFromSer="";
  	String listtype=request.getParameter("listtype");

 	paraAray1[0] = loginNo;		/* �ֻ�����   */
  	paraAray1[1] = phoneNo; 	    /* ��������   */
  	paraAray1[2] = request.getParameter("listtype");	    /* ��������   */

  	for(int i=0; i<paraAray1.length; i++){
		if( paraAray1[i] == null ){
	  		paraAray1[i] = "";
		}
  	}
 
  	int [] lens ={8,4};
  	//ScallSvrViewBean viewBean = new ScallSvrViewBean();
  	//CallRemoteResultValue   value = viewBean.callService("2", phoneNo ,  "s7378Qry", "12"  ,  lens , paraAray1 ) ;
%>
	<wtc:service name="s7378Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="12" >
		<wtc:param value=" " />
		<wtc:param value="01" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=loginPwd%>" />	
		<wtc:param value="<%=paraAray1[1]%>"/>
    	<wtc:param value=" " />   
		<wtc:param value="<%=paraAray1[2]%>"/>		
	</wtc:service>
	<wtc:array id="result" start="0" length="8" scope="end"/>
	<wtc:array id="result2" start="8" length="4" scope="end"/>
<%
  	//ArrayList list = value.getList();
  	//String [][] result =null;
  	//String [][] result2 = null;
  	//result = (String[][])list.get(0);
  	String return_code="0";
  	String error_msg="";
  	//String return_code =result[0][0];
  	//String error_msg =result[0][1];
  	if(result!=null&&result.length>0){
  		return_code =result[0][0];
  		error_msg =result[0][1];
  	}	
  	
  	String offon="";
  	String bp_name="";
  	String cardId_no="";
  	String bp_add="";
  	int maxlines=0;
  	String sm_code="";
 
  if (return_code.equals("000000")){
		//result2 = (String[][])list.get(1);		
		maxlines = result2.length;
		System.out.println("result2.lengthresult2.length="+result2.length);
		offon=result[0][2];
		System.out.println("offonoffonoffon=["+offon+"]");
  		passwordFromSer=result[0][3];
  		 bp_name=result[0][4];
  		 cardId_no=result[0][5];
  		 bp_add=result[0][6];
  		 sm_code=result[0][7];
  }
  else
  {
  	System.out.println("errCode="+return_code);
  	System.out.println("errMsg="+error_msg);
	%>
		<script language="JavaScript">
			rdShowMessageDialog("������룺<%=return_code%>��������Ϣ��<%=error_msg%>",0);
			history.go(-1);
		</script>
<%	
	}

%>
<html>
<head>
	<title>����ҵ��������������--ɾ��</title>
	<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
	<script language="JavaScript" src="/npage/s1400/pub.js"></script>
 	<script language=javascript> 
  		onload=function(){
  	
  		}
 
 		function viewConfirm(){
			if(document.frm.IMEINo.value==""){
				document.frm.confirm.disabled=true;
			}
		}
 	</script>
	<script language="JavaScript">
		<!--
		  //����Ӧ��ȫ�ֵı���
		  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
		  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
		  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�
		
		  //***
		  function opchange()
		  {
		  	if(document.all.opFlag[1].checked==true){
		  		alldel();
		  	}
		  }
		  function alldel()
		  {
		  	getAfterPrompt();
		  	<%if(maxlines==1){%>
		  		document.all.ck_1.checked=false;
		  	<%}else{%>
		  		<%for(int l=0;l<maxlines;l++){%>
		  			document.all.ck_1[<%=l%>].checked=false;
		  		<%}%>
		  	<%}%>
		  }
		  function frmCfm(){
		  	var optypelist="";
			var opcodelist="";
			var opCount=0;
			<%System.out.println("aaaaaaaaaaaaaaaaa="+maxlines);
			 if (maxlines==1){%>
			   		if(!document.all.ck_1.checked){
						if(document.all.optype0.value!=""){
							optypelist=optypelist+document.all.optype0.value+",";
							opcodelist=opcodelist+document.all.opcode0.value+",";
							opCount=opCount+1;
						}
						
					}
			   
			   <%} else{%>
			   <%for(int l=0;l<maxlines;l++)
					{%>
				
						if(!document.all.ck_1[<%=l%>].checked){
							if(document.all.optype<%=l%>.value!=""){
								optypelist=optypelist+document.all.optype<%=l%>.value+",";
								opcodelist=opcodelist+document.all.opcode<%=l%>.value+",";
								opCount=opCount+1;
							}
						
						}
			<%	}
			}%>
		
			document.frm.action="f7378_3.jsp";
			
			if(opCount==0){
				rdShowConfirmDialog("û��ɾ����Ϣ��");
				return;
			}
			
			document.all.optypestr.value=optypelist;
			//alert(document.all.optypestr.value);
			document.all.opcodestr.value=opcodelist;
			//alert(document.all.opcodestr.value);
			document.all.opCount.value=opCount;
			//alert(document.all.opCount.value);
			if("<%=offon%>"=="0"){
				document.all.offon.value="1";
				document.all.opCount.value=0;
			}
		 	
		 	frm.submit();
			return true;
		  }
		 //***
		 function printCommit()
		 {
		 
			if("<%=request.getParameter("listtype")%>"=="W")
			{
		 		//��ӡ�������ύ��
		  		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
		  		if(typeof(ret)!="undefined")
		  		{
		   	 		if((ret=="confirm"))
		    		{
		      			if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
		      			{
		      				document.all.printcount.value="1";
			    			frmCfm();
		      			}
					}
					if(ret=="continueSub")
					{
		      			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		      			{
		      				document.all.printcount.value="0";
			    			frmCfm();
		      			}
					}
		  		}
		  		else
		  		{
		     		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		     		{
		     			document.all.printcount.value="0";
			   			frmCfm();
		  	   		}
		  		}
		  		return true;
		  	}else{
		  		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		     	{
		     		document.all.printcount.value="0";
			   		frmCfm();
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
			var phoneNo = <%=phoneNo%>;                           //�ͻ��绰		
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
		      	
		      	cust_info+="�ͻ�������   "+document.all.cust_name.value+"|";
			cust_info+="�ֻ����룺   "+document.all.phone_no.value+"|";
			cust_info+="�ͻ���ַ��   "+document.all.cust_addr.value+"|";
			cust_info+="֤�����룺   "+document.all.cardId_no.value+"|";
			
			opr_info+="�û�Ʒ��:"+"<%=sm_code%>"+"        ����ҵ��ͣ��ҵ����Ϣ"+"|";
		  	opr_info+="������ˮ��"+document.all.login_accept.value+"|";
			
			note_info1+="˵�����������ҵ��󣬼�Ϊ�����Ϥ�ҹ�˾��չ�ĸ��������Ƴ����Ż��ʷѺ���ҵ�����Ƴ��ķ�����Ŀ����Ϣ���ҹ�˾�������Զ��š��绰�ȷ�ʽ���֪ͨ����"+"|";
			
			retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
	    	      	return retInfo;	
		}
		
		//-->
	</script>




</head>
<body>
	<form name="frm" method="post" action="f7378_3.jsp" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�ͻ���Ϣ</div>
		</div>
        	<table cellspacing="0">		  
            		<td class="blue">��������</td>
            		<td colspan="3">����ҵ��������������-ɾ��</td>            
          	</tr>
          	<tr>
            		<td class="blue">�ͻ�����</td>
            		<td>
			  	<input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_name" maxlength="20" >
			  	<font class="orange">*</font>
            		</td>
            		<td class="blue">&nbsp;</td>
            		<td>
			  	<input name="cust_addr" value="<%=bp_add%>" type="hidden"  v_must=1 readonly class="InputGrey" id="cust_addr" maxlength="20" >
            		</td>
            	</tr>          
           	 <tr>
            		<td colspan="4"> 
            			<div align="center"> 
            				ҵ���ܿ���
            				<% if(!offon.equals("0")){%>
           					<input type="radio" name="opFlag" value="one" onclick="opchange()" disabled >��&nbsp;&nbsp;
						<input type="radio" name="opFlag" value="two" onclick="opchange()" checked>��
					<%}else{%>
			 			<input type="radio" name="opFlag" value="one" onclick="opchange()"  disabled checked >��&nbsp;&nbsp;
						<input type="radio" name="opFlag" value="two" onclick="opchange()" >��
					<%}%>
				</div>
        		</td>
            	</tr>
            <table>       
            <table cellspacing="0">	
              	<tr>              	                        
            		<th>������ʽ����</th>
            		<th>������ʽ����</th>
            		<th>ҵ�����</th>
            		<th>ҵ������</th>
            	</tr>
          		<%if(return_code.equals("000000")){
				for(int i=0;i<result2.length;i++){
			%>
			<tr>
             			<input type="hidden" name="optype<%=i%>" value="<%=result2[i][0]%>" >
             			<input type="hidden" name="opcode<%=i%>" value="<%=result2[i][2]%>" >
             			<td>
		             		<% if(!offon.equals("0")){%>
		             			<input type="checkbox" checked name="ck_1" >
		            		<%}else{%>
		            			<input type="checkbox" checked name="ck_1" disabled>
		            		<%}%>			  
					<%=result2[i][0]%>
                			&nbsp;
            			</td>
             			<td>
                			<%=result2[i][1]%>
            			</td>
            			<td>
                			<%=result2[i][2]%>
            			</td>
            			<td>
                			<%=result2[i][3]%>
            			</td>            	
             		</tr>				 
			<%}}%> 		 
    		</table>
    		<table cellspacing="0">	
          		<tr>
            			<td id="footer">
            				<input name="alldelete" type="button"  class="b_foot_long" value="ȫ�����"  onClick="alldel()">
            				&nbsp;
                			<input name="confirm" type="button"  class="b_foot_long" index="2" value="ȷ��&��ӡ" onClick="printCommit()"  >
                			&nbsp;                
                			<input name="back" onClick="location='f7378_1.jsp?activePhone=<%=phoneNo%>'" class="b_foot" type="button"  value="����">
                			&nbsp; 
                		</td>
          		</tr>
        </table>
 	     <input type="hidden" name="opCode" value="<%=opCode%>">
 	     <input type="hidden" name="opName" value="<%=opName%>">
 	      
	    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
	    <input type="hidden" name="work_no" value="<%=loginName%>">
	    <input type="hidden" name="login_accept" value="<%=printAccept%>">
	    <input type="hidden" name="listtype" value="<%=listtype%>">
	    <input type="hidden" name="optypestr" >
	    <input type="hidden" name="opcodestr" >
	    <input type="hidden" name="opCount" >
	    <input type="hidden" name="offon" >
	    <input type="hidden" name="optype" value="D">
	    <input type="hidden" name="cust_info">
	    <input type="hidden" name="opr_info">
	    <input type="hidden" name="note_info1">
	    <input type="hidden" name="haseval">
	    <input type="hidden" name="evalcode">      
	    <input type="hidden" name="note_info2">
	    <input type="hidden" name="note_info3">
	    <input type="hidden" name="note_info4">
    	    <input type="hidden" name="printcount">
    	    <input name="cardId_no" value="<%=cardId_no%>" type="hidden"  v_must=1 readonly class="InputGrey" id="cardId_no" maxlength="20" >
    	    <%@ include file="/npage/include/footer.jsp" %>   
	</form>
</body>
</html>



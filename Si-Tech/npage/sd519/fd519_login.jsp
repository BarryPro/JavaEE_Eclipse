<%
  /*
   * ����: Ԥ������������ d519
   * �汾: 1.8.2
   * ����: 2011/4/22
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%>
            
<%
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ include file="/npage/common/pwd_comm.jsp" %>	
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
 
<HTML><HEAD><TITLE><%=opName%></TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<%
String regionCode = (String)session.getAttribute("regCode");
String loginNo =  (String)session.getAttribute("workNo");
String phoneNo = (String)request.getParameter("activePhone");
String bindNo = (String)request.getParameter("bindNo")==null? "":(String)request.getParameter("bindNo");
String PrintAccept="";
PrintAccept = getMaxAccept();
String sql="";
%>

<script language="JavaScript">
	function validatePwd()
	{
		if(!check(document.frm)){
			return false;
		}	
		if( document.frm.bindNo.value==""){
			rdShowMessageDialog("�����û����벻��Ϊ�գ������룡",1);
			return false;
		}
		if( document.frm.bindPwd.value==""){
			rdShowMessageDialog("�����û������벻��Ϊ�գ������룡",1);
			return false;
		}		
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
				checkPwd_Packet.data.add("custType","01");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
				checkPwd_Packet.data.add("phoneNo",document.frm.bindNo.value);	//�ƶ�����,�ͻ�id,�ʻ�id
				checkPwd_Packet.data.add("custPaswd",document.frm.bindPwd.value);//�û�/�ͻ�/�ʻ�����
				checkPwd_Packet.data.add("idType"," ");				//en ����Ϊ���ģ�������� ����Ϊ����
				checkPwd_Packet.data.add("idNum","");					//����
				checkPwd_Packet.data.add("loginNo","<%=loginNo%>");		//����
				core.ajax.sendPacket(checkPwd_Packet,doCheckPwd,true);
				checkPwd_Packet=null;
	}
	
	function doCheckPwd(packet)
	{
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			rdShowMessageDialog(msg);
			window.location="fd519_login.jsp?opCode=d519&opName=Ԥ������������&activePhone=<%=phoneNo%>&bindNo="+document.frm.bindNo.value;
		}else
		{
			getFavourInfo();
		}
	}
	
	function getFavourInfo()
	{
		var packet = new AJAXPacket("getFavourInfo.jsp","������֤�ͻ�ȡ�û���Ϣ�����Ժ�......");
	  packet.data.add("phoneNo",document.frm.phoneNo.value);
	  packet.data.add("bindNo",document.frm.bindNo.value);
	  packet.data.add("op_code",document.frm.iOpCode.value);
	  packet.data.add("login_accept",document.frm.login_accept.value);
	  core.ajax.sendPacket(packet,doFavourInfo);
	  packet = null;	
	}
	
	function doFavourInfo(packet)
	{
	 var retCode = packet.data.findValueByName("retCode");
   var retMsg = packet.data.findValueByName("retMsg");
   if(retCode != "000000")
   {
   	rdShowMessageDialog(retMsg+"��");
   }else
   {	
   	var retFee = packet.data.findValueByName("retFee");	
    var retTerm = packet.data.findValueByName("retTerm");	
    var perFee =Number(retFee)/Number(retTerm);
    document.frm.returnFee.value=retFee;
    document.frm.perFee.value=perFee;    
    document.frm.favourInfo.value="����"+retFee+"Ԫ���ѣ���"+retTerm+"��������ÿ�·���"+perFee+"Ԫ";
   	document.frm.confirmAndPrint.disabled = false;
		var cust_name = packet.data.findValueByName("cust_name");	
		document.frm.cust_name.value=cust_name;
		var cust_address = packet.data.findValueByName("cust_address");	
		document.frm.cust_address.value=cust_address;		
		var id_iccid = packet.data.findValueByName("id_iccid");
		document.frm.id_iccid.value=id_iccid;			
		var sm_code = packet.data.findValueByName("sm_code");	
		document.frm.sm_code.value=sm_code;		
		var sm_name = packet.data.findValueByName("sm_name");	
		document.frm.sm_name.value=sm_name;
		var prepay_fee = packet.data.findValueByName("prepay_fee");	
		document.frm.prepay_fee.value=prepay_fee;		
   }
  }
		
	 function printCommit(){
		  getAfterPrompt();	 
		  document.frm.confirmAndPrint.disabled = true;
		  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
			if(typeof(ret)!="undefined")
			    {
			      if((ret=="confirm"))
			      {
			        if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
			        {
				      	frmCfm();
			        }
				  }
				  if(ret=="continueSub")
				  {
			        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
			        {
				      	frmCfm();
			        }
				  }
			    }
			    else
			    {
			       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
			       {
				    	 frmCfm();
			       }
			    }				  	
	 }
	 
	 	function frmCfm(){
	 		document.frm.action = "fd519Cfm.jsp";
	 		document.frm.submit();
		}
		
		function showPrtDlg(printType,DlgMessage,submitCfm)
    {  //��ʾ��ӡ�Ի��� 
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
			var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
			var sysAccept=<%=PrintAccept%>;                            // ��ˮ��
			var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
			var mode_code=null;                                        //�ʷѴ���
			var fav_code=null;                                         //�ط�����
			var area_code=null;                                        //С������
			var opCode="<%=opCode%>";                                  //��������
			var phoneNo=document.frm.phoneNo.value;                 //�ͻ��绰
		
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
			return ret;		
  }

  function printInfo(printType)
  {
	  var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		var retInfo = "";
		
		cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
		cust_info+="�ͻ�������"+document.frm.cust_name.value+"|";
		cust_info+="�ͻ���ַ��"+document.frm.cust_address.value+"|";
		cust_info+="֤�����룺"+document.frm.id_iccid.value+"|";		
 		
		
    opr_info+="�û�Ʒ�ƣ�"+document.all.sm_name.value+"    ҵ�����ͣ�Ԥ������������"+"|";
		opr_info+="ҵ����ˮ��"+"<%=PrintAccept%>"+"|";
		opr_info+="�������ƣ������Ż��������������ѣ�12���£�"+"|";					
		opr_info+="���ͻ��ѣ�ÿ�����ͻ���"+document.frm.perFee.value+"Ԫ"+"|";			

			
		note_info1+="��ע����ӭ���μӡ�Ԥ�����������󡱻��������������������ޣ����ɻ�������"+document.frm.returnFee.value+"Ԫ�����ͻ��ѽ���12���·��·�����ÿ�·���"+document.frm.perFee.value+"Ԫ�����ͻ����ڻ��Ч�մ���5���ڵ��ˡ��������ǰ����ǩԼ��������ȡ����������ΥԼ������ÿ�»������ѻҲ����ֹͣ�����λδ�漰���ʷѣ������е��ƶ��绰�ʷѱ�׼ִ�С���Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�"+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;		  
  } 
</script>
</HEAD>
<BODY >
<FORM  method=post name=frm >
	<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div> 
  <table cellspacing="0">
		 	<tr>
	 			<td class="blue">�ֻ�����</td>
	 			<td colspan="3"><input type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" readOnly class="InputGrey"></td>
		 	</tr>
		 		
		 	 <tr>
				<td class="blue" nowrap>�����û�����</td>
				<td> 
					<input type="text" name="bindNo" value="<%=bindNo%>"  name="bindNo" v_type="mobphone" v_must="1" maxlength="11" onblur="checkElement(this)" ><font class="orange">*</font>
		    </td>
				<td class="blue">�����û�������</td>
				<td> 
					<jsp:include page="/npage/common/pwd_1.jsp">
				      <jsp:param name="width1" value="16%"  />
				      <jsp:param name="width2" value="34%"  />
				      <jsp:param name="pname" value="bindPwd"  />
				      <jsp:param name="pwd" value="account_passwd"  />
			    </jsp:include>
			    <input name=checkout type=button onClick="validatePwd();" class="b_text" style="cursor:hand" id="checkout" value=У��><font class="orange">*</font>
		    </td>
			</tr>
			
		 	<tr>
	 			<td class="blue">�����Ż���Ϣ</td>
	 			<td colspan="3"><input type="text" name="favourInfo" id="favourInfo" value="" size="60" readOnly class="InputGrey"></td>
		 	</tr>												
	</table>
	<table>					
		 	<tr>	
		 		<td id="footer" colspan="4">
		 			<input type="button" id="confirmAndPrint" class="b_foot" value="ȷ��&��ӡ" onclick="printCommit()" disabled>
		 			<input type="button" id="colse"  class="b_foot" value="�ر�" onclick="removeCurrentTab()">
		 		</td>
		 	</tr>
	</table>
<input type="hidden" name="iOpCode"  value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="login_accept"  value="<%=PrintAccept%>">
<input type="hidden" name="returnFee" id="returnFee">
<input type="hidden" name="perFee" id="perFee">
<input type="hidden" name="cust_address" id="cust_address">
<input type="hidden" name="id_iccid" id="id_iccid">
<input type="hidden" name="sm_code" id="sm_code">
<input type="hidden" name="sm_name" id="sm_name">
<input type="hidden" name="cust_name" id="cust_name">
<input type="hidden" name="prepay_fee" id="prepay_fee">

</FORM>
		<%@ include file="/npage/include/footer.jsp"%>
</BODY> 	
</HTML>
						
  					

<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-09 ҳ�����,�޸���ʽ
     *������ҳ��������֤����
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
  	request.setCharacterEncoding("GBK");

	  HashMap hm=new HashMap();
	  hm.put("1","û�пͻ�ID��");
	  hm.put("3","�������");
	  hm.put("4","�����Ѳ�ȷ���������ܽ����κβ�����");
	  ///////
	  //  ��������� START
	  hm.put("5","�Բ��𣬴˺���Ϊ����������룬���Ĺ���Ȩ�޲��㣡");
	  hm.put("6","�Բ��𣬴˺����������ʼ��ʵ���ҵ������ȡ����");
	  hm.put("7","�Բ��𣬴˺��������������ʵ���ҵ������ȡ����");
	  hm.put("8","�Բ��𣬴˺����������ʼ��ʵ����͡������ʵ���ҵ������ȡ����");
	  hm.put("9","δ��ȡ���û������Ļ�����Ϣ!");
	  ///////
	  //  ��������� END
	  hm.put("2", "�û����ϲ�����1����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("10","�û����ϲ�����2����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("11","�û����ϲ�����3����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("12","�û����ϲ�����4����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("13","�û����ϲ�����5����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("14","�û����ϲ�����6����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("15","�Բ��𣬴˺�������������ͨҵ��ҵ������ȡ����");
	  hm.put("30","���û�Ϊ����û������ܽ���ʵ���Ǽǣ�");
	  hm.put("31","ʡ��Я���û���ֻ����ԭ�����ؽ���ʵ���Ǽǣ�");
%>
<%
		String opCode = WtcUtil.repNull(request.getParameter("opCode"))==""?"m058":WtcUtil.repNull(request.getParameter("opCode"));
		String opName = WtcUtil.repNull(request.getParameter("opName"))==""?"ʵ���Ǽ�":WtcUtil.repNull(request.getParameter("opName"));
		String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
		System.out.println("#############ReqPageName->"+ReqPageName);
		String accept = WtcUtil.repNull(request.getParameter("accept"));
		String work_no = (String)session.getAttribute("workNo");
		String activePhone1=WtcUtil.repNull(request.getParameter("activePhone"));
		
		//2011/6/23 wanghfa��� ������Ȩ������ start
  boolean pwrf=false;
	String pubOpCode = opCode;
	String pubWorkNo = work_no;
	int favFlag = 0 ;/*0û������Ȩ��1������Ȩ��*/
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
 
	//2011/6/23 wanghfa��� ������Ȩ������ end
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ʵ���Ǽ�</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
 var isValidateFlag = false;
 onload=function()
 {
 		self.status="";
 		<%
 		if(accept.equals("")) {
 		%>
 		//document.all.cus_pass.disabled = false;
 		<%
 	}
 	%>
		<%
			if(ReqPageName.equals("s1238Main"))
			{
			  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));			 
		 	  if(!retMsg.equals("100") && !retMsg.equals("101"))
			  {
		%>
			    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");
		<%
			  }
			  else if(retMsg.equals("100"))
			  {
		%>
				rdShowMessageDialog('�ʻ�<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>��Ƿ�ѣ����ܰ���ҵ��');

		<%
			  }
		      else if(retMsg.equals("101"))
			  {
		%>
		rdShowMessageDialog('����<%=WtcUtil.repNull(request.getParameter("errCode"))%>��<%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');
		       		<%
			  }
			}
		%>

  }

var passflag="no";
	//��֤���ύ����
	function doCfm()
	{
		
	<%
		if(accept.equals("")) {
		%>
		
			if(checkElement(document.frm.srv_no)==false) {
				 return false;
				}
				
				//var jiamiqianmima= document.all.cus_pass.value;		
				var phones_no= $("#srv_no").val();	
				
				
				if(phones_no.trim()=="") {
				 rdShowMessageDialog("�ֻ����벻��Ϊ�գ�");
				 return false;
				}
				
				chkIsValidateSpecial("1",phones_no,"<%=opCode%>");
				
				//if(isValidateFlag==false) {
				if(false){//Ϊ����д��
					
					var path = "<%=request.getContextPath()%>/npage/public/publicValidate.jsp";
					path =  path + "?valideVal=1";
					path =  path + "&titleName=<%=opName%>";
					path =  path + "&activePhone=" + $("#srv_no").val();
					path =  path + "&opCode=<%=opCode%>";
					path =  path + "&nowTimeee=" + Math.random();
					var validateResult = window.showModalDialog(path,"","dialogWidth=450px;dialogHeight=250px");
					if((validateResult=="undefined")||(validateResult!="1")){
						return;
					}
				}
			 
	 <%
		}	
		%>	
		
		
			
    frm.action="s1238Main.jsp";
    frm.submit();
	}
	
	function chkIsValidateSpecial(validateVal,activePhone,opcode)
	{
	  	isValidateFlag = false;
	  	var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/public/chkIsValidateSpecial.jsp","���ڽ����û���Ч����֤,���Ժ�...");

	    chkInfoPacket.data.add("retType" ,     "chkIsValidate"  );
	    chkInfoPacket.data.add("verifyVal" ,  validateVal);
	    chkInfoPacket.data.add("phoneNo" ,  activePhone);
	    chkInfoPacket.data.add("opCode" ,  opcode);
	    chkInfoPacket.data.add("nowTime" ,  Math.random());
	    core.ajax.sendPacket(chkInfoPacket,doProcesspwd);
	    chkInfoPacket =null;
	}
	
    function doProcesspwd(packet)
	{
	    var retType = packet.data.findValueByName("retType");

	    if(retType=="chkIsValidate")
      {
      	var retCode = packet.data.findValueByName("retCode");
      	if(retCode=="000000")
      	 {
	         isValidateFlag = true;
      	 }
      }
      
       if(retType=="timeValidate")
      {
        var retCode   = packet.data.findValueByName("retCode");
        var timestamp = packet.data.findValueByName("timestamp");
        var targetUrl = packet.data.findValueByName("targetUrl");
        if(retCode=="000000")
         {
         	   if(targetUrl.indexOf("chncard") != -1){
         	   	   //alert('chncard');
         	   	   oldjumpurl=targetUrl;
         	  }else{
         	    targetUrl=targetUrl.substring(0,targetUrl.indexOf("#"));
         	    oldjumpurl=targetUrl+"&v99="+timestamp+"#";
         	      //alert(oldjumpurl);
         	   }
              return true;
         }else{
         	    
         	    alert("ʱ�����ʧ��");
         	    return false;
        }
      }
	}
	
 
</script>
</head>
	<body>
		<form name="frm" method="POST">
 			<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1238Login">
 			<input type="hidden" name="accept" value="<%=accept%>"/>
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">ʵ���Ǽ�</div>
			</div>
	    <table cellspacing="0">
          <tr>
            <td width="16%" class="blue">�������</td>
      			<td width="34%">
                <input type="text" size="17" maxLength="20" name="srv_no" id="srv_no"   maxlength="11" value="<%=activePhone1%>"  <%if(!activePhone1.equals("")){out.print(" readOnly");}%>>
      			</td>
      			
      			<!--
      			    <td width="16%" class="blue">�û�����</td>
    <td>
        <jsp:include page="/npage/common/pwd_one_new.jsp">
            <jsp:param name="width1" value="16%"/>
            <jsp:param name="width2" value="34%"/>
            <jsp:param name="pname" value="cus_pass"/>
            <jsp:param name="pwd" value="12345"/>
        </jsp:include>
    </td>
    -->
      		</tr>
          <tr>
            <td id="footer" colspan="2">
			          <input class="b_foot" type=button name=qryPage value="ȷ��" onClick="doCfm()">
					  		<input class="b_foot" type=button name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
      			</td>
    			</tr>
  			</table>
  			 <input type="hidden" name="jiamipassword" id="jiamipassword"  >
	<%@ include file="/npage/include/footer_simple.jsp"%>
		<%@ include file="/npage/common/pwd_comm.jsp" %>
   </form>
</body>
</html>
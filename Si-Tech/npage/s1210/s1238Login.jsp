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
	  hm.put("30","���û�Ϊ����û������ܽ���GSM������");
	  hm.put("31","ʡ��Я���û���ֻ����ԭ�����ؽ���GSM������");
%>
<%
		String opCode = WtcUtil.repNull(request.getParameter("opCode"))==""?"1238":WtcUtil.repNull(request.getParameter("opCode"));
		String opName = WtcUtil.repNull(request.getParameter("opName"))==""?"GSM����":WtcUtil.repNull(request.getParameter("opName"));
		String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
		System.out.println("#############ReqPageName->"+ReqPageName);
		String accept = WtcUtil.repNull(request.getParameter("accept"));
		String work_no = (String)session.getAttribute("workNo");
		String activePhone1=WtcUtil.repNull(request.getParameter("activePhone"));
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>GSM����</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>

 onload=function()
 {
 		self.status="";
 		<%
 		if(accept.equals("")) {
 		%>
 		document.all.cus_pass.disabled = false;
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
		
				var jiamiqianmima= document.all.cus_pass.value;		
				var phones_no= $("#srv_no").val();		
				if(jiamiqianmima=="") {
				 rdShowMessageDialog("�û����벻��Ϊ�գ�");
				 return false;
				}
				if(phones_no.trim()=="") {
				 rdShowMessageDialog("�ֻ����벻��Ϊ�գ�");
				 return false;
				}
				var checkPwd_Packets = new AJAXPacket("queryENPass.jsp","ȡ�ü��ܺ��û����������");
				checkPwd_Packets.data.add("jiamiqianmima",jiamiqianmima);			
				core.ajax.sendPacket(checkPwd_Packets, doqueryjiami);
				checkPwd_Packets=null;
		
		
		
				
				var jiamipasswords= $("#jiamipassword").val();			
				var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
				checkPwd_Packet.data.add("custType","01");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
				checkPwd_Packet.data.add("phoneNo",phones_no);	//�ƶ�����,�ͻ�id,�ʻ�id
				checkPwd_Packet.data.add("custPaswd",jiamipasswords);//�û�/�ͻ�/�ʻ�����
				checkPwd_Packet.data.add("idType","en");				//en ����Ϊ���ģ�������� ����Ϊ����
				checkPwd_Packet.data.add("idNum","");					//����
				checkPwd_Packet.data.add("loginNo","<%=work_no%>");		//����
				core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
				checkPwd_Packet=null;
				
				if(passflag=="no") {
				return false;
				}
	 <%			
		}	
		%>	
			
    frm.action="s1238Main.jsp";
    frm.submit();
	}
	
			function doqueryjiami(packet) {
					var retResult = packet.data.findValueByName("jiamimima");
					$("#jiamipassword").val(retResult);
			}
			
			function doCheckPwd(packet) {
				var retResult = packet.data.findValueByName("retResult");
				var msg = packet.data.findValueByName("msg");
				if (retResult != "000000") {
					rdShowMessageDialog(msg);						
					passflag="no";	
					document.all.cus_pass.value="";		
				}else {
				 rdShowMessageDialog("�û�����У��ɹ���",2);
				  passflag="yes";			
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
			    <div id="title_zi">GSM����</div>
			</div>
	    <table cellspacing="0">
          <tr>
            <td width="16%" class="blue">�������</td>
      			<td width="34%">
                <input type="text" size="17" maxLength="13" name="srv_no" id="srv_no" v_type="mobphone"  maxlength="11" value="<%=activePhone1%>"  <%if(!activePhone1.equals("")){out.print(" readOnly");}%>>
      			</td>
      			    <td width="16%" class="blue">�û�����</td>
    <td>
        <jsp:include page="/npage/common/pwd_one_new.jsp">
            <jsp:param name="width1" value="16%"/>
            <jsp:param name="width2" value="34%"/>
            <jsp:param name="pname" value="cus_pass"/>
            <jsp:param name="pwd" value="12345"/>
        </jsp:include>
    </td>
      		</tr>
          <tr>
            <td id="footer" colspan="4">
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
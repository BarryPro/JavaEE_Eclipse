<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		response.setHeader("Pragma","No-cache");
		response.setHeader("Cache-Control","no-cache");
		response.setDateHeader("Expires", 0);
		
		String opName     = "��վ�������������ϸ��Ϣ";
		String regionCode = (String)session.getAttribute("regCode");
		String opCode 		= WtcUtil.repNull((String)request.getParameter("opCode"));
		String phoneNo 		= WtcUtil.repNull((String)request.getParameter("phoneNo"));
		
		String vOrderId			 = "";
		String vSendCode		 = "";
		String vSendName		 = "";
		String vOrderTime		 = "";
		String vCustName		 = "";
		String vIdName			 = "";
		String vIdIccid			 = "";
		String vProCode			 = "";
		String vDisCode			 = "";
		String vMailPerson	 = "";
		String vMailPhone		 = "";
		String vFixPhoneNo	 = "";
		String vMailAddress	 = "";
		String vMailPro			 = "";
		String vMailDis			 = "";
		String vMailTown		 = "";
		String vPostCode		 = "";
		String vDispatchType = "";
		String vOfferName		 = "";
		String vPrepayFee		 = "";
		String vPayAccept		 = "";
		String vPayTime			 = "";
		String vPayBank			 = "";
		String vPayPhone		 = "";
		String vPhoneNo			 = "";
		String vSaleFlag		 = "";
		String vIdAddr			 = "";
		String vOfferId			 = "";
		
		String paraAray[] = new String[10];

		paraAray[0] = "";                                       //��ˮ
		paraAray[1] = "01";                                     //��������
		paraAray[2] = opCode;                                   //��������
		paraAray[3] = (String)session.getAttribute("workNo");   //����
		paraAray[4] = (String)session.getAttribute("password"); //��������
		paraAray[5] = phoneNo;                                  //�û�����
		paraAray[6] = "";                                       //�û�����
		paraAray[7] = "";
		paraAray[8] = "3";
		paraAray[9] = "";
		
		String retCode = "";
		String retMsg  = "";
try{
%>
 	<wtc:service name="sg530Qry" outnum="28" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
 		<wtc:param value="<%=paraAray[0]%>" />
 		<wtc:param value="<%=paraAray[1]%>" />
 		<wtc:param value="<%=paraAray[2]%>" />
 		<wtc:param value="<%=paraAray[3]%>" />
 		<wtc:param value="<%=paraAray[4]%>" />
 		<wtc:param value="<%=paraAray[5]%>" />					
 		<wtc:param value="<%=paraAray[6]%>" />	
 		<wtc:param value="<%=paraAray[7]%>" />	
 		<wtc:param value="<%=paraAray[8]%>" />	
 		<wtc:param value="<%=paraAray[9]%>" />				
 	</wtc:service>
 	<wtc:array id="sg530QryResult" scope="end"/>
<%		
	if("000000".equals(code)&&sg530QryResult.length>0){
			vOrderId		  = sg530QryResult[0][0];   //���Ŷ�����   
			vSendCode		  = sg530QryResult[0][1];   //�������󷽱�ʶ
			vSendName		  = sg530QryResult[0][2];   //������������
			vOrderTime	  = sg530QryResult[0][3];   //����ʱ��      
			vCustName		  = sg530QryResult[0][4];   //�ͻ�����      
			vIdName			  = sg530QryResult[0][5];   //֤������      
			vIdIccid		  = sg530QryResult[0][6];   //֤������      
			vProCode		  = sg530QryResult[0][7];   //���Ź���ʡ    
			vDisCode		  = sg530QryResult[0][8];   //���Ź�������  
			vMailPerson	  = sg530QryResult[0][9];   //�ջ�����������
			vMailPhone	  = sg530QryResult[0][10];   //��ϵ�绰      
			vFixPhoneNo	  = sg530QryResult[0][11];   //�̶��绰      
			vMailAddress  = sg530QryResult[0][12];   //�ͻ���ַ      
			vMailPro		  = sg530QryResult[0][13];   //�ջ���ʡ������
			vMailDis		  = sg530QryResult[0][14];   //�ջ��˵�������
			vMailTown		  = sg530QryResult[0][15];   //�ջ�����������
			vPostCode		  = sg530QryResult[0][16];   //��������      
			vDispatchType = sg530QryResult[0][17];   //����ʱ��Ҫ��  
			vOfferId 	    = sg530QryResult[0][18];   //�ײͱ���      
			vOfferName		= sg530QryResult[0][19];   //�ײ�����      
			vPrepayFee		= sg530QryResult[0][20];   //Ԥ���        
			vPayAccept		= sg530QryResult[0][21];   //֧����ˮ      
			vPayTime			= sg530QryResult[0][22];   //֧��ʱ��      
			vPayBank		  = sg530QryResult[0][23];   //֧������      
			vPayPhone			= sg530QryResult[0][24];   //�ֻ�֧������  
			vPhoneNo		  = sg530QryResult[0][25];   //��������      
			vSaleFlag		  = sg530QryResult[0][26];   //����״̬      
			vIdAddr				= sg530QryResult[0][27];   //֤����ַ      
	}
	 retCode = code;
	 retMsg  = msg;
}catch(Exception e){
	 e.printStackTrace();
	 retCode = "40404";
	 retMsg  = "���÷���ϵͳ��������ϵ����Ա";
}		
%>
<HEAD>
<TITLE>�������ƶ�BOSS</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script type="text/javascript">
	
$(document).ready(function (){
	if("000000"!="<%=retCode%>"){
		rdShowMessageDialog("��ѯ����<%=retCode%>��<%=retMsg%>");
		window.close();
	}
});
</script>
</HEAD>
<BODY>
	<form method=post name="getsimno">
	<%@ include file="/npage/include/header_pop.jsp" %>
	
	<div class="title">
		<div id="title_zi">��ϸ��Ϣչʾ</div>
	</div>
			    
	<table cellspacing="0" >
	  <tr>
	    <td class="blue" width="15%">���Ŷ�����</td>
	    <td width="35%"><%=vOrderId%></td>
	    <td class="blue" width="15%">����ʱ��</td>
	    <td width="35%"><%=vOrderTime%></td>
		</tr>
		
		<tr>
	    
	    <td  class="blue">�ͻ�����</td>
	    <td><%=vCustName%></td>
	    <td class="blue" >�ջ�����������</td>
	    <td><%=vMailPerson%></td>
		</tr>
		
		<tr>
			<td  class="blue">֤������</td>
	    <td><%=vIdName%></td>
	    <td class="blue" >֤������</td>
	    <td><%=vIdIccid%></td>
		</tr>
		
		<tr>
	    <td  class="blue">��ϵ�绰</td>
	    <td><%=vMailPhone%></td>
	    <td  class="blue">ƽ̨������</td>
	    <td><%=vFixPhoneNo%></td>
		</tr>
		
		
		<tr>
			<td  class="blue">��������</td>
	    <td><%=vPhoneNo%></td>
	    <td  class="blue">��������</td>
	    <td><%=vPostCode%></td>
		</tr>
		
		<tr>
	    <td class="blue" >�ײͱ���</td>
	    <td><%=vOfferId%></td>
	    <td  class="blue">�ײ�����</td>
	    <td><%=vOfferName%></td>
		</tr>
		

		<tr>
			<td  class="blue">Ԥ���</td>
	    <td><%=vPrepayFee%></td>		
	    <td  class="blue">����״̬</td>
	    <td><%if ("5".equals(vSaleFlag)){
	    				out.write("δ���");
	    		} else if ("8".equals(vSaleFlag)){
	    				out.write("��Ԥռ");
	    		} else if ("0".equals(vSaleFlag)){
	    				out.write("����ɹ�δд��");
	    		}else if ("1".equals(vSaleFlag)){
	    				out.write("��д��δ�ʼ�");
	    		}else if ("2".equals(vSaleFlag)){
	    				out.write("���ʼ�δ�������");
	    		}else if ("3".equals(vSaleFlag)){
	    				out.write("���ͳɹ�");
	    		}else if ("4".equals(vSaleFlag)){
	    				out.write("����ʧ��");
	    		}else if ("5".equals(vSaleFlag)){
	    				out.write("δ���");
	    		}else if ("6".equals(vSaleFlag)){
	    				out.write("���ʧ��");
	    		}else if ("7".equals(vSaleFlag)){
	    				out.write("�û�����");
	    		} %></td>
		</tr>
		
	 <tr>
			<td  class="blue">����ʱ��Ҫ��</td>
	    	<td colspan="3">
	    	<%if ("1".equals(vDispatchType)){
	    				out.write("ֻ�������ͻ���˫���ա����ղ��ͻ���");
	    		} else if ("2".equals(vDispatchType)){
	    				out.write("˫���ա������ͻ��������ղ��ͻ���");
	    		} else if ("3".equals(vDispatchType)){
	    				out.write("�����ա�˫��������վ����ͻ�");
	    		} %>
	    	</td>
	  </tr>
		<tr>
	    <td class="blue" >�ͻ���ַ</td>
	    <td colspan="3"><%=vMailAddress%></td>
		</tr>
	</table>
  
  <table cellSpacing="0">
    <tr>
      <TD align="center" id="footer" >
        <input class="b_text" name=back onClick="window.close()" type="button" value="�ر�">&nbsp;
      </TD>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</BODY>
</HTML>

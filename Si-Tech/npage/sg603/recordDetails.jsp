<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		response.setHeader("Pragma","No-cache");
		response.setHeader("Cache-Control","no-cache");
		response.setDateHeader("Expires", 0);
		String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
		String opName = WtcUtil.repNull((String)request.getParameter("opName"));
		
		String vOrderId	= WtcUtil.repNull((String)request.getParameter("vOrderId"));
		String vSendCode	= WtcUtil.repNull((String)request.getParameter("vSendCode"));
		String vSendName	= WtcUtil.repNull((String)request.getParameter("vSendName"));
		String vOrderTime	= WtcUtil.repNull((String)request.getParameter("vOrderTime"));
		String vCustName	= WtcUtil.repNull((String)request.getParameter("vCustName"));
		String vIdName	= WtcUtil.repNull((String)request.getParameter("vIdName"));
		String vIdIccid	= WtcUtil.repNull((String)request.getParameter("vIdIccid"));
		String vProCode	= WtcUtil.repNull((String)request.getParameter("vProCode"));
		String vDisCode	= WtcUtil.repNull((String)request.getParameter("vDisCode"));
		String vMailPerson	= WtcUtil.repNull((String)request.getParameter("vMailPerson"));
		String vMailPhone	= WtcUtil.repNull((String)request.getParameter("vMailPhone"));
		String vFixPhoneNo	= WtcUtil.repNull((String)request.getParameter("vFixPhoneNo"));
		String vMailAddress	= WtcUtil.repNull((String)request.getParameter("vMailAddress"));
		String vMailPro= WtcUtil.repNull((String)request.getParameter("vMailPro"));
		String vMailDis	= WtcUtil.repNull((String)request.getParameter("vMailDis"));
		String vMailTown	= WtcUtil.repNull((String)request.getParameter("vMailTown"));
		String vPostCode	= WtcUtil.repNull((String)request.getParameter("vPostCode"));
		String vDispatchType	= WtcUtil.repNull((String)request.getParameter("vDispatchType"));
		String vOfferName	= WtcUtil.repNull((String)request.getParameter("vOfferName"));
		String vPrepayFee	= WtcUtil.repNull((String)request.getParameter("vPrepayFee"));
		String vPayAccept	= WtcUtil.repNull((String)request.getParameter("vPayAccept"));
		String vPayTime	= WtcUtil.repNull((String)request.getParameter("vPayTime"));
		String vPayBank	= WtcUtil.repNull((String)request.getParameter("vPayBank"));
		String vPayPhone	= WtcUtil.repNull((String)request.getParameter("vPayPhone"));
		String vPhoneNo	= WtcUtil.repNull((String)request.getParameter("vPhoneNo"));
		String vSaleFlag	= WtcUtil.repNull((String)request.getParameter("vSaleFlag"));
		String vIdAddr	= WtcUtil.repNull((String)request.getParameter("vIdAddr"));
		String vOfferId	= WtcUtil.repNull((String)request.getParameter("vOfferId"));
		
%>
<HEAD>
	<TITLE>�������ƶ�BOSS</TITLE>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>

	<script type=text/javascript>
		
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
	    <td><%=vOrderId%></td>
	    <td width="15%" class="blue">�������󷽱�ʶ</td>
	    <td><%=vSendCode%></td>
	    <td width="15%" class="blue">������������</td>
	    <td><%=vSendName%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">����ʱ��</td>
	    <td><%=vOrderTime%></td>
	    <td width="15%" class="blue">�ͻ�����</td>
	    <td><%=vCustName%></td>
	    <td width="15%" class="blue">֤������</td>
	    <td><%=vIdName%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">֤������</td>
	    <td><%=vIdIccid%></td>
	    <td width="15%" class="blue">���Ź���ʡ</td>
	    <td><%=vProCode%></td>
	    <td width="15%" class="blue">���Ź�������</td>
	    <td><%=vDisCode%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">�ջ�����������</td>
	    <td><%=vMailPerson%></td>
	    <td width="15%" class="blue">��ϵ�绰</td>
	    <td><%=vMailPhone%></td>
	    <td width="15%" class="blue">�̶��绰</td>
	    <td><%=vFixPhoneNo%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">�ͻ���ַ</td>
	    <td><%=vMailAddress%></td>
	    <td width="15%" class="blue">�ջ���ʡ������</td>
	    <td><%=vMailPro%></td>
	    <td width="15%" class="blue">�ջ��˵�������</td>
	    <td><%=vMailDis%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">�ջ�����������</td>
	    <td><%=vMailTown%></td>
	    <td width="15%" class="blue">��������</td>
	    <td><%=vPostCode%></td>
	    <td width="15%" class="blue">����ʱ��Ҫ��</td>
	    <td>
	    	<%if ("1".equals(vDispatchType)){
	    				out.write("ֻ�������ͻ���˫���ա����ղ��ͻ���");
	    		} else if ("2".equals(vDispatchType)){
	    				out.write("˫���ա������ͻ��������ղ��ͻ���");
	    		} else if ("3".equals(vDispatchType)){
	    				out.write("�����ա�˫��������վ����ͻ�");
	    		} %></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">�ײͱ���</td>
	    <td><%=vOfferId%></td>
	    <td width="15%" class="blue">�ײ�����</td>
	    <td><%=vOfferName%></td>
	    <td width="15%" class="blue">Ԥ���</td>
	    <td><%=vPrepayFee%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">֧����ˮ</td>
	    <td><%=vPayAccept%></td>
	    <td width="15%" class="blue">֧��ʱ��</td>
	    <td><%=vPayTime%></td>
	    <td width="15%" class="blue">֧������</td>
	    <td><%=vPayBank%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">�ֻ�֧������</td>
	    <td><%=vPayPhone%></td>
	    <td width="15%" class="blue">��������</td>
	    <td><%=vPhoneNo%></td>
	    <td width="15%" class="blue">����״̬</td>
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
	    <td class="blue">֤����ַ</td>
	    <td cospan="5"><%=vIdAddr%></td>
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

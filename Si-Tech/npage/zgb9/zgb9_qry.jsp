<%
/********************
 * version v2.0
 * ������: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	
	String opCode = "zgb9";
	String opName = "Ƿ�ѷ�Ʊ����";
	
	       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	
	String tax_no= request.getParameter("tax_no");
	String work_no = (String)session.getAttribute("workNo");
	 
	String tax_code = request.getParameter("tax_code"); 
	//�����ܽ��  
	String paraAray[] = new String[2]; 
	//select nvl(pre_inv_money,0) from VAT_INVOICE_PRE where invoice_number=:1 and invoice_code=:2 and status='p'
	paraAray[0] = "select  to_char(a.invoice_accept),to_char(nvl(pre_inv_money,0)),to_char(a.user_no)  from VAT_INVOICE_PRE  a where a.invoice_number=:s_no and invoice_code=:s_code and status='p' group by a.invoice_accept,pre_inv_money,a.user_no";
	paraAray[1] = "s_no="+ tax_no+",s_code="+tax_code;

 

	double d_sum=0.0;
%>

 

<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="sCode" retmsg="sMsg" outnum="3" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
</wtc:service>
<wtc:array id="sArr" scope="end"/>

 
<%
	String retCode= sCode;
	String retMsg = sMsg;
   

	String errMsg = sMsg;
	if(sArr!=null&&sArr.length>0)
	{ 
 
%>
	<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>��ѯ���</TITLE>
</HEAD>
<body >
<script language="javascript">
	 
	 onload=function form_load()
	 {
		rdShowMessageDialog("ӪҵԱִ��ȷ��ǰ��<br>��ȷ���ջؽ���Ԥ����Ʊ�����ȣ�");
		 
	 } 
	 function doCfm(d_sum)
	 {
		var	prtFlag = rdShowConfirmDialog("��˰�ϼ��ܽ��Ϊ"+d_sum+"Ԫ,�Ƿ�ȷ������?");
		if (prtFlag==1)
		{
			document.frm1508_2.action="zgb9_cfm.jsp";
			document.frm1508_2.submit();
		}
		else
		{
			return false;
		}
		  
		//�߼��� ԭ������ʷ ״̬��Ϊr ��¼wloginopr
     }
	 
</script>

<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>

      <table cellspacing="0"  >
                 
				<tr> 
                  <th>��ˮ</th>
				  <th>רƱ��˰�ϼ�</th>
				  <th>��Ʒ����</th>
				 
                </tr>
		<%
			for(int i=0;i<sArr.length;i++)
			{
				%>
					<tr>
						<td><input type="hidden" id="s_phone<%=i%>" value="<%=sArr[i][0]%>"><%=sArr[i][0]%></td>
				 
						<td><input type="hidden" id="s_money<%=i%>" value="<%=sArr[i][1]%>">
						<a href="zgb9_detail.jsp?loginaccept=<%=sArr[i][0]%>"><%=sArr[i][1]%></a></td>
						<td><input type="hidden" id="s_manager<%=i%>" value="<%=sArr[i][2]%>"><%=sArr[i][2]%></td>
					 
					</tr>
				<%
				d_sum  = d_sum+Double.parseDouble(sArr[i][1]);
			}
		%>
		 
        <input type="hidden" id="s_sum" name="s_sum1" value="<%=d_sum%>"> 
	 
		
          <tr id="footer"> 
      	    <td colspan="4">
			<!--
			  <input class="b_foot" name=back onClick="doCfm('<%=d_sum%>') " type=button value=Ԥ�����ŷ�Ʊ����>
			-->
    	      <input class="b_foot" name=back onClick="window.location = 'zgb9_1.jsp'  " type=button value=����>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
 
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("��ѯʧ��: <%=retMsg%>,<%=sCode%>",0);
	window.location="zgb9_1.jsp?opCode=zg27&opName=��ֵ˰���ַ�Ʊ��������";
	</script>
<%}
%>
		<%

%>




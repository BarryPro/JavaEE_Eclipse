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
	
	String opCode = "zg46";
	String opName = "����Ԥ����Ʊ����";
	
	       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	
	String unit_id= request.getParameter("unit_id");
	String work_no = (String)session.getAttribute("workNo");
	 
	String year_month = request.getParameter("year_month"); 
	//�����ܽ�� 
	String paraAray[] = new String[2]; 
	//paraAray[0] = "select to_char(a.invoice_money),to_char(a.grp_phone_no),to_char(nvl(sum(a.invoice_money),0)),a.manager_name   from grp_pre_invoice a where a.unit_id=:s_id and s_flag='p' and to_char(op_time,'YYYYMM')=:year_month group by to_char(a.grp_phone_no),to_char(a.invoice_money),a.manager_name";
	//paraAray[0] = "select  to_char(a.grp_phone_no),to_char(nvl(sum(a.invoice_money),0)),a.manager_name   from grp_pre_invoice a where a.unit_id=:s_id and s_flag='p' and to_char(op_time,'YYYYMM')=:year_month group by to_char(a.grp_phone_no), a.manager_name";
	paraAray[0] = "select  to_char(a.login_accpet),to_char(sum(a.invoice_money)),to_char(a.op_time,'YYYYMMDD hh24:mi:ss')  from grp_pre_invoice a where a.unit_id=:s_id and s_flag='p' and to_char(op_time,'YYYYMM')=:year_month group by a.login_accpet,a.op_time";
	paraAray[1] = "s_id="+ unit_id+",year_month="+year_month;

	 
	//���⼯������
	String paraAray3[] = new String[2]; 
	paraAray3[0] = "select trim(unit_name) from dvirtualgrpmsg where unit_id = :s_id ";
	paraAray3[1] = "s_id="+ unit_id;

	double d_sum=0.0;
%>

<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="sCode3" retmsg="sMsg3" outnum="1" >
    <wtc:param value="<%=paraAray3[0]%>"/>
    <wtc:param value="<%=paraAray3[1]%>"/> 
</wtc:service>
<wtc:array id="sArr3" scope="end"/>

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
<HEAD><TITLE>���⼯�Ų�ѯ���</TITLE>
</HEAD>
<body >
<script language="javascript">
	 
	 onload=function form_load()
	 {
		rdShowMessageDialog("ӪҵԱִ��ȷ��ǰ��<br>��ȷ���ջؽ���Ԥ����Ʊ�����ȣ�");
		 
	 } 
	 function doCfm(d_sum)
	 {
		var	prtFlag = rdShowConfirmDialog("Ԥ����Ʊ�ܽ��Ϊ"+d_sum+"Ԫ,�Ƿ�ȷ������?");
		if (prtFlag==1)
		{
			document.frm1508_2.action="zg46_cfm.jsp";
			document.frm1508_2.submit();
		}
		else
		{
			return false;
		}
		  
		//�߼��� ԭ������ʷ ״̬��Ϊr ��¼wloginopr
     }
	 function dojf()
	 {
		 alert("123");
	 }
</script>

<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>

      <table cellspacing="0"  >
                <tr> 
                  <th >���⼯�ź���</th>
				  <th >���⼯������</th>
                </tr>
			    <tr>
					<td><%=unit_id%></td>
					<td><%=sArr3[0][0]%></td>
				<input type="hidden" name="unit_id" value="<%=unit_id%>">	 
				<input type="hidden" name="unit_name" value="<%=sArr3[0][0]%>">
	 
				</tr>
				<tr> 
                  <th>��ˮ</th>
				  <th>Ԥ����Ʊ�ܽ��</th>
				  <th>Ԥ����Ʊʱ��</th>
				 
                </tr>
		<%
			for(int i=0;i<sArr.length;i++)
			{
				%>
					<tr>
						<td><input type="hidden" id="s_phone<%=i%>" value="<%=sArr[i][0]%>"><%=sArr[i][0]%></td>
				 
						<td><input type="hidden" id="s_money<%=i%>" value="<%=sArr[i][1]%>">
						<a href="zg46_detail.jsp?loginaccept=<%=sArr[i][0]%>"><%=sArr[i][1]%></a></td>
						<td><input type="hidden" id="s_manager<%=i%>" value="<%=sArr[i][2]%>"><%=sArr[i][2]%></td>
					 
					</tr>
				<%
				d_sum  = d_sum+Double.parseDouble(sArr[i][1]);
			}
		%>
		 
        <input type="hidden" id="s_sum" name="s_sum1" value="<%=d_sum%>"> 
		<input type="hidden"  name="year_month" value="<%=year_month%>">
		
          <tr id="footer"> 
      	    <td colspan="4">
			<!--
			  <input class="b_foot" name=back onClick="doCfm('<%=d_sum%>') " type=button value=Ԥ�����ŷ�Ʊ����>
			-->
    	      <input class="b_foot" name=back onClick="window.location = 'zg46_1.jsp'  " type=button value=����>
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
	window.location="zg46_1.jsp?opCode=zg27&opName=��ֵ˰���ַ�Ʊ��������";
	</script>
<%}
%>
		<%

%>




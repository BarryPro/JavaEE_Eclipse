<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/public/checkPhone.jsp" %>

<%
	  String workno=(String)session.getAttribute("workNo");    //����
	  
	  String opCode = "g807";
      String opName = "У԰�źż���ѽ���޸�";
	  String cxtj = request.getParameter("flag");
	  String pzds = request.getParameter("pzdsname");
	  String pzgh = request.getParameter("s_login_no");
	  
	  String ret_val_new[][];
	  //xl add ��ѯ
	  String[] inParas2 = new String[2];
 
	  System.out.println("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF cxtj is "+cxtj+" and pzds is "+pzds+" and pzgh is "+pzgh);
	  if(cxtj=="1" ||cxtj.equals("1"))
	  {
		  System.out.println("FFFFFFFFFFFFFFFFF ������");
		  inParas2[0]=" select to_char(op_code),to_char(lj_pay), lj_paytype,to_char(rest_pay),to_char(rest_month),to_char(rest_total_pay),rest_paytype,to_char(EXPENSE_MONTH),to_char(ACCUMULATE_TYPE),a.login_no,b.region_name, to_char(op_time,'YYYYMMDD hh24:mi:ss'),b.region_code  from wpregiftcfg a,sregioncode b where a.region_code = b.region_code and  a.login_no = :login_no";
		  inParas2[1]="login_no="+pzgh;
	  }
	  else
	  {
		  System.out.println("FFFFFFFFFFFFFFFFF ������");
		  inParas2[0]=" select to_char(op_code),to_char(lj_pay), lj_paytype,to_char(rest_pay),to_char(rest_month),to_char(rest_total_pay),rest_paytype,to_char(EXPENSE_MONTH),to_char(ACCUMULATE_TYPE),a.login_no,b.region_name,to_char(op_time,'YYYYMMDD hh24:mi:ss'),b.region_code  from wpregiftcfg a,sregioncode b where a.region_code = b.region_code and b.region_code=:region_code";
		  inParas2[1]="region_code="+pzds;
	  }
	  // System.out.println("FFFFFFFFFFFFFFFFFFFFFFf inParas2[0] is "+inParas2[0]+" and inParas2[1] is "+inParas2[1]);
%>
	<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="13">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
<%
	if(ret_val==null||ret_val.length==0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("��ѯ���Ϊ��,�����²�ѯ��");
				window.location.href='g807_1.jsp';
			</script>
		<%
	}
	else
	{
			%>



 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>У԰�źż���ѽ���ѯ���</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">У԰�źż���ѽ�����ò�ѯ���</div>
</div>
<div id="Operation_Table">
      <table cellspacing="0" id = "PrintA">
                <tr> 
             <th>opCode</th>          
				  <th>�������ѽ��</th>
				 
				  <th>��������</th>
				  <th>ʣ��ÿ�·��ѽ��</th> 
				  <th>ʣ�෵������</th>
				  <th>ʣ�෵���ܽ��</th>
				  <!--th>ʣ�෵������</th-->
				  <th>��������</th>
				  <th>�Ƿ��ۻ�����</th>
				  <th>���ù���</th>
				  <th>���õ���</th>
				  <th>����ʱ��</th>
				  <th>����</th>
                   
				  
                </tr>
			<%
				//select to_char(lj_pay),to_char(lj_begin_date),lj_paytype,to_char(rest_pay),to_char(rest_total_pay),to_char(rest_month),rest_paytype,to_char(op_time,'YYYYMMDD hh24:mi:ss')  from wpregiftcfg a,sregioncode b where a.region_code = b.region_code and b.region_code=:region_code
				for(int i=0;i<ret_val.length;i++)
				{
					%>
						<tr>
							<td><%=ret_val[i][0]%></td>
							<td><%=ret_val[i][1]%></td>
							<td><%=ret_val[i][2]%></td>
							<td><%=ret_val[i][3]%></td>
							<td><%=ret_val[i][4]%></td>
							<td><%=ret_val[i][5]%></td>
							<!--td><%=ret_val[i][6]%></td-->
							<td><%=ret_val[i][7]%></td>
							<%
							if(ret_val[i][8].equals("1"))
							{
							%>
								<td>��</td>
							<%
							}else
							{
							%>
								<td>��</td>
							<%
							}
							%>
						
							 <td><%=ret_val[i][9]%></td>
							 <td><%=ret_val[i][10]%></td>
							 <td><%=ret_val[i][11]%></td>
							<td><input type="button" class="b_foot" value="ɾ��" onclick="deletes('<%=ret_val[i][12]%>','<%=ret_val[i][0]%>')"> </td>
						</tr>
					<%
				}	
			%>
</div>			
         
          <tr id="footer"> 
      	    <td colspan="15">
    	      <input class="b_foot" name=back onClick="window.location = 'g807_1.jsp' " type=button value=����>
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
		}
%>	  
    
<script language="javascript">
	function deletes(region_code,opcode)
	{
		var prtFlag=0;
		prtFlag=rdShowConfirmDialog("�Ƿ�ȷ��ɾ��?");
		if (prtFlag==1)
		{
			
			//alert(opcode);
			//alert(region_code);
 			document.frm1508_2.action="g807_3.jsp?s_flag="+"1"+"&s_region_code="+region_code+"&opcode="+opcode;
			document.frm1508_2.submit();
		}
		else
		{
			//alert("��ɾ�� "+region_code);
			return false;
		}
		
	}
</script>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-------------------------------------------->
<!---����:  2005-06-02                    ---->
<!---����:  Doucm                         ---->
<!---����:  s1448_integral                ---->
<!---���ܣ��ʼ��ʵ�                       ---->
<!---�޸ģ�                               ---->
<!-------------------------------------------->
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.27
********************/
%>


<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
	
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("activePhone");
     
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");

	
	String paraStr[]=new String[1];
	String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
	//paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phoneNo%>"  id="seq"/>
<%
	paraStr[0] = seq;
	System.out.println("11111111111��" +paraStr[0]);
	String op_code = opCode;

%>

<%@ include file="../../npage/s5061/head_7114_javascript.htm" %>
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
</head>
<script language=javascript>
function showWorldMsg()
{
		
     if( document.all.r_cus[0].checked){}
}
</script>
<body>
  
<form action="7114Cfm.jsp" method="POST" name="s7114"  onKeyUp="chgFocus(s7114)">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
	<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	<input type="hidden" name="id_iccid"  value="">
	<input type="hidden" name="id_address"  value="">
	<input type="hidden" name="sm_name"  value="">
	
	<input type="hidden" name="loginAccept" value="<%=paraStr[0]%>">
	<%@ include file="../../include/remark.htm" %>
  <table cellspacing="0">
	  	<tr> 
	    	<td class="blue">��������</td>
	        <td colspan="3">
	        <input type="radio" name="r_cus" index="0" value="0" checked >����
	  		<input type="radio" name="r_cus"  index="1" value="1">ȡ��
	        </td>
	    </tr>
	    <tr> 
        <td class="blue">�û�����</td>
        <td colspan="3"> 
          <input class="InputGrey"  type="text" name="phoneno" value="<%=phoneNo%>" v_must=1  v_type="mobphone" readOnly maxlength=11  index="6" >              
          <input class="b_text" type="button" name="qryId_No" value="��ѯ" onClick="phone_qry()" > 
        </td>
      </tr>
      <tr> 
        <td class="blue">�û�����</td>
        <td> 
          <div align="left"> 
            <input name="cust_name" type="text" index="6" >
        </td>
        <td class="blue">��������</td>
        <td> 
         	<select name="remind_type" index="15">
	 		<option value="0" selected >�굥��ѯ</option>
            </select>
        </td>
      </tr>
    
      <tr> 
        <td class="blue"> 
          <div>ϵͳ��ע</div>
        </td>
        <td colspan="4"> 
          <input type="text" class="InputGrey" name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30>
        </td>
      </tr>
     
      <tr> 
        <td colspan="4" id="footer"> 
          <div align="center"> 
            <input class="b_foot" type="button" name="confirm" value="��ӡ&ȷ��"  onClick="printCommit()" index="26" disabled >
            <input class="b_foot" type=reset name=back value="���" onClick="document.all.confirm.disabled=true;" >
            <input class="b_foot" type="button" name="b_back" value="����"  onClick="removeCurrentTab()" index="28">
          </div>
        </td>
      </tr>
    </table>
  <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>


</html>

<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>

<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	
	String opCode = "zg44";
	String opName = "���⼯�Ź�ϵ����";
	
	       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	
	String unit_id= request.getParameter("unit_id");
    String select_id = request.getParameter("select_id");
    String cxhm = request.getParameter("cxhm");
 
	String work_no = (String)session.getAttribute("workNo");
	 
	 
	 
	String paraAray[] = new String[2]; 
	if(select_id=="1" ||select_id.equals("1"))
	{
		paraAray[0]="select to_char(unit_id),trim(unit_name),to_char(nvl(grp_phone_no,'��')),trim(grp_contract_no),to_char(op_time,'YYYYMMDD hh24:mi:ss'),login_no from Dvirtualgrpmsgdetail where unit_id = :s_id";
		paraAray[1]="s_id="+unit_id;
	}
	else
	{
		paraAray[0]="select to_char(unit_id),trim(unit_name),to_char(nvl(grp_phone_no,'��')),trim(grp_contract_no),to_char(op_time,'YYYYMMDD hh24:mi:ss'),login_no from Dvirtualgrpmsgdetail where grp_phone_no = :s_id";
		paraAray[1]="s_id="+cxhm;
	}
	String ret_val_new[][];
%>
<script language="javascript">
	function dels(unit_id,phone_no,contract_no)
	{
		//alert("unit_id is "+unit_id+" and phone_no is "+phone_no+" and contract_no is "+contract_no);
		var prtFlag=0;
		prtFlag=rdShowConfirmDialog("�Ƿ�ȷ������ɾ�����⼯�ų�Ա?");
		if (prtFlag==1){
			document.frm1508_2.action="zg44_detail_del.jsp?unit_id="+unit_id+"&phone_no="+phone_no+"&contract_no="+contract_no;
			//alert(document.frm.action);
			document.frm1508_2.submit();
		}
		else
		{ 
			return false;	
		}
	}
</script>
<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="sCode" retmsg="sMsg" outnum="6" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
 
</wtc:service>
<wtc:array id="sArr" scope="end"/>
<%
	String retCode= sCode;
	String retMsg = sMsg;
    ret_val_new=sArr;

	String errMsg = sMsg;
	if ( sCode.equals("000000"))
	{
 
%>
	<FORM method=post name="frm1508_2">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">��ѯ���</div>
		</div>
	<table cellspacing="0">
		<tr> 
			<th>���⼯�ű���</th>
			<th>���⼯������</th>
			<th>���⼯�ų�Ա����</th>
			<th>���⼯�ų�Ա�˺�</th>
			<th>����ʱ��</th>
			<th>����</th>
			<th>����</th>
		</tr>
		<%
			for(int i =0;i<ret_val_new.length;i++)
		    {
				%>
					<tr>
						<td>
							<%=ret_val_new[i][0]%>
						</td>
						<td>
							<%=ret_val_new[i][1]%>
						</td>
						<td>
							<%=ret_val_new[i][2]%>
						</td>
						<td>
							<%=ret_val_new[i][3]%>
						</td>
						<td>
							<%=ret_val_new[i][4]%>
						</td>
						<td>
							<%=ret_val_new[i][5]%>
						</td>
						<td>
							<input type="button" name="del" value="ɾ��"  class="b_foot" onclick="dels('<%=ret_val_new[i][0]%>','<%=ret_val_new[i][2]%>','<%=ret_val_new[i][3]%>')">
						</td>
					</tr>
				<%
            }
		%>
		<tr>
			<td colspan=7 align="center">
				<input type="button"  class="b_foot" value="����" onclick="window.location='zg44_1.jsp'">
			</td>
		</tr>
	</table>
	</FORM>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("����ʧ��: <%=retMsg%>,<%=sCode%>",0);
	window.location="zg44_1.jsp?opCode=zg27&opName=��ֵ˰���ַ�Ʊ��������";
	</script>
<%}
%>


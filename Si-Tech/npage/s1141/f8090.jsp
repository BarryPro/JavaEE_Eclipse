<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>�޸�IMEI�󶨹�ϵ</title>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	<%
		String opCode = "8090";
		String opName = "�޸�IMEI�󶨹�ϵ";
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String[] inParams = new String[2];
		String Sql_Str = "";
		Sql_Str = "select sale_op_code,plan_name,is_com from dbchnterm.schnressaleplantype where is_ModifyImei='Y'" ;
		inParams[0] = Sql_Str;
    inParams[1] = "";
    
		
	%>
	
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg0" retcode="code0" outnum="10">
			<wtc:param value="<%=inParams[0]%>"/>
			<wtc:param value="<%=inParams[1]%>"/>
		</wtc:service>
		<wtc:array id="resulttest" scope="end" />
			
	<script language="javascript">
		$(document).ready(function(){
			
		});
		//��ѯ����
		function doSubmit()
		{
			if(check(frm))
		{
			var plan_code = $("select[name='plan_code']").find("option:selected").val();
			var startCust = $("#startCust").val();
			if(plan_code.length==0)
			{
				rdShowMessageDialog("��ѡ��Ӫ������",1);
				return false;
			}
			if(startCust.length==0)
			{
				rdShowMessageDialog("��ѡ������ʱ�䣡",1);
				return false;
			}
			if(startCust.length!=0){
			startCust = startCust.replace("��-","");
			startCust = startCust.replace("��-","");
			startCust = startCust.replace("��","");
			//������ʱ��ȥ���������Լ���ܸ�ֵ����������
			$("#saletime").val(startCust);
			}
			frm.action="f8090Qry.jsp";
			frm.submit();
			
		}
			
		}
</script>
</head>
<body>
<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�޸�IMEI�󶨹�ϵ</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">�ֻ�����</td>
			<td>
				<input type="text" id="phoneno" name="phoneno"  v_must="1" 
						v_type="mobphone" onblur="checkElement(this)" />
			</td>
			<td class="blue">Ӫ����</td>
			<td>
				<select name="plan_code" style="width:200px">  			      
					<option value=""></option>
						<%                  
            		for(int i=0;i<resulttest.length;i++){
            %>
  			        <option value="<%=resulttest[i][0]%>"><%=resulttest[i][1]%></option>
  			    <%
  			    }
  			    %> 
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">����ʱ��</td>
			<td>
				<input type="text" id="startCust"   name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyy��-MM��-dd��',alwaysUseStartDate:true,maxDate:'%y-%M-%d',minDate:'#{%y-6}-01-01'})"/>
							<img id = "imgCustStart" 
								onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyy��-MM��-dd��',alwaysUseStartDate:true,maxDate:'%y-%M-%d',minDate:'#{%y-6}-01-01'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			</td>
			<td class="blue" colspan="2">ʱ�����ƣ�2006��---����</td>
			
		</tr>
		<tr>
			<td class="red" colspan="4">ע�⣺�û���Ӫ������ƽ̨��Ӫ��ִ��(g794)��������ն�Ӫ�������ڡ���������IMEI�󶨹�ϵ(g821)�������޸�</td>
		</tr>
	</table>
	
	<table cellSpacing="0">
		<tr align="center">
			<td align="center" id="footer">
			<input type="button" class="b_foot" value="��ѯ" onclick="doSubmit()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" class="b_foot"  value="���"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab();"/>
			</td>
		</tr>
	</table>
	<input type="hidden" id="saletime" name="saletime" value=""/>
	<input type="hidden" name="iLoginNo" value="<%=workNo%>"/>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>  
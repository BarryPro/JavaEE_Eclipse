<%
/********************
 version v2.0
������: si-tech
update:anln@2009-01-12 ҳ�����,�޸���ʽ
********************/
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%!
/*2014/10/08 10:03:04 gaopeng ��������BOSS�;���ϵͳ�ͻ���Ϣģ����չʾ�ĺ���201409�� 
	ģ������������ objType 1 �ͻ����� �˻����� 2���������ֵ�ַ�ȣ�
*/
private String vagueFunc(String objName,int objType){
	if(objName != null && !"".equals(objName) && !"NULL".equals(objName)){
		if(objType == 1){
			if(objName.length() == 2 ){
				objName = objName.substring(0,1)+"*";
			}
			if(objName.length() == 3 ){
				objName = objName.substring(0,1)+"**";
			}
			if(objName.length() == 4){
				objName = objName.substring(0,2)+"**";
			}
			if(objName.length() > 4){
				objName = objName.substring(0,2)+"******";
			}
		}else if(objType == 2){
			objName = "********";
		}
		
	}
	return objName;
}
%>
<%
	//������� �û�ID���ֻ����롢�������š�����Ա����ɫ������
	String id_no  = request.getParameter("idNo");
	String phone_no  = request.getParameter("phoneNo");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");	
	String org_Code = (String)session.getAttribute("orgCode");  //��������	
	
	String opCode = "1550";	
	String opName = "�ۺ���ʷ��Ϣ��ѯ֮�û�������Ϣ��ѯ";	//header.jsp��Ҫ�Ĳ��� 
	String sql_str="select to_char(a.assure_no),assure_name,assure_id,assure_phone,assure_address,to_char(assure_num) from dAssuMsg a,dCustInnetDead b where a.assure_no=b.assure_no and b.id_no="+id_no;  
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=org_Code%>"  retcode="retCode1" retmsg="retMsg1" outnum="6">
	<wtc:sql><%=sql_str%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="result" scope="end" />
<%	
	if(!retCode1.equals("000000")){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("����δ�ܳɹ�,�������:<%=retCode1%><br>������Ϣ:<%=retMsg1%>!");
	</script>
<%
		return;
	}else if(result==null||result.length==0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("��ѯ���Ϊ��,û�з�������������!");
	</script>
<%
		return;
	}
%>
<HTML>
	<HEAD>
		<TITLE>������Ϣ</TITLE>
	</HEAD>
	<body>
		<FORM method=post name="f1500_dAssuMsg">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">������Ϣ</div>
			</div> 	    
			<table cellspacing="0">     
		              <TBODY>
		                	 <TR>
		               	 	   	<td class="blue">����ID</td>
		               	 	   	<td>
		               	 	   		<input class="InputGrey" value="<%=result[0][0]%>" maxlength="27" size=27 readonly>
		               	 	   	</td>
		               	 	   	<td class="blue">����������</td>
		               	 	   	<td>
		               	 	   		<input class="InputGrey" value="<%=vagueFunc(result[0][1],1)%>" maxlength="23" size=23 readonly>
		               	 	   	</td>
		               	 	   	<td class="blue">������ʶ</td>
		               	 	   	<td>
		               	 	   		<input class="InputGrey" value="<%=result[0][2]%>" maxlength="25" size=25 readonly>
		               	 	   	</td>			               	 	   	
			                </TR>
			                
			                <TR>
			                	<td class="blue">�����˵绰</td>
		               	 	   	<td>
		               	 	   		<input class="InputGrey" value="<%=result[0][3]%>" maxlength="23" size=23 readonly>
		               	 	   	</td>
		               	 	   	<td class="blue">�����˵�ַ</td>
		               	 	   	<td>
		               	 	   		<input class="InputGrey" value="<%=vagueFunc(result[0][4],2)%>" maxlength="23" size=23 readonly>
		               	 	   	</td>
		               	 	   	<td class="blue">��������</td>
		               	 	   	<td>
		               	 	   		<input class="InputGrey" value="<%=result[0][5]%>" maxlength="23" size=23 readonly>
		               	 	   	</td>				               
			                </TR>				                		               
		              </TBODY>
			</table>       
		      	<table cellspacing=0>
			        <tbody> 
				          <tr> 
					      	    <td id="footer">
					    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
					    	      &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
					    	      &nbsp; 
					    	    </td>
				          </tr>
			        </tbody> 
		      </table>  
		</FORM>
		 <%@ include file="/npage/include/footer.jsp" %>
	</BODY>
</HTML>

<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-13 ҳ�����,�޸���ʽ
*
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
	String opCode = "1500";
  String opName = "�ۺ���Ϣ��ѯ֮�û�������Ϣ��ѯ";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String id_no  = request.getParameter("idNo");
	String phone_no  = request.getParameter("phoneNo");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	
	String pwrf = (String)request.getParameter("opwrf");
	String passFlag = (String)request.getParameter("opassFlag");
	System.out.println("gaopengSeeLog============pwrf="+pwrf);
	System.out.println("gaopengSeeLog============passFlag="+passFlag);
	String sql_str="select to_char(a.assure_no),assure_name,assure_id,assure_phone,assure_address,to_char(assure_num) from dAssuMsg a,dCustInnet b where a.assure_no=b.assure_no and b.id_no="+id_no;
	String perName = "";
	String perAddr = "";
	System.out.println("gaopengSeeLog============sql_str="+sql_str);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="6">
	<wtc:sql><%=sql_str%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%	
	/*2014/10/09 15:40:40 gaopeng R_CMI_HLJ_xueyz_2014_1864647@��������BOSS�;���ϵͳ�ͻ���Ϣģ����չʾ�ĺ���201409��
		ģ��������
	*/
	if("000000".equals(retCode1) && result != null && result.length != 0){
		 perName =  result[0][1];
		 perAddr =  result[0][4];
		if(!"true".equals(pwrf) && !"0".equals(passFlag)){
			perName = vagueFunc(perName,1);
			perAddr = vagueFunc(perAddr,2);
		}
		
	}
	else if(!retCode1.equals("000000")){
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
		rdShowMessageDialog("��ѯ���Ϊ��,�û�������Ϣ������!");
	</script>
<%
		return;
	}
%>

<HTML><HEAD><TITLE>������Ϣ</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dCustSimHis">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">������¼��Ϣ</div>
		</div>
    <table cellspacing="0">
      <tbody>
        <TR>
          <TD class="blue">����ID</td>
          <td><%=result[0][0]%></TD>
          <TD class="blue">����������</td>
          <td><%=perName %></TD>
          <TD class="blue">������ʶ</td>
          <td><%=result[0][2]%></TD>
        </TR>
        <TR>
          <TD class="blue">�����˵绰</td>
          <td><%=result[0][3]%></TD>
          <TD class="blue">�����˵�ַ</td>
          <td><%=perAddr %></TD>
          <TD class="blue">��������</td>
          <td><%=result[0][5]%></TD>
        </TR>
      </TBODY>
	  </TABLE>
         
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value=�ر�>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>

<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-12 ҳ�����,�޸���ʽ
*
********************/
%>
      
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String opCode = "1500";
  String opName = "�ۺ���Ϣ��ѯ֮�ͻ�������Ϣ";
	//������� �ͻ�ID���ͻ��������������š�����Ա����ɫ������
	String cust_id  = request.getParameter("custId");
	String cust_name  = request.getParameter("custName");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String recodeIDd=request.getParameter("recodeIDd");
	String sqlStr="select to_char(cust_id),sex_name,to_char(birthday,'yyyymmdd hh24 mi ss'),nvl(ltrim(rtrim(profession_name)),'NULL'),type_name,nvl(ltrim(rtrim(cust_love)),'NULL'),nvl(ltrim(rtrim(cust_habit)),'NULL') from dCustDocInAdd a,sSexCode b,sProfessionId c,sWorkCode d where a.cust_id="+cust_id+" and a.cust_sex=b.sex_code and a.profession_id=c.profession_id and d.region_code='0'||substr("+cust_id+",1,1) and a.edu_level=d.work_code";
	System.out.println("_________________________________________________");
	System.out.println(sqlStr);
	System.out.println("_________________________________________________");	
	/**
	ArrayList arlist = new ArrayList();
	try{
	 	S1100View callView = new S1100View();
		arlist = callView.view_spubqry32("7",sql_str);
	}
	catch(Exception e)
	{
		//System.out.println("����EJB����ʧ�ܣ�");
	}
	
	String [][] result = new String[][]{{"0","1","2","3","4","5","6"}};
	***/
%>
	
	<wtc:pubselect name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="7">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
		
<%
	if (result.length==0){
%>
			<script language="JavaScript">
				rdShowMessageDialog("�ͻ�������ϢΪ��!");
				history.go(-1);
			</script>
<%	
		return;
	}
%>

<HTML><HEAD><TITLE>�ͻ�������Ϣ</TITLE>
<script language="javascript">
	$(document).ready(function(){
		try{
			parent.parent.oprInfoRecode('','','','',"<%=recodeIDd%>");
		}catch(e){
		}
	});
</script>		
	
</HEAD>
<body>
<FORM method=post name="f1500_dCustDocInAdd">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�ͻ�������Ϣ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ͻ�����:<%=cust_name%></div>
		</div>
		
      <TABLE cellspacing=0>
        <TBODY>
          <TR>
            <td class="blue">�ͻ���ʶ</td>
            <td><%=result[0][0]%></td>
            <td class="blue">��&nbsp&nbsp&nbsp&nbsp��</td>
            <td><%=result[0][1]%></td>
            <td class="blue">��������</td>
            <td><%=result[0][2]%></td>
          </TR>
          <TR>
            <td class="blue">ְҵ����</td>
            <td><%=result[0][3]%></td>
            <td class="blue">ѧ&nbsp&nbsp&nbsp&nbsp��</td>
            <td colspan="3"><%=result[0][4]%></td>
          </TR>
          <TR>
            <td class="blue">�ͻ�ϰ��</td>
            <td colspan="5"><%=result[0][5]%></td>
          </TR>
          <TR>
            <td class="blue">�ͻ�����</td>
            <td colspan="5"><%=result[0][6]%></td>
          </TR>
        </TBODY>
	    </TABLE>
          
      <table cellspacing=0>
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
      <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

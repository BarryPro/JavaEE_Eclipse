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
  String opName = "�ۺ���Ϣ��ѯ֮�߽�����Ͷ����Ϣ";
	
	String region_code = ((String)session.getAttribute("orgCode")).substring(0,2);
	String cust_id=request.getParameter("idNo");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
String recodeIDd=request.getParameter("recodeIDd");
	String qrySql = "select VISIT_PROV_CODE, MSC_ID, LAC_ID, CELL_ID, PROV_CODE, PROV_DISTRCIT_NO, to_char(STATE_TIME,'yyyymmdd hh24:mi:ss'), to_char(START_TIME,'yyyymmdd hh24:mi:ss'), to_char(END_TIME,'yyyymmdd hh24:mi:ss')  from dRoamStateInfo  where phone_no = (select phone_no from dCustMsg where id_no =" + cust_id + ") order by STATE_TIME desc";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode1" retmsg="retMsg1" outnum="9">
	<wtc:sql><%=qrySql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
	if (!retCode1.equals("000000"))
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=retMsg1%><br>�������:<%=retCode1%>");
			history.go(-1);
		</script>
<%
		return;
	}else if(result==null||result.length==0){
%>
		<script language="JavaScript">
			rdShowMessageDialog("�߽�����Ͷ����Ϣ������!");
			history.go(-1);
		</script>
<%
		return;			
	}
%>

<HTML><HEAD><TITLE>�߽�����Ͷ����Ϣ</TITLE>
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
<FORM method=post name="f1500_custuser">
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�߽�����Ͷ����Ϣ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ͻ�����:<%=result[0][3]%></div>
		</div>
    <TABLE cellspacing="0">
      <TBODY>
        <TR align="center"> 
          <th>����ʡ����</th>
          <th>����MSC_ID</th>
          <th>����LAC_ID</th>
				  <th>����CELL_ID</th>
				  <th>������ʡ����</th>
				  <th>��;����</th>
				  <th>Ͷ��ʱ��</th>
          <th>ͨ����ʼʱ��</th>
          <th>ͨ������ʱ��</th>
        </TR>
<%	      
			String tbClass="";
			for(int y=0;y<result.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
%>
	        <tr align="center">
<%	        
				for(int j=0;j<result[0].length;j++){
%>
	          <td class="<%=tbClass%>"><%= result[y][j]%>&nbsp;</td>
<%	    
				}
%>
	        </tr>
<%	      
			}
%>
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
	</BODY>
</HTML>

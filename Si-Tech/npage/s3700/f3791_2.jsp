<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-------------------------------------------->
<!---����   2003-10-24                    ---->
<!---����   HYZ                           ---->
<!---����   f1500_Main                    ---->
<!---����   �ۺ���Ϣ��ѯ                  ---->
<!---�޸�   dengyuan @2008-05-19          ---->
<!-------------------------------------------->
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sitech.channelmng.PrdMgrSql" %>
<%@ page import="java.io.*" %>

<% 	
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String powerName = (String)session.getAttribute("powerCode");
	String orgCode = (String)session.getAttribute("orgCode");
	
	String regionCode = orgCode.substring(0,2);
  //������� ��ѯ���ͣ���ѯ�������������룬���ţ�Ȩ�޴��롣 
	String inStr  = request.getParameter("condText")==null?"":request.getParameter("condText");//�õ��������

	String opCode = "3791";
	String opName="�Ӵ��켣��ѯ";
	
		String result0= "";
		String result1= "";
		String result2= "";
		String result3= "";
		String result4= "";
		String result5= "";
		String result6= "";
		String result7= "";
		String result8= "";
		String result9= "";
		
 %>                    
	<wtc:service name="sQryCnttTrack" outnum="11">
		<wtc:param value="<%=inStr%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%    
System.out.println("_________________________________________________________________________");
	    for(int i=0;i<result.length;i++){
	      for(int j=0;j<result[i].length;j++){
	      System.out.println("############################result["+i+"]["+j+"]"+"   "+result[i][j]);
	      
	      }
	    
	    
	    }
System.out.println("_________________________________________________________________________");
	if (!retCode.equals("000000")){
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=retMsg%><br>������� '<%=retCode%>'��");
	history.go(-1);
</script>
<%
	}
		if (result.length==0){
%>
<script language="JavaScript">
	rdShowMessageDialog("�޴˼�¼��");
	history.go(-1);
</script>
<%
}else{
		result0=result[0][0];
		result1=result[0][1];
		result2=result[0][2];
		result3=result[0][3];
		result4=result[0][4];
		result5=result[0][5];
		result6=result[0][6];
		result7=result[0][7];
		result8=result[0][8];
		result9=result[0][9];
	}
	  
	
	%>


<HTML>
<HEAD>
<TITLE><%=opName%></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</HEAD>
<body>
<%@ include file="/npage/include/header.jsp"%>
<!-- �ͻ���Ϣ�� Start -->
<DIV class="title">	
  <div id="title_zi">�Ӵ��켣��Ϣ</div>	  
	  <div id="FormSub">
     </div>  
</DIV>
  <table align="center" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td class="Blue">�Ӵ�ID</td>
      <td> 
        <%=result0%>
        </td>
      <td class="Blue">�켣��ʶ</td>
      <td> 
       <b>         <%=result1%></b>
        </td>
         </tr>
    <tr > 
      <td class="Blue">�Ӵ��켣����</td>
      <td> 
           <%=result2%>
        </td>
   
      <td class="Blue">�Ӵ���ˮ��</td>
      <td> 
          <%=result3%>
        </td>
         </tr>
    <tr > 
      <td class="Blue">�Ӵ��켣����</td>
      <td> 
         <%=result4%>
      </td>
      <td class="Blue">IVR�ڵ���</td>
      <td> 
          <%=result5%>&nbsp;
	    </td>
	    </TR>
	    <TR >    
      <td class="Blue">�û�����ʱ��</td>
      <td> 
       <b>       <%=result6%></b>
       </td>
      <td class="Blue">�û������켣��Ҫ</td>
      <td >
	       <%=result7%>
	    </td>
	     </tr>
    <tr > 
      <td class="Blue">��ע</td>
      <td> 
          <%=result8%>
       </td>
      <td class="Blue">�켣����</td>
        <td> 
         <%=result9%>&nbsp;
       </td>
    </TR>
  </table>
	<!-- ������ End -->
<!-- �ͻ���Ϣ�� End -->



<table  border=0  cellpadding=0 cellspacing=0>
  <tr > 
    <td id="footer">
      &nbsp; <input   class="b_foot" name=back onClick="parent._exttabref.removeTab('<%=opCode%>')" type=button value="�ر�">
      &nbsp; 
    </td>
  </tr>
</table>
	<%@ include file="/npage/include/footer.jsp"%>
</BODY></HTML>
<!--***********************************************************************-->

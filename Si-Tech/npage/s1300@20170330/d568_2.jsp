<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "d568";
    String opName = "�����ն˽ɷ���Ϣ��ѯ���";
	  String check_code=request.getParameter("check_code");
	  String check_no=request.getParameter("check_no");
	  String loginno=request.getParameter("loginno");
	  String phoneno=request.getParameter("phoneno");
	  //��ʼ ����
	  String print_begin = request.getParameter("print_begin");
	  String print_end = request.getParameter("print_end");
	  String ret_val[][];
	  String ret_val_new[][];
	  int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 10;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;
		int recordcount=0;
	
 
		
 
 
 

//ƴ��sql ʹ��stringBuffer where 1=1 and~~   sbuffer.append("");
/*
��ƣ� ����Ӧ����forѭ��,�ֱ�ȡ��ÿ���µķֱ�ļ�¼��Ȼ��չ��?
	   forѭ���������� YYYYMMȡ��������
	   for(k=vBeginTime;k<=vEndTime;)
*/
int iBegin = Integer.parseInt(print_begin);
int iEnd = Integer.parseInt(print_end);
int vYear=0;
int vMonth = 0;
vYear = iBegin/100;
vMonth=iBegin%100;	
int k = 0;



 
%>
   
	 
 
<script language = "javascript">
	function toExcel(){
		 var oXL = new ActiveXObject("Excel.Application"); 
	���� var oWB = oXL.Workbooks.Add(); 
	���� var oSheet = oWB.ActiveSheet; 
	���� var Lenr = PrintA.rows.length;
	���� for (i=0;i<Lenr;i++) 
	���� { 
	���� var Lenc = PrintA.rows(i).cells.length; 
	���� for (j=0;j<Lenc;j++) 
	���� { 
	���� oSheet.Cells(i+1,j+1).value = PrintA.rows(i).cells(j).innerText; 
	���� } 
	���� } 
	���� oXL.Visible = true; 
	}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>�����ն˲�ѯ���</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>

      <table cellspacing="0" id = "PrintA">
                <tr> 
                  <th>��Ʊ����</th>
				  <th>��Ʊ����</th>
                  <th>�ն˱��(�豸��)</th> 
				  <th>������</th>
				  <th>������ˮ</th>
				  <th>��������</th>
				  <th>���Ѻ���</th>
				  <th>Ʒ��</th>
				  <th>�ͻ�����</th>
				  <th>���ѽ��(��д)</th>
				  <th>���ѽ��(Сд)</th>
				  <th>ԭ�������</th>
				  <th>���ν�����</th>
				  <th>�������</th>
				  <th>δ���ʻ���</th>
				  <th>��ǰ�������</th>
				  <th>Э�����</th>
				  <th>���п�����</th>
				  <th>�����ο���</th>
				  <th>���������</th>
				  <th>�ն˺�</th>
				  <th>�̻���</th>
				  <th>ͳһԤ��������Ϣ����</th>
				  <th>��ע��Ϣ</th>
				  <th>��ӡʱ��</th>
				  <th>��ӡ�ص�</th>
				  <th>��Ʊ���ͱ�ʶ(01:�ֽ𽻷�;02:ͳһԤ������;03:���п��ɷ�)</th>
				  <th>��Ʊ���ݼ�¼����</th>
				  <th>������ע��Ϣ</th>
				  
                </tr>
<%
for(k=iBegin;k<=iEnd;  )
{
		
	StringBuffer sbuffer = new StringBuffer();
	sbuffer.append(" select * from DBSELFADM.TD_PTL_LOG_INVOICEPRINT");	 
	sbuffer.append(k);
	//sbuffer.append("201105");
	sbuffer.append(" where 1 =1 ");
	//ƴ�Ӳ�ѯ����
	//��Ʊ����
	if((check_code!=null) && !(check_code.equals(""))){
		sbuffer.append(" and INVOICE_CODE = "+"'"+check_code+"'" );
	}
	//��Ʊ����
	if((check_no!=null) && !(check_no.equals(""))){
		sbuffer.append(" and INVOICE_NO = "+"'"+check_no+"'" );
	}
	//������
	if((loginno!=null) && !(loginno.equals(""))){
		sbuffer.append(" and LOGIN_NO = "+"'"+loginno+"'" );
	}
	//�ɷѺ���
	if((phoneno!=null) && !(phoneno.equals(""))){
		sbuffer.append(" and PHONE_NO = "+"'"+phoneno+"'" );
	}
	//System.out.println("\n11111111111111111111111111111111111111111tets the sql is \n"+sbuffer.toString());
	%>
	<script>
	//	alert("sql is "+"<%=sbuffer.toString()%>");
	</script>
	<%
		vMonth++;
		if(vMonth==13)
		{
			vYear++;
			vMonth=1;
		}
		k=vYear*100+vMonth;
    //xl ����ֱ��ѯ~~
%>
<wtc:pubselect name="TlsPubSelCrm"   retcode="retCode2" retmsg="retMsg2" outnum="29">
	<wtc:sql><%=sbuffer.toString()%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="ret_val3" scope="end" />
	<%
		ret_val_new =ret_val3 ;
		 
	 //�޷����ɲ�ѯ�޽������ʾ ��Ϊ�ǶԷֱ��ѭ����ѯ �޷��ж��Ƿ��޼�¼~~
for(int y=0;y<ret_val_new.length;y++)
	      {
	
%>
	        <tr>
<%    	        for(int j=0;j<ret_val_new[0].length;j++)
	        {
				
			 
					%>				  
	              <td><%= ret_val_new[y][j]%></td>
<%
				 
	        }
%>
	        </tr>
<%	      
		}
 
	 
	//xl end����ֱ��ѯ

}
//end ѭ��

%>

         
          <tr id="footer"> 
      	    <td colspan="9">
    	      <input class="b_foot" name=back onClick="window.location = 'd568.jsp?activePhone=<%=phoneno%>' " type=button value=����>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
			  <input class="b_foot" name=back onClick="toExcel();" type=button value=����EXCEL>
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>


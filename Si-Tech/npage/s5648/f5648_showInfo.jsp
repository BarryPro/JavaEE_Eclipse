<%
   /*���ƣ�SI������ϵ��ѯ - EC�����û���ѯ
�� * �汾: v1.0
�� * ����: 2007/2/9
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	
	String op_name = "EC�����û���ѯ";
	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

%>

<%
	boolean nextFlag = false;
	
	String idno = request.getParameter("idno");
	
	System.out.println("idno = " + idno);

	/********************* ������� *************************/
	String[][] phoneNo     	= new String[][]{};   //���˳�Ա����
	String[][] custName   	= new String[][]{};   //���˿ͻ�����
	String[][] vBeginTime  	= new String[][]{};   //����ʱ��    
	String[][] vRunCode    	= new String[][]{};   //��ǰ״̬    
	String[][] vRunName  		= new String[][]{};   // ��������    
	String[][] vIdNum       = new String[][]{};   // ֤������    
	/******************************************************/
		
%>
    <wtc:service name="sQryECMebEXC" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="6" >
    	<wtc:param value="<%=idno%>"/>
    </wtc:service>
	<wtc:array id="phoneNo"    start="0" length="1" scope="end"/>
	<wtc:array id="custName"   start="1" length="1" scope="end"/>
	<wtc:array id="vBeginTime" start="2" length="1" scope="end"/>
	<wtc:array id="vRunCode"   start="3" length="1" scope="end"/>
	<wtc:array id="vRunName"   start="4" length="1" scope="end"/>
	<wtc:array id="vIdNum"     start="5" length="1" scope="end"/>
    						 
<%	
  if("000000".equals(errCode))
 	{
 		nextFlag = true;
		    
		if(phoneNo.length == 0)
		{			
		nextFlag = false;
%>
			<script language='jscript'>
				rdShowMessageDialog("û�в鵽��ؼ�¼��");
				window.close();
			</script>
<%  
		}	 	
	}else
    {
%>        
		  <script language='jscript'>
	          rdShowMessageDialog("������Ϣ��<%=errMsg%>",0);
	          window.close();
	    </script>         
<%            
    }
%>

<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
</head> 
<%if(nextFlag)
{	
%>
<body >

<form name="form1" method="post" action="">	
<input type="hidden" name="OprCode" value="05" >
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">SI������ϵ��ѯ</div>
</div>
        
		<TABLE cellSpacing=0>
	         </TR> 	         
             <TR id="line_1">
             	<TD >���˳�Ա����</TD>
				<TD >���˿ͻ�����</TD>
	            <TD >����ʱ��    	</TD> 	         								    		            	              
	            <TD >��ǰ״̬    	</TD> 	         								    		            	              
	            <TD >��������    	</TD> 	         								    		            	              
	            <TD >֤������    	</TD> 	         								    		            	              
	         </TR>
	         
	         <%
	         for(int i=0;i<phoneNo.length;i++)
	         {
	         %>
	          <TR id="line_1"> 
	          	<TD ><%=phoneNo[i][0]%></TD>
	          	<TD ><%=custName[i][0]%></TD>
	          	<TD ><%=vBeginTime[i][0]%></TD>
	          	<TD ><%=vRunCode[i][0]%></TD>
	          	<TD ><%=vRunName[i][0]%></TD>
	          	<TD ><%=vIdNum[i][0]%></TD>
	         </TR>
	        <%}%>
	         
		</TABLE>	       
		
 
		<TABLE cellSpacing=0>
			 <TR> 
	         	<TD id="footer"> 		      
	         	    <input name="backBtn" style="cursor:hand" type="button" class="b_foot" value="����" onClick="javascript:window.close()">	         	    	         	     		         	     	         	   
			 	</TD>
	       </TR>
	    </TABLE>	   	
	   	
	</div>	 
</form>
</body>
<%}%>
</html>


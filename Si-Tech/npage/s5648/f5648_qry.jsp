<%
   /*���ƣ�SI������ϵ��ѯ - test:  cl32 sQrySIECMsg 2 7 parterId operId
�� * �汾: v1.0
�� * ����: 2007/2/9
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-24    qidp        �°漯�Ų�Ʒ����
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
	
	String opCode = "5648";
	String opName = "SI������ϵ��ѯ";
	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

	boolean nextFlag = false;
	
	String operId = request.getParameter("operId");
	String parterId = request.getParameter("parterId");
	String trId = request.getParameter("trId");
	String checkdocId = request.getParameter("trId");
	
	System.out.println("operId = " + operId);
	System.out.println("parterId = " + parterId);
	System.out.println("checkdocId = " + checkdocId);
	
	String paramsIn[] = new String[2];	 	
 	paramsIn[0] = parterId;
 	paramsIn[1] = operId;
	
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
		
	ArrayList acceptList = new ArrayList();
		   
	//acceptList = callView.callFXService("sQrySIECMsg", paramsIn, "11","region", regionCode);
	
	String errCode = "";
	String errMsg = "";
	try{
    %>
        <wtc:service name="s5648SiecEXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
        	<wtc:param value="<%=opCode%>"/>
        	<wtc:param value="<%=workNo%>"/> 
        	<wtc:param value="<%=paramsIn[0]%>"/>
        	<wtc:param value="<%=paramsIn[1]%>"/> 
        </wtc:service>
        <wtc:array id="retArr1" scope="end"/>
    <%
        errCode = retCode1;
        errMsg = retMsg1;
        
        if("000000".equals(errCode)){
            nextFlag = true;
            if(retArr1.length>0){
                result = retArr1;
            }else{
                nextFlag = false;
                %>        
                    <script language='jscript'>
                        rdShowMessageDialog("û�в鵽��ؼ�¼��",0);
                        window.close();
                    </script>         
                <%
            }
        }else{
            %>        
                <script language='jscript'>
                    rdShowMessageDialog("������Ϣ��<%=errMsg%>",0);
                    window.close();
                </script>         
            <%
        }
    }catch(Exception e){
        e.printStackTrace();
        %>        
            <script language='jscript'>
                rdShowMessageDialog("���÷���ʧ�ܣ�",0);
                window.close();
            </script>         
        <%
    }

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script>
//��ʾĳ��ҵ����Ϣ
	function showInfo(v_id)
	{  
        var str = "?idno=" + v_id;
        var path="f5648_showInfo.jsp" + str;
				window.open(path,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}
</script>
</head> 

<%if(nextFlag)
{	
%>
<body>
<form name="form1" method="post" action="">	
<input type="hidden" name"OprCode" value="05" >
<input type="hidden" name="parterId" value="">
<input type="hidden" name="checkdocId" value="">
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">SI������ϵ��ѯ</div>
</div>
		<TABLE cellSpacing=0 align="center">      
             <TR id="line_1">
                <Th align='center'>���ſͻ�����</Th>
                <Th align='center'>���ſͻ�����</Th>
                <Th align='center'>��Ʒ����</Th> 	         								    		            	              
                <Th align='center'>��Ʒ�˺�</Th> 	         								    		            	              
                <Th align='center'>��Ʒ���� </Th> 	         								    		            	              
                <Th align='center'>���ŷ������</Th> 	         								    		            	              
                <Th align='center'>ҵ��״̬</Th> 	         								    		            	              
                <Th align='center'>�ͻ�������</Th> 	         								    		            	              
                <Th align='center'>��ϵ�绰</Th> 	         								    		            	              
                <Th align='center'>��ʼʱ��</Th> 	         								    		            	              
                <Th align='center'>����ʱ��</Th> 	         								    		            	              
	         </TR>
	         
	         <%
	         for(int i=0;i<result.length;i++)
	         {
	         %>
	          <TR id="line_1" align='certer'> 
	          	<TD align='center'><%=result[i][0]%></TD>
	          	<TD align='center'><%=result[i][1]%></TD>
	          	<TD align='center'><%=result[i][2]%></TD>
	          	<TD align='center'><%=result[i][3]%></TD>
	          	<TD align='center'><%=result[i][4]%></TD>
	          	<TD align='center'><%=result[i][5]%></TD>
	          	<TD align='center'><%=result[i][6]%></TD>
	          	<TD align='center'><%=result[i][7]%></TD>
	          	<TD align='center'><%=result[i][8]%></TD>
	          	<TD align='center'><%=result[i][9]%></TD>
	          	<TD align='center'><%=result[i][10]%></TD>
	         </TR>
	        <%}%>
	         
		</TABLE>	       
		
 
		<TABLE cellSpacing=0>
			 <TR id="footer"> 
	         	<TD> 		      
	         	    <!--<input name="backBtn" style="cursor:hand" type="button" class="b_foot" value="����" onClick="javascript:window.location='f5648_qrydParterOperation.jsp?parterId='+parterId+'checkdocId='+checkdocId ">         	    	         	     		         	     	         	   
			 	-->
			 	<input name="backBtn" style="cursor:hand" type="button" class="b_foot" value="����" onClick="javascript:self.close();">  
			 	</TD>
	       </TR>
	    </TABLE>	   	
	   	
	</div>	
</form>
</body>
<%}%>
</html>


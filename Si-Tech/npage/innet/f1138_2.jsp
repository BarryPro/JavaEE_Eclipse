

<% request.setCharacterEncoding("GB2312");%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page contentType= "text/html;charset=gb2312" %>



<%
/*
   ���������������ˮ �������� �������� ��������
   ���������������� ������Ϣ
*/
	//Logger logger = Logger.getLogger("f1138_2.jsp");

    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
        String sIn_Login_no = (String)session.getAttribute("workNo");
        String sIn_Org_code = (String)session.getAttribute("orgCode");
        String regionCode= (String)session.getAttribute("regCode");
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
 
	String sIn_Open_Accept = request.getParameter("sysAccept");       /* ������ˮ      */
	String sIn_Op_code = "1138";                                       /* ��������      */    

    String ret_code = "";      
    String retMessage = "";	
 	try              
 	{    
 	%>
 	     <wtc:service name="sInvoiceInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="s1223CfmCode" retmsg="s1223CfmMsg" outnum="21" >               
        <wtc:param value="<%=sIn_Open_Accept%>"/>
        <wtc:param value="<%=sIn_Org_code%>"/>
        <wtc:param value="<%=sIn_Login_no%>"/>
        <wtc:param value="<%=sIn_Op_code%>"/>
    </wtc:service>
    <wtc:array id="result" scope="end" />
 	<%                   		

    		ret_code =s1223CfmCode;      
    		retMessage =s1223CfmMsg;
     	}catch(Exception e){
       		//logger.error("Call sunView(sInvoiceInfo) is Failed!");
     	}

        
		if((ret_code.trim()).compareTo("000000") == 0)
		{
%>
            <script language='jscript'>
                rdShowMessageDialog("��Ʊ����ɹ���",2);
                location = "f1138_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
            </script>            
<%		}else
        {
%>
            <script language='jscript'>
                rdShowMessageDialog("<%=retMessage%>" + "[" + "<%=ret_code%>" + "]" ,0);
                history.go(-1);
            </script>
<%        
        }
%>
<%
   /*���ƣ����ſͻ���Ŀ���� - �鿴
�� * �汾: v1.0
�� * ����: 2007/2/7
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-17    qidp        �°漯�Ų�Ʒ����
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	String[][] colNameArr = new String[][]{};
	 
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String grpParamSet="";
    String grpParamSetName="";
	
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	
	String opCode = "4914";
	String op_name = "��Ա��Ϣ��ѯ";
	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

%>

<%
	String operId = request.getParameter("operId");	
	
	System.out.println("operId = " + operId);
	
	try{
	//acceptList = callView.sPubSelect("5",sqlStr);
	
	%>
        <wtc:service name="s4914EXCQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="30" >
        	<wtc:param value="<%=opCode%>"/>
            <wtc:param value="<%=workNo%>"/>
        	<wtc:param value="<%=operId%>"/>
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%
    

        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++"+retCode);
	    if("000000".equals(retCode.trim()) && retArr.length>0){
	            colNameArr = retArr;
	            System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++yanpx");
	 
	               
			if (colNameArr != null)
			{
				if (colNameArr[0][0].equals("")) 
				{
					colNameArr = null;
					System.out.println("colNameArr = null");
				}
			}	    
		    
			    
	      if(colNameArr==null || colNameArr.length == 0)
	     	{
	     	System.out.println("colNameArr = null");
	    %>
	    			<script language='jscript'>
	    				rdShowMessageDialog("û�в鵽��ؼ�¼��",0);
	    				window.close();
	    			</script> 
	    <%
	       }

       %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head> 

<body>
	<div id="Operation_Table">	
		<table id="tabList" cellspacing=0>			
			<tr bgcolor="#F5F5F5">				
				<th>�ֻ�����</th>
				<th>�ͻ�����</th>				
				<th>����״̬</th>				
			    <th>���ű���</th>
				<th>����ʱ��</th>				
			</tr>
	<%	if(colNameArr!=null){
		for(int i = 0; i < colNameArr.length; i++)
		{
	%>			
			<tr>				
				<td nowrap><%=colNameArr[i][0].trim()%></td>
				<td nowrap><%=colNameArr[i][1].trim()%></td>				
				<td nowrap><%=colNameArr[i][2].trim()%></td>			
			    <td nowrap><%=colNameArr[i][3].trim()%></td>
				<td nowrap><%=colNameArr[i][4].trim()%></td>		
			</tr>
	<%
		}}	%>				
		</table>
				
	</div>   

</body>
</html>
<%
}
else if(!retCode.trim().equals("000000"))
        {
        System.out.println("++++++++++++++++++++++++++++++++++++++++++++111+++++retArr.length="+retArr.length);
        System.out.println("++++++++++++++++++++++++++++++++++++++++++++111+++++retCode="+retCode);
        System.out.println("++++++++++++++++++++++++++++++++++++++++++++111+++++retMsg="+retMsg);
    %>
    			<script language='jscript'>
    				rdShowMessageDialog("������룺<%=retCode%>,������Ϣ��"+"<%=retMsg%>",0);
    				window.close();
    			</script> 
    <%        	
        }	
       }catch(Exception e){
            e.printStackTrace();
    %>
    			<script language='jscript'>
    				rdShowMessageDialog("��ѯ��Ϣʧ�ܣ�",0);
    				window.close();
    			</script> 
    <%
       }
    %>

<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-07
 *update:tangsong@2010-12-30 ҳ����ʽ����,�����û���Ϣҳ
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
 <%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
 <%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>

<%@ page import="java.util.*"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
    String opCode = "1528";
    String opName = "������Ϣ��ѯ";
    String phoneNo =  request.getParameter("phoneNo");
 
	   
	String beginTime =  request.getParameter("beginDate");
	String endTime =    request.getParameter("endDate");
    String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code = org_code.substring(0,2);
	String busy_name="";
    
        	
        
 
	String op_code = "1528";
	busy_name="������Ϣ";
	// tianyang �޸� 20090818
	//ArrayList arlist = new ArrayList();
	String inParas[] = new String[3];
	inParas[0] = phoneNo;
	inParas[1] = beginTime;
	inParas[2] = endTime;
     //0 ����, 1 ����
System.out.println("inParas[0]==="+inParas[0]);
System.out.println("inParas[1]==="+inParas[1]);
System.out.println("inParas[2]==="+inParas[2]);
 
%>


<wtc:service name="sPhonePayNew" routerKey="phone" routerValue="<%=phoneNo%>" retcode="sConMoreQryCode" retmsg="sPhoneQueryPayMsg" outnum="19">
    <wtc:param value="<%=inParas[0]%>"/> 
    <wtc:param value="<%=inParas[1]%>"/>
    <wtc:param value="<%=inParas[2]%>"/>
 
</wtc:service>
<wtc:array id="sConMoreQryArr0" start="0"  length="6"  scope="end" /> 
<wtc:array id="sConMoreQryArr1" start="6"  length="12"  scope="end" /> 
<%
	//arlist  = value.getList();
 
  
	String[][] result = new String[][]{}; 
 
	//result2 ��ʾ������ֵ
	String[][] result2 = new String[][]{};
 
 
	
	//result = (String[][])arlist.get(0);
	String return_code = sConMoreQryCode;
	String return_msg = sPhoneQueryPayMsg;

if (sConMoreQryArr0.length > 0)
  	result2 = sConMoreQryArr0;	
//System.out.println("666666666666 result2.length is "+result2.length+" and result2[0][1] is "+result2[0][1]);	 
%>


 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>



<title>������Ϣ��ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>

<BODY>
<FORM action="" method="post" name="form">
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">�ɷѼ�¼��Ϣ���</div>
</div>
		<table cellspacing="0">
		 <tr>
			<td>�ɷѴ�����</td>
			<td><%=result2[0][1]%></td>
			<td>�ɷѽ�</td>
			<td><%=result2[0][2]%></td>
		 </tr>
		 <tr>
			<td>����Ƿ�ѣ�</td>
			<td><%=result2[0][3]%></td>
			<td>�������ɽ�</td>
			<td><%=result2[0][4]%></td>
		 </tr>
		 <tr>
			<td>���������ѣ�</td>
			<td><%=result2[0][5]%></td>
			<td colspan="2">&nbsp;</td>
		 </tr>
		 </table>
		 <table cellspacing="0">
		  <tr> 
            <th nowrap> 
              <div align="center">����</div>
            </th>
            
			<th nowrap> 
              <div align="center">�ɷ�ʱ��</div>
            </th>
			<th nowrap> 
              <div align="center">�ɷѵص�</div>
            </th>
            <th nowrap> 
              <div align="center">�ɷѷ�ʽ</div>
            </th>
            <th nowrap> 
              <div align="center">�ɷѽ��</div>
            </th>
            <th nowrap> 
              <div align="center">��������</div>
            </th>                        
            <th nowrap> 
              <div align="center">����Ԥ��</div>
            </th>
            <th nowrap> 
              <div align="center">Ƿ��</div>
            </th>
			<th nowrap> 
              <div align="center">���ɽ�</div>
            </th>
			 
			<th nowrap> 
              <div align="center">��������</div>
            </th>
			
			<th nowrap> 
              <div align="center">������ˮ��</div>
            </th>           
          </tr>
		   <% 
		   if (sConMoreQryArr1.length > 0)
  	result = sConMoreQryArr1;
		//System.out.println("tttttttttttttt1111111111111111111111111111result.length is  "+result.length+" and sConMoreQryArr1.length is "+sConMoreQryArr1.length);	 
		   for(int i = 0;i<result.length;i++ )
			  { %>
                <tr> 
                    <td  ><%=result[i][0]%></td>
                    
                    <td  ><%=result[i][2]%></td>
                    <td  ><%=result[i][3]%></td>
                    <td  ><%=result[i][4]%></td>
                    <td  ><%=result[i][5]%></td> 
                    <td  ><%=result[i][6]%></td>
                    <td  ><%=result[i][7]%></td>
                    <td  ><%=result[i][8]%></td>
                    <td  ><%=result[i][9]%></td>
                     						
                    <td  ><%=result[i][11]%></td>
					
					<td  ><%=result[i][1]%></td>
                </tr>
		<% } %>
        </table>
        

<!------------------------>
	
<%@ include file="/npage/include/footer.jsp" %>
</Form>
 
</body>
</html>



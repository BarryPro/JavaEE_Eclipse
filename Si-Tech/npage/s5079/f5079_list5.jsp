<%
   /*
   * ����: ���Ű���Ŀ��Ѳ�ѯ - �б�(ȫ������)
�� * �汾: v1.0
�� * ����: 2012/5/25
�� * ����: diling
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.DecimalFormat"%>


<%	
  //���Ƹ�ʽ
	DecimalFormat df = new DecimalFormat("#.00");
	//��ȡ�û�session��Ϣ
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));              //����
	String password  = WtcUtil.repNull((String)session.getAttribute("password"));  //��½����
	String regCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));

	String QryValues = request.getParameter("turnValue");
	String QryFlag = request.getParameter("QryFlag");             
	String QryValues1 = request.getParameter("QryValues"); 
	String idNo = request.getParameter("idNo"); 
	System.out.println("--------------5079-------QryValues5="+QryValues1);   
	System.out.println("--------------5079-------QryFlag="+QryFlag);  
	System.out.println("--------------5079-------turnValue="+QryValues);  
	System.out.println("--------------5079-------idNo="+idNo);  
	                  
	String[][] result = new String[][]{};
	Logger logger = Logger.getLogger("f5079_list5.jsp");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
<%
	
	ArrayList acceptList = new ArrayList();
	String paraArr[] = new String[9];
	paraArr[0] = printAccept;
	paraArr[1] = "01";
	paraArr[2] = "5079";
	paraArr[3] = workNo;
	paraArr[4] = password;
	paraArr[5] = "";
	paraArr[6] = "";
	paraArr[7] = QryValues1;
	paraArr[8] = idNo;
	
	String errCode = "";
	String errMsg = "";
	try{
    	%>
            <wtc:service name="s5079GrpConUser" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="6" >
            	<wtc:param value="<%=paraArr[0]%>"/>
            	<wtc:param value="<%=paraArr[1]%>"/> 
              <wtc:param value="<%=paraArr[2]%>"/> 
              <wtc:param value="<%=paraArr[3]%>"/> 
              <wtc:param value="<%=paraArr[4]%>"/> 
              <wtc:param value="<%=paraArr[5]%>"/> 
              <wtc:param value="<%=paraArr[6]%>"/> 
              <wtc:param value="<%=paraArr[7]%>"/> 
              <wtc:param value="<%=paraArr[8]%>"/>
            </wtc:service>
            <wtc:array id="retArr1" scope="end"/>
        <%
            errCode = retCode1;
            errMsg = retMsg1;
            System.out.println("-------------5079-------errCode="+errCode);
            if("000000".equals(errCode)){
                if(retArr1.length>0){
    	            result = retArr1;
    	          }else{
    	            %>
        	            <script type=text/javascript>
        	                rdShowMessageDialog("û���������!",0);
        	            </script>
        	        <%
    	          }
            }else{
	            %>
    	            <script type=text/javascript>
    	                rdShowMessageDialog("������룺<%=errCode%>,������Ϣ��<%=errMsg%>",0);
    	            </script>
    	        <%
            	System.out.println("# return from f5079_list5.jsp by s5079GrpConUser -> retCode = " + errCode);
            	System.out.println("# return from f5079_list5.jsp by s5079GrpConUser -> retMsg  = " + errMsg);
	          }
    }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("���÷���s5079GrpConUserʧ�ܣ�",0);
            </script>
        <%
        e.printStackTrace();
    }
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	var oldrow = -1;
	var nowrow = -1;

	//�����ĳ�д�����
	function rowClick(objname,flag){
		var o = eval(objname);
		if(flag == 1)
			o.className = "opened";
		else
			o.className = "unopen";
	}
	
	//����Ƶ�ĳ��
	function rowMouseOver(node){
		if(node.className != "opened")
			node.className = "mouseover";
	}
	
	//����Ƴ�ĳ��
	function rowMouseOut(node){
		if(node.className != "opened")
			node.className = "unopen";
	}
	
	//�����ĳ��
	function trfunc1(node){
		nowrow = parseInt(node.id.substring(3,node.id.length));  
		if(oldrow != nowrow){
			if(oldrow != -1) 
				rowClick("row" + oldrow,0);
			rowClick("row" + nowrow,1);
			oldrow = nowrow;
		}
	}
		function printxlslist(){
			window.open("f5079_print5xls.jsp?turnValue=<%=QryValues%>&QryFlag=<%=QryFlag%>&QryValues=<%=QryValues1%>&idNo=<%=idNo%>");
	}
	
</script>
</head>

<body>
<div id="Operation_Table" >
<table cellspacing="0">
    <tr>
			<td colspan="6"><input type="button" name="printxls" class="b_text" value="����ΪXLS���" onclick="printxlslist()"/></td>
		</tr>
    <tr>
        <th>����</th>
        <th>���ű���</th>
        <th>��������</th>
        <th> �����ʺ�</th>
        <th>������Ŀ��</th>
        <th>���ѳ�Ա����</th>
    </tr>
<%
		if("000000".equals(errCode)){
		System.out.println("------------2222222222222222222-----------");
  		for(int i = 0; i < result.length; i++)
  		{	
  			String tdClass = "";
              if (i%2==0){
                  tdClass = "Grey";
              }
  %>
  		<tr>
  			<td class="<%=tdClass%>"><%=result[i][0]%></td>
  			<td class="<%=tdClass%>"><%=result[i][1]%></td>
  			<td class="<%=tdClass%>"><%=result[i][2]%></td>
  			<td class="<%=tdClass%>"><%=result[i][3]%></td>
  			<td class="<%=tdClass%>"><%=result[i][4]%></td>		
  			<td class="<%=tdClass%>"><%=result[i][5]%></td>		
  		</tr>
  <%
  		}
	}	
%>	
</table>
<div>
</body>
</html>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String opCode = "5082";
	String opName = "������Ϣ��ѯ";
	
    //input param
	String contract_no = request.getParameter("selected_contract_no"); //�˺�	
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();  //����wtc����
	
	String paramsIn1[] = new String[1];
	paramsIn1[0]=contract_no;
	
	ArrayList acceptList = new ArrayList();
	
	//acceptList = callView.callFXService("sQryGrpBill6s", paramsIn1, "13");	
	//callView.printRetValue();
	int recordNum=0;
	String errCode = "";
	String errMsg = "";
    String prepay_fee1 = "";
	String owe_fee1="";
	String[][] result = new String[][]{};
	
	try{
	%>
    	<wtc:service name="sGrpBill6EXC"  outnum="13" retcode="retCode1" retmsg="retMsg1" routerKey="region" routerValue="<%=regionCode%>">
    	    <wtc:param value="<%=paramsIn1[0]%>" />
    	</wtc:service>
    	<wtc:array id="retArr1" scope="end"/>
    <%
	    errCode = retCode1;
	    errMsg = retMsg1;
	    
	    if("000000".equals(errCode) && retArr1.length>0){
	        result = retArr1;
	        recordNum     =  result.length;
    		prepay_fee1 = result[0][11];
    		owe_fee1 = result[0][12];
	    }else{
	        %>
        	<script>
        		rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
        	    window.close();
        	</script>
		    <%
	    }
	 }catch(Exception e){
	    e.printStackTrace();
	    %>
        	<script>
        		rdShowMessageDialog("���÷���sQryGrpBill6sʧ�ܣ�" ,0);
        	    window.close();
        	</script>
        <%
	 }
	//int errCode = callView.getErrCode();
	//String errMsg = callView.getErrMsg();
  //output param
	
%>              
                
<html xmlns="http://www.w3.org/1999/xhtml">         
<head>          
<title>���ſͻ��ʵ��б�</title>
</head>
<BODY>
<FORM method=post name="fPubSimpSel">   
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">���ſͻ��ʵ��б�</div>
</div>
<table cellspacing=0>
    <TR> 
        <td class='blue' nowrap width='15%'>��ǰʣ����</TD>
        <TD><%=prepay_fee1%></TD>
        <td class='blue' nowrap width='15%'>Ƿ�ѽ��</TD>
        <TD><%=owe_fee1%></TD>
    </TR>
</TABLE>
<table cellspacing=0>
<tr>
	<TH>���ſͻ�ID</TH>
	<TH>���ſͻ�����</TH>
	<TH>��Ʒ����</TH>
	<TH>��Ʒ�ʺ�</TH>
	<TH>��Ʒ����</TH>
	<TH>��Ʒ����</TH>
	<TH>��ʼʱ��</TH>
	<TH>����ʱ��</TH>
	<TH>Ӧ�����</TH>
	<TH>�Żݽ��</TH>
</TR> 
<% 
    for (int i = 0;i < recordNum; i++) {
%>
    <tr> 
        <td><%=result[i][9]%></td>
        <td><%=result[i][1]%></td>
        <td><%=result[i][10]%></td>
        <td><%=result[i][0]%></td>
        <td><%=result[i][3]%></td>
        <td><%=result[i][4]%></td>
        <td><%=result[i][5]%></td>
        <td><%=result[i][6]%></td>	  
        <td><%=result[i][7]%></td>	  
        <td><%=result[i][8]%></td>	  
    </tr>
<%
    }
%>
</table>
<!------------------------------------------------------>
<table cellspacing=0>
    <TR id="footer"> 
        <TD>
           <input class="b_foot" name=commit onClick="window.close()" style="cursor:hand" type=button value=�ر�>
        </TD>
    </TR>
</TABLE>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>    

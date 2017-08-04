<%
    /*************************************
    * ��  ��: �����Ϣ��ѯ��� 3690
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-11-26
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.GregorianCalendar"%>
<%
	String opName = "�����Ϣ��ѯ���";
	
	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));

	String prodCode = WtcUtil.repNull((String)request.getParameter("prodCode"));//��Ʒ����
	String cust_id = WtcUtil.repNull((String)request.getParameter("cust_id"));//���ſͻ�ID
	/*��������*/
	prodCode = "13053955248";
	cust_id = "13006422016";
	
	String strDate = "";
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	GregorianCalendar cal = new GregorianCalendar();
	cal.setTime(new Date());
	
	strDate = sdf.format(cal.getTime());
	
	cal.add(GregorianCalendar.MONTH, 1);
	strDate = sdf.format(cal.getTime());
	strDate = strDate.substring(0,6)+"01";
	
  String[][] result = new String[][]{};
	String paraArr[] = new String[3];
	paraArr[0] = prodCode;
	paraArr[1] = loginNo;
	paraArr[2] = cust_id;
	
%>
  <wtc:service name="s3518QryIDEXC" retcode="retCode" retmsg="retMsg" outnum="13" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:param value="<%=paraArr[0]%>"/>
    <wtc:param value="<%=paraArr[1]%>"/> 
    <wtc:param value="<%=paraArr[2]%>"/> 
  </wtc:service>
  <wtc:array id="retArr" scope="end"/>
<%
	String errCode=retCode;   
	String errMsg=retMsg; 
			
    if("000000".equals(errCode))
    {
        result = retArr;
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>
<body>
<form>	
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
      <table cellspacing="0" id="tab1">
					<tr>
						<th  align="center">��Ʒ����</th>
						<th  align="center">��Ʒ����</th>
						<th  align="center">�������</th>
						<th  align="center">��������</th>
						<th  align="center">ԭʼ�۸�</th>
						<th  align="center">�������</th>
						<th  align="center">��ʼʱ��</th>
						<th  align="center">����ʱ��</th>
					</tr>
					<%
		
            for(int i = 0; i < result.length; i++){	
            %>
                <tr>
            		<td><%=result[i][1]%></td>
            		<td><%=result[i][2]%></td>
            	    <td><%=result[i][3]%></td>
            		<td><%=result[i][4]%></td>
            		<td><%=result[i][5]%></td>			
            	    <td>
            	    	<input type="radio" name="priceType<%=i%>" value="0" <%=result[i][6].equals("0")==true?"checked":"disabled"%>>����
            	    	<input type="radio" name="priceType<%=i%>" value="1" <%=result[i][6].equals("1")==true?"checked":"disabled"%>>�Ż�&nbsp;
            	    	ֵ��<%=result[i][7]%>
            	    </td>
            		<td><%=result[i][8]%></td>
            		<td><%=result[i][9]%></td>
            		<input type="hidden" name="priceCode" value="<%=result[i][10]%>">
            		<input type="hidden" name="loginAccept" value="<%=result[i][11]%>">
            		<input type="hidden" id="hiddenBeginTime" name="hiddenBeginTime" value="<%=result[i][8]%>">
            		<input type="hidden" id="hiddenEndTime" name="hiddenEndTime" value="<%=result[i][9]%>">
            </tr>
            <%
            	}
            }	
            else{
            %>
            	<script language="javascript" >
            		rdShowMessageDialog("������룺<%=errCode%>,������Ϣ��<%=errMsg%>",0);
            		window.close();
            	</script>
            <%
            }
            %>	
				</table>
				<table cellspacing="0">
					<tr id="footer">
						<td>
					      <input type="button" class="b_foot" name="back" onClick="window.close();" value=" �ر� ">
						</td>
					</tr>
				</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

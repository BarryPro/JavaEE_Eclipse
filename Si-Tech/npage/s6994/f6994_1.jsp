<%
/********************
 version v2.0
 ������ si-tech
 create hejwa@2010-1-14 :14:39
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>

<%
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    System.out.println("---------------f6994_1.jsp--------------");
    String regionCode = (String)session.getAttribute("regCode");
    String iPhoneNo = request.getParameter("activePhone");
    System.out.println("iPhoneNo = " + iPhoneNo);
    String[][] infoArr = new String[][]{};
%>
    <wtc:service name="s1362Query" retcode="retCode" retmsg="retMsg" outnum="15" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=iPhoneNo%>"/>
    </wtc:service>
    <wtc:array id="retArr" scope="end"/>
<%
    infoArr = retArr;
%> 

<head>
<title>ר���˻���Ϣ </title>
</head>
<body>
<%if("000000".equals(retCode)){%>
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ����</div>
</div>
<table  cellspacing="0" >
	<tr>
        <td class="blue">�ֻ�����</td>
        <td>
            <input type="text" id="phoneNo" value="<%=activePhone%>" readOnly class="InputGrey" />
        </td>
    </tr>
</table>
</div>
<div id="Operation_Table">
 <div class="title">
	<div id="title_zi">ר���˻���ϸ��Ϣ</div>
</div>
<table  cellspacing="0" id="infoList">
    <tr>
        <th>�˺�</th>
        <th>Ԥ������</th>
        <th>Ԥ����</th>
        <th>���������</th>
        <th>��������ʼ</th>
        <th>����������</th>
        <th>���˿�ʼ</th>
        <th>���˽���</th>
        <th>�Ƿ����</th>
        <th>�Ƿ�ר��</th>
    </tr>	
	<%
	if(infoArr.length > 0){
        for(int i=0;i<infoArr.length;i++){ 
            out.print("<tr>");
                for(int j=0;j<infoArr[i].length;j++){
                    if(j>2 && j<13){
                        out.print("<td>"+infoArr[i][j]+"</td>");
                    }
                }
            out.print("</tr>");
        }
	}else{%>
    	<tr>
         	<td colspan="10" align="center">
         		�Բ���û�в��ҵ����ϵļ�¼!
         	</td>
        </tr>
	<%}%>
</table>

<table>
    <tr>
        <td id="footer" >
            <input type="button" value="�ر�" class="b_foot" onclick="removeCurrentTab()">
        </td>
    </tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
<%}else{%>
    <script language=javascript>
        rdShowMessageDialog("��ѯר���˻���Ϣʧ�ܣ�������룺<%=retCode%>,������Ϣ��<%=retMsg%>",0);
    </script>
<%}%>
</form>
</body>
</html>
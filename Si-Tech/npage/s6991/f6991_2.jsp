<%
    /********************
     * @ OpCode    :  6991
     * @ OpName    :  SIM�������ʷ����ϸ��Ϣ��ѯ
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2010-01-28
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode = "6991";
    String opName = "SIM�������ʷ����ϸ��Ϣ��ѯ";
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));
    String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String iPhoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));
    
    String iSimNo = "";
    String sqlStr = "select sim_no from dsimres where  phone_no = "+iPhoneNo;
    System.out.println("sql = "+sqlStr);
%>
    <wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr" scope="end"/>
<%
    if("000000".equals(retCode)){
        if(retArr.length>0){
            iSimNo = retArr[0][0];
        }else{
            System.out.println("SIM��������!");
        %>
            <script type="text/javascript">
                rdShowMessageDialog("SIM�������ڣ����������룡",0);
                history.go(-1);
            </script>
        <%
        }
    }else{
        System.out.println("��ѯSim���������");
    %>
        <script type="text/javascript">
            rdShowMessageDialog("��ѯSim���������",0);
            history.go(-1);
        </script>
    <%
    }
    System.out.println("phoneNo = "+iPhoneNo);
    /* BEGIN:��ѯSIM�������ʷ */
    String iChnSource = "06"; /* ������ʶ��01-BOSS��02-����Ӫҵ����03-����Ӫҵ����04-����Ӫҵ����05-��ý���ѯ����06-10086 */
    String[][] iSimModHis = new String[][]{};
%>
    <wtc:service name="sPCSelService" retcode="sPCSelServiceCode" retmsg="sPCSelServiceMsg" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="0"/>
    	<wtc:param value="<%=iChnSource%>"/> 
    	<wtc:param value=""/> 
    	<wtc:param value="<%=workNo%>"/> 
    	<wtc:param value="<%=workPwd%>"/> 
    	<wtc:param value="<%=iPhoneNo%>"/> 
    	<wtc:param value=""/> 
    	<wtc:param value=""/> 
    </wtc:service>
    <wtc:array id="sPCSelServiceArr" scope="end"/>
<%
    if("000000".equals(sPCSelServiceCode)){
        iSimModHis = sPCSelServiceArr;
    }else{
    %>
        <script type="text/javascript">
            rdShowMessageDialog("��ѯSIM�������ʷʧ�ܣ�������룺<%=sPCSelServiceCode%>,������Ϣ��<%=sPCSelServiceMsg%>",0);
            history.go(-1);
        </script>
    <%
    }
    /* END:��ѯSIM�������ʷ */
    
    /* BEGIN:��ѯSIM����ϸ��Ϣ */
    String[] inputFlagArr = new String[6];
    inputFlagArr[0] = "5";  /* �ֻ����� */
    inputFlagArr[1] = "78"; /* SIM ���� */
    inputFlagArr[2] = "98"; /* PUK1 �� */
    inputFlagArr[3] = "99"; /* PUK2 �� */
    inputFlagArr[4] = "96"; /* PIN1 �� */
    inputFlagArr[5] = "97"; /* PIN2 �� */
    String[][] iSimInfo = new String[][]{};
%>
    <wtc:service name="sPubUserMsg" retcode="sPubUserMsgCode" retmsg="sPubUserMsgMsg" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="0"/>
    	<wtc:param value="<%=iPhoneNo%>"/> 
    	<wtc:params value="<%=inputFlagArr%>"/> 
    </wtc:service>
    <wtc:array id="sPubUserMsgArr" scope="end"/>
<%
    if("000000".equals(sPubUserMsgCode)){
        iSimInfo = sPubUserMsgArr;
    }else{
    %>
        <script type="text/javascript">
            rdShowMessageDialog("��ѯSIM����Ϣʧ�ܣ�������룺<%=sPubUserMsgCode%>,������Ϣ��<%=sPubUserMsgMsg%>",0);
            history.go(-1);
        </script>
    <%   
    }
    /* END:��ѯSIM����ϸ��Ϣ */
%>

<%if(iSimInfo.length>0){%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">SIM�������ʷ</div>
</div>
<table cellspacing=0>
<tr>
    <th>��������</th>
    <th>������������</th>
    <th>����ʱ��</th>
    <th>��������</th>
</tr>
<%
    for(int i=0;i<iSimModHis.length;i++){
    %>
        <tr>
            <td><%=iSimModHis[i][3]%></td>
            <td><%=iSimModHis[i][4]%></td>
            <td><%=iSimModHis[i][6]%></td>
            <td><%=iSimModHis[i][8]%></td>
        </tr>
    <%
    }
%>
</table>

</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">SIM����ϸ��Ϣ</div>
</div>

<table cellspacing="0">
<tr>
    <td class="blue">SIM����</td>
    <td colspan="3">
        <input type="text" id="sim_no" name="sim_no" value="<%=iSimInfo[1][2]%>" class="InputGrey" readOnly />
    </td>
</tr>
<tr>
    <td class="blue">PUK1 ��</td>
    <td>
        <input type="text" id="puk1_no" name="puk1_no" value="<%=iSimInfo[2][2]%>" class="InputGrey" readOnly />
    </td>
    <td class="blue">PUK2 ��</td>
    <td>
        <input type="text" id="puk2_no" name="puk2_no" value="<%=iSimInfo[3][2]%>" class="InputGrey" readOnly />
    </td>
</tr>
<tr>
    <td class="blue">PIN1 ��</td>
    <td>
        <input type="text" id="pin1_no" name="pin1_no" value="<%=iSimInfo[4][2]%>" class="InputGrey" readOnly />
    </td>
    <td class="blue">PIN2 ��</td>
    <td>
        <input type="text" id="pin2_no" name="pin2_no" value="<%=iSimInfo[5][2]%>" class="InputGrey" readOnly />
    </td>
</tr>
<tr id="footer">
    <td colspan="4">
        <input type="button" id="bBack" name="bBack" value="����" class="b_foot" />
        <input type="button" id="bClose" name="bClose" value="�ر�" class="b_foot" />
    </td>
</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</form>

<script type=text/javascript>
    $(document).ready(function(){
        $("#bBack").bind("click",function(){
            history.go(-1);
        });
        $("#bClose").bind("click",removeCurrentTab);
    });
</script>

</body>
</html>
<%}%>
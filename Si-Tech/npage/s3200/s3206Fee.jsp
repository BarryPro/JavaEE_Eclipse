

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String opCode = "3206";
  String opName = "VPMN���Ų�ѯ";
  	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
    String callData[][] = new String[][]{};
    String[] ParamsIn = null;

    String iQueryType = request.getParameter("busyType");
	String iOpCode = request.getParameter("Op_Code");
	String iWorkNo = request.getParameter("WorkNo");
	String iWorkName = request.getParameter("WorkName");
	String iNoPass = request.getParameter("NoPass");
	String iSystemNote = request.getParameter("TBackNote");
	String iOrgCode = request.getParameter("OrgCode");
	String iGrpId = request.getParameter("TGrpId");
    String iRegion_Code = iOrgCode.substring(0,2);
					
  %>
	<wtc:service name="s3206CfmEXC" routerKey="region" routerValue="<%=iRegion_Code%>"  retcode="error_code" retmsg="error_msg" outnum="3">
		<wtc:param value="<%=iWorkNo%>" />
		<wtc:param value="<%=iNoPass%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=iOrgCode%>" />
		<wtc:param value="<%=iQueryType%>" />
		<wtc:param value="<%=iGrpId%>" />		
		<wtc:param value="<%=iSystemNote%>" />		
	</wtc:service>
	<wtc:array id="result_t" start="0" length="1" scope="end" />		  
  <%
	if( result_t.length==0 ){
		valid = 1;
	}else{
		if( !error_code.equals("000000")){
			valid = 2;
		}else{
			valid = 0;
			callData = result_t;
		}
	}

 if( valid == 1){%>
<script language="JavaScript">

	rdShowMessageDialog("û����صĲ�ѯ����!!");
	history.go(-1);
</script>

<%}else if ( valid == 2 ) {
%>
<script language="JavaScript">
	rdShowMessageDialog("ҵ�����<br>������룺'<%=error_code%>'��<br>������Ϣ��'<%=error_msg%>'��");
	history.go(-1);
</script>
<%
}
else{%>
<html>
<head>
<title>�������ƶ�ͨ��-���Ż�����Ϣ��ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<BODY>
<FORM action="" method="post" name="form">
<input type="hidden" name="Op_Code"  value="3206">
<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">��ѯ��ʽ�����Ż�����Ϣ</div>
	</div>	

		  
        <table  cellspacing=0 >
          <tr > 
            <td class="blue" >���ź�</td>      
            <td> 
              <input name="grpId" type="text" class="InputGrey" readonly id="grpId" value="<%=callData[0][0]%>"></td>
            <td class="blue">��������</td>      
            <td> 
              <input name="MONTHNOW" type="text" class="InputGrey"  readonly id="MONTHNOW" value="<%=callData[1][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">�����ܷ���</td>      
            <td> 
              <input name="TOTALFEE" type="text" class="InputGrey"  readonly id="TOTALFEE" value="<%=callData[2][0]%>"></td>
            <td class="blue">����Ƿ���ܶ�</td>      
            <td> 
              <input name="OVERDUE" type="text" class="InputGrey"  readonly id="OVERDUE" value="<%=callData[3][0]%>"></td>
    </tr>
          <tr > 
            <td height="16"  class="blue">�������ں����ܷ���</td>      
            <td> 
              <input name="FEE1" type="text" class="InputGrey"  readonly id="FEE1" value="<%=callData[4][0]%>"></td>
            <td class="blue">���ں��д���</td>      
            <td> 
              <input name="TIME1" type="text" class="InputGrey"  readonly id="TIME1" value="<%=callData[5][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">������������ܷ���</td>      
            <td> 
              <input name="FEE2" type="text" class="InputGrey"  readonly id="FEE2" value="<%=callData[6][0]%>"></td>
            <td class="blue">������д���</td>      
            <td> 
              <input name="TIME2" type="text" class="InputGrey" readonly  id="TIME2" value="<%=callData[7][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">�����������������ܷ���</td>
            <td> 
              <input name="FEE3" type="text" class="InputGrey"  readonly id="FEE3" value="<%=callData[8][0]%>"></td>
            <td class="blue">�����������д���</td>      
            <td> 
              <input name="TIME3" type="text" class="InputGrey"  readonly id="TIME3" value="<%=callData[9][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">������������ܷ���</td>      
            <td> 
              <input name="FEE4" type="text" class="InputGrey" readonly  value="<%=callData[10][0]%>"></td>
            <td class="blue">������д���</td>      
            <td> 
              <input name="TIME4" type="text" class="InputGrey"  readonly value="<%=callData[11][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">������������л���</td>      
            <td> 
              <input name="FEE5" type="text" class="InputGrey"  readonly value="<%=callData[12][0]%>"></td>
            <td class="blue">�����л����д���</td>      
            <td> 
              <input name="TIME5" type="text" class="InputGrey"  readonly value="<%=callData[13][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">�����������ʡ�ڳ�;��</td>
            <td> 
              <input name="FEE6" type="text" class="InputGrey" readonly  value="<%=callData[14][0]%>"></td>
            <td class="blue">����ʡ�ڳ�;���д���</td>
            <td> 
              <input name="TIME6" type="text" class="InputGrey"  readonly value="<%=callData[15][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">�����������ʡ�ⳤ;��</td>
            <td> 
              <input name="FEE7" type="text" class="InputGrey"  readonly value="<%=callData[16][0]%>"></td>
            <td class="blue">����ʡ�ⳤ;���д���</td>
            <td> 
              <input name="TIME7" type="text" class="InputGrey"  readonly value="<%=callData[17][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">����������й��ʳ�;��</td>
            <td> 
              <input name="FEE8" type="text" class="InputGrey"  readonly value="<%=callData[18][0]%>"></td>
            <td class="blue">������ʳ�;���д���</td>
            <td> 
              <input name="TIME8" type="text" class="InputGrey"  readonly value="<%=callData[19][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">���ں�����ʱ��</td>      
            <td> 
              <input name="DURAT1" type="text" class="InputGrey"  readonly id="DURAT1" value="<%=callData[20][0]%>"></td>
            <td class="blue">�����л�����ʱ��</td>      
            <td> 
              <input name="DURAT2" type="text" class="InputGrey"  readonly id="DURAT2" value="<%=callData[21][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">���ⳤ;����ʱ��</td>      
            <td> 
              <input name="DURAT3" type="text" class="InputGrey"  readonly value="<%=callData[22][0]%>"></td>
            <td class="blue">��������������ʱ��</td>
            <td> 
              <input name="DURAT4" type="text" class="InputGrey"  readonly value="<%=callData[23][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">���������ʱ��</td>      
            <td> 
              <input name="DURAT5" type="text" class="InputGrey"  readonly value="<%=callData[24][0]%>"></td>
            <td class="blue">���˸����ܷ���</td>      
            <td> 
              <input name="PTOTALFEE" type="text" class="InputGrey"  readonly value="<%=callData[25][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">���˸���Ƿ���ܶ�</td>      
            <td> 
              <input name="POVERDUE" type="text" class="InputGrey"  readonly value="<%=callData[26][0]%>"></td>
            <td class="blue">���˸������ں����ܷ���</td>      
            <td> 
              <input name="PFEE1" type="text" class="InputGrey"  readonly value="<%=callData[27][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">���˸�����������ܷ���</td>      
            <td> 
              <input name="PFEE2" type="text" class="InputGrey" value="<%=callData[28][0]%>"></td>
            <td class="blue">���˸�����������ܷ���</td>      
            <td> 
              <input name="PFEE3" type="text" class="InputGrey"  readonly value="<%=callData[29][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">���˸�����������ܷ���</td>      
            <td> 
              <input name="PFEE4" type="text" class="InputGrey"  readonly value="<%=callData[30][0]%>"></td>
            <td class="blue">�ʷ��ײ���Ч����</td>      
            <td> 
              <input name="PKGDAY" type="text" class="InputGrey"  readonly value="<%=callData[31][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">���һ�ν���������</td>      
            <td> 
              <input name="PAYDAY" type="text" class="InputGrey"  readonly value="<%=callData[32][0]%>"></td>
            <td class="blue">&nbsp;</td>
            <td width="24%">&nbsp;</td>
    </tr>
          <tr > 
            <td  class="blue">��������ʣ�����ʱ��1</td>      
            <td> 
              <input name="RENTTIME1" type="text" class="InputGrey"  readonly value="<%=callData[33][0]%>"></td>
            <td class="blue">��������ʣ�����ʱ��2</td>      
            <td> 
              <input name="RENTTIME2" type="text" class="InputGrey"  readonly value="<%=callData[34][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">��������ʣ����ѽ��1</td>      
            <td> 
              <input name="RENTFEE1" type="text" class="InputGrey"  readonly value="<%=callData[35][0]%>"></td>
            <td class="blue">��������ʣ����ѽ��2</td>      
            <td> 
              <input name="RENTFEE2" type="text" class="InputGrey"  readonly value="<%=callData[36][0]%>"></td>
    </tr>
   </table>
        <TABLE cellSpacing="0" >
          <TR > 
            <TD noWrap  colspan="6" id="footer"> 
                <input type="button" name="return" class="b_foot" value="����" onclick="history.go(-1)">
                <input type="button" name="return" class="b_foot" value="�ر�" onClick="removeCurrentTab()">
            </TD>
          </TR>
        </TABLE>
			<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html>
<%}%>

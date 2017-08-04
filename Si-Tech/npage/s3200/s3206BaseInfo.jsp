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
<title>���Ų�ѯ��������Ϣ��ѯ</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

</head>

<BODY>
<FORM action="" method="post" name="form">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ѯ��ʽ��������Ϣ</div>
	</div>	
		  
        <table cellspacing="0">
          <tr > 
            <td class="blue">���ź�</td>
            <td  > 
              <input name="grpId" type="text" class="InputGrey" readonly  id="grpId" value="<%=callData[0][0]%>">
            </td>
            <td class="blue">��������</td>
            <td > 
              <input name="grpName" type="text" class="InputGrey"  readonly id="grpName" value="<%=callData[2][0]%>">
            </td>
          </tr>
          <tr > 
            <td class="blue">ʡ����</td>
            <td  > 
              <input name="province" type="text" class="InputGrey"  readonly id="province" value="<%=callData[3][0]%>">
            </td>
            <td class="blue">ҵ������</td>
            <td > 
              <input name="servArea" type="text" class="InputGrey"  readonly id="servArea" value="<%=callData[4][0]%>">
            </td>
          </tr>
          <tr > 
            <td class="blue">SCP��</td>
            <td  > 
              <input name="scpId" type="text" class="InputGrey"  readonly id="scpId" value="<%=callData[5][0]%>">
            </td>
            <td class="blue">��������</td>
            <td > 
              <input name="grpType" type="text" class="InputGrey"  readonly id="grpType" 
              value="<% 
            	if(callData[6][0].equals("0")) out.println("���ؼ���");
            	else if(callData[6][0].equals("1")) out.println("ȫʡ����");
            	else if(callData[6][0].equals("1")) out.println("ȫ������");  
            	else out.println("���ػ�ʡ������");         	
             	%>">
            </td>
          </tr>
          <tr > 
            <td class="blue">��ϵ������</td>
            <td  > 
              <input name="contact" type="text" class="InputGrey"  readonly id="contact" value="<%=callData[7][0]%>">
            </td>
            <td class="blue">������ϵ�绰</td>
            <td > 
              <input name="telePhone" type="text" class="InputGrey"  readonly id="telePhone" value="<%=callData[9][0]%>">
            </td>
          </tr>
          <tr > 
            <td  class="blue">������ϵ��ַ</td>
            <td  colspan="3"> 
              <input name="address" type="text" class="InputGrey"  readonly id="address" value="<%=callData[8][0]%>" size="60">
            </td>
          </tr>
          <tr > 
            <td class="blue">����ʱ��</td>
            <td  > 
              <input name="creDate" type="text" class="InputGrey"  readonly id="creDate" value="<%=callData[10][0]%>">
            </td>
            <td class="blue">����/ȥ��������</td>
            <td > 
              <input name="actDate" type="text" class="InputGrey"  readonly id="actDate" value="<%=callData[11][0]%>">
            </td>
          </tr>
          <tr > 
            <td class="blue">ҵ����ʼ����</td>
            <td  > 
              <input name="srvStart" type="text" class="InputGrey"  readonly id="srvStart" value="<%=callData[12][0]%>">
            </td>
            <td class="blue">ҵ���������</td>
            <td > 
              <input name="srvStop" type="text" class="InputGrey"  readonly id="srvStop" value="<%=callData[13][0]%>">
            </td>
          </tr>
          <tr > 
            <td class="blue">ҵ�񼤻��־</td>
            <td  > 
              <input name="subState" type="text" class="InputGrey"  readonly id="subState" 
              value="<% 
            	if(callData[14][0].equals("0")) out.println("δ����");
            	else if(callData[14][0].equals("1")) out.println("����");  
            	else out.println("���Ų�����");         	
             	%>">
            </td>
            <td class="blue">&nbsp;</td>
            <td >&nbsp;</td>
          </tr>
          <tr > 
            <td nowrap class="blue">���ڷ�������</td>
            <td > 
              <input name="INTERFEE" type="text" class="InputGrey"  readonly id="INTERFEE" value="<%=callData[16][0]%>">
            </td>
            <td class="blue">�����������</td>
            <td > 
              <input name="OUTFEE" type="text" class="InputGrey"  readonly id="OUTFEE" value="<%=callData[17][0]%>">
            </td>
          </tr>
          <tr > 
            <td nowrap class="blue">����������������</td>
            <td > 
              <input name="OUTGRPFEE" type="text" class="InputGrey"  readonly id="OUTGRPFEE" value="<%=callData[18][0]%>">
            </td>
            <td class="blue">���Żݷ�������</td>
            <td > 
              <input name="NORMALFEE" type="text" class="InputGrey"  readonly id="NORMALFEE" value="<%=callData[19][0]%>">
            </td>
          </tr>
          <tr > 
            <td nowrap class="blue">���Ź������̵Ľ�����</td>
            <td > 
              <input name="admNo" type="text" class="InputGrey"  readonly id="admNo" value="<%=callData[23][0]%>">
            </td>
            <td class="blue">���л���Աת�Ӻ���</td>
            <td > 
              <input name="transNo" type="text" class="InputGrey" readonly  id="transNo2" value="<%=callData[24][0]%>">
            </td>
          </tr>
          <tr > 
            <td height="19" nowrap class="blue">���к�����ʾ��ʽ</td>
            <td > 
              <input name="display" type="text" class="InputGrey"  readonly id="display" 
          value="<% 
            	if(callData[25][0].equals("0")) out.println("ʹ�ø��˱�־");
            	else if(callData[25][0].equals("1")) out.println("��ʾ�̺�");
            	else if(callData[25][0].equals("2")) out.println("��ʾ��ʵ����");
            	else if(callData[25][0].equals("3")) out.println("PBX������ʾ��ʵ����");
            	else out.println("������ʾ�̺�");
             	%>">
            </td>
            <td class="blue">&nbsp;</td>
            <td >&nbsp;</td>
          </tr>
          <tr > 
            <td nowrap class="blue">���պ��û�Ⱥ��</td>
            <td > 
              <input name="MAXCLNUM" type="text" class="InputGrey"  readonly id="MAXCLNUM" value="<%=callData[26][0]%>">
            </td>
            <td class="blue">��ǰ�պ��û�Ⱥ��</td>
            <td > 
              <input name="CURCLNUM" type="text" class="InputGrey"  readonly id="CURCLNUM" value="<%=callData[27][0]%>">
            </td>
          </tr>
          <tr > 
            <td class="blue" >�����պ��û�Ⱥ�ܰ���������û���</td>
            <td > 
              <input name="MAXNUMCL" type="text" class="InputGrey"  readonly id="MAXNUMCL" value="<%=callData[28][0]%>">
            </td>
            <td class="blue">�����û����ɼ���ıպ�Ⱥ��</td>
            <td > 
              <input name="PMAXCLOSE" type="text" class="InputGrey"  readonly id="PMAXCLOSE" value="<%=callData[29][0]%>" >
            </td>
          </tr>
          <tr > 
            <td nowrap class="blue">��������������</td>
            <td > 
              <input name="MAXOUTNUM " type="text" class="InputGrey"  readonly id="MAXOUTNUM" value="<%=callData[30][0]%>">
            </td>
            <td class="blue">��ǰ�������������</td>
            <td > 
              <input name="CUROUTNUM " type="text" class="InputGrey"  readonly id="CUROUTNUM" value="<%=callData[31][0]%>">
            </td>
          </tr>
          <tr > 
            <td  class="blue">��ǰ���ų�Ա���������</td>
            <td > 
              <input name="CURPOUTNUM " type="text" class="InputGrey"  readonly id="CURPOUTNUM" value="<%=callData[32][0]%>">
            </td>
            <td class="blue">����û���</td>
            <td > 
              <input name="MAXUSERS" type="text" class="InputGrey" id="MAXUSERS" value="<%=callData[33][0]%>">
            </td>
          </tr>
          <tr > 
            <td nowrap class="blue">��ǰ�û���</td>
            <td > 
              <input name="CURUSERS" type="text" class="InputGrey"  readonly id="CURUSERS" value="<%=callData[34][0]%>">
            </td>
            <td class="blue">&nbsp;</td>
            <td >&nbsp;</td>
          </tr>
          <tr > 
            <td nowrap class="blue">�ʷ��ײ�����</td>
            <td > 
              <input name="PKGTYPE" type="text" class="InputGrey"  readonly id="PKGTYPE" value="<%=callData[35][0]%>">
            </td>
            <td class="blue">�ʷ��ײ�����</td>
            <td > 
              <input name="PKGNAME" type="text" class="InputGrey"  readonly id="PKGNAME" value="<%=callData[36][0]%>">
            </td>
          </tr>
          <tr > 
            <td nowrap class="blue">���ۿ�</td>
            <td > 
              <input name="DISCOUNT" type="text" class="InputGrey"  readonly id="DISCOUNT" value="<%=callData[37][0]%>">
            </td>
            <td class="blue">�����·����޶�</td>
            <td > 
              <input name="textfield2411" type="text" class="InputGrey"  readonly value="<%=callData[38][0]%>">
            </td>
          </tr>
          <tr > 
            <td nowrap class="blue">�����ۺ�v���ʷ�</td>
            <td colspan="3"> 
              <input name="offer" type="text" class="InputGrey"  readonly id="offer" value="<%=callData[96][0]%>">
            </td>
          </tr>
          <tr> 
            <td colspan="4" bgcolor="#99ccff">&nbsp;</td>
          </tr>
          <tr > 
            <td colspan="4">����ѡ�</td>
          </tr>
        </table>

              <table cellspacing=0>
                <tr > 
                  <td class="blue" nowrap>����ȥ��</td>
                  <td > 
                    <input name="textfield15" type="text"  readonly class="InputGrey" 
            value="<% 
            	if(callData[15][0].substring(0,1).equals("0")) out.println("��ֹ");
            	else if(callData[15][0].substring(0,1).equals("1")) out.println("�л�");
            	else if(callData[15][0].substring(0,1).equals("2")) out.println("�л�+ʡ��");
            	else if(callData[15][0].substring(0,1).equals("3")) out.println("�л�+ʡ��+ʡ��");
            	else if(callData[15][0].substring(0,1).equals("4")) out.println("�л�+ʡ��+ʡ��+����");
            	%>">
                  </td>
                  <td class="blue" nowrap>��������</td>
                  <td > 
                    <input name="textfield16" type="text"  readonly class="InputGrey" 
            value="<% 
            	if(callData[15][0].substring(1,2).equals("0")) out.println("��ֹ");
            	else if(callData[15][0].substring(1,2).equals("1")) out.println("�л�");
            	else if(callData[15][0].substring(1,2).equals("2")) out.println("�л�+ʡ��");
            	else if(callData[15][0].substring(1,2).equals("3")) out.println("�л�+ʡ��+ʡ��");
            	else if(callData[15][0].substring(1,2).equals("4")) out.println("�л�+ʡ��+ʡ��+����");
            	%>">
                  </td>
                  <td class="blue" nowrap>����ȥ��</td>
                  <td > 
                    <input name="textfield17" type="text"  readonly class="InputGrey" 
            value="<% 
            	if(callData[15][0].substring(2,3).equals("0")) out.println("��ֹ");
            	else if(callData[15][0].substring(2,3).equals("1")) out.println("�л�");
            	else if(callData[15][0].substring(2,3).equals("2")) out.println("�л�+ʡ��");
            	else if(callData[15][0].substring(2,3).equals("3")) out.println("�л�+ʡ��+ʡ��");
            	else if(callData[15][0].substring(2,3).equals("4")) out.println("�л�+ʡ��+ʡ��+����");
            	%>">
                  </td>
                </tr>
                <tr > 
                  <td class="blue" nowrap>��������</td>
                  <td > 
                    <input name="textfield152" type="text"  readonly class="InputGrey" 
            value="<% 
            	if(callData[15][0].substring(3,4).equals("0")) out.println("��ֹ");
            	else if(callData[15][0].substring(3,4).equals("1")) out.println("�л�");
            	else if(callData[15][0].substring(3,4).equals("2")) out.println("�л�+ʡ��");
            	else if(callData[15][0].substring(3,4).equals("3")) out.println("�л�+ʡ��+ʡ��");
            	else if(callData[15][0].substring(3,4).equals("4")) out.println("�л�+ʡ��+ʡ��+����");
            	%>">
                  </td>
                  <td class="blue" nowrap>����ȥ��</td>
                  <td > 
                    <input name="textfield1514" type="text"  readonly class="InputGrey" 
            value="<% 
            	if(callData[15][0].substring(4,5).equals("0")) out.println("��ֹ");
            	else if(callData[15][0].substring(4,5).equals("1")) out.println("�л�");
            	else if(callData[15][0].substring(4,5).equals("2")) out.println("�л�+ʡ��");
            	else if(callData[15][0].substring(4,5).equals("3")) out.println("�л�+ʡ��+ʡ��");
            	else if(callData[15][0].substring(4,5).equals("4")) out.println("�л�+ʡ��+ʡ��+����");
            	%>">
                  </td>
                  <td class="blue" nowrap>��������</td>
                  <td class="button1"> 
                    <input name="textfield1515" type="text"      readonly class="InputGrey" 
            value="<% 
            	if(callData[15][0].substring(5,6).equals("0")) out.println("��ֹ");
            	else if(callData[15][0].substring(5,6).equals("1")) out.println("�л�");
            	else if(callData[15][0].substring(5,6).equals("2")) out.println("�л�+ʡ��");
            	else if(callData[15][0].substring(5,6).equals("3")) out.println("�л�+ʡ��+ʡ��");
            	else if(callData[15][0].substring(5,6).equals("4")) out.println("�л�+ʡ��+ʡ��+����");
            	%>">
                  </td>
                </tr>
                <tr > 
                  <td class="blue" nowrap>���������ȥ��</td>
                  <td > 
                    <input name="textfield153" type="text" class="InputGrey"  readonly 
            value="<% 
            	if(callData[15][0].substring(6,7).equals("0")) out.println("��ֹ");
            	else if(callData[15][0].substring(6,7).equals("1")) out.println("�л�");
            	else if(callData[15][0].substring(6,7).equals("2")) out.println("�л�+ʡ��");
            	else if(callData[15][0].substring(6,7).equals("3")) out.println("�л�+ʡ��+ʡ��");
            	else if(callData[15][0].substring(6,7).equals("4")) out.println("�л�+ʡ��+ʡ��+����");
            	%>">
                  </td>
                  <td class="blue" nowrap>�������������</td>
                  <td > 
                    <input name="textfield1513" type="text" class="InputGrey"  readonly 
             value="<% 
            	if(callData[15][0].substring(7,8).equals("0")) out.println("��ֹ");
            	else if(callData[15][0].substring(7,8).equals("1")) out.println("�л�");
            	else if(callData[15][0].substring(7,8).equals("2")) out.println("�л�+ʡ��");
            	else if(callData[15][0].substring(7,8).equals("3")) out.println("�л�+ʡ��+ʡ��");
            	else if(callData[15][0].substring(7,8).equals("4")) out.println("�л�+ʡ��+ʡ��+����");
            	%>">
                  </td>
                  <td class="blue" nowrap>��������Ȩ��</td>
                  <td > 
                    <input name="textfield1516" type="text" class="InputGrey"  readonly 
            value="<% 
            	if(callData[15][0].substring(8,9).equals("0")) out.println("��ֹ");
            	else if(callData[15][0].substring(8,9).equals("1")) out.println("ʡ��");
            	else if(callData[15][0].substring(8,9).equals("2")) out.println("ʡ��+ʡ��");
             	%>">
                  </td>
                </tr>
                <tr > 
                  <td class="blue" nowrap>��������Ȩ��</td>
                  <td class="button1"> 
                    <input name="textfield154" type="text" class="InputGrey"  readonly 
             value="<% 
            	if(callData[15][0].substring(9,10).equals("0")) out.println("��ֹ");
            	else if(callData[15][0].substring(9,10).equals("1")) out.println("ʡ��");
            	else if(callData[15][0].substring(9,10).equals("2")) out.println("ʡ��+ʡ��");
             	%>">
                  </td>
                  <td class="blue">���Ż���Ա</td>
                  <td class="button1"> 
                    <input name="textfield1512" type="text" class="InputGrey"  readonly 
             value="<% 
            	if(callData[15][0].substring(10,11).equals("0")) out.println("���ṩ");
            	else if(callData[15][0].substring(10,11).equals("1")) out.println("�ṩ");
            	else if(callData[15][0].substring(10,11).equals("2")) out.println("�ṩ������Ա����������");
             	%>">
                  </td>
                  <td class="blue">����ǰת</td>
                  <td class="button1"> 
                    <input name="textfield1517" type="text" class="InputGrey"  readonly 
             value="<% 
            	if(callData[15][0].substring(11,12).equals("0")) out.println("���ṩ");
            	else if(callData[15][0].substring(11,12).equals("1")) out.println("�ṩ");
             	%>">
                  </td>
                </tr>
                <tr > 
                  <td nowrap class="blue">�պ��û�Ⱥ����</td>
                  <td class="button1"> 
                    <input name="textfield155" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(12,13).equals("0")) out.println("���ṩ");
            	else if(callData[15][0].substring(12,13).equals("1")) out.println("�ṩ�Ż�Ⱥ");
            	else if(callData[15][0].substring(12,13).equals("2")) out.println("�ṩ�պ��Ż�Ⱥ");
             	%>">
                  </td>
                  <td class="blue">�����ۿ�</td>
                  <td class="button1"> 
                    <input name="textfield1511" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(13,14).equals("0")) out.println("���ṩ");
            	else if(callData[15][0].substring(13,14).equals("1")) out.println("�ṩ");
             	%>">
                  </td>
                  <td class="blue">�������</td>
                  <td class="button1"> 
                    <input name="textfield1518" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(14,15).equals("0")) out.println("���ṩ");
            	else if(callData[15][0].substring(14,15).equals("1")) out.println("�ṩ");
             	%>">
                  </td>
                </tr>
                <tr > 
                  <td class="blue" nowrap>Ⱥ�����Ϣ����</td>
                  <td class="button1"> 
                    <input name="textfield156" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(15,16).equals("0")) out.println("���ṩ");
            	else if(callData[15][0].substring(15,16).equals("1")) out.println("�ṩ");
             	%>">
                  </td>
                  <td colspan="3" class="blue">ͨ���������̲�����Ա�������Ƿ��շ�</td>
                  <td class="button1"> 
                    <input name="textfield1519" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(16,17).equals("0")) out.println("���շ�");
            	else if(callData[15][0].substring(16,17).equals("1")) out.println("�շ�");
             	%>">
                  </td>
                </tr>
                <tr > 
                  <td class="blue">��Ա�Ƿ���ֱ�Ӻ��л���Ա</td>
                  <td class="button1"> 
                    <input name="textfield157" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(17,18).equals("0")) out.println("����");
            	else if(callData[15][0].substring(17,18).equals("1")) out.println("��");
             	%>">
                  </td>
                  <td class="blue">����Ա���������Ƿ��շ�</td>
                  <td class="button1"> 
                    <input name="textfield1510" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(18,19).equals("0")) out.println("���շ�");
            	else if(callData[15][0].substring(18,19).equals("1")) out.println("�շ�");
             	%>">
                  </td>
                  <td class="blue">������Ա�Ƿ�ת����Ӫ�̿ͷ�����</td>
                  <td class="button1"> 
                    <input name="textfield1520" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(19,20).equals("0")) out.println("��ת��");
            	else if(callData[15][0].substring(19,20).equals("1")) out.println("ת��");
             	%>">
                  </td>
                </tr>
                <tr > 
                  <td class="blue" nowrap>�ʷ��ײ͹���</td>
                  <td class="button1"> 
                    <input name="textfield158" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(20,21).equals("0")) out.println("���ṩ");
            	else if(callData[15][0].substring(20,21).equals("1")) out.println("�ṩ");
             	%>">
                  </td>
                  <td class="blue">��������鹦��</td>
                  <td class="button1"> 
                    <input name="textfield159" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(21,22).equals("0")) out.println("���ṩ");
            	else if(callData[15][0].substring(21,22).equals("1")) out.println("�ṩ");
             	%>">
                  </td>
                  <td class="blue">���˸��Ѻ����Ƿ����Ż�</td>
                  <td class="button1"> 
                    <input name="textfield1521" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(22,23).equals("0")) out.println("���Ż�");
            	else if(callData[15][0].substring(22,23).equals("1")) out.println("���Ż�");
             	%>">
                  </td>
                </tr>
              </table>
        <TABLE cellSpacing="0">
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

<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>

<%request.setCharacterEncoding("GBK");%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.config.INIT_DATA"%>

<script type="text/javascript" src="date.js"></script>

<%
		String opCode = "3216";
		String opName = "��ѯ���ų�Ա��Ϣ ";
        ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
        String[][] baseInfoSession = (String[][])arrSession.get(0);
        String[][] otherInfoSession = (String[][])arrSession.get(2);
		
		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
    	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));   
    	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String loginNoPass = WtcUtil.repNull((String)session.getAttribute("password"));
		String powerCode= (String)session.getAttribute("powerCode");

        String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
        String GroupId = baseInfoSession[0][21];
        String ProvinceRun = baseInfoSession[0][22];
        String OrgId = baseInfoSession[0][23];

        int recordNum = 0;
        String tok = "~";
        ArrayList retArray = new ArrayList();
        String[][] result = new String[][]{};
        
%>

<%
    int valid = 1;  //0:��ȷ��1��ϵͳ����2��ҵ�����
	String[] retInfos = null;

    String[] ParamsIn = new String[8];
    String op_code = request.getParameter("opCode");
    String no_type = request.getParameter("noType");
    String inOrgCode = request.getParameter("orgCode");     /* ��������   */
    String iRegion_Code = inOrgCode.substring(0,2);

    ParamsIn[0] = request.getParameter("loginNo");  /* ��������   */
    ParamsIn[1] = request.getParameter("orgCode");  /* ��������   */
    ParamsIn[2] = request.getParameter("opCode");   /* ��������   */
    ParamsIn[3] = request.getParameter("opNote");   /* ������ע   */
    ParamsIn[4] = request.getParameter("GRPID");    /* ���ź�     */
    ParamsIn[5] = request.getParameter("PHONENO");  /* �̺���     */
    ParamsIn[6] = request.getParameter("ISDNNO");   /* ��ʵ����   */
    ParamsIn[7] = request.getParameter("qryType");  /* ��ѯ����   */

    for(int i=0; i<ParamsIn.length; i++){
        if( ParamsIn[i] == null ){
            ParamsIn[i] = "";
        }
        //System.out.println("["+i+"]="+ParamsIn[i]);
    }

    //al = s3210.get_s3216( op_code,input_paras );
    //retArray = callView.callFXService("s3216Cfm", ParamsIn, "3", "region", iRegion_Code);
  %>
	<wtc:service name="s3216Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="errorCode" retmsg="errorMsg" outnum="3">
		<wtc:param value="<%=ParamsIn[0]%>" />
		<wtc:param value="<%=ParamsIn[1]%>" />
		<wtc:param value="<%=ParamsIn[2]%>" />
		<wtc:param value="<%=ParamsIn[3]%>" />
		<wtc:param value="<%=ParamsIn[4]%>" />
		<wtc:param value="<%=ParamsIn[5]%>" />		
		<wtc:param value="<%=ParamsIn[6]%>" />
		<wtc:param value="<%=ParamsIn[7]%>" />				
	</wtc:service>
	<wtc:array id="callData" start="2" length="1" scope="end" />		  
  <% 
    if( callData == null ){
        valid = 1;
    }else{
        if( !errorCode.equals("000000")){
            valid = 2;
        }else{
            valid = 0;
			retInfos = callData[0][0].split(tok, 63);
/*
			for(int i = 0; i < retInfos.length; i ++)
			{
				System.out.println("retInfos[" + i + "]=[" + retInfos[i] + "];");
			}
*/
			if( retInfos.length != 63 )
            {
                valid = 2;
                errorCode="444444";
                errorMsg="������ȱ��!!";
            }
        }
    }
%>

<%if( valid != 0 ){ //System.out.println("===111valid=="+valid);
response.sendRedirect("smapError.jsp?ReqPageName=f3216&errCode="+errorCode+"&errMsg="+errorMsg);
%>
<script language="JavaScript">
<!--
    rdShowMessageDialog("<br>�������:"+"<%=errorCode%></br>"+"������Ϣ:"+"<%=errorMsg%>");
    history.go(-1);

//-->
</script>
<%}%>


<head>
<title>��ѯ:������Ϣ</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<script language="JavaScript">
	function init()
	{
		with(document.frm)
		{
			GRPID.value = "<%=retInfos[0]%>";
			PHONENO.value = "<%=retInfos[1]%>";
			ISDNNO.value = "<%=retInfos[2]%>";

			MONTHNOW.value = "<%=retInfos[31]%>";
			TOTALFEE.value = "<%=retInfos[32]%>";
			OVERDUE.value = "<%=retInfos[33]%>";
			FEE1.value = "<%=retInfos[34]%>";
			FEE2.value ="<%=retInfos[35]%>";
			FEE3.value ="<%=retInfos[36]%>";
			FEE4.value = "<%=retInfos[37]%>";
			DURAT1.value = "<%=retInfos[39]%>";
			DURAT2.value = "<%=retInfos[40]%>";
			DURAT3.value = "<%=retInfos[41]%>";
			DURAT4.value = "<%=retInfos[42]%>";
			DURAT5.value = "<%=retInfos[43]%>";
			PTOTALFEE.value = "<%=retInfos[44]%>";
			POVERDUE.value = "<%=retInfos[45]%>";
			PFEE1.value = "<%=retInfos[46]%>";
			PFEE2.value = "<%=retInfos[47]%>";
			PFEE3.value = "<%=retInfos[48]%>";
			PFEE4.value = "<%=retInfos[49]%>";
			PFEE5.value = "<%=retInfos[50]%>";
			PFEE6.value = "<%=retInfos[51]%>";
			PKGDAY.value = "<%=retInfos[52]%>";
			PAYDAY.value = "<%=retInfos[53]%>";
			RENTTIME1.value = "<%=retInfos[54]%>";
			RENTTIME2.value = "<%=retInfos[55]%>";
			RENTFEE1.value = "<%=retInfos[56]%>";
			RENTFEE2.value = "<%=retInfos[57]%>";
		}
	}



//-->
</script>

</head>


<body onLoad="init()">
<form name="frm" method="post" action="">

<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">��ѯ:������Ϣ</div>
	</div>	


        <table cellspacing="0">
          <tr >
            <td class="blue">���ź�</td>
            <td ><input name="GRPID" type="text" class="InputGrey" id="GRPID"  readonly></td>
            <td class="blue">��������</td>
            <td><input name="MONTHNOW" type="text" class="InputGrey" id="MONTHNOW" readonly></td>
          </tr>
          <tr >
            <td class="blue">�̺�</td>
            <td width="34%"><input name="qryNo" type="text" class="InputGrey" id="PHONENO" readonly></td>
            <td class="blue">��ʵ����</td>
            <td><input name="ISDNNO" type="text" class="InputGrey" id="ISDNNO" readonly></td>
          </tr>
          <tr >
            <td class="blue">���Ÿ����ܷ���</td>
            <td><input name="TOTALFEE" type="text" class="InputGrey" id="TOTALFEE" readonly></td>
            <td class="blue">���Ÿ���Ƿ���ܶ�</td>
            <td><input name="OVERDUE" type="text" class="InputGrey" id="OVERDUE" readonly></td>
          </tr>
          <tr >
            <td class="blue">�������ں����ܷ���</td>
            <td><input name="FEE1" type="text" class="InputGrey" id="FEE1" readonly></td>
            <td class="blue">������������ܷ���</td>
            <td><input name="FEE2" type="text" class="InputGrey" id="FEE2" readonly></td>
          </tr>
          <tr >
            <td  class="blue">�����������������ܷ���</td>
            <td ><input name="FEE3" type="text" class="InputGrey" id="FEE3" readonly></td>
            <td class="blue">������������ܷ���</td>
            <td><input name="FEE4" type="text" class="InputGrey" id="FEE4" readonly></td>
          </tr>
          <tr >
            <td class="blue">���ں�����ʱ��</td>
            <td><input name="DURAT1" type="text" class="InputGrey" id="DURAT1" readonly></td>
            <td class="blue">�����л�����ʱ��</td>
            <td><input name="DURAT2" type="text" class="InputGrey" id="DURAT2" readonly></td>
          </tr>
          <tr >
            <td class="blue">���ⳤ;����ʱ��</td>
            <td><input name="DURAT3" type="text" class="InputGrey" id="DURAT3" readonly></td>
            <td class="blue">��������������ʱ��</td>
            <td><input name="DURAT4" type="text" class="InputGrey" id="DURAT4" readonly></td>
          </tr>
          <tr >
            <td class="blue">���������ʱ��</td>
            <td><input name="DURAT5" type="text" class="InputGrey" id="DURAT5" readonly></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr >
            <td class="blue">�����Żݺ����ܷ���</td>
            <td><input name="PTOTALFEE" type="text" class="InputGrey" id="PTOTALFEE" readonly></td>
            <td class="blue">����Ƿ���ܶ�</td>
            <td><input name="POVERDUE" type="text" class="InputGrey" id="POVERDUE" readonly></td>
          </tr>
          <tr >
            <td class="blue">�������ں����ܷ���</td>
            <td><input name="PFEE1" type="text" class="InputGrey" id="PFEE1" readonly></td>
            <td class="blue">������������ܷ���</td>
            <td><input name="PFEE2" type="text" class="InputGrey" id="PFEE2" readonly></td>
          </tr>
          <tr >
            <td class="blue">�����������������ܷ���:</td>
            <td><input name="PFEE3" type="text" class="InputGrey" id="PFEE3" readonly></td>
            <td class="blue">������������ܷ���</td>
            <td><input name="PFEE4" type="text" class="InputGrey" id="PFEE4" readonly></td>
          </tr>
          <tr >
            <td class="blue">�ײ��û����ں����л��ܷ���</td>
            <td><input name="PFEE5" type="text" class="InputGrey" id="PFEE5" readonly></td>
            <td class="blue">���һ��ͨ������</td>
            <td><input name="PFEE6" type="text" class="InputGrey" id="PFEE6" readonly></td>
          </tr>
          <tr >
            <td class="blue">�ʷ��ײ���Ч����</td>
            <td><input name="PKGDAY" type="text" class="InputGrey" id="PKGDAY" readonly></td>
            <td class="blue">���һ�ν���������</td>
            <td><input name="PAYDAY" type="text" class="InputGrey" id="PAYDAY" readonly></td>
          </tr>
          <tr >
            <td class="blue">��������ʣ�����ʱ��1</td>
            <td><input name="RENTTIME1" type="text" class="InputGrey" id="RENTTIME1" readonly></td>
            <td class="blue">��������ʣ�����ʱ��2</td>
            <td><input name="RENTTIME2" type="text" class="InputGrey" id="RENTTIME2" readonly></td>
          </tr>
          <tr >
            <td class="blue">��������ʣ����ѽ��1</td>
            <td><input name="RENTFEE1" type="text" class="InputGrey" id="RENTFEE1" readonly></td>
            <td class="blue">��������ʣ����ѽ��2</td>
            <td><input name="RENTFEE2" type="text" class="InputGrey" id="RENTFEE2" readonly></td>
          </tr>
          <tr >
            <td colspan="4" id="footer"> <div align="center"> &nbsp; &nbsp; &nbsp;
                <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
                &nbsp; </div></td>
          </tr>
        </table>


    <input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
    <input type="hidden" name="loginName" id="loginName" value="">
    <input type="hidden" name="opCode" id="opCode" value="">
    <input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
    <input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
    <input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">
    <input type="hidden" name="org_id"  value="<%=OrgId%>">
    <input type="hidden" name="group_id"  value="<%=GroupId%>">
			<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

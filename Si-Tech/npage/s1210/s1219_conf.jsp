<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-08-28 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
	String srv_no = request.getParameter("srv_no");
	String iccid = WtcUtil.repNull(request.getParameter("iccid"));
	String comm_addr = WtcUtil.repNull(request.getParameter("comm_addr"));
	String cust_name = WtcUtil.repNull(request.getParameter("cust_name"));
	String cust_id = WtcUtil.repNull(request.getParameter("cust_id"));
	String nopass = (String)session.getAttribute("password");
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String op_code = "1219";
	String paraStr[] = new String[24];
	String stream = WtcUtil.repNull(request.getParameter("loginAccept"));
	System.out.println("stream=" + stream);
	String thework_no = work_no;
	String themob = WtcUtil.repNull(request.getParameter("srv_no"));
	String theop_code = op_code;
%>
<%--@ include file="../../npage/public/fPubSavePrint.jsp" --%>
<%
	/*@service information
	 *@name	s1219Cfm
	 *@description	ӪҵԱ���ݿͻ������룬�����ͻ��ط����ܵ�ҵ��
	 *@author	lugz
	 *@created	20020712 05:01:0
	 *@input parameter information
	 *@inparam	loginAccept		��ˮ	�������룬������������ڷ�����ȡ��ˮ
	 *@inparam	opCode			���ܴ���
	 *@inparam	loginNo			��������
	 *@inparam	loginPasswd		�������ܵĹ�������
	 *@inparam	orgCode			�������Ź���
	 *@inparam	phoneNo			�û��ֻ�����
	 *@inparam	delFuncs		ȡ���ط���	����ԤԼ���ط�����ʽ����'AA|' + 'AA|' + 'AA|' + ���� "AA"��ʾ�ط����룬"|"���ָ�����
	 *@inparam	updUsedFuncs	�޸���Ч���ط���	��ʱ��ʼʱ�䲻���޸ģ���ʽ����'AAYYYYMMDD|' + 'AAYYYYMMDD|' + 'AAYYYYMMDD|' + �� ����"AA"��ʾ�ط����룬"YYYYMMDD"��ʾ�������ڣ�"|"���ָ�����
	 *@inparam	updUnUsedFuncs	�޸�δ��Ч���ط���	��ʱ��ʼʱ��ͽ���ʱ�䶼�����޸ģ�����ʼʱ�������ڵ�ǰʱ�䡣����ʽ��'AAYYYYMMDDYYYYMMDD|' + 'AAYYYYMMDDYYYYMMDD |'  +  'AAYYYYMMDDYYYYMMDD |' + ������"AA"��ʾ�ط����룬"YYYYMMDDYYYYMMDD"��ʾ��ʼ���ں͵������ڣ�"|"��ʾ��ָ�����
	 *@inparam	addUsedFuncs	����������Ч���ط���	 ��ʽ����'AAYYYYMMDD|' + 'AAYYYYMMDD|' + 'AAYYYYMMDD|' + ������ "AA"��ʾ�ط����룬"YYYYMMDD"��ʾ�������ڣ�"|"��ʾ��ָ�����
	 *@inparam	addUnUsedFuncs	����ԤԼ��Ч���ط���	 ��ʽ������ʽ��'AAYYYYMMDDYYYYMMDD|' + 'AAYYYYMMDDYYYYMMDD|'  +  'AAYYYYMMDDYYYYMMDD|' + ������"AA"��ʾ�ط����룬"YYYYMMDDYYYYMMDD"��ʾ��ʼ���ں͵������ڣ�"|"���ָ�����
	 *@inparam	addAddFuncs		���Ӵ��̺ŵ��ط����������ܹ�����ԤԼ	 ��ʽ������ʽ��'AAXXXXXXXX|' + 'AAXXXXXXXX|'  +  'AAXXXXXXXX|' + ������"AA"��ʾ�ط����룬"XXXXXXXX"��ʾ�̺��룬"|"���ָ�����
	 *@inparam	payFee			Ӧ��
	 *@inparam	realFee			ʵ��
	 *@inparam	systemNote		ϵͳ��ע
	 *@inparam	opNote			�û���ע
	 *@inparam	ipAddr			IP��ַ
	 *--------------------------------------------------------------*
	 *@inparam17	cust_name		����������
	 *@inparam18    contact_phone	��������ϵ�绰
	 *@inparam19    id_type			������֤������
	 *@inparam20    id_iccid		������֤������
	 *@inparam21    id_address	 	������֤����ַ
	 *@inparam22    contact_address	��������ϵ��ַ
	 *@inparam23    notes			������ע
	 *--------------------------------------------------------------*
	
	 *@output parameter information
	 *@outparam	loginAccept		��ˮ	�����ڷ��������ɵ���ˮ����ԭ�������ˮ
	 *@return SVR_ERR_NO
	 */
%>
<%
    paraStr[0] = WtcUtil.repNull(request.getParameter("loginAccept"));
    paraStr[1] = op_code;
    paraStr[2] = work_no;
    paraStr[3] = nopass;
    paraStr[4] = org_code;

    paraStr[5] = WtcUtil.repNull(request.getParameter("srv_no"));
    paraStr[6] = WtcUtil.repNull(request.getParameter("delStr"));
    paraStr[7] = WtcUtil.repNull(request.getParameter("modValidStr"));
    paraStr[8] = WtcUtil.repNull(request.getParameter("modInvalidStr"));
    paraStr[9] = WtcUtil.repNull(request.getParameter("addValidStr"));
    paraStr[10] = WtcUtil.repNull(request.getParameter("addInvalidStr"));
    paraStr[11] = WtcUtil.repNull(request.getParameter("addShortnoStr"));

    paraStr[12] = WtcUtil.repNull(request.getParameter("oriHandFee"));
    paraStr[13] = WtcUtil.repNull(request.getParameter("t_handFee"));
    paraStr[14] = WtcUtil.repNull(request.getParameter("t_sys_remark"));
    paraStr[15] = WtcUtil.repSpac(request.getParameter("t_op_remark"));
    paraStr[16] = request.getRemoteAddr();

    paraStr[17] = WtcUtil.repNull(request.getParameter("assuName"));
    paraStr[18] = WtcUtil.repNull(request.getParameter("assuPhone"));
    paraStr[19] = WtcUtil.repNull(request.getParameter("assuIdType"));
    paraStr[20] = WtcUtil.repNull(request.getParameter("assuId"));
    paraStr[21] = WtcUtil.repNull(request.getParameter("assuIdAddr"));
    paraStr[22] = WtcUtil.repNull(request.getParameter("assuAddr"));
    paraStr[23] = WtcUtil.repNull(request.getParameter("assuNote"));

    //String[] fg = co.callService("s1219Cfm", paraStr, "1", "phone", srv_no);
%>
		<wtc:service name="s1219Cfm" routerKey="phone" retCode="initRetCode" retMsg="initRetMsg" routerValue="<%=srv_no%>" outnum="1">
			<wtc:param value="<%=paraStr[0]%>"/>
			<wtc:param value="<%=paraStr[1]%>"/>
			<wtc:param value="<%=paraStr[2]%>"/>
			<wtc:param value="<%=paraStr[3]%>"/>
			<wtc:param value="<%=paraStr[4]%>"/>
			
			<wtc:param value="<%=paraStr[5]%>"/>
			<wtc:param value="<%=paraStr[6]%>"/>
			<wtc:param value="<%=paraStr[7]%>"/>
			<wtc:param value="<%=paraStr[8]%>"/>
			<wtc:param value="<%=paraStr[9]%>"/>
			
			<wtc:param value="<%=paraStr[10]%>"/>
			<wtc:param value="<%=paraStr[11]%>"/>
			<wtc:param value="<%=paraStr[12]%>"/>
			<wtc:param value="<%=paraStr[13]%>"/>
			<wtc:param value="<%=paraStr[14]%>"/>
			
			<wtc:param value="<%=paraStr[15]%>"/>
			<wtc:param value="<%=paraStr[16]%>"/>
			<wtc:param value="<%=paraStr[17]%>"/>
			<wtc:param value="<%=paraStr[18]%>"/>
			<wtc:param value="<%=paraStr[19]%>"/>
				
			<wtc:param value="<%=paraStr[20]%>"/>
			<wtc:param value="<%=paraStr[21]%>"/>
			<wtc:param value="<%=paraStr[22]%>"/>
			<wtc:param value="<%=paraStr[23]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	  System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");		
		String s1219cfmLoginAccept = "";
		if(result!=null&&result.length>0){
			s1219cfmLoginAccept = result[0][0];
			System.out.println("###################################s1210->s1219cfmLoginAccept->"+s1219cfmLoginAccept);
		}
    int s1219CfmRetCode = 999999;
    if(initRetCode!=null&&initRetCode!=""){
    	s1219CfmRetCode = Integer.parseInt(initRetCode);
    }
    String s1219CfmRetMsg = initRetMsg;
    System.out.println("errCode = " + s1219CfmRetCode);
	String cnttActivePhone = srv_no;    
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+paraStr[1]+"&retCodeForCntt="+initRetCode+"&opName=�ط����&workNo="+paraStr[2]+"&loginAccept="+s1219cfmLoginAccept+"&pageActivePhone="+cnttActivePhone+"&retMsgForCntt="+s1219CfmRetMsg+"&opBeginTime="+opBeginTime;
 %>
 	<jsp:include page="<%=url%>" flush="true" />
 <%
 		System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");	
    if (s1219CfmRetCode == 0) {
        if (Double.parseDouble(((paraStr[12].trim().equals("")) ? ("0") : (paraStr[12]))) < 0.01) {
%>
			<script>
			    rdShowMessageDialog("�ͻ�<%=cust_name%>(<%=cust_id%>)���ط�����ѳɹ���", 2);
			    location = "s1219Login.jsp?activePhone=<%=activePhone%>";
			</script>
<%
		} else {
%>
		<script>
		    rdShowMessageDialog("�ͻ�<%=cust_name%>(<%=cust_id%>)���ط�����ѳɹ������潫��ӡ��Ʊ��",2);
		    var infoStr = "";
		
		    infoStr += "<%=iccid%>" + "|";
		    infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";
		    infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
		    infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
		    infoStr += "<%=srv_no%>" + "|";
		    infoStr += " " + "|";
		    infoStr += "<%=cust_name%>" + "|";
		    infoStr += "<%=comm_addr%>" + "|";
		    infoStr += "�ֽ�" + "|";
		    infoStr += "<%=paraStr[12]%>" + "|";
		
		    infoStr += "�ط������*�����ѣ�" + "<%=paraStr[12]%>" + "*��ˮ�ţ�" + "<%=s1219cfmLoginAccept%>" + "|";
		    location = "chkPrint.jsp?retInfo=" + infoStr + "&dirtPage=s1219Login.jsp&?activePhone=<%=activePhone%>";
		</script>
<%
    	}
	} else {
	%>
		<script>
		    rdShowMessageDialog('����<%=s1219CfmRetCode%>��' + '<%=s1219CfmRetMsg%>�������²�����');
		    location = "s1219Login.jsp?activePhone=<%=activePhone%>";
		</script>
<%
    }
%>

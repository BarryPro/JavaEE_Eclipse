<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-08-28 页面改造,修改样式
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
	 *@description	营业员根据客户的申请，增减客户特服功能的业务。
	 *@author	lugz
	 *@created	20020712 05:01:0
	 *@input parameter information
	 *@inparam	loginAccept		流水	可以输入，如果不输入则在服务中取流水
	 *@inparam	opCode			功能代码
	 *@inparam	loginNo			操作工号
	 *@inparam	loginPasswd		经过加密的工号密码
	 *@inparam	orgCode			操作工号归属
	 *@inparam	phoneNo			用户手机号码
	 *@inparam	delFuncs		取消特服串	包括预约的特服，格式：“'AA|' + 'AA|' + 'AA|' + …” "AA"表示特服代码，"|"表结分隔符。
	 *@inparam	updUsedFuncs	修改生效的特服串	此时开始时间不能修改；格式：“'AAYYYYMMDD|' + 'AAYYYYMMDD|' + 'AAYYYYMMDD|' + … ”；"AA"表示特服代码，"YYYYMMDD"表示到期日期，"|"表结分隔符。
	 *@inparam	updUnUsedFuncs	修改未生效的特服串	此时开始时间和结束时间都可以修改，但开始时间必须大于当前时间。；格式：'AAYYYYMMDDYYYYMMDD|' + 'AAYYYYMMDDYYYYMMDD |'  +  'AAYYYYMMDDYYYYMMDD |' + …”；"AA"表示特服代码，"YYYYMMDDYYYYMMDD"表示开始日期和到期日期，"|"表示结分隔符。
	 *@inparam	addUsedFuncs	增加立即生效的特服串	 格式：“'AAYYYYMMDD|' + 'AAYYYYMMDD|' + 'AAYYYYMMDD|' + …”； "AA"表示特服代码，"YYYYMMDD"表示到期日期，"|"表示结分隔符。
	 *@inparam	addUnUsedFuncs	增加预约生效的特服串	 格式：“格式：'AAYYYYMMDDYYYYMMDD|' + 'AAYYYYMMDDYYYYMMDD|'  +  'AAYYYYMMDDYYYYMMDD|' + …”；"AA"表示特服代码，"YYYYMMDDYYYYMMDD"表示开始日期和到期日期，"|"表结分隔符。
	 *@inparam	addAddFuncs		增加带短号的特服串，不能能够进行预约	 格式：“格式：'AAXXXXXXXX|' + 'AAXXXXXXXX|'  +  'AAXXXXXXXX|' + …”；"AA"表示特服代码，"XXXXXXXX"表示短号码，"|"表结分隔符。
	 *@inparam	payFee			应收
	 *@inparam	realFee			实收
	 *@inparam	systemNote		系统备注
	 *@inparam	opNote			用户备注
	 *@inparam	ipAddr			IP地址
	 *--------------------------------------------------------------*
	 *@inparam17	cust_name		担保人姓名
	 *@inparam18    contact_phone	担保人联系电话
	 *@inparam19    id_type			担保人证件类型
	 *@inparam20    id_iccid		担保人证件号码
	 *@inparam21    id_address	 	担保人证件地址
	 *@inparam22    contact_address	担保人联系地址
	 *@inparam23    notes			担保备注
	 *--------------------------------------------------------------*
	
	 *@output parameter information
	 *@outparam	loginAccept		流水	返回在服务中生成的流水，或还原传入的流水
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
	  System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");		
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
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+paraStr[1]+"&retCodeForCntt="+initRetCode+"&opName=特服变更&workNo="+paraStr[2]+"&loginAccept="+s1219cfmLoginAccept+"&pageActivePhone="+cnttActivePhone+"&retMsgForCntt="+s1219CfmRetMsg+"&opBeginTime="+opBeginTime;
 %>
 	<jsp:include page="<%=url%>" flush="true" />
 <%
 		System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");	
    if (s1219CfmRetCode == 0) {
        if (Double.parseDouble(((paraStr[12].trim().equals("")) ? ("0") : (paraStr[12]))) < 0.01) {
%>
			<script>
			    rdShowMessageDialog("客户<%=cust_name%>(<%=cust_id%>)的特服变更已成功！", 2);
			    location = "s1219Login.jsp?activePhone=<%=activePhone%>";
			</script>
<%
		} else {
%>
		<script>
		    rdShowMessageDialog("客户<%=cust_name%>(<%=cust_id%>)的特服变更已成功，下面将打印发票！",2);
		    var infoStr = "";
		
		    infoStr += "<%=iccid%>" + "|";
		    infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";
		    infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
		    infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
		    infoStr += "<%=srv_no%>" + "|";
		    infoStr += " " + "|";
		    infoStr += "<%=cust_name%>" + "|";
		    infoStr += "<%=comm_addr%>" + "|";
		    infoStr += "现金" + "|";
		    infoStr += "<%=paraStr[12]%>" + "|";
		
		    infoStr += "特服变更。*手续费：" + "<%=paraStr[12]%>" + "*流水号：" + "<%=s1219cfmLoginAccept%>" + "|";
		    location = "chkPrint.jsp?retInfo=" + infoStr + "&dirtPage=s1219Login.jsp&?activePhone=<%=activePhone%>";
		</script>
<%
    	}
	} else {
	%>
		<script>
		    rdShowMessageDialog('错误<%=s1219CfmRetCode%>：' + '<%=s1219CfmRetMsg%>，请重新操作！');
		    location = "s1219Login.jsp?activePhone=<%=activePhone%>";
		</script>
<%
    }
%>

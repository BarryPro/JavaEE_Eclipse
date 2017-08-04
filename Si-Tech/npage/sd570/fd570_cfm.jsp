<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2011/5/16 欢乐家庭
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>欢乐家庭</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String printAccept = WtcUtil.repStr(request.getParameter("printAccept"), "");
	String saleType = WtcUtil.repStr(request.getParameter("saleType"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	
	String tdCustName = WtcUtil.repStr(request.getParameter("tdCustName"), "");
	//String tdUserPhone = WtcUtil.repStr(request.getParameter("tdUserPhone"), "");
	String tdCustAddr = WtcUtil.repStr(request.getParameter("tdCustAddr"), "");
	String salePrice = WtcUtil.repStr(request.getParameter("salePrice"), "");
	String brandName = WtcUtil.repStr(request.getParameter("brandName"), "");
	String phoneTypeName = WtcUtil.repStr(request.getParameter("phoneTypeName"), "");
	String imeiCode = WtcUtil.repStr(request.getParameter("imeiCodeT"), "");
	String workName = (String)session.getAttribute("workName");
	
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String opNote = WtcUtil.repStr(request.getParameter("opNote"), "");
	String comboType = WtcUtil.repStr(request.getParameter("comboType"), "");
	String tdUserPhoneStr = WtcUtil.repStr(request.getParameter("tdUserPhoneStr"), "");
	String[] tdUserPhone = tdUserPhoneStr.split(",");
	String gsmUserPhoneStr = WtcUtil.repStr(request.getParameter("gsmUserPhoneStr"), "");
	String[] gsmUserPhone = gsmUserPhoneStr.split(",");
	String mOfferId = WtcUtil.repStr(request.getParameter("mOfferId"), "");
	String aOfferId = WtcUtil.repStr(request.getParameter("aOfferId"), "");
	String tdMOfferIdStr = WtcUtil.repStr(request.getParameter("tdMOfferIdStr"), "");
	String[] tdMOfferId = tdMOfferIdStr.split(",");
	String tdAOfferIdStr = WtcUtil.repStr(request.getParameter("tdAOfferIdStr"), "");
	String[] tdAOfferId = tdAOfferIdStr.split(",");
	String gsmMOfferIdStr = WtcUtil.repStr(request.getParameter("gsmMOfferIdStr"), "");
	String[] gsmMOfferId = gsmMOfferIdStr.split(",");
	String gsmAOfferIdStr = WtcUtil.repStr(request.getParameter("gsmAOfferIdStr"), "");
	String[] gsmAOfferId = gsmAOfferIdStr.split(",");
	String saleStrStr = WtcUtil.repStr(request.getParameter("saleStrStr"), "");
	String[] saleStr = saleStrStr.split(",");
	String tdUserMsgStr = WtcUtil.repStr(request.getParameter("tdUserMsgStr"), "");
	String[] tdUserMsg = tdUserMsgStr.split("~");
  String ipAddr = (String)session.getAttribute("ipAddr");
	String mainFamProdId = WtcUtil.repStr(request.getParameter("mainFamProdId"), "");
	String tdFamProdId = WtcUtil.repStr(request.getParameter("tdFamProdId"), "");
	String gsmFamProdId = WtcUtil.repStr(request.getParameter("gsmFamProdId"), "");
	
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm====0==== inLoginAccept = " + printAccept);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm====4==== iChnSource = 01");
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm====1==== inOpCode = " + opCode);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm====2==== inLoginNo = " + workNo);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm====5==== iLoginPwd = " + password);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm====3==== inPhone = " + activePhone);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm====6==== inUserPwd = ");
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm====7==== iOpNote = " + opNote);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm====8==== iFamilyType = " + comboType);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm====9==== iTDPhone_no数组 = " + tdUserPhoneStr);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm===10==== iGMSPhone_no数组 = " + gsmUserPhoneStr);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm===11==== iMain_moffer_id = " + mOfferId);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm===12==== iMain_aoffer_id = " + aOfferId);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm===13==== iTD_moffer_id数组 = " + tdMOfferIdStr);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm===14==== iTD_aoffer_id数组 = " + tdAOfferIdStr);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm===15==== iGMS_moffer_id数组 = " + gsmMOfferIdStr);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm===16==== iGMS_aoffer_id数组 = " + gsmAOfferIdStr);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm===17==== iSaleStr数组 = " + saleStrStr);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm===18==== iSaleType = " + saleType);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm===19==== iIpAddr = " + ipAddr);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm===20==== iMainFamProdId = " + mainFamProdId);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm===21==== iTDFamProdId = " + tdFamProdId);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm===22==== iGSMFamProdId = " + gsmFamProdId);
	
%>
	<wtc:service name="sd570Cfm" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value="<%=comboType%>"/>
		<wtc:params value="<%=tdUserPhone%>"/>
		<wtc:params value="<%=gsmUserPhone%>"/>
		<wtc:param value="<%=mOfferId%>"/>
		<wtc:param value="<%=aOfferId%>"/>
		<wtc:params value="<%=tdMOfferId%>"/>
		<wtc:params value="<%=tdAOfferId%>"/>
		<wtc:params value="<%=gsmMOfferId%>"/>
		<wtc:params value="<%=gsmAOfferId%>"/>
		<wtc:params value="<%=saleStr%>"/>
		<wtc:param value="<%=saleType%>"/>
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value="<%=mainFamProdId%>"/>
		<wtc:param value="<%=tdFamProdId%>"/>
		<wtc:param value="<%=gsmFamProdId%>"/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
	
<%
	System.out.println("====wanghfa====fd570_main.jsp====sd570Cfm==== " + retCode1 + ", " + retMsg1);
	
//为统一接触  start
	String myOpBeginTime = new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
	System.out.println("%%%%d570%%%调用统一接触开始%%%%%%%%");
	String url = "/npage/contact/upCnttInfo.jsp?opCode=" + opCode + "&opName=" + opName + "&workNo="
		+ workNo + "&retCodeForCntt=" + retCode1 + "&loginAccept=" + printAccept + "&pageActivePhone="
		+ activePhone + "&contactType=user&contactId=" + activePhone + "&retMsgForCntt=" + retMsg1
		+ "&opBeginTime=" + myOpBeginTime;
	System.out.println("url = " + url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	System.out.println("%%%%d570%%%调用统一接触结束%%%%%%%%");
//为统一接触  end
	
	
	if ("000000".equals(retCode1)) {
		String chinaFee = "";
		int i = 0;
		if (!"0".equals(tdUserMsg[i].split("\\|")[3])) {
			%>
				<script language="javascript">
					rdShowMessageDialog("业务办理申请成功！打印发票......", 2);
			<%
				System.out.println("====wanghfa====fd570_main.jsp====sToChinaFee==== salePrice = " + tdUserMsg[i].split("\\|")[3]);
			%>
				<wtc:service name="sToChinaFee" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCodeCf" retmsg="retMsgCf" outnum="3" >
					<wtc:param value="<%=tdUserMsg[i].split(\"\\\|\")[3]%>"/>
				</wtc:service>
				<wtc:array id="chinaFeeArr" scope="end"/>
			<%
				System.out.println("====wanghfa====fd570_main.jsp====sToChinaFee: " + retCodeCf + " " + retMsgCf);
				if(("000000".equals(retCodeCf) || ("0".equals(retCodeCf))) && chinaFeeArr != null && chinaFeeArr.length > 0) {
					chinaFee = chinaFeeArr[0][2];
				}
			%>
				var infoStr="";
				infoStr+="<%=workNo%>  <%=printAccept%>"+"       <%=opName%>"+"|";
				infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
				infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				infoStr+='<%=tdUserMsg[i].split("\\|")[0]%>'+"|";//用户名称
				infoStr+=""+"|";//合同号码
				infoStr+="<%=tdUserMsg[i].split("\\|")[1]%>"+"|";//移动号码
				infoStr+="<%=tdUserMsg[i].split("\\|")[2]%>"+"|";//用户地址
				infoStr+=""+"|";
				
				infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
				infoStr+="<%=tdUserMsg[i].split("\\|")[3]%>"+"|";//小写 
				infoStr += "备注：办理欢乐家庭业务赠送TD固话一部。~";
				
				infoStr += "TD固话品牌型号：<%=tdUserMsg[i].split("\\|")[4]%> <%=tdUserMsg[i].split("\\|")[5]%>~";
				infoStr += "TD固话号码：<%=tdUserMsg[i].split("\\|")[1]%>~";
				infoStr += "IMEI码：<%=tdUserMsg[i].split("\\|")[6]%>|";
				infoStr+="<%=workName%>"+"|";//开票人
				infoStr+=" "+"|";//收款人
				location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/sd570/fd570.jsp?opCode=<%=opCode%>%26opName=<%=opName%>%26activePhone=<%=activePhone%>";
			</script>
			<%
			
		} else {
		%>
			<script language="javascript">
				rdShowMessageDialog("业务办理申请成功！", 2);
				window.location = "fd570.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
			</script>
		<%
		}
%>
		</script>
<%
	} else {
%>
		<script language="javascript">
			rdShowMessageDialog("sd570Cfm服务：<%=retCode1%>，<%=retMsg1%>", 0);
			window.location = "fd570.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
		</script>
<%
	}
%>

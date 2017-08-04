<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-08
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%	
    	//String[][] result = new String[][]{};
    	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
    	//ArrayList retArray = new ArrayList();
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	//String ip_Addr = request.getRemoteAddr();  
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String cust_name=request.getParameter("cust_name");
	String card_info=request.getParameter("cardy");
	String card_money=request.getParameter("card_money");
	
	String prepay_fee=request.getParameter("pay_money");
	String print2=request.getParameter("print2");
	String phone_typename=request.getParameter("phone_typename");
	String gift_name=request.getParameter("gift_name");
	String stream=request.getParameter("login_accept");
	String thework_no=work_no;
	String themob=request.getParameter("phone_no");
	String theop_code=request.getParameter("opcode");
  	
	String paraAray[] = new String[9];
    paraAray[0] =request.getParameter("login_accept");
    paraAray[1] = request.getParameter("opcode");
    paraAray[2] = work_no;
    paraAray[3] = request.getParameter("phone_no");
    paraAray[4] = request.getParameter("mode_code");
    paraAray[5] = (request.getParameter("sum_money")).trim();
    paraAray[6] = request.getParameter("opNote");
    paraAray[7] = request.getParameter("ip_Addr");
    paraAray[8] = request.getParameter("back_accept");
    
	//String[] ret = impl.callService("s2297Cfm",paraAray,"2","region",org_code.substring(0,2));
%>

<wtc:service name="s2297Cfm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="s2297CfmCode" retmsg="s2297CfmMsg" outnum="2">
	<wtc:param value="<%=paraAray[0]%>"/> 
	<wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/> 
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/>
    <wtc:param value="<%=paraAray[6]%>"/>
    <wtc:param value="<%=paraAray[7]%>"/>
    <wtc:param value="<%=paraAray[8]%>"/>
</wtc:service>
<wtc:array id="s2297CfmArr" scope="end" />

<%
	String errCode = s2297CfmCode;
	String errMsg = s2297CfmMsg;
	System.out.println("in f2297_2.jsp - s2297Cfm :  "+errCode+" : "+errMsg);
    System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+"2297"+"&retCodeForCntt="+errCode+"&opName="+"无线音乐俱乐部包年(季)会员冲正"+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+themob+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%

    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
    
	if (errCode.equals("000000"))
	{
	    String chinaFee = "";
        //S1100View callView = new S1100View();
        //String chinaFee = ((String[][])(callView.view_sToChinaFee(WtcUtil.formatNumber(paraAray[5],2)).get(0)))[0][2];//大写金额
%>
    <wtc:service name="sToChinaFee" routerKey="phone" routerValue="<%=themob%>" retcode="sToChinaFeeCode" retmsg="sToChinaFeeMsg" outnum="3">
        <wtc:param value="<%=WtcUtil.formatNumber(paraAray[5],2)%>"/>
    </wtc:service>
    <wtc:array id="result" scope="end"/>
<%
        if(result.length>0 && sToChinaFeeCode.equals("0")){
            chinaFee = result[0][2];
        }
        System.out.print("chinaFee   ===   "+chinaFee);
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功！",2);
   window.location="f2296_login.jsp?activePhone=<%=themob%>&opCode=2297&opName=无线音乐俱乐部包年(季)会员冲正";
   /**************20090323刘春梅修改，不交现金不打发票
   var infoStr="";
   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       无线音乐包年用户申请"+"|";//工号  
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";//卡号
   infoStr+='<%=paraAray[3]%>'+"|";
   infoStr+=" "+"|";//协议号码               
   infoStr+=" "+"|";//协议号码                                                     
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=WtcUtil.formatNumber(paraAray[5],2)%>"+"|";//小写 
   var jkinfo="";
   jkinfo+="缴款合计：  <%=paraAray[5]%>元"+"~"+
		 "包年类型: <%=phone_typename%>"+"~"+
		 "礼品名称：<%=gift_name%>";
    infoStr+=jkinfo+"|";
    infoStr+="<%=work_name%>"+"|";//开票人
    infoStr+=" "+"|";//收款人
   
   location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s2292/f2296_login.jsp?activePhone=<%=themob%>%26opCode=2297%26opName=无线音乐俱乐部包年(季)会员冲正";

****/
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("无线音乐包年(季)用户申请失败!(<%=errMsg%>");
	window.location="f2296_login.jsp?activePhone=<%=themob%>&opCode=2297&opName=无线音乐俱乐部包年(季)会员冲正";
</script>
<%}%>

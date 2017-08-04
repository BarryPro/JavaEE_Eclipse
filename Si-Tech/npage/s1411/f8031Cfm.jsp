<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-6
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>   

<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>


<%	
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	
	
	String cust_name=request.getParameter("cust_name"); 
	String sum_money=request.getParameter("sum_money");
	String prepay_fee=request.getParameter("limit_pay"); 
	String sale_name=request.getParameter("sale_name");
	String card_info=request.getParameter("");
	String card_money=request.getParameter("");   
	String machine_type=request.getParameter("machine_type");
	String paraAray[] = new String[6];
	String opNamew = request.getParameter("opName");
	String opCodew = request.getParameter("opCode");
	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("phone_no");
	paraAray[2] = request.getParameter("opcode");
  paraAray[3] = work_no;
  paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");
  String vUnitId =  request.getParameter("vUnitId");
  String chinaFee="";
    	
	
              

	//String[] ret = impl.callService("s8031Cfm",paraAray,"2","region",regionCode);
%>

    <wtc:service name="s8031Cfm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />	
			<wtc:param value="<%=paraAray[3]%>" />
			<wtc:param value="<%=paraAray[4]%>" />
			<wtc:param value="<%=paraAray[5]%>" />			
		</wtc:service>

<%	
	String errCode = code1;
	String errMsg = msg1;
%>

<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCodew+
								 "&retCodeForCntt="+errCode+
								 "&retMsgForCntt="+errMsg+
	               "&opName="+opNamew+
     	    			 "&workNo="+work_no+
     	    			 "&loginAccept="+paraAray[4]+
     	    			 "&pageActivePhone="+paraAray[1]+
     	    			 "&opBeginTime="+opBeginTime+
     	    			 "&contactId="+paraAray[1]+
     	    			 "&contactType=user";%>
     	    			 
<jsp:include page="<%=url%>" flush="true" />

<%	
	if (errCode.equals("000000") )
	{
		//S1100View callView = new S1100View();
		//String chinaFee = ((String[][])(callView.view_sToChinaFee(WtcUtil.formatNumber(sum_money,2)).get(0)))[0][2];//大写金额
%>
	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" retcode="sToChinaFeeCode" retmsg="sToChinaFeeMsg" outnum="3">
		<wtc:param value="<%=WtcUtil.formatNumber(sum_money,2)%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
    if(result.length>0 && sToChinaFeeCode.equals("0")){
        chinaFee = result[0][2];
    }
			
	System.out.print("------------------------chinaFee-------------------"+chinaFee);
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功! 下面将打印发票！");
   var infoStr="";
   infoStr+="<%=work_no%>  <%=work_name%>"+"       集团用户预存话费优惠购机冲正"+"|";//工号  
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[1]%>'+"|";
   infoStr+=" "+"|";//协议号码                                                          
   infoStr+="手机型号："+"<%=machine_type%>"+"|";//手机型号 
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=WtcUtil.formatNumber(sum_money,2)%>"+"|";//小写 
   infoStr+="退款合计：  <%=sum_money%>"+
		 "含预存话费： <%=prepay_fee%>"+"|";
		

	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
  // location="/page/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/page/s1775/f1775_1.jsp";
   var dirtPage="/npage/s1141/f8030.jsp?opCode=<%=opCodew%>&opName=<%=opNamew%>&activePhone=<%=paraAray[1]%>"
   location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPage);
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("集团用户预存话费优惠购机冲正失败!(<%=errMsg%>");
		 location="f8030.jsp?opCode=<%=opCodew%>&opName=<%=opNamew%>&activePhone=<%=paraAray[1]%>";
</script>
<%}%>

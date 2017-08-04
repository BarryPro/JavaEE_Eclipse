<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-04
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.ErrorMsg"%>

<%@ include file="../../include/title_name.jsp" %>


 <%
    String srv_no=request.getParameter("srv_no");
    String chgcode=request.getParameter("chgcode");
	String cus_name=WtcUtil.repNull(request.getParameter("cus_name"));
    String cus_addr=WtcUtil.repNull(request.getParameter("cus_addr"));
	String cus_id=WtcUtil.repNull(request.getParameter("cus_id"));

	String nopass = (String)session.getAttribute("password");
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    
   	String paraStr[]=new String[29];
	paraStr[0]= WtcUtil.repNull(request.getParameter("loginAccept"));
 	paraStr[1]=op_code;
 	paraStr[2]=work_no;
	paraStr[3]=nopass;
	paraStr[4]=org_code;
    paraStr[5]=WtcUtil.repNull(request.getParameter("cus_id"));
  	paraStr[6]=WtcUtil.repNull(request.getParameter("simOldNo"));
	paraStr[7]=WtcUtil.repNull(request.getParameter("s_oldStatus"));
	paraStr[8]=WtcUtil.repNull(request.getParameter("t_newsimf"));
 	paraStr[9]=WtcUtil.repNull(request.getParameter("oriSimFee"));
	paraStr[10]=WtcUtil.repNull(request.getParameter("t_simFeef"));
 	paraStr[11]=WtcUtil.repNull(request.getParameter("oriHandFee"));
	paraStr[12]=WtcUtil.repNull(request.getParameter("t_handFee"));
    paraStr[13]=WtcUtil.repNull(request.getParameter("t_sys_remark"));
    paraStr[14]=WtcUtil.repSpac(request.getParameter("t_op_remark"));
	paraStr[15]=request.getRemoteAddr();

	paraStr[16]=WtcUtil.repNull(request.getParameter("assuName"));
	paraStr[17]=WtcUtil.repNull(request.getParameter("assuPhone"));
	paraStr[18]=WtcUtil.repNull(request.getParameter("assuIdType"));
	paraStr[19]=WtcUtil.repNull(request.getParameter("assuId"));
	paraStr[20]=WtcUtil.repNull(request.getParameter("assuIdAddr"));
	paraStr[21]=WtcUtil.repNull(request.getParameter("assuAddr"));
	paraStr[22]=WtcUtil.repNull(request.getParameter("assuNote"));
	paraStr[23]=chgcode;
	paraStr[24]=WtcUtil.repNull(request.getParameter("srv_no"));
	paraStr[25]=WtcUtil.repNull(request.getParameter("phone_z"));
	paraStr[26]=request.getParameter("cardtype_bz");
	paraStr[27]=request.getParameter("cardstatus");
	paraStr[28]=request.getParameter("cardNo");
	
  
    String totalFee=String.valueOf(Double.parseDouble(((paraStr[10].trim().equals(""))?("0"):(paraStr[10])))+Double.parseDouble(((paraStr[12].trim().equals(""))?("0"):(paraStr[12]))));
        //SPubCallSvrImpl co=new SPubCallSvrImpl();
 	//if(Double.parseDouble(totalFee)<0.01)    
        //paraStr[0]="0";
    //else
	//{
	   /*
 	   String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
	   ArrayList  retList = co.sPubSelect("1",prtSql);
	   paraStr[0]=(((String[][])retList.get(0))[0][0]).trim();
	  */
 	//}
    String[] fg=new String[3];
        //String[] fg=co.callService("s1442Cfm",paraStr,"3","phone",srv_no);
%>
<wtc:service name="s1442Cfm" routerKey="phone" routerValue="<%=srv_no%>" retcode="s1442CfmCode" retmsg="s1442CfmMsg" outnum="3">
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
    <wtc:param value="<%=paraStr[24]%>"/>
    
    <wtc:param value="<%=paraStr[25]%>"/>
    <wtc:param value="<%=paraStr[26]%>"/>
    <wtc:param value="<%=paraStr[27]%>"/>
    <wtc:param value="<%=paraStr[28]%>"/>
</wtc:service>
<wtc:array id="s1442CfmArr" scope="end" />
<%
	String retCode = s1442CfmCode;
	String retMsg = s1442CfmMsg;
	System.out.println("xxxxxxxv retCode = " + String.valueOf(retCode) + retMsg);
	
    System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+"1442"+"&retCodeForCntt="+retCode+"&opName="+"SIM卡营销"+"&workNo="+work_no+"&loginAccept="+paraStr[0]+"&pageActivePhone="+srv_no+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%

    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
    
    if(s1442CfmArr.length>0 && retCode.equals("000000")){
    	for(int i = 0; i < s1442CfmArr[0].length; i++)
    	{
    	    fg[i] = s1442CfmArr[0][i];
    	}
    }

   if(retCode.equals("000000"))
   {

 	  if(Double.parseDouble(totalFee)<0.01)    
 	  {
%>
        <script>
	     rdShowMessageDialog("客户<%=cus_name%>(<%=cus_id%>)<%=op_name%>已成功！",2);
         location="s1442.jsp?op_code=<%=op_code%>&activePhone=<%=srv_no%>";
	    </script>
<%
	  }
	  else
	  {
%>
        <script>
	     rdShowMessageDialog("客户<%=cus_name%>(<%=cus_id%>)<%=op_name%>已成功，下面将打印发票！");
 		 var infoStr="";
	 
	     infoStr+='<%=work_no%>'+"  "+'<%=fg[2].trim()%>'+"  "+'<%=op_name%>'+"|";
         infoStr+='<%=new java.text.SimpleDateFormat("yyyy   MM    dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+="<%=cus_name%>"+"|";
	     infoStr+=""+"|";
	     infoStr+="<%=srv_no%>"+"|";
	     infoStr+=""+"|";
	     infoStr+=""+"|";
		 infoStr+='<%=totalFee%>'+"|";
	     infoStr+="<%=op_name%>。*手续费："+"<%=paraStr[12]%>"+"*SIM卡费："+"<%=paraStr[10]%>"+"|";
 		 infoStr+=""+"|";
 		 infoStr+="备注："+"用户 "+'<%=srv_no%>'+" 打印发票"+"|";
 		 infoStr+='<%=loginName%>'+"|";
 		 location="<%=request.getContextPath()%>/npage/innet/chkPrintNew.jsp?retInfo="+infoStr+"&dirtPage=<%=request.getContextPath()%>/npage/s1442/s1442.jsp?op_code=<%=op_code%>%26activePhone=<%=srv_no%>";
	    </script>
<%
	  }
   }
   else
   {
%>
     <script>
	   rdShowMessageDialog('错误<%=retCode%>：'+'<%=retMsg%>，请重新操作！');
	  location="s1442.jsp?op_code=<%=op_code%>&activePhone=<%=srv_no%>";
	 </script>
<%
   }
%>

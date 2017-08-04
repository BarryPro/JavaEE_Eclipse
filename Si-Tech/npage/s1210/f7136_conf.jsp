<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.ErrorMsg"%>

<%
  request.setCharacterEncoding("GBK");
%>

 <%
    String srv_no=request.getParameter("srv_no");
	String iccid=WtcUtil.repNull(request.getParameter("iccid"));
	String comm_addr=WtcUtil.repNull(request.getParameter("comm_addr"));
	String cust_name=WtcUtil.repNull(request.getParameter("cust_name"));
	String cust_id=WtcUtil.repNull(request.getParameter("cust_id"));
 
	String nopass = (String)session.getAttribute("password");
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
	String op_code = "7136";
	
  	String paraStr[]=new String[7];
	paraStr[0]=WtcUtil.repNull(request.getParameter("loginAccept"));
 	paraStr[1]=work_no;
 	paraStr[2]=WtcUtil.repNull(request.getParameter("srv_no"));
 	String bz=WtcUtil.repNull(request.getParameter("bz"));
 	paraStr[3]=WtcUtil.repNull(request.getParameter("bz"));
 	if(bz.equals("0")){
     	paraStr[4]=WtcUtil.repNull(request.getParameter("yu_funccode"));
     	paraStr[5]=WtcUtil.repNull(request.getParameter("yu_begin"));
     	paraStr[6]=WtcUtil.repNull(request.getParameter("yu_end"));
    }else{
    	paraStr[4]=WtcUtil.repNull(request.getParameter("function_code"));
     	paraStr[5]=WtcUtil.repNull(request.getParameter("new_begin"));
     	paraStr[6]=WtcUtil.repNull(request.getParameter("new_end"));
	}
	
   

 	String oriHandFee=WtcUtil.repNull(request.getParameter("oriHandFee"));
	
  
   //SPubCallSvrImpl co=new SPubCallSvrImpl();
 	/*if(Double.parseDouble(((paraStr[12].trim().equals(""))?("0"):(paraStr[12])))<0.01)    
     paraStr[0]="0";
    else
	{     
 	   String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
	   paraStr[0]=(((String[][])co.fillSelect(prtSql))[0][0]).trim();
 	}
    */
    String[] fg = new String[2];
    //String[] fg=co.callService("s7136Cfm", paraStr, "2", "phone",srv_no);
%>
<wtc:service name="s7136Cfm" routerKey="phone" routerValue="<%=srv_no%>" retcode="s7136CfmCode" retmsg="s7136CfmMsg" outnum="2">
    <wtc:param value="<%=paraStr[0]%>"/>
    <wtc:param value="<%=paraStr[1]%>"/>
    <wtc:param value="<%=paraStr[2]%>"/>
    <wtc:param value="<%=paraStr[3]%>"/>
    <wtc:param value="<%=paraStr[4]%>"/>
    <wtc:param value="<%=paraStr[5]%>"/>
    <wtc:param value="<%=paraStr[6]%>"/>
</wtc:service>
<wtc:array id="s7136CfmArr" scope="end" />
<%

	String retCode = s7136CfmCode;
	String retMsg = s7136CfmMsg;
    System.out.println("errCode = " + String.valueOf(retCode)); 
    
    System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+"7136"+"&retCodeForCntt="+retCode+"&opName="+"资费绑定特服变更"+"&workNo="+work_no+"&loginAccept="+paraStr[0]+"&pageActivePhone="+paraStr[2]+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%

    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
    
    if(s7136CfmArr.length>0 && retCode.equals("000000")){
    	for(int i = 0; i < s7136CfmArr[0].length; i++)
    	{
    	    fg[i] = s7136CfmArr[0][i];
    	}
    }
    
   if(retCode.equals("000000"))
   {
	   
 	if(Double.parseDouble(((oriHandFee.trim().equals(""))?("0"):(oriHandFee)))<0.01)    
	  {
		 
%>
        <script>
	      rdShowMessageDialog("客户<%=cust_name%>(<%=cust_id%>)的资费绑定特服变更已成功！",2);
          location="f7136_1.jsp?activePhone=<%=paraStr[2]%>";
	    </script>
<%
	  }
	  else
	  {
%>
        <script>
	     rdShowMessageDialog("客户<%=cust_name%>(<%=cust_id%>)的资费绑定特服变更已成功，下面将打印发票！",2);
 		 var infoStr="";
	 
	     infoStr+="<%=iccid%>"+"|";
         infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+="<%=srv_no%>"+"|";
	     infoStr+=" "+"|";
	     infoStr+="<%=cust_name%>"+"|";
	     infoStr+="<%=comm_addr%>"+"|";
  		 infoStr+="现金"+"|";
		 infoStr+="<%=oriHandFee%>"+"|";

	     infoStr+="资费绑定特服变更。*手续费："+"<%=oriHandFee%>"+"*流水号："+"<%=paraStr[0].trim()%>"+"|";
		 location="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=f7136_1.jsp&activePhone=<%=paraStr[2]%>";
	    </script>
<%
	  }
   }
   else
   {
%>
     <script>
	   rdShowMessageDialog('错误<%=retCode%>：'+'<%=retMsg%>，请重新操作！',0);
	   location="f7136_1.jsp?activePhone=<%=paraStr[2]%>";
	 </script>
<%
   }
%>

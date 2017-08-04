<%
/********************
 *version v2.0
 *开发商: si-tech
 *update by qidp @ 2008-12-30
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%	
    	//String[][] result = new String[][]{};
    	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
    	//ArrayList retArray = new ArrayList();
    	//S1100View callView = new S1100View();
    	
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	String paraAray[] = new String[11];
    String phoneNo = (String)request.getParameter("phoneno");
	String login_Accept = (String)request.getParameter("login_Accept");
    paraAray[0] = login_Accept; //流水                        
    paraAray[1] = work_no; //工号                            
    paraAray[2] = org_code;//归属代码                        
    paraAray[3] = request.getParameter("work_Pwd"); //操作密码                       
    paraAray[4] = "m281"; //操作代码                        
    paraAray[5] = request.getParameter("phoneno");  //手机                           
    paraAray[6] = request.getParameter("billDate"); //日期                           
    paraAray[7] = request.getParameter("loginAccept").trim(); //原始交易流水              
    paraAray[8] = "m280"; //原始交易代码                                                                         
    paraAray[9] = request.getParameter("remark");  //备注                                                                                            
    paraAray[10] =  request.getRemoteAddr(); //IP地址            
    System.out.println("login_Acceptlogin_Acceptlogin_Acceptlogin_Acceptlogin_Accept"+login_Accept);              
	    //String[] ret = impl.callService("s1220BackCfm",paraAray,"3","phone",request.getParameter("phoneno"));
%>
    <wtc:service name="s1220BackCfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s1220BackCfmCode" retmsg="s1220BackCfmMsg" outnum="5">
        <wtc:param value="<%=paraAray[0]%>"/>
        <wtc:param value="<%=paraAray[1]%>"/>
        <wtc:param value="<%=paraAray[2]%>"/>
        <wtc:param value="<%=paraAray[3]%>"/>
        <wtc:param value="<%=paraAray[4]%>"/>
        <wtc:param value="<%=paraAray[5]%>"/>
        <wtc:param value="<%=paraAray[6]%>"/>
        <wtc:param value="<%=paraAray[7]%>"/>
        <wtc:param value="<%=paraAray[8]%>"/>
        <wtc:param value="<%=paraAray[9]%>"/>
        <wtc:param value="<%=paraAray[10]%>"/>
    </wtc:service>
    <wtc:array id="s1220BackCfmArr" scope="end"/>
<%
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>s1220BackCfmArr ====== "+s1220BackCfmArr[0][2]);
    System.out.println("1221retCode=   "+s1220BackCfmCode);
    System.out.println("1221retMsg=   "+s1220BackCfmMsg);
    
    System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+"1221"+"&retCodeForCntt="+s1220BackCfmCode+"&opName="+"换卡冲正"+"&workNo="+paraAray[1]+"&loginAccept="+s1220BackCfmArr[0][0]+"&pageActivePhone="+paraAray[5]+"&retMsgForCntt="+s1220BackCfmMsg+"&opBeginTime="+opBeginTime;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%

    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
    
	String errMsg = s1220BackCfmMsg;
	String loginAccept = "";
    //===========================================
    //组织打印数据开始
	String login_accept = request.getParameter("loginAccept");
	String custName = request.getParameter("custName");
	String phone_no = request.getParameter("phoneno");
	String sumPay = request.getParameter("oldFee");
	if(sumPay==null || sumPay.trim().equals("")) sumPay="0";
	String chinaFee = "";
	String printInfo = "";
	System.out.println("====wanghfa==== f1221BackCfm.jsp Double.parseDouble(sumPay) = " + Double.parseDouble(sumPay));
 	
 	String printInfo1 = "";
 	String simfee = "";
 	String simName = "";
	//=========================================
	//组织打印数据结束
	if (s1220BackCfmArr.length > 0 && s1220BackCfmCode.equals("000000"))
	{
	    loginAccept = s1220BackCfmArr[0][2];
	    simfee = s1220BackCfmArr[0][3];
	    simName = s1220BackCfmArr[0][4];
		if(Double.parseDouble(sumPay)>0.01){
%>
	
            <!--script language="JavaScript">
            	rdShowMessageDialog("换卡冲正成功！");
            	history.go(-1);
            </script-->
        <script language='jscript'>
        	rdShowMessageDialog("补卡变更冲正成功！");
        	
        				var  billArgsObj = new Object();
						$(billArgsObj).attr("10001","<%=work_no%>");       //工号
						$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
						$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
						$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
						$(billArgsObj).attr("10005","<%=custName%>"); //客户名称
						$(billArgsObj).attr("10006","补卡变更冲正"); //业务类别
						$(billArgsObj).attr("10008","<%=phone_no%>"); //用户号码
						$(billArgsObj).attr("10015", "-<%=WtcUtil.formatNumber(sumPay,2)%>");   //本次发票金额
						$(billArgsObj).attr("10016", "-<%=WtcUtil.formatNumber(sumPay,2)%>");   //大写金额合计	
						$(billArgsObj).attr("10017","*"); //本次缴费现金
						$(billArgsObj).attr("10030","<%=paraAray[7]%>"); //流水号--业务流水
						$(billArgsObj).attr("10036","m281"); //操作代码	
						$(billArgsObj).attr("10041","SIM卡"); //品名规格     
						$(billArgsObj).attr("10042","张"); //单位         
						$(billArgsObj).attr("10043","1"); //数量         
						$(billArgsObj).attr("10044","-<%=WtcUtil.formatNumber(simfee,2)%>"); //单价         
						$(billArgsObj).attr("10061","<%=simName%>"); //sim卡型号
						$(billArgsObj).attr("10071","7"); //模版
						$(billArgsObj).attr("10072","2"); //模版
						var h=180;
						var w=350;
						var t=screen.availHeight/2-h/2;
						var l=screen.availWidth/2-w/2;
						var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
						
						var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=换卡冲正成功,下面将打印发票！";
						var loginAccept = "<%=login_accept%>";
						var path = path + "&loginAccept="+loginAccept+"&opCode=1221&submitCfm=Single";
						var ret=window.showModalDialog(path, billArgsObj, prop);
						location="fm281.jsp?activePhone=<%=phoneNo%>";
						window.close();
/*
            var h=180;
            var w=360;
            var t=screen.availHeight/2-h/2;
            var l=screen.availWidth/2-w/2;
            var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
            var path = "spubPrint_1104.jsp?DlgMsg=" + "换卡冲正成功,下面将打印发票！";
            var path = path + "&printInfo=<%=printInfo%>&printInfo1=<%=printInfo1%>&submitCfm=Single";
            var ret=window.showModalDialog(path,"",prop); 			
            window.location="s1221_1.jsp?activePhone=<%=phoneNo%>";
*/
        </script>
<%
	
		}else{
			%>
			 <script language="JavaScript">
          	rdShowMessageDialog("补卡变更冲正成功！");
          	location="fm281.jsp?activePhone=<%=phoneNo%>";
						window.close();
       </script>
			<%
	}
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("补卡变更冲正失败!(<%=errMsg%>",0);
	history.go(-1);
</script>
<%}
%>


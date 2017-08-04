   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-12
********************/
%>
              
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.StringTokenizer"%>

<%
    ArrayList retArray = null;
    String error_code = "";
    String error_msg = "";
    Logger logger = Logger.getLogger("f3717_delete.jsp");
    String url="";
	String[] retStr = null;
  String iLoginAccept    = request.getParameter("login_accept");     //操作流水号
  String iWorkNo         = request.getParameter("WorkNo");           //操作员工号
  String iLogin_Pass     = request.getParameter("NoPass");           //操作员密码
  String iOrgCode        = request.getParameter("OrgCode");          //操作员机构代码
  String iSys_Note       = request.getParameter("sysnote");          //系统操作备注
  String iOp_Note        = request.getParameter("tonote");           //用户操作备注
  String iIpAddr         = request.getParameter("ip_Addr");          //操作员IP地址
  String iGrp_Id         = request.getParameter("id_no");            //集团用户ID	 
	String idcMebNo        = request.getParameter("cust_code");          //IDC用户编码
	//add by baixf 20070606
	String unit_id     =request.getParameter("unit_id");	
	
	//

	String iPay_Type	   = "0";     //付款方式
	String iCash_Pay	   = "0";     //支付金额
	String iCheck_No	   = "0";     //支票号码
	String iBank_Code	   = "0";     //银行代码
	String iCheck_Pay	   = "0";     //支票交款
	String iShouldHandFee  = "0";   //应收手续费
  String iHandFee        = "0";     //实收手续费
	String feeList="";//费用信息
	feeList=iPay_Type+"~"+iCheck_No+"~"+iBank_Code+"~"+iCheck_Pay+"~"+iCash_Pay+"~"+iShouldHandFee+"~"+iHandFee+"~";

    String iRegion_Code = iOrgCode.substring(0,2);
    try
    {		
			String paramsIn[] = new String[11];

            paramsIn[0] = iLoginAccept    ;
            paramsIn[1] = "3719"         ;
            paramsIn[2] = iWorkNo         ;
            paramsIn[3] = iLogin_Pass     ;
            paramsIn[4] = iOrgCode        ;
            paramsIn[5] = iSys_Note       ;
            paramsIn[6] = iOp_Note        ;
            paramsIn[7] = iIpAddr         ;
            paramsIn[8] = iGrp_Id         ;
            paramsIn[9] = idcMebNo        ;
            paramsIn[10] = feeList         ;

		//	retStr = callView.callService("s3717del", paramsIn, "1", "region", iRegion_Code);
		
		%>
		
    <wtc:service name="s3717del" outnum="10" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=iRegion_Code%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />	
			<wtc:param value="<%=paramsIn[2]%>" />	
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />		
			<wtc:param value="<%=paramsIn[5]%>" />	
			<wtc:param value="<%=paramsIn[6]%>" />
			<wtc:param value="<%=paramsIn[7]%>" />
			<wtc:param value="<%=paramsIn[8]%>" />
			<wtc:param value="<%=paramsIn[9]%>" />				
			<wtc:param value="<%=paramsIn[10]%>" />
		</wtc:service>
		
		<%
            url = "/npage/contact/onceCnttInfo.jsp?opCode=3719&retCodeForCntt="+code+"&retMsgForCntt="+msg+"&opName=BlackBerry成员删除&workNo="+iWorkNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";		
            error_code = code;
            error_msg= msg;
            System.out.println("-----------------error_code------------"+error_code);
            System.out.println("-----------------error_msg------------"+error_msg);
            System.out.println("error_code="+error_code+";error_msg="+error_msg);
    }catch(Exception e){
				e.printStackTrace();
        logger.error("Call s3717del is Failed!");
    }

    if(error_code.equals("000000"))
    {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_msg%>",2);
            location = "f3717_1.jsp?opCode=3719&opName=BlackBerry成员删除";
        </script>
<%  } else {
%>
        <script language='jscript'>
                     
            var path="<%=request.getContextPath()%>/npage/s3717/f3717_2_printxls.jsp?phoneNo=" + "<%=idcMebNo%>";
            
	   		if (rdShowConfirmDialog("<br>错误代码:"+"<%=error_code%></br>"+"错误信息:"+"<%=error_msg%>"+"<br>是否保存错误信息？")==1)	
			{
				path = path + "&returnMsg=" + "<%=error_msg%>"+ "&unitID=" + "<%=unit_id%>";
	  			path = path + "&op_Code="+"8888";
	  			path = path + "&orgCode=" + "<%=iOrgCode%>";
				window.open(path);
			}	
           location = "f3717_1.jsp?opCode=3719&opName=BlackBerry成员删除";
        </script>
<%
    }
%>
  <jsp:include page="<%=url%>" flush="true" />
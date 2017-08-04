 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-20 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	
	String opName =  request.getParameter("opName");	//header.jsp需要的参数   
	 
	String error_msg="null";
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	
	String error_code = "";
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误
    	String[] retStr = null;
	String[][] result = new String[][]{};    	
	boolean showFlag=false;	//showFlag表示是否有数据可供显示
	
    String regionCode = (String)session.getAttribute("regCode");
    
    String iLoginAccept    = request.getParameter("login_accept");     //操作流水号
    String iOpType         = request.getParameter("op_type");    //操作类型,0-删除,1-增加,2-修改,
    String iOpCode         = request.getParameter("op_code");          //操作代码
    String iWorkNo         = request.getParameter("WorkNo");           //操作员工号
    String iLogin_Pass     = request.getParameter("NoPass");           //操作员密码
    String iOrgCode        = request.getParameter("OrgCode");          //操作员机构代码
    String iSys_Note       = request.getParameter("sysnote");        //系统操作备注
    String iOp_Note        = request.getParameter("sysnote");        //用户操作备注
    String iIpAddr         = request.getParameter("ip_Addr");          //操作员IP地址
    String iBelong_code    = request.getParameter("belong_code");      //集团用户的归属
    String icust_id        = request.getParameter("cust_id");
    String ism_code        = request.getParameter("sm_code");
    String iproduct_code   = request.getParameter("product_code");
    //String iproduct_append = request.getParameter("product_append");  
    String iproduct_prices = request.getParameter("product_prices");   //产品价格代码
    String iproduct_attr   = request.getParameter("product_attr");     //产品属性代码
    String iproduct_type   = request.getParameter("product_type");     //产品类型
    String iservice_code   = request.getParameter("service_code");     //服务代码
    String iservice_attr   = request.getParameter("service_attr");     //服务属性
    String igrp_id         = request.getParameter("grp_id");
    String igrp_name       = request.getParameter("grp_name");
    String iaccount_id     = request.getParameter("account_id");
    String igrp_userno     = request.getParameter("grp_userno");
    String iuser_passwd    = request.getParameter("user_passwd");
    String iprovince       = request.getParameter("province");
    String iserv_area      = request.getParameter("serv_area");
    String iscp_id         = request.getParameter("scp_id");
    String igrp_type       = request.getParameter("grp_type");
    String icontact        = request.getParameter("contact");
    String iaddress        = request.getParameter("address");
    String itelephone      = request.getParameter("telephone");
    String isub_state      = request.getParameter("sub_state");
    String isrv_start      = request.getParameter("srv_start");
    String isrv_stop       = request.getParameter("srv_stop");
    String iflags          = request.getParameter("flags");
    String iinter_fee      = request.getParameter("inter_fee");
    String iout_fee        = request.getParameter("out_fee");
    String iout_grpfee     = request.getParameter("out_grpfee");
    String inormal_fee     = request.getParameter("normal_fee");
    String iadm_no         = request.getParameter("adm_no");
    String itrans_no       = request.getParameter("trans_no");
    String idisplay        = request.getParameter("display");
    String imax_clnum      = request.getParameter("max_clnum");
    String imax_numcl      = request.getParameter("max_numcl");
    String ipmax_close     = request.getParameter("pmax_close");
    String imax_outnum     = request.getParameter("max_outnum");
    String imax_outnumcl   = request.getParameter("max_outnumcl");
    String imax_users      = request.getParameter("max_users");
    String ipkg_type       = request.getParameter("pkg_type");
    String ipkg_day        = request.getParameter("pkg_day");
    String idiscount       = request.getParameter("discount");
    String ilmt_fee        = request.getParameter("lmt_fee");
    String ifee_rate       = request.getParameter("fee_rate");
    String ilock_flag      = request.getParameter("lock_flag");
    String ibusi_type      = request.getParameter("busi_type");
    String ibill_type      = request.getParameter("bill_type");
    String iuse_status     = request.getParameter("use_status");
    String icover_region   = request.getParameter("cover_region");
    String ichg_flag       = request.getParameter("chg_flag");
    String iOrg_Id         = request.getParameter("org_id");           //操作员的org_id
    String iGroup_Id       = request.getParameter("group_id");         //操作员的group_id
    String iPayCode        = request.getParameter("pay_code");         //集团帐户付款方式，未使用
    String iflags_no_2     = request.getParameter("flags_no_2");

    String strTmp = ipkg_type     + "~"  + ipkg_day + "~" +
                    idiscount     + "~"  + ilmt_fee + "~" +
                    ifee_rate     + "~"  +
                    ilock_flag    + "~"  +
                    ibusi_type    + "~"  +
                    ibill_type    + "~"  +
                    iuse_status   + "~"  +
                    icover_region + "~"  +
                    ichg_flag     + "~"  +
                    iOrg_Id       + "~"  +
                    iGroup_Id     + "~"  + 
                    iPayCode      + "~"  ;
                    String iRegion_Code = iOrgCode.substring(0,2);

    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
 
   try
    {
            String[] paramsIn = new String[50];

            paramsIn[0]=iLoginAccept;//0
            paramsIn[1]=iOpType     ;
            paramsIn[2]=iOpCode     ;
            paramsIn[3]=iWorkNo     ;
            paramsIn[4]=iLogin_Pass ;
            paramsIn[5]=iOrgCode    ;
            paramsIn[6]=iSys_Note   ;
            paramsIn[7]=iOp_Note    ;
            paramsIn[8]=iIpAddr     ;
            paramsIn[9]=iBelong_code;
            paramsIn[10]=icust_id    ;
//10
            paramsIn[11]=ism_code    ;
            paramsIn[12]=iproduct_code;
            //paramsIn[13]=ProdAppend  ;
            //paramsIn[14]=ProdPrice  ;
            //paramsIn[15]=ProdAttr   ;
            paramsIn[16]=iproduct_type;
            paramsIn[17]=iservice_code;
            paramsIn[18]=iservice_attr;
            paramsIn[19]=igrp_id     ;
            paramsIn[20]=igrp_name   ;
    //20        
						paramsIn[21]=iaccount_id ;
            paramsIn[22]=igrp_userno ;
            paramsIn[23]=iuser_passwd;
            paramsIn[24]=iprovince   ;
            paramsIn[25]=iserv_area  ;
            paramsIn[26]=iscp_id     ;
            paramsIn[27]=igrp_type   ;
            paramsIn[28]=icontact    ;
            paramsIn[29]=iaddress    ;
            paramsIn[30]=itelephone  ;
//30
            paramsIn[31]=isub_state  ;
            paramsIn[32]=isrv_start  ;
            paramsIn[33]=isrv_stop   ;
            paramsIn[34]=iflags      ;
            paramsIn[35]=iinter_fee  ;
            paramsIn[36]=iout_fee    ;
            paramsIn[37]=iout_grpfee ;
            paramsIn[38]=inormal_fee ;
            paramsIn[39]=iadm_no     ;
            paramsIn[40]=itrans_no   ;
//40
            paramsIn[41]=idisplay    ;
            paramsIn[42]=imax_clnum  ;
            paramsIn[43]=imax_numcl  ;
            paramsIn[44]=ipmax_close ;
            paramsIn[45]=imax_outnum ;
            paramsIn[46]=imax_outnumcl;
            paramsIn[47]=imax_users  ;
            paramsIn[48]=strTmp      ;
//48
            paramsIn[49]=iflags_no_2 ;

     
           //retStr = callView.callService("s3200Cfm", paramsIn, "2", "region", iRegion_Code);
           
%>
	  <wtc:service name="s3200Cfm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=iRegion_Code%>">
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
			<wtc:param value="<%=paramsIn[11]%>" />
			<wtc:param value="<%=paramsIn[12]%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=paramsIn[16]%>" />
			<wtc:param value="<%=paramsIn[17]%>" />
			<wtc:param value="<%=paramsIn[18]%>" />
			<wtc:param value="<%=paramsIn[19]%>" />
			<wtc:param value="<%=paramsIn[20]%>" />
			<wtc:param value="<%=paramsIn[21]%>" />
			<wtc:param value="<%=paramsIn[22]%>" />
			<wtc:param value="<%=paramsIn[23]%>" />
			<wtc:param value="<%=paramsIn[24]%>" />
			<wtc:param value="<%=paramsIn[25]%>" />
			<wtc:param value="<%=paramsIn[26]%>" />
			<wtc:param value="<%=paramsIn[27]%>" />
			<wtc:param value="<%=paramsIn[28]%>" />
			<wtc:param value="<%=paramsIn[29]%>" />
			<wtc:param value="<%=paramsIn[30]%>" />
			<wtc:param value="<%=paramsIn[31]%>" />
			<wtc:param value="<%=paramsIn[32]%>" />
			<wtc:param value="<%=paramsIn[33]%>" />
			<wtc:param value="<%=paramsIn[34]%>" />
			<wtc:param value="<%=paramsIn[35]%>" />
			<wtc:param value="<%=paramsIn[36]%>" />
			<wtc:param value="<%=paramsIn[37]%>" />
			<wtc:param value="<%=paramsIn[38]%>" />
			<wtc:param value="<%=paramsIn[39]%>" />
			<wtc:param value="<%=paramsIn[40]%>" />
			<wtc:param value="<%=paramsIn[41]%>" />
			<wtc:param value="<%=paramsIn[42]%>" />
			<wtc:param value="<%=paramsIn[43]%>" />
			<wtc:param value="<%=paramsIn[44]%>" />
			<wtc:param value="<%=paramsIn[45]%>" />
			<wtc:param value="<%=paramsIn[46]%>" />
			<wtc:param value="<%=paramsIn[47]%>" />
			<wtc:param value="<%=paramsIn[48]%>" />
			<wtc:param value="<%=paramsIn[49]%>" />												
	</wtc:service>
	<wtc:array id="result1" scope="end"  />
	
<%
	    error_code = code1;
            error_msg = msg1;
            //error_code = Integer.parseInt(retStr[0]);
            System.out.println("--------------error_code--------------"+error_code);
            System.out.println("--------------error_msg--------------"+error_msg);
               System.out.println("--------------igrp_userno--------------"+igrp_userno);
               System.out.println("--------------iWorkNo--------------"+iWorkNo);
                System.out.println("--------------itelephone--------------"+itelephone);
    }catch(Exception e){
        
    }
 
    if(error_code.equals("000000"))
    {
%>
        <script language='jscript'>
            rdShowMessageDialog("业务处理成功！",2);
            location = "s3202.jsp?opCode=<%=iOpCode%>&opName=<%=opName%>";
        </script>
<%  } else {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_code%>" + "[" + "<%=error_msg%>" + "]" ,0);
            history.go(-1);
        </script>
<%
    }
%>

<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+iOpCode+"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg+"&opName="+opName+"&workNo="+iWorkNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+itelephone+"&opBeginTime="+opBeginTime+"&contactId="+igrp_userno+"&contactType=grp";%>

<jsp:include page="<%=url%>" flush="true" />

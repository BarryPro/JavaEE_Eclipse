<%
    /********************
     * @ OpCode    :  7896
     * @ OpName    :  集团成员属性变更
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2009-09-27
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<form name="frm" action="" method="post" >
    <input type="hidden" id="errPhoneList" name="errPhoneList" value="" />
    <input type="hidden" id="errMsgList" name="errMsgList" value="" />
    <input type="hidden" id="unitId" name="unitId" value="" />
    <input type="hidden" id="loginAccept" name="loginAccept" value="" />
    <input type="hidden" id="grpName" name="grpName" value="" />
</form>
</body>
<%
    String opCode = "7896";
    String opName = "集团成员属性变更";
    
    String iLoginPwd        = WtcUtil.repNull((String)session.getAttribute("password"));
    String iOrgCode         = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String iIpAddr          = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String iRegion_Code     = WtcUtil.repNull((String)session.getAttribute("requestCode"));
	
    String iLoginAccept     = WtcUtil.repNull((String)request.getParameter("sys_accept"));
    String iOpCode          = WtcUtil.repNull((String)request.getParameter("op_code"));
    String iWorkNo          = WtcUtil.repNull((String)request.getParameter("work_no"));
    String iSys_Note        = WtcUtil.repNull((String)request.getParameter("opNote"));
	String iOp_Note         = WtcUtil.repNull((String)request.getParameter("opNote"));
	String iGrp_Id          = WtcUtil.repNull((String)request.getParameter("id_no"));
	String iUnitId          = WtcUtil.repNull((String)request.getParameter("unit_id"));
	String iGrpName         = WtcUtil.repNull((String)request.getParameter("grp_name"));
	String In_OpType        = "m02";
	String In_SmCode        = WtcUtil.repNull((String)request.getParameter("sm_code"));
	System.out.println("# In_SmCode = " + In_SmCode);
	
	String idcMebNo         = "";
	String input_type       = WtcUtil.repNull((String)request.getParameter("input_type"));
	if("np".equals(In_SmCode)){
	    if("single".equals(input_type)){
	        idcMebNo = WtcUtil.repNull((String)request.getParameter("single_phoneno1")) + "|";
    	}else if("multi".equals(input_type)){
    	    idcMebNo = WtcUtil.repNull((String)request.getParameter("multi_phoneNo"));
	    }
	}else{
	    idcMebNo = WtcUtil.repNull((String)request.getParameter("single_phoneno")) + "|";
	}
	
    	String payType      = WtcUtil.repNull((String)request.getParameter("payType"));
    	String checkNo      = WtcUtil.repNull((String)request.getParameter("checkNo"));
    	String bankCode     = WtcUtil.repNull((String)request.getParameter("bankCode"));
    	String checkPay     = WtcUtil.repNull((String)request.getParameter("checkPay"));
    	String cashPay      = WtcUtil.repNull((String)request.getParameter("checkPrePay"));
    	String shouldHandFee= WtcUtil.repNull((String)request.getParameter("should_handfee"));
    	String handFee      = WtcUtil.repNull((String)request.getParameter("real_handfee"));
	String feeList          = payType +"~"+ checkNo +"~"+ bankCode +"~"+ checkPay +"~"+ cashPay +"~"+ shouldHandFee +"~"+ handFee +"~";
	
	String cycleMoney       = WtcUtil.repNull((String)request.getParameter("cycleMoney"));
	String beginDate        = WtcUtil.repNull((String)request.getParameter("beginDate"));
	String endDate          = WtcUtil.repNull((String)request.getParameter("endDate"));
	String request_type = new String();
	String iInputType = new String();
	if ("j1".equals(In_SmCode)) {
		request_type = WtcUtil.repNull((String)request.getParameter("j1_request_type"));
		iInputType = WtcUtil.repNull((String)request.getParameter("j1_input_type"));
	} else if("vp".equals(In_SmCode)) {
		request_type = WtcUtil.repNull((String)request.getParameter("request_type"));
		iInputType = WtcUtil.repNull((String)request.getParameter("vp_input_type"));
	}else{
	  request_type = WtcUtil.repNull((String)request.getParameter("request_type"));
	  System.out.println("-----------------ap-------request_type="+request_type);
		iInputType = WtcUtil.repNull((String)request.getParameter("phoneNo_input_type"));
	}
	String service_no       = WtcUtil.repNull((String)request.getParameter("service_no"));
	String update_no_type   = WtcUtil.repNull((String)request.getParameter("updateNoType"));
	String iGrpUnitId       = WtcUtil.repNull((String)request.getParameter("grp_unit_id"));
	
	if("".equals(request_type))	
		In_OpType = "m02";
	else
		In_OpType = request_type;
	
    String iServerIpAddr = realip;   // 0.100主机隐藏ip用上面方法得到的是0.100非真实ip
    
    String tmpR1 = WtcUtil.repNull((String)request.getParameter("tmpR1"));
    String tmpR2 = WtcUtil.repNull((String)request.getParameter("tmpR2"));
    String tmpR3 = WtcUtil.repNull((String)request.getParameter("tmpR3"));

    System.out.println("#   短号     = "+tmpR1);
    System.out.println("#   手机号码 = "+tmpR2);
    System.out.println("#   客户姓名 = "+tmpR3);
    
    String iInputFile = WtcUtil.repNull((String)request.getParameter("inputFile"));
    /* end of vpmn 取数据 */
   
    /* vpmn,短号修改时,取数据 */
    String tmpR21 = WtcUtil.repNull((String)request.getParameter("tmpR21"));
    String tmpR22 = WtcUtil.repNull((String)request.getParameter("tmpR22"));

    System.out.println("###   手机号码|短号&     = "+tmpR21);
    /* end of vpmn 取数据 */
     
    /* 获取动态展示数据 */
	String name_list=(String)request.getParameter("nameList");
	System.out.println("-------ningtn----7896------name_list="+name_list);
	String grp_list=request.getParameter("nameGroupList");
	StringTokenizer token=new StringTokenizer(name_list,"|");
	StringTokenizer token_grp=new StringTokenizer(grp_list,"|");
	int length=token.countTokens();
	
	System.out.println("#   wanghao     = "+name_list);
	
	String fieldCodes[] = new String [length];
	String fieldValues[]= new String [length];
	String fieldRowNo[]= new String [length];
	
	String parm1[] = new String [length];
    String parm2[] = new String [length];
    String parm3[] = new String [length];
            
	ArrayList fieldValueAry = new ArrayList();
	Vector vec = new Vector();
	
	String error_code = "0";
	String error_msg = "";	

	
	
		//解析组号字符串
		int k=0;
		while (token_grp.hasMoreElements()){
			fieldRowNo[k]=(String)token_grp.nextElement();
			//System.out.println("###########********fieldRowNo["+k+"]**********##########"+fieldRowNo[k]);
			k++;
		}
		
		int i=0;
		int pp=0;
		//解析名字和值字符串
		while (token.hasMoreElements()){
			fieldCodes[i]=(String)token.nextElement();
			System.out.println("###########********fieldCodes["+i+"]**********##########"+fieldCodes[i]);
			System.out.println("###########********fieldRowNo["+i+"]**********##########"+fieldRowNo[i]);
			
			if(!vec.contains(fieldCodes[i]))
			{
				if(!fieldRowNo[i].equals("0"))	//行号从1开始
				{
					String[] tempValues = (String[])request.getParameterValues("F"+fieldCodes[i]);
					for(pp=0;pp<tempValues.length;pp++)
					{
						fieldValueAry.add(tempValues[pp]);
						System.out.println("###########********tempValues["+pp+"]**********##########"+tempValues[pp]);
					}
				}
				else
				{
					fieldValueAry.add(request.getParameter("F"+fieldCodes[i]));
					System.out.println("###########********tempValues["+pp+"]**********##########"+request.getParameter("F"+fieldCodes[i]));
				}
				vec.add(fieldCodes[i]);
			}
			i++;
		}
		
		fieldValues=(String[])fieldValueAry.toArray(new String[length]);
	
	/* end of 获取动态展示数据 */
	
	try
	{
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm====0==== iLoginAccept = " + iLoginAccept);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm====1==== iOpCode = " + iOpCode);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm====2==== iWorkNo = " + iWorkNo);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm====3==== iLoginPwd = " + iLoginPwd);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm====4==== iOrgCode = " + iOrgCode);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm====5==== iSys_Note = " + iSys_Note);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm====6==== iOp_Note = " + iOp_Note);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm====7==== iIpAddr = " + iIpAddr);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm====8==== idcMebNo = " + idcMebNo);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm====9==== iGrp_Id = " + iGrp_Id);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===10==== In_OpType = " + In_OpType);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===11==== In_SmCode = " + In_SmCode);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===12==== feeList = " + feeList);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===13==== cycleMoney = " + cycleMoney);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===14==== beginDate = " + beginDate);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===15==== endDate = " + endDate);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===16==== tmpR1 = " + tmpR1);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===17==== tmpR2 = " + tmpR2);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===18==== request_type = " + request_type);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===19==== ");
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===20==== ");
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===21==== service_no = " + service_no);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===22==== tmpR21 = " + tmpR21);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===23==== update_no_type = " + update_no_type);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===24==== iGrpUnitId = " + iGrpUnitId);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===25==== iInputType = " + iInputType);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===26==== iInputFile = " + iInputFile);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===27==== iServerIpAddr = " + iServerIpAddr);
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===28==== ");
		System.out.println("====wanghfa====f7896_2.jsp====s7896Cfm===29==== ");
		
		
		String mm_phoneNoList  = WtcUtil.repNull((String)request.getParameter("mm_phoneNoList"));
		String mm_phoneType    = WtcUtil.repNull((String)request.getParameter("mm_phoneType"));
    String mm_cfm_param_30 = WtcUtil.repNull((String)request.getParameter("mm_cfm_param_30"));
		String mm_cfm_param_31 = WtcUtil.repNull((String)request.getParameter("mm_cfm_param_31"));
		String mm_cfm_param_32 = WtcUtil.repNull((String)request.getParameter("mm_cfm_param_32"));
		
		System.out.println("-------hejwa---------------mm_phoneNoList----------->"+mm_phoneNoList);
		System.out.println("-------hejwa---------------mm_phoneType------------->"+mm_phoneType);
		System.out.println("-------hejwa---------------mm_cfm_param_30---------->"+mm_cfm_param_30);
		System.out.println("-------hejwa---------------mm_cfm_param_31---------->"+mm_cfm_param_31);
		System.out.println("-------hejwa---------------mm_cfm_param_32---------->"+mm_cfm_param_32);
		
		System.out.println("-------hejwa---------------In_SmCode---------------->"+In_SmCode);
		
		if("MM".equals(In_SmCode)){
			update_no_type = mm_phoneType;
		}
		
		System.out.println("-------hejwa---------------update_no_type------------>"+update_no_type);
		
		String[] mm_cfm_param_30_arr = new String[]{}; 
		String[] mm_cfm_param_31_arr = new String[]{}; 
		String[] mm_cfm_param_32_arr = new String[]{}; 
		
		if("2".equals(mm_phoneType)){
			mm_cfm_param_30_arr = new String[]{mm_cfm_param_30}; 
			mm_cfm_param_31_arr = new String[]{mm_cfm_param_31}; 
			mm_cfm_param_32_arr = new String[]{mm_cfm_param_32}; 
			
			System.out.println("-------hejwa---------------mm_cfm_param_30_arr---------->"+mm_cfm_param_30_arr.length);
		}
		
		if("3".equals(mm_phoneType)){
				Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        calendar.add(Calendar.MONTH, 1);
      	String nextMotehOneDay = new java.text.SimpleDateFormat("yyyyMMdd").format(calendar.getTime())+"000000";
			
			mm_cfm_param_30_arr = new String[]{mm_cfm_param_30,"81017"}; 
			mm_cfm_param_31_arr = new String[]{mm_cfm_param_31,nextMotehOneDay}; 
			mm_cfm_param_32_arr = new String[]{mm_cfm_param_32,"0"}; 
			
			System.out.println("-------hejwa---------------mm_cfm_param_30_arr---------->"+mm_cfm_param_30_arr.length);
		}
%>

			<wtc:service name="s7896Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="retCode1" retmsg="retMsg1" outnum="4" >
				<wtc:param value="<%=iLoginAccept%>"/>
				<wtc:param value="<%=iOpCode%>"/>
				<wtc:param value="<%=iWorkNo%>"/>
				<wtc:param value="<%=iLoginPwd%>"/>
				<wtc:param value="<%=iOrgCode%>"/>
					
				<wtc:param value="<%=iSys_Note%>"/>
				<wtc:param value="<%=iOp_Note%>"/>	
				<wtc:param value="<%=iIpAddr%>"/>
<%
if("2".equals(mm_phoneType)||"3".equals(mm_phoneType)){
%>					
				<wtc:param value="<%=mm_phoneNoList%>"/>
<%
}else{
%>
				<wtc:param value="<%=idcMebNo%>"/>
<%
}
%>					
				<wtc:param value="<%=iGrp_Id%>"/>
					
				<wtc:param value="<%=In_OpType%>"/>
				<wtc:param value="<%=In_SmCode%>"/>
				<wtc:param value="<%=feeList%>"/>
				<wtc:param value="<%=cycleMoney%>"/>
				<wtc:param value="<%=beginDate%>"/>
					
				<wtc:param value="<%=endDate%>"/>				
				<wtc:param value="<%=tmpR1%>"/>
				<wtc:param value="<%=tmpR2%>"/>
				<wtc:param value="<%=request_type%>"/>
				<wtc:param value=""/>
					
				<wtc:param value=""/>
				<wtc:param value="<%=service_no%>"/>
				<wtc:param value="<%=tmpR21%>"/><!-- 按短号修改时,手机号码1|短号1&手机号码2|短号2&... -->
				<wtc:param value="<%=update_no_type%>"/>
				<wtc:param value="<%=iGrpUnitId%>"/>

        <wtc:param value="<%=iInputType%>"/>
        <wtc:param value="<%=iInputFile%>"/>
        <wtc:param value="<%=iServerIpAddr%>"/>
        <wtc:param value=""/><!-- 预留参数,暂未启用 -->
        <wtc:param value=""/><!-- 预留参数,暂未启用 -->
        	
<%
if("2".equals(mm_phoneType)||"3".equals(mm_phoneType)){
%>	
				<wtc:params value="<%=mm_cfm_param_30_arr%>"/>
				<wtc:params value="<%=mm_cfm_param_31_arr%>"/>
				<wtc:params value="<%=mm_cfm_param_32_arr%>"/>
<%
}else{
			if(length>0){
%>
				<wtc:params value="<%=fieldCodes%>"/>
				<wtc:params value="<%=fieldValues%>"/>
				<wtc:params value="<%=fieldRowNo%>"/>
<%	
			}else{
%>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
<%	
			}
}
%>
			</wtc:service>	
      <wtc:array id="retArr" scope="end"/>
<%	
		/*入参:19 20 21*/
		error_code = retCode1;
		error_msg= retMsg1;

		System.out.println("error_msg---"+error_msg);
		
		if(error_code.equals("000000")){
            String errPhoneList = retArr[0][0];
            String errMsgList   = retArr[0][1];
            System.out.println("------------7896---------errPhoneList="+errPhoneList);
            System.out.println("------------7896---------errMsgList="+errMsgList);
        /* 成功后转到错误展示页面 */
        %>
            <script type=text/javascript>
                $("#errPhoneList").val("<%=errPhoneList%>");
                $("#errMsgList").val("<%=errMsgList%>");
                $("#unitId").val("<%=iUnitId%>");
                $("#loginAccept").val("<%=iLoginAccept%>");
                $("#grpName").val("<%=iGrpName%>");
                
                frm.action="f7896_3.jsp";
            	frm.method="post";
            	frm.submit();
            	
            	//用location批量时有可能URL超长。
                //window.location="f7896_3.jsp?errPhoneList=<%=errPhoneList%>&errMsgList=<%=errMsgList%>&unitId=<%=iUnitId%>&loginAccept=<%=iLoginAccept%>&grpName=<%=iGrpName%>";
            </script>
        <%
            System.out.println("# return from f7896_2.jsp -> Call Service s7896Cfm Success !");
        } else {
    %>
            <script language='jscript'>
                rdShowMessageDialog("错误代码：<%=error_code%>，错误信息：<%=error_msg%>",0);
                window.location="f7896_1.jsp";
            </script>
<%
        }
    
    }catch(Exception e){
%>
        <script type=text/javascript>
            rdShowMessageDialog("调用服务s7896Cfm失败！",0);
            window.location="f7896_1.jsp";
        </script>
<%
		e.printStackTrace();
    }
    
System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
%>
<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg+"&opName="+opName+"&workNo="+iWorkNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+iUnitId+"&contactType=grp";%>
<jsp:include page="<%=url%>" flush="true" />
<%
System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
%>
</html>
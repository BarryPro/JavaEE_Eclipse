<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-19
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
    ArrayList retArray = null;
    String error_code = "";
    String error_msg = "";
    Logger logger = Logger.getLogger("f3505_delete.jsp");
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();

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
	
	String opCode = (String)request.getParameter("iOpCode");
	String opName = (String)request.getParameter("op_name");
	System.out.println("opNameopNameopNameopNameopName="+opName);
	//luxc add 20080622
	String opType = request.getParameter("opType");
	String new_mode = request.getParameter("addProduct");
	String op_code="";
	if("2".equals(opType))
	{
		op_code="3541";
	}
	else if("1".equals(opType))
	{
		op_code="3506";
	}
	else
	{
		%>
        <script language='jscript'>
            rdShowMessageDialog("操作代码参数错误!",0);
            history.go(-1);
        </script>
		<%
		return;
	}
	
		
	
	

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
			ArrayList paramsIn = new ArrayList();

            paramsIn.add(new String[]{iLoginAccept    });//0
            paramsIn.add(new String[]{op_code         });
            paramsIn.add(new String[]{iWorkNo         });
            paramsIn.add(new String[]{iLogin_Pass     });
            paramsIn.add(new String[]{iOrgCode        });
            paramsIn.add(new String[]{iSys_Note       });//5
            paramsIn.add(new String[]{iOp_Note        });
            paramsIn.add(new String[]{iIpAddr         });
            paramsIn.add(new String[]{iGrp_Id         });
            paramsIn.add(new String[]{idcMebNo        });
            paramsIn.add(new String[]{feeList         });//10
            paramsIn.add(new String[]{new_mode        });

			//传入参数数组
            //String [] paramsIn = new String[] { iLoginAccept, iOpCode, iWorkNo, iLogin_Pass, iOrgCode, iSys_Note, iOp_Note, iIpAddr, iGrp_Id,cust_code,user_type,bill_type,bill_time,"ip28I000",add_mode,feeList,name_list,value_list.toString()};
			//retStr = callView.callService("s3506Cfm", paramsIn, "1", "region", iRegion_Code);
			%>
            <wtc:service name="s3506Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="s3506CfmCode" retmsg="s3506CfmMsg" outnum="4" >
            	<wtc:param value="<%=iLoginAccept%>"/>
                <wtc:param value="<%=op_code%>"/> 
                <wtc:param value="<%=iWorkNo%>"/>
                <wtc:param value="<%=iLogin_Pass%>"/>
                <wtc:param value="<%=iOrgCode%>"/>
                
                <wtc:param value="<%=iSys_Note%>"/>
                <wtc:param value="<%=iOp_Note%>"/>
                <wtc:param value="<%=iIpAddr%>"/>
                <wtc:param value="<%=iGrp_Id%>"/>
                <wtc:param value="<%=idcMebNo%>"/>
                
                <wtc:param value="<%=feeList%>"/>
                <wtc:param value="<%=new_mode%>"/>
            </wtc:service>
            <wtc:array id="s3506CfmArr" scope="end"/>
            <%
			//callView.printRetValue();
            error_code = s3506CfmCode;
            error_msg= s3506CfmMsg;
            
            System.out.println("error_code="+error_code+";error_msg="+error_msg);
            //----------------------------
                System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
                String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg+"&opName="+opName+"&workNo="+iWorkNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
                 System.out.println("%%%%%%%%url%%%%%%%%");
            %>
                <jsp:include page="<%=url%>" flush="true" />
            <%
                System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
            //----------------------------
    }catch(Exception e){
		e.printStackTrace();
        logger.error("Call s3506Cfm is Failed!");
    }

    if(error_code.equals("000000"))
    {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_msg%>",2);
            location = "f3505_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
        </script>
<%  } else {
%>
        <script language='jscript'>
                     
            var path="<%=request.getContextPath()%>/npage/s3500/f3505_2_printxls.jsp?phoneNo=" + "<%=idcMebNo%>";
            
	   		if (rdShowConfirmDialog("<br>错误代码:"+"<%=error_code%></br>"+"错误信息:"+"<%=error_msg%>"+"<br>是否保存错误信息？",0)==1)	
			{
				path = path + "&returnMsg=" + "<%=error_msg%>"+ "&unitID=" + "<%=unit_id%>";
	  			path = path + "&op_Code="+"8888";
	  			path = path + "&orgCode=" + "<%=iOrgCode%>";
          			window.open(path);
			}	
            history.go(-1);
        </script>
<%
    }
%>

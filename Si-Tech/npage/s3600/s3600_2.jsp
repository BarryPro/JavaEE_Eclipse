<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.05
 模块: BOSS侧VPMN集团开户
********************/
%>

	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
    String error_code="";
    String error_msg="";

    String iIpAddr = (String)session.getAttribute("ipAddr");
    String iWorkNo = (String)session.getAttribute("workNo");
    String iOrgCode = (String)session.getAttribute("orgCode");
    String iLogin_Pass  = (String)session.getAttribute("password");
    String unit_id = request.getParameter("unit_id");  					//集团id
    System.out.println("unit_idunit_idunit_id====================="+unit_id);
    String iLoginAccept    = request.getParameter("login_accept");     //操作流水号
    	System.out.println("iLoginAcceptiLoginAcceptiLoginAcceptiLoginAcceptiLoginAccept========="+iLoginAccept);
    String iOpCode         = request.getParameter("op_code");          //操作代码
    //String iWorkNo         = request.getParameter("WorkNo");           //操作员工号
    // String iLogin_Pass     = request.getParameter("NoPass");           //操作员密码
    // String iOrgCode        = request.getParameter("OrgCode");          //操作员机构代码
    String iSys_Note       = request.getParameter("sysnote");          //系统操作备注
    String iOp_Note        = request.getParameter("tonote");           //用户操作备注
    //String iIpAddr         = request.getParameter("ip_Addr");          //操作员IP地址
    String iCust_Id        = request.getParameter("cust_id");          //集团客户ID
    String iGrp_Id         = request.getParameter("grp_id");           //集团用户ID
    String iContract_No    = request.getParameter("account_id");       //集团用户帐号
    String iUser_Passwd    = request.getParameter("user_passwd");      //集团用户密码
    String iProvince       = request.getParameter("province");         //集团所在省区
	System.out.println("$$$$$$$$$$$$$$$$iProvince="+iProvince);
	System.out.println("@@@@@@@@@@@@@@"+request.getParameter("belong_code"));
    String iBelong_Code    = request.getParameter("belong_code").substring(0,7);      //客户归属地区
    String iBill_Type      = request.getParameter("bill_type");        //出帐周期
    String iBill_Date      = request.getParameter("srv_stop");         //业务结束时间????
    String iGrp_Name       = request.getParameter("grp_name");         //集团用户名称
    String iOrg_Id         = request.getParameter("org_id");           //操作员的org_id
    String iGroup_Id       = request.getParameter("group_id");         //操作员的group_id
    String iSm_Code        = request.getParameter("sm_code");          //服务品牌代码
    String iProduct_Code   = request.getParameter("product_code");     //集团主产品代码
    String iProduct_Append = request.getParameter("product_append");   //集团附加产品代码
    String iProduct_Prices = request.getParameter("product_prices");   //产品价格代码
    String iProduct_Attr   = request.getParameter("product_attr");     //产品属性代码
    String iProduct_Type   = request.getParameter("product_type");     //产品类型
    String iService_Code   = request.getParameter("service_code");     //服务代码
    String iService_Attr   = request.getParameter("service_attr");     //服务属性
	String mainRate   =request.getParameter("mainRate");
	String[] optionalRates   =(String[])request.getParameterValues("optionalRate");
	String url = "";
	String iPay_Type	   = request.getParameter("payType");     //付款方式
	String iCash_Pay	   = request.getParameter("cashNum");     //支付金额
	String iCheck_No	   = request.getParameter("checkNo");     //支票号码
	String iBank_Code	   = request.getParameter("bankCode");     //银行代码
	String iCheck_Pay	   = request.getParameter("checkPay");     //支票交款
	String iShouldHandFee  = request.getParameter("should_handfee");   //应收手续费
    String iHandFee        = request.getParameter("real_handfee");     //实收手续费
   //payType 交费方式 ~ checkNo 支票号码 ~ bankCode 银行代码 ~ checkPay 支票交款 ~ cashPay 现金交款 ~ shouldHandFee 手续费 ~ handFee 手续费
	String feeList="";                                                 //费用信息
	feeList=iPay_Type+"~"+iCheck_No+"~"+iBank_Code+"~"+iCheck_Pay+"~"+iShouldHandFee+"~"+iShouldHandFee+"~"+iHandFee+"~";
    //String iContract_List  = "";                                       //合同列表
    //String iContract_Desc  = "";                                       //合同描述
    //String iPayNo          = request.getParameter("pay_no");           //付费手机号码
    String iGrp_UserNo     = request.getParameter("grp_userno");       //集团用户编号
    String iRegion_Code = iOrgCode.substring(0,2);
    iUser_Passwd = Encrypt.encrypt(iUser_Passwd);  //加密用户密码

    int i=0,j=0,k=0;
    i = iProduct_Code.indexOf("|"); //得到主产品代码
    iProduct_Code = iProduct_Code.substring(0, i);
/*
    for (i=0,j=1; i<iProduct_Append.length(); i++) { //统计附加产品数量
        if (iProduct_Append.charAt(i) == ',')
            j++;
    }
*/
    String[] ProdAppend = new String[j+1]; //将附加产品、产品价格、产品属性分解到数组中
    String[] ProdPrice = new String[j+1];
    String[] ProdAttr = new String[j+1];
    ProdAppend[0] = iProduct_Code;
    ProdPrice[0] = " ";
    ProdAttr[0] = " ";
/*
    for(i=1; i<j+1; i++) {
        k = iProduct_Append.indexOf(',');
        if (k > 0)
            ProdAppend[i] = iProduct_Append.substring(0, k);
        else
            ProdAppend[i] = iProduct_Append;
        ProdPrice[i] = "";
        ProdAttr[i] = "";
        iProduct_Append = iProduct_Append.substring(k+1);
    }
*/
    try
    {
            ArrayList paramsIn = new ArrayList();

            paramsIn.add(new String[]{iLoginAccept    });//0
            paramsIn.add(new String[]{iOpCode         });
            paramsIn.add(new String[]{iWorkNo         });
            paramsIn.add(new String[]{iLogin_Pass     });
            paramsIn.add(new String[]{iOrgCode        });
            paramsIn.add(new String[]{iSys_Note       });
            paramsIn.add(new String[]{iOp_Note        });
            paramsIn.add(new String[]{iIpAddr         });
            paramsIn.add(new String[]{iCust_Id        });
            paramsIn.add(new String[]{iGrp_Id         });
            paramsIn.add(new String[]{iContract_No    });//10
            paramsIn.add(new String[]{iUser_Passwd    });
            paramsIn.add(new String[]{iProvince       });
            paramsIn.add(new String[]{iBelong_Code    });
            paramsIn.add(new String[]{iBill_Type      });
            paramsIn.add(new String[]{iBill_Date      });
            paramsIn.add(new String[]{iGrp_Name       });
            paramsIn.add(new String[]{iOrg_Id         });
            paramsIn.add(new String[]{iGroup_Id       });
            paramsIn.add(new String[]{iSm_Code        });
            paramsIn.add(new String[]{iProduct_Code   });//20
            paramsIn.add(ProdAppend                    );
           
            paramsIn.add(ProdPrice                     );
            paramsIn.add(ProdAttr                      );
            paramsIn.add(new String[]{iProduct_Type   });
            paramsIn.add(new String[]{iService_Code   });
            paramsIn.add(new String[]{iService_Attr   });
			paramsIn.add(new String[]{feeList         });
						
						
            //paramsIn.add(new String[]{iContract_List  });
            //paramsIn.add(new String[]{iContract_Desc  });
            //paramsIn.add(new String[]{iShouldHandFee  });
            //paramsIn.add(new String[]{iHandFee        });
            //paramsIn.add(new String[]{iPayNo          });
            paramsIn.add(new String[]{iGrp_UserNo     });//28

			String[] fieldCodes = null;
			String[] rates = null;
			if (optionalRates != null)
			{
				fieldCodes = new String[1+optionalRates.length];
				rates = new String[1+optionalRates.length];
			}
			else
			{
				fieldCodes = new String[1];
				rates = new String[1];
			}
			fieldCodes[0] = "10000";
			rates[0] = mainRate;
			for (i = 1; i < rates.length; i ++)
			{
				fieldCodes[i] = "10001";
				rates[i] = optionalRates[i-1];
			}
			paramsIn.add(fieldCodes);
			paramsIn.add(rates);
			
            //retStr = callView.callService("s3600Cfm", paramsIn, "1", "region", iRegion_Code);
%>
			<wtc:service name="s3600Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
			<wtc:param value="<%=iLoginAccept%>"/>	
			<wtc:param value="<%=iOpCode      %>"/>	
			<wtc:param value="<%=iWorkNo      %>"/>	
			<wtc:param value="<%=iLogin_Pass  %>"/>	
			<wtc:param value="<%=iOrgCode     %>"/>	
			<wtc:param value="<%=iSys_Note    %>"/>	
			<wtc:param value="<%=iOp_Note     %>"/>	
			<wtc:param value="<%=iIpAddr      %>"/>	
			<wtc:param value="<%=iCust_Id     %>"/>	
			<wtc:param value="<%=iGrp_Id      %>"/>	
			<wtc:param value="<%=iContract_No %>"/>	
			<wtc:param value="<%=iUser_Passwd %>"/>	
			<wtc:param value="<%=iProvince    %>"/>	
			<wtc:param value="<%=iBelong_Code %>"/>	
			<wtc:param value="<%=iBill_Type   %>"/>	
			<wtc:param value="<%=iBill_Date   %>"/>	
			<wtc:param value="<%=iGrp_Name    %>"/>	
			<wtc:param value="<%=iOrg_Id      %>"/>	
			<wtc:param value="<%=iGroup_Id    %>"/>	
			<wtc:param value="<%=iSm_Code     %>"/>	
			<wtc:param value="<%=iProduct_Code%>"/>	
				
			<wtc:params value="<%=ProdAppend%>"/>	
			<wtc:params value="<%=ProdPrice%>"/>	
			<wtc:params value="<%=ProdAttr%>"/>	
				
			<wtc:param value="<%=iProduct_Type%>"/>	
			<wtc:param value="<%=iService_Code%>"/>	
			<wtc:param value="<%=iService_Attr%>"/>	
			<wtc:param value="<%=feeList      %>"/>	
			<wtc:param value="<%=iGrp_UserNo%>"/>	
			<wtc:params value="<%=fieldCodes%>"/>	
			<wtc:params value="<%=rates%>"/>	
			
			</wtc:service>	
			<wtc:array id="retStrTemp"  scope="end"/>
<%
     url = "/npage/contact/onceCnttInfo.jsp?opCode="+"3600"+"&retCodeForCntt="+retCode1+"&retMsgForCntt="+retMsg1
		+"&opName="+"BOSS侧VPMN集团开户"+"&workNo="+iWorkNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+unit_id
		+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
			//callView.printRetValue();
            error_code = retCode1;
            error_msg= retMsg1;
            System.out.println("error_code===="+error_code);
             System.out.println("url===="+url);
    }catch(Exception e){
        System.out.println(e.toString());
        error_code = "9";
    }

    if(error_code.equals("000000"))
    {
%>
        <script language='jscript'>
            rdShowMessageDialog("业务受理成功！",2);
            removeCurrentTab();
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
<jsp:include page="<%=url%>" flush="true" />
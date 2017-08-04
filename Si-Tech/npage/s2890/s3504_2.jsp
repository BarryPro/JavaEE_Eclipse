<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.18
 模块:EC产品订购
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<% 
	String opName = "EC产品订购";
	String[] inParams = new String[2];
    String[][] retStr = null;
    String error_code="";
    String error_msg="";
	String smName="";
	String custName="";
	double d_totalPay=0.00, d_cashPay=0.00, d_handPay=0.00 ;

    String iIpAddr = (String)session.getAttribute("ipAddr");
    String iWorkNo = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String iOrgCode = (String)session.getAttribute("orgCode");
    String iLogin_Pass  = (String)session.getAttribute("password");
    String regCode = (String)session.getAttribute("regCode");
    
    String sql_str = "";
    //取运行省份代码 -- 为吉林增加，山西可以使用session
		sql_str = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
		//result2 = (String[][])callView.sPubSelect("1",sql_str).get(0);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=sql_str%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
<%
		String ProvinceRun = "";
		if (result2 != null && result2.length != 0) 
		{
			ProvinceRun = result2[0][0];
		}
	
    //取工号密码和GROUP_ID
    String GroupId = "";
    String OrgId = "";
    if(ProvinceRun.equals("20"))  //吉林
    {
		
		inParams[0] = "select to_char(group_id),'unknown' FROM dLoginMsg where login_no=:iWorkNo";
		inParams[1] = "iWorkNo="+iWorkNo;
		//result1 = (String[][])callView.sPubSelect("2",sql_str).get(0);
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">			
		<wtc:param value="<%=inParams[0]%>"/>	
		<wtc:param value="<%=inParams[1]%>"/>	
		</wtc:service>	
		<wtc:array id="result1"  scope="end"/>
<%
		if (result1 != null && result1.length != 0) 
		{
			GroupId = result1[0][0];
			OrgId = result1[0][1];
		}
	}
	else
	{
		GroupId = (String)session.getAttribute("groupId");
		OrgId = (String)session.getAttribute("orgId");
	}
   
	String unit_id         = request.getParameter("unit_id");          //集团编码
    String iLoginAccept    = request.getParameter("login_accept");     //操作流水号
    String iOpCode         = request.getParameter("op_code");          //操作代码
    String iSys_Note       = request.getParameter("sysnote");          //系统操作备注
    String iOp_Note        = request.getParameter("tonote");           //用户操作备注
    String iCust_Id        = request.getParameter("cust_id");          //集团客户ID
    String iGrp_Id         = request.getParameter("grp_id");           //集团用户ID
    String iContract_No    = request.getParameter("account_id");       //集团用户帐号
    String iUser_Passwd    = request.getParameter("user_passwd");      //集团用户密码
    String iProvince       = request.getParameter("province");         //集团所在省区
   
    String iBelong_Code    = request.getParameter("belong_codeNew").substring(0,7);      //客户归属地区
    
    System.out.println("wulntest="+iBelong_Code);
    String iBill_Type      = request.getParameter("bill_type");        //出帐周期
    String iBill_Date      = request.getParameter("srv_stop");         //业务结束时间????
    String iGrp_Name       = request.getParameter("grp_name");         //集团用户名称
    String custAddress       = request.getParameter("custAddress"); 
    String iOrg_Id         = request.getParameter("org_id");           //操作员的org_id
    String iGroup_Id       = request.getParameter("group_id");         //操作员的group_id
	String iSm_Code        = request.getParameter("sm_code_hidden");          //服务品牌代码
    String iProduct_Code   = request.getParameter("product_code");     //集团主产品代码
    String iProduct_Append = request.getParameter("product_append");   //集团附加产品代码
    String iProduct_Prices = request.getParameter("product_prices");   //产品价格代码
    System.out.println("iProduct_Prices="+iProduct_Prices);
  	String mode_code       = request.getParameter("mainProduct"); //主套餐代码
	String add_mode       = request.getParameter("addProduct");         //附加模版代
    String iProduct_Type   = request.getParameter("product_type");     //产品类型
    String iService_Code   = request.getParameter("service_code");     //服务代码
    String iService_Attr   = request.getParameter("service_attr");     //服务属性
	String grpFieldCode    ="10200";
	String iPay_Type	   = request.getParameter("payType");     //付款方式
	String iCash_Pay	   = request.getParameter("cashNum");     //支付金额
	String iCheck_No	   = request.getParameter("checkNo");     //支票号码
	String iBank_Code	   = request.getParameter("bankCode");     //银行代码
	String iCheck_Pay	   = request.getParameter("checkPay");     //支票交款
	String iCashPay	   = request.getParameter("cashPay");     //现金交款
	String iShouldHandFee  = request.getParameter("should_handfee");   //应收手续费
    String iHandFee        = request.getParameter("real_handfee");     //实收手续费
	String systemNote        = request.getParameter("sysnote");     //系统备注
	String opNote        = request.getParameter("tonote");     //用户备注
	String town_code        = "101";     //用户备注
	String channel_id = "";
	String cust_Address = request.getParameter("cust_address"); 
	String gongnengfee_hid = request.getParameter("gongnengfee_hid"); 
	String bizCode = request.getParameter("bizCode"); 
		
	System.out.println("aa");  
		
	if(town_code.equals("101")){
	    channel_id = OrgId;
	}else{
	    channel_id = request.getParameter("channel_id");     //用户备注
	}

 //payType 交费方式 ~ checkNo 支票号码 ~ bankCode 银行代码 ~ checkPay 支票交款 ~ cashPay 现金交款 ~ shouldHandFee 手续费 ~ handFee 手续费
     if (iCash_Pay == null)
    {
    	iCash_Pay = "0.00";
    }
	 if (iHandFee == null)
    {
    	iHandFee = "0.00";
    }
	String feeList="";                                                 //费用信息
	feeList=iPay_Type+"~"+iCheck_No+"~"+iBank_Code+"~"+iCheck_Pay+"~"+iCashPay+"~"+iShouldHandFee+"~"+iHandFee+"~";
    String iGrp_UserNo     = request.getParameter("grp_userno");       //集团用户编号
    String iRegion_Code = iOrgCode.substring(0,2);
    iUser_Passwd = Encrypt.encrypt(iUser_Passwd);  //加密用户密码
	System.out.println("aa1"); 
    int i=0,j=0,k=0;
    i = iProduct_Code.indexOf("|"); //得到主产品代码
    iProduct_Code = iProduct_Code.substring(0, i);
	System.out.println("aa11"); 
    
	System.out.println("bb");
	String name_list=request.getParameter("nameList_grp");
	String grp_list=request.getParameter("nameGroupList_grp");
	String nameList_2890=request.getParameter("nameList_2890");
	String valueList_2890=request.getParameter("valueList_2890");
		
	System.out.println("-----nameList_2890="+nameList_2890);
	System.out.println("-----valueList_2890="+valueList_2890);
		
	StringTokenizer token=new StringTokenizer(name_list,"|");
	StringTokenizer token_grp=new StringTokenizer(grp_list,"|");
	StringTokenizer token_n_2890=new StringTokenizer(nameList_2890,"|");
	StringTokenizer token_v_2890=new StringTokenizer(valueList_2890,"|");
	
	int length=token.countTokens();
	int length_2890=token_n_2890.countTokens();
		
	String fieldCodes[] = new String [length];
	String fieldValues[]= new String [length];
	String fieldRowNo[]= new String [length];
	
	String fieldCodes_2890[]=new String [length_2890];
	String fieldValues_2890[]=new String [length_2890];
		
	ArrayList fieldValueAry = new ArrayList();
	Vector vec = new Vector();
	
	int n2890=0;
	while (token_n_2890.hasMoreElements()){
		fieldCodes_2890[n2890]=(String)token_n_2890.nextElement();
		n2890++;
	}
	
	int v2890=0;
	while (token_v_2890.hasMoreElements()){
		fieldValues_2890[v2890]=(String)token_v_2890.nextElement();
		v2890++;
	}
	
	//解析组号字符串
	k=0;
	while (token_grp.hasMoreElements()){
		fieldRowNo[k]=(String)token_grp.nextElement();
		//System.out.println("###########********fieldRowNo["+k+"]**********##########"+fieldRowNo[k]);
		k++;
	}
	
	i=0;
	int p=0;
	//解析名字和值字符串
	while (token.hasMoreElements()){
		fieldCodes[i]=(String)token.nextElement();
		System.out.println("###########********fieldCodes["+i+"]**********##########"+fieldCodes[i]);
		System.out.println("###########********fieldRowNo["+i+"]**********##########"+fieldRowNo[i]);
		
		if(!vec.contains(fieldCodes[i]))
		{
			if(!fieldRowNo[i].equals("0"))	//行号从1开始
			{
				String[] tempValues = (String[])request.getParameterValues("F"+request.getParameter("sm_code_hidden")+fieldCodes[i]);
				for(p=0;p<tempValues.length;p++)
				{
					fieldValueAry.add(tempValues[p]);
					System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
				}
			}
			else
			{
				fieldValueAry.add(request.getParameter("F"+request.getParameter("sm_code_hidden")+fieldCodes[i]));
				System.out.println("###########********tempValues["+p+"]**********##########"+request.getParameter("F"+request.getParameter("sm_code_hidden")+fieldCodes[i]));
			}
			vec.add(fieldCodes[i]);
		}
		i++;
	}
	
	fieldValues=(String[])fieldValueAry.toArray(new String[length]);
	//System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$fieldCodes.length"+fieldCodes.length);
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
            
            paramsIn.add(new String[]{iProduct_Prices   });
            paramsIn.add(new String[]{""   }           );
          //  paramsIn.add(new String[]{""   }           );
            paramsIn.add(new String[]{""   }           );
            paramsIn.add(new String[]{iProduct_Type   });//24
            paramsIn.add(new String[]{iService_Code   });
            paramsIn.add(new String[]{iService_Attr   });
            paramsIn.add(new String[]{iGrp_UserNo     });
            
            if(length>0)
            {
             paramsIn.add(fieldCodes);//28
             paramsIn.add(fieldValues);
             paramsIn.add(fieldRowNo);
             
            }
            else
            {
             paramsIn.add("");
             paramsIn.add("");
             paramsIn.add("");
            }
            
            						
			paramsIn.add(new String[]{channel_id   });//31
			
			//32-33
			String cust_code       = request.getParameter("cust_code");		   //IDC用户编码

			String bill_type       = "0";         //结算类型
			String bill_time       = request.getParameter("billTime");		   //结算日期
							
		paramsIn.add(new String[]{cust_code       });//32
        paramsIn.add(new String[]{iSm_Code       });//33
        paramsIn.add(new String[]{bill_type       });//34
        paramsIn.add(new String[]{bill_time       });//35
			
	name_list=request.getParameter("nameList_usr");
	grp_list=request.getParameter("nameGroupList_usr");
	token=new StringTokenizer(name_list,"|");
	token_grp=new StringTokenizer(grp_list,"|");
	length=token.countTokens();
	
	fieldCodes = new String [length];
	fieldValues= new String [length];
	fieldRowNo= new String [length];
	
	fieldValueAry = new ArrayList();
	vec = new Vector();
	
	
	//解析组号字符串
	k=0;
	while (token_grp.hasMoreElements()){
		fieldRowNo[k]=(String)token_grp.nextElement();
		//System.out.println("###########********fieldRowNo["+k+"]**********##########"+fieldRowNo[k]);
		k++;
	}
	
	i=0;
	p=0;
	//解析名字和值字符串
	while (token.hasMoreElements()){
		fieldCodes[i]=(String)token.nextElement();
		System.out.println("###########********fieldCodes["+i+"]**********##########"+fieldCodes[i]);
		System.out.println("###########********fieldRowNo["+i+"]**********##########"+fieldRowNo[i]);
		
		if(!vec.contains(fieldCodes[i]))
		{
			if(!fieldRowNo[i].equals("0"))	//行号从1开始
			{
				String[] tempValues = (String[])request.getParameterValues("F"+request.getParameter("userType")+fieldCodes[i]);
			//System.out.println("F"+request.getParameter("userType")+fieldCodes[i]);
				for(p=0;p<tempValues.length;p++)
				{
					fieldValueAry.add(tempValues[p]);
					System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
				}
			}
			else
			{
				fieldValueAry.add(request.getParameter("F"+request.getParameter("userType")+fieldCodes[i]));
				System.out.println("###########********tempValues["+p+"]**********##########"+request.getParameter("F"+request.getParameter("userType")+fieldCodes[i]));
			}
			vec.add(fieldCodes[i]);
		}
		i++;
	}
	
	fieldValues=(String[])fieldValueAry.toArray(new String[length]);

		String belong_code        = request.getParameter("belong_code_hidden");     //归属地区 add
		String pay_flag      = request.getParameter("hid_pay_flag");     //付费方式 add
		
		paramsIn.add(new String[]{feeList         });//36
		if(length>0)
		{
            paramsIn.add(fieldCodes                    );//37
            paramsIn.add(fieldValues                   );//38
            paramsIn.add(fieldRowNo                   );///39
            }
          else
          	{
          	  paramsIn.add("");
             	paramsIn.add("");
             	paramsIn.add("");
          	}
			paramsIn.add(new String[]{belong_code     });//40
			paramsIn.add(new String[]{pay_flag        });//41
			paramsIn.add(new String[]{mode_code       });	//42主套餐
            paramsIn.add(new String[]{""});//43附加套餐
           paramsIn.add(fieldCodes_2890);//44
			 paramsIn.add(fieldValues_2890);//45
	
			 paramsIn.add(gongnengfee_hid);//46
			 paramsIn.add(bizCode);//47
					 
            //retStr = callView.callService("sGrpProdOpen", paramsIn, "3", "region", iRegion_Code);
%>
			<wtc:service name="sGrpProdOpen" routerKey="region" routerValue="<%=regCode%>" retcode="retCode3" retmsg="retMsg3" outnum="3">			
			<wtc:param value="<%=iLoginAccept%>"/>
			<wtc:param value="<%=iOpCode%>"/>
			<wtc:param value="<%=iWorkNo%>"/>
			<wtc:param value="<%=iLogin_Pass%>"/>
			<wtc:param value="<%=iOrgCode%>"/>
			<wtc:param value="<%=iSys_Note%>"/>
			<wtc:param value="<%=iOp_Note%>"/>
			<wtc:param value="<%=iIpAddr%>"/>
			<wtc:param value="<%=iCust_Id%>"/>
			<wtc:param value="<%=iGrp_Id%>"/>
			<wtc:param value="<%=iContract_No%>"/>                  
			<wtc:param value="<%=iUser_Passwd %>"/>
			<wtc:param value="<%=iProvince%>"/>                     
			<wtc:param value="<%=iBelong_Code%>"/>
			<wtc:param value="<%=iBill_Type%>"/>
			<wtc:param value="<%=iBill_Date%>"/>
			<wtc:param value="<%=iGrp_Name%>"/>
			<wtc:param value="<%=iOrg_Id%>"/>
			<wtc:param value="<%=iGroup_Id%>"/>
			<wtc:param value="<%=iSm_Code%>"/>
			<wtc:param value="<%=iProduct_Code%>"/>                 
			<wtc:param value="iProduct_Prices"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=iProduct_Type%>"/>
			<wtc:param value="<%=iService_Code%>"/>
			<wtc:param value="<%=iService_Attr%>"/>
			<wtc:param value="<%=iGrp_UserNo%>"/>
			<wtc:params value="<%=fieldCodes%>"/>
			<wtc:params value="<%=fieldValues%>"/>
			<wtc:params value="<%=fieldRowNo%>"/>
			<wtc:param value="<%=channel_id%>"/>                       
			<wtc:param value="<%=cust_code%>"/>
			<wtc:param value="<%=iSm_Code%>"/>
			<wtc:param value="<%=bill_type%>"/>
			<wtc:param value="<%=bill_time%>"/>
			<wtc:param value="<%=feeList%>"/>
			<wtc:params value="<%=fieldCodes%>"/>
			<wtc:params value="<%=fieldValues%>"/>
			<wtc:params value="<%=fieldRowNo%>"/>
			<wtc:param value="<%=belong_code%>"/>                 
			<wtc:param value="<%=pay_flag%>"/>
			<wtc:param value="<%=mode_code%>"/>
			<wtc:param value=""/>
			<wtc:params value="<%=fieldCodes_2890%>"/>
			<wtc:params value="<%=fieldValues_2890%>"/>
			<wtc:param value="<%=gongnengfee_hid%>"/>
			<wtc:param value="<%=bizCode%>"/>
			</wtc:service>	
			<wtc:array id="retStrTemp"  scope="end"/>
<%            
			String url = "/npage/contact/onceCnttInfo.jsp?opCode="+iOpCode+"&retCodeForCntt="+retCode3+"&retMsgForCntt="+retMsg3+"&opName="+opName+"&workNo="+iWorkNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
%>
			<jsp:include page="<%=url%>" flush="true" />
<%
            retStr = retStrTemp;
            //System.out.println("paramsIn.size()="+paramsIn.size());
			//callView.printRetValue();
            error_code = retCode3;
            error_msg= retMsg3;
   			System.out.println("......error_code......."+error_code+"......error_msg...."+error_msg);

   			//----------------------为打印发票组织参数add
			  //double d_totalPay=0.00, d_cashPay=0.00, d_checkPay=0.00 ;
			  d_cashPay = Double.parseDouble(iCash_Pay);
			  d_handPay = Double.parseDouble(iHandFee);
			  d_totalPay = d_cashPay + d_handPay ;
			  //String totalPay = (new Double(d_totalPay2)).toString();
			  //System.out.println("*******iSm_Code****"+iSm_Code+"....iRegion_Code.."+iRegion_Code+"++iCust_Id "+iCust_Id);
			  String sqlStr="select sm_name from sSmCode where sm_code='"
							+iSm_Code + "' and region_code='"+iRegion_Code+"'";
			inParams[0] = "select sm_name from sSmCode where sm_code=:iSm_Code and region_code=:iRegion_Code";
			inParams[1] = "iSm_Code="+iSm_Code+",iRegion_Code="+iRegion_Code;
%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode4" retmsg="retMsg4" outnum="1">			
			<wtc:param value="<%=inParams[0]%>"/>	
			<wtc:param value="<%=inParams[1]%>"/>	
			</wtc:service>	
			<wtc:array id="smNameTemp"  scope="end"/>
<%
			  String sqlStr1="select cust_name from dCustDoc where cust_id ='"+iCust_Id + "'";
			  inParams[0] = "select cust_name from dCustDoc where cust_id =:iCust_Id";
			  inParams[1] = "iCust_Id="+iCust_Id;
			  //retList = callView.sPubSelect("1",sqlStr); 
%>
			  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode5" retmsg="retMsg5" outnum="1">			
			<wtc:param value="<%=inParams[0]%>"/>	
			<wtc:param value="<%=inParams[1]%>"/>	
			</wtc:service>	
			<wtc:array id="custNameTemp"  scope="end"/>
<%	
			  smName = smNameTemp[0][0];
			  //retList = callView.sPubSelect("1",sqlStr1); 
			  custName = custNameTemp[0][0];

    }catch(Exception e){
		e.printStackTrace();
		e.getMessage();
    }
   
    if(retStr==null || retStr.length==0)
  {
%>
	<script language='jscript'>
            rdShowMessageDialog("调用服务超时" ,0);
            history.go(-1);
    </script>
<%
	return;
 }
  else
 {
 	String error_code1=retStr[0][1];
 	String error_msg1=retStr[0][2];
 	
 	System.out.println("error_code1="+error_code1+" error_msg1="+error_msg1);
 	
   	
    //if(error_code == 0)
    if("000000".equals(error_code1) || "0".equals(error_code1))
    {
%>
<script language="javascript">

<%if(d_totalPay>0){

	 java.text.DecimalFormat df = new java.text.DecimalFormat(".00"); 
 	 String strTotal = df.format(d_totalPay);

%>
	  //打印发票
      rdShowMessageDialog("开户成功,下面将打印发票,请检查纸张!");

	  //--------------------print begin-----------------------------//
      var op_code = "<%=iOpCode%>";//op_code  操作代码
	  var work_no = "<%=iWorkNo%>";//work_no 工号
	  var maxAccept = "<%=iLoginAccept%>";//maxAccept 流水
	  var phoneNo = "<%=iGrp_UserNo%>";//phoneNo 手机号码////成员用户编码 ok
	  var smName = "<%=smName%>";//smName 品牌名称
	  var custName = "<%=custName%>";//custName 客户姓名  ///// oksql select cust_name from dCustDoc where //cust_id = 8610277301;
	  var iHandFee = "<%=iHandFee%>";// 实收手续费
	  var iCash_Pay = "<%=iCash_Pay%>";// 付款金额
	  var tmpMoney = Math.round(iHandFee)+Math.round(iCash_Pay);//tmpMoney 交费合计 =实收手续费+付款金额
	  //alert("tmpMoney"+tmpMoney);
	  var innetFee = "0.00";//innetFee 入网费 0
	  var simFee = "0.00";//simFee SIM卡费 0
	  var selectFee = "0.00"; //selectFee 选号费 0
	  var insuranceFee = "0.00";//insuranceFee 保险费 0
	  var checkMachineFee = "0.00";//checkMachineFee 验机费 0
	  var handFee = "<%=iHandFee%>"; //handFee 手续费 =实收手续费
	  var machineFee = "0.00"; //machineFee 机器费 0
	  var otherFee = "<%=iCash_Pay%>";//其他费 =付款金额
	  var totalPrepay = "0.00"; //totalPrepay 预存款 0
      var payType = "<%=iPay_Type%>";//付费类型
	  if(payType=='0'){
          var cashPay = tmpMoney; //cashPay 现金方式 tmpMoney ?0
	      var checkPay = "0.00"; //checkPay 支票方式 tmpMoney?0
	  }else{
		  var cashPay = "0.00"; //cashPay 现金方式 tmpMoney ?0
	      var checkPay = tmpMoney; //checkPay 支票方式 tmpMoney?0
	  }
	  var systemNote = "<%=systemNote%>"; //systemNote 系统备注
	  var opNote = "<%=opNote%>"; //opNote 用户备注

	  var printInfo = "op_code="+op_code+"&work_no="+work_no+"&maxAccept="+maxAccept+"&phoneNo="+phoneNo+"&smName="+smName+"&custName="+custName+"&tmpMoney="+tmpMoney+"&innetFee="+innetFee+"&simFee="+simFee+"&selectFee="+selectFee+"&insuranceFee="+insuranceFee+"&checkMachineFee="+checkMachineFee+"&handFee="+handFee+"&machineFee="+machineFee+"&otherFee="+otherFee+"&totalPrepay="+totalPrepay+"&cashPay="+cashPay+"&checkPay="+checkPay+"&systemNote="+systemNote+"&opNote="+opNote;

	 
	 
	 var ProFlag= "<%=ProvinceRun%>"; //判断省份
	 if(ProFlag=="20")//吉林
	  {
	    var infoStr="";
	     
	     infoStr+=" "+"|";
         infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+="<%=iGrp_Id%>"+"|";
	     infoStr+="<%=iContract_No%>"+"|";
	     infoStr+="<%=iGrp_Name%>"+"|";
	     infoStr+="<%=cust_Address%>"+"|";
		 infoStr+="现金"+"|";	
		 infoStr+="<%=strTotal%>"+"|";
	     infoStr+="手续费："+"<%=iHandFee%>"+"    流水号："+"<%=iLoginAccept%>"+"|";
	     infoStr+="<%=iWorkNo%>|";

      
     
	    var printPage="/npage/s2890/idc_print.jsp?retInfo="+infoStr;
	    var printPage = window.open(printPage);

	  }
	  else
	  {
		   var printPage="/npage/common/sPubPrintInvoice.jsp?";

	     var printPage = printPage + printInfo;


	  var h=150;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;     
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";

	    var retValue = window.showModalDialog(printPage,"",prop);
	  }
	  	  	  	 	 	  
	  //------------------------print end---------------------------------------////

	  this.location="s2890_1.jsp?opCode=2890&opName=EC产品定购";
	 <%}else{%>
      rdShowMessageDialog("EC产品订购成功！",2);
	  removeCurrentTab();
	 <%}%>	 
  </script>

<%  } else {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_code1%>" + "[" + "<%=error_msg1%>" + "]" ,0);
            history.go(-2);
        </script>
<%
    }
}
%>

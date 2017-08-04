<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-15
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
	String opName=(String)request.getParameter("opName");
    String[] retStr = null;
    ArrayList retArray = null;
    String error_code="";
    String error_msg="";
    Logger logger = Logger.getLogger("f3500_2.jsp");
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String smName="";
	String custName="";
    String [] paraIn = new String[2];
	
	ArrayList retList = new ArrayList();//返回结果
	double d_totalPay=0.00, d_cashPay=0.00, d_handPay=0.00 ;

    String iIpAddr = (String)session.getAttribute("ipAddr");
    System.out.println("ipAddr ====  "+iIpAddr);
    String iWorkNo = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String iOrgCode = (String)session.getAttribute("orgCode");
    String iLogin_Pass  = (String)session.getAttribute("password");
    String Department = iOrgCode;
    String regionCode = Department.substring(0,2);
    String districtCode = Department.substring(2,4);
    String townCode = Department.substring(4,7);
    
    String sql_str = "";
    //取运行省份代码 -- 为吉林增加，山西可以使用session
	String[][] result2  = null;
	sql_str = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	//result2 = (String[][])callView.sPubSelect("1",sql_str).get(0);
	String ProvinceRun = "";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="1">
    	<wtc:sql><%=sql_str%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr1" scope="end" />
<%
	if (retArr1.length > 0 && retCode1.equals("000000")) 
	{
		ProvinceRun = retArr1[0][0];
	}
	
    //取工号密码和GROUP_ID
    String GroupId = "";
    String OrgId = "";
    if(ProvinceRun.equals("20"))  //吉林
    {
		String[][] result1  = null;
		sql_str = "select group_id,'unknown' FROM dLoginMsg where login_no=:iWorkNo";
		//result1 = (String[][])callView.sPubSelect("2",sql_str).get(0);
		
		paraIn[0] = sql_str;    
        paraIn[1]="iWorkNo="+iWorkNo;
%>
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2" >
        	<wtc:param value="<%=paraIn[0]%>"/>
        	<wtc:param value="<%=paraIn[1]%>"/> 
        </wtc:service>
        <wtc:array id="retArr2" scope="end"/>
<%
        if(retCode2.equals("000000")){
            result1 = retArr2;
        }
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
   
 String iccid    = request.getParameter("iccid");     //操作流水号
    String iLoginAccept    = request.getParameter("login_accept");     //操作流水号
    System.out.println("----------------iLoginAccept==="+iLoginAccept);
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
	//System.out.println("$$$$$$$$$$$$$$$$iProvince="+iProvince);
    String iBelong_Code    = request.getParameter("belong_code").substring(0,7);      //客户归属地区
    String iBill_Type      = request.getParameter("bill_type");        //出帐周期
    String iBill_Date      = request.getParameter("srv_stop");         //业务结束时间????
    String iGrp_Name       = request.getParameter("grp_name");         //集团用户名称
    String iOrg_Id         = request.getParameter("org_id");           //操作员的org_id
    String iGroup_Id       = request.getParameter("group_id");         //操作员的group_id
    System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&& iOrg_Id  "+iOrg_Id);
    System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&& iGroup_Id  "+iGroup_Id);
    //String iSm_Code        = request.getParameter("sm_code");          //服务品牌代码
	String iSm_Code        = request.getParameter("userType");          //服务品牌代码
	//System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&& iSm_Code  "+iSm_Code);
    String iProduct_Code   = request.getParameter("product_code");     //集团主产品代码
    String iProduct_Append = request.getParameter("product_append");   //集团附加产品代码
    String iProduct_Prices = request.getParameter("product_prices");   //产品价格代码
    
    
    String iProduct_Attr   = request.getParameter("product_attr");     //产品属性代码
      
    //System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&iProduct_Attr="+iProduct_Attr);
    String iProduct_Type   = request.getParameter("product_type");     //产品类型
    String iService_Code   = request.getParameter("service_code");     //服务代码
    String iService_Attr   = request.getParameter("service_attr");     //服务属性
	String grpFieldCode    ="10200";
	/////////////////////String grpFieldValue   =request.getParameter("userNum");
	String iPay_Type	   = request.getParameter("payType");     //付款方式
	String iPay_Type_Value="";
	if(iPay_Type.equals("0"))
	{
		iPay_Type_Value="现金";
	}
	else
	{
		iPay_Type_Value="支票";
	}
	
	String iCash_Pay	   = request.getParameter("cashNum");     //支付金额
	String iCheck_No	   = request.getParameter("checkNo");     //支票号码
	String iBank_Code	   = request.getParameter("bankCode");     //银行代码
	String iCheck_Pay	   = request.getParameter("checkPay");     //支票交款
	String iCashPay	   = request.getParameter("cashPay");     //现金交款
	String iShouldHandFee  = request.getParameter("should_handfee");   //应收手续费
    String iHandFee        = request.getParameter("real_handfee");     //实收手续费    
    String pay_si        = request.getParameter("pay_si");     //结算SI
	String systemNote        = request.getParameter("sysnote");     //系统备注
	String opNote        = request.getParameter("tonote");     //用户备注
	//String town_code        = request.getParameter("town_code");     //用户备注
	String town_code        = "101";     //用户备注
	String channel_id = "";
	String cust_Address = request.getParameter("cust_address");
	
	if(town_code.equals("101")){
	    channel_id = OrgId;
		//System.out.println("&&&&&&&&HHHHHHH");
	}else{
	    channel_id        = request.getParameter("channel_id");     //用户备注
	//System.out.println("&&&&&&&&gggggggggggg");
	}
	//System.out.println("*******************************channel_id"+channel_id);

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
    //String iContract_List  = "";                                       //合同列表
    //String iContract_Desc  = "";                                       //合同描述
    //String iPayNo          = request.getParameter("pay_no");           //付费手机号码
    String iGrp_UserNo     = request.getParameter("grp_userno");       //集团用户编号
    String iRegion_Code = iOrgCode.substring(0,2);
    iUser_Passwd = Encrypt.encrypt(iUser_Passwd);  //加密用户密码

    int i=0,j=0,k=0;
    i = iProduct_Code.indexOf("|"); //得到主产品代码
    iProduct_Code = iProduct_Code.substring(0, i);

    for (i=0,j=1; i<iProduct_Append.length(); i++) { //统计附加产品数量
        if (iProduct_Append.charAt(i) == ',')
            j++;
    }

    String[] ProdAppend = new String[j+1]; //将附加产品、产品价格、产品属性分解到数组中
    String[] ProdPrice = new String[j+1];
    String[] ProdAttr = new String[j+1];
    ProdAppend[0] = iProduct_Code;
    ProdPrice[0] = "";
    ProdAttr[0] = "";
    for(i=1; i<j+1; i++) {
        k = iProduct_Append.indexOf(',');
        if (k > 0)
            ProdAppend[i] = iProduct_Append.substring(0, k);
        else
            ProdAppend[i] = iProduct_Append;
        ProdPrice[i] = "";
        ProdAttr[i] = "";
        //iProduct_Append = iProduct_Append.substring(k+1);
    }

	String name_list=request.getParameter("nameList");
	String grp_list=request.getParameter("nameGroupList");
	StringTokenizer token=new StringTokenizer(name_list,"|");
	StringTokenizer token_grp=new StringTokenizer(grp_list,"|");
	int length=token.countTokens();
	
	String fieldCodes[] = new String [length];
	String fieldValues[]= new String [length];
	String fieldRowNo[]= new String [length];
	
	String parm1[] = new String [length];
    String parm2[] = new String [length];
    String parm3[] = new String [length];
            
	ArrayList fieldValueAry = new ArrayList();
	Vector vec = new Vector();
	
	
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
				String[] tempValues = (String[])request.getParameterValues("F"+fieldCodes[i]);
				for(p=0;p<tempValues.length;p++)
				{
					fieldValueAry.add(tempValues[p]);
					System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
				}
			}
			else
			{
				fieldValueAry.add(request.getParameter("F"+fieldCodes[i]));
				System.out.println("###########********tempValues["+p+"]**********##########"+request.getParameter("F"+fieldCodes[i]));
			}
			vec.add(fieldCodes[i]);
		}
		i++;
	}
	
	fieldValues=(String[])fieldValueAry.toArray(new String[length]);
	
	try
    {
    	if (iSm_Code.equals("j0"))
    		iOpCode = "3900";
    	if (iSm_Code.equals("j1"))
    		iOpCode = "3810";
    	if (iSm_Code.equals("j2"))
    		iOpCode = "3800";
    
            ArrayList paramsIn = new ArrayList();
            paramsIn.add(new String[]{iLoginAccept    });
            paramsIn.add(new String[]{iOpCode         });
            paramsIn.add(new String[]{iWorkNo         });
            paramsIn.add(new String[]{iLogin_Pass     });
            paramsIn.add(new String[]{iOrgCode        });
            paramsIn.add(new String[]{iSys_Note       });
            paramsIn.add(new String[]{iOp_Note        });
            paramsIn.add(new String[]{iIpAddr         });
            paramsIn.add(new String[]{iCust_Id        });
            paramsIn.add(new String[]{iGrp_Id         });
            paramsIn.add(new String[]{iContract_No    });
            paramsIn.add(new String[]{iUser_Passwd    });
            paramsIn.add(new String[]{iProvince       });
            paramsIn.add(new String[]{iBelong_Code    });
            paramsIn.add(new String[]{iBill_Type      });
            paramsIn.add(new String[]{iBill_Date      });
            paramsIn.add(new String[]{iGrp_Name       });
            paramsIn.add(new String[]{iOrg_Id         });
            paramsIn.add(new String[]{iGroup_Id       });
            paramsIn.add(new String[]{iSm_Code        });
            paramsIn.add(new String[]{iProduct_Code   });
            paramsIn.add(ProdAppend                  );

            paramsIn.add(iProduct_Prices               );
            //paramsIn.add(ProdPrice                     );

            paramsIn.add(ProdAttr                      );
            paramsIn.add(new String[]{iProduct_Type   });
            paramsIn.add(new String[]{iService_Code   });
            paramsIn.add(new String[]{iService_Attr   });
			paramsIn.add(new String[]{feeList         });
            //paramsIn.add(new String[]{iContract_List  });
           // paramsIn.add(new String[]{iContract_Desc  });
            //paramsIn.add(new String[]{iShouldHandFee  });
           // paramsIn.add(new String[]{iHandFee        });
            //paramsIn.add(new String[]{iPayNo          });
            paramsIn.add(new String[]{iGrp_UserNo     });
     if(length>0)
     {       
			paramsIn.add(fieldCodes);
			paramsIn.add(fieldValues);
			paramsIn.add(fieldRowNo);
			}
		 else
			{
			paramsIn.add("");
			paramsIn.add("");
			paramsIn.add("");
			
			}
			paramsIn.add(new String[]{channel_id   });
            paramsIn.add(new String[]{pay_si   });//结算SI
            
            if(length>0)
            {       
    			parm1 = fieldCodes;
    			parm2 = fieldValues;
    			parm3 = fieldRowNo;
			}
		    
			
            //retStr = callView.callService("s3500Cfm", paramsIn, "1", "region", iRegion_Code);
            %>
            <wtc:service name="s3500Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="s3500CfmCode" retmsg="s3500CfmMsg" outnum="1" >
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
                <wtc:param value="<%=iUser_Passwd%>"/>
                <wtc:param value="<%=iProvince%>"/>
                <wtc:param value="<%=iBelong_Code%>"/>
                <wtc:param value="<%=iBill_Type%>"/>
                <wtc:param value="<%=iBill_Date%>"/>
                <wtc:param value="<%=iGrp_Name%>"/>
                <wtc:param value="<%=iOrg_Id%>"/>
                <wtc:param value="<%=iGroup_Id%>"/>
                <wtc:param value="<%=iSm_Code%>"/>
                <wtc:param value="<%=iProduct_Code%>"/>
                <wtc:params value="<%=ProdAppend%>"/>
                <wtc:param value="<%=iProduct_Prices%>"/>
                <wtc:params value="<%=ProdAttr%>"/>
                <wtc:param value="<%=iProduct_Type%>"/>
                <wtc:param value="<%=iService_Code%>"/>
                <wtc:param value="<%=iService_Attr%>"/>
                <wtc:param value="<%=feeList%>"/>
                <wtc:param value="<%=iGrp_UserNo%>"/>
                <wtc:params value="<%=parm1%>"/>
                <wtc:params value="<%=parm2%>"/>
                <wtc:params value="<%=parm3%>"/>
                <wtc:param value="<%=channel_id%>"/>
                <wtc:param value="<%=pay_si%>"/>
                
            </wtc:service>
            <wtc:array id="s3500CfmArr" scope="end"/>
            <%
			//callView.printRetValue();
            //error_code = callView.getErrCode();
            //error_msg= callView.getErrMsg();
            error_code = s3500CfmCode;
            error_msg = s3500CfmMsg;
            
            
    
   //System.out.println("......error_code......."+error_code+"......error_msg...."+error_msg);

   //----------------------为打印发票组织参数add
			  //double d_totalPay=0.00, d_cashPay=0.00, d_checkPay=0.00 ;
			  d_cashPay = Double.parseDouble(iCash_Pay);
			  d_handPay = Double.parseDouble(iHandFee);
			  d_totalPay = d_cashPay + d_handPay ;
			  //String totalPay = (new Double(d_totalPay2)).toString();
//System.out.println("*******iSm_Code****"+iSm_Code+"....iRegion_Code.."+iRegion_Code+"++iCust_Id "+iCust_Id);

			  String sqlStr="select sm_name from sSmCode where sm_code=:iSm_Code and region_code=:iRegion_Code";
							
			  String sqlStr1="select cust_name from dCustDoc where cust_id =:iCust_Id";
			  
			  //retList = callView.sPubSelect("1",sqlStr); 
			  
              paraIn[0] = sqlStr;    
              paraIn[1]="iSm_Code="+iSm_Code+",iRegion_Code="+iRegion_Code;
    %>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4" outnum="1" >
            	<wtc:param value="<%=paraIn[0]%>"/>
            	<wtc:param value="<%=paraIn[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr4" scope="end"/>
    <%
              if(retArr4.length>0 && retCode4.equals("000000")){
                    smName = retArr4[0][0];
              }
                         
			  //smName = ((String[][])retList.get(0))[0][0];
			  //retList = callView.sPubSelect("1",sqlStr1); 
			  
			  paraIn[0] = sqlStr1;    
              paraIn[1]="iCust_Id="+iCust_Id;
    %>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5" outnum="1" >
            	<wtc:param value="<%=paraIn[0]%>"/>
            	<wtc:param value="<%=paraIn[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr5" scope="end"/>
    <%
              if(retArr5.length>0 && retCode5.equals("000000")){
                    custName = retArr5[0][0];
              }
              
			  //custName = ((String[][])retList.get(0))[0][0];

    }catch(Exception e){
		e.printStackTrace();
		e.getMessage();
        logger.error("Call s3500Cfm is Failed!-----");
    }
 
    if(error_code.equals("000000"))
    {
    
    	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
    	ArrayList retList0 = new ArrayList();  
		String sqlStr0="";
 		sqlStr0 ="select user_no from dgrpusermsg where id_no=:iGrp_Id";
 		//retList0 = impl.sPubSelect("1",sqlStr0,"region",regionCode);
 		
 		String grp_user_no="";
 		paraIn[0] = sqlStr0;    
        paraIn[1]="iGrp_Id="+iGrp_Id;
    %>
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode6" retmsg="retMsg6" outnum="1" >
        	<wtc:param value="<%=paraIn[0]%>"/>
        	<wtc:param value="<%=paraIn[1]%>"/> 
        </wtc:service>
        <wtc:array id="retArr6" scope="end"/>
    <%
        if(retArr6.length>0 && retCode6.equals("000000")){
            grp_user_no = retArr6[0][0];
        }
 		//String[][] retListString0 = (String[][])retList0.get(0);
		//grp_user_no=retListString0[0][0];
%>
<script language="javascript">

<%if(d_totalPay>0){

java.text.DecimalFormat df = new java.text.DecimalFormat(".00"); 
 String strTotal = df.format(d_totalPay);

%>
	  //打印发票
      rdShowMessageDialog("开户成功,下面将打印发票,请检查纸张!",2);

	  //--------------------print begin-----------------------------//
    var op_code = "<%=iOpCode%>";//op_code  操作代码
	  var work_no = "<%=iWorkNo%>";//work_no 工号
	  var maxAccept = "<%=iLoginAccept%>";//maxAccept 流水
	  var phoneNo = "<%=iGrp_UserNo%>";//phoneNo 手机号码////成员用户编码 ok
	  var smName = "<%=smName%>";//smName 品牌名称
	  var custName = "<%=custName%>";//custName 客户姓名  ///// oksql select cust_name from dCustDoc where //cust_id = 8610277301;
	  var cust_Address="<%=cust_Address%>";
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
	     infoStr+="<%=custName%>"+"|";
	     infoStr+="<%=cust_Address%>"+"|";
		   infoStr+="现金"+"|";	
		   infoStr+="<%=strTotal%>"+"|";
	     infoStr+="*手续费："+"<%=iHandFee%>"+"*流水号："+"<%=iLoginAccept%>"+"|";
       infoStr+="<%=iWorkNo%>|";
     
	    var printPage="/npage/s3500/idc_print.jsp?retInfo="+infoStr;
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
	  
	  
	  
	  
	  
	  
	  //------------------------print end---------------------------------------//

	  this.location="s3500_1.jsp";
	 <%}else{%>
      rdShowMessageDialog("集团用户开户操作成功！",2);
      prtFlag = rdShowConfirmDialog("是否打印电子免填单？");
        //提交打印界面
	
        
        if (prtFlag==1) {

			var printPage="/npage/s3500/sGrpPubPrint3500.jsp?op_code=3500"
														+"&phone_no=" +"<%=iGrp_UserNo%>"       
														+"&function_name=集团产品开户"   
														+"&work_no="+"<%=iWorkNo%>"        
														+"&cust_name="+"<%=custName%>"     
														+"&login_accept="+"<%=iLoginAccept%>" 
														+"&idIccid=" +"<%=iccid%>"       
														+"&hand_fee=" +"<%=iHandFee%>"        
														+"&mode_name="+"<%=iProduct_Code%>"       
														+"&custAddress="+"<%=cust_Address%>"     
														+"&system_note="+"<%=systemNote%>"     
														+"&op_note="+"<%=opNote%>"          
														+"&space="           
														+"&copynote="
														+"&work_name="+"<%=workname%>"
														+"&pay_type="+"<%=iPay_Type_Value%>"
														+"&account_id="+"<%=iContract_No%>"
														+"&grp_user_no="+"<%=grp_user_no%>";
		   var printPage = window.open(printPage,"","width=200,height=200")
		}
	  this.location="s3500_1.jsp";
	 <%}%>	 
  </script>

<%  } else {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_code%>" + "[" + "<%=error_msg%>" + "]" ,0);
            history.go(-1);
        </script>
<%
    }
    
    String url = "/npage/contact/onceCnttInfo.jsp?opCode="+iOpCode +"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg
		+"&opName="+opName+"&workNo="+iWorkNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+iGrp_Id
		+"&opBeginTime="+opBeginTime+"&contactId="+iGrp_Id+"&contactType=grp";
%>
	<jsp:include page="<%=url%>" flush="true" />
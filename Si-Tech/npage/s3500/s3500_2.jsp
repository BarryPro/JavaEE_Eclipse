<%
/********************
 * version v2.0
 * ������: si-tech
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
	
	ArrayList retList = new ArrayList();//���ؽ��
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
    //ȡ����ʡ�ݴ��� -- Ϊ�������ӣ�ɽ������ʹ��session
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
	
    //ȡ���������GROUP_ID
    String GroupId = "";
    String OrgId = "";
    if(ProvinceRun.equals("20"))  //����
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
   
 String iccid    = request.getParameter("iccid");     //������ˮ��
    String iLoginAccept    = request.getParameter("login_accept");     //������ˮ��
    System.out.println("----------------iLoginAccept==="+iLoginAccept);
    String iOpCode         = request.getParameter("op_code");          //��������
    //String iWorkNo         = request.getParameter("WorkNo");           //����Ա����
   // String iLogin_Pass     = request.getParameter("NoPass");           //����Ա����
   // String iOrgCode        = request.getParameter("OrgCode");          //����Ա��������
    String iSys_Note       = request.getParameter("sysnote");          //ϵͳ������ע
    String iOp_Note        = request.getParameter("tonote");           //�û�������ע
    //String iIpAddr         = request.getParameter("ip_Addr");          //����ԱIP��ַ
    String iCust_Id        = request.getParameter("cust_id");          //���ſͻ�ID
    String iGrp_Id         = request.getParameter("grp_id");           //�����û�ID
    String iContract_No    = request.getParameter("account_id");       //�����û��ʺ�
    String iUser_Passwd    = request.getParameter("user_passwd");      //�����û�����
    String iProvince       = request.getParameter("province");         //��������ʡ��
	//System.out.println("$$$$$$$$$$$$$$$$iProvince="+iProvince);
    String iBelong_Code    = request.getParameter("belong_code").substring(0,7);      //�ͻ���������
    String iBill_Type      = request.getParameter("bill_type");        //��������
    String iBill_Date      = request.getParameter("srv_stop");         //ҵ�����ʱ��????
    String iGrp_Name       = request.getParameter("grp_name");         //�����û�����
    String iOrg_Id         = request.getParameter("org_id");           //����Ա��org_id
    String iGroup_Id       = request.getParameter("group_id");         //����Ա��group_id
    System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&& iOrg_Id  "+iOrg_Id);
    System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&& iGroup_Id  "+iGroup_Id);
    //String iSm_Code        = request.getParameter("sm_code");          //����Ʒ�ƴ���
	String iSm_Code        = request.getParameter("userType");          //����Ʒ�ƴ���
	//System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&& iSm_Code  "+iSm_Code);
    String iProduct_Code   = request.getParameter("product_code");     //��������Ʒ����
    String iProduct_Append = request.getParameter("product_append");   //���Ÿ��Ӳ�Ʒ����
    String iProduct_Prices = request.getParameter("product_prices");   //��Ʒ�۸����
    
    
    String iProduct_Attr   = request.getParameter("product_attr");     //��Ʒ���Դ���
      
    //System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&iProduct_Attr="+iProduct_Attr);
    String iProduct_Type   = request.getParameter("product_type");     //��Ʒ����
    String iService_Code   = request.getParameter("service_code");     //�������
    String iService_Attr   = request.getParameter("service_attr");     //��������
	String grpFieldCode    ="10200";
	/////////////////////String grpFieldValue   =request.getParameter("userNum");
	String iPay_Type	   = request.getParameter("payType");     //���ʽ
	String iPay_Type_Value="";
	if(iPay_Type.equals("0"))
	{
		iPay_Type_Value="�ֽ�";
	}
	else
	{
		iPay_Type_Value="֧Ʊ";
	}
	
	String iCash_Pay	   = request.getParameter("cashNum");     //֧�����
	String iCheck_No	   = request.getParameter("checkNo");     //֧Ʊ����
	String iBank_Code	   = request.getParameter("bankCode");     //���д���
	String iCheck_Pay	   = request.getParameter("checkPay");     //֧Ʊ����
	String iCashPay	   = request.getParameter("cashPay");     //�ֽ𽻿�
	String iShouldHandFee  = request.getParameter("should_handfee");   //Ӧ��������
    String iHandFee        = request.getParameter("real_handfee");     //ʵ��������    
    String pay_si        = request.getParameter("pay_si");     //����SI
	String systemNote        = request.getParameter("sysnote");     //ϵͳ��ע
	String opNote        = request.getParameter("tonote");     //�û���ע
	//String town_code        = request.getParameter("town_code");     //�û���ע
	String town_code        = "101";     //�û���ע
	String channel_id = "";
	String cust_Address = request.getParameter("cust_address");
	
	if(town_code.equals("101")){
	    channel_id = OrgId;
		//System.out.println("&&&&&&&&HHHHHHH");
	}else{
	    channel_id        = request.getParameter("channel_id");     //�û���ע
	//System.out.println("&&&&&&&&gggggggggggg");
	}
	//System.out.println("*******************************channel_id"+channel_id);

 //payType ���ѷ�ʽ ~ checkNo ֧Ʊ���� ~ bankCode ���д��� ~ checkPay ֧Ʊ���� ~ cashPay �ֽ𽻿� ~ shouldHandFee ������ ~ handFee ������
     if (iCash_Pay == null)
    {
    	iCash_Pay = "0.00";
    }
	 if (iHandFee == null)
    {
    	iHandFee = "0.00";
    }
	String feeList="";                                                 //������Ϣ
	feeList=iPay_Type+"~"+iCheck_No+"~"+iBank_Code+"~"+iCheck_Pay+"~"+iCashPay+"~"+iShouldHandFee+"~"+iHandFee+"~";
    //String iContract_List  = "";                                       //��ͬ�б�
    //String iContract_Desc  = "";                                       //��ͬ����
    //String iPayNo          = request.getParameter("pay_no");           //�����ֻ�����
    String iGrp_UserNo     = request.getParameter("grp_userno");       //�����û����
    String iRegion_Code = iOrgCode.substring(0,2);
    iUser_Passwd = Encrypt.encrypt(iUser_Passwd);  //�����û�����

    int i=0,j=0,k=0;
    i = iProduct_Code.indexOf("|"); //�õ�����Ʒ����
    iProduct_Code = iProduct_Code.substring(0, i);

    for (i=0,j=1; i<iProduct_Append.length(); i++) { //ͳ�Ƹ��Ӳ�Ʒ����
        if (iProduct_Append.charAt(i) == ',')
            j++;
    }

    String[] ProdAppend = new String[j+1]; //�����Ӳ�Ʒ����Ʒ�۸񡢲�Ʒ���Էֽ⵽������
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
	
	
	//��������ַ���
	k=0;
	while (token_grp.hasMoreElements()){
		fieldRowNo[k]=(String)token_grp.nextElement();
		//System.out.println("###########********fieldRowNo["+k+"]**********##########"+fieldRowNo[k]);
		k++;
	}
	
	i=0;
	int p=0;
	//�������ֺ�ֵ�ַ���
	while (token.hasMoreElements()){
		fieldCodes[i]=(String)token.nextElement();
		System.out.println("###########********fieldCodes["+i+"]**********##########"+fieldCodes[i]);
		System.out.println("###########********fieldRowNo["+i+"]**********##########"+fieldRowNo[i]);
		
		if(!vec.contains(fieldCodes[i]))
		{
			if(!fieldRowNo[i].equals("0"))	//�кŴ�1��ʼ
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
            paramsIn.add(new String[]{pay_si   });//����SI
            
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

   //----------------------Ϊ��ӡ��Ʊ��֯����add
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
	  //��ӡ��Ʊ
      rdShowMessageDialog("�����ɹ�,���潫��ӡ��Ʊ,����ֽ��!",2);

	  //--------------------print begin-----------------------------//
    var op_code = "<%=iOpCode%>";//op_code  ��������
	  var work_no = "<%=iWorkNo%>";//work_no ����
	  var maxAccept = "<%=iLoginAccept%>";//maxAccept ��ˮ
	  var phoneNo = "<%=iGrp_UserNo%>";//phoneNo �ֻ�����////��Ա�û����� ok
	  var smName = "<%=smName%>";//smName Ʒ������
	  var custName = "<%=custName%>";//custName �ͻ�����  ///// oksql select cust_name from dCustDoc where //cust_id = 8610277301;
	  var cust_Address="<%=cust_Address%>";
	  var iHandFee = "<%=iHandFee%>";// ʵ��������
	  var iCash_Pay = "<%=iCash_Pay%>";// ������
	  var tmpMoney = Math.round(iHandFee)+Math.round(iCash_Pay);//tmpMoney ���Ѻϼ� =ʵ��������+������
	  //alert("tmpMoney"+tmpMoney);
	  var innetFee = "0.00";//innetFee ������ 0
	  var simFee = "0.00";//simFee SIM���� 0
	  var selectFee = "0.00"; //selectFee ѡ�ŷ� 0
	  var insuranceFee = "0.00";//insuranceFee ���շ� 0
	  var checkMachineFee = "0.00";//checkMachineFee ����� 0
	  var handFee = "<%=iHandFee%>"; //handFee ������ =ʵ��������
	  var machineFee = "0.00"; //machineFee ������ 0
	  var otherFee = "<%=iCash_Pay%>";//������ =������
	  var totalPrepay = "0.00"; //totalPrepay Ԥ��� 0
      var payType = "<%=iPay_Type%>";//��������
	  if(payType=='0'){
          var cashPay = tmpMoney; //cashPay �ֽ�ʽ tmpMoney ?0
	      var checkPay = "0.00"; //checkPay ֧Ʊ��ʽ tmpMoney?0
	  }else{
		  var cashPay = "0.00"; //cashPay �ֽ�ʽ tmpMoney ?0
	      var checkPay = tmpMoney; //checkPay ֧Ʊ��ʽ tmpMoney?0
	  }
	  var systemNote = "<%=systemNote%>"; //systemNote ϵͳ��ע
	  var opNote = "<%=opNote%>"; //opNote �û���ע

	  var printInfo = "op_code="+op_code+"&work_no="+work_no+"&maxAccept="+maxAccept+"&phoneNo="+phoneNo+"&smName="+smName+"&custName="+custName+"&tmpMoney="+tmpMoney+"&innetFee="+innetFee+"&simFee="+simFee+"&selectFee="+selectFee+"&insuranceFee="+insuranceFee+"&checkMachineFee="+checkMachineFee+"&handFee="+handFee+"&machineFee="+machineFee+"&otherFee="+otherFee+"&totalPrepay="+totalPrepay+"&cashPay="+cashPay+"&checkPay="+checkPay+"&systemNote="+systemNote+"&opNote="+opNote;

	 
	 
	 var ProFlag= "<%=ProvinceRun%>"; //�ж�ʡ��
	 if(ProFlag=="20")//����
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
		   infoStr+="�ֽ�"+"|";	
		   infoStr+="<%=strTotal%>"+"|";
	     infoStr+="*�����ѣ�"+"<%=iHandFee%>"+"*��ˮ�ţ�"+"<%=iLoginAccept%>"+"|";
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
      rdShowMessageDialog("�����û����������ɹ���",2);
      prtFlag = rdShowConfirmDialog("�Ƿ��ӡ���������");
        //�ύ��ӡ����
	
        
        if (prtFlag==1) {

			var printPage="/npage/s3500/sGrpPubPrint3500.jsp?op_code=3500"
														+"&phone_no=" +"<%=iGrp_UserNo%>"       
														+"&function_name=���Ų�Ʒ����"   
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
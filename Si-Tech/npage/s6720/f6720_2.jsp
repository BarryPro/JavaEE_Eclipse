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

    String[] retStr = null;
    ArrayList retArray = null;
    String error_code="";
    String error_msg="";
    Logger logger = Logger.getLogger("s2890_2.jsp");
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    String smName="";
    String custName="";
    ArrayList retList = new ArrayList();//���ؽ��
    double d_totalPay=0.00, d_cashPay=0.00, d_handPay=0.00 ;
    String [] paraIn = new String[2];

    String iIpAddr = (String)session.getAttribute("ipAddr");
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
   
    String iLoginAccept    = request.getParameter("login_accept");     //������ˮ��
    String iOpCode         = request.getParameter("op_code");          //��������
    String iSys_Note       = request.getParameter("sysnote");          //ϵͳ������ע
    String iOp_Note        = request.getParameter("tonote");           //�û�������ע
    String iCust_Id        = request.getParameter("cust_id");          //���ſͻ�ID
    String iGrp_Id         = request.getParameter("grp_id");           //�����û�ID
    String iContract_No    = request.getParameter("account_id");       //�����û��ʺ�
    String iUser_Passwd    = request.getParameter("user_passwd");      //�����û�����
    String iProvince       = request.getParameter("province");         //��������ʡ��
   
   
    String iBelong_Code    = request.getParameter("belong_codeNew").substring(0,7);      //�ͻ���������
    
    
    String iBill_Type      = request.getParameter("bill_type");        //��������
    String iBill_Date      = request.getParameter("srv_stop");         //ҵ�����ʱ��
    String iGrp_Name       = request.getParameter("grp_name");         //�����û�����
    String custAddress     = request.getParameter("custAddress"); 
    String iOrg_Id         = request.getParameter("org_id");           //����Ա��org_id
    String iGroup_Id       = request.getParameter("group_id");         //����Ա��group_id
	String iSm_Code        = request.getParameter("hid_sm_code");      //����Ʒ�ƴ���
	

    String iProduct_Code   = request.getParameter("product_code");     //��������Ʒ����
    String iProduct_Append = request.getParameter("product_append");   //���Ÿ��Ӳ�Ʒ����
    String iProduct_Prices = request.getParameter("product_prices");   //��Ʒ�۸����
    String iProduct_Attr   = request.getParameter("product_attr");     //��Ʒ���Դ���
  	
    String mode_code       = "";//request.getParameter("modeCode");    //���ײʹ���
	String add_mode       ="";//request.getParameter("addProduct");    //����ģ���
    String iProduct_Type   = request.getParameter("product_type");     //��Ʒ����
    String iService_Code   = request.getParameter("service_code");     //�������
    String iService_Attr   = request.getParameter("service_attr");     //��������
	String grpFieldCode    ="10200";
	String iPay_Type	   = request.getParameter("payType");            //���ʽ
	String iCash_Pay	   = request.getParameter("cashNum");            //֧�����
	String iCheck_No	   = request.getParameter("checkNo");            //֧Ʊ����
	String iBank_Code	   = request.getParameter("bankCode");           //���д���
	String iCheck_Pay	   = request.getParameter("checkPay");           //֧Ʊ����
	String iCashPay	     = request.getParameter("cashPay");            //�ֽ𽻿�
	String iShouldHandFee  = request.getParameter("should_handfee");   //Ӧ��������
    String iHandFee        = request.getParameter("real_handfee");     //ʵ��������
	String systemNote      = request.getParameter("sysnote");          //ϵͳ��ע
	String opNote        = request.getParameter("tonote");             //�û���ע
	String town_code        = "101";                                 
	String channel_id = "";
	String cust_Address = request.getParameter("cust_address"); 
	


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
    String iGrp_UserNo     = request.getParameter("grp_userno");       //�����û����
    String iRegion_Code = iOrgCode.substring(0,2);
    iUser_Passwd = Encrypt.encrypt(iUser_Passwd);  //�����û�����
    
    int i=0,j=0,k=0;
    i = iProduct_Code.indexOf("|"); //�õ�����Ʒ����
    iProduct_Code = iProduct_Code.substring(0, i);
       
    String[] ProdAppend = new String[j+1]; //�����Ӳ�Ʒ����Ʒ�۸񡢲�Ʒ���Էֽ⵽������
    String[] ProdPrice = new String[j+1];
    String[] ProdAttr = new String[j+1];
    ProdAppend[0] = iProduct_Code;
    ProdPrice[0] = "";
    ProdAttr[0] = "";
    for(i=1; i<j+1; i++) {       
        ProdPrice[i] = "";
        ProdAttr[i] = "";
    }
  
	String name_list=request.getParameter("nameList_grp");
	String grp_list=request.getParameter("nameGroupList_grp");
		
	StringTokenizer token=new StringTokenizer(name_list,"|");
	StringTokenizer token_grp=new StringTokenizer(grp_list,"|");
	
	int length=token.countTokens();
		
	String fieldCodes[] = new String [length];
	String fieldValues[]= new String [length];
	String fieldRowNo[] = new String [length];
		
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
				String[] tempValues = (String[])request.getParameterValues("F"+request.getParameter("hid_sm_code")+fieldCodes[i]);
				for(p=0;p<tempValues.length;p++)
				{
					fieldValueAry.add(tempValues[p]);
					System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
				}
			}
			else
			{
				fieldValueAry.add(request.getParameter("F"+request.getParameter("hid_sm_code")+fieldCodes[i]));
				System.out.println("###########********tempValues["+p+"]**********##########"+request.getParameter("F"+request.getParameter("hid_sm_code")+fieldCodes[i]));
			}
			vec.add(fieldCodes[i]);
		}
		i++;
	}
	
	fieldValues=(String[])fieldValueAry.toArray(new String[length]);
	try
    {
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
            paramsIn.add(ProdAppend                    );     
            paramsIn.add(ProdPrice                     );     
            paramsIn.add(ProdAttr                      );     
            paramsIn.add(new String[]{iProduct_Type   });     
            paramsIn.add(new String[]{iService_Code   });     
            paramsIn.add(new String[]{iService_Attr   });     
            paramsIn.add(new String[]{iGrp_UserNo     });       
                                                                         
            if(length>0)                                                 
            {                                                            
                parm1 = fieldCodes;
    			parm2 = fieldValues;
    			parm3 = fieldRowNo;                
            }                                               
                                                        
                                                                        						                                    
						paramsIn.add(new String[]{channel_id   });          
  
  			//9-12                                                
				String cust_code       = request.getParameter("cust_code");		   //IDC�û�����
				String user_type       = request.getParameter("userType");       //�û�����
				String bill_type       = "0";                                    //��������
				String bill_time       = request.getParameter("billTime");		   //��������
				
				String Mng_user=request.getParameter("Mng_user"); 
				  				                                                        
        String Mng_pwd =request.getParameter("Mng_pwd");
        //String iMng_Passwd = Encrypt.encrypt(Mng_pwd);  //���ܹ���Ա����        	
        		
						paramsIn.add(new String[]{cust_code       });         
        		paramsIn.add(new String[]{user_type       });         
        		paramsIn.add(new String[]{bill_type       });                
        		paramsIn.add(new String[]{bill_time       });                
			                                                                           
			  //15-20                                                                    
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
	
	
				//��������ַ���
				k=0;
				while (token_grp.hasMoreElements()){
					fieldRowNo[k]=(String)token_grp.nextElement();
					//System.out.println("###########********fieldRowNo["+k+"]**********##########"+fieldRowNo[k]);
					k++;
				}
	
				i=0;
				p=0;
				//�������ֺ�ֵ�ַ���
				while (token.hasMoreElements()){
					fieldCodes[i]=(String)token.nextElement();
					
					if(!vec.contains(fieldCodes[i]))
					{
						if(!fieldRowNo[i].equals("0"))	//�кŴ�1��ʼ
						{
							String[] tempValues = (String[])request.getParameterValues("F"+request.getParameter("userType")+fieldCodes[i]);
						//System.out.println("F"+request.getParameter("userType")+fieldCodes[i]);
							for(p=0;p<tempValues.length;p++)
							{
								fieldValueAry.add(tempValues[p]);
							}
						}
						else
						{
							fieldValueAry.add(request.getParameter("F"+request.getParameter("userType")+fieldCodes[i]));
						}
						vec.add(fieldCodes[i]);
					}
					i++;
				}
				
				    fieldValues=(String[])fieldValueAry.toArray(new String[length]);

						String belong_code   = iBelong_Code;                               //�������� add
						String pay_flag      = request.getParameter("hid_pay_flag");       //���ѷ�ʽ add
						
						paramsIn.add(new String[]{feeList         });          
						if(length>0)                                                 
                        {                                                            
                            parm1 = fieldCodes;
                			parm2 = fieldValues;
                			parm3 = fieldRowNo;                
                        }                                    
						paramsIn.add(new String[]{belong_code     });                    
						paramsIn.add(new String[]{pay_flag        });                          
                                                                                            
           paramsIn.add(new String[]{mode_code       });	//���ײ�        
           paramsIn.add(new String[]{add_mode        });  
           paramsIn.add("");                    
                                                                              
           //����Ա�ʻ�������Ա����

           
			     paramsIn.add(new String[]{Mng_user       });	                
				   paramsIn.add(new String[]{Mng_pwd        });                  
									 
          //retStr = callView.callService("s6720Cfm", paramsIn, "1", "region", iRegion_Code);
%>
            <wtc:service name="s6720Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="s6720CfmCode" retmsg="s6720CfmMsg" outnum="1" >
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
                <wtc:params value="<%=ProdPrice%>"/>
                <wtc:params value="<%=ProdAttr%>"/>
                <wtc:param value="<%=iProduct_Type%>"/>
                
                <wtc:param value="<%=iService_Code%>"/>
                <wtc:param value="<%=iService_Attr%>"/>
                <wtc:param value="<%=iGrp_UserNo%>"/>
                <wtc:params value="<%=parm1%>"/>
                <wtc:params value="<%=parm2%>"/>
                
                <wtc:params value="<%=parm3%>"/>
                <wtc:param value="<%=channel_id%>"/>
                <wtc:param value="<%=cust_code%>"/>
                <wtc:param value="<%=user_type%>"/>
                <wtc:param value="<%=bill_type%>"/>
                
                <wtc:param value="<%=bill_time%>"/>
                <wtc:param value="<%=feeList%>"/>
                <wtc:params value="<%=parm1%>"/>
                <wtc:params value="<%=parm2%>"/>
                <wtc:params value="<%=parm3%>"/>
                    
                <wtc:param value="<%=belong_code%>"/>
                <wtc:param value="<%=pay_flag%>"/>
                <wtc:param value="<%=mode_code%>"/>
                <wtc:param value="<%=add_mode%>"/>
                <wtc:param value=""/>
                
                <wtc:param value="<%=Mng_user%>"/>
                <wtc:param value="<%=Mng_pwd%>"/>
            </wtc:service>
            <wtc:array id="s6720CfmArr" scope="end"/>
            <%
			      //callView.printRetValue();
            //error_code = callView.getErrCode();
            //error_msg= callView.getErrMsg();
            error_code = s6720CfmCode;
            error_msg = s6720CfmMsg;
            System.out.println("......error_code......."+error_code+"......error_msg...."+error_msg);

//-------modify by qidp-------
 System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
    String url = "/npage/contact/onceCnttInfo.jsp?opCode="+"6720"+"&retCodeForCntt="+error_code
    +"&retMsgForCntt="+error_msg+"&opName="+"���Ų��忪��"+"&workNo="+iWorkNo+"&loginAccept="+iLoginAccept
    +"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+iCust_Id+"&contactType=grp";
    System.out.println("url="+url);
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
//----------------------------


        //----------------------Ϊ��ӡ��Ʊ��֯����add
			  //double d_totalPay=0.00, d_cashPay=0.00, d_checkPay=0.00 ;
			  d_cashPay = Double.parseDouble(iCash_Pay);
			  d_handPay = Double.parseDouble(iHandFee);
			  d_totalPay = d_cashPay + d_handPay ;
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
			  //smName = ((String[][])retList.get(0))[0][0];
			  if(retArr4.length>0 && retCode4.equals("000000")){
                    smName = retArr4[0][0];
              }
              
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
			  //custName = ((String[][])retList.get(0))[0][0];
			  if(retArr5.length>0 && retCode5.equals("000000")){
                    custName = retArr5[0][0];
              }

    }catch(Exception e){
		e.printStackTrace();
		e.getMessage();
        logger.error("Call s6720Cfm is Failed!-----");
    }
		
    if(error_code.equals("000000"))
    {
		%>
		<script language="javascript">
		
		<%if(d_totalPay>0){
		
			 java.text.DecimalFormat df = new java.text.DecimalFormat(".00"); 
		 String strTotal = df.format(d_totalPay);
		
		%>
	  //��ӡ��Ʊ
      rdShowMessageDialog("�����ɹ�,���潫��ӡ��Ʊ,����ֽ��!");

	  //--------------------print begin-----------------------------//
	    var op_code = "<%=iOpCode%>";//op_code  ��������
		  var work_no = "<%=iWorkNo%>";//work_no ����
		  var maxAccept = "<%=iLoginAccept%>";//maxAccept ��ˮ
		  var phoneNo = "<%=iGrp_UserNo%>";//phoneNo �ֻ�����////��Ա�û����� ok
		  var smName = "<%=smName%>";//smName Ʒ������
		  var custName = "<%=custName%>";//custName �ͻ�����  ///// oksql select cust_name from dCustDoc where //cust_id = 8610277301;
		  var iHandFee = "<%=iHandFee%>";// ʵ��������
		  var iCash_Pay = "<%=iCash_Pay%>";// ������
		  var tmpMoney = Math.round(iHandFee)+Math.round(iCash_Pay);//tmpMoney ���Ѻϼ� =ʵ��������+������
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
	     infoStr+="<%=iGrp_Name%>"+"|";
	     infoStr+="<%=cust_Address%>"+"|";
		   infoStr+="�ֽ�"+"|";	
		   infoStr+="<%=strTotal%>"+"|";
	     infoStr+="�����ѣ�"+"<%=iHandFee%>"+"    ��ˮ�ţ�"+"<%=iLoginAccept%>"+"|";
	     infoStr+="<%=iWorkNo%>|";
    
	    var printPage="/npage/s6720/CR_print.jsp?retInfo="+infoStr;
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

	  this.location="f6720_1.jsp";
	 <%}else{%>
      rdShowMessageDialog("���Ų��忪���ɹ���",2);
	    this.location="f6720_1.jsp";
	 <%}%>	 
  </script>

<% 
   } else {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_code%>" + "[" + "<%=error_msg%>" + "]" ,0);
            history.go(-1);
        </script>
<%
    }
%>

<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-19
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%@ page import="java.util.StringTokenizer"%>

<%
	String region_code=((String)session.getAttribute("orgCode")).substring(0,2);
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");

    String opCode = (String)request.getParameter("iOpCode");
	String opName = (String)request.getParameter("op_name");
	System.out.println("!!!!@@###opNameopNameopNameopName====="+opName);
	
	//ȡ��ǰ����
	Date currentDate = new Date();
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
	String activeTime = formatter.format(currentDate);

    ArrayList retArray = null;
	ArrayList retList = new ArrayList();//���ؽ�� 
    String error_code = "";
    String error_msg = "";
	String maxAccept = "";
	String idNo = "";
    Logger logger = Logger.getLogger("f3505_2.jsp");
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    
    //ȡ����ʡ�ݴ��� -- Ϊ�������ӣ�ɽ������ʹ��session
    //String[][] result2  = null;
    String sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
	String ProvinceRun = "";
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" retcode="retCode1" retmsg="retMsg1"  outnum="1">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="result2" scope="end" />
	<%
	if (result2.length>0 && retCode1.equals("000000")) 
	{
		ProvinceRun = result2[0][0];
	}
	
   	
	String[] retStr = null;
    String iLoginAccept    = request.getParameter("login_accept");     //������ˮ��
    String iOpCode         = request.getParameter("op_code");          //��������
    String iWorkNo         = request.getParameter("WorkNo");           //����Ա����
    String iLogin_Pass     = request.getParameter("NoPass");           //����Ա����
    String iOrgCode        = request.getParameter("OrgCode");          //����Ա��������
    String iSys_Note       = request.getParameter("sysnote");          //ϵͳ������ע
    String iOp_Note        = request.getParameter("tonote");           //�û�������ע
    String iIpAddr         = request.getParameter("ip_Addr");          //����ԱIP��ַ
    String iGrp_Id         = request.getParameter("id_no");           //�����û�ID
	String cust_code       = request.getParameter("cust_code");		   //IDC�û�����
	String bill_type       = request.getParameter("billType");         //��������
	String bill_time       = request.getParameter("billTime");		   //��������
	
	//add by baixf 20070606
	String unit_id     =request.getParameter("unit_id");	
	
	//
	String user_type = ""; 
	String mode_code = "";
	String add_mode  = "";
	if(ProvinceRun.equals("16"))//ɽ��
	{
		user_type       = request.getParameter("product_attr");         //�û�����
		mode_code       = request.getParameter("product_code"); //���ײʹ���
    	
		if(!mode_code.equals("")){
    	mode_code = mode_code.substring(0, mode_code.indexOf("|"));
		}
		add_mode       = request.getParameter("product_append");         //����ģ���
	}
	else
	{
		user_type       = request.getParameter("userType");         //�û�����
	//	user_type = user_type.substring(0,user_type.indexOf("|"));
    
   // System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&user_type="+user_type);
		
		mode_code       = request.getParameter("modeCode"); //���ײʹ���
		//if(!mode_code.equals("")){
    	//mode_code = mode_code.substring(0, mode_code.indexOf("|"));
		//}
		add_mode       = request.getParameter("addProduct");         //����ģ���
	}

	String iPay_Type	   = request.getParameter("payType");     //���ʽ
	String iCash_Pay	   = request.getParameter("cashNum");     //֧�����
	String iCheck_No	   = request.getParameter("checkNo");     //֧Ʊ����
	String iBank_Code	   = request.getParameter("bank_code");     //���д���
	String iCashPay	   = request.getParameter("cashPay");     //�ֽ𽻿�
	String iCheck_Pay	   = request.getParameter("checkPay");     //֧Ʊ����
	String iShouldHandFee  = request.getParameter("should_handfee");   //Ӧ��������
    String iHandFee        = request.getParameter("real_handfee");     //ʵ��������
    /** add by liwd 20081127,group_id��Դ�ڲ�����Ա��ѡ�� */
    String belong_str     = request.getParameter("belong_code");
    System.out.println("belong_str==============="+belong_str);
    String belong[] = belong_str.split("\\|");
	//String belong_code        = request.getParameter("belong_code");     //�������� add
	String belong_code        = belong[0];     //�������� add
	String group_id        = belong[1];     //�������� add
	
	/* add by liwd 20081127 end */
	String smCode        = request.getParameter("sm_code");     //��ӡ���������û����
	String cust_id        = request.getParameter("cust_id");     //���ſͻ�ID
	String payType        = request.getParameter("payType");     //���ʽ
	String pay_flag      = request.getParameter("hid_pay_flag");     //���ѷ�ʽ add
	String totalPay      = request.getParameter("totalPay");
	String cust_address  =request.getParameter("cust_address");
  String cust_name  =request.getParameter("custname");
  
  
	if("0".equals(iPay_Type)){//�ֽ�
		iCheck_Pay="0.00";
	}else{//֧Ʊ
	    iCashPay="0.00";
	}
	double d_totalPay=0.00 ;
	d_totalPay = Double.parseDouble(iCashPay)+Double.parseDouble(iCheck_Pay);
	
	
	String feeList="";//������Ϣ
	//feeList=iPay_Type+"~"+iCheck_No+"~"+iBank_Code+"~"+iCheck_Pay+"~"+iCash_Pay+"~"+iShouldHandFee+"~"+iHandFee+"~";
	feeList=iPay_Type+"~"+iCheck_No+"~"+iBank_Code+"~"+iCheck_Pay+"~"+iCashPay+"~"+iShouldHandFee+"~"+iHandFee+"~";

	StringBuffer value_list=new StringBuffer();
    String iRegion_Code = iOrgCode.substring(0,2);
	String name_list=request.getParameter("nameList");
	String grp_list=request.getParameter("nameGroupList");
	String fieldValuestr = "";
    try
    {		
			StringTokenizer token=new StringTokenizer(name_list,"|");
			//StringTokenizer token_val=new StringTokenizer(value_list,"|");
			StringTokenizer token_grp=new StringTokenizer(grp_list,"|");
			StringTokenizer token1=new StringTokenizer(add_mode,"~");
			int length2=token.countTokens();
			int length1=token1.countTokens();

			String fieldCodes[] = new String [length2];
			String fieldValues[]= new String [length2];
			String fieldRowNo[]= new String [length2];
			
			String param0[] = new String[length1];
			String param1[] = new String[length2];
			String param2[] = new String[length2];
			String param3[] = new String[length2];
			
			ArrayList fieldValueAry = new ArrayList();
			Vector vec = new Vector();
			
			String addModeList[]= new String [length1];
			int i=0;	//���������
			int m=0;
			int j=0;    //�����ʷѸ���
			int k=0;	//��Ÿ��������������ͬ
			int p=0;	//ÿ�����е�һ����ļ�¼����
			//��������ַ���
			while (token_grp.hasMoreElements()){
				fieldRowNo[k]=(String)token_grp.nextElement();
				//System.out.println("###########********fieldRowNo["+k+"]**********##########"+fieldRowNo[k]);
				k++;
			}
			//�������ֺ�ֵ�ַ���
			while (token.hasMoreElements()){
				fieldCodes[i]=(String)token.nextElement();
				//System.out.println("###########********fieldCodes["+i+"]**********##########"+fieldCodes[i]);
				//System.out.println("###########********fieldRowNo["+i+"]**********##########"+fieldRowNo[i]);
				
				if(!vec.contains(fieldCodes[i]))
				{
					if(!fieldRowNo[i].equals("0"))	//�кŴ�1��ʼ
					{
						String[] tempValues = (String[])request.getParameterValues("F"+fieldCodes[i]);
						for(p=0;p<tempValues.length;p++)
						{
							fieldValueAry.add(tempValues[p]);
							//System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
						}
					}
					else
					{
						fieldValueAry.add(request.getParameter("F"+fieldCodes[i]));
						//System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
					}
					vec.add(fieldCodes[i]);
				}
				i++;
			}
			
			fieldValues=(String[])fieldValueAry.toArray(new String[length2]);
			
			/******************************************
			for(int n=0;n<fieldCodeAry.toArray().length;n++)
        	{
        	    fieldCodes[n]=(String)fieldCodeAry.toArray()[n];
        	    System.out.println("###########********fieldCodes["+n+"]**********##########"+fieldCodes[n]);
        	}
        	for(int n=0;n<fieldCodeAry.toArray().length;n++)
        	{
        	    fieldValues[n]=(String)fieldValueAry.toArray()[n];
        	    System.out.println("###########********fieldValues["+n+"]**********##########"+fieldValues[n]);
        	}
        	for(int n=0;n<fieldCodeAry.toArray().length;n++)
        	{
        	    fieldRowNo[n]=(String)fieldRowNoAry.toArray()[n];
        	    System.out.println("###########********fieldRowNo["+n+"]**********##########"+fieldRowNo[n]);
        	}
        	*****************************************/
        	
			//���������ʷ�����
			while (token1.hasMoreElements()){
				addModeList[j]=(String)token1.nextElement();//��������ȡ�ô������Ĳ���
				//System.out.println("###########********addModeList[j]**********##########"+addModeList[j]);
				j++;
			}

			System.out.println(value_list);
			ArrayList paramsIn = new ArrayList();

            paramsIn.add(new String[]{iLoginAccept    });//0
            paramsIn.add(new String[]{iOpCode         });
            paramsIn.add(new String[]{iWorkNo         });
            paramsIn.add(new String[]{iLogin_Pass     });
            paramsIn.add(new String[]{iOrgCode        });
            paramsIn.add(new String[]{iSys_Note       });//5
            paramsIn.add(new String[]{iOp_Note        });
            paramsIn.add(new String[]{iIpAddr         });
            paramsIn.add(new String[]{iGrp_Id         });
            paramsIn.add(new String[]{cust_code       });
            paramsIn.add(new String[]{user_type       });//10
            paramsIn.add(new String[]{bill_type       });
            paramsIn.add(new String[]{bill_time       });
            paramsIn.add(new String[]{mode_code       });
            if(length1>0)
            {
            	param0 = addModeList;
            }
            else
            {
            	param0 = new String[]{add_mode};
            }	
            paramsIn.add(new String[]{feeList         });
            
            if(length2>0)
            {
            param1 = fieldCodes;
            param2 = fieldValues;
            param3 = fieldRowNo;
            }
            
            
			paramsIn.add(new String[]{belong_code     });
			paramsIn.add(new String[]{pay_flag        });
			paramsIn.add(new String[]{group_id        });//add by liwd 20081127,group_id��Դ�ڲ�����Ա��ѡ��
			

			//�����������
            //String [] paramsIn = new String[] { iLoginAccept, iOpCode, iWorkNo, iLogin_Pass, iOrgCode, iSys_Note, iOp_Note, iIpAddr, iGrp_Id,cust_code,user_type,bill_type,bill_time,"ip28I000",add_mode,feeList,name_list,value_list.toString()};
			//retStr = callView.callService("s3505Cfm", paramsIn, "2", "region", iRegion_Code);
			
			%>
            <wtc:service name="s3505Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="s3505CfmCode" retmsg="s3505CfmMsg" outnum="2" >
                <wtc:param value="<%=iLoginAccept%>"/>
                <wtc:param value="<%=iOpCode%>"/> 
                <wtc:param value="<%=iWorkNo%>"/> 
                <wtc:param value="<%=iLogin_Pass%>"/> 
                <wtc:param value="<%=iOrgCode%>"/> 
                
                <wtc:param value="<%=iSys_Note%>"/> 
                <wtc:param value="<%=iOp_Note%>"/> 
                <wtc:param value="<%=iIpAddr%>"/> 
                <wtc:param value="<%=iGrp_Id%>"/> 
                <wtc:param value="<%=cust_code%>"/> 
                
                <wtc:param value="<%=user_type%>"/> 
                <wtc:param value="<%=bill_type%>"/> 
                <wtc:param value="<%=bill_time%>"/> 
                <wtc:param value="<%=mode_code%>"/> 
                <wtc:params value="<%=param0%>"/> 
                
                <wtc:param value="<%=feeList%>"/> 
                <wtc:params value="<%=param1%>"/> 
                <wtc:params value="<%=param2%>"/> 
                <wtc:params value="<%=param3%>"/> 
                <wtc:param value="<%=belong_code%>"/> 
                
                <wtc:param value="<%=pay_flag%>"/> 
                <wtc:param value="<%=group_id%>"/> 
            </wtc:service>
            <wtc:array id="s3505CfmArr" scope="end"/>
            <%
    
			//callView.printRetValue();
            error_code = s3505CfmCode;
            error_msg = s3505CfmMsg;
            if(error_code.equals("000000") && s3505CfmArr.length>0){
    			maxAccept=s3505CfmArr[0][0];
    			idNo=s3505CfmArr[0][1];
			}

//----------------------------
    System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
    String url = "/npage/contact/onceCnttInfo.jsp?opCode="+iOpCode+"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg+"&opName="+opName+"&workNo="+iWorkNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
    System.out.println("%%%%%%%%url%%%%%%%%");
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
//----------------------------



    }catch(Exception e){
		e.printStackTrace();
        logger.error("Call s3505Cfm is Failed!");
    }

     if(error_code.equals("000000"))
    { 
%>
<script language="javascript">

	//rdShowMessageDialog("�����ɹ���")
  
<%if(d_totalPay>0){
	 //String[][] result3  = null;
	 String cust_code_prt = "";
	sqlStr = "select contract_no from dcustmsg where phone_no =:cust_code";
	//result3 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
	
	String [] paraIn = new String[2];
	paraIn[0] = sqlStr;    
    paraIn[1]="cust_code="+cust_code;
    %>
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="retCode2" retmsg="retMsg2" outnum="1" >
    	<wtc:param value="<%=paraIn[0]%>"/>
    	<wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
    <wtc:array id="retArr2" scope="end"/>
    <%
    if(retCode2.equals("000000") && retArr2.length>0){
		cust_code_prt = retArr2[0][0];
	}
	 
	 
	 java.text.DecimalFormat df = new java.text.DecimalFormat(".00"); 
 	 String strTotal = df.format(Double.parseDouble(totalPay));

%>
	//��ӡ��Ʊ
	//rdShowMessageDialog("�����ɹ�,���潫��ӡ��Ʊ,����ֽ��!");

	var prtFlag=0;
	var confirmFlag=0;
	var ProFlag= "<%=ProvinceRun%>"; //�ж�ʡ��
	var iCash_Pay="<%=iCash_Pay%>";
	
	prtFlag = rdShowConfirmDialog("�Ƿ��ӡ��Ʊ��");
	//�ύ��ӡ����

	if (prtFlag==1) {
	  if(ProFlag=="20")//����
	  {
	    var infoStr="";
	     infoStr+=" "+"|";
       infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+="<%=iGrp_Id%>"+"|";
	     infoStr+="<%=cust_code_prt%>"+"|";
	     infoStr+="<%=cust_name%>"+"|";
	     infoStr+="<%=cust_address%> "+"|";
		   infoStr+="�ֽ�"+"|";	
		   infoStr+="<%=strTotal%>"+"|";
	     infoStr+="*�����ѣ�"+"<%=iHandFee%>"+"*��ˮ�ţ�"+"<%=iLoginAccept%>"+"|";
       infoStr+="<%=iWorkNo%>|";
     
	    var printPage="/npage/s3500/idc_print.jsp?retInfo="+infoStr;
	    var printPage = window.open(printPage);

	  }
	  else
	  {
		  var proc_name = "prc_3505_invoice";
		  var send = "<%=idNo%>"+","+"<%=maxAccept%>"+",'<%=activeTime.substring(0,4)%>','<%=activeTime.substring(4,6)%>'";
		  var printPage="/npage/common/smPrint.jsp?procedure_name="+proc_name+"&parameters="+send;
		  var printPage = window.open(printPage,"","width=200,height=200");
	  }
	}

	this.location="f3505_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	 <%}else{%>
      rdShowMessageDialog("���Ų�Ʒ��Ա���������ɹ���",2);
	  this.location="f3505_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	  //history.go(-1);
	 <%}%>	 
  </script>

<%  } else {
%>
        <script language='jscript'>
            
            var path="<%=request.getContextPath()%>/npage/s3500/f3505_2_printxls.jsp?phoneNo=" + "<%=cust_code%>";
            
	   		if (rdShowConfirmDialog("<br>�������:"+"<%=error_code%></br>"+"������Ϣ:"+"<%=error_msg%>"+"<br>�Ƿ񱣴������Ϣ��",0)==1)	
			{
				path = path + "&returnMsg=" + "<%=error_msg%>"+ "&unitID=" + "<%=unit_id%>";
	  			path = path + "&op_Code=" + "<%=iOpCode%>";
	  			path = path + "&orgCode=" + "<%=iOrgCode%>";
          			window.open(path);
			}	
            
            history.go(-1);
        </script>
<%
    }
%>

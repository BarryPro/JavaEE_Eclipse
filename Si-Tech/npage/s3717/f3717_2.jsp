   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-12
********************/
%>
              
<%
  String opCode = "3718";
  String opName = "BlackBerry��Ա���";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%@ page import="java.util.StringTokenizer"%>
<%
   	
		String region_code= (String)session.getAttribute("regCode");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");

	//ȡ��ǰ����
	Date currentDate = new Date();
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
	String activeTime = formatter.format(currentDate);
    String url="";
    String error_code = "";
    String error_msg = "";
	String maxAccept = "";
	String idNo = "";
    Logger logger = Logger.getLogger("f3717_2.jsp");
    
    //ȡ����ʡ�ݴ��� -- Ϊ�������ӣ�ɽ������ʹ��session
    String sqlStr="";
	String[][] result2  = null;
	String[][] result22  = null;
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=region_code%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%	
	String ProvinceRun = "";
	if (result_t1 != null && result_t1.length != 0) 
	{
		ProvinceRun = result_t1[0][0];
	}
   	
  System.out.println("-----------------------ProvinceRun------------------"+ProvinceRun); 		
	String[] retStr = null;
    String iLoginAccept    = request.getParameter("login_accept");     //������ˮ��
    /*String iOpCode         = request.getParameter("op_code");          //��������
    */
    String iOpCode         = "3718";        //��������
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
	
	System.out.println("luxc:op_code:iOpCode="+iOpCode);
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
	String belong_code        = request.getParameter("belong_code");     //�������� add
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
			

        	
			//���������ʷ�����
			while (token1.hasMoreElements()){
				addModeList[j]=(String)token1.nextElement();//��������ȡ�ô������Ĳ���
				//System.out.println("###########********addModeList[j]**********##########"+addModeList[j]);
				j++;
			}


            String fieldCodes_t[] = new String[]{};
            String fieldValues_t[] = new String[]{};
            String fieldRowNo_t[] = new String[]{};
         	  String addModeList_t[] = new String[]{}; 
            
            
            if(length1>0)
            {
            	  addModeList_t = addModeList  ;
            }
            else
            {
            	  addModeList_t = new String[]{add_mode    } ;
            }	
            
            if(length2>0)
            {
              fieldCodes_t = fieldCodes;
              fieldValues_t = fieldValues ;
              fieldRowNo_t = fieldRowNo   ;
            }
            else
            {
              fieldCodes_t = new String[]{""    } ;
              fieldValues_t = new String[]{""    } ;
              fieldRowNo_t = new String[]{""    } ;
            }
            
         String paramsIn[]=new String[17];
            
            paramsIn[0]=iLoginAccept    ;//0
            paramsIn[1]=iOpCode         ;
            paramsIn[2]=iWorkNo         ;
            paramsIn[3]=iLogin_Pass     ;
            paramsIn[4]=iOrgCode        ;
            paramsIn[5]=iSys_Note       ;//5
            paramsIn[6]=iOp_Note        ;
            paramsIn[7]=iIpAddr         ;
            paramsIn[8]=iGrp_Id         ;
            paramsIn[9]=cust_code       ;
            paramsIn[10]=user_type       ;//10
            paramsIn[11]=bill_type       ;
            paramsIn[12]=bill_time       ;
            paramsIn[13]=mode_code       ;
            paramsIn[14]=feeList         ;
						paramsIn[15]=belong_code     ;
						paramsIn[16]=pay_flag        ;

						
			//�����������
            //String [] paramsIn = new String[] { iLoginAccept, iOpCode, iWorkNo, iLogin_Pass, iOrgCode, iSys_Note, iOp_Note, iIpAddr, iGrp_Id,cust_code,user_type,bill_type,bill_time,"ip28I000",add_mode,feeList,name_list,value_list.toString()};
			//retStr = callView.callService("s3717add", paramsIn, "2", "region", iRegion_Code);
%>

    <wtc:service name="s3717add" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=region_code%>">
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
			<wtc:param value="<%=paramsIn[13]%>" />
			<wtc:params value="<%=addModeList_t%>" />	
			<wtc:param value="<%=paramsIn[14]%>" />						
			<wtc:params value="<%=fieldCodes_t%>" />	
			<wtc:params value="<%=fieldValues_t%>" />	
			<wtc:params value="<%=fieldRowNo_t%>" />	
			<wtc:param value="<%=paramsIn[15]%>" />	
			<wtc:param value="<%=paramsIn[16]%>" />						
		</wtc:service>
		<wtc:array id="result_t2" scope="end" />

<%			
            url = "/npage/contact/onceCnttInfo.jsp?opCode="+iOpCode+"&retCodeForCntt="+code2+"&retMsgForCntt="+msg2+"&opName=BlackBerry��Ա���&workNo="+iWorkNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
            error_code = code2;
            error_msg= msg2;
result22 = result_t2;
    }catch(Exception e){
		e.printStackTrace();
        logger.error("Call s3717add is Failed!!!");
    }
    
    
	if(error_code.equals("000000"))
    { 
    	 maxAccept = result22[0][0];
			 idNo = result22[0][1];
%>
<script language="javascript">

	//rdShowMessageDialog("�����ɹ���")
  
<%if(d_totalPay>0){
	 String[][] result3  = null;
	sqlStr = "select contract_no from dcustmsg where phone_no ='"+cust_code+"'";
	//result3 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
	
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=region_code%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>

<%	
	String cust_code_prt = "";
	result3 = result_t3;
	if (result3 != null && result3.length != 0) 
	{
		cust_code_prt = result3[0][0];
	}
	 System.out.println("-----------------------cust_code_prt------------------"+cust_code_prt); 	
	 
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

	this.location="f3717_1.jsp?opCode=<%=iOpCode%>&opName=BlackBerry��Ա���";
	 <%}else{%>
      rdShowMessageDialog("���Ų�Ʒ��Ա���������ɹ���",2);
	  this.location="f3717_1.jsp?opCode=<%=iOpCode%>&opName=BlackBerry��Ա���";
	  //history.go(-1);
	 <%}%>	 
  </script>

<%  } else {
%>
        <script language='jscript'>
            
            var path="<%=request.getContextPath()%>/npage/s3717/f3717_2_printxls.jsp?phoneNo=" + "<%=cust_code%>";
            
	   		if (rdShowConfirmDialog("<br>�������:"+"<%=error_code%></br>"+"������Ϣ:"+"<%=error_msg%>"+"<br>�Ƿ񱣴������Ϣ��")==1)	
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
  <jsp:include page="<%=url%>" flush="true" />
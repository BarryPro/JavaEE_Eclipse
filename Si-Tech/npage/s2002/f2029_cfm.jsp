<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<%
String loginNo = request.getParameter("loginNo");
String expireTime = request.getParameter("expireTime");
%>
<%
ArrayList arr = (ArrayList)session.getAttribute("allArr");
String[][] baseInfo = (String[][])arr.get(0);
String org_code = baseInfo[0][16];
String regionCode = org_code.substring(0,2);
String workNo = (String)session.getAttribute("workNo");
String loginPwd  = (String)session.getAttribute("password");
String ipAddr = java.net.InetAddress.getLocalHost().getHostAddress().toString();	//request.getRemoteAddr();
System.out.println("====wanghfa==== f2029_cfm.jsp ipAddr = " + ipAddr);
String in_ChanceId = WtcUtil.repNull((String)request.getParameter("in_ChanceId"));
String WaNo = WtcUtil.repNull((String)request.getParameter("WaNo"));
String batchNo = WtcUtil.repNull((String)request.getParameter("batchNo"));
String opCode = WtcUtil.repNull((String)request.getParameter("op_code"));
String opName = WtcUtil.repNull((String)request.getParameter("op_name"));
String p_operType = WtcUtil.repNull((String)request.getParameter("p_operType"));

%>

<script language="JavaScript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<%
    int addNum0 = Integer.parseInt(request.getParameter("hiddendate_PospecratePolicy_num"));
    int addNum1 = Integer.parseInt(request.getParameter("hiddendate_RatePlans_num"));
    int addNum2 = Integer.parseInt(request.getParameter("hiddendate_POICBs_num"));
    int addNum3 = Integer.parseInt(request.getParameter("hiddendate_ProductOrder_num"));
    System.out.println("��Ʒ��������="+addNum3);
    int addNum4 = Integer.parseInt(request.getParameter("hiddendate_ProductOrderRatePlan_num"));
    System.out.println("��Ʒ�ʷѼƻ�����="+addNum4);
    int addNum5 = Integer.parseInt(request.getParameter("hiddendate_ProductOrderPOICB_num"));
    System.out.println("��Ʒ�ʷѼƻ�ICB����="+addNum5);
    
    int addNum6 = Integer.parseInt(request.getParameter("hiddendate_PayCompany_num"));
    int addNum7 = Integer.parseInt(request.getParameter("hiddendate_ProductOrderChara_num"));
    
    int addNum8 = Integer.parseInt(request.getParameter("hiddendate_ProductCodePOICB_num"));
    
    int addNum9 = Integer.parseInt(request.getParameter("hiddendate_ProductOrderManagerChar_num"));//����ڵ����Ը���
    
    int addNum10 = Integer.parseInt(request.getParameter("hiddendate_ProductOrderExamine_num"));//��������
    
    System.out.println("====wanghfa====addNum7="+addNum7+",addNum8="+addNum8);
    System.out.println("addNum9="+addNum9+",addNum10="+addNum10);

   
    int delNum0 = Integer.parseInt(request.getParameter("hiddendate_PospecratePolicy_num_delete"));
    int delNum1 = Integer.parseInt(request.getParameter("hiddendate_RatePlans_num_delete"));
    int delNum2 = Integer.parseInt(request.getParameter("hiddendate_POICBs_num_delete"));
    int delNum3 = Integer.parseInt(request.getParameter("hiddendate_ProductOrder_num_delete"));
    int delNum4 = Integer.parseInt(request.getParameter("hiddendate_ProductOrderRatePlan_num_delete"));
    int delNum5 = Integer.parseInt(request.getParameter("hiddendate_ProductOrderPOICB_num_delete"));
    int delNum6 = Integer.parseInt(request.getParameter("hiddendate_PayCompany_num_delete"));
    int delNum7 = Integer.parseInt(request.getParameter("hiddendate_ProductOrderChara_num_delete"));
    System.out.println("====wanghfa==== " + delNum0 + ", " + delNum1 + ", " + delNum2 + ", " + delNum3
    	 + ", " + delNum4 + ", " + delNum5 + ", " + delNum6 + ", " + delNum7);
    List inparamList = new ArrayList();
    String[] POOrder = new String[25];
    //��Ʒ��Ϣ
    POOrder[0] = "a";//��Ϣ����
    POOrder[1] = request.getParameter("p_OrderSourceID"  );//������Դ
    POOrder[2] = request.getParameter("product_code");//���ſͻ�����ʡ����(δ�·�)
    POOrder[3] = request.getParameter("p_CustomerNumber"  );//EC���ſͻ�����
    POOrder[4] = request.getParameter("p_POOrderNumber"  );//��Ʒ������
    POOrder[5] = request.getParameter("p_POSpecNumber"  );//��Ʒ�����
    POOrder[6] = request.getParameter("p_ProductOfferingID"  );//��Ʒ������ϵ
    POOrder[7] = request.getParameter("p_SICode"  );//SI����
    POOrder[8] = request.getParameter("p_HostCompany"  );//����ʡ
    POOrder[9] = request.getParameter("p_PORatePolicyEffRule"  );//�ײ���Ч����
    //POOrder[10]= request.getParameter("p_operationSubTypeID"  );//��Ʒ��ҵ�����
    POOrder[10]= request.getParameter("p_operationSubType"  );//��Ʒ��ҵ�����
    POOrder[11]= request.getParameter("p_BusinessMode"  );//ҵ��չģʽ
    POOrder[12]= "0";//"1";//��������
    POOrder[13]= workNo;//"";����
    POOrder[14]= org_code;
    POOrder[15]= loginPwd;//����Ա����   
    POOrder[16]="";	//request.getParameter("POAttachment");//��Ʒ�������� wangzn 2010-3-22 16:14:32
    POOrder[17]=ipAddr;
    POOrder[18]=in_ChanceId;//�̻���� wangzn 2010-5-12 14:39:53
    POOrder[19]=WaNo;//������
    POOrder[20]=batchNo;//���κ�
    POOrder[21]= request.getParameter("fee_list");//wuxy add 20110523 ��Ʒ��һ���Է��ô�
    POOrder[22]= request.getParameter("busNeedDegree") == null ? "" : request.getParameter("busNeedDegree");
    POOrder[23]= request.getParameter("notes") == null ? "" : request.getParameter("notes");
    POOrder[24]= request.getParameter("busi_req_type") == null ? "" : request.getParameter("busi_req_type");
    //����ֵΪundefined���ֶ�
    POOrder[1]  = POOrder[1].equals("undefined")?"":POOrder[1];
    POOrder[2]  = POOrder[2].equals("undefined")?"":POOrder[2];
    POOrder[3]  = POOrder[3].equals("undefined")?"":POOrder[3];
    POOrder[4]  = POOrder[4].equals("undefined")?"":POOrder[4];
    POOrder[5]  = POOrder[5].equals("undefined")?"":POOrder[5];
    POOrder[6]  = POOrder[6].equals("undefined")?"":POOrder[6];
    POOrder[7]  = POOrder[7].equals("undefined")?"":POOrder[7];
    POOrder[8]  = POOrder[8].equals("undefined")?"":POOrder[8];
    if("------������------".equals( POOrder[8].trim()))
               POOrder[8]="";
    POOrder[9]  = POOrder[9].equals("undefined")?"":POOrder[9];
    System.out.println("@:******DUBUG9******");
    if("------������------".equals( POOrder[9].trim()))    
               POOrder[9]="";
    POOrder[10] = POOrder[10].equals("undefined")?"":POOrder[10];
    System.out.println("@:******DUBUG10******");
    POOrder[11] = POOrder[11].equals("undefined")?"":POOrder[11];
    System.out.println("@:******DUBUG11******");
    if("------������------".equals( POOrder[11].trim()))    
               POOrder[11]="";
    /*add by rendi for ���ӶԲ�Ʒ���������жϣ�ֻ����Ʒ�������в�Ʒ��ȡ������Ʒ�������ſ�����
    ȡ����������Ʒ����������5-���*/
    System.out.println(POOrder[10].equals("2|"));
    
    POOrder[21] = POOrder[21].equals("undefined")?"":POOrder[21];
    
    /*
    if(POOrder[10].equals("2|"))
    {
    	String Com_flag="";
	    for(int i=0;i<addNum3;i++){
	        String Product_flag = request.getParameter("a_OperationSubTypeID_PrdOrd"+i);//��Ʒ��ҵ�����
	    	Product_flag=Product_flag.equals("undefined")?"":Product_flag;
	    	System.out.println(Product_flag);
	    	
	    	if(i==0)
	    	{
	    		Com_flag=Product_flag;//��һ�ν���ʱ���м������ֵΪ��������
	    		if(Product_flag.equals("A|"))
	    			POOrder[10]="A|";//����Ʒ��������ΪԤ������ֻ��һ��ΪԤ��ʱ������Ʒ������
	    							//Ҳ��ֵΪԤ���������Ϊȡ������
	    	}
	    	System.out.println("+Com_flag+="+Com_flag);
	    	if(!Com_flag.equals(Product_flag))
	    		POOrder[10]="5|";
	    	System.out.println("product_flag="+Product_flag+";Com_flag="+Com_flag+";POOrder[10]="+POOrder[10]);
	    	Com_flag = Product_flag;
	    }
    }
    */  
    inparamList.add(POOrder);	//0
    
    
    //--------------------------�������----------------------------
    System.out.println("��Ʒ������Ϣ====wanghfa==== "+POOrder[0]+","+POOrder[1]+","+POOrder[2]+","+POOrder[3]+","+POOrder[4]+","+POOrder[5]+","+POOrder[6]+","+POOrder[7]+","+POOrder[8]+","+POOrder[9]+","+POOrder[10]+","+POOrder[11]+","+POOrder[12]+","+POOrder[13]+","+POOrder[14]+","+POOrder[15]+","+POOrder[16]+","+POOrder[17]+","+POOrder[18]+","+POOrder[19]+","+POOrder[20]+","+POOrder[21]+","+POOrder[22]+","+POOrder[23]+","+POOrder[24]);
    /*System.out.println("POOrder[1]="+POOrder[1]);
    System.out.println("POOrder[2]="+POOrder[2]);
    System.out.println("POOrder[3]="+POOrder[3]);
    System.out.println("POOrder[4]="+POOrder[4]);
    System.out.println("POOrder[5]="+POOrder[5]);
    System.out.println("POOrder[6]="+POOrder[6]);
    System.out.println("POOrder[7]="+POOrder[7]);
    System.out.println("POOrder[8]="+POOrder[8]);
    System.out.println("POOrder[9]="+POOrder[9]);
    System.out.println("POOrder[10]="+POOrder[10]);
    System.out.println("POOrder[11]="+POOrder[11]);
    System.out.println("POOrder[12]="+POOrder[12]);
    System.out.println("POOrder[13]="+POOrder[13]);
    System.out.println("POOrder[14]="+POOrder[14]);
    System.out.println("POOrder[15]="+POOrder[15]);
    System.out.println("POOrder[16]="+POOrder[16]);
    System.out.println("POOrder[17]="+POOrder[17]);
    System.out.println("POOrder[18]="+POOrder[18]);
    System.out.println("POOrder[19]="+POOrder[19]);
    System.out.println("POOrder[20]="+POOrder[20]);
    System.out.println("POOrder[21]="+POOrder[21]);
    System.out.println("POOrder[22]="+POOrder[22]);
    System.out.println("POOrder[23]="+POOrder[23]);
    System.out.println("POOrder[24]="+POOrder[24]);*/
   //--------------------------�������end----------------------------
    
    
    
    
    //��Ʒ�ʷ�ɾ��
    for(int i=0;i<delNum0;i++){
        String[] POSepc = new String[15];
    	POSepc[0]  =  "1";//��Ϣ����
        POSepc[1]  =  request.getParameter("p_POOrderNumber");//��Ʒ������
        POSepc[2]  =  request.getParameter("p_POSpecNumber");//��Ʒ�����
        POSepc[3]  =  request.getParameter("d_POSpecRatePolicyID_POS"+i);//�ײ�ID
        POSepc[4]  =  request.getParameter("d_Name_POS"+i);//�ײ�����
        POSepc[5]  =  "0";//�ײͲ������� 0ɾ��
        POSepc[6]  =  "0";
        POSepc[7]  =  "";
        POSepc[8]  =  request.getParameter("d_AcceptID_POS"+i);
        POSepc[9]  =  "";
        POSepc[10] =  "";
        POSepc[11] =  "";
        POSepc[12] =  "";
        POSepc[13] =  "";
        POSepc[14] =  "";
        //����ֵΪundefined���ֶ�
        POSepc[1] = POSepc[1].equals("undefined")?"":POSepc[1];
        POSepc[2] = POSepc[2].equals("undefined")?"":POSepc[2];
        POSepc[3] = POSepc[3].equals("undefined")?"":POSepc[3];
        POSepc[4] = POSepc[4].equals("undefined")?"":POSepc[4];
        POSepc[5] = POSepc[5].equals("undefined")?"":POSepc[5];
        inparamList.add(POSepc);
    }
    //��Ʒ�ʷ����
    System.out.println("��Ʒ�ʷ����====wanghfa==== "+addNum0);
    for(int i=0;i<addNum0;i++){
        String[] POSepc = new String[15];
        POSepc[0]  = "1";//��Ϣ����
        POSepc[1]  = request.getParameter("p_POOrderNumber");//��Ʒ������
        POSepc[2]  = request.getParameter("p_POSpecNumber");;//��Ʒ�����
        POSepc[3]  = request.getParameter("a_POSpecRatePolicyID_POS"+i);//�ײ�ID
        POSepc[4]  = request.getParameter("a_Name_POS"+i);//�ײ�����
        POSepc[5]  = "1";//�ײͲ������� 1����
        POSepc[6]  = "0";
        POSepc[7]  = "";
        POSepc[8]  = request.getParameter("a_AcceptID_POS"+i);
        POSepc[9]  = "";
        POSepc[10] = "";
        POSepc[11] = "";
        POSepc[12] = "";
        POSepc[13] = "";
        POSepc[14] = "";
        //����ֵΪundefined���ֶ�
        POSepc[1] = POSepc[1].equals("undefined")?"":POSepc[1];
        POSepc[2] = POSepc[2].equals("undefined")?"":POSepc[2];
        POSepc[3] = POSepc[3].equals("undefined")?"":POSepc[3];
        POSepc[4] = POSepc[4].equals("undefined")?"":POSepc[4];
        POSepc[5] = POSepc[5].equals("undefined")?"":POSepc[5];
        System.out.print("====wanghfa====");
        for(int kk=0;kk<POSepc.length;kk++){
            System.out.print(POSepc[kk] + ",");
        }
        System.out.println("");
        
        inparamList.add(POSepc);
    }

    //��Ʒ�ʷѼƻ�ɾ��
    for(int i=0;i<delNum1;i++){
        String[] PORatePlan = new String[15];
        PORatePlan[0]  = "2";//��Ϣ����
        PORatePlan[1]  = request.getParameter("p_POOrderNumber");//��Ʒ������
        PORatePlan[2]  = request.getParameter("p_POSpecNumber");//��Ʒ�����
        PORatePlan[3]  = request.getParameter("d_POSpecRatePolicyID_POSRP"+i);//�ײ�ID
        PORatePlan[4]  = request.getParameter("d_RatePlanID_POSRP"+i);//��Ʒ���ʷѼƻ���ʶ
        PORatePlan[5]  = request.getParameter("d_Description_POSRP"+i);//�ʷ�����
        PORatePlan[6]  = "0";//�ƻ���ʶ��������
        PORatePlan[7]  = "0";
        PORatePlan[8]  = request.getParameter("d_ParAcceptID_POSRP"+i);
        PORatePlan[9]  = request.getParameter("d_AcceptID_POSRP"+i);
        PORatePlan[10] = "";
        PORatePlan[11] = "";
        PORatePlan[12] = "";
        PORatePlan[13] = "";
        PORatePlan[14] = "";
        PORatePlan[1]=PORatePlan[1].equals("undefined")?"":PORatePlan[1];
        PORatePlan[2]=PORatePlan[2].equals("undefined")?"":PORatePlan[2];
        PORatePlan[3]=PORatePlan[3].equals("undefined")?"":PORatePlan[3];
        PORatePlan[4]=PORatePlan[4].equals("undefined")?"":PORatePlan[4];
        PORatePlan[5]=PORatePlan[5].equals("undefined")?"":PORatePlan[5];
        PORatePlan[6]=PORatePlan[6].equals("undefined")?"":PORatePlan[6];
        inparamList.add(PORatePlan);
    }
    //��Ʒ�ʷѼƻ�����
    for(int i=0;i<addNum1;i++){
        String[] PORatePlan = new String[15];
        PORatePlan[0]  = "2";//��Ϣ����
        PORatePlan[1]  = request.getParameter("p_POOrderNumber");//��Ʒ������
        PORatePlan[2]  = request.getParameter("p_POSpecNumber");//��Ʒ�����
        PORatePlan[3]  = request.getParameter("a_POSpecRatePolicyID_POSRP"+i);//�ײ�ID
        PORatePlan[4]  = request.getParameter("a_RatePlanID_POSRP"+i);//��Ʒ���ʷѼƻ���ʶ
        PORatePlan[5]  = request.getParameter("a_Description_POSRP"+i);//�ʷ�����
        PORatePlan[6]  = "1";//�ƻ���ʶ��������
        PORatePlan[7]  = "0";
        PORatePlan[8]  = request.getParameter("a_ParAcceptID_POSRP"+i);
        PORatePlan[9]  = request.getParameter("a_AcceptID_POSRP"+i);
        PORatePlan[10] = "";
        PORatePlan[11] = "";
        PORatePlan[12] = "";
        PORatePlan[13] = "";
        PORatePlan[14] = "";
        PORatePlan[1]=PORatePlan[1].equals("undefined")?"":PORatePlan[1];
        PORatePlan[2]=PORatePlan[2].equals("undefined")?"":PORatePlan[2];
        PORatePlan[3]=PORatePlan[3].equals("undefined")?"":PORatePlan[3];
        PORatePlan[4]=PORatePlan[4].equals("undefined")?"":PORatePlan[4];
        PORatePlan[5]=PORatePlan[5].equals("undefined")?"":PORatePlan[5];
        PORatePlan[6]=PORatePlan[6].equals("undefined")?"":PORatePlan[6];
        inparamList.add(PORatePlan);
    }
    //��Ʒ�ʷѼƻ�ICB����ֵɾ��
    for(int i=0;i<delNum2;i++){
    		String[] POICB = new String[15];//????�Ƿ�ȱ���ײ�ID����
        POICB[0]  = "3";//��Ʒ�ʷѼƻ�ICB����ֵ
        POICB[1]  = request.getParameter("p_POOrderNumber");//��Ʒ������
        POICB[2]  = request.getParameter("p_POSpecNumber");//��Ʒ�����
        POICB[3]  = request.getParameter("p_RatePlanID"+i);//��Ʒ���ʷѼƻ���ʶ
        POICB[4]  = request.getParameter("d_ParameterNumber_POICB"+i);//��������
        POICB[5]  = request.getParameter("d_ParameterName_POICB"+i);//������
        POICB[6]  = request.getParameter("d_ParameterValue_POICB"+i);//����ֵ
        POICB[7]  = "0";
        POICB[8]  = request.getParameter("d_ParAcceptID_POICB"+i);
        POICB[9]  = request.getParameter("d_AcceptID_POICB"+i);
        POICB[10] = "";
        POICB[11] = "";
        POICB[12] = "";
        POICB[13] = "";
        POICB[14] = "";
        POICB[1] = POICB[1].equals("undefined")?"": POICB[1];
        POICB[2] = POICB[2].equals("undefined")?"": POICB[2];
        POICB[3] = POICB[3].equals("undefined")?"": POICB[3];
        POICB[4] = POICB[4].equals("undefined")?"": POICB[4];
        POICB[5] = POICB[5].equals("undefined")?"": POICB[5];
        POICB[6] = POICB[6].equals("undefined")?"": POICB[6];
        inparamList.add(POICB);
    }

    //��Ʒ�ʷѼƻ�ICB����ֵ����
    for(int i=0;i<addNum2;i++){
        String[] POICB = new String[15];
        POICB[0]  = "3";//��Ʒ�ʷѼƻ�ICB����ֵ
        POICB[1]  = request.getParameter("p_POOrderNumber");//��Ʒ������
        POICB[2]  = request.getParameter("p_POSpecNumber");//��Ʒ�����
        POICB[3]  = request.getParameter("a_RatePlanID_POICB"+i);//��Ʒ���ʷѼƻ���ʶ
        POICB[4]  = request.getParameter("a_ParameterNumber_POICB"+i);//��������
        POICB[5]  = request.getParameter("a_ParameterName_POICB"+i);//������
        POICB[6]  = request.getParameter("a_ParameterValue_POICB"+i);//����ֵ
        POICB[7]  = "1";
        POICB[8]  = request.getParameter("a_ParAcceptID_POICB"+i);
        POICB[9]  = request.getParameter("a_AcceptID_POICB"+i);
        POICB[10] = "";
        POICB[11] = "";
        POICB[12] = "";
        POICB[13] = "";
        POICB[14] = "";
        POICB[1] = POICB[1].equals("undefined")?"":POICB[1];
        POICB[2] = POICB[2].equals("undefined")?"":POICB[2];
        POICB[3] = POICB[3].equals("undefined")?"":POICB[3];
        POICB[4] = POICB[4].equals("undefined")?"":POICB[4];
        POICB[5] = POICB[5].equals("undefined")?"":POICB[5];
        POICB[6] = POICB[6].equals("undefined")?"":POICB[6];
        inparamList.add(POICB);
    }
    
    //��Ʒ����ɾ��
    for(int i=0;i<delNum3;i++){
        String[] ProductOrder = new String[15];
        ProductOrder[0]  = "0";//��Ʒ������Ϣ
        ProductOrder[1]  = request.getParameter("d_ProductOrderNumber_PrdOrd"+i);//��Ʒ������
        ProductOrder[2]  = request.getParameter("d_ProductID_PrdOrd"+i);//��Ʒ������ϵID
        ProductOrder[3]  = request.getParameter("d_ProductSpecNumber_PrdOrd"+i);//��Ʒ�����
        ProductOrder[4]  = request.getParameter("d_AccessNumber_PrdOrd"+i);//��Ʒ�ؼ�����
        ProductOrder[5]  = request.getParameter("d_PriAccessNumber_PrdOrd"+i);//��Ʒ��������
        ProductOrder[6]  = request.getParameter("d_Linkman_PrdOrd"+i);//��ϵ��
        ProductOrder[7]  = request.getParameter("d_ContactPhone_PrdOrd"+i);//��ϵ�绰
        ProductOrder[8]  = request.getParameter("d_Description_PrdOrd"+i);//��Ʒ����
        ProductOrder[9]  = request.getParameter("d_ServiceLevelID_PrdOrd"+i);//����ͨ�ȼ�ID
        ProductOrder[10] = request.getParameter("a_OperationSubTypeID_PrdOrd"+i);//��Ʒ��ҵ�����
        ProductOrder[11] = "0";
        ProductOrder[12] = "";
        ProductOrder[13] = request.getParameter("d_AcceptID_PrdOrd"+i);
        ProductOrder[14] = request.getParameter("p_POOrderNumber");//add ��Ʒ��������
        ProductOrder[1] =  ProductOrder[1].equals("undefined")?"":ProductOrder[1];
        ProductOrder[2] =  ProductOrder[2].equals("undefined")?"":ProductOrder[2];
        ProductOrder[3] =  ProductOrder[3].equals("undefined")?"":ProductOrder[3];
        ProductOrder[4] =  ProductOrder[4].equals("undefined")?"":ProductOrder[4];
        ProductOrder[5] =  ProductOrder[5].equals("undefined")?"":ProductOrder[5];
        ProductOrder[6] =  ProductOrder[6].equals("undefined")?"":ProductOrder[6];
        ProductOrder[7] =  ProductOrder[7].equals("undefined")?"":ProductOrder[7];
        ProductOrder[8] =  ProductOrder[8].equals("undefined")?"":ProductOrder[8];
        ProductOrder[9] =  ProductOrder[9].equals("undefined")?"":ProductOrder[9];
        ProductOrder[10] = ProductOrder[10].equals("undefined")?"":ProductOrder[10];
        ProductOrder[11] = ProductOrder[11].equals("undefined")?"":ProductOrder[11];
        ProductOrder[12] = ProductOrder[12].equals("undefined")?"":ProductOrder[12];
        ProductOrder[13] = ProductOrder[13].equals("undefined")?"":ProductOrder[13];
        ProductOrder[14] = ProductOrder[14].equals("undefined")?"":ProductOrder[14];
        inparamList.add(ProductOrder);
        System.out.println("��Ʒ������:"+i+"  : "+ProductOrder[10]);
    }

    //��Ʒ��������
    for(int i=0;i<addNum3;i++){
        String[] ProductOrder = new String[16];
        ProductOrder[0]  = "0";//��Ʒ������Ϣ
        ProductOrder[1]  = request.getParameter("a_ProductOrderNumber_PrdOrd"+i);//��Ʒ������        
        ProductOrder[2]  = request.getParameter("a_ProductID_PrdOrd"+i);//��Ʒ������ϵID
        ProductOrder[3]  = request.getParameter("a_ProductSpecNumber_PrdOrd"+i);//��Ʒ�����
        ProductOrder[4]  = request.getParameter("a_AccessNumber_PrdOrd"+i);//��Ʒ�ؼ�����
        ProductOrder[5]  = request.getParameter("a_PriAccessNumber_PrdOrd"+i);//��Ʒ��������
        ProductOrder[6]  = request.getParameter("a_Linkman_PrdOrd"+i);//��ϵ��
        ProductOrder[7]  = request.getParameter("a_ContactPhone_PrdOrd"+i);//��ϵ�绰
        ProductOrder[8]  = request.getParameter("a_Description_PrdOrd"+i);//��Ʒ����
        ProductOrder[9]  = request.getParameter("a_ServiceLevelID_PrdOrd"+i);//����ͨ�ȼ�ID
        ProductOrder[10] = request.getParameter("a_OperationSubTypeID_PrdOrd"+i);//��Ʒ��ҵ�����
        ProductOrder[11] = "0";
        ProductOrder[12] = request.getParameter("a_selSales"+i);//���۴�����
        ProductOrder[13] = request.getParameter("a_AcceptID_PrdOrd"+i);
        ProductOrder[14] = request.getParameter("p_POOrderNumber");//add ��Ʒ��������
        ProductOrder[15] = request.getParameter("a_OneTimeFee"+i);// add ��Ʒһ���Է���
        ProductOrder[1]  = ProductOrder[1].equals("undefined")?"":ProductOrder[1];
        ProductOrder[2]  = ProductOrder[2].equals("undefined")?"":ProductOrder[2];
        ProductOrder[3]  = ProductOrder[3].equals("undefined")?"":ProductOrder[3];
        ProductOrder[4]  = ProductOrder[4].equals("undefined")?"":ProductOrder[4];
        ProductOrder[5]  = ProductOrder[5].equals("undefined")?"":ProductOrder[5];
        ProductOrder[6]  = ProductOrder[6].equals("undefined")?"":ProductOrder[6];
        ProductOrder[7]  = ProductOrder[7].equals("undefined")?"":ProductOrder[7];
        ProductOrder[8]  = ProductOrder[8].equals("undefined")?"":ProductOrder[8];
        ProductOrder[9]  = ProductOrder[9].equals("undefined")?"":ProductOrder[9];
        ProductOrder[10] = ProductOrder[10].equals("undefined")?"":ProductOrder[10];
        ProductOrder[11] = ProductOrder[11].equals("undefined")?"":ProductOrder[11];
        System.out.println("()()()");
        ProductOrder[12] = ProductOrder[12].equals("undefined")?"":ProductOrder[12];
        System.out.println(")()()(");
        ProductOrder[13] = ProductOrder[13].equals("undefined")?"":ProductOrder[13];
        ProductOrder[14] = ProductOrder[14].equals("undefined")?"":ProductOrder[14];
        ProductOrder[15] = ProductOrder[15].equals("undefined")?"":ProductOrder[15];
        inparamList.add(ProductOrder);
        //--------------------�������-----------------------
        System.out.print("��Ʒ������Ϣ====wanghfa====");
        System.out.print(",ProductOrder[0] = "+ ProductOrder[0]);
        System.out.print(",ProductOrder[1] = "+ ProductOrder[1]);
        System.out.print(",ProductOrder[2] = "+ ProductOrder[2]);
        System.out.print(",ProductOrder[3] = "+ ProductOrder[3]);
        System.out.print(",ProductOrder[4] = "+ ProductOrder[4]);
        System.out.print(",ProductOrder[5] = "+ ProductOrder[5]);
        System.out.print(",ProductOrder[6] = "+ ProductOrder[6]);
        System.out.print(",ProductOrder[7] = "+ ProductOrder[7]);
        System.out.print(",ProductOrder[8] = "+ ProductOrder[8]);
        System.out.print(",ProductOrder[9] = "+ ProductOrder[9]);
        System.out.print(",ProductOrder[10] = "+ ProductOrder[10]);
        System.out.print(",ProductOrder[11] = "+ ProductOrder[11]);
        System.out.print(",ProductOrder[12] = "+ ProductOrder[12]);
        System.out.print(",ProductOrder[13] = "+ ProductOrder[13]);
        System.out.print(",ProductOrder[14] = "+ ProductOrder[14]);
        System.out.print(",ProductOrder[15] = "+ ProductOrder[15]);
        System.out.println("");
    }
    
    //��Ʒ�ʷѼƻ�ɾ��
    for(int i=0;i<delNum4;i++){
        String[] ProdRatePlan = new String[15];
        ProdRatePlan[0]  = "4";//��Ʒ�ʷѼƻ�
        ProdRatePlan[1]  = request.getParameter("d_ProductOrderNumber_PrdOrdRatePlan"+i);//��Ʒ������
        ProdRatePlan[2]  = request.getParameter("d_ProductSpecNumber_PrdOrdRatePlan"+i);//��Ʒ�����
        ProdRatePlan[3]  = request.getParameter("d_RatePlanID_PrdOrdRatePlan"+i);//��Ʒ���ʷѼƻ���ʶ
        ProdRatePlan[4]  = request.getParameter("d_Description_PrdOrdRatePlan"+i);//��Ʒ�ʷ�����
        ProdRatePlan[5]  = "0";//�ƻ���ʶ��������
        //ProdRatePlan[6]  = "0";wangzn modify 2011/6/24 11:11:13
        ProdRatePlan[6]	=request.getParameter("d_OperType_PrdOrdRatePlan"+i);//NEW or OLD
        System.out.println("***:"+ProdRatePlan[1]);
        ProdRatePlan[7]  = request.getParameter("d_ParAcceptID_PrdOrdRatePlan"+i);
         System.out.println(" 1ProdRatePlan[7]"+ ProdRatePlan[7]);
        ProdRatePlan[8]  = request.getParameter("d_AcceptID_PrdOrdRatePlan"+i);
        System.out.println(" ProdRatePlan[8]"+ ProdRatePlan[8]);
        ProdRatePlan[9]  = WtcUtil.repNull(request.getParameter("p_BIZCODE"+i));//add ҵ�����
         System.out.println(" ProdRatePlan[9]"+ ProdRatePlan[9]);
        ProdRatePlan[10] = WtcUtil.repNull(request.getParameter("p_BillType"+i)).equals("undefined")?"":request.getParameter("p_BillType"+i);//add ���ѷ�ʽ
         System.out.println(" ProdRatePlan[10]"+ ProdRatePlan[10]);
        ProdRatePlan[11] = request.getParameter("a_ProductCode"+i);			//add ��Ʒ����
        System.out.println(" ProdRatePlan[11]"+ ProdRatePlan[11]);
        ProdRatePlan[12] = "";
        ProdRatePlan[13] = "";
        ProdRatePlan[14] = "";
        System.out.println(" ProdRatePlan[1]"+ ProdRatePlan[1]);
        System.out.println(" ProdRatePlan[2]"+ ProdRatePlan[2]);
        System.out.println(" ProdRatePlan[3]"+ ProdRatePlan[3]);
        System.out.println(" ProdRatePlan[4]"+ ProdRatePlan[4]);
        System.out.println(" ProdRatePlan[5]"+ ProdRatePlan[5]);
        System.out.println(" ProdRatePlan[6]"+ ProdRatePlan[6]);
        System.out.println(" ProdRatePlan[7]"+ ProdRatePlan[7]);
        System.out.println(" ProdRatePlan[8]"+ ProdRatePlan[8]);
        System.out.println(" ProdRatePlan[9]"+ ProdRatePlan[9]);
        System.out.println(" ProdRatePlan[10]"+ ProdRatePlan[10]);
        System.out.println(" ProdRatePlan[11]"+ ProdRatePlan[11]);
        ProdRatePlan[1] =  ProdRatePlan[1].equals("undefined")?"":ProdRatePlan[1];
        ProdRatePlan[2] =  ProdRatePlan[2].equals("undefined")?"":ProdRatePlan[2];
        ProdRatePlan[3] =  ProdRatePlan[3].equals("undefined")?"":ProdRatePlan[3];
        ProdRatePlan[4] =  ProdRatePlan[4].equals("undefined")?"":ProdRatePlan[4];
        ProdRatePlan[5] =  ProdRatePlan[5].equals("undefined")?"":ProdRatePlan[5];
        
        inparamList.add(ProdRatePlan);
    }      
    //��Ʒ�ʷѼƻ�����
    /*liujian 2012-12-18 17:01:30  BillType�Ǹ����ڶ����ϵģ�һ������һ��BillType��Ŀǰ��Ʒ�ʷ�֧������������ÿ����Ʒ��Ӧ�����ó�BillType*/
    String  __billType = "";
    for(int i=0;i<addNum4;i++){
        String[] ProdRatePlan = new String[15];
        ProdRatePlan[0]  = "4";//��Ʒ�ʷѼƻ�
        ProdRatePlan[1]  = request.getParameter("a_ProductOrderNumber_PrdOrdRatePlan"+i);//��Ʒ������
        System.out.println("ProdRatePlan[1]------------------|"+ProdRatePlan[1]);
        ProdRatePlan[2]  = request.getParameter("a_ProductSpecNumber_PrdOrdRatePlan"+i);//��Ʒ�����
        ProdRatePlan[3]  = request.getParameter("a_RatePlanID_PrdOrdRatePlan"+i);//��Ʒ���ʷѼƻ���ʶ
        ProdRatePlan[4]  = request.getParameter("a_Description_PrdOrdRatePlan"+i);//��Ʒ�ʷ�����
        ProdRatePlan[5]  = "1";//�ƻ���ʶ��������
        //ProdRatePlan[6]  = "0";wangzn modify 2011/6/24 11:11:13
        ProdRatePlan[6]	=request.getParameter("a_OperType_PrdOrdRatePlan"+i);//NEW or OLD
        ProdRatePlan[7]  = request.getParameter("a_ParAcceptID_PrdOrdRatePlan"+i);
        ProdRatePlan[8]  = request.getParameter("a_AcceptID_PrdOrdRatePlan"+i);
        ProdRatePlan[9]  = WtcUtil.repNull(request.getParameter("p_BIZCODE"+i));//add ҵ�����
        //liujian 2012-12-18 15:57:13 ��request.getParameter("p_BillType"+i).equals("undefined")
        //	�޸ĳ�����
        if(i == 0 ) {
        	  String _billTypeTemp = request.getParameter("p_BillType"+i);
        	  if(null == _billTypeTemp) {
        	  	 __billType = "";
        	  }else if(_billTypeTemp.equals("undefined")) {
        	  	 __billType = "";
        	  }else {
        	  		__billType = _billTypeTemp;
        	  }
        }
        ProdRatePlan[10] = __billType;
        //liujian  2012-12-18 16:06:35 �޸Ľ���
        ProdRatePlan[11] = request.getParameter("a_ProductCode"+i);			//add ��Ʒ����
        ProdRatePlan[12] = "";
        ProdRatePlan[13] = "";
        ProdRatePlan[14] = "";
        ProdRatePlan[1] =  ProdRatePlan[1].equals("undefined")?"":ProdRatePlan[1];
        ProdRatePlan[2] =  ProdRatePlan[2].equals("undefined")?"":ProdRatePlan[2];
        ProdRatePlan[3] =  ProdRatePlan[3].equals("undefined")?"":ProdRatePlan[3];
        ProdRatePlan[4] =  ProdRatePlan[4].equals("undefined")?"":ProdRatePlan[4];
        ProdRatePlan[5] =  ProdRatePlan[5].equals("undefined")?"":ProdRatePlan[5];
        
        ProdRatePlan[9] =  ProdRatePlan[9].equals("undefined")?"":ProdRatePlan[9];
        inparamList.add(ProdRatePlan);
        //--------------------�������-----------------------
        System.out.println("��Ʒ�ʷѼƻ���Ϣ" + ProdRatePlan[0] + ", " + ProdRatePlan[8]);
        /*
        System.out.println(" ProdRatePlan[1]"+ ProdRatePlan[1]);
        System.out.println(" ProdRatePlan[2]"+ ProdRatePlan[2]);
        System.out.println(" ProdRatePlan[3]"+ ProdRatePlan[3]);
        System.out.println(" ProdRatePlan[4]"+ ProdRatePlan[4]);
        System.out.println(" ProdRatePlan[5]"+ ProdRatePlan[5]);
        System.out.println(" ProdRatePlan[6]"+ ProdRatePlan[6]);
        System.out.println(" ProdRatePlan[7]"+ ProdRatePlan[7]);
        System.out.println(" ProdRatePlan[8]"+ ProdRatePlan[8]);
        System.out.println(" ProdRatePlan[9]"+ ProdRatePlan[9]);
        System.out.println(" ProdRatePlan[10]"+ ProdRatePlan[10]);
        System.out.println(" ProdRatePlan[11]"+ ProdRatePlan[11]);
        System.out.println(" ProdRatePlan[12]"+ ProdRatePlan[12]);
        System.out.println(" ProdRatePlan[13]"+ ProdRatePlan[13]);
        System.out.println(" ProdRatePlan[14]"+ ProdRatePlan[14]);
        */ 
    }  
    //��ƷPICBɾ��
    for(int i=0;i<delNum5;i++){
        String[] ProdICB = new String[15];
        ProdICB[0]  = "5";//��Ʒ�ʷѼƻ�
        ProdICB[1]  = request.getParameter("d_ProductOrderNumber_PrdOrdPOICB"+i);//��Ʒ������
        ProdICB[2]  = request.getParameter("d_ProductSpecNumber_PrdOrdPOICB"+i);//��Ʒ�����
        ProdICB[3]  = request.getParameter("d_RatePlanID_PrdOrdPOICB"+i);//��Ʒ�ʷѼƻ���ʶ
        ProdICB[4]  = request.getParameter("d_ParameterNumber_PrdOrdPOICB"+i);//��������
        ProdICB[5]  = request.getParameter("d_ParameterName_PrdOrdPOICB"+i);//������
        ProdICB[6]  = request.getParameter("d_ParameterValue_PrdOrdPOICB"+i);//����ֵ
        ProdICB[7]  = "0";
        ProdICB[8]  = request.getParameter("d_ParAcceptID_PrdOrdPOICB"+i);
        ProdICB[9]  = request.getParameter("d_AcceptID_PrdOrdPOICB"+i);
        ProdICB[10] = "";
        ProdICB[11] = "";
        ProdICB[12] = "";
        ProdICB[13] = "";
        ProdICB[14] = "";
        ProdICB[1] = ProdICB[1].equals("undefined")?"":ProdICB[1];
        ProdICB[2] = ProdICB[2].equals("undefined")?"":ProdICB[2];
        ProdICB[3] = ProdICB[3].equals("undefined")?"":ProdICB[3];
        ProdICB[4] = ProdICB[4].equals("undefined")?"":ProdICB[4];
        ProdICB[5] = ProdICB[5].equals("undefined")?"":ProdICB[5];
        ProdICB[6] = ProdICB[6].equals("undefined")?"":ProdICB[6];
        inparamList.add(ProdICB);
    }
    
    //��ƷPICB����
    for(int i=0;i<addNum5;i++){        
        String[] ProdICB = new String[15];
        ProdICB[0]  = "5";//��Ʒ�ʷѼƻ�����
        ProdICB[1]  = request.getParameter("a_ProductOrderNumber_PrdOrdPOICB"+i);//��Ʒ������
        ProdICB[2]  = request.getParameter("a_ProductSpecNumber_PrdOrdPOICB"+i);//��Ʒ�����
        ProdICB[3]  = request.getParameter("a_RatePlanID_PrdOrdPOICB"+i);//��Ʒ�ʷѼƻ���ʶ
        ProdICB[4]  = request.getParameter("a_ParameterNumber_PrdOrdPOICB"+i);//��������
        ProdICB[5]  = request.getParameter("a_ParameterName_PrdOrdPOICB"+i);//������
        ProdICB[6]  = request.getParameter("a_ParameterValue_PrdOrdPOICB"+i);//����ֵ
        ProdICB[7]  = "0";
        ProdICB[8]  = request.getParameter("a_ParAcceptID_PrdOrdPOICB"+i);
        ProdICB[9]  = request.getParameter("a_AcceptID_PrdOrdPOICB"+i);
        ProdICB[10] = "";
        ProdICB[11] = "";
        ProdICB[12] = "";
        ProdICB[13] = "";
        ProdICB[14] = "";
        //--------------------�������-----------------------
        
        System.out.println("��Ʒ�ʷѼƻ�ICB��Ϣ");
        System.out.println("====wanghfa==== ProdICB[0]"+ ProdICB[0]);
        /*System.out.println("====wanghfa==== ProdICB[1]"+ ProdICB[1]);
        System.out.println("====wanghfa==== ProdICB[2]"+ ProdICB[2]);
        System.out.println("====wanghfa==== ProdICB[3]"+ ProdICB[3]);
        System.out.println("====wanghfa==== ProdICB[4]"+ ProdICB[4]);
        System.out.println("====wanghfa==== ProdICB[5]"+ ProdICB[5]);
        System.out.println("====wanghfa==== ProdICB[6]"+ ProdICB[6]);
        System.out.println("====wanghfa==== ProdICB[7]"+ ProdICB[7]);
        System.out.println("====wanghfa==== ProdICB[8]"+ ProdICB[8]);
        System.out.println("====wanghfa==== ProdICB[9]"+ ProdICB[9]);
        System.out.println("====wanghfa==== ProdICB[10]"+ ProdICB[10]);
        System.out.println("====wanghfa==== ProdICB[11]"+ ProdICB[11]);
        System.out.println("====wanghfa==== ProdICB[12]"+ ProdICB[12]);
        System.out.println("====wanghfa==== ProdICB[13]"+ ProdICB[13]);
        System.out.println("====wanghfa==== ProdICB[14]"+ ProdICB[14]);*/
        
        ProdICB[1] = ProdICB[1].equals("undefined")?"":ProdICB[1];
        ProdICB[2] = ProdICB[2].equals("undefined")?"":ProdICB[2];
        ProdICB[3] = ProdICB[3].equals("undefined")?"":ProdICB[3];
        ProdICB[4] = ProdICB[4].equals("undefined")?"":ProdICB[4];
        ProdICB[5] = ProdICB[5].equals("undefined")?"":ProdICB[5];
        ProdICB[6] = ProdICB[6].equals("undefined")?"":ProdICB[6];
        inparamList.add(ProdICB);
        
    }   
    //֧��ʡɾ��
    for(int i=0;i<delNum6;i++){ 
        String[] PayCompany = new String[15];
        PayCompany[0]  = "7";//֧��ʡ                    
        PayCompany[1]  = request.getParameter("d_ProductOrderNumber_PayCompany"+i);//��Ʒ������ 
        PayCompany[2]  = request.getParameter("d_PayCompanyID_PayCompany"+i);//֧��ʡ����       
        PayCompany[3]  = "0";//��������     
        PayCompany[4]  = "0";
        PayCompany[5]  = request.getParameter("d_ParAcceptID_PrdOrdPOICB"+i);
        PayCompany[6]  = request.getParameter("d_AcceptID_PrdOrdPOICB"+i);
        PayCompany[7]  = "";
        PayCompany[8]  = "";
        PayCompany[9]  = "";
        PayCompany[10] = "";
        PayCompany[11] = "";
        PayCompany[12] = "";
        PayCompany[13] = "";
        PayCompany[14] = "";
        PayCompany[1] = PayCompany[1].equals("undefined")?"":PayCompany[1];
        PayCompany[2] = PayCompany[2].equals("undefined")?"":PayCompany[2];
        PayCompany[3] = PayCompany[3].equals("undefined")?"":PayCompany[3];
        inparamList.add(PayCompany);
    }              
    //֧��ʡ����
    for(int i=0;i<addNum6;i++){        
        String[] PayCompany = new String[15];
        PayCompany[0]  = "7";//֧��ʡ                    
        PayCompany[1]  = request.getParameter("a_ProductOrderNumber_PayCompany"+i);//��Ʒ������ 
        PayCompany[2]  = request.getParameter("a_PayCompanyID_PayCompany"+i);//֧��ʡ����       
        PayCompany[3]  = "1";//��������     
        PayCompany[4]  = "0";
        PayCompany[5]  = request.getParameter("a_ParAcceptID_PayCompany"+i);
        PayCompany[6]  = request.getParameter("a_AcceptID_PayCompany"+i);
        PayCompany[7]  = "";
        PayCompany[8]  = "";
        PayCompany[9]  = "";
        PayCompany[10] = "";
        PayCompany[11] = "";
        PayCompany[12] = "";
        PayCompany[13] = "";
        PayCompany[14] = "";
        PayCompany[1] = PayCompany[1].equals("undefined")?"":PayCompany[1];
        PayCompany[2] = PayCompany[2].equals("undefined")?"":PayCompany[2];
        PayCompany[3] = PayCompany[3].equals("undefined")?"":PayCompany[3];
        inparamList.add(PayCompany);
        System.out.println("====wanghfa==== ��Ʒ����������Ϣ"+i+"PayCompany[0] = "+ PayCompany[0]);
        /*System.out.println("====wanghfa====  PayCompany[1] = "+ PayCompany[1]);
        System.out.println("====wanghfa====  PayCompany[2] = "+ PayCompany[2]);
        System.out.println("====wanghfa====  PayCompany[3] = "+ PayCompany[3]);
        System.out.println("====wanghfa====  PayCompany[4] = "+ PayCompany[4]);
        System.out.println("====wanghfa====  PayCompany[5] = "+ PayCompany[5]);
        System.out.println("====wanghfa====  PayCompany[6] = "+ PayCompany[6]);
        System.out.println("====wanghfa====  PayCompany[7] = "+ PayCompany[7]);
        System.out.println("====wanghfa====  PayCompany[8] = "+ PayCompany[8]);
        System.out.println("====wanghfa====  PayCompany[9] = "+ PayCompany[9]);
        System.out.println("====wanghfa====  PayCompany[10]= "+ PayCompany[10]);
        System.out.println("====wanghfa====  PayCompany[11]= "+ PayCompany[11]);
        System.out.println("====wanghfa====  PayCompany[12]= "+ PayCompany[12]);
        System.out.println("====wanghfa====  PayCompany[13]= "+ PayCompany[13]);
        System.out.println("====wanghfa====  PayCompany[14]= "+ PayCompany[14]);*/
    }              
       
    //��Ʒ����ɾ��
    System.out.println("------AAABBBCCCDDDEEEFFF--------");
    System.out.println("====wanghfa====����:"+delNum7);
    for(int i=0;i<delNum7;i++){
        String[] ProductChara = new String[15];
        ProductChara[0] = "6";//��Ʒ����                            
        ProductChara[1] = request.getParameter("d_ProductOrderNumber_ProOrdChara"+i);//��Ʒ������             
        ProductChara[2] = request.getParameter("d_ProductSpecCharacterNumber_ProOrdChara"+i);//��Ʒ���Դ���   
        ProductChara[3] = request.getParameter("d_CharacterValue_ProOrdChara"+i);//����ֵ
        ProductChara[4] = request.getParameter("d_Name_ProOrdChara"+i);//������          
        ProductChara[5] = "0";//��������      
        ProductChara[6] = "0";
        ProductChara[7] = request.getParameter("d_ParAcceptID_ProOrdChara"+i);
        ProductChara[8] = request.getParameter("d_AcceptID_ProOrdChara"+i);
        ProductChara[9] = request.getParameter("d_CharacterGroup"+i) == null ? "" : request.getParameter("d_CharacterGroup"+i);
        System.out.println("d_CharacterGroup********======="+ProductChara[9]);
        ProductChara[10] = request.getParameter("d_POOrderSeriNum_ProOrdChara"+i);
        System.out.println("i:"+i+" : "+ProductChara[10]);
        ProductChara[11] = "";
        ProductChara[12] = "";
        ProductChara[13] = "";
        ProductChara[14] = "";
        ProductChara[1] = ProductChara[1].equals("undefined")?"":ProductChara[1];
        ProductChara[2] = ProductChara[2].equals("undefined")?"":ProductChara[2];
        ProductChara[3] = ProductChara[3].equals("undefined")?"":ProductChara[3];
        ProductChara[4] = ProductChara[4].equals("undefined")?"":ProductChara[4];
        ProductChara[5] = ProductChara[5].equals("undefined")?"":ProductChara[5];
        inparamList.add(ProductChara);
        System.out.println("====wanghfa==== ��Ʒ����ɾ����Ϣ"+i+"ProductChara[0] = "+ ProductChara[0] + ", " + ProductChara[1]);
        /*System.out.println("====wanghfa====  ProductChara[1] = "+ ProductChara[1]);
        System.out.println("====wanghfa====  ProductChara[2] = "+ ProductChara[2]);
        System.out.println("====wanghfa====  ProductChara[3] = "+ ProductChara[3]);
        System.out.println("====wanghfa====  ProductChara[4] = "+ ProductChara[4]);
        System.out.println("====wanghfa====  ProductChara[5] = "+ ProductChara[5]);
        System.out.println("====wanghfa====  ProductChara[6] = "+ ProductChara[6]);
        System.out.println("====wanghfa====  ProductChara[7] = "+ ProductChara[7]);
        System.out.println("====wanghfa====  ProductChara[8] = "+ ProductChara[8]);
        System.out.println("====wanghfa====  ProductChara[9] = "+ ProductChara[9]);
        System.out.println("====wanghfa====  ProductChara[10]= "+ ProductChara[10]);
        System.out.println("====wanghfa====  ProductChara[11]= "+ ProductChara[11]);
        System.out.println("====wanghfa====  ProductChara[12]= "+ ProductChara[12]);
        System.out.println("====wanghfa====  ProductChara[13]= "+ ProductChara[13]);
        System.out.println("====wanghfa====  ProductChara[14]= "+ ProductChara[14]);
        System.out.println(" ProductChara[10]"+ ProductChara[10]);*/
    }     
    //��Ʒ��������
    System.out.println("====wanghfa==== ��Ʒ�������� addNum7 = " + addNum7);
    for(int i=0;i<addNum7;i++){
        String[] ProductChara = new String[15];
        ProductChara[0] = "6";//��Ʒ����                            
        ProductChara[1] = request.getParameter("a_ProductOrderNumber_ProOrdChara"+i);//��Ʒ������             
        ProductChara[2] = request.getParameter("a_ProductSpecCharacterNumber_ProOrdChara"+i);//��Ʒ���Դ���   
        ProductChara[3] = request.getParameter("a_CharacterValue_ProOrdChara"+i);//����ֵ
        ProductChara[4] = request.getParameter("a_Name_ProOrdChara"+i);//������          
        System.out.println("rendi add for #########################################"+request.getParameter("a_OperType_ProOrdChara"+i));
        ProductChara[5] = "1";//��������      
        ProductChara[6] = "0";
        ProductChara[7] = request.getParameter("a_ParAcceptID_ProOrdChara"+i);
        ProductChara[8] = request.getParameter("a_AcceptID_ProOrdChara"+i);
        ProductChara[9] = request.getParameter("a_CharacterGroup"+i).equals("undefined")?"":request.getParameter("a_CharacterGroup"+i);
        System.out.println("a_CharacterGroup========="+ProductChara[9]);
        ProductChara[10] = "";//��������ԭ��
        ProductChara[11] = request.getParameter("a_OperType_ProOrdChara"+i);
        ProductChara[12] = "";
        ProductChara[13] = "";
        ProductChara[14] = "";
        System.out.println("====wanghfa==== ��Ʒ����������Ϣ"+i+","+ ProductChara[0] + ", " + ProductChara[1] + ", " + ProductChara[11]);
        /*System.out.println("====wanghfa==== ProductChara[1]"+ ProductChara[1]);
        System.out.println("====wanghfa==== ProductChara[2]"+ ProductChara[2]);
        System.out.println("====wanghfa==== ProductChara[3]"+ ProductChara[3]);
        System.out.println("====wanghfa==== ProductChara[4]"+ ProductChara[4]);
        System.out.println("====wanghfa==== ProductChara[5]"+ ProductChara[5]);
        System.out.println("====wanghfa==== ProductChara[6]"+ ProductChara[6]);
        System.out.println("====wanghfa==== ProductChara[7]"+ ProductChara[7]);
        System.out.println("====wanghfa==== ProductChara[8]"+ ProductChara[8]);
        System.out.println("====wanghfa==== ProductChara[9]"+ ProductChara[9]);
        System.out.println("====wanghfa==== ProductChara[10]"+ ProductChara[10]);
        System.out.println("====wanghfa==== ProductChara[11]"+ ProductChara[11]);
        System.out.println("====wanghfa==== ProductChara[12]"+ ProductChara[12]);
        System.out.println("====wanghfa==== ProductChara[13]"+ ProductChara[13]);
        System.out.println("====wanghfa==== ProductChara[14]"+ ProductChara[14]);*/
        ProductChara[1] = ProductChara[1].equals("undefined")?"":ProductChara[1];
        ProductChara[2] = ProductChara[2].equals("undefined")?"":ProductChara[2];
        ProductChara[3] = ProductChara[3].equals("undefined")?"":ProductChara[3];
        ProductChara[4] = ProductChara[4].equals("undefined")?"":ProductChara[4];
        ProductChara[5] = ProductChara[5].equals("undefined")?"":ProductChara[5];
        inparamList.add(ProductChara);
        /*
        //������ֻ�������������ݣ����е����ݲ����뵽������������
        if(request.getParameter("a_OperType_ProOrdChara"+i).equals("NEW"))
        { 
        	inparamList.add(ProductChara);
        }
        if(POOrder[10].equals("3|")||POOrder[10].equals("4|")){
        	inparamList.add(ProductChara);
        }
        */
        //--------------------�������-----------------------
        
        
     }
     //������ڵ�2010-4-13 20:05:29
     for(int i=0;i<addNum9;i++){
        String[] ProductManager = new String[15];
        ProductManager[0] = request.getParameter("managerType"+i);
        ProductManager[1] = request.getParameter("productOrderNumber"+i);
        ProductManager[2] = request.getParameter("operateCode"+i);
        ProductManager[3] = request.getParameter("characterID"+i);
        ProductManager[4] = request.getParameter("characterValue"+i);
        ProductManager[5] = request.getParameter("characterName"+i);
        ProductManager[6] = request.getParameter("characterDesc"+i);
        ProductManager[7] = "";
        ProductManager[8] = "";
        ProductManager[9] = "";
        ProductManager[10] = "";
        ProductManager[11] = "";
        ProductManager[12] = "";
        ProductManager[13] = "";
        ProductManager[14] = "";
        inparamList.add(ProductManager);	
        System.out.println("====wanghfa====---------Manager--------");
        System.out.println("====wanghfa===="+ProductManager[0]+","+ProductManager[1]+","+ProductManager[2]+","+ProductManager[3]+","+ProductManager[4]+","+ProductManager[5]+","+ProductManager[6]);
     }
     
		for(int i=0;i<addNum10;i++){
			String[] ExamineData = new String[15];
			ExamineData[0] = request.getParameter("ExamineType"+i);
			ExamineData[1] = request.getParameter("ExamineContent"+i);
			ExamineData[2] = request.getParameter("ExamineResult"+i);
			ExamineData[3] = "";
			ExamineData[4] = "";
			ExamineData[5] = "";
			ExamineData[6] = "";
			ExamineData[7] = "";
			ExamineData[8] = "";
			ExamineData[9] = "";
			ExamineData[10] = "";
			ExamineData[11] = "";
			ExamineData[12] = "";
			ExamineData[13] = "";
			ExamineData[14] = "";
			inparamList.add(ExamineData);	
			System.out.println("---------ExamineData--------");
			System.out.println(ExamineData[0]);
			System.out.println(ExamineData[1]);
			System.out.println(ExamineData[2]);
			System.out.println(ExamineData[3]);
			System.out.println(ExamineData[4]);
			System.out.println(ExamineData[5]);
			System.out.println(ExamineData[6]);
			System.out.println(ExamineData[7]);
			System.out.println(ExamineData[8]);
			System.out.println(ExamineData[9]);
			System.out.println(ExamineData[10]);
			System.out.println(ExamineData[11]);
			System.out.println(ExamineData[12]);
			System.out.println(ExamineData[13]);
			System.out.println(ExamineData[14]);
			System.out.println("---------ExamineData--------");
		}
    
		//2012/2/12	wanghfa���	start
		//����
		String[] poAttType = request.getParameterValues("poAttType");
		String[] poAttCode = request.getParameterValues("poAttCode");
		String[] contName = request.getParameterValues("contName");
		String[] poAttName = request.getParameterValues("poAttName");
		String[] poAttNameFile = request.getParameterValues("poAttNameFile");
		
		
		String[] ContEffdate   = request.getParameterValues("ContEffdate");
		String[] ContExpdate   = request.getParameterValues("ContExpdate");
		String[] IsAutoRecont  = request.getParameterValues("IsAutoRecont");
		String[] RecontExpdate = request.getParameterValues("RecontExpdate");
		String[] ContFee       = request.getParameterValues("ContFee");
		String[] PerferPlan    = request.getParameterValues("PerferPlan");
		String[] AutoRecontCyc = request.getParameterValues("AutoRecontCyc");
		String[] IsRecont      = request.getParameterValues("IsRecont");
		
		
		
		
		if (poAttType != null) {
			for(int i = 0;i < poAttType.length;i ++){
				String[] poAttachmentMsg = new String[15];
				poAttachmentMsg[0] = "8";
				poAttachmentMsg[1] = "";
				poAttachmentMsg[2] = poAttType[i];
				poAttachmentMsg[3] = poAttCode[i];
				poAttachmentMsg[4] = contName[i];
				poAttachmentMsg[5] = poAttName[i];
				poAttachmentMsg[6] = poAttNameFile[i];
				poAttachmentMsg[7] = ContEffdate[i];
				poAttachmentMsg[8] = ContExpdate[i];
				poAttachmentMsg[9] = IsAutoRecont[i];
				poAttachmentMsg[10] = RecontExpdate[i];
				poAttachmentMsg[11] = ContFee[i];
				poAttachmentMsg[12] = PerferPlan[i];
				poAttachmentMsg[13] = AutoRecontCyc[i];
				poAttachmentMsg[14] = IsRecont[i];
				
				
				inparamList.add(poAttachmentMsg);
				System.out.println("---------poAttachmentMsg--------");
				for (int j = 0;j < 15;j ++) {
					System.out.println(poAttachmentMsg[j]);
				}
				System.out.println("---------poAttachmentMsg--------");
			}
		}
		
		//ҵ��������Ϣ
		String[] auditor = request.getParameterValues("auditor");
		String[] auditTime = request.getParameterValues("auditTime");
		String[] custName = request.getParameterValues("custName");
		if (auditor != null) {
			for(int i = 0;i < auditor.length;i ++){
				String[] poAuditMsg = new String[15];
				poAuditMsg[0] = "9";
				poAuditMsg[1] = "";
				poAuditMsg[2] = "";
				poAuditMsg[3] = auditor[i];
				poAuditMsg[4] = auditTime[i];
				poAuditMsg[5] = custName[i];
				poAuditMsg[6] = "";
				poAuditMsg[7] = "";
				poAuditMsg[8] = "";
				poAuditMsg[9] = "";
				poAuditMsg[10] = "";
				poAuditMsg[11] = "";
				poAuditMsg[12] = "";
				poAuditMsg[13] = "";
				poAuditMsg[14] = "";
				inparamList.add(poAuditMsg);
				System.out.println("---------poAuditMsg--------");
				for (int j = 0;j < 15;j ++) {
					System.out.println(poAuditMsg[j]);
				}
				System.out.println("---------poAuditMsg--------");
			}
		}
		//ҵ��������Ϣ
		String[] contactorType = request.getParameterValues("contactorType");
		String[] contactorName = request.getParameterValues("contactorName");
		String[] contactorPhone = request.getParameterValues("contactorPhone");
		if (contactorType != null) {
			for(int i = 0;i < contactorType.length;i ++){
				String[] contactorInfoMsg = new String[15];
				contactorInfoMsg[0] = "b";
				contactorInfoMsg[1] = "";
				contactorInfoMsg[2] = "";
				contactorInfoMsg[3] = contactorType[i];
				contactorInfoMsg[4] = contactorName[i];
				contactorInfoMsg[5] = contactorPhone[i];
				contactorInfoMsg[6] = "";
				contactorInfoMsg[7] = "";
				contactorInfoMsg[8] = "";
				contactorInfoMsg[9] = "";
				contactorInfoMsg[10] = "";
				contactorInfoMsg[11] = "";
				contactorInfoMsg[12] = "";
				contactorInfoMsg[13] = "";
				contactorInfoMsg[14] = "";
				inparamList.add(contactorInfoMsg);
				System.out.println("---------contactorInfoMsg--------");
				for (int j = 0;j < 15;j ++) {
					System.out.println(contactorInfoMsg[j]);
				}
				System.out.println("---------contactorInfoMsg--------");
			}
		}
		//2012/2/12	wanghfa���	end

		for(int i=0;i<inparamList.size();i++) {
			for(int j=0;j<((String [])inparamList.get(i)).length;j++) System.out.println("%%%%%%%%%%%%%%%%%%%%%size["+i+"]["+j+"]="+((String [])inparamList.get(i))[j]);
		} 
     
     
		int inParamSize = inparamList.size();
		String[] p0 = new String[inParamSize];
		String[] p1 = new String[inParamSize];
		String[] p2 = new String[inParamSize];
		String[] p3 = new String[inParamSize];
		String[] p4 = new String[inParamSize];
		String[] p5 = new String[inParamSize];
		String[] p6 = new String[inParamSize];
		String[] p7 = new String[inParamSize];
		String[] p8 = new String[inParamSize];
		String[] p9 = new String[inParamSize];
		String[] p10 = new String[inParamSize];
		String[] p11 = new String[inParamSize];
		String[] p12 = new String[inParamSize];
		String[] p13 = new String[inParamSize];
		String[] p14 = new String[inParamSize];
		String[] p15 = new String[inParamSize];
		String[] p16 = new String[inParamSize];
		String[] p17 = new String[inParamSize];
		String[] p18 = new String[inParamSize];
		String[] p19 = new String[inParamSize];
		String[] p20 = new String[inParamSize];
		String[] p21 = new String[inParamSize];
		String[] p22 = new String[inParamSize];
		String[] p23 = new String[inParamSize];
		String[] p24 = new String[inParamSize];
     

		for (int i = 0;i < inParamSize;i++) {
			String[] inParamArray = (String[])inparamList.get(i);
			p0[i] =inParamArray[0];
			p1[i] =inParamArray[1];
			p2[i] =inParamArray[2];
			p3[i] =inParamArray[3];
			p4[i] =inParamArray[4];
			p5[i] =inParamArray[5];
			p6[i] =inParamArray[6];
			p7[i] =inParamArray[7];
			p8[i] =inParamArray[8];
			p9[i] =inParamArray[9];
			p10[i]=inParamArray[10];
			p11[i]=inParamArray[11];
			p12[i]=inParamArray[12];
			p13[i]=inParamArray[13];
			p14[i]=inParamArray[14];
			
			System.out.println("p0[" +i+"]:"+p0[i] );
			System.out.println("p1[" +i+"]:"+p1[i] );
			System.out.println("p2[" +i+"]:"+p2[i] );
			System.out.println("p3[" +i+"]:"+p3[i] );
			System.out.println("p4[" +i+"]:"+p4[i] );
			System.out.println("p5[" +i+"]:"+p5[i] );
			System.out.println("p6[" +i+"]:"+p6[i] );
			System.out.println("p7[" +i+"]:"+p7[i] );
			System.out.println("p8[" +i+"]:"+p8[i] );
			System.out.println("p9[" +i+"]:"+p9[i] );
			System.out.println("p10["+i+"]:"+p10[i]);
			System.out.println("p11["+i+"]:"+p11[i]);
			System.out.println("p12["+i+"]:"+p12[i]);
			System.out.println("p13["+i+"]:"+p13[i]);
			System.out.println("p14["+i+"]:"+p14[i]);
       
			System.out.println("*********************************--"+i);
			//wuxy add 20110509
			if(inParamArray.length == 16 && inParamArray[15] != null) {
				p15[i]=inParamArray[15];
				System.out.println("p15["+i+"]:"+p15[i]);
			}
			if(inParamArray.length == 25 && inParamArray[15] != null) {
				p15[i]=inParamArray[15];
				System.out.println("p15["+i+"]:"+p15[i]);
				if(inParamArray[16] != null) {
					p16[i]=inParamArray[16];
					System.out.println("p16["+i+"]:"+p16[i]);
				}
				if(inParamArray[17] != null) {
					p17[i]=inParamArray[17];
					System.out.println("p17["+i+"]:"+p17[i]);
				}
				if(inParamArray[18] != null) {
					p18[i]=inParamArray[18];
					System.out.println("p18["+i+"]:"+p18[i]);
				}
				if(inParamArray[19] != null) {
					p19[i]=inParamArray[19];
					System.out.println("p19["+i+"]:"+p19[i]);
				}
				if(inParamArray[20] != null) {
					p20[i]=inParamArray[20];
					System.out.println("p20["+i+"]:"+p20[i]);
				}
				if(inParamArray[21] != null) {
					p21[i]=inParamArray[21];
					System.out.println("p21["+i+"]:"+p21[i]);
				}
				if(inParamArray[21] != null) {
					p22[i]=inParamArray[22];
					System.out.println("p22["+i+"]:"+p22[i]);
				}
				if(inParamArray[21] != null) {
					p23[i]=inParamArray[23];
					System.out.println("p23["+i+"]:"+p23[i]);
				}
				if(inParamArray[21] != null) {
					p24[i]=inParamArray[24];
					System.out.println("p24["+i+"]:"+p24[i]);
				}
			}
		}
		
%>

<wtc:service name="s9102Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="7"  retcode="Code" retmsg="Msg">
   <wtc:params value="<%=p0%>"/>
   <wtc:params value="<%=p1%>"/>
   <wtc:params value="<%=p2%>"/>
   <wtc:params value="<%=p3%>"/>
   <wtc:params value="<%=p4%>"/>
   <wtc:params value="<%=p5%>"/>
   <wtc:params value="<%=p6%>"/>
   <wtc:params value="<%=p7%>"/>
   <wtc:params value="<%=p8%>"/>
   <wtc:params value="<%=p9%>"/>
   <wtc:params value="<%=p10%>"/>
   <wtc:params value="<%=p11%>"/>
   <wtc:params value="<%=p12%>"/>
   <wtc:params value="<%=p13%>"/>
   <wtc:params value="<%=p14%>"/>
   <wtc:params value="<%=p15%>"/>
   <wtc:params value="<%=p16%>"/>
   <wtc:params value="<%=p17%>"/>
   <wtc:params value="<%=p18%>"/>
   <wtc:params value="<%=p19%>"/>
   <wtc:params value="<%=p20%>"/>
   <wtc:params value="<%=p21%>"/>
   <wtc:params value="<%=p22%>"/>
   <wtc:params value="<%=p23%>"/>
   <wtc:params value="<%=p24%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
System.out.println("Code-------------|"+Code);
if(!Code.equals("000000")){
%>
<script language="JavaScript">
		rdShowMessageDialog("<%=Msg%>!",0);
		window.location.replace("f2029_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
</script>
<%
}else{
%>
<script language="JavaScript">
		if(("0"=="<%=p_operType%>"||"2"=="<%=p_operType%>")&&"010109002"=="<%=request.getParameter("p_POSpecNumber")%>"){
			rdShowMessageDialog("ҵ������������ύ����24Сʱ���ѯ�鵵�������δ��ʱ�鵵�뷢��ҵ����档",1);
		}
		else if("2"=="<%=p_operType%>"&&"010109002"=="<%=request.getParameter("p_POSpecNumber")%>"){
			rdShowMessageDialog("ҵ������������ύ����24Сʱ���ѯ�鵵�������δ��ʱ�鵵�뷢��ҵ����档",1);
		}
		else{
			rdShowMessageDialog("�����ɹ�!",2);
		}
		window.location.replace("f2029_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
</script>
<%
}
%>

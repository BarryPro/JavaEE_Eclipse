<%
/********************
 * version v2.0
 * ������: si-tech
 * update by shengzd @ 2009-05-25
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ page import="com.sitech.boss.pub.util.*"%>


<%
    String opCode = "3500";
    String opName = "���Ų�Ʒ����";
    Logger logger = Logger.getLogger("s3500_1.jsp");

    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    int iDate = Integer.parseInt(dateStr);
    String addDate = Integer.toString(iDate);
    String Date100 = Integer.toString(iDate+1000000);

    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String nopass  = (String)session.getAttribute("password");
    String Department = org_code;
    String regionCode = Department.substring(0,2);
    String districtCode = Department.substring(2,4);
    String townCode = Department.substring(4,7);
    //String GroupId = baseInfo[0][21];      //���ֵ�SESSION��û�и�����,��������ֵ
    //String ProvinceRun = baseInfo[0][22];  //���ֵ�SESSION��û�и�����,���ҳ�����Ҳ��ʹ�øñ���
    //String OrgId = baseInfo[0][23];        //���ֵ�SESSION��û�и�����,����Ĭ��ֵ
    String [] paraIn = new String[2];
    String sqlStr_flag = ""; // shengzd add @20090531
    String sqlStr = "";
		String cust_address = "";
    ArrayList retArray = new ArrayList();
    String[][] result = new String[][]{};
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    productCfg prodcfg = new productCfg();
		String[][] resultList = new String[][]{};
		/*��Ʒ�ͷ���ķ���Ȩ��*/
    int iPowerRight = Integer.parseInt(((String)session.getAttribute("powerRight")).trim()); //����Ȩ��

		//ȡ����ʡ�ݴ��� -- Ϊ�������ӣ�ɽ������ʹ��session
		String[][] result2  = null;
		sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";//������agent_prov_code='21'
		//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode11" retmsg="retMsg11"  outnum="1">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    	</wtc:pubselect>
    	<wtc:array id="retArr11" scope="end" />
<%
    if(retCode11.equals("000000")){
        result2 = retArr11;
    }
		String ProvinceRun = "";
		if (result2 != null && result2.length != 0) 
		{
			ProvinceRun = result2[0][0];
		}
	
    //ȡ���������GROUP_ID
    String GroupId = "";
    String OrgId = "";
    if(ProvinceRun.equals("20"))  //����
    {
		String[][] result1  = null;
		sqlStr = "select group_id,'unknown' FROM dLoginMsg where login_no=:workno";
		//result1 = (String[][])callView.sPubSelect("2",sqlStr).get(0);
		
    paraIn[0] = sqlStr;    
    paraIn[1]="workno="+workno;
%>
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode12" retmsg="retMsg12" outnum="2" >
    	<wtc:param value="<%=paraIn[0]%>"/>
    	<wtc:param value="<%=paraIn[1]%>"/> 
    	</wtc:service>
    	<wtc:array id="retArr12" scope="end"/>
<%
    if(retCode12.equals("000000")){
        result1 = retArr12;
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
    System.out.println("*****************GroupId"+GroupId);
    System.out.println("#################OrgId"+OrgId);
		//ȡ��ˮ
		/*ScallSvrViewBean viewBean = new ScallSvrViewBean();
		CallRemoteResultValue  value = null;
		String[] inParas = new String[]{""};
	
		String[][] result1  = null;
		inParas[0] = "select to_char(sMaxSysAccept.nextval) FROM dual";
		value = viewBean.callService("0", null, "spubqrycode32", "1", inParas);
		result1 = value.getData();
		String maxAccept = "0";
		if (result1 != null && result1.length != 0) 
		{
			maxAccept = result1[0][0];
		}*/
		int nextFlag=1;
		String listShow="none";
		StringBuffer nameList=new StringBuffer();
		StringBuffer nameValueList=new StringBuffer();
		StringBuffer nameGroupList=new StringBuffer();
		//String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		//String [] valueList=new String[30]{};
		//�õ�ҳ����� 
		String iccid = "";
		String cust_id = "";
		String unit_id = "";
		String cust_name = "";
		String province = "";
		String openType = "";
		String userType = "";
		//String product_attr1 = "";
		String product_code = "";
		String product_append = "";
		String grp_id = "";
		String grp_name = "";
		String account_id = "";
		String grp_userno = "";
		String channel_code = "";
		String belong_code = "";
		String group_id = "";/*add by liwd 20081127,group_id����dcustDoc��group_id*/
		String sm_code = "";
		String custAddress = "";

		StringBuffer numberList=new StringBuffer();

		//�õ��б����
		String action=request.getParameter("action");
		//String sm_code=request.getParameter("sm_code1");
		int resultListLength=0;



	if (action!=null&&action.equals("select"))
	{
		try{
             //hid_createFlag=request.getParameter("hid_createFlag");
			 iccid=request.getParameter("iccid");
			 cust_id=request.getParameter("cust_id");
			 unit_id=request.getParameter("unit_id");
			 cust_name=request.getParameter("cust_name");
			 province=request.getParameter("province");
			 sm_code=request.getParameter("sm_code");/////
			 openType=request.getParameter("openType");
			 //product_attr1=request.getParameter("product_attr");
			 userType=request.getParameter("sm_code");
			 System.out.println(".................. userType.........."+userType);
			 product_code=request.getParameter("product_code");
			 product_append=request.getParameter("product_append");
			 grp_id=request.getParameter("grp_id");
			 grp_name=request.getParameter("grp_name");
			 account_id=request.getParameter("account_id");
			 grp_userno=request.getParameter("grp_userno");
			 channel_code=request.getParameter("channel_code");
			 belong_code = request.getParameter("belong_code");
			 group_id = request.getParameter("group_id");/*add by liwd 20081127,group_id����dcustDoc��group_id*/
			 custAddress = request.getParameter("cust_address");

			 //orderid=request.getParameter("orderid");
			 //work_id=request.getParameter("work_id");

			//sqlStr= "select a.field_code,a.field_name,a.field_purpose,a.field_type,a.field_length"
			//       +"  from sUserFieldCode a,sGrpSmFieldRela b"
			//	   +" where a.busi_type = b.busi_type"
			//	   +"   and a.field_code=b.field_code"
			//	   +"   and a.busi_type = '1000'"
			//	   +"   and b.user_type='"+sm_code+"'"
			//	   +" order by b.field_order";
			
			sqlStr= "select a.field_code,a.field_name,a.field_purpose,a.field_type,to_char(a.field_length),"
			       +" b.field_grp_no,c.field_grp_name,to_char(c.max_rows),to_char(c.min_rows),b.ctrl_info"
			       +"  from sUserFieldCode a,sGrpSmFieldRela b,sUserTypeGroup c"
				   +" where a.busi_type = b.busi_type"
				   +"   and a.field_code=b.field_code"
				   +"   and a.busi_type = '1000'"
				   +"   and b.user_type=:sm_code"
				   +"   and a.busi_type = c.busi_type"
				   +"   and b.user_type = c.user_type"
				   +"   and b.field_grp_no = c.field_grp_no"
				   +" order by b.field_grp_no,b.field_order";
		        System.out.println(sqlStr);
			
			
			paraIn[0] = sqlStr;    
            paraIn[1]="sm_code="+sm_code;
%>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode13" retmsg="retMsg13" outnum="10" >
            	<wtc:param value="<%=paraIn[0]%>"/>
            	<wtc:param value="<%=paraIn[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr13" scope="end"/>
<%
        String test[][] = retArr13;

        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
        for(int outer=0 ; test != null && outer< test.length; outer++)
        {
                for(int inner=0 ; test[outer] != null && inner< test[outer].length; inner++)
                {
                        System.out.print(" | "+test[outer][inner]);
                }
                System.out.println(" | ");
        }
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
			System.out.println("11111111++++++===!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@"+retArr13.length);
            if(retCode13.equals("000000")){
                resultList = retArr13;
            }
            
			
			if (resultList != null)
			{
				for(int i=0;i<resultList.length;i++)
				{
					if (resultList[i][2].equals("10")){
						numberList.append(resultList[i][0]+"|");
					}
				}
			}else{
			}
			resultListLength=result.length;
			nextFlag=2;
			listShow="";
			//�õ����ݵ�����
			//�õ���������
		}
		catch(Exception e){
		}
	}
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>���Ų�Ʒ����</TITLE>
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s3500/pub.js"></script>
</HEAD>
	


<SCRIPT type=text/javascript>
//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function(){
	document.all.checkPayTR.style.display="none";  
	 var sm_code = document.frm.sm_code.value;	
	 if(sm_code=="gh"){
	   document.all.si_te.style.display = ""; 	   
	 	}
	 	else{
	 		 document.all.si_te.style.display = "none"; 	 			
	 		}	
    //core.rpc.onreceive = doProcess;
<%if (action!=null&&action.equals("select")){%>
    //getInfo_ProdAttr('1');
<%}%>

<%if (request.getParameter("custPwd")!=null){%>
	document.all.custPwd.value="<%=request.getParameter("custPwd")%>";
<%}%>

}

function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
	var retMessage=packet.data.findValueByName("retMessage");
	
    self.status="";
    
    if(retType == "checkContract")
    {
    	if (parseInt(retCode) == 0)
    	{
    		//alert(packet.data.findValueByName("grpFlag"));
    		//alert(packet.data.findValueByName("iCount"));
    		if (packet.data.findValueByName("grpFlag")=="Y")
    			if (packet.data.findValueByName("iCount")=="0")
    			{
					rdShowMessageDialog("����¼�뼯�ź�ͬ");
					return false;
    			}
	    	frm.action="s3500_1.jsp?action=select";
			frm.method="post";
			frm.submit();
		}
		else
		{
			rdShowMessageDialog("������룺" + retCode + "<br>������Ϣ��" + retMessage,0);
			return false;
		}
    }
    if(retType == "UserId")
    {
        if(retCode == "000000")
        {
            var retUserId = packet.data.findValueByName("retnewId");    	    
    	    document.frm.grp_id.value = retUserId;
    	    document.frm.grpQuery.disabled = true;
            document.frm.grp_name.focus();
         }
        else
        {
            rdShowMessageDialog("û�еõ��û�ID,�����»�ȡ��");
			return false;
        }
		//�õ������û���ŵ�ʱ�򣬵õ����Ŵ���
		//getGrpId();
    }
    if(retType == "GrpId") //�õ����Ŵ���
    {
        if(retCode == "000000")
        {
            var GrpId = packet.data.findValueByName("GrpId");
            document.frm.grp_userno.value = oneTok(GrpId,"|",1);
         }
        else
        {
            var retMessage = packet.data.findValueByName("retMessage");
            rdShowMessageDialog(retMessage,0);
        }
	}
    if(retType == "GrpNo") //�õ������û����
    {
        if(retCode == "000000")
        {
            var GrpNo = packet.data.findValueByName("GrpNo");
            document.frm.grp_userno.value = GrpNo;
            document.frm.getGrpNo.disabled = true;
         }
        else
        {
            var retMessage = packet.data.findValueByName("retMessage");
            rdShowMessageDialog(retMessage,0);
        }
	}
    //---------------------------------------
    if(retType == "GrpCustInfo") //�û�����ʱ�ͻ���Ϣ��ѯ
    {
        var retname = packet.data.findValueByName("retname");
        if(retCode=="000000")
        {
            document.frm.cust_name.value = retname;
			document.frm.unit_id.focus();
        }
        else
        {
            retMessage = retMessage + "[errorCode1:" + retCode + "]";
                rdShowMessageDialog(retMessage,0);
				return false;
        }
     }
    if(retType == "AccountId") //�õ��ʻ�ID
    {
        if(retCode == "000000")
        {
            var retnewId = packet.data.findValueByName("retnewId");
            document.frm.account_id.value = retnewId;
            document.frm.accountQuery.disabled = true;
			//document.frm.user_passwd.focus();
         }
        else
        {
            rdShowMessageDialog("û�еõ��ʻ�ID,�����»�ȡ��");
        }
    }
    //---------------------------------------
    if(retType == "UnitInfo")
    {
        //������Ϣ��ѯ
        var retname = packet.data.findValueByName("retname");
        if(retCode=="000000")
        {
            document.frm.unit_name.value = retname;
			document.frm.contract_name.focus();
        }
        else
        {
            retMessage = retMessage + "[errorCode1:" + retCode + "]";
                rdShowMessageDialog(retMessage,0);
				return false;
        }
     }
     //---------------------------------------
     if(retType == "checkPwd") //���ſͻ�����У��
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false") {
    	    	rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
	        	frm.custPwd.value = "";
	        	frm.custPwd.focus();
    	    	return false;	        	
            } 
            else if((document.all.OwnerType.value!="04")&&(document.frm.sm_code.value=="YM"))
            {
            	rdShowMessageDialog("ֻ��EC�����ܰ�������ע��ҵ��",2);
            	return false;
            }
            else{
                rdShowMessageDialog("�ͻ�����У��ɹ���",2);
                if(<%=nextFlag%>==1){
                	document.frm.next.disabled = false;
                }
                
            }
         }
        else
        {
            rdShowMessageDialog("�ͻ�����У�����������У�飡",0);
    		return false;
        }
     }	

     //---------------------------------------
     if(retType == "ProdAttr")
     {
        if(retCode == "000000")
        {
        	
            var retnums = packet.data.findValueByName("retnums");
            var retname = packet.data.findValueByName("retname");
            
/*
            if (retnums == 1) { //ֻ��һ����Ʒ���Ե�ʱ�򣬲���Ҫ�û�ѡ��
                document.frm.product_attr.value = retname;
                document.frm.ProdAttrQuery.disabled = true;
            }
            else if (retnums > 1) {
                document.frm.product_attr.value = "";
                document.frm.ProdAttrQuery.disabled = false;
            }
  */       }
        else
        {
                rdShowMessageDialog("��ѯ��Ʒ���Գ���,�����»�ȡ��",0);
				return false;
        }
    }
    //rendi���ֻ��EC���Ű�������ע��ҵ��
    if(retType == "ProdAttr")
    {
    	var OwnerType=packet.data.findValueByName("OwnerType");
    	document.all.OwnerType.value=OwnerType;
    	if(OwnerType!="04")
    	{
    		if((document.frm.sm_code.value=="YM"))
    		{
    			rdShowMessageDialog("ֻ��EC�����ܰ�������ע��ҵ��",0);
    			if(<%=nextFlag%>==1){
                	document.frm.next.disabled = true;
                }
				return false;
    		}
    	}
	}
	//ȡ��ˮ
	if(retType == "getSysAccept")
     {
        if(retCode == "000000")
        {
            var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.login_accept.value=sysAccept;

			var prtFlag=0;
		var confirmFlag=0;

		/*prtFlag = rdShowConfirmDialog("�Ƿ��ӡ���������");
        //�ύ��ӡ����
	
		GPARM32_0, in_phone_no        �ֻ�����
        GPARM32_1, in_cust_name       �ͻ�����
        GPARM32_2, in_id_iccid        �ͻ�֤��
        GPARM32_3, in_product_name    ��Ʒ����
        GPARM32_4, in_op_code         ��������
        GPARM32_5, in_login_no        ��������
        GPARM32_6, in_op_fee          ��ȡ����
        GPARM32_7, in_content_str     ��ӡ����
        GPARM32_8, in_attention_str   ע������
        
        if (prtFlag==1) {

			var printPage="/page/s3500/sGrpPubPrint.jsp?op_code=3500"
														+"&phone_no=" +document.all.grp_userno.value       
														+"&function_name=���Ų�Ʒ����"   
														+"&work_no="+"<%=workno%>"        
														+"&cust_name="+document.all.cust_name.value     
														+"&login_accept="+document.all.login_accept.value 
														+"&idIccid=" +document.all.iccid.value       
														+"&hand_fee=" +document.all.real_handfee.value        
														+"&mode_name="+document.all.product_code.value       
														+"&custAddress="+document.all.cust_address.value     
														+"&system_note="+document.all.sysnote.value     
														+"&op_note="+document.all.tonote.value          
														+"&space="           
														+"&copynote="
														+"&work_name="+"<%=workname%>"
														+"&pay_type="+document.all.payType.options[document.all.payType.selectedIndex].text;

		   var printPage = window.open(printPage,"","width=200,height=200")
		   
	    } 
	    */
		confirmFlag = rdShowConfirmDialog("�Ƿ��ύ���β�����");

			if (confirmFlag==1) {
			 //����ӡ��Ҫ����Ӧ����
				spellList();
				
				frm.action="s3500_2.jsp";
				frm.submit();
			}
         }
        else
        {
                rdShowMessageDialog("��ѯ��ˮ����,�����»�ȡ��",0);
				return false;
        }
    }
	if(retType == "getCheckInfo")
	{   //�õ�֧Ʊ��Ϣ
        var obj = "checkShow"; 
        if(retCode=="000000")
    	{
            var bankCode = packet.data.findValueByName("bankCode");
            var bankName = packet.data.findValueByName("bankName");
            var checkPrePay = packet.data.findValueByName("checkPrePay");
            if(checkPrePay == "0.00"){
                frm.bankCode.value = "";
                frm.bankName.value = "";                
                frm.checkNo.focus();
                document.all(obj).style.display = "none";
                rdShowMessageDialog("��֧Ʊ���ʻ����Ϊ0��");
            }
            else {   
					document.all(obj).style.display = "";            
			        frm.bankCode.value = bankCode;
					frm.bankName.value = bankName;
		            frm.checkPrePay.value = checkPrePay;
					if(frm.real_handfee.value==''){
						frm.checkPay.value='0.00';
					}
					else
					{
					    frm.checkPay.value = frm.real_handfee.value;//add
					}
			}
		}
    	else
    	{
    		frm.checkNo.value = "";
            frm.bankCode.value = "";
            frm.bankName.value = "";
            document.all(obj).style.display = "none"; 
            frm.checkNo.focus();
    	    retMessage = retMessage + "[errorCode9:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);               		
			return false;
    	}	
	}
	if(retType == "custaddress")//add
	{   //�õ��ͻ���ַ 
        if(retCode == "0")
        {
            var custAddress = packet.data.findValueByName("custAddress");
            if (custAddress == "false") {
    	    	rdShowMessageDialog("��ȡ�ͻ���ַʧ�ܣ�",0);
    	    	return false;	        	
            } else {
                document.frm.cust_address.value = custAddress;
            }
         }
        else
        {
            rdShowMessageDialog("��ȡ�ͻ���ַʧ�ܣ������»�ȡ��",0);
    		return false;
        }
	}
	if(retType == "query_channelid")/////////////
	{   //�õ�query_channelid
        if(retCode == "0")
        {
            var channel_name = packet.data.findValueByName("channel_name");

			var channel_id = packet.data.findValueByName("channel_id");
			//alert(channel_id);
            if (channel_id == "false"){
    	    	rdShowMessageDialog("��ȡchannelidʧ�ܣ�",0);
    	    	return false;
            } else {
                document.frm.channel_id.value = channel_id;
            }
         }
        else
        {
            rdShowMessageDialog("��ȡchannelidʧ�ܣ������»�ȡ��",0);
    		return false;
        }
	}
	
	//shengzd added for TD-���� @ 20090525
	if(retType == "getUserInfo1")
	{
		var flag = packet.data.findValueByName("flag");
		
		if(flag =="0")
		{
 			rdShowMessageDialog(retMessage,1);
			return false;
		}
		 document.frm.checkPhone_alert.value="1";
	}
	
	if(retType == "getUserInfo3")
	{
		var flag = packet.data.findValueByName("flag");

		if(flag =="0")
		{
 			rdShowMessageDialog(retMessage,1);
			return false;
		}
		 document.frm.checkPhone_3G.value="1";
	}
	
		if(retType == "getUserInfo2")
	{
		var flag = packet.data.findValueByName("flag");
		
		if(flag =="0")
		{
 			rdShowMessageDialog(retMessage,1);
			return false;
		}
		 document.frm.checkPhone_2G.value="1";
	}
}

function check_HidPwd()
{
    var cust_id = document.all.cust_id.value;
    var Pwd1 = document.all.custPwd.value;
    var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd");
		checkPwd_Packet.data.add("cust_id",cust_id);
		checkPwd_Packet.data.add("Pwd1",Pwd1);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet = null;
}

function getAccountId()
{
		//query_custaddress();//�õ��ͻ���ַ
		//�õ��ʻ�ID
    var getAccountId_Packet = new AJAXPacket("../s3500/f1100_getId.jsp","���ڻ���ʻ�ID�����Ժ�......");
		getAccountId_Packet.data.add("region_code","<%=regionCode%>");
		getAccountId_Packet.data.add("retType","AccountId");
		getAccountId_Packet.data.add("idType","1");
		getAccountId_Packet.data.add("oldId","0");
		core.ajax.sendPacket(getAccountId_Packet); 
		getAccountId_Packet = null;
}

//�õ������û����user_no
function getGrpUserNo()
{
    var sm_code = document.frm.sm_code.value;

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��",0);
        return false;
    }

    var getgrp_Userno_Packet = new AJAXPacket("getGrpUserno.jsp","���ڻ�ü��Ų�Ʒ��ţ����Ժ�......");
    getgrp_Userno_Packet.data.add("retType","GrpNo");
    getgrp_Userno_Packet.data.add("orgCode","<%=org_code%>");
    getgrp_Userno_Packet.data.add("smCode",sm_code);
    core.ajax.sendPacket(getgrp_Userno_Packet);
    getgrp_Userno_Packet = null;
}

function getGrpId()
{
    //�õ������������û�����
    var getgrp_no_Packet = new AJAXPacket("../s3500/getGrpId.jsp","���ڻ�ü��Ŵ��룬���Ժ�......");
    getgrp_no_Packet.data.add("retType","GrpId");
    getgrp_no_Packet.data.add("orgCode","<%=org_code%>");
    core.ajax.sendPacket(getgrp_no_Packet);
    getgrp_no_Packet=null;
}

function getUserId()
{
    //�õ������û�ID���͸����û�IDһ��
    var getUserId_Packet = new AJAXPacket("../s3500/f1100_getId.jsp","���ڻ���û�ID�����Ժ�......");
	getUserId_Packet.data.add("region_code","<%=regionCode%>");
	getUserId_Packet.data.add("retType","UserId");
	getUserId_Packet.data.add("idType","1");
	getUserId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getUserId_Packet);
	getUserId_Packet = null;
}
 //��һ��
function nextStep()
{
	
	
  var checkContract = new AJAXPacket("f3500_checkContract.jsp","���ڼ���û���Ϣ�����Ժ�......");
	checkContract.data.add("retType","checkContract");
	checkContract.data.add("sm_code",document.all.sm_code.value);
	checkContract.data.add("cust_id",document.all.cust_id.value);
	core.ajax.sendPacket(checkContract);
	checkContract = null;

/*
	frm.action="s3500_1.jsp?action=select";
	frm.method="post";
	frm.submit();
*/
}
//��һ��
function previouStep(){
	frm.action="s3500_1.jsp";
	frm.method="post";
	frm.submit();
}
//��ѯ�ͻ���ַ
function query_custaddress()
{
			if(document.frm.cust_id.value == "")
			{
				return false;
			}

			    var getInfoPacket = new AJAXPacket("s3500_custaddress.jsp","���ڲ�ѯ�ͻ���ַ�����Ժ�......");
				getInfoPacket.data.add("retType","custaddress");
				getInfoPacket.data.add("cust_id",document.frm.cust_id.value);
				core.ajax.sendPacket(getInfoPacket);
				getInfoPacket = null;
}
//��ѯchannel_id
function query_channelid()
{
			    var getInfoPacket = new AJAXPacket("s3500_channelid.jsp","���ڲ�ѯ�����Ժ�......");
				getInfoPacket.data.add("retType","query_channelid");
				getInfoPacket.data.add("org_code","<%=org_code%>");
				getInfoPacket.data.add("town_code",document.frm.town_code.value);
				core.ajax.sendPacket(getInfoPacket);
				getInfoPacket=null;
}
//���ù������棬���м����ʻ�ѡ��
function getInfo_Acct()
{
    var pageTitle = "�����ʻ�ѡ��";
    var fieldName = "���Ų�ƷID|���Ų�Ʒ����|��Ʒ����|�����ʺ�|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "4|0|1|2|3|";
    var retToField = "tmp1|tmp2|tmp3|account_id|"; //����ֻ��Ҫ�����ʺ�
    var cust_id = document.frm.cust_id.value;

    if(document.frm.cust_id.value == "")
    {
        rdShowMessageDialog("����ѡ���ſͻ������ܽ��м����ʻ���ѯ��");
        document.frm.iccid.focus();
        return false;
    }

    if(PubSimpSelAcct(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelAcct(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s3500/fpubcustacct_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&cust_id=" + document.all.cust_id.value;

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

    document.frm.accountQuery.disabled = false;

	return true;
}

function getvalueacct(retInfo)
{
  var retToField = "tmp1|tmp2|tmp3|account_id|";;
  if(retInfo ==undefined)      
    {   return false;   }

	var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
}

//���ù������棬���м��ſͻ�ѡ��
function getInfo_Cust()
{
    var pageTitle = "���ſͻ�ѡ��";
    /**add by liwd 20081127,group_id����dcustDoc��group_id
     **var fieldName = "֤������|�ͻ�ID|�ͻ�����|����ID|��������|������|";
     **var sqlStr = "";
     **var selType = "S";    //'S'��ѡ��'M'��ѡ
     **var retQuence = "6|0|1|2|3|4|5|";
     **var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|";
    **/ 
    var fieldName = "֤������|�ͻ�ID|�ͻ�����|����ID|��������|������|������֯|";
		var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|2|3|4|5|6|";
    var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|group_id|";
    /**add by liwd 20081127,group_id����dcustDoc��group_id end **/
    var cust_id = document.frm.cust_id.value;

    if(document.frm.iccid.value == "" &&
       document.frm.cust_id.value == "" &&
       document.frm.unit_id.value == "")
    {
        rdShowMessageDialog("���������֤�š��ͻ�ID����ID���в�ѯ��");
        document.frm.iccid.focus();
        return false;
    }

    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("���������֣�");
    	return false;
    }

    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
        rdShowMessageDialog("���������֣�");
    	return false;
    }

    if(PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s3500/fpubcust_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
    path = path + "&cust_id=" + document.all.cust_id.value;
    path = path + "&unit_id=" + document.all.unit_id.value;
    path = path + "&regionCode=" + document.frm.OrgCode.value.substr(0,2);

    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
  /*add by liwd 20081127,group_id����dcustDoc��group_id
   **var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|";;
  **/
  var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|group_id|";
  /**add by liwd 20081127,group_id����dcustDoc��group_id end **/
  if(retInfo ==undefined)      
    {   return false;   }

	var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	document.all.grp_name.value = document.all.unit_name.value;
	query_custaddress();///////////////add
}

//���ݿͻ�ID��ѯ�ͻ���Ϣ
function getInfo_CustId()
{
    var cust_id = document.frm.cust_id.value;

    //���ݿͻ�ID�õ������Ϣ
    if(document.frm.cust_id.value == "")
    {
        rdShowMessageDialog("������ͻ�ID��");
        return false;
    }
    if(for0_9(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("�ͻ�ID���������֣�");
    	return false;
    }

    var getInfoPacket = new AJAXPacket("f1902_Infoqry.jsp","���ڻ�ü��ſͻ���Ϣ�����Ժ�......");
        var cust_id = document.frm.cust_id.value;
        getInfoPacket.data.add("region_code","<%=regionCode%>");
        getInfoPacket.data.add("retType","GrpCustInfo");
        getInfoPacket.data.add("cust_id",cust_id);
        core.ajax.sendPacket(getInfoPacket);
        getInfoPacket=null;
}

//���ݿͻ�ID��ѯ�ͻ���Ϣ
function getInfo_UnitId()
{
    var cust_id = document.frm.cust_id.value;
    var unit_id = document.frm.unit_id.value;

    //���ݿͻ�ID�õ������Ϣ
    if(document.frm.cust_id.value == "")
    {
        rdShowMessageDialog("���������뼯�ſͻ�ID��");
        return false;
    }
    if(for0_9(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("���ſͻ�ID���������֣�");
    	return false;
    }
    if(document.frm.unit_id.value == "")
    {
        rdShowMessageDialog("���������뼯��ID��");
        return false;
    }
    if(for0_9(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
        rdShowMessageDialog("����ID���������֣�");
    	return false;
    }

    var getInfoPacket = new AJAXPacket("f1902_Infoqry.jsp","���ڻ�ü��ſͻ���Ϣ�����Ժ�......");
        var cust_id = document.frm.cust_id.value;
        getInfoPacket.data.add("region_code","<%=regionCode%>");
        getInfoPacket.data.add("retType","UnitInfo");
        getInfoPacket.data.add("cust_id",cust_id);
        getInfoPacket.data.add("unit_id",unit_id);
        core.ajax.sendPacket(getInfoPacket);
        getInfoPacket=null;
}

//��ѯ��Ʒ����
function query_prodAttr()
{
    var sm_code = document.frm.sm_code.options[document.frm.sm_code.selectedIndex].value;
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ�����Ʒ�ƣ�");
        return false;
    }
    
    var getInfoPacket = new AJAXPacket("fpubprodattr_qry.jsp","���ڲ�ѯ��Ʒ���Դ��룬���Ժ�......");
        getInfoPacket.data.add("retType","ProdAttr");
        getInfoPacket.data.add("sm_code",sm_code);
        getInfoPacket.data.add("cust_id",document.all.cust_id.value);
        core.ajax.sendPacket(getInfoPacket);
        getInfoPacket=null;
}

//���ù������棬���в�Ʒ����ѡ��
function getInfo_ProdAttr(defFlag)
{
    var pageTitle = "��Ʒ����ѡ��";
    var fieldName = "��Ʒ���Դ���|��Ʒ����|";
		var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "1|0|";
    var retToField = "product_attr|";

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��");
        return false;
    }

    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField, defFlag));
}
//��ѯ֧Ʊ����
function getBankCode()
{ 
  	//���ù���js�õ����д���
    if((frm.checkNo.value).trim() == "")
    {
        rdShowMessageDialog("������֧Ʊ���룡");
        frm.checkNo.focus();
        return false;
    }
    var getCheckInfo_Packet = new AJAXPacket("getBankCode.jsp","���ڻ��֧Ʊ�����Ϣ�����Ժ�......");
	getCheckInfo_Packet.data.add("retType","getCheckInfo");
    getCheckInfo_Packet.data.add("checkNo",document.frm.checkNo.value);
	core.ajax.sendPacket(getCheckInfo_Packet);
	getCheckInfo_Packet = null;     
 }
 
 function getSi()
{ 
  	//���ù���js�õ����д���
    if((frm.pay_si.value).trim() == "")
    {
        rdShowMessageDialog("���������Si��");
        frm.pay_si.focus();
        return false;
    }
    var path = "<%=request.getContextPath()%>/npage/s3500/getSi.jsp";    
    path = path + "?pay_si=" + document.frm.pay_si.value;

  retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
      
 }
function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField, defFlag)
{
    var path = "<%=request.getContextPath()%>/npage/s3500/fpubprodattr_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&groupFlag=Y";
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&defFlag=" + defFlag; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

function getvalueProdAttr(retInfo)
{
//alert(retInfo);
  var retToField = "product_attr|";
  if(retInfo ==undefined)      
    {   return false;   }
    
    chPos_retInfo = retInfo.indexOf("|");
    
    var valueStr = retInfo.substring(0,chPos_retInfo);
    document.frm.product_attr.value= valueStr;
 
    retInfo = retInfo.substring(chPos_retInfo + 1);
    
    chPos_retInfo = retInfo.indexOf("|");
		
    valueStr = retInfo.substring(0,chPos_retInfo);
   
    document.frm.product_attr_hidden.value=valueStr;
		


/*
	var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
    */
    document.frm.product_code.value = "";
    document.frm.product_append.value = "";
}
function changeTownCode(){
   document.all.town_name.value="";
}
function getTownCode()
{
    var pageTitle = "�����̲�ѯ";
    var fieldName = "�����̴���|����������|";
	var sqlStr="SELECT a.town_code,a.town_name"
           +"  FROM sTownCode a,sAgType b"
           +" WHERE a.region_code   = substr('"+document.all.OrgCode.value+"',1,2)"
           +"   AND a.region_code   = b.region_code"
           +"   AND a.district_code = substr('"+document.all.OrgCode.value+"',3,2)"
           +"   AND a.innet_type    = b.agent_type "
           +"   AND b.agent_flag    = 'Y' and rownum<290";
    if(document.all.town_code.value != "")
    {
        sqlStr = sqlStr + " and town_code like '" + document.all.town_code.value + "%'";
    }
    sqlStr = sqlStr + " order by town_code" ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "town_code|town_name|";
    PubSimpSel2(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}
function PubSimpSel2(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{

    var path = "/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
    if(typeof(retInfo)=="undefined")      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	//��ѯchannel_id
	query_channelid();

}

//���ù������棬���в�Ʒ��Ϣѡ��
function getInfo_Prod()
{
    var pageTitle = "���Ų�Ʒѡ��";
    var fieldName = "��Ʒ����|��Ʒ����|�Ƿ��������|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "product_code|product_name|";

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��");
        return false;
    }
    //�����ж��Ƿ��Ѿ�ѡ���˲�Ʒ����
    /*if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�",0);
        return false;
    }*/

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s3500/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
    path = path + "&product_attr=" + document.all.product_attr.value; 

    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	
	return true;
}

function getvalue(retInfo, retInfoDetail)
{

  var retToField = "product_code|product_name|";
  if(retInfo ==undefined)      
    {   return false;   }

  document.all.product_code.value = retInfo;
  document.frm.product_prices.value = retInfoDetail;
  //alert(document.all.product_code.value);
  //alert(document.frm.product_prices.value);
  var classValue=retInfo.split("|")[0];
  getMidPrompt("10442",codeChg(classValue),"ipTd");
}

//���Ÿ��Ӳ�Ʒѡ��
function getInfo_ProdAppend()
{
    var pageTitle = "���Ÿ��Ӳ�Ʒѡ��";
    var fieldName = "��Ʒ����|��Ʒ����|";
	var sqlStr = "";
    var selType = "M";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "product_append|product_name|";
    var product_code = document.frm.product_code.value;

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��");
        return false;
    }
    //�����ж��Ƿ��Ѿ�ѡ���˲�Ʒ����
    /*if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�",0);
        return false;
    }*/
    //�����ж��Ƿ��Ѿ������˼��Ų�Ʒ
    if(document.frm.product_code.value == "")
    {
        rdShowMessageDialog("������ѡ���Ų�Ʒ��");
        return false;
    }

    if(PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var product_code = document.all.product_code.value;
    var chPos = product_code.indexOf("|");
    product_code = product_code.substring(0,chPos);
    var path = "<%=request.getContextPath()%>/npage/s3500/fpubprodappend_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&showType=" + "Default";
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&product_code=" + product_code; 

    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalueProdAppend(retInfo)
{
  var retToField = "product_append|product_name|";
  if(retInfo ==undefined)      
    {   return false;   }

  document.all.product_append.value = retInfo;          
  var classValue=retInfo.split("|")[0];              
  //alert(classValue);                               
  getMidPrompt("10442",codeChg(classValue),"ipTd1");
} 
  
function checkPwd(obj1,obj2)
{
        //����һ����У��,����У��
        var pwd1 = obj1.value;
        var pwd2 = obj2.value;
        if(pwd1 != pwd2)
        {
                var message = "'" + obj1.v_name + "'��'" + obj2.v_name + "'��һ�£����������룡";
                rdShowMessageDialog(message,0);
                if(obj1.type != "hidden")
                {   obj1.value = "";    }
                if(obj2.type != "hidden")
                {   obj2.value = "";    }
                obj1.focus();
                return false;
        }
        return true;
}
//����Ʒ�Ʊ���¼�
function changeSmCode() {
    document.frm.product_attr.value = "";
	document.frm.product_code.value = "";
    document.frm.product_append.value = "";
    document.frm.grp_userno.value = "";
    document.frm.getGrpNo.disabled = false;
    query_prodAttr();
}

//��Ʒ���Ա���¼�
function changeProdAttr() {
	document.frm.product_code.value = "";
    document.frm.product_append.value = "";
}

//��Ʒ����¼�
function changeProduct() {
    document.frm.product_append.value = "";
}

function changeOpenType()
{
	if (document.frm.grp_userno.value != "")
	{
		document.frm.grp_userno.value =  document.frm.openType.value
		                               + document.frm.grp_userno.value(2, document.frm.grp_userno.value.length);
	}
}

function dateCompare(sDate1,sDate2){
	
	if(sDate1>sDate2)	//sDate1 ���� sDate2
		return 1;
	if(sDate1==sDate2)	//sDate1��sDate2 Ϊͬһ��
		return 0;
	return -1;		//sDate1 ���� sDate2
}

function refMain(){
	getAfterPrompt();
//У�鶯̬���ɵ��ֶ�
	if(!checkDynaFieldValues(false))
			return false;
    var checkFlag; //ע��javascript��JSP�ж���ı���Ҳ������ͬ,���������ҳ����.

    //˵��:���ֳ�����,һ���������Ƿ��ǿ�,��һ���������Ƿ�Ϸ�.
    if(check(frm))
    {
        if(  document.frm.grp_name.value == "" ){
            rdShowMessageDialog("��������:"+document.frm.grp_name.value+",��������!!");
            document.frm.grp_name.select();
            return false;
        }
        if(  document.frm.grp_id.value == "" ){
            rdShowMessageDialog("���Ŵ����������!!");
            document.frm.grp_id.select();
            return false;
        }
        
        //2.ת��ҵ����ʼ���ں�ҵ��������ڵ�YYYYMMDD---->YYYY-MM-DD
		checkFlag = isValidYYYYMMDD(document.frm.srv_start.value);
        if(checkFlag < 0){
            rdShowMessageDialog("ҵ����ʼ����:"+document.frm.srv_start.value+",���ڲ��Ϸ�!!");
            document.frm.srv_start.select();
            return false;
        }
        checkFlag = isValidYYYYMMDD(document.frm.srv_stop.value);
        if(checkFlag < 0){
            rdShowMessageDialog("ҵ���������:"+document.frm.srv_stop.value+",���ڲ��Ϸ�!!");
            document.frm.srv_stop.select();
            return false;
        }
        //ҵ����ʼ���ں�ҵ��������ڵ�ʱ��Ƚ�
        checkFlag = dateCompare(document.frm.srv_start.value,document.frm.srv_stop.value);
        if( checkFlag == 1 ){
            rdShowMessageDialog("ҵ���������Ӧ�ô���ҵ����ʼ����!!");
            document.frm.srv_stop.select();
            return false;
        }
        
		//��������У��
		if(((document.all.user_passwd.value).trim()).length>0)
        {
            if(document.all.user_passwd.value.length!=6)
            {
                rdShowMessageDialog("�û����볤������");
                document.all.user_passwd.focus();
                return false;
             }
             if(checkPwd(document.frm.user_passwd,document.frm.account_passwd)==false)
                return false;
        }
        else
        {
            rdShowMessageDialog("�û����벻��Ϊ�գ�");
            document.all.user_passwd.focus();
            return false;
        }
        
	   	//if(document.frm.town_code.value == "" ){
        //  rdShowMessageDialog("�����̱�������!!");
        //  document.frm.town_code.focus();
        //  return false;
        // }
		//�ж�real_handfee
		if(!checkElement(document.frm.real_handfee)) return false;
        if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
        {
				rdShowMessageDialog("ʵ�������Ѳ�Ӧ����Ӧ��������");
				document.frm.real_handfee.focus();
				return false;	
        }
		if (parseFloat(document.frm.checkPay.value)!=parseFloat(document.frm.real_handfee.value))
        {
				rdShowMessageDialog("֧Ʊ����Ӧ����ʵ��������");
				document.frm.checkPay.focus();
				return false;	
        }
		if (parseFloat(document.frm.checkPay.value)>parseFloat(document.frm.checkPrePay.value))
        {
				rdShowMessageDialog("֧Ʊ����ӦС��֧Ʊ���");
				document.frm.checkPay.focus();
				return false;	
        }
		if (parseFloat(document.frm.should_handfee.value)==0)
		{
			document.frm.real_handfee.value="0.00";
		}
		//add by lilm for M2M

		if(document.frm.sm_code.value=="MM")
		{
			if(document.all.F10340.value=="01")
			{
				if(document.all.F10341.value.trim()=="")
				{
					rdShowMessageDialog("ר��APN��APNֵ����Ϊ��!!");
					document.all.F10341.select();
		            return false;
				}
			}
		}
		
		//Add by shengzd @ 20090520
		//��TD-���񱦿�������¼���ֵ������Ч���ж�
		if(document.frm.sm_code.value=="SW")
		{
			
			if(document.all.F10343.value.trim()==document.all.F10345.value.trim()&&document.all.F10343.value.trim()!=""&&document.all.F10345.value.trim()!="")
				{
					rdShowMessageDialog("3G�����Ԥ�����벻������ͬ!");
					document.all.F10343.select();
		      return false;
				}
			if(document.all.F10342.value=="01")
			{
				if(document.all.F10343.value.trim()==document.all.F10344.value.trim()&&document.all.F10343.value.trim()!=""&&document.all.F10344.value.trim()!="")
				{
					rdShowMessageDialog("3G�����2G���벻������ͬ!");
					document.all.F10343.select();
		      return false;
				}
				
				if(document.all.F10344.value.trim()==document.all.F10345.value.trim()&&document.all.F10344.value.trim()!=""&&document.all.F10345.value.trim()!="")
				{
					rdShowMessageDialog("2G�����Ԥ�����벻������ͬ!");
					document.all.F10343.select();
		      return false;
				}
				if(document.all.F10343.value.trim()=="")
				{
					rdShowMessageDialog("3G���벻��Ϊ��!");
					document.all.F10343.select();
		      return false;
				}//�ж�3G�����Ƿ�Ϊ��
				else{
					var getUserInfo_packet3 = new AJAXPacket("getUserInfo.jsp", "�����ύ�����Ժ�......");
					getUserInfo_packet3.data.add("sqlStr_flag","3");
					getUserInfo_packet3.data.add("retType","getUserInfo3");
   	 			getUserInfo_packet3.data.add("phoneNo_3G", document.all.F10343.value.trim());
 	  		 	core.ajax.sendPacket(getUserInfo_packet3);
  	  		getUserInfo_packet3=null;
    
    			if(document.frm.checkPhone_3G.value=="0"){
    				return false;
 		  		}
 		    }//У���Ƿ�����Ч��3G����

				if(document.all.F10344.value.trim()=="")
				{
					rdShowMessageDialog("2G������Ϊ�գ�!");
					document.all.F10344.select();
		      return false;
				}//�ж�2G�����Ƿ�Ϊ��
				else{
					var getUserInfo_packet2 = new AJAXPacket("getUserInfo.jsp", "�����ύ�����Ժ�......");
					getUserInfo_packet2.data.add("sqlStr_flag","2");
					getUserInfo_packet2.data.add("retType","getUserInfo2");
   	 			getUserInfo_packet2.data.add("phoneNo_2G", document.all.F10344.value.trim());
 	  		 	core.ajax.sendPacket(getUserInfo_packet2);
  	  		getUserInfo_packet2=null;
    
    			if(document.frm.checkPhone_2G.value=="0"){
    				return false;
 		  		}
 		    }//�ж�2G�����Ƿ��������û�����״̬����

				if(document.all.F10345.value.trim()=="")
				{
					rdShowMessageDialog("Ԥ�����벻��Ϊ��!!");
					document.all.F10345.select();
		      return false;
				}//�ж�Ԥ�������Ƿ�Ϊ��
				else{
					var getUserInfo_packet1 = new AJAXPacket("getUserInfo.jsp", "�����ύ�����Ժ�......");
					getUserInfo_packet1.data.add("sqlStr_flag","1");
					getUserInfo_packet1.data.add("retType","getUserInfo1");
   	 			getUserInfo_packet1.data.add("phoneNo_alert", document.all.F10345.value.trim());
 	  		 	core.ajax.sendPacket(getUserInfo_packet1);
  	  		getUserInfo_packet1=null;
    
    			if(document.frm.checkPhone_alert.value=="0"){
    				return false;
 		  		}
 		    }//�ж�Ԥ�������Ƿ��������û�����״̬����
			}
			else{
				
				if(document.all.F10343.value.trim()=="")
				{
					rdShowMessageDialog("3G���벻��Ϊ��!!");
					document.all.F10343.select();
		      return false;
				}else{
					var getUserInfo_packet3= new AJAXPacket("getUserInfo.jsp", "�����ύ�����Ժ�......");
					getUserInfo_packet3.data.add("sqlStr_flag","3");
					getUserInfo_packet3.data.add("retType","getUserInfo3");		
   	 			getUserInfo_packet3.data.add("phoneNo_3G", document.all.F10343.value.trim());
 	  		 	core.ajax.sendPacket(getUserInfo_packet3);
  	  		getUserInfo_packet3=null;
    
    			if(document.frm.checkPhone_3G.value=="0"){
    				return false;
 		  		 }
 		    }
				
				if(document.all.F10345.value.trim()=="")
				{
					rdShowMessageDialog("Ԥ�����벻��Ϊ��!!");
					document.all.F10345.select();
		      return false;
				}else{
					var getUserInfo_packet1= new AJAXPacket("getUserInfo.jsp", "�����ύ�����Ժ�......");
					getUserInfo_packet1.data.add("sqlStr_flag","1");
					getUserInfo_packet1.data.add("retType","getUserInfo1");		
   	 			getUserInfo_packet1.data.add("phoneNo_alert", document.all.F10345.value.trim());
 	  		 	core.ajax.sendPacket(getUserInfo_packet1);
  	  		getUserInfo_packet1=null;
    
    			if(document.frm.checkPhone_alert.value=="0"){
    				return false;
 		  		 }
 		    }
		 }
	}
		
	 	 //add by rendi for ����ע��
		 //ҵ����ʼ���ں�ҵ��������ڵ�ʱ��Ƚ�
		 if(document.frm.sm_code.value=="YM")
		 {
	        checkFlag = dateCompare(document.frm.srv_start.value,document.frm.F10336.value);
	        if( checkFlag == 1 ){
	            rdShowMessageDialog("������Ч����Ӧ�ô���ҵ����ʼ����!!");
	            document.frm.F10336.select();
	            return false;
	        }
	        var YMtmp=document.all.F10335.value;
	        if((YMtmp.trim()).length==0||(YMtmp.trim()).length==3)
	        {
	        	rdShowMessageDialog("��������Ϊ�ջ�ֻ��.cn!!");
	            document.frm.F10335.select();
	            return false;
	        }
	        if(YMtmp.substring((YMtmp.trim()).length-3)!=".cn")
	        {
	        	rdShowMessageDialog("����������.cn��β!!");
	            document.frm.F10335.select();
	            return false;
	        }
    	}
        //���ڲ���̫�࣬��Ҫͨ��form��post����,���,��Ҫ����������ݸ��Ƶ���������. yl.
        document.frm.chgsrv_start.value = changeDateFormat(document.frm.srv_start.value);
        document.frm.chgsrv_stop.value  = changeDateFormat(document.frm.srv_stop.value);
        <%if(userType.equals("pe")) {%>
        document.frm.sysnote.value = "�ֻ����伯�Ų�Ʒ����"+document.frm.grp_userno.value;
        //document.frm.tonote.value = "�ֻ����伯�Ų�Ʒ����"+document.frm.grp_userno.value;
        <%}else{%>
        //document.frm.sysnote.value = "IDC���Ų�Ʒ����"+document.frm.grp_userno.value;
        //document.frm.tonote.value = "IDC���Ų�Ʒ����"+document.frm.grp_userno.value;
        document.frm.sysnote.value = "���Ų�Ʒ����:���ű��:"+document.frm.unit_id.value+" ��Ʒ:"+document.frm.product_code.value;
        //document.frm.tonote.value = "���Ų�Ʒ����:���ű��:"+document.frm.unit_id.value+" ��Ʒ:"+document.frm.product_code.value;

        <%}%>	
		getSysAccept();

		//��ѯ�ͻ���ַcust_address
		//query_custaddress();

    }
}
//��ӡ���
//ȡ��ˮ
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","�������ɲ�����ˮ�����Ժ�......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet = null;   
}
//ѡ��֧����ʽ
function changePayType(){
	if (document.all.checkPayTR.style.display==""){
		document.all.checkPayTR.style.display="none";
		document.all.cashPay_div.style.display="";
		
			if(document.frm.cashPay.value=='')
			{
			document.frm.sure.disabled = true;
			}
	}
	else {
		document.all.checkPayTR.style.display="";
		document.all.cashPay_div.style.display="none";
		document.frm.sure.disabled = false;
	}
}
 //����ܼƽ��
function getCashNum(){
	if(!checkDynaFieldValues(true)){//������������
		return false;
	}
	var retToField = "<%=numberList%>";
	var chPos_field = retToField.indexOf("|");
	var chPos_retStr;
	var valueStr;
	var obj;
	var temp;
	var addSub=0;
	while(chPos_field > -1)
	{
		obj = "F"+retToField.substring(0,chPos_field);
	   
		if(typeof(document.all(obj).length)=="undefined")
		{
			temp=document.all(obj).value;
			addSub=addSub+Number(temp); 
		}
		else{
			for(var n = 0 ; n < Number(eval(document.all(obj).length)) ; n++)
			{
				temp=eval("document.frm."+obj+"[n].value");
				addSub=addSub+Number(temp);
			}
		}
		
		retToField = retToField.substring(chPos_field + 1);
		chPos_field = retToField.indexOf("|");
	}    
	document.frm.cashNum.value=addSub;
}
function check_cashPay(){
			if(document.frm.cashNum.value==""){
				rdShowMessageDialog("���ѯ������!");
				return false;
			}
			var real_handfee = document.frm.real_handfee.value;
			var cashNum = document.frm.cashNum.value;
			if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
			{
					rdShowMessageDialog("ʵ�������Ѳ�Ӧ����Ӧ��������");
					document.frm.real_handfee.focus();
					return false;	
			}
			document.frm.cashPay.value=Math.round(real_handfee)+Math.round(cashNum);//�ܷ�
			rdShowMessageDialog("�������ɹ�!",2);
			document.frm.sure.disabled = false;
			
}
function closefields()//�����һ��ʱ���Ѿ���õ��ֶβ����޸�
{
				document.frm.custQuery.disabled=true;
				//document.frm.chkPass.disabled=true;
				document.frm.sm_code.disabled=true;

					
}

function ctrlF10340(selectId)
{
	var f10340txt = "";
	var f10341txt = "";
	if(selectId.value == "11")
	{
		f10340txt = "<select id='F10340' name='F10340' datatype=66 onchange='ctrlF10341(frm.F10340);'>";
		f10340txt = f10340txt + "<option  value='00'>00--��ר��APN</option>";
		f10340txt = f10340txt + "<option  value='01'>01--ר��APN</option>";
		f10340txt = f10340txt + "</select>";
		f10341txt = "<input id='F10341' name='F10341'  class='button' type='hidden' datatype=67  value='0'>&nbsp";
	}
	else
	{
		f10340txt = "<input id='F10340' name='F10340'  class='button' type='hidden' datatype=66  value='0'>&nbsp";
		f10341txt = "<input id='F10341' name='F10341'  class='button' type='hidden' datatype=67  value='0'>&nbsp";
	}
	divF10340.innerHTML=f10340txt;
	divF10341.innerHTML=f10341txt;
}


function ctrlF10341(selectId)
{
	var f10341txt = "";
	if(selectId.value == "01")
	{
		f10341txt = "<input id='F10341' name='F10341'  class='button' type='text' datatype=67  value=''>";
	}
	else
	{
		f10341txt = "<input id='F10341' name='F10341'  class='button' type='hidden' datatype=67  value='0'>&nbsp";
	}
	divF10341.innerHTML=f10341txt;
}

//TD-���񱦣�"ҵ������"���"2G����"�ı������������ 
//ADD by shengzd @ 20090519
function ctrlF10342(selectId)
{
	var f10342txt = "";
	if(selectId.value == "01")
	{
		f10342txt = "<input id='F10344' name='F10344'  class='button' type='text' datatype=72 maxlength=11 value=''>&nbsp"; //�����ص�"2G����"Ĭ��ֵΪ�� 
	}
	else
	{
		f10342txt = "<input id='F10344' name='F10344'  class='button' type='hidden' datatype=72 maxlength=11 value='0'>&nbsp";
	}
	divF10344.innerHTML=f10342txt;
}
</script>

<BODY>
<FORM action="" method="post" name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">������֤</div>
</div>
<input type="hidden" id=hidPwd name="hidPwd" v_name="ԭʼ����">
<input type="hidden" name="chgsrv_start" value="">
<input type="hidden" name="chgsrv_stop"  value="">
<input type="hidden" name="product_level"  value="1">
<input type="hidden" name="product_name"  value="">
<input type="hidden" name="belong_code"  value="<%=belong_code%>">
<input type="hidden" name="prod_appendname"  value="">
<input type="hidden" name="tfFlag" value="n">
<input type="hidden" name="chgpkg_day"   value="">
<input type="hidden" name="TCustId"  value="">
<input type="hidden" name="unit_name"  value="">
<input type="hidden" name="tmp1"  value="">
<input type="hidden" name="tmp2"  value="">
<input type="hidden" name="tmp3"  value="">
<input type="hidden" name="org_id"  value="<%=OrgId%>">
<!-- add by liwd 20081127,group_id����dcustdoc��group_id
<input type="hidden" name="group_id"  value="<%=GroupId%>">
-->
<input type="hidden" name="group_id"  value="<%=group_id%>">
<!--add by liwd 20081127,group_id����dcustDoc��group_id end -->
<input type="hidden" name="login_accept"  value="0"> <!-- ������ˮ��-->
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="bill_type"  value="0"> <!-- �������� -->
<input type="hidden" name="product_prices"  value="">
<input type="hidden" name="product_type"  value="">
<input type="hidden" name="service_code"  value="">
<input type="hidden" name="service_attr"  value="">
<input type="hidden" name="pay_no"  value="">
<input type="hidden" name="op_code"  value="3500">
<input type="hidden" name="OrgCode"  value="<%=org_code%>">
<input type="hidden" name="region_code"  value="<%=regionCode%>">
<input type="hidden" name="district_code"  value="<%=districtCode%>">
<input type="hidden" name="town_code1"  value="<%=townCode%>">
<input type="hidden" name="WorkNo"   value="<%=workno%>">
<input type="hidden" name="NoPass"   value="<%=nopass%>">
<input type="hidden" name="ip_Addr"  value=<%=ip_Addr%>>
<input type="hidden" name="cust_address"  value="<%=custAddress%>">
<input type="hidden" name="channel_id"  value="">
<input type="hidden" name="userType"  value="<%=userType%>">
<input name="srv_start" type="hidden" class="button" id="srv_start"  onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>" size="20" maxlength="8" v_must=1 v_type="date" v_name="ҵ����ʼ����">
<input name="srv_stop" type="hidden" class="button" id="srv_stop"  onKeyPress="return isKeyNumberdot(0)" value="<%=Date100%>" size="20" maxlength="8" v_must=1 v_type="date" v_name="ҵ���������" readonly>
<input name="credit_value" type="hidden" class="button" value="1000" id="credit_value" size="20" maxlength="6" v_must=0 v_type="string" v_name="���ö�">
<input name="credit_code" type="hidden" class="button" id="credit_code3" value="E" size="20" maxlength="2" v_must=0 v_type="string" v_name="���õȼ�">

        <TABLE cellSpacing=0>
          <TR>
            <TD class=blue>֤������</TD>
            <TD>
                <input name=iccid <%if(nextFlag==2)out.println("readonly");%> id="iccid" size="24" maxlength="20" v_type="string" v_must=1 index="1" value="<%=iccid%>">
                <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=��ѯ>
                <font class="orange">*</font>
            </TD>
            <TD class=blue>���ſͻ�ID</TD>
            <!--wuxy alter maxlength="12" 20080706-->
            <TD>
              <input type="text" <%if(nextFlag==2)out.println("readonly");%> name="cust_id" size="20" maxlength="12" v_type="0_9" v_must=1 v_name="�ͻ�ID" index="2" value="<%=cust_id%>">
              <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class=blue>���ű��</TD>
            <TD>
		    <input name=unit_id <%if(nextFlag==2)out.println("readonly");%> id="unit_id" size="24" maxlength="11" v_type="0_9" v_must=1 index="3" value="<%=unit_id%>">
            <font class="orange">*</font>
            </TD>
            <TD class=blue>���ſͻ�����</TD>
            <TD>
              <input name="cust_name" size="20" readonly v_must=1 v_type=string index="4" value="<%=cust_name%>">
              <font class="orange">*</font>
              </TD>
          </TR>
          <TR>
            <TD class=blue>���ſͻ�����</TD>
            <TD>
          <%if(!ProvinceRun.equals("20"))  //������Ǽ���
			  		{
					%>        
              <jsp:include page="/npage/common/pwd_1.jsp">
              <jsp:param name="width1" value="16%"  />
	            <jsp:param name="width2" value="34%"  />
	            <jsp:param name="pname" value="custPwd"  />
	            <jsp:param name="pwd" value="<%=123%>"  />
 	            </jsp:include>
 	       <%}else{%>
 	            <input name=custPwd value="" type="password" id="custPwd" size="6" maxlength="6" v_must=1>
         <%}%>   
         			<input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass2" value=У��>
            <font class="orange">*</font>
            </TD>
            <!--TD>��������ʡ���ţ�</TD>
            <TD-->
              <input class="InputGrey" type="hidden" name="province" size="20"  
			  <%
        try
        {
                sqlStr = "select AGENT_PROV_CODE from sprovinceCode where run_flag = 'Y'";
                //sqlStr = "select '16' from dual";
                //retArray = callView.sPubSelect("1",sqlStr);
            %>
            	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode15" retmsg="retMsg15"  outnum="1">
                	<wtc:sql><%=sqlStr%></wtc:sql>
                </wtc:pubselect>
                <wtc:array id="retArr15" scope="end" />
            <%
                //result = (String[][])retArray.get(0);
                if(retCode15.equals("000000")){
                    result = retArr15;
                }
                int recordNum = result.length;
                for(int i=0;i<recordNum;i++){
                    out.println("value='" + result[i][0] + "'");
                }
        }catch(Exception e){
                logger.error("��ѯ����ʡ����ʧ��!");
        }
%>
			  readonly v_must=1 v_type="0_9" index="11"> 
			<!--font class="orange">*</font>
            </TD-->
            <TD class=blue>����Ʒ��</TD>
            <TD>
			<%
			if(userType!=""){
			%>
			<select name="sm_code" id="sm_code"  onChange="changeSmCode()" v_must=1 v_type="string" index="10" >
			<%
			}else{
			%>
				<select name="sm_code" id="sm_code"  onChange="changeSmCode()" v_must=1 v_type="string" index="10" >
			<%}%>
<%
				try
				{
          //wuxy alter 20090824Ϊ��϶˵���ͬ�����ߣ������У�����3500�в�Ӧ�ó��ֵ�Ʒ��
					sqlStr = "select a.sm_code, a.sm_name"
							+"  from sSmCode a, sBusiTypeSmCode b"
							+" where a.sm_code = b.sm_code"
							+" and a.sm_code not in ('CR','AD','va','vp','ML','DL','MA') "
							+"   and b.busi_type = '1000'"
							+"   and a.region_code =:regionCode";
					//retArray = callView.sPubSelect("2",sqlStr);
					System.out.println("sqlStr:"+sqlStr);
                    paraIn[0] = sqlStr;    
                    paraIn[1]="regionCode="+regionCode;
            %>
                    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode16" retmsg="retMsg16" outnum="2" >
                    	<wtc:param value="<%=paraIn[0]%>"/>
                    	<wtc:param value="<%=paraIn[1]%>"/> 
                    </wtc:service>
                    <wtc:array id="retArr16" scope="end"/>
            <%					
					//result = (String[][])retArray.get(0);
					if(retCode16.equals("000000")){
					    result = retArr16;
					}
					int recordNum = result.length;
					for(int i=0;i<recordNum;i++)
					{
						if (userType.equals(result[i][0]))
						{
							out.println("<option class='button' value='" + result[i][0].trim() + "' selected>" + result[i][1] + "</option>");
						}
						else
						{
							out.println("<option class='button' value='" + result[i][0].trim() + "'>" + result[i][1] + "</option>");
						}
					}
				}catch(Exception e){
					logger.error("Call sunView is Failed!");
				}
%>
			<font class="orange">*</font>
			</select>
           </TD>
            <!--TD>������ʽ��</TD>
            <TD>
				<select name="openType" id="openType" onChange="changeOpenType()" v_must=1 v_type="string" v_name="������ʽ��" index="10">
					<option value='IDC'>IDCҵ�񿪻�</option>
				</select>
           </TD-->
          </TR>
	  </TABLE>
<!---- ���ص��б�-->
	<%
		//Ϊinclude�ļ��ṩ���� 
		int fieldCount=0;
		boolean isGroup = true;
		
		if (resultList != null)
		{
			fieldCount = resultList.length;
		}
		String []fieldCodes=new String[fieldCount];
		String []fieldNames=new String[fieldCount];
		String []fieldPurposes=new String[fieldCount];
		String []fieldValues=new String[fieldCount];
		String []dataTypes=new String[fieldCount];
		String []fieldLengths=new String[fieldCount];
		String []fieldGroupNo=new String[fieldCount];
		String []fieldGroupName=new String[fieldCount];
		String []fieldMaxRows=new String[fieldCount];
		String []fieldMinRows=new String[fieldCount];
		String []fieldCtrlInfos=new String[fieldCount];
		int iField=0;
		while(iField<fieldCount)
		{
			fieldCodes[iField]=resultList[iField][0];
			fieldNames[iField]=resultList[iField][1];
			fieldPurposes[iField]=resultList[iField][2];
			fieldValues[iField]="";
			dataTypes[iField]=resultList[iField][3];
			fieldLengths[iField]=resultList[iField][4];
			System.out.println("!@#$%^&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+fieldLengths[iField]);
			fieldGroupNo[iField]=resultList[iField][5];
			fieldGroupName[iField]=resultList[iField][6];
			fieldMaxRows[iField]=resultList[iField][7];
			fieldMinRows[iField]=resultList[iField][8];
			fieldCtrlInfos[iField]=resultList[iField][9];
			iField++;
		}
	%>
	<%@ include file="fpubDynaFields.jsp"%>

          <TR style="display:none">
            <TD class=blue>��Ʒ����</TD>
            <TD colspan="3">
              <input type="hidden" name="product_attr" value="<%=product_code%>"/>
              <input class="button" type="text" name="product_attr_hidden" size="20" readonly  onChange="changeProdAttr()" v_must=0 v_type="string" v_name="��Ʒ����" >
			               
              <input name="ProdAttrQuery" type="button" id="ProdAttrQuery"  class="button" onClick="getInfo_ProdAttr('0');" onClick="if(event.keyCode==13)getInfo_ProdAttr('0');" value="ѡ��">
			  <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class=blue>���Ų�Ʒ</TD>
            <TD id="ipTd">
              <input type="text" name="product_code" size="20" readonly onChange="changeProduct()" v_must=1 v_type="string" value="<%=product_code%>">
              <input name="prodQuery" type="button" id="ProdQuery"  class="b_text" onClick="getInfo_Prod();" onClick="if(event.keyCode==13)getInfo_Prod();" value="ѡ��">
			  <font class="orange">*</font>
            </TD>
            <TD class=blue>���Ÿ��Ӳ�Ʒ</TD>
            <TD id="ipTd1">
              <input type="text" name="product_append" size="20" readonly v_must=0 v_type="string" value="<%=product_append%>">
              <input name="ProdAppendQuery" type="button" id="ProdAppendQuery"  class="b_text" onClick="getInfo_ProdAppend();" onClick="if(event.keyCode==13)getInfo_ProdAppend();" value="ѡ��">
            </TD>
          </TR>
          <TR>
            <TD class=blue>���Ų�ƷID</TD>
            <TD>
              <input name="grp_id" type="text" size="20" maxlength="12" readonly v_type="0_9" v_must=1 value="<%=grp_id%>">
              <input name="grpQuery" type="button" id="grpQuery"  class="b_text" onClick="getUserId();" onClick="if(event.keyCode==13)getUserId();" value="��ȡ">
              <font class="orange">*</font>
            </TD>
            <TD class=blue>�û�����</TD>
            <TD>
              <input name="grp_name" type="text" size="20" maxlength="60" v_must=1 v_maxlength=60 v_type="string" value="<%=grp_name%>">
            <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class=blue>��Ʒ�ʻ�ID</TD>
            <TD colspan=3>
              <input name="account_id" type="text" size="20" maxlength="12" readonly v_type="0_9" v_must=1 value="<%=account_id%>">
              <input name="accountQuery" type="button" class="b_text" id="accountQuery" onClick="getAccountId();" onClick="if(event.keyCode==13)getAccountId();" value="��ȡ" >
              <font class="orange">*</font>
            </TD>

            <TD class=blue style="display:none">���Ų�Ʒ���</TD>
            <TD style="display:none">
              <input name="grp_userno" type="text" class="button" size="20" maxlength="12" readonly v_type="string" v_must=1 v_name="���Ų�Ʒ���" value="<%=grp_userno%>">
              <input name="getGrpNo" type="button" class="button" id="getGrpNo" onClick="getGrpUserNo();" onClick="if(event.keyCode==13)getGrpUserNo();" value="���">
              <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
           <%if(!ProvinceRun.equals("20"))  //���Ǽ���
			  		{
					%>  
			<jsp:include page="/npage/common/pwd_4.jsp">
				<jsp:param name="width1" value="18%"  />
				<jsp:param name="width2" value="32%"  />
				<jsp:param name="pname" value="user_passwd"  />
				<jsp:param name="pcname" value="account_passwd"  />
			</jsp:include>
			 <%}else{%>
			 <TD class=blue> 
			 	<div align="left">�ʻ�����</div>
			 </TD>
			 
			 <TD>
			 	<input name="user_passwd" type="password" class="button" maxlength=6 pwdlength="6">
			 </TD>
			 
			 <TD class=blue> 
			 	<div align="left">����У��</div>
			 </TD>
			 
			 <TD>
			 	<input  name="account_passwd" type="password" class="button" prefield="user_passwd" filedtype="pwd" maxlength=6 pwdlength=6>	
			 </TD>
			 <%}%> 
          </TR>
           <!--
          <TR bgcolor="E8E8E8">
            <TD width="18%">ҵ����ʼ���ڣ�</TD>
            <TD width="32%">
              <input name="srv_start" type="text" class="button" id="srv_start"  onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>" size="20" maxlength="8" v_must=1 v_type="date" v_name="ҵ����ʼ����"> <font class="orange">*</font>
            </TD>
            <TD width="18%">ҵ��������ڣ�</TD>
            <TD width="32%">
              <input name="srv_stop" type="text" class="button" id="srv_stop"  onKeyPress="return isKeyNumberdot(0)" value="<%=Date100%>" size="20" maxlength="8" v_must=1 v_type="date" v_name="ҵ���������" readonly> <font class="orange">*</font>
            </TD>
          </TR>
         
          <TR bgcolor="E8E8E8">
            <TD>���öȣ�</TD>
            <TD><input name="credit_value" type="text" class="button" value="1000" id="credit_value" size="20" maxlength="6" v_must=0 v_type="string" v_name="���ö�"> <font class="orange"></font>
            </TD>
            <TD>���õȼ���</TD>
            <TD><input name="credit_code" type="text" class="button" id="credit_code3" value="E" size="20" maxlength="2" v_must=0 v_type="string" v_name="���õȼ�"> <font class="orange"></font> </TD>
          </TR>
			
		   <TR bgcolor="E8E8E8">
			<TD>�����̣�</TD>
			<TD>
            <input type="text" name="town_code" class="button" maxlength="3" size="5" onChange="changeTownCode()" value="101">
            <input type="text" name="town_name" class="button" disabled value="��������">
            <input name="townCodeQuery" type="button" onClick="getTownCode()" value="��ѯ">
			</TD>
		   <TD></TD>
           <TD></TD>
          </TR>
          -->
		  <TR style="display:none">
		  <%
		    String handfee2 = "0.00";
				try{
					sqlStr = "select hand_fee from sNewFunction where function_Code ='3500'";
	                //retArray = callView.sPubSelect("1",sqlStr);
                %>
                	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode17" retmsg="retMsg17"  outnum="1">
                    	<wtc:sql><%=sqlStr%></wtc:sql>
                    </wtc:pubselect>
                    <wtc:array id="retArr17" scope="end" />
                <%
		            //result = (String[][])retArray.get(0);
		            if(retArr17.length>0 && retCode17.equals("000000")){
		                handfee2 = retArr17[0][0];
		            }
				}
				catch(Exception e){
					System.out.println("�����ѳ���!");
				}
			%>
				<%if(!userType.equals("pe")) {%>
				<TD width="18%">Ӧ��������</TD>
				<TD width="32%">
				<input class="InputGrey" name="should_handfee" id="should_handfee" value="<%=handfee2%>" readonly>
				</TD>
				<TD width="18%">ʵ��������</TD>
				<TD width="32%">
				<input class="button" name="real_handfee" id="real_handfee" value="0" v_must=0 v_type=money>
				</TD>
				<%}else{%>
				<input type="hidden" name="should_handfee" value="0">
				<input type="hidden" name="real_handfee" value="0">
				<%}%>
		   </TR>
			<TR>
				<TD class=blue>���ʽ</TD>
				<TD>
				    <select name='payType' onchange='changePayType()'>
					<option value='0'>�ֽ�</option>
					<option value='9'>֧Ʊ</option>
					</select>
					<font class="orange">&nbsp;*</font>
					</TD>
					<TD class=blue>һ���Ը�����</TD>
				<TD colspan="1">
				    <input name="cashNum" type="text" v_must=1 v_maxlength=8 v_type="string" index="8" value="" readOnly>
				<input name=cash_num type=button id="cash_num" class="b_text" onMouseUp="getCashNum();getGrpUserNo();" onKeyUp="if(event.keyCode==13)getCashNum();getGrpUserNo();" style="cursor��hand" value=��ѯ>
				<font class="orange">*</font>
				</TD>
			 </TR>
			  <tr id="cashPay_div" style="display:''">
           <td class=blue>�ֽ𽻿�</td>
            <td colspan=3>
			    <input type="text" name="cashPay" maxlength="10" readOnly value="">
				<input name="checkPass" id="next5" type="button" onClick="check_cashPay()" class="b_text" value="����У��">
				<font class="orange">*</font>
			</td>
         </tr>
           <TBODY>
             <TR id='checkPayTR'> 
                <TD class=blue nowrap> 
                   <div align="left">֧Ʊ����</div>
                </TD>
                <TD width="32%" nowrap> 
                    <input class="button" v_must=0 v_type="0_9" name=checkNo maxlength=20 onkeyup="if(event.keyCode==13)getBankCode();" index="50">
                    <font class="orange">*</font>
					<input name=bankCodeQuery type=button class="b_text" style="cursor:hand" onClick="getBankCode()" value=��ѯ>
				</TD>
                <TD class=blue nowrap> 
                    <div align="left">���д���</div>
                </TD>
                <TD width="32%" nowrap> 
                    <input name=bankCode size=12 maxlength="12" readonly>
					<input name=bankName size=20 readonly>
                </TD>                                              
            </TR>
           </TBODY>
          <TBODY> 
            <TR id='checkShow' style='display:none'> 
                  <TD class=blue nowrap> 
                    <div align="left">֧Ʊ����</div>
                  </TD>
           		 <TD width=32%>
              	    <input class="button" v_must=0 v_type=money v_account=subentry name="checkPay" value="0.00" maxlength=15 index="51">
                    <font class="orange">*</font> </TD> 
                  <TD class=blue> 
                    <div align="left">֧Ʊ���</div>
                  </TD>
                  <TD width=32%> 
                    <input class="button" name="checkPrePay" value=0.00 readonly>
                  </TD>               
            </TR>            
          </TBODY>
        
          <TBODY>
            <TR id="si_te" style="display:">
                   <td class=blue>����SI</td>
                   <td colspan='3'>         
                         <input class="button" v_type="0_9" name=pay_si maxlength=20 onkeyup="if(event.keyCode==13)getSi();" index="60">
                         <input name=siQuery type=button id="siQuery" class="b_text" onMouseUp="getSi();" onKeyUp="if(event.keyCode==13)getSi();" style="cursor:hand" value=��ѯ>              
                    </td>
             </TR>
            </TBODY>
            
            <TR>
               <TD class=blue>��ע</TD>
               <TD width="82%" colspan="3">
               <input class="InputGrey" name="sysnote" size="60" readonly>
               </TD>
            </TR>
            <TR style="display:none">
                <TD class=blue>�û���ע</TD>
                <TD width="82%" colspan="3">
                <input name="tonote" size="60">
                </TD>
           </TR>
       </TABLE>

 <!-----------���ص��б�---------------> 
<TABLE cellSpacing=0>
    <TR id="footer">
        <TD align=center>
        <%
            if (nextFlag==1){
        %>
                <input name="next" class="b_foot"  type=button value="��һ��" onclick="nextStep()" disabled>
        <%
            }else {
        %>
                <script>
                    closefields();
                </script>
                <input class="b_foot" name="previous"  type=button value="��һ��" onclick="previouStep()">
                <input class="b_foot" name="sure"  type=button value="ȷ��" onclick="refMain()" disabled>
        <%
            }
        %>
            <input class="b_foot" name=back  type=button value="���" onclick="window.location='s3500_1.jsp'">
            <input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="�ر�">
        </TD>
    </TR>
<!-------------������--------------->
<input type="hidden" name="modeType">
<input type="hidden" name="typeName">
<input type="hidden" name="addMode">
<input type="hidden" name="modeName">
<input type="hidden" name="nameList">
<input type="hidden" name="nameGroupList">	
<input type="hidden" name="fieldNamesList">
<input type="hidden" name="choiceFlag">
<input type="hidden" name="OwnerType">
<input type="hidden" name="checkPhone_3G" value="0">     <!--shengzd added for TD-���� @ 20090526-->
<input type="hidden" name="checkPhone_2G" value="0">     <!--shengzd added for TD-���� @ 20090526-->
<input type="hidden" name="checkPhone_alert" value="0">  <!--shengzd added for TD-���� @ 20090526-->
<!-------------������--------------->
</TABLE>

<jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
 <%if (nextFlag==1){%>
 <script language="JavaScript">
 document.frm.iccid.focus();
 //query_prodAttr();
 </script>
 <%}%>
</BODY>
</HTML>

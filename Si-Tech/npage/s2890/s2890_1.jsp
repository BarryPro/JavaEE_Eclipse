<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.14
 ģ��:EC��Ʒ����
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.*"%>


<%
	ArrayList retArray = new ArrayList();
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
	String op_name ="EC��Ʒ����";
	Logger logger = Logger.getLogger("s2890_1.jsp");

    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    int iDate = Integer.parseInt(dateStr);
    String addDate = Integer.toString(iDate+1);
    String Date100 = Integer.toString(iDate+1000000);

    
    String regCode = (String)session.getAttribute("regCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String nopass  = (String)session.getAttribute("password");
    String Department = (String)session.getAttribute("orgCode");
    String regionCode = Department.substring(0,2);
    String districtCode = Department.substring(2,4);
    String townCode = Department.substring(4,7);
    
    String[] inParamsStr = new String[2];
    String sqlStr = "";
	String cust_address = "";
    String[][] result = new String[][]{};
	String[][] resultList = new String[][]{};
	String[][] resultList_usr = new String[][]{};
	String [][]smProTypeList =  new String[][]{};
	String [][]modeList =  new String[][]{};
	String [][]proddirectname =  new String[][]{};
		/*��Ʒ�ͷ���ķ���Ȩ��*/
    //int iPowerRight = Integer.parseInt((String)session.getAttribute("powerRight")); //����Ȩ��

	//ȡ����ʡ�ݴ��� -- Ϊ�������ӣ�ɽ������ʹ��session
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCodeA" retmsg="retMsgA" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
<%
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
		sqlStr = "select group_id,'unknown' FROM dLoginMsg where login_no='"+workno+"'";
		inParamsStr[0] = "select group_id,'unknown' FROM dLoginMsg where login_no=:workno";
		inParamsStr[1] = "workno="+workno;
		//result1 = (String[][])callView.sPubSelect("2",sqlStr).get(0);
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCodeB" retmsg="retMsgB" outnum="2">			
		<wtc:param value="<%=inParamsStr[0]%>"/>	
		<wtc:param value="<%=inParamsStr[1]%>"/>	
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
    
	int nextFlag=1;
	String listShow="none";
	StringBuffer nameList=new StringBuffer();
	StringBuffer nameValueList=new StringBuffer();
	StringBuffer nameGroupList=new StringBuffer();

//�õ�ҳ����� 
	String nameList_2890 ="";
	String valueList_2890 = "";
	String mainProduct="";
	String addProduct ="";
	String modeCode   ="";
	String addMode    ="";
	String iccid = "";
	String cust_id = request.getParameter("cust_id")==null?"":request.getParameter("cust_id");//wuxy alter 20090513
	String unit_id = "";
	String cust_code  ="";
	String cust_name = "";
	String province = "";
	String openType = "";
	String userType = "";
	String userTypeNew = "";
	String GroupIdnew=""; //wuxy add 20090328 ���group_id����
	String product_code = "";
	String bizCode = "";
	String bizName = "";
	String product_append = "";
	String grp_id = "";
	String grp_name = "";
	String account_id = "";
	String grp_userno = "";
	String channel_code = "";
	String belong_code = "";
	String belong_codeNew = "";
	String sm_code = "";
	String prod_direct = "";
	String hid_pay_flag = "";
	String hid_createFlag="";
	String billTime   ="";
	String productAttr = "";
	String userType_hidden = "";
	String product_attr_hidden = "";
	String custAddress = "";
	String product_prices = "";
	
	String sm_code_hidden = "";
	String belong_code_hidden="";
	String billingtype="";
	String gongnengfee_hid="";
	
	StringBuffer numberList=new StringBuffer();
	StringBuffer numberList_usr=new StringBuffer();
	
	System.out.println("=============ajax=============");
	//�õ��б����
	String action=request.getParameter("action");
	String modeType=request.getParameter("product_attr");
	int resultListLength=0;
	int resultListLength_usr=0;
	if (action!=null&&action.equals("select")){
		System.out.println("=======!!!!!action========");
		try{
             hid_createFlag=request.getParameter("hid_createFlag");
	         hid_pay_flag=request.getParameter("hid_pay_flag");
	         if("2".equals(hid_pay_flag)){
				hid_pay_flag=request.getParameter("pay_flag");
			 }
			 billTime=request.getParameter("billTime");
			 iccid=request.getParameter("iccid");
			 cust_id=request.getParameter("cust_id");
			 unit_id=request.getParameter("unit_id");
			 cust_name=request.getParameter("cust_name");
			 custAddress =request.getParameter("cust_address");
			 cust_code=request.getParameter("cust_code");
			 province=request.getParameter("province");
			 sm_code=request.getParameter("sm_code");
			 prod_direct=request.getParameter("prod_direct");
			 sm_code_hidden=sm_code;
			 openType=request.getParameter("openType");
			 productAttr=request.getParameter("product_attr");
			 userType_hidden=request.getParameter("userType_hidden");
			 mainProduct=request.getParameter("mainProduct");
			 addProduct=request.getParameter("addProduct");
			 modeCode=request.getParameter("modeCode");
			 addMode=request.getParameter("addMode");
			 product_attr_hidden = request.getParameter("product_attr_hidden");
			 userType=request.getParameter("sm_code");
			 userTypeNew=request.getParameter("userType");
			 product_prices=request.getParameter("product_prices");
			
			 product_code=request.getParameter("product_code");
			 bizCode=request.getParameter("bizCode");
			 bizName=request.getParameter("bizName");
			 product_append=request.getParameter("product_append");
			 grp_id=request.getParameter("grp_id");
			 grp_name=request.getParameter("grp_name");
			 account_id=request.getParameter("account_id");
			 grp_userno=request.getParameter("grp_userno");
			 channel_code=request.getParameter("channel_code");
			 belong_code = request.getParameter("belong_code");
			 belong_code_hidden=belong_code;
			 belong_codeNew = request.getParameter("belong_codeNew");
			 GroupIdnew=request.getParameter("group_id");//wuxy add 20090328 
			 billingtype = 	request.getParameter("billingtype");
			 gongnengfee_hid = request.getParameter("gongnengfee");

			nameList_2890 = request.getParameter("nameList_2890");	
			valueList_2890 = request.getParameter("valueList_2890");	
			String product_code_str = product_code.substring(0,product_code.indexOf("|"));
			System.out.println("product_code_str="+product_code_str);
			
			sqlStr="select ufeild_type,mfield_type,is_mebbill from sSmProduct where sm_code = '"+sm_code+"' and product_code = '"+product_code_str+"'";
			inParamsStr[0] = "select ufeild_type,mfield_type,is_mebbill from sSmProduct where sm_code =:sm_code and product_code =:product_code_str";
			inParamsStr[1] = "sm_code="+sm_code+",product_code_str="+product_code_str;
			System.out.println("sqlStr======"+sqlStr);
			//smProTypeList=(String[][])callView.sPubSelect("3",sqlStr).get(0);
%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCodeC" retmsg="retMsgC" outnum="3">			
			<wtc:param value="<%=inParamsStr[0]%>"/>	
			<wtc:param value="<%=inParamsStr[1]%>"/>	
			</wtc:service>	
			<wtc:array id="smProTypeListTemp"  scope="end"/>
<%
			smProTypeList = smProTypeListTemp;
			if(smProTypeList.length==0){
				smProTypeList = new String[1][3];
				smProTypeList[0][0] = "";
				smProTypeList[0][1] = "";
				smProTypeList[0][2] = "";
			}
			
			sqlStr="select b.mode_code,mode_name from sSmProduct a, sBillModeCode b " +
							" where  a.mode_code = b.mode_code 		and    a.sm_code = '"+sm_code+"'" +
							" and    a.product_code = '"+product_code_str+"'	and    b.region_code = '"+regionCode+"'";
			inParamsStr[0] = "select b.mode_code,mode_name from sSmProduct a, sBillModeCode b " +
							" where  a.mode_code = b.mode_code 		and    a.sm_code =:sm_code" +
							" and    a.product_code =:product_code_str	and    b.region_code =:regionCode";
			inParamsStr[1] = "sm_code="+sm_code+",product_code_str="+product_code_str+",regionCode="+regionCode;
			//modeList=(String[][])callView.sPubSelect("2",sqlStr).get(0);
%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCodeD" retmsg="retMsgD" outnum="2">			
			<wtc:param value="<%=inParamsStr[0]%>"/>	
			<wtc:param value="<%=inParamsStr[1]%>"/>	
			</wtc:service>	
			<wtc:array id="modeListTemp"  scope="end"/>
<%
			if(modeListTemp.length!=0)
			modeList = modeListTemp;
			if(modeList.length==0){
				modeList = new String[1][2];
				modeList[0][0] = "";
				modeList[0][1] = "";
			}
			
			sqlStr="select a.direct_name  from sProductDirect a where prod_direct= '"+prod_direct+"'";
			inParamsStr[0] = "select a.direct_name  from sProductDirect a where prod_direct=:prod_direct";
			inParamsStr[1] = "prod_direct="+prod_direct;
			//proddirectname=(String[][])callView.sPubSelect("1",sqlStr).get(0);
%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCodeD" retmsg="retMsgD" outnum="1">			
			<wtc:param value="<%=inParamsStr[0]%>"/>	
			<wtc:param value="<%=inParamsStr[1]%>"/>	
			</wtc:service>	
			<wtc:array id="proddirectnameTemp"  scope="end"/>
<%
			if(proddirectnameTemp.length!=0)
			proddirectname = proddirectnameTemp;
			//ȡ����������
			sqlStr= "select a.field_code,a.field_name,a.field_purpose,a.field_type,a.field_length,"
			       +" b.field_grp_no,c.field_grp_name,c.max_rows,c.min_rows,b.ctrl_info,nvl(b.FIELD_DEFVALUE,' ')"
			       +"  from sUserFieldCode a,sGrpSmFieldRela b,sUserTypeGroup c"
				   +" where a.busi_type = b.busi_type"
				   +"   and a.field_code=b.field_code"
				   +"   and a.busi_type = '"+smProTypeList[0][0]+"'"
				   +"   and b.user_type='"+sm_code+"'"
				   +"   and a.busi_type = c.busi_type"
				   +"   and b.user_type = c.user_type"
				   +"   and b.field_grp_no = c.field_grp_no"
				   +" order by b.field_grp_no,b.field_order";
			//System.out.println("group:"+sqlStr);
			//resultList=(String[][])callView.sPubSelect("11",sqlStr).get(0);
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCodeE" retmsg="retMsgE" outnum="11">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="resultListTemp" scope="end" />
<%
			if(resultListTemp.length!=0)
			resultList = resultListTemp;
			if (resultList != null && resultList.length>0)
			{
				if (resultList[0][0].equals(""))
				{
					resultList = null;
				}
			}
			
			if (resultList != null && resultList.length>0)
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
			
			System.out.println("resultListLength====================="+resultListLength);
			listShow="";
			//�õ����ݵ�����
			//�õ���������
			
			//ȡ����Ա����
			
			sqlStr= "select a.field_code,a.field_name,a.field_purpose,a.field_type,a.field_length,"
			       +" b.field_grp_no,c.field_grp_name,c.max_rows,c.min_rows,b.ctrl_info,nvl(b.FIELD_DEFVALUE,' ')"
			       +"  from sUserFieldCode a,sUserTypeFieldRela b,sUserTypeGroup c"
				   +" where a.busi_type = b.busi_type"
				   +"   and a.field_code=b.field_code"
				   +"   and a.busi_type = '"+smProTypeList[0][1]+"'"
				   +"   and b.user_type='"+sm_code+"'"
				   +"   and a.busi_type = c.busi_type"
				   +"   and b.user_type = c.user_type" 
				   +"   and b.field_grp_no = c.field_grp_no"
				   +" order by b.field_grp_no,b.field_order";
			System.out.println("member:"+sqlStr);
			//resultList_usr=(String[][])callView.sPubSelect("11",sqlStr).get(0);
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCodeF" retmsg="retMsgF" outnum="11">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="resultList_usrTemp" scope="end" />
<%
			if(resultList_usrTemp.length!=0)
			resultList_usr = resultList_usrTemp;
			//System.out.println("############resultList_usr="+resultList_usr.length);
			if (resultList_usr != null && resultList_usr.length>0)
			{
				if (resultList_usr[0][0].equals(""))
				{
					resultList_usr = null;
				}
			}
			if (resultList_usr != null && resultList_usr.length>0)
			{
				for(int i=0;i<resultList_usr.length;i++)
				{
					if (resultList_usr[i][2].equals("10")){
						numberList_usr.append(resultList_usr[i][0]+"|");
					}
				}
			}
			resultListLength_usr=result.length;
			nextFlag=2;
			System.out.println("******nextFlag===="+nextFlag);
			listShow="";
		}
		catch(Exception e){
		}
	}
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=op_name%></TITLE>
</HEAD>
<SCRIPT type=text/javascript>

onload=function(){
	document.all.checkPayTR.style.display="none";
}

function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
	var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
    if(retType == "getProdDirect")
    {
        if(retCode == "000000")
        {
			var backString = packet.data.findValueByName("backString");
         	var temLength = backString.length+1;
			var arr = new Array(temLength);
			for(var i = 0 ; i < backString.length ; i ++)
			{
				arr[i] = "<OPTION value="+backString[i][0]+" pvalue="+backString[i][1]+">" +backString[i][1] + "</OPTION>";
			}
          	prod_direct_div.innerHTML = "<select id=prod_direct size=1 onChange=changeProdDirect() name=prod_direct>" + arr.join() + "</SELECT>";
         	chgGrpName();
		}
        else
        {
            rdShowMessageDialog("û�еõ����Ų�Ʒ����,�����»�ȡ��");
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
            rdShowMessageDialog(retMessage, 0);
        }
	}
    if(retType == "GrpNo") //�õ������û����
    {
        if(retCode == "000000")
        {
            var GrpNo = packet.data.findValueByName("GrpNo");
            document.frm.grp_userno.value = GrpNo;
            //document.frm.getGrpNo.disabled = true;
        }
        else
        {
            var retMessage = packet.data.findValueByName("retMessage");
            rdShowMessageDialog(retMessage, 0);
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
    if(retType == "AccountId") //�õ������ʻ�ID
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
            rdShowMessageDialog("û�еõ������ʻ�ID,�����»�ȡ��");
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
            } else {
                rdShowMessageDialog("�ͻ�����У��ɹ���",2);
                document.frm.next.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("�ͻ�����У�����������У�飡");
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
       	}
        else
        {
                rdShowMessageDialog("��ѯ��Ʒ���Գ���,�����»�ȡ��");
				return false;
        }
	}
	
	
	
	if(retType == "getCreateflag")//add
	{   		
		if(retCode == "000000")
        {
        	var createFlag = packet.data.findValueByName("createFlag");
			var pay_flag = packet.data.findValueByName("pay_flag");

			frm.hid_createFlag.value = createFlag;
			
			frm.hid_pay_flag.value = pay_flag;
			
			if(pay_flag=="0")
			{
				frm.pay_flag.selected = pay_flag;
				frm.pay_flag.disabled = true;
			}
			else
			{	
				frm.pay_flag.value = pay_flag;
			}
            if (createFlag == "false")
			{
    	    	rdShowMessageDialog("��ȡcreateFlagʧ�ܣ�",0);
    	    	return false;	        	
            }
			else
			{
                if(createFlag=='Y')////////////////////////Y->N
				{
					frm.getUserOutNo.style.display="";
					frm.verifyMebNo.style.display="none";
				//	document.all.productcode_div.style.display="";
					frm.mainProduct.v_must=1;
				}
				else
				{
					frm.cust_code.readOnly=false;
					frm.getUserOutNo.style.display="none";
					frm.verifyMebNo.style.display="";
				//	document.all.productcode_div.style.display="none";
					frm.mainProduct.v_must=0;
				}
            }
        }
        else
        {
            rdShowMessageDialog("��ȡ�ͻ���ַʧ�ܣ������»�ȡ��");
    		return false;
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

			confirmFlag = rdShowConfirmDialog("�Ƿ��ύ���β�����");
		
			if (confirmFlag==1) 
			{
			 //����ӡ��Ҫ����Ӧ����
				spellList_grp();
				//spellList();
				
				frm.action="s3504_2.jsp";
				frm.submit();
			}
        }
        else
        {
        	rdShowMessageDialog("��ѯ��ˮ����,�����»�ȡ��");
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
    if(retType == "verifycustcode")//add
	{   //��֤cust_code 
        if(retCode == "0")
        {
				rdShowMessageDialog("�û�������ϢУ��ɹ���");
				frm.verifyMebNo.disabled=true;
         }
        else
        {
			var retMsg = packet.data.findValueByName("retMsg");
    		rdShowMessageDialog(retMsg,0);  
			//rdShowMessageDialog("У�鲻�ɹ���",0);
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
            rdShowMessageDialog("��ȡ�ͻ���ַʧ�ܣ������»�ȡ��");
    		return false;
        }
	}
	if(retType == "query_channelid")/////////////
	{   //�õ�query_channelid
        if(retCode == "0")
        {
            var channel_name = packet.data.findValueByName("channel_name");

			var channel_id = packet.data.findValueByName("channel_id");
            if (channel_id == "false") {
    	    	rdShowMessageDialog("��ȡchannelidʧ�ܣ�",0);
    	    	return false;	        	
            } else {
                document.frm.channel_id.value = channel_id;
            }
         }
        else
        {
            rdShowMessageDialog("��ȡchannelidʧ�ܣ������»�ȡ��");
    		return false;
        }
	}
	if(retType == "custCode") //�õ���Ա�û�����
    {
        if(retCode == "000000")
        {
            var memIdNo = packet.data.findValueByName("memIdNo");
            document.frm.cust_code.value = memIdNo;
            document.frm.getUserOutNo.disabled = true;
         }
        else
        {
            rdShowMessageDialog("û�еõ������ʻ�ID,�����»�ȡ��");
        }
    }
    if(retType=="getBillingType")//�õ�sbillspcode�е� billingtype luxc add 20070916
    {
    	
    	if(retCode="000000")
    	{
    		
    		var billingtype = packet.data.findValueByName("billingtype");
    		document.all.billingtype.value = billingtype;
    		
    		if(billingtype == "00" || billingtype == "01")//�����ѻ����
    		{
    			document.all.tr_gongnengfee.style.display = "none";
    		}
    		else if(billingtype == "02")//�������
    		{
    			document.all.tr_gongnengfee.style.display = "block";
    		}
    		else
    		{
    			rdShowMessageDialog("��ѯsbillspcode,billingtype����="+billingtype,0);
    		}
    		
    	}
    	else
    	{
    		rdShowMessageDialog(retMessage);
    	}
    }
    
    
    
    
}

function refMain2()
{
	getAfterPrompt();
/*
	if(  document.frm.grp_userno.value == "" ){
            rdShowMessageDialog("�����û���ű�������!!");
            document.frm.grp_userno.select();
            return false;
        }
  */  
    		if(  document.frm.product_code.value == "" ){
            rdShowMessageDialog("���Ų�Ʒ��������!!");
            document.frm.product_code.select();
            return false;
        }

		document.frm.mainProduct.v_must=0;        
		if(((document.frm.mainProduct.value).trim() == "") && (document.frm.mainProduct.v_must==1))
        {
        	rdShowMessageDialog("���ײͱ�������!!");
            document.frm.mainProduct .select();
            return false;
        }
        
        	if(  document.frm.grp_id.value == "" ){
            rdShowMessageDialog("���Ų�ƷID��������!!");
            document.frm.grp_id.select();
            return false;
        }
        
        
        if(  document.frm.grp_name.value == "" ){
            rdShowMessageDialog("�û�����:"+document.frm.grp_name.value+",��������!!");
            document.frm.grp_name.select();
            return false;
        }
         	if(  document.frm.account_id.value == "" ){
            rdShowMessageDialog("�����ʻ�ID��������!!");
            document.frm.account_id.select();
            return false;
        }
        /*
         	if(  document.frm.cust_code.value == "" ){
            rdShowMessageDialog("��Ա�û������������!!");
            document.frm.cust_code.select();
            return false;
        }
        */
          	if(  document.frm.credit_value.value == "" ){
            rdShowMessageDialog("���öȱ�������!!");
            document.frm.credit_value.select();
            return false;
        }
         	if(  document.frm.credit_code.value == "" ){
            rdShowMessageDialog("���õȼ���������!!");
            document.frm.credit_code.select();
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
      
	   	
		//�ж�real_handfee
		if(!checkElement(document.all.real_handfee)) return false;
        if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
        {
				rdShowMessageDialog("ʵ�������Ѳ�Ӧ����Ӧ��������");
				document.frm.real_handfee.focus();
				return false;	
        }
        //alert(document.frm.checkPay.value);alert(document.frm.real_handfee.value);
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
		
		
		document.frm.chgsrv_start.value = changeDateFormat(document.frm.srv_start.value);
        document.frm.chgsrv_stop.value  = changeDateFormat(document.frm.srv_stop.value);
        document.frm.sysnote.value = " EC��Ʒ����:�����û�:"+document.frm.grp_userno.value+"���Ų�Ʒ:"+document.frm.product_code.value;
        document.frm.tonote.value = " EC��Ʒ����:�����û�:"+document.frm.grp_userno.value+"���Ų�Ʒ:"+document.frm.product_code.value;
        
		var real_handfee = document.frm.real_handfee.value;
		var cashNum = document.frm.cashNum.value;
		var cashPay = document.frm.cashPay.value;
		var totalPay2 = Math.round(real_handfee) + Math.round(cashNum);
		document.frm.totalPay2.value = totalPay2;
			
	
		var prtFlag=0;
	
		prtFlag = rdShowConfirmDialog("�Ƿ��ӡ���������");
       
        if (prtFlag==1) {

         	spellList_grp();
         	//spellList();
         
			frm.action="sGrpPubPrint3504.jsp"; 
		    frm.submit(); 
		   
		    
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
	checkPwd_Packet=null;
}

function getAccountId()
{
	//query_custaddress();//�õ��ͻ���ַ
	//�õ������ʻ�ID
    var getAccountId_Packet = new AJAXPacket("../s2890/f1100_getId.jsp","���ڻ�ü����ʻ�ID�����Ժ�......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","AccountId");
	getAccountId_Packet.data.add("idType","1");
	getAccountId_Packet.data.add("oldId","0");
	
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet=null;

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

    var getgrp_Userno_Packet = new AJAXPacket("getGrpUserno.jsp","���ڻ�ü����û���ţ����Ժ�......");
    getgrp_Userno_Packet.data.add("retType","GrpNo");
    getgrp_Userno_Packet.data.add("orgCode","<%=org_code%>");
    getgrp_Userno_Packet.data.add("smCode",sm_code);
    core.ajax.sendPacket(getgrp_Userno_Packet);
    getgrp_Userno_Packet=null;
}

function getGrpId()
{
    //�õ������������û�����
    var getgrp_no_Packet = new AJAXPacket("../s2890/getGrpId.jsp","���ڻ�ü��Ŵ��룬���Ժ�......");
    getgrp_no_Packet.data.add("retType","GrpId");
    getgrp_no_Packet.data.add("orgCode","<%=org_code%>");
    core.ajax.sendPacket(getgrp_no_Packet);
    getgrp_no_Packet=null;
}

function getUserId()
{
    //�õ����Ų�ƷID���͸����û�IDһ��
    var getUserId_Packet = new AJAXPacket("../s2890/f1100_getId.jsp","���ڻ���û�ID�����Ժ�......");
	getUserId_Packet.data.add("region_code","<%=regionCode%>");
	getUserId_Packet.data.add("retType","UserId");
	getUserId_Packet.data.add("idType","1");
	getUserId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getUserId_Packet);
	getUserId_Packet=null;
}
 //��һ��
function nextStep()
{
	
  if(  document.frm.grp_id.value == "" ){
            rdShowMessageDialog("���Ų�ƷID��������!!");
            document.frm.grp_id.select();
            return false;
  }	
  
  if (document.frm.nameList_2890.value=="")
        {
				rdShowMessageDialog("����û������");			
				return false;	
        }
  if(  document.frm.grp_name.value == "" ){
      rdShowMessageDialog("�û�����:"+document.frm.grp_name.value+",��������!!");
      document.frm.grp_name.select();
      return false;
  }  
	if(  document.frm.grp_userno.value == "" ){
            rdShowMessageDialog("�����û���ű�������!!");
            document.frm.grp_userno.select();
            return false;
  }
  if(  document.frm.account_id.value == "" ){
      rdShowMessageDialog("�����ʻ�ID��������!!");
      document.frm.account_id.select();
      return false;
  }    
  if(  document.frm.product_code.value == "" ){
          rdShowMessageDialog("���Ų�Ʒ��������!!");
          document.frm.product_code.select();
          return false;
  }      
        
	frm.action="s2890_1.jsp?action=select&opCode=2890&opName=EC��Ʒ����";
	frm.method="post";
	frm.submit();
}
//��һ��
function previouStep(){
	frm.action="s2890_1.jsp?opCode=2890&opName=EC��Ʒ����";
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
	    var getInfoPacket = new AJAXPacket("s2890_custaddress.jsp","���ڲ�ѯ�ͻ���ַ�����Ժ�......");
		getInfoPacket.data.add("retType","custaddress");
		getInfoPacket.data.add("cust_id",document.frm.cust_id.value);
		core.ajax.sendPacket(getInfoPacket,doProcess,false);
		getInfoPacket=null;
}
function doOnLoad()
{
	var createFlag2 = frm.hid_createFlag.value;
	if (createFlag2 == "")
	{
		createFlag2 = document.frm.sm_code.options[document.frm.sm_code.options.selectedIndex].createFlag;
	}

	if(createFlag2=='Y')
	{
		frm.getUserOutNo.style.display="";
		frm.verifyMebNo.style.display="none";
		//document.all.productcode_div.style.display="";
		frm.mainProduct.v_must=1;
	}
	else if(createFlag2=='N')
	{
		frm.cust_code.readOnly=false;
		frm.getUserOutNo.style.display="none";
		frm.verifyMebNo.style.display="";
		//document.all.productcode_div.style.display="none";
		frm.mainProduct.v_must=0;
	}
	else if(createFlag2=='')
	{
		frm.getUserOutNo.style.display="";
		frm.verifyMebNo.style.display="none";
		//document.all.productcode_div.style.display=""
		frm.mainProduct.v_must=1;
	}
}

//��ѯchannel_id
function query_channelid()
{
    var getInfoPacket = new AJAXPacket("s2890_channelid.jsp","���ڲ�ѯ�����Ժ�......");
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
    var fieldName = "���Ų�ƷID|�����û�����|��Ʒ����|�����ʺ�|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "4|0|1|2|3|";
    var retToField = "tmp1|tmp2|tmp3|account_id|"; //����ֻ��Ҫ�����ʺ�
    var cust_id = document.frm.cust_id.value;

    if(document.frm.cust_id.value == "")
    {
        rdShowMessageDialog("����ѡ���ſͻ������ܽ��м����ʻ���ѯ��",0);
        document.frm.iccid.focus();
        return false;
    }

    if(PubSimpSelAcct(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelAcct(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s2890/fpubcustacct_sel.jsp";
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
    var fieldName = "֤������|�ͻ�ID|�ͻ�����|���ű��|��������|������|group_id|";
		var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|2|3|4|5|6|";
    //wuxy alter 20090328 ��ȡһ��group_id
    var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_codeNew|group_id|";
    var cust_id = document.frm.cust_id.value;

    if(document.frm.iccid.value == "" &&
       document.frm.cust_id.value == "" &&
       document.frm.unit_id.value == "")
    {
        rdShowMessageDialog("������֤�����롢���ſͻ�ID���ű�����в�ѯ��",0);
        document.frm.iccid.focus();
        return false;
    }

    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
        rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s2890/fpubcust_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
    path = path + "&cust_id=" + document.all.cust_id.value;
    path = path + "&unit_id=" + document.all.unit_id.value;
    path = path + "&regionCode=" + document.frm.OrgCode.value.substr(0,2);

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	
	return true;
}

function getvaluecust(retInfo)
{
	                
  var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_codeNew|group_id|";;
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
   
 
	 //query_custaddress();///////////////add
	 getCreateflag();
 	 chgGrpName(); 
}

function chgGrpName()
{
	var z_sm_code ;
    if(document.all.sm_code.value=="AD")
    {
    	z_sm_code="ADC";
    }else if(document.all.sm_code.value=="ML")
    {
    	z_sm_code="����MAS";
    }else if(document.all.sm_code.value=="MA")
    {
    	z_sm_code="ȫ��MAS";
    }
    
   
    for(j = 0 ; j < document.all.prod_direct.length ; j ++){
		if(document.all.prod_direct.options[j].selected){
		 z_sm_code= z_sm_code+"-"+document.frm.prod_direct.options[j].pvalue;
		}
	}
	
	document.all.grp_name.value = z_sm_code;
}
//��ѯgetCreateflag
function getCreateflag()
{ 
    if((frm.sm_code.value).trim() == "")
    {
        rdShowMessageDialog("���ȡҵ�����ͣ�",0);
        frm.sm_code.focus();
        return false;
    }
    var getCheckInfo_Packet = new AJAXPacket("f3505_getflag.jsp","���ڻ�������Ϣ�����Ժ�......");
	getCheckInfo_Packet.data.add("retType","getCreateflag");
    getCheckInfo_Packet.data.add("sm_code",document.frm.sm_code.value);
	core.ajax.sendPacket(getCheckInfo_Packet);
	getCheckInfo_Packet=null;     
}
//���ݿͻ�ID��ѯ�ͻ���Ϣ
function getInfo_CustId()
{
    var cust_id = document.frm.cust_id.value;

    //���ݿͻ�ID�õ������Ϣ
    if(document.frm.cust_id.value == "")
    {
        rdShowMessageDialog("������ͻ�ID��",0);
        return false;
    }
    if(forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("�ͻ�ID���������֣�",0);
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
        rdShowMessageDialog("���������뼯�ſͻ�ID��",0);
        return false;
    }
    if(forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("���ſͻ�ID���������֣�",0);
    	return false;
    }
    if(document.frm.unit_id.value == "")
    {
        rdShowMessageDialog("���������뼯�ű�ţ�",0);
        return false;
    }
    if(forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
        rdShowMessageDialog("���ű�ű��������֣�",0);
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
        return false;
    }
    var getInfoPacket = new AJAXPacket("fpubprodattr_qry.jsp","���ڲ�ѯ��Ʒ���Դ��룬���Ժ�......");
    getInfoPacket.data.add("retType","ProdAttr");
    getInfoPacket.data.add("sm_code",sm_code);
    core.ajax.sendPacket(getInfoPacket);
    getInfoPacket=null;
}


//��ѯ֧Ʊ����
function getBankCode()
{ 
  	//���ù���js�õ����д���
    if((frm.checkNo.value).trim() == "")
    {
        rdShowMessageDialog("������֧Ʊ���룡",0);
        frm.checkNo.focus();
        return false;
    }
    var getCheckInfo_Packet = new AJAXPacket("getBankCode.jsp","���ڻ��֧Ʊ�����Ϣ�����Ժ�......");
	getCheckInfo_Packet.data.add("retType","getCheckInfo");
    getCheckInfo_Packet.data.add("checkNo",document.frm.checkNo.value);
	core.ajax.sendPacket(getCheckInfo_Packet);
	getCheckInfo_Packet=null;     
 }


function getvalueProdAttr(retInfo)
{
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
    var fieldName = "��Ʒ����|��Ʒ����|�Ƿ��������|ҵ�����|ҵ������|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "4|0|1|2|3|";
    var retToField = "product_code|product_name|bizCode|bizName|";

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��",0);
        return false;
    }
    

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    /*
    {
    	
    	getBillingType(document.all.product_code.value);
    }
    else
    {
    	alert("ѡ���Ų�Ʒʧ��23!");
    	return false;
    }
    */
}
function getBillingType(product_code)
{
	//alert("getBillingType()product_code="+product_code);
	if((product_code).trim() == "")
    {
       	rdShowMessageDialog("ѡ���Ų�Ʒʧ��24!",0);
        return false;
    }
    
    var getBillingType_Packet = new AJAXPacket("fgetBillingType.jsp","���ڻ�ȡbillingtype�����Ժ�......");
	getBillingType_Packet.data.add("retType","getBillingType");
    getBillingType_Packet.data.add("product_code",product_code);
	core.ajax.sendPacket(getBillingType_Packet);
	getBillingType_Packet=null;
	
	
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s2890/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&direct_id=" + document.all.prod_direct.value; 

  retInfo = window.open(path,"newwindow","height=450, width=680,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	  
	return true;
}

function getvalue(retInfo, retInfoDetail)
{
	var tmpProductShow = "";
	var retToField = "product_code|product_name|bizCode|bizName|";
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
    
	//alert(document.all.bizCode.value);
	  //alert(document.all.product_name.value);
	  var  tmpValue = document.all.product_code.value + "|" + document.all.product_name.value+"|"
  	//document.all.product_code.value = retInfo;
  	document.all.product_code.value = tmpValue;
  	
  	document.frm.product_prices.value = retInfoDetail;
  	var path1 = "fpubDynaFields_2890.jsp";
	  path1 = path1 + "?bizCode=" + document.all.bizCode.value;
	  //alert(document.all.bizCode.value);
	  if(getBillingType(document.all.bizCode.value));

	window.open(path1,"newwindow1","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

}

function getnameList_2890(info1,info2)
{
	document.frm.nameList_2890.value=info1;
	document.frm.valueList_2890.value=info2;
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
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��",0);
        return false;
    }
    //�����ж��Ƿ��Ѿ�ѡ���˲�Ʒ����
    if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�",0);
        return false;
    }
    //�����ж��Ƿ��Ѿ������˼��Ų�Ʒ
    if(document.frm.product_code.value == "")
    {
        rdShowMessageDialog("������ѡ���Ų�Ʒ��",0);
        return false;
    }

    if(PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var product_code = document.all.product_code.value;
    var chPos = product_code.indexOf("|");
    product_code = product_code.substring(0,chPos);
    var path = "<%=request.getContextPath()%>/npage/s2890/fpubprodappend_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&showType=" + "Default";
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&product_code=" + product_code; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalueProdAppend(retInfo)
{
  var retToField = "product_append|product_name|";
  if(retInfo ==undefined)      
    {   return false;   }

  document.all.product_append.value = retInfo;
}

function checkPwd(obj1,obj2)
{
        //����һ����У��,����У��
        var pwd1 = obj1.value;
        var pwd2 = obj2.value;
        if(pwd1 != pwd2)
        {
                //var message = "'" + obj1.v_name + "'��'" + obj2.v_name + "'��һ�£����������룡";
                var message = "������������벻һ�£����������룡";
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
function changeSmCode() 
{
	document.frm.product_code.value = "";
    if (document.frm.sm_code.options.length > 0)
    {
	    if (document.frm.sm_code.options[document.frm.sm_code.options.selectedIndex].seqFlag == "Y")
	    {
	    	document.frm.grp_userno.readOnly = true;
	    }
	    else
	    {
	    	document.frm.grp_userno.readOnly = false;
	    }
	}
	getCreateflag();
    query_prodAttr();
    getProdDirect();
}

//��ѯҵ������
function getProdDirect()
{ 
    if((frm.sm_code.value).trim() == "")
    {
        rdShowMessageDialog("���ȡҵ�����ͣ�",0);
        frm.sm_code.focus();
        return false;
    }
    var getProdDirect_Packet = new AJAXPacket("f2890_getProdDirect.jsp","���ڻ�������Ϣ�����Ժ�......");
	getProdDirect_Packet.data.add("retType","getProdDirect");
    getProdDirect_Packet.data.add("sm_code",document.frm.sm_code.value);
	core.ajax.sendPacket(getProdDirect_Packet);
	getProdDirect_Packet=null;     
 }
function changeProdDirect() {
		document.frm.product_code.value = "";
		 chgGrpName();
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
//����Դ��js/common/date/date.js
function dateCompare(sDate1,sDate2){
	
	if(sDate1>sDate2)	//sDate1 ���� sDate2
		return 1;
	if(sDate1==sDate2)	//sDate1��sDate2 Ϊͬһ��
		return 0;
	return -1;		//sDate1 ���� sDate2
}
//����Դ��page/s2890/pub.js
function isValidYYYYMMDD(sDateTime)
{
	//ʱ���ʽΪ��YYYYMMDD
	var sTmp = "";
	var iYear = 0;
	var iMonth = 0;
	var iDay = 0;
	var iHour = 0;
	var iMinute = 0;
	var iSecond = 0;
	  
	if ( (sDateTime.length > 8 ) || (sDateTime.length < 8) )
	{
		return -1;
	}
	  
	sTmp = sDateTime.substring(0,4);
	if (isNaN(sTmp))
	{
	  return -5;
	}
	iYear = parseInt(sTmp, 10);
	  
	sTmp = sDateTime.substring(4,6);
	if (isNaN(sTmp))
	{
	   return -6;
	}
	iMonth = parseInt(sTmp, 10);
	 
	sTmp = sDateTime.substring(6,8);
	if (isNaN(sTmp))
	{
	   return -6;
	}
	iDay = parseInt(sTmp, 10); 
	
	if (iYear < 1900)
	{
	  	rdShowMessageDialog("��Ӧ����1900��");
	   	return -11;
	}
	
	if (iMonth < 1 || iMonth > 12)
	{
	   	rdShowMessageDialog("��Ӧ��1��12֮��");
	   	return -12;
	}
	
	if ((iMonth == 1)||(iMonth == 3)||(iMonth == 5)||(iMonth == 7)||(iMonth == 8)||(iMonth == 10)||(iMonth == 12))
	{
	   	if (iDay > 31) return -13;
	}
	else if (iMonth == 2)
	{
	   if (iDay > 29) return -14;
	    if (iDay == 29)
	    {
	     	 //�ж��Ƿ�������
	      	if (!((iYear % 4 == 0) && ((iYear % 100 != 0) || (iYear % 400 == 0))))
	      	{
	       		return -15;
	      	}
	    }
	}
	else
	{
	   	if (iDay > 30) return -16;
	}
	  
	return 0;
}
function changeDateFormat(sDate)
{
		year = sDate.substring(0,4);
		month= sDate.substring(4,6);
		day= sDate.substring(6,8);
		
		return year+"-"+month+"-"+day;
	
}
function refMain(){
	getAfterPrompt();
//У�鶯̬���ɵ��ֶ�
	if(!checkDynaFieldValues_grp(false))
			return false;
			
/* �����include fpubDynaFields_usr.jsp ������Ҳ���
	if(!checkDynaFieldValues(false))
			return false;
*/
			
    var checkFlag; //ע��javascript��JSP�ж���ı���Ҳ������ͬ,���������ҳ����.

    //˵��:���ֳ�����,һ���������Ƿ��ǿ�,��һ���������Ƿ�Ϸ�.
   
   			if(  document.frm.grp_userno.value == "" ){
            rdShowMessageDialog("�����û���ű�������!!");
            document.frm.grp_userno.select();
            return false;
        }
    
    		if(  document.frm.product_code.value == "" ){
            rdShowMessageDialog("���Ų�Ʒ��������!!");
            document.frm.product_code.select();
            return false;
        }
        <%
        if(nextFlag==2)
        {
				if(smProTypeList[0][2].trim().equals("Y"))
				{
				%>
				/*
					if(  document.frm.cust_code.value == "" ){
       	    rdShowMessageDialog("��Ա�û������������!!");
       	    document.frm.cust_code.select();
       	    return false;
       		}
        */
        	document.frm.mainProduct.v_must=0;
				 	if(((document.frm.mainProduct.value).trim() == "") && (document.frm.mainProduct.v_must==1))
	    		{
    	    	rdShowMessageDialog("���ײͱ�������!!");
            document.frm.mainProduct .select();
            return false;
        	}
				<%
				}
				}
				%>
	
        
        	if(  document.frm.grp_id.value == "" ){
            rdShowMessageDialog("���Ų�ƷID��������!!");
            document.frm.grp_id.select();
            return false;
        }
        
        
        if(  document.frm.grp_name.value == "" ){
            rdShowMessageDialog("�û�����:"+document.frm.grp_name.value+",��������!!");
            document.frm.grp_name.select();
            return false;
        }
         	if(  document.frm.account_id.value == "" ){
            rdShowMessageDialog("�����ʻ�ID��������!!");
            document.frm.account_id.select();
            return false;
        }
         	
        
          	if(  document.frm.credit_value.value == "" ){
            rdShowMessageDialog("���öȱ�������!!");
            document.frm.credit_value.select();
            return false;
        }
         	if(  document.frm.credit_code.value == "" ){
            rdShowMessageDialog("���õȼ���������!!");
            document.frm.credit_code.select();
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
		if((document.all.user_passwd.value).trim().length>0)
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

	   	
		//�ж�real_handfee
		if(!checkElement(document.all.real_handfee)) return false;
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
        //���ڲ���̫�࣬��Ҫͨ��form��post����,���,��Ҫ����������ݸ��Ƶ���������. yl.
        document.frm.chgsrv_start.value = changeDateFormat(document.frm.srv_start.value);
        document.frm.chgsrv_stop.value  = changeDateFormat(document.frm.srv_stop.value);
        document.frm.sysnote.value = " EC��Ʒ����:�����û�:"+document.frm.grp_userno.value+"���Ų�Ʒ:"+document.frm.product_code.value;
		document.frm.tonote.value = " EC��Ʒ����:�����û�:"+document.frm.grp_userno.value+"���Ų�Ʒ:"+document.frm.product_code.value;
		
		getSysAccept();

		//��ѯ�ͻ���ַcust_address
		//query_custaddress();
		
    
}
//��ӡ���
//ȡ��ˮ
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","�������ɲ�����ˮ�����Ժ�......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet=null;   
}
//ѡ��֧����ʽ
function changePayType(){
	if (document.all.checkPayTR.style.display==""){
		document.all.checkPayTR.style.display="none";
		document.all.cashPay_div.style.display="";
		
		if(document.frm.cashPay.value=='')
		{
		document.frm.sure.disabled = true; 
		document.frm.sure2.disabled = true;
		}
	}
	else {
		document.all.checkPayTR.style.display="";
		document.all.cashPay_div.style.display="none";
		
		document.frm.sure.disabled = false;
		document.frm.sure2.disabled = false;
	}
}

//У���Ա�û����� 
function DoVerifyMebNo()
{ 
    if((frm.cust_code.value).trim() == "")
    {
        rdShowMessageDialog("�������Ա�û����룡",0);
        frm.cust_code.focus();
        return false;
    }
    var getCheckInfo_Packet = new AJAXPacket("f3505_verifycustcode.jsp","���ڻ�������Ϣ�����Ժ�......");
	getCheckInfo_Packet.data.add("retType","verifycustcode");
    getCheckInfo_Packet.data.add("cust_code",document.frm.cust_code.value);
	getCheckInfo_Packet.data.add("sm_code",document.frm.sm_code.value);
	getCheckInfo_Packet.data.add("login_accept",document.frm.login_accept.value);
	core.ajax.sendPacket(getCheckInfo_Packet);
	getCheckInfo_Packet=null;     
 }

 //����ܼƽ��
function getCashNum(){

	if(!checkDynaFieldValues_grp(true)){//������������
			return false;
		}
/* �����include fpubDynaFields_usr.jsp ������Ҳ���		
	if(!checkDynaFieldValues(true)){//������������
		return false;
	}
*/	
	var addSub_grp = getCashNum_grp();
	var addSub_usr = getCashNum_usr();
	
	document.frm.cashNum.value=addSub_grp+addSub_usr;
}

 //��ü����ܼƽ��
function getCashNum_grp(){

	var retToField = "<%=numberList%>";
	var chPos_field = retToField.indexOf("|");
	var chPos_retStr;
	var valueStr;
	var obj;
	var temp;
	var addSub=0;
	while(chPos_field > -1)
	{
		obj = "F"+"<%=request.getParameter("sm_code")%>"+retToField.substring(0,chPos_field);
	   
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
	return addSub;
}
 //��ó�Ա�ܼƽ��
function getCashNum_usr(){

	
	var retToField = "<%=numberList_usr%>";
	var chPos_field = retToField.indexOf("|");
	var chPos_retStr;
	var valueStr;
	var obj;
	var temp;
	var addSub=0;
	while(chPos_field > -1)
	{
		obj = "F"+"<%=request.getParameter("userType")%>"+retToField.substring(0,chPos_field);
	   
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
	return addSub;
	
}
function check_cashPay(){
			if(document.frm.cashNum.value==""){
				rdShowMessageDialog("���ѯһ���Ը�����!");
				return false;
			}
			/*
			var real_handfee = document.frm.real_handfee.value;
			var cashNum = document.frm.cashNum.value;
			if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
			{
					rdShowMessageDialog("ʵ�������Ѳ�Ӧ����Ӧ��������");
					document.frm.real_handfee.focus();
					return false;	
			}
			*/
			
			//document.frm.cashPay.value=Math.round(real_handfee)+Math.round(cashNum);//�ܷ�
			
			var cashNum = document.frm.cashNum.value;
			document.frm.cashPay.value=Math.round(cashNum);//�ܷ�
			
			rdShowMessageDialog("�������ɹ�!",2);
			document.frm.sure.disabled = false;
			document.frm.sure2.disabled = false;
			
}
//��ó�Ա�û�����
function getCustCode(){
	var getAccountId_Packet = new AJAXPacket("../s2890/f3505_getCustcode.jsp","���ڻ�ó�Ա�û����룬���Ժ�......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","custCode");
	getAccountId_Packet.data.add("idType","2");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet=null;
}
//���ù������棬�����û�����ѡ��
function getInfo_UserType()
{
    var pageTitle = "�û�����ѡ��";
    var fieldName = "�û����ʹ���|��������|";
		var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "1|0|";
    var retToField = "userType|";

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ�����Ʒ�ƣ�",0);
        return false;
    }
    //�ж��Ƿ�ѡ���˲�Ʒ����
    if(document.frm.product_attr_hidden.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�",0);
        return false;
    }

    if(PubSimpSelUserType(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
function PubSimpSelUserType(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s2890/fpubusertype_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&groupFlag=N";
    path = path + "&grpProductCode=" + document.all.grpProductCode.value;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&grpProductAttr=" + document.all.product_attr.value; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}
function getvalueUserType(retInfo)
{
  
  var retToField = "userType|";
  if(retInfo ==undefined)      
    {   return false;   }
    
    chPos_retInfo = retInfo.indexOf("|");
    
    var valueStr = retInfo.substring(0,chPos_retInfo);
    document.frm.userType.value= valueStr;
		
    retInfo = retInfo.substring(chPos_retInfo + 1);
    
    chPos_retInfo = retInfo.indexOf("|");
		
    valueStr = retInfo.substring(0,chPos_retInfo);

    document.frm.userType_hidden.value=valueStr;

    document.frm.mainProduct.value = "";
    document.frm.addProduct.value = "";
}
//���㼯�źͳ�Ա�ļ����ֶ�
function calcAllFieldValues_all()
{
	calcAllFieldValues_grp();
	
	calcAllFieldValues();
}
//������ײ�
function getMainBill(){
	var pageTitle = "";
    var fieldName = "";
	var sqlStr="";
	var regionCode="<%=regionCode%>";
	var md_type=document.all.userType.value;
	var sm_code=document.all.sm_code.value;
	//var addCode=UrlEncode('+');
	
	if (document.frm.userType.value==""){
		rdShowMessageDialog("����ѡ���û�����");
		return false;
	}
		pageTitle = "���ײͲ�ѯ";
		fieldName = "�ʷѴ���|�ʷ�����|ѡ���־|��ע|";
		sqlStr ="select a.mode_code,a.mode_name,to_char(sum(to_number(nvl(b.choiced_flag, '0')))),a.note from sbillmodecode a,cBillbadepend b where a.region_code = b.region_code(%2b) and a.mode_code = b.mode_code(%2b) and a.region_code ='"+regionCode+"' and a.sm_code = '"+sm_code+"' and a.MODE_TYPE ='"+md_type+"' and a.start_time<=sysdate and a.stop_time>sysdate and a.select_flag='0' and a.mode_flag ='0' and a.mode_status ='Y' group by a.mode_code , a.mode_name , a.note order by a.mode_code";
		var selType = "S";    //'S'��ѡ��'M'��ѡ
		var retQuence = "4|0|1|2|3|";
		var retToField = "modeCode|mainProduct|choiceFlag|";
		var returnNum="4";
		if(PubSimpSel_getMainBill(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,returnNum)){
			//�ж�ѡ����
			if (document.frm.choiceFlag.value==0){
				document.all.selectAdditive.disabled=true;
			}
			else 
				document.all.selectAdditive.disabled=false;
		}
		document.all.addProduct.value="";
}
function getAdditiveBill()
{
/*
	//�õ���ѡ�ʷ���Ϣ
	if (document.frm.mainProduct.value==""){
		rdShowMessageDialog("����ѡ�����ײ�");
		return false;
	}
*/
    var modeCode = document.frm.modeCode.value;
	var addMode = document.frm.addProduct.value;
    var path = "pubAdditiveBill_3505.jsp";
    path = path + "?pageTitle=" + "��ѡ�ʷ�ѡ��";
    path = path + "&orgCode=" + "<%=Department%>";
    path = path + "&smCode=id";
    path = path + "&modeCode=" + modeCode;
	path = path + "&existModeCode=" + addMode;
	path = path + "&userType=" + document.frm.userType.value;
    //window.open(path);
	//return false;

    var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:30;");
	if(typeof(retInfo) == "undefined")     
    {   return false;   }
	
	var addiMode=retInfo.substring(0,retInfo.indexOf("|"));
	//------��ѡ�ʷѷ����仯-----s------
	/*if(addiMode!=frm1104.additiveCode.value)
	{
	  frm1104.serviceResult.value="";
	  
	  frm1104.serviceNow.value="";
  	  frm1104.serviceAfter.value="";
  	  frm1104.serviceAddNo.value="";
	  
	  frm1104.tfFlag.value ="n";
	}*/
	//------��ѡ�ʷѷ����仯-----e------
	
    document.frm.addProduct.value =  addiMode;
    //frm1104.additivePayWay.value = retInfo.substring(1*retInfo.indexOf("|") + 1);
	//subPassFlag=true;
}
function PubSimpSel_getMainBill(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,returnNum)
{
    var path = "<%=request.getContextPath()%>/npage/s2890/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType; 
	path = path + "&returnNum=" + returnNum;
    retInfo = window.showModalDialog(path);
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
	return true;
}
function closefields()//�����һ��ʱ���Ѿ���õ��ֶβ����޸�
{
	document.frm.custQuery.disabled=true;
	document.frm.chkPass.disabled=true;
	document.frm.grpQuery.disabled=true;
	//document.frm.getGrpNo.disabled=true;
	document.frm.accountQuery.disabled=true;
	document.frm.prodQuery.disabled=true;
	document.frm.sm_code.disabled=true;
	document.frm.belong_code.disabled=true;
		
		<%
			if(nextFlag==2)
      {%>
				prod_direct_div.innerHTML = "<select id=prod_direct size=1 onChange=changeProdDirect() name=prod_direct><option><%=proddirectname[0][0]%></option></SELECT>";
		<%}%>
}
<%System.out.println("=============ajax2=============");%>
</script>
<BODY>
<FORM action="" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
<input type="hidden" id=hidPwd name="hidPwd" v_name="ԭʼ����">
<input type="hidden" name="chgsrv_start" value="">
<input type="hidden" name="chgsrv_stop"  value="">
<input type="hidden" name="product_level"  value="1">
<input type="hidden" name="product_name"  value="">
<input type="hidden" name="belong_codeNew"  value="<%=belong_codeNew%>">
<input type="hidden" name="prod_appendname"  value="">
<input type="hidden" name="tfFlag" value="n">
<input type="hidden" name="chgpkg_day"   value="">
<input type="hidden" name="TCustId"  value="">
<input type="hidden" name="unit_name"  value="">
<input type="hidden" name="tmp1"  value="">
<input type="hidden" name="tmp2"  value="">
<input type="hidden" name="tmp3"  value="">
<input type="hidden" name="org_id"  value="<%=OrgId%>">
<input type="hidden" name="group_id"  value="<%=GroupIdnew%>"><!--wuxy alter 20090328 value="<%=GroupId%>"-->   
<input type="hidden" name="login_accept"  value="0"> <!-- ������ˮ��-->
<input type="hidden" name="bill_type"  value="0"> <!-- �������� -->
<input type="hidden" name="product_prices"  value="<%=product_prices%>">
<input type="hidden" name="product_type"  value="">
<input type="hidden" name="service_code"  value="">
<input type="hidden" name="service_attr"  value="">
<input type="hidden" name="pay_no"  value="">
<input type="hidden" name="op_code"  value="2890">
<input type="hidden" name="OrgCode"  value="<%=org_code%>">
<input type="hidden" name="region_code"  value="<%=regionCode%>">
<input type="hidden" name="district_code"  value="<%=districtCode%>">
<input type="hidden" name="town_code1"  value="<%=townCode%>">
<input type="hidden" name="WorkNo"   value="<%=workno%>">
<input type="hidden" name="NoPass"   value="<%=nopass%>">
<input type="hidden" name="ip_Addr"  value=<%=ip_Addr%>>
<input type="hidden" name="cust_address"  value="<%=custAddress%>">
<input type="hidden" name="channel_id"  value="">
<input type="hidden" name="nameList_2890" value="<%=nameList_2890%>">
<input type="hidden" name="valueList_2890" value="<%=valueList_2890%>">
<input type="hidden" name="hid_pay_flag"  value="<%=hid_pay_flag%>">
<input type="hidden" name="hid_createFlag"  value="<%=hid_createFlag%>">
<input type="hidden" name="totalPay2"  value="">
<input type="hidden" name="sm_code_hidden"  value="<%=sm_code_hidden%>">
<input type="hidden" name="belong_code_hidden"  value="<%=belong_code_hidden%>">
<input type="hidden" name="billingtype"  value="<%=billingtype%>">
<input type="hidden" name="gongnengfee_hid"  value="<%=gongnengfee_hid%>">


        <TABLE cellSpacing="0">
          <TR>
            <TD class="blue">
              <div align="left">֤������</div>
            </TD>
            <TD>
                <input name=iccid <%if(nextFlag==2)out.println("readonly");%> id="iccid" size="24" maxlength="20" v_type="string" v_must=1 index="1" value="<%=iccid%>" >
                <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=��ѯ >
                <font color="orange">*</font>
            </TD>
            <TD class="blue">���ſͻ�ID</TD>
            <TD>
              <input type="text" name="cust_id" <%if(nextFlag==2)out.println("readonly");%> size="20" maxlength="11" v_type="0_9" v_must=1 index="2" value="<%=cust_id%>">
              <font color="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue">
               <div align="left">���ű���</div>
            </TD>
            <TD>
		    <input name=unit_id id="unit_id" <%if(nextFlag==2)out.println("readonly");%> size="24" maxlength="11" v_type="0_9" v_must=1  index="3" value="<%=unit_id%>">
            <font color="orange">*</font>
            </TD>
            <TD class="blue">���ſͻ�����</TD>
            <TD>
            <input name="cust_name" size="20" readonly v_must=1 v_type=string index="4" value="<%=cust_name%>">
              <font color="orange">*</font> </TD>
          </TR>
          <TR>
            <TD class="blue">���ſͻ�����</TD>
            <TD colspan="3">
            <%if(!ProvinceRun.equals("20"))  //���Ǽ���
			  		{
					%>       
                <jsp:include page="/npage/common/pwd_1.jsp">
                <jsp:param name="width1" value="16%"  />
	            <jsp:param name="width2" value="34%"  />
	            <jsp:param name="pname" value="custPwd"  />
	            <jsp:param name="pwd" value=""  />
 	            </jsp:include>
 	            
 	          	<%}else{%>
 	            <input name=custPwd type="password" id="custPwd" size="6" maxlength="6" v_must=1>
         		<%}%>   
         		<input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass2" value=У��>
            	<font color="orange">*</font>
            </TD>
            <!--��������ʡ���ţ�-->
            
              <input type="hidden" name="province" size="20"  
			  <%
        try
        {
                sqlStr = "select AGENT_PROV_CODE from sprovinceCode where run_flag = 'Y'";
           	  %>
           	  	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="resultTemp" scope="end" />
           	  <%	
                //sqlStr = "select '16' from dual";
                //retArray = callView.sPubSelect("1",sqlStr);
                if(resultTemp.length!=0)
                result = resultTemp;
                int recordNum = result.length;
                for(int i=0;i<recordNum;i++){
                    out.println("value='" + result[i][0] + "'");
                }
        }catch(Exception e){
                
        }
%>
			  readonly v_must=1 v_type="0_9" v_name="��������ʡ����" index="11"> <!--<font color="orange">*</font>-->
            
          </TR>
          <TR>
            <TD class="blue">����Ʒ��</TD>
            <TD>
				 <select name="sm_code" id="sm_code"   onChange="changeSmCode()" v_must=1 v_type="string" index="10" >
					<option  value='AD'  seqFlag='Y' payFlag='0' createFlag='Y' <%if(sm_code.equals("AD")){%>selected<%}%> >ADC</option>
					<option  value='ML'  seqFlag='Y' payFlag='0' createFlag='Y' <%if(sm_code.equals("ML")){%>selected<%}%> >����MAS</option>
					<option  value='MA'  seqFlag='Y' payFlag='0' createFlag='Y' <%if(sm_code.equals("MA")){%>selected<%}%> >ȫ��MAS</option>
					<font color="orange">*</font>
				 </select>
       			</TD>
		  		<TD class="blue">��������</TD>
      			<TD>
				<select name="belong_code" id="belong_code" <%if(nextFlag==2)out.println("readonly");%> >
<%//add
				try
				{
					sqlStr = "select substr('"+org_code+"',1,2),substr('"+org_code+"',1,7),'�������ڵ�' from dual "
                           +" union all select region_code,belong_code,belong_name from sBelongCode";
                    String[] inParams = new String[2];
					inParams[0] = "select substr(:org_code,1,2),substr(:org_code2,1,7),'�������ڵ�' from dual "
                           +" union all select region_code,belong_code,belong_name from sBelongCode";
				    inParams[1] = "org_code="+org_code+",org_code2="+org_code;
					//retArray = callView.sPubSelect("3",sqlStr);
%>
					
						
					<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="3">
					<wtc:sql><%=sqlStr%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="resultTemp2" scope="end" />
<%
					if(resultTemp2.length!=0)
					result = resultTemp2;
					//System.out.println("result[[][]===="+result[0][0]);
					int recordNum = result.length;
					for(int i=0;i<recordNum;i++)
					{
						//System.out.println(result[i][1]+"--"+result[i][2]);
						%>
						<option value="<%=result[i][1]%>" <%if(belong_code.equals(result[i][1])) out.println("selected");%>><%=result[i][1]%>--<%=result[i][2]%></option>
						<%
					}
				}catch(Exception e){
					
				}
%>
			<font color="orange">*</font>
			</select>
           </TD>
            <!--TD>������ʽ��</TD>
            <TD>
				<select name="openType" id="openType" onChange="changeOpenType()" v_must=1 v_type="string" v_name="������ʽ��" index="10">
					<option value='IDC'>IDCҵ�񿪻�</option>
				</select>
           </TD-->
          </TR>
            <TR>
            <TD class="blue">ҵ������</TD>
            <TD colspan="3">
            	<div id=prod_direct_div style='display:'>
            	</div>
       		</TD>
       	  </TR>
          <TR>
           <TD class="blue">�Ʒ�ʱ��</TD>
            <TD colspan="1">
	           <input name="billTime" class="button" <%if(nextFlag==2)out.println("readonly");%> type="text" v_must=1 v_maxlength=8 v_type="string" v_name="�Ʒ�ʱ��" index="8" value="<%=(billTime=="")?dateStr:billTime%>">
			   		 <font color="orange">*</font>
            </TD>
           <TD class="blue">���ѷ�ʽ</TD>
           <TD>
							<%if(nextFlag==2){
								System.out.println("*********hid_pay_flag***********"+hid_pay_flag);
							  if("0".equals(hid_pay_flag)){%>
							    <select name="pay_flag" id="pay_flag" disabled>
									<option value="0" selected>0--����ͳ��</option>
									<option value="2">2--���˸���</option>
								</select>
							<%}else{%>
							    <select name="pay_flag" id="pay_flag" disabled>
									<option value="0">0--����ͳ��</option>
									<option value="2" selected>2--���˸���</option>
								</select>
							<%}
						  }else{%>
						  	   <select name="pay_flag" id="pay_flag" <%if(nextFlag==2)out.println("readonly");%>>
									<option value="0">0--����ͳ��</option>
									<option value="2">2--���˸���</option>
								</select>
						  <%}%>
							<font color="orange">*</font>
							</select>
           </TD>
          </TR>

          <TR>
            <TD class="blue">���Ų�ƷID</TD>
            <TD>
              <input name="grp_id" type="text" class="InputGrey" size="20" maxlength="12" readonly v_type="0_9" v_must=1 value="<%=grp_id%>">
              <input name="grpQuery" type="button" id="grpQuery"  class="b_text" onMouseUp="getUserId();" onKeyUp="if(event.keyCode==13)getUserId();" value="��ȡ">
              <font color="orange">*</font>
            </TD>
            <TD class="blue">�û�����</TD>
            <TD>
              <input name="grp_name" type="text" size="20" maxlength="60" v_must=1 v_maxlength=60 v_type="string" value="<%=grp_name%>"  >
              <font color="orange">*</font>
            </TD>
          </TR>
          <TR>
          	<TD class="blue">�����ʻ�ID</TD>
            <TD colspan="3">
              <input name="account_id" type="text" class="InputGrey" size="20" maxlength="12" readonly v_type="0_9" v_must=1 value="<%=account_id%>">
              <input name="accountQuery" type="button" class="b_text" id="accountQuery" onMouseUp="getAccountId();" onKeyUp="if(event.keyCode==13)getAccountId();" value="��ȡ" >
              <font color="orange">*</font>
            </TD>
          
              <input name="grp_userno" type="hidden" class="InputGrey" size="20" maxlength="12" readonly  v_type="string"  value="<%=grp_userno%>">
            <!--  <input name="getGrpNo" type="button" class="button" id="getGrpNo" onMouseUp="getGrpUserNo();" onKeyUp="if(event.keyCode==13)getGrpUserNo();" value="���">-->
         
            
          </TR>
          <TR>
         	 <TD class="blue">���Ų�Ʒ</TD>
            <TD>
              <input class="InputGrey" type="text" name="product_code" size="20" readonly onChange="changeProduct()" v_must=1 v_type="string" value="<%=product_code%>">
              <input name="prodQuery" type="button" id="ProdQuery"  class="b_text" onMouseUp="getInfo_Prod();" onKeyUp="if(event.keyCode==13)getInfo_Prod();" value="ѡ��">
			  <font color="orange">*</font>
            </TD>
            <TD class="blue">ҵ������</TD>
            <TD>
            	<input class="InputGrey" type="hidden" name="bizCode" size="20" readonly  value="<%=bizCode%>">
            	<input class="InputGrey" type="text" name="bizName" size="30" readonly  value="<%=bizName%>"></TD>
           </TR>
          
			<TR id="tr_gongnengfee"  name="tr_gongnengfee" style="display:none" >
				<TD class="blue">���ܷѸ��ѷ�ʽ</TD>
		         <TD>
            	<select name="gongnengfee" id="gongnengfee" <%if(nextFlag==2)out.println("readonly");%>>
            		<option value="0"> 0-���Ÿ��� </option>
					<option value="1"> 1-���˸��� </option>
				</select>
				<font color="orange">*</font>
            </TD>
        </TR>
        
	   <%
			 if (nextFlag!=1){
			 %>
			 
			 <%}else{%>
		
			 	<%}%>
			 
<!---- ���ص��б�-->
  <!--��������-->
	<%
	//ͨ�ñ���
	boolean calcButtonFlag_all = false;
	
	
	
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
		String []fieldDefValue=new String[fieldCount];
		int iField=0;
		while(iField<fieldCount)
		{
			fieldCodes[iField]=resultList[iField][0];
			fieldNames[iField]=resultList[iField][1];
			fieldPurposes[iField]=resultList[iField][2];
			fieldValues[iField]="";
			dataTypes[iField]=resultList[iField][3];
			fieldLengths[iField]=resultList[iField][4];
			fieldGroupNo[iField]=resultList[iField][5];
			fieldGroupName[iField]=resultList[iField][6];
			fieldMaxRows[iField]=resultList[iField][7];
			fieldMinRows[iField]=resultList[iField][8];
			fieldCtrlInfos[iField]=resultList[iField][9]; 
			fieldDefValue[iField]=resultList[iField][10]; 
			iField++;
		}
		userType=request.getParameter("sm_code");
		
		%>
	
	<%@ include file="fpubDynaFields_grp.jsp"%>

  <!--��Ա����-->
  <%
 
		//Ϊinclude�ļ��ṩ����  
	
		if (resultList_usr != null)
		{
		fieldCount=resultList_usr.length;
		}
		else{
		fieldCount = 0;
		}
		isGroup = false;
		fieldCodes=new String[fieldCount];
		fieldNames=new String[fieldCount];
		fieldPurposes=new String[fieldCount];
		fieldValues=new String[fieldCount];
		dataTypes=new String[fieldCount];
		fieldLengths=new String[fieldCount];
		fieldGroupNo=new String[fieldCount];
		fieldGroupName=new String[fieldCount];
		fieldMaxRows=new String[fieldCount];
		fieldMinRows=new String[fieldCount];
		fieldCtrlInfos=new String[fieldCount];
		fieldDefValue=new String[fieldCount];
		iField=0;
		while(iField<fieldCount)
		{
			fieldCodes[iField]=resultList_usr[iField][0];
			fieldNames[iField]=resultList_usr[iField][1];
			fieldPurposes[iField]=resultList_usr[iField][2];
			fieldValues[iField]="";
			dataTypes[iField]=resultList_usr[iField][3];
			fieldLengths[iField]=resultList_usr[iField][4];
			fieldGroupNo[iField]=resultList_usr[iField][5];
			fieldGroupName[iField]=resultList_usr[iField][6];
			fieldMaxRows[iField]=resultList_usr[iField][7];
			fieldMinRows[iField]=resultList_usr[iField][8];
			fieldCtrlInfos[iField]=resultList_usr[iField][9]; 
			fieldDefValue[iField]=resultList_usr[iField][10]; 
			iField++;
		}
	
		userType=request.getParameter("userType");
		
	%>
	<%--@ include file="fpubDynaFields_usr.jsp"--%>     

<%
    if (calcButtonFlag_all)//����м����ֶ�����ʾ���㰴ť
		{
%>
			<TR>
				<TD colspan="4">
					<input value="������ɫ�Ǻŵ�ֵ" name=calcAll type=button id="calcAll" class="b_text" onMouseUp="calcAllFieldValues_all();" onKeyUp="if(event.keyCode==13)calcAllFieldValues_all();" style="cursor��hand">
				</TD>
			</TR>
<%
		}%>
		</table>		
		<TABLE cellspacing="0" style="display:<%=listShow%>">  
          <TR  style="display:none">
             <TD class="blue">��Ա�û�����</TD>
        	 <TD COLSPAN="1">
          		<input class="button" name="cust_code" size="20" readonly v_must=1 v_type=string index="4" >
	 			<input id="getUserOutNo" name="getUserOutNo" type="button" class="b_text" onMouseUp="getCustCode();" onKeyUp="if(event.keyCode==13)getCustCode();" value="���">
	  			<input id="verifyMebNo" name="verifyMebNo" type="button" class="button" style="display:'none' " onMouseUp="DoVerifyMebNo();" onKeyUp="if(event.keyCode==13)DoVerifyMebNo();" value="У��">
              <font color="orange">*</font>
            	</TD>
            <TD class="blue">���ײ�</TD>
            <TD colspan=3>
            	<input name="mainProduct1" class="InputGrey" type="text" v_must=1 v_maxlength=8 v_type="string" index="8" size=30 <% if(nextFlag==2){ %>value="<%=modeList[0][0]%>--><%=modeList[0][1]%>"<%}%> readonly >
            <input name="mainProduct" <% if(nextFlag==2){ %>value="<%=modeList[0][0]%>" <%}%>type=hidden  readonly >
            </TD>
          </TR>
         
     
          <TR>
             <%if(!ProvinceRun.equals("20"))  //���Ǽ���
			  		{
					%>  
			<jsp:include page="/npage/common/pwd_2.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="user_passwd"  />
				<jsp:param name="pcname" value="account_passwd"  />
			</jsp:include>
			 <%}else{%>
 	            
			
			 <TD class="blue"> 
			 	<div align="left">����</div>
			 </TD>
			 
			 <TD>
			 	<input name="user_passwd" type="password" maxlength=6 pwdlength="6">
			 </TD>
			 
			 <TD class="blue"> 
			 	<div align="left">����У��</div>
			 </TD>
			 
			 <TD>
			 	<input  name="account_passwd" type="password" prefield="user_passwd" filedtype="pwd" maxlength=6 pwdlength=6>	
			 </TD>
			 <%}%> 
          </TR>
          
          <input name="srv_start" type="hidden" id="srv_start"  onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>" size="20" maxlength="8" v_must=1 v_type="date" v_name="ҵ����ʼ����">
          <input name="srv_stop" type="hidden" class="InputGrey" id="srv_stop"  onKeyPress="return isKeyNumberdot(0)" value="<%=Date100%>" size="20" maxlength="8" v_must=1 v_type="date" v_name="ҵ���������" readonly> 
          <input name="credit_value" type="hidden"  value="1000" id="credit_value" size="20" maxlength="6" v_must=0 v_type="string" v_name="���ö�"> 
          <input name="credit_code" type="hidden"  id="credit_code3" value="E" size="20" maxlength="2" v_must=0 v_type="string" v_name="���õȼ�">
          <!--
          <TR>
            <TD>ҵ����ʼ���ڣ�</TD>
            <TD>
              <input name="srv_start" type="text" class="button" id="srv_start"  onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>" size="20" maxlength="8" v_must=1 v_type="date" v_name="ҵ����ʼ����"> <font color="orange">*</font>
            </TD>
            <TD>ҵ��������ڣ�</TD>
            <TD>
              <input name="srv_stop" type="text" class="button" id="srv_stop"  onKeyPress="return isKeyNumberdot(0)" value="<%=Date100%>" size="20" maxlength="8" v_must=1 v_type="date" v_name="ҵ���������" readonly> <font color="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD>���öȣ�</TD>
            <TD><input name="credit_value" type="text" class="button" value="1000" id="credit_value" size="20" maxlength="6" v_must=0 v_type="string" v_name="���ö�"> <font color="orange">*</font>
            </TD>
            <TD>���õȼ���</TD>
            <TD><input name="credit_code" type="text" class="button" id="credit_code3" value="E" size="20" maxlength="2" v_must=0 v_type="string" v_name="���õȼ�"> <font color="orange">*</font> </TD>
          </TR>
          -->
			<!--
		   <TR>
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
		  <TR>
		  <%
				try{
					
					sqlStr = "select hand_fee from sSmCode where function_Code ='2890'";
	                //retArray = callView.sPubSelect("1",sqlStr);
	       %>
	       			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="1">
					<wtc:sql><%=sqlStr%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="resultTemp3" scope="end" />
	       <%
	       			//System.out.println("result[][]==="+result.length);
		            result = resultTemp3;
					if (result.length==0){
						result = new String[1][1];
						result[0][0]="0.00";
					}
				}
				catch(Exception e){
					System.out.println("�����ѳ���!");
				}
			%>
			<input type="hidden" class="button" name="should_handfee" id="should_handfee" value="<%=result[0][0]%>" readonly>
			<input type="hidden" class="button" name="real_handfee" id="real_handfee" value="<%=result[0][0]%>" v_must=0 v_name="ʵ��������" v_type=money>
			
			<TR>
				<TD class="blue">���ʽ</TD>
				<TD><select name='payType' onchange='changePayType()'>
					<option value='0'>�ֽ�</option>
					<option value='9'>֧Ʊ</option>
					</select><font color="orange">*</font>
					</TD>
					<TD><font color=green>һ���Ը�����</font></TD>
				<TD colspan="1"><input name="cashNum" class="button" type="text" v_must=1 v_maxlength=8 v_type="string" v_name="������" index="8" value="" readOnly>
				<input name=cash_num type=button id="cash_num" class="b_text" onMouseUp="getCashNum();" onKeyUp="if(event.keyCode==13)getCashNum();" style="cursor��hand" value=��ѯ>
				<font color="orange">*</font>
				</TD>
			 </TR>
			  <tr id="cashPay_div" style="display:''">
            
           <td class="blue">�ֽ𽻿�</td>
            <td colspan="3">
			    <input class="InputGrey" type="text" name="cashPay" maxlength="10" readOnly value="">
				<input name="checkPass" id="next5" class="b_text" type="button" onClick="check_cashPay()" value="����У��">
				<font color="orange">*</font>
			</td>
         </tr>
           <TBODY>
             <TR id='checkPayTR'> 
                <TD nowrap class="blue"> 
                   <div align="left">֧Ʊ����</div>
                </TD>
                <TD nowrap> 
                    <input class="button" v_must=0  v_type="0_9" name=checkNo maxlength=20 onkeyup="if(event.keyCode==13)getBankCode();" index="50">
                    <font color="orange">*</font>
					<input name=bankCodeQuery type=button class="b_text" style="cursor:hand" onClick="getBankCode()" value=��ѯ>
				</TD>
                <TD nowrap class="blue"> 
                    <div align="left">���д���</div>
                </TD>
                <TD nowrap> 
                    <input name=bankCode size=12 class="InputGrey" maxlength="12" readonly>
					<input name=bankName size=20 class="InputGrey" readonly>
                </TD>                                              
            </TR>
           </TBODY>
           <TBODY> 
            <TR id='checkShow' style="display:none"> 
                  <TD class="blue" nowrap> 
                    <div align="left">֧Ʊ����</div>
                  </TD>
            	  <TD>
              	    <input v_must=0 v_type=money v_account=subentry name="checkPay" value="0.00" maxlength=15 index="51">
                    <font color="orange">*</font> </TD> 
                  <TD class="blue"> 
                    <div align="left">֧Ʊ���</div>
                  </TD>
                  <TD> 
                    <input class="InputGrey" name="checkPrePay" value=0.00 readonly>
                  </TD>               
            </TR>            
          </TBODY>
           <TR style="display:none">
               <TD class="blue">ϵͳ��ע</TD>
               <TD colspan="3">
               <input class="InputGrey" name="sysnote" size="60" readonly>
               <input class="InputGrey" name="tonote" size="60" readonly>
               </TD>
           </TR>
       </TABLE>

 <!-----------���ص��б�--> 
        <TABLE cellSpacing="0">
          <TBODY>
            <TR>
              <TD align=center id="footer">
			 <%
			 if (nextFlag==1){
			 %>
			
			 &nbsp;
			  <input name="next" class="b_foot"  type=button value="��һ��" onclick="nextStep()" disabled>
			  &nbsp; 
               <input class="b_foot" name=back  type=reset value="���">
			 <%
			 }else {
			 %>
			  <script>
			 closefields();
				</script>
			 &nbsp;
			  <input class="b_foot" name="previous"  type=button value="��һ��" onclick="previouStep()">
			  &nbsp;
              <input class="b_foot" name="sure"  type=button value="ȷ��" onclick="refMain()" disabled>
             <input class="b_foot" name="sure2"  type=button value="��ӡ���" onclick="refMain2()" disabled>
			 <%
			 }
			 %>
              
			   &nbsp;
              <input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="�ر�">
              </TD>
            </TR>
			<!-------------������--------------->
			<input type="hidden" name="modeCode" value="<%=(modeCode==null)?"":modeCode%>">
			<input type="hidden" name="addMode" value="<%=(addMode==null)?"":addMode%>">
			<input type="hidden" name="modeType">
			<input type="hidden" name="typeName">
			<input type="hidden" name="addMode">
			<input type="hidden" name="modeName">
			<input type="hidden" name="nameList_grp">
			<input type="hidden" name="nameGroupList_grp">	
			<input type="hidden" name="fieldNamesList_grp">
			<input type="hidden" name="nameList_usr">
			<input type="hidden" name="nameGroupList_usr">	
			<input type="hidden" name="fieldNamesList_usr">
			<input type="hidden" name="choiceFlag">
			<input type="hidden" name="grpProductCode">
			<input type="hidden" name="userTypeNew" value="<%=userTypeNew%>">
			<!-------------������--------------->
          </TBODY>
        </TABLE>
  
</div>

 <%@ include file="/npage/include/footer.jsp" %> 
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
</FORM>
 <script language="JavaScript">

<%
if (nextFlag==1)
{
%>
	getGrpUserNo();
	document.frm.iccid.focus();
	//query_prodAttr();
	getProdDirect(); 
<%
}
%>

	doOnLoad();
	
	<%
	
	if(nextFlag==2)
	{
		if(smProTypeList[0][2].trim().equals("Y"))
		{
		%>
			document.frm.getUserOutNo.disabled=false;
		<%
		}
		else
		{
		%>
			document.frm.getUserOutNo.disabled=true;
		<%	
		}
		%>
		var billingtype = document.all.billingtype.value;
		if(billingtype == "00" || billingtype == "01")//�����ѻ����
		{
			document.all.tr_gongnengfee.style.display = "none";
		}
		else if(billingtype == "02")//�������
		{
			document.all.tr_gongnengfee.style.display = "block";
		}
		document.all.gongnengfee.value=document.all.gongnengfee_hid.value;
		document.all.gongnengfee.disabled= true;
		<%
	}			
	%>
	
 </script>
</BODY>
</HTML>



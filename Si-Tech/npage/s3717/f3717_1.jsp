   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-12
********************/
%>
              
<%
	String opCode = request.getParameter("opCode");
	String flag ="";
	String flag1 = "";
	if(opCode.equals("3718")){
		flag="selected";
	}else if(opCode.equals("3719")){
		flag1="selected";
	}
	String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
	
	
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>


<%
    Logger logger = Logger.getLogger("f3717_1.jsp");

    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String orgCode = (String)session.getAttribute("orgCode");
    String nopass  = (String)session.getAttribute("password");
    String districtCode = orgCode.substring(2,4);
		String regionCode = (String)session.getAttribute("regCode");

    String sqlStr = "";

    String[][] result = new String[][]{};
		String[][] resulta = new String[][]{};
		String[][] resultList = new String[][]{};
		String should_handfee_str="0.00";
    productCfg prodcfg = new productCfg();
	int nextFlag=1;
	String listShow="none";
	StringBuffer nameList=new StringBuffer();
	StringBuffer nameValueList=new StringBuffer();
	StringBuffer nameGroupList=new StringBuffer();
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	//String [] valueList=new String[30]{};
	
	//ȡ����ʡ�ݴ��� -- Ϊ�������ӣ�ɽ������ʹ��session
	String[][] result2  = null;
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%	
	result2 = result_t1;
	String ProvinceRun = "";
	if (result2 != null && result2.length != 0) 
	{
		ProvinceRun = result2[0][0];
	}
	
//�õ�ҳ����� 
	String iccid      ="";
	String cust_id    ="";
	String unit_id    ="";
	String user_no    ="";
	String id_no      ="";
	String cust_code  ="";
	String userType   ="";
	String mainProduct="";
	String addProduct ="";
	String billType   ="0";
	String billTime   ="";
	String custPwd    ="";
	String modeCode   ="";
	String addMode    ="";
	String orderid    ="";
	String work_id    ="";
	String sm_code    ="";
	String sm_name    ="";
	String charge_type="";
	String custname   ="";
	String custAddress   ="";
	String hid_createFlag="";
	String hid_pay_flag = "";
	String userType_hidden = "";
	String accountMsg="";
	

	StringBuffer numberList=new StringBuffer();

//�õ��б����
	String action=request.getParameter("action");
	String modeType=request.getParameter("product_attr");
	int resultListLength=0;
	
	if (action!=null&&action.equals("select")){
		try{
             hid_createFlag=request.getParameter("hid_createFlag");
			 hid_pay_flag=request.getParameter("hid_pay_flag");
			 if("2".equals(hid_pay_flag)){
				hid_pay_flag=request.getParameter("pay_flag");
			 }

			 iccid=request.getParameter("iccid");
			 cust_id=request.getParameter("cust_id");
			 unit_id=request.getParameter("unit_id");
			 user_no=request.getParameter("user_no");
			 id_no=request.getParameter("id_no");
			 accountMsg=request.getParameter("accountMsg");
			 
			 custPwd=request.getParameter("custPwd");
			 cust_code=request.getParameter("cust_code");
			 if(ProvinceRun.equals("16"))    //ɽ��
			 {
			 	userType=request.getParameter("product_attr");
			 	mainProduct=request.getParameter("product_code");
			 	addProduct=request.getParameter("product_append");
			 }
			 else
			 {
			 	userType=request.getParameter("userType");
			 	userType_hidden=request.getParameter("userType_hidden");
			 	mainProduct=request.getParameter("mainProduct");
			 	addProduct=request.getParameter("addProduct");
			 }
			 billType=request.getParameter("billType");
			 billTime=request.getParameter("billTime");
			 modeCode=request.getParameter("modeCode");
			 addMode=request.getParameter("addMode");
			 sm_code=request.getParameter("sm_code");
			 sm_name=request.getParameter("sm_name");
			 charge_type=request.getParameter("charge_type");
			 custname=request.getParameter("custname");
			 custAddress=request.getParameter("cust_address");
			 
			//sqlStr= "select a.field_code,a.field_name,a.field_purpose,a.field_type,a.field_length,"
			//       +"  from sUserFieldCode a,sUserTypeFieldRela b"
			//	   +" where a.busi_type = b.busi_type"
			//	   +"   and a.field_code=b.field_code"
			//	   +"   and a.busi_type = '1000'"
			//	   +"   and b.user_type='"+userType+"'"
			//	   +" order by b.field_order";
			
			sqlStr= "select a.field_code,a.field_name,a.field_purpose,a.field_type,a.field_length,"
			       +" b.field_grp_no,c.field_grp_name,c.max_rows,c.min_rows,b.ctrl_info"
			       +"  from sUserFieldCode a,sUserTypeFieldRela b,sUserTypeGroup c"
				   +" where a.busi_type = b.busi_type"
				   +"   and a.field_code=b.field_code"
				   +"   and a.busi_type = '1000'"
				   +"   and b.user_type='"+userType+"'"
				   +"   and a.busi_type = c.busi_type"
				   +"   and b.user_type = c.user_type" 
				   +"   and b.field_grp_no = c.field_grp_no"
				   +" order by b.field_grp_no,b.field_order";
			//resultList=(String[][])callView.sPubSelect("10",sqlStr).get(0);
%>

		<wtc:pubselect name="sPubSelect" outnum="10" retmsg="msg4" retcode="code4" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t4" scope="end"/>

<%			
				resultList = result_t4;
				
				if(code4.equals("000000")){
				for(int i=0;i<result_t4.length;i++)
				{
					if (result_t4[i][2].equals("10")){
						numberList.append(resultList[i][0]+"|");
					}
				}
			}
			
			
 
			
			
			resultListLength=result.length;
			nextFlag=2;
			listShow="";
			//�õ����ݵ�����
			//�õ���������


		sqlStr ="select b.field_name,"
		+"decode(pay_flag,'0','���ڵ�һ��','1','�������һ��','2','���ڵ�һ��','3','�������һ��',''),"
       +"c.type_name,a.charge_unit,d.fee_code,e.detail_code"
       +"  from sUserFieldFee a,sUserFieldCode b,sChargeType c,"
       +"sFeeCode d,sFeeCodeDetail e"
       +" where a.busi_type=b.busi_type"
       +"   and a.busi_type='1000'"
       +"   and a.field_code=b.field_code"
       +"   and a.charge_type=c.charge_type"
       +"   and a.fee_code=d.fee_code"
       +"   and a.fee_code=e.fee_code"
       +"   and a.detail_code=e.detail_code"
	   +"   and a.user_type='"+userType+"'";
	System.out.println(sqlStr);
			
			//resulta=(String[][])callView.sPubSelect("6",sqlStr).get(0);
%>

		<wtc:pubselect name="sPubSelect" outnum="6" retmsg="msg5" retcode="code5" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t5" scope="end"/>

<%			
			
resulta = result_t5;
		}
		catch(Exception e){
		}
	}

	//ȡ��ˮ
	//sqlStr = "select to_char(sMaxSysAccept.nextval) FROM dual";
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="maxAccept" /> 

<HTML>
<HEAD>
<TITLE>BlackBerry��Ա����</TITLE>
</HEAD>
<SCRIPT type=text/javascript>


function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    self.status="";

    //---------------------------------------
    if(retType == "GrpCustInfo") //�û������û�����ʱ�ͻ���Ϣ��ѯ
    {
        var retname = packet.data.findValueByName("retname");
        if(retCode=="000000")
        {
            document.frm.cust_name.value = retname;
			document.frm.unit_id.focus();
        }
        else
        {
            retMessage = retMessage + "[errorCode1" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
            return false;
        }
     }
	 //----------------------------------------
	 if(retType == "custCode") //�õ���Ա�û�����
    {
        if(retCode == "000000")
        {
            var memIdNo = packet.data.findValueByName("memIdNo");
            document.frm.cust_code.value = memIdNo;
         }
        else
        {
            rdShowMessageDialog("û�еõ��ʻ�ID,�����»�ȡ��",0);
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
                //document.frm.sysnote.value ="IDC��Ա�û�����";
                //document.frm.tonote.value = "IDC��Ա�û�����";
                document.frm.next.disabled = false;
                document.frm.queryInfo.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("�ͻ�����У�����������У�飡",0);
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
			showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
			if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1){
				page = "f3505_2.jsp?sm_code="+document.all.sm_code.value;
				frm.action=page;
				frm.method="post";
				frm.submit();
			}
			else return false;
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
                rdShowMessageDialog("��֧Ʊ���ʻ����Ϊ0��",0);
            }
            else {   
					document.all(obj).style.display = "";            
			        frm.bankCode.value = bankCode;
					frm.bankName.value = bankName;
		            frm.checkPrePay.value = checkPrePay;  
					if(frm.real_handfee.value==''){//add
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
	if(retType == "getCheckNoInfo")
	{   //�õ�֧Ʊ��Ϣ 
        if(retCode=="0")
    	{
            var checkPrePay = packet.data.findValueByName("checkPrePay");
            if(checkPrePay == "0.00"){               
                frm.checkNo.focus();
                //document.all(obj).style.display = "none";
                rdShowMessageDialog("��֧Ʊ���ʻ����Ϊ0��",0);
            }
            else {   
					document.all(obj).style.display = "";            
		            frm.checkPrePay.value = checkPrePay;
				document.frm.checkPay.value=Math.round(document.frm.real_handfee.value)
					+Math.round(document.frm.cashNum.value);//�ܷ�
					
			}
		}
    	else
    	{
			var retMsg = packet.data.findValueByName("retMsg");
    	    retMsg = retMsg + "[errorCode9:" + retCode + "]";
    		rdShowMessageDialog(retMsg,0);               		
			return false;
    	}	
	}
	if(retType == "getCreateflag")//add
	{   //�õ��ͻ���ַ 
        if(retCode == "0")
        {
            var createFlag = packet.data.findValueByName("createFlag");
			var pay_flag = packet.data.findValueByName("pay_flag");
			frm.hid_createFlag.value = createFlag;
			frm.hid_pay_flag.value = pay_flag;
			if(pay_flag=='0'){
				frm.pay_flag.selected = pay_flag;
				frm.pay_flag.disabled = true;
			}else{
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
					document.all.productcode_div.style.display="";
<%
					if(ProvinceRun.equals("16"))    //ɽ��
					{
%>
						frm.product_code.v_must=1;
<%
					}
					else
					{
%>
						frm.mainProduct.v_must=1;
<%
					}
%>
				}
				else
				{
					frm.cust_code.readOnly=false;
					frm.getUserOutNo.style.display="none";
					frm.verifyMebNo.style.display="";
					document.all.productcode_div.style.display="none";
<%
					if(ProvinceRun.equals("16"))    //ɽ��
					{
%>
						frm.product_code.v_must=0;
<%
					}
					else
					{
%>
						frm.mainProduct.v_must=0;
<%
					}
%>
				}
            }
         }
        else
        {
            rdShowMessageDialog("��ȡcreateFlagʧ�ܣ������»�ȡ��");
    		return false;
        }
	}
    if(retType == "verifycustcode")//add
	{   //��֤cust_code 
        if(retCode == "0")
        {
				rdShowMessageDialog("�û�������ϢУ��ɹ���",2);
				frm.verifyMebNo.disabled=true;
         }
        else
        {
			var retMsg = packet.data.findValueByName("retMsg");
    		     	
    		     	if (rdShowConfirmDialog(retMsg+"<br>�Ƿ񱣴������Ϣ��")==1)	
					{
						
						
						var path="/npage/s3717/f3717_2_printxls.jsp?phoneNo=" + document.all.cust_code.value;
						path = path + "&returnMsg=" + retMsg;
						path = path +  "&unitID=" + document.all.unit_id.value;
	  					path = path + "&op_Code=" + "3718";
	  					path = path + "&orgCode=" + document.all.OrgCode.value;
          					
          					window.open(path);
          					
					}
			
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
	if(retType == "getDeteilInfo")//add
	{   //�õ���Ա�ն����ͺ��ʼ���ַ
      if(retCode == "0")
      {
          var email = packet.data.findValueByName("email");
          var phoneType = packet.data.findValueByName("phoneType");
          document.all.termType.value=phoneType;
          document.all.email.value=email;
          document.all.doDelete.disabled=false;
       }
      else
      {
          rdShowMessageDialog("��ȡ��Ա��Ϣʧ�ܣ������»�ȡ��");
  				return false;
  		}
 	}
	if(retType == "getSysAccept2")
  	{
    	if(retCode == "000000")
    	{		  
			var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.login_accept.value=sysAccept;
			var ret = showPrtDlg2("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
		    if(typeof(ret)!="undefined")
			{
				if((ret=="confirm"))
		        {
					if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
		          	{
		            	page = "f3717_delete.jsp";
						frm.action=page;
						frm.method="post";
						frm.submit();
		          	}
			    }
			    if(ret=="continueSub")
			    {
		        	if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		          	{
		            	page = "f3717_delete.jsp";
						frm.action=page;
						frm.method="post";
						frm.submit();
		          	}
			    }
			}
			else
			{
		        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		        {
		            	page = "f3717_delete.jsp";
						frm.action=page;
						frm.method="post";
						frm.submit();
		        }
			}
	  	}
    	else
    	{
      		rdShowMessageDialog("��ѯ��ˮ����,�����»�ȡ��");
			return false;
    	}
	}
}


//���ù������棬���м��ſͻ�ѡ��
function getInfo_Cust()
{
    var pageTitle = "���ſͻ�ѡ��";
    var fieldName = "֤������|���ſͻ�ID|���ſͻ�����|���Ų�ƷID|���Ų�Ʒ���|��Ʒ����|��Ʒ����|���ű��|���Ų�Ʒ�����ʻ�|ҵ��Ʒ��|Ʒ������|";
//    var fieldName = "֤������|�ͻ�ID|�����û�ID|���Ų�Ʒ����|����ID|ҵ��Ʒ��|";
	  var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "10|0|1|3|4|5|7|9|2|8|10|";
    var retToField = "iccid|cust_id|id_no|user_no|grpProductCode|unit_id|sm_code|custname|accountMsg|sm_name|";
    var cust_id = document.frm.cust_id.value;
    var custname = document.frm.custname.value;
    
    
    if(document.frm.iccid.value == "" &&
       document.frm.cust_id.value == "" &&
       document.frm.unit_id.value == "" &&
       document.frm.user_no.value == "")
    {
        rdShowMessageDialog("���������֤�š��ͻ�ID������ID�����û���Ž��в�ѯ��",0);
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

    if(document.frm.user_no.value == "0")
    {
    	frm.user_no.value = "";
        rdShowMessageDialog("���Ų�Ʒ��Ų���Ϊ0��",0);
    	return false;
    }

    PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s3717/fpubgrpusr_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
    path = path + "&cust_id=" + document.all.cust_id.value;
    path = path + "&unit_id=" + document.all.unit_id.value;
    path = path + "&user_no=" + document.all.user_no.value;
    path = path + "&busi_type=1000";

    retInfo = window.open(path,"newwindow","height=550, width=1030,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
    
	return true;
}

function getvaluecust(retInfo)
{
    var fieldName = "֤������|�ͻ�ID|���ſͻ�����|���Ų�ƷID|���Ų�Ʒ���|��Ʒ����|��Ʒ����|���ű��|���Ų�Ʒ�����ʻ�|ҵ��Ʒ��|Ʒ������|";
    var retQuence = "10|0|1|3|4|5|7|9|2|8|10|";

  var retToField = "iccid|cust_id|id_no|user_no|grpProductCode|unit_id|sm_code|custname|accountMsg|sm_name|";
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
        //alert(obj);
        //alert(valueStr);
        //alert("result="+document.frm.custname.value);
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
    }
    if (document.all.sm_code.value=='j1')
    {
	    document.all.cust_code.readOnly = false;
    	//document.all.getUserOutNo.style.display="none";
    }
	getCreateflag();
}
//���ù������棬���в�Ʒ��Ϣѡ��
function getInfo_Prod()
{
    var pageTitle = "���Ų�Ʒѡ��";
    var fieldName = "��Ʒ����|��Ʒ����|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "product_code|product_name|";

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ�����Ʒ�ƣ�",0);
        return false;
    }
    //�����ж��Ƿ��Ѿ�ѡ���˲�Ʒ����
    if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�",0);
        return false;
    }

    if(PubSimpProdSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpProdSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s3500/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
    path = path + "&product_attr=" + document.all.product_attr_hidden.value; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}
function getvalue(retInfo)
{
  var retToField = "product_code|product_name|";
  if(retInfo ==undefined)      
    {   return false;   }

  document.all.product_code.value = retInfo;
  document.frm.product_append.value = "";
}

//���ù������棬���в�Ʒ����ѡ��
function getInfo_ProdAttr()
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
        rdShowMessageDialog("������ѡ�����Ʒ�ƣ�",0);
        return false;
    }

    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s3500/fpubprodattr_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&groupFlag=N";
    path = path + "&grpProductCode=" + document.all.grpProductCode.value;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}
function getvalueProdAttr(retInfo)
{
  var retToField = "product_attr|";
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
    document.frm.product_code.value = "";
    document.frm.product_append.value = "";
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
    
    if(PubSimpSelUserType(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
function PubSimpSelUserType(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{ 
    var path = "/npage/s3500/fpubusertype_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&groupFlag=N";
    path = path + "&grpProductCode=" + document.all.grpProductCode.value;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value;

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
    document.frm.mainProduct.value = "";
    document.frm.addProduct.value = "";
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
        rdShowMessageDialog("������ѡ�����Ʒ�ƣ�",0);
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
    var path = "/npage/s3500/fpubprodappend_sel.jsp";
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

//������ײ�
function getMainBill(){
	var pageTitle = "";
    var fieldName = "";
	var sqlStr="";
	var regionCode="<%=regionCode%>";
	var md_type=document.all.userType.value;
	var sm_code=document.all.sm_code.value;
	//var addCode=UrlEncode('+');
	//alert("zzzzzzzzzzz"+addCode);
	
	if (document.frm.userType.value==""){
		rdShowMessageDialog("����ѡ���û�����");
		return false;
	}
		pageTitle = "���ײͲ�ѯ";
		fieldName = "�ʷѴ���|�ʷ�����|ѡ���־|��ע|";
		sqlStr ="select a.mode_code,a.mode_name,to_char(sum(to_number(nvl(b.choiced_flag, '0')))),a.note from sbillmodecode a,cBillbadepend b where a.region_code = b.region_code(%2b) and a.mode_code = b.mode_code(%2b) and a.region_code ='"+regionCode+"' and a.sm_code = '"+sm_code+"' and a.MODE_TYPE ='"+md_type+"' and a.start_time<=sysdate and a.stop_time>sysdate and a.select_flag='0' and a.mode_flag ='0' group by a.mode_code , a.mode_name , a.note order by a.mode_code";
		var selType = "S";    //'S'��ѡ��'M'��ѡ
		var retQuence = "4|0|1|2|3|";
		var retToField = "modeCode|mainProduct|choiceFlag|";
		var returnNum="4";
		if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,returnNum)){
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
    var path = "/npage/s3500/pubAdditiveBill_3505.jsp";
    path = path + "?pageTitle=" + "��ѡ�ʷ�ѡ��";
    path = path + "&orgCode=" + "<%=orgCode%>";
    path = path + "&smCode="+document.all.sm_code.value;
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
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,returnNum)
{
    var path = "/npage/s3500/fPubSimpSel.jsp";
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
function check_HidPwd()
{
    var user_no = document.all.user_no.value;
    var Pwd1 = document.all.custPwd.value;
    var checkPwd_Packet = new AJAXPacket("/npage/s3500/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("user_no",user_no);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;	
}
//��ó�Ա�û�����
function getCustCode(){
	var getAccountId_Packet = new AJAXPacket("/npage/s3500/f3505_getCustcode.jsp","���ڻ�ó�Ա�û����룬���Ժ�......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","custCode");
	getAccountId_Packet.data.add("idType","2");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet = null;
}
//ѡ��֧����ʽ
function changePayType(){
	var val=document.frm.payType.value;//���ѷ�ʽ
	var div1=document.all.cashPay_div;//�ֽ𽻿�
	var div2=document.all.checkNo_div;//֧Ʊ����
	var div3=document.all.checkPrePay_div;//֧Ʊ���
	
			if(val=='0'){//�ֽ�
				div1.style.display="block";
				div2.style.display="none";
				div3.style.display="none";
			}else{//֧Ʊ
				div1.style.display="none";
				div2.style.display="block";
				div3.style.display="block";
			}
	document.all.sure.disabled = true;
	document.all.sure2.disabled = true;
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
	getCheckInfo_Packet = null;
 }
 
 //��ѯ֧Ʊ����New!!!
function check_checkNo()
{ 
  	//���ù���js�õ����д���
    if((frm.checkNo.value).trim() == "")
    {
        rdShowMessageDialog("������֧Ʊ���룡",0);
        frm.checkNo.focus();
        return false;
    }
    var getCheckInfo_Packet = new AJAXPacket("check_checkNo.jsp","���ڻ��֧Ʊ�����Ϣ�����Ժ�......");
	getCheckInfo_Packet.data.add("retType","getCheckNoInfo");
    getCheckInfo_Packet.data.add("bank_code",document.frm.bank_code.value);
	getCheckInfo_Packet.data.add("checkNo",document.frm.checkNo.value);
	core.ajax.sendPacket(getCheckInfo_Packet);
	getCheckInfo_Packet = null;
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
	getCheckInfo_Packet = null;
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
    var getCheckInfo_Packet = new AJAXPacket("/npage/s3500/f3505_verifycustcode.jsp","���ڻ�������Ϣ�����Ժ�......");
	getCheckInfo_Packet.data.add("retType","verifycustcode");
    getCheckInfo_Packet.data.add("cust_code",document.frm.cust_code.value);
	getCheckInfo_Packet.data.add("sm_code",document.frm.sm_code.value);
	getCheckInfo_Packet.data.add("login_accept",document.frm.login_accept.value);
	core.ajax.sendPacket(getCheckInfo_Packet);
	getCheckInfo_Packet = null;
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
 //��һ��
function nextStep()
{
	if ((frm.pay_flag.value).trim()=="")
	{
		rdShowMessageDialog("����ѡ�񸶿ʽ",0);
        return false;
	}
	if(document.frm.hid_createFlag.value=='Y'){
		if((document.frm.cust_code.value).trim() == ""){
		rdShowMessageDialog("���ȡ��Ա�û����룡",0);
        return false;
	    }
	}else{
		if(document.frm.verifyMebNo.disabled!=true){
			rdShowMessageDialog("��У���Ա�û����룡",0);
			return false;
		}
	}
	<%if(ProvinceRun.equals("16"))   //ɽ��
	  {
	%>
    if((document.frm.product_attr.value).trim() == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�",0);
        return false;
    }
	if(((document.frm.product_code.value).trim(); == "") && (document.frm.product_code.v_must==1))
    {
        rdShowMessageDialog("��ѡ���Ա����Ʒ��",0);
        return false;
    }
    <%
      }
      else
      {
    %>
		    if((document.frm.userType.value).trim() == "")
		    {
		        rdShowMessageDialog("������ѡ���û����ͣ�",0);
		        return false;
		    }
				if(((document.frm.mainProduct.value).trim() == "") && (document.frm.mainProduct.v_must==1))
		    {
		        rdShowMessageDialog("��ѡ�����ײͣ�",0);
		        return false;
		    }
		    if(((document.frm.addProduct.value).trim() == "") && (document.frm.addProduct.v_must==1))
		    {
		        rdShowMessageDialog("��ѡ�񸽼��ײͣ�",0);
		        return false;
		    }
    <%
      }
    %>
    var opCode=document.all.op_code.value;
    var opName=document.all.op_name.value;
	frm.action="f3717_1.jsp?action=select&opCode="+opCode+"&opName="+opName;
	frm.method="post";
	frm.submit();
}
//��һ��
function previouStep(){
	//frm.action="f3505_1.jsp";
	//frm.method="post";
	//frm.submit();
	history.go(-1);
}
//��ӡ��Ϣ
function printInfo(printType)
{
     var retInfo = "";
    //getChinaFee(frm1104.sumPay.value);
    if(printType == "Detail")
    {	//��ӡ�������
    retInfo+=document.frm.iccid.value+"|"+"���֤��"+"|";
		retInfo+=document.frm.login_accept.value+"|"+"��ˮ��"+"|";
		retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		retInfo = retInfo + "15|10|10|0|" +document.frm.cust_id.value+ "|";   //�ֻ���
		retInfo = retInfo + "10|11|10|0|" + document.frm.iccid.value + "|";  //�û��� 	
        retInfo = retInfo + "5|19|9|0|" + "���Ų�Ʒ��Ա������ҵ��Ʊ��" + "|"; //ҵ����Ŀ    
 	}  
 	return retInfo;	
}

function printInfo2(printType)
{		

	  	var retInfo = "";
      retInfo+='<%=workno%>  <%=workname%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>'+"|";
      
      retInfo+="֤������"+document.all.iccid.value+"|";
      retInfo+="���Ų�ƷID"+document.all.id_no.value+"|";
	    retInfo+="��Ա�ֻ�����"+document.all.cust_code.value+"|";
      retInfo+="�û�����"+document.all.cust_name1.value +"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
      
      retInfo+="����ҵ��"+"BlackBerry��Ա�û�����"+"|";
      retInfo+="��ˮ��"+document.frm.login_accept.value+"|";
	    retInfo+=" "+"|";
	    retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";

	  return retInfo;
}

//��ʾ��ӡ�Ի���
function showPrtDlg(printType,DlgMessage,submitCfm)
{  
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var printStr = printInfo(printType);
   if(printStr == "failed")
   {    return false;   }

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
   var path = "/npage/s3500/gdPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
}

//��ʾ��ӡ�Ի���
function showPrtDlg2(printType,DlgMessage,submitCfm)
{  
   var h=165;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var printStr = printInfo2(printType);
   
   if(printStr == "failed")
   {    return false;   }

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     var path = "<%=request.getContextPath()%>/npage/innet/hljGdPrint.jsp?DlgMsg=" + DlgMessage;
     var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
     var ret=window.showModalDialog(path,"",prop);
     return ret;  
}

//ȡ��ˮ
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","�������ɲ�����ˮ�����Ժ�......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet = null;
}
function refMain()
{
		getAfterPrompt(document.all.op_code.value);
		if(!checkDynaFieldValues(true))
			return false;
		if (!calcAllFieldValues())
			return false;

		//˵�����ֳ�����,һ���������Ƿ��ǿ�,��һ���������Ƿ�Ϸ�.
        if(  document.frm.iccid.value == "" ){
            rdShowMessageDialog("֤������"+document.frm.iccid.value+",��������!!");
            document.frm.iccid.select();
            return false;
        }
        if(  document.frm.cust_id.value == "" ){
            rdShowMessageDialog("���Ŵ����������!!");
            document.frm.cust_id.select();
            return false;
        }
		//checkFlag = isValidYYYYMMDD(document.frm.billTime.value);
		
		if(!forDate(document.frm.billTime)){
			return ;
		}
		if(document.frm.cust_code.value==""){
			rdShowMessageDialog("��Ա�û����벻��Ϊ��!");
			return false;
		}
		if(document.frm.cashNum.value==""){
			rdShowMessageDialog("�������Ϊ��!");
			return false;
		}
		//�жϽ��
		if(!checkElement(document.frm.real_handfee)) return false;
		var hid_payType = document.frm.payType.value;
		if(hid_payType=='0'){//�ֽ�
			 var real_handfee = document.frm.real_handfee.value;
		     var cashNum = document.frm.cashNum.value;
			 var cashPay = document.frm.cashPay.value;
			 var totalPay = Math.round(real_handfee) + Math.round(cashNum);
			 document.frm.totalPay.value = totalPay;
			if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
			{
					rdShowMessageDialog("ʵ�������Ѳ�Ӧ����Ӧ��������");
					document.frm.real_handfee.focus();
					return false;	
			}
			//Ӧ����� == �����֮�ͣ�
			  if( Math.round( Math.round(real_handfee*100) + Math.round(cashNum*100)) != Math.round(cashPay*100) )
			  {
				   rdShowMessageDialog("�ֽ𽻿����������ȷ��!");		   
				   return false;
			  }

		}else{//֧Ʊ
			var real_handfee = document.frm.real_handfee.value;
		    var cashNum = document.frm.cashNum.value;
			var totalPay = Math.round(real_handfee) + Math.round(cashNum);
			document.frm.totalPay.value = totalPay;
			var checkPay = document.frm.checkPay.value;
			var checkPrePay = document.frm.checkPrePay.value;
			if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
			{
					rdShowMessageDialog("ʵ�������Ѳ�Ӧ����Ӧ��������");
					document.frm.real_handfee.focus();
					return false;	
			}
			if(Math.round( Math.round(checkPay*100)-Math.round(checkPrePay*100) ) > 0)
	       {
	           rdShowMessageDialog("֧Ʊ����ܴ���֧Ʊ���!");
               document.form1.checkPay.focus();
		       return false;
	       }
		   if( Math.round( Math.round(real_handfee*100) + Math.round(cashNum*100)) != Math.round(checkPay*100) )
			{
				   rdShowMessageDialog("֧Ʊ�������������ȷ��!");		   
				   return false;
			}
			if (parseFloat(document.frm.should_handfee.value)==0)
			{
				document.frm.real_handfee.value="0.00";
			}
		}
		//getSysAccept()
		//��ѯ�ͻ���ַcust_address
		query_custaddress();

		var prtFlag=0;
		//var confirmFlag=0;
		prtFlag = rdShowConfirmDialog("�Ƿ��ύ���β�����");

        if (prtFlag==1) {
			spellList();
			frm.action="f3717_2.jsp";
		    frm.submit(); 
	    } 

}
function refMain2()
{
			 var real_handfee = document.frm.real_handfee.value;
		         var cashNum = document.frm.cashNum.value;
			 var cashPay = document.frm.cashPay.value;
			 var totalPay2 = Math.round(real_handfee) + Math.round(0);
			 document.frm.totalPay2.value = totalPay2;
			//��ѯ�ͻ���ַcust_address
		query_custaddress();
		var prtFlag=0;
		//var confirmFlag=0;
		prtFlag = rdShowConfirmDialog("�Ƿ��ӡ���������");
       
        if (prtFlag==1) {
         	//alert("333");
         	//spellList();
	        //frm.action="sGrpPubPrint3505.jsp";
		var printPage="/npage/s3500/sGrpPubPrint.jsp?op_code=3718"
			+"&phone_no=" +document.all.cust_code.value       
			+"&function_name=BlackBerry��Ա�û�����"   
			+"&work_no="+"<%=workno%>"        
			+"&cust_name="+document.all.custname.value     
			+"&login_accept="+document.all.login_accept.value 
			+"&idIccid="+document.all.iccid.value    
			+"&pay_type="+document.all.pay_flag[document.all.pay_flag.selectedIndex].text        
			+"&mode_name="+document.all.sm_code.value       
			+"&custAddress="+document.all.cust_address.value     
			+"&system_note="+document.all.sysnote.value     
			+"&op_note="          
			+"&space="           
			+"&copynote=";

		   var printPage = window.open(printPage,"","width=200,height=200")
		   //frm.submit(); 
		}
}
//��ѯ�ͻ���ַ
function query_custaddress()
{
			if(document.frm.cust_id.value == "")
			{
				return false;
			}
			    var getInfoPacket = new AJAXPacket("/npage/s3500/s3500_custaddress.jsp","���ڲ�ѯ�ͻ���ַ�����Ժ�......");
				getInfoPacket.data.add("retType","custaddress");
				getInfoPacket.data.add("cust_id",document.frm.cust_id.value);
				core.ajax.sendPacket(getInfoPacket);
				getInfoPacket = null;
}
function doOnLoad(){
	var createFlag2 = frm.hid_createFlag.value;
         if(createFlag2=='Y')
				{
					frm.getUserOutNo.style.display="";
					frm.verifyMebNo.style.display="none";
					<%if(ProvinceRun.equals("16"))
					{
					%>
					document.all.productcode_div.style.display="";
					<%
					}
					%>
				}
		 else if(createFlag2=='N')
				{
					frm.cust_code.readOnly=false;
					frm.getUserOutNo.style.display="none";
					frm.verifyMebNo.style.display="";
					<%if(ProvinceRun.equals("16"))
					{
					%>
					document.all.productcode_div.style.display="none";
					<%
					}
					%>
				}
		 else if(createFlag2=='')
				{
					frm.getUserOutNo.style.display="";
					frm.verifyMebNo.style.display="none";
					<%if(ProvinceRun.equals("16"))
					{
					%>
					document.all.productcode_div.style.display=""
					<%
					}
					%>
				}
}

function changeBankCode(){
   document.all.bank_name.value="";
}

function getBankCode()
{
    var pageTitle = "���в�ѯ";
    var fieldName = "���д���|��������|";
	var sqlStr="select bank_code, bank_name "
				+"  from sBankCode "
				+" where region_code ='"+document.all.region_code.value+"'"
				+"   and district_code = '"+document.all.OrgCodevalue.value+"'";

    if(document.all.bank_code.value != "")
    {
        sqlStr = sqlStr + " and bank_code like '" + document.all.bank_code.value + "%'";
    }
    sqlStr = sqlStr + " order by bank_code" ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "bank_code|bank_name|";
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
			document.frm.sure2.disabled = false;
}

function check_checkPrePay(){
			if(document.frm.cashNum.value==""){
				rdShowMessageDialog("���ѯ������!");
				return false;
			}
			var real_handfee = document.frm.real_handfee.value;
			var cashNum = document.frm.cashNum.value;
			var checkPay = document.frm.checkPay.value;
			var checkPrePay = document.frm.checkPrePay.value;
			if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
			{
					rdShowMessageDialog("ʵ�������Ѳ�Ӧ����Ӧ��������");
					document.frm.real_handfee.focus();
					return false;	
			}
		   if(Math.round( Math.round(checkPay*100)-Math.round(checkPrePay*100) ) > 0)
	       {
	           rdShowMessageDialog("֧Ʊ����ܴ���֧Ʊ���!");
               document.form1.checkPay.focus();
		       return false;
	       }
		   if( Math.round( Math.round(real_handfee*100) + Math.round(cashNum*100)) != Math.round(checkPay*100) )
			{
				   rdShowMessageDialog("֧Ʊ�������������ȷ��!");		   
				   return false;
			}
			rdShowMessageDialog("�������ɹ�!",2);
			document.frm.sure.disabled = false;
			document.frm.sure2.disabled = false;
}
function closefields()//�����һ��ʱ���Ѿ���õ��ֶβ����޸�
{
				
				document.frm.custQuery.disabled=true;
				document.frm.getUserOutNo.disabled=true;
				document.frm.verifyMebNo.disabled=true;
				document.frm.chkPass.disabled=true;
				document.frm.UserTypeQuery.disabled=true;
				document.frm.selectMode.disabled=true;
				document.frm.selectAdditive.disabled=true;
				
				

}

function changeOp(obj){
	if(obj.value=="1"){
		/*
		if(document.all.iccid.value==""){
			rdShowMessageDialog("'֤������'����Ϊ�գ�");
			obj.value="0";
			return false;
		}
		*/
		document.all.queryInfo.style.display="";
		document.all.verifyMebNo.disabled=true;
		document.all.getUserOutNo.disabled=true;
		document.all.selectMode.disabled=true;
		document.all.selectAdditive.disabled=true;
		document.all.UserTypeQuery.disabled=true;
		document.all.doDelete.style.display="";
		document.all.next.style.display="none";
		document.getElementById("tr1").style.display="none";
		document.getElementById("tr2").style.display="none";
		document.getElementById("tr3").style.display="";
		document.getElementById("td1").style.display="";
		document.getElementById("td2").style.display="";
		document.getElementById("td3").colSpan="1";
		//document.getElementById("tr4").style.display="";
		//document.getElementById("tr5").style.display="";
		document.all.cust_code.readOnly=true;
		document.all.op_code.value="3719";
		document.all.op_name.value="BlackBerry��Աɾ��";
		getBeforePrompt("3719");
	}
	if(obj.value=="0"){
		document.all.queryInfo.style.display="none";
		document.all.verifyMebNo.disabled=false;
		document.all.getUserOutNo.disabled=false;
		document.all.selectMode.disabled=false;
		document.all.selectAdditive.disabled=false;
		document.all.UserTypeQuery.disabled=false;
		document.all.doDelete.style.display="none";
		document.all.next.style.display="";
		document.getElementById("td1").style.display="none";
		document.getElementById("td2").style.display="none";
		document.getElementById("td3").colSpan="3";
		document.getElementById("tr1").style.display="";
		document.getElementById("tr2").style.display="";
		//document.getElementById("tr4").style.display="none";
		//document.getElementById("tr5").style.display="none";
		document.getElementById("tr3").style.display="none";
		document.all.cust_code.readOnly=false;
		document.all.op_code.value="3718";
		document.all.op_name.value="BlackBerry��Ա���";
		getBeforePrompt("3718");
	}
}

function queryInf(){
	if(document.all.id_no.value==""){
		rdShowMessageDialog("����ͨ��֤�������ѯ������Ϣ!");
		return false;
	}
	var pageTitle = "BlackBerry��Ա��ѯ";
  var fieldName = "��Ա����|��Ա����|��ʼʱ��|����ʱ��|";
	var sqlStr= " select b.phone_no, c.cust_name, a.begin_time, a.end_time "
							+" from dGrpUserMebMsg a, dCustMsg b, dCustDoc c"
							+" where a.id_no = "+document.all.id_no.value 
							+" and   a.member_id = b.id_no"
							+" and   b.cust_id = c.cust_id";
  var selType = "S";    //'S'��ѡ��'M'��ѡ
  var retQuence = "4|0|1|2|3|";
  var retToField = "cust_code|cust_name1|";
  PubSimpSel3(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
	
}

function PubSimpSel3(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
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
    getDeteilInfo();
}


function getDeteilInfo(){
	var phoneNo=document.all.cust_code.value;
	var getDeteilInfo_Packet = new AJAXPacket("/npage/s3717/f3717_getDeteilInfo.jsp","���ڻ�������Ϣ�����Ժ�......");
	getDeteilInfo_Packet.data.add("retType","getDeteilInfo");
  	getDeteilInfo_Packet.data.add("phoneNo",phoneNo);
	core.ajax.sendPacket(getDeteilInfo_Packet);
	getDeteilInfo_Packet = null;
}

function dDelete(){
	getAfterPrompt(document.all.op_code.value);
	document.all.sysnote.value="BlackBerry��Ա�û�����";
	document.all.tonote.value="BlackBerry��Ա�û�����";
	getSysAccept2();

}

function getSysAccept2()
{
	var getSysAccept2_Packet = new AJAXPacket("/npage/s3500/pubSysAccept.jsp","�������ɲ�����ˮ�����Ժ�......");
	getSysAccept2_Packet.data.add("retType","getSysAccept2");
	core.ajax.sendPacket(getSysAccept2_Packet);
	getSysAccept2_Packet = null;
	
}
function getBeforePrompt(opCode)
{
	var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","���Ժ�...");
	packet.data.add("opCode" ,opCode);
  core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//�첽
	packet =null;
}

function doGetBeforePrompt(data)
{
	$('#wait').hide();
	$('#beforePrompt').html(data);
}

function getAfterPrompt(opCode)
{
	var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","���Ժ�...");
	packet.data.add("opCode" ,opCode);
  core.ajax.sendPacket(packet,doGetAfterPrompt,false);//ͬ��
	packet =null;
}

function doGetAfterPrompt(packet)
{
var retCode = packet.data.findValueByName("retCode"); 
var retMsg = packet.data.findValueByName("retMsg"); 
if(retCode=="000000"){
	promtFrame(retMsg);
}
}
 
</script>
<BODY onMouseDown="hideEvent()" onKeyDown="hideEvent()" onload="getBeforePrompt(<%=opCode%>);" >
<FORM action="" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">BlackBerry��Ա����</div>
	</div>
<input type="hidden" name="product_level"  value="1">
<input type="hidden" name="op_type" value="1">
<input type="hidden" name="grp_no" value="0">
<input type="hidden" name="tfFlag" value="n">
<input type="hidden" name="chgpkg_day"   value="">
<input type="hidden" name="TCustId"  value="">
<input type="hidden" name="unit_name"  value="">
<input type="hidden" name="login_accept"  value="<%=maxAccept%>"> <!-- ������ˮ�� -->
<input type="hidden" name="op_code"  value="<%=opCode%>"/>
<input type="hidden" name="op_name"  value="<%=opName%>"/>
<input type="hidden" name="OrgCode"  value="<%=orgCode%>">
<input type="hidden" name="OrgCodevalue"  value="<%=orgCode.substring(2,4)%>">
<input type="hidden" name="region_code"  value="<%=regionCode%>">
<input type="hidden" name="district_code"  value="<%=districtCode%>">
<input type="hidden" name="WorkNo"   value="<%=workno%>">
<input type="hidden" name="NoPass"   value="<%=nopass%>">
<input type="hidden" name="ip_Addr"  value="<%=ip_Addr%>">
<input type="hidden" name="hid_createFlag"  value="<%=hid_createFlag%>">
<input type="hidden" name="cust_address"  value="<%=custAddress%>">
<input type="hidden" name="hid_sumPay"  value="">
<input type="hidden" name="hid_pay_flag"  value="<%=hid_pay_flag%>">
<input type="hidden" name="totalPay"  value="">
<input type="hidden" name="totalPay2"  value="">
<%System.out.println("---------------------nextFlag-----------------"+nextFlag);%>
        <TABLE    cellSpacing="0">
          <TR >
            <TD width="18%">
              <div align="left" class="blue">֤������</div>
            </TD>
            <TD width="32%">
                <input name="iccid"  <%if(nextFlag==2)out.println("readonly Class='InputGrey'");%> id="iccid"   maxlength="18" v_type="string" v_must=1 v_name="֤������" index="1" value="<%=iccid%>">
                <input name=custQuery type=button id="custQuery"  onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursorhand" value=��ѯ class="b_text">
                <font class="orange">*</font>
            </TD>
            <TD width="18%" class="blue">���ſͻ�ID</TD>
            <TD width="32%">
              <input  type="text" <%if(nextFlag==2)out.println("readonly Class='InputGrey'");%> name="cust_id"   maxlength="18" v_type="0_9" v_must=1 v_name="���ſͻ�ID" index="2" value="<%=cust_id%>">
              <font class="orange">*</font>
            </TD>
          </TR>
          <TR >
            <TD>
               <div align="left" class="blue">���ű��</div>
            </TD>
            <TD>
		    <input name=unit_id  <%if(nextFlag==2)out.println("readonly Class='InputGrey'");%> id="unit_id"   maxlength="11" v_type="0_9" v_must=1 v_name="����ID" index="3" value="<%=unit_id%>">
            <font class="orange">*</font>
            </TD>
            <TD class="blue">���Ų�Ʒ����</TD>
            <TD>
              <input  name="user_no" <%if(nextFlag==2)out.println("readonly Class='InputGrey'");%>   v_must=1 v_type=string v_name="���Ų�Ʒ���" index="4" value="<%=user_no%>">
              <font class="orange">*</font>
            </TD>
          </TR>
          <TR >
            <TD class="blue">���Ų�ƷID</TD>
            <TD COLSPAN="1">
              <input  name="id_no"   readonly  Class="InputGrey" v_must=1 v_type=string v_name="�����û�ID" index="4" value="<%=id_no%>">
              <font class="orange">*</font>
            </TD>
            <TD class="blue">��Ʒ�����ʻ�</TD>
            <TD COLSPAN="1">
              <input  name="accountMsg"    readonly   Class="InputGrey"  v_must=1 v_type=string v_name="��Ʒ�����ʻ�" index="4" value="<%=accountMsg%>">
              <font class="orange">*</font>
            </TD>
			
          </TR>
           

          <TR >
            <TD class="blue">����Ʒ��</TD>
            <TD COLSPAN="1">
              <input  name="sm_name" value="<%=sm_name%>"  readonly  Class="InputGrey" >
              <input type="hidden"  name="sm_code"   readonly  Class="InputGrey"  v_must=1 v_type=string v_name="����Ʒ��" index="4" value="<%=sm_code%>">
            </TD>
			<TD class="blue">��������</TD>
                        <TD>
				<select name="belong_code" id="belong_code">
<%//add
				try
				{
					sqlStr = "select substr('"+orgCode+"',1,2),substr('"+orgCode+"',1,7),'�������ڵ�' from dual "
                           +"-- union all select region_code,belong_code,belong_name from sBelongCode";
					//retArray = callView.sPubSelect("3",sqlStr);
					
%>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>

<%					
					result = result_t3;
		
					int recordNum = result.length;
					for(int i=0;i<recordNum;i++)
					{
						%>
						<option value="<%=result[i][1]%>"><%=result[i][1]%>--<%=result[i][2]%></option>
						<%
					}
				}catch(Exception e){
					logger.error("Call sunView is Failed!");
				}
%>
			<font class="orange">*</font>
			</select>
           </TD>
          </TR>
          <TR >
            <TD class="blue">���Ų�Ʒ����</TD>
            <TD colspan="3">
<%
if(!ProvinceRun.equals("20"))  //���Ǽ���
{
%> 
              <jsp:include page="/npage/common/pwd_1.jsp">
              <jsp:param name="width1" value="16%"  />
	            <jsp:param name="width2" value="34%"  />
	            <jsp:param name="pname" value="custPwd"  />
	            <jsp:param name="pwd" value=""  />
 	            </jsp:include>
<%
}
else
{
%>
 	            <input name=custPwd type="password"  id="custPwd" size="6" maxlength="6" v_must=1>
<%
}
%>
	            <input name=chkPass type=button onClick="check_HidPwd();"  style="cursorhand" id="chkPass2" value=У�� class="b_text">
	            <font class="orange">*</font>
            </TD>
<%
if(ProvinceRun.equals("16"))  //ɽ��
{
%>            
            <TD class="blue">��Ʒ����</TD>
            <TD >
              <input  type="text" name="product_attr"   readonly   Class="InputGrey"  onChange="changeProdAttr()" v_must=1 v_type="string" v_name="��Ʒ����" value="<%=userType%>">
              <input name="ProdAttrQuery" type="button" id="ProdAttrQuery"   onMouseUp="getInfo_ProdAttr();" onKeyUp="if(event.keyCode==13)getInfo_ProdAttr();" value="ѡ��" class="b_text">
			  <font class="orange">*</font>
            </TD>
          </TR>
          <TR id="productcode_div" style="display: " >
            <TD class="blue">��Ա����Ʒ</TD>
            <TD  id="productcode_div" style="display:" colspan=3>
              <input  type="text" name="product_code"   readonly  Class="InputGrey"  onChange="changeProduct()" v_must=1 v_type="string" v_name="��Ա����Ʒ" value="<%=mainProduct%>">
              <input name="prodQuery" type="button" id="ProdQuery"   onMouseUp="getInfo_Prod();" onKeyUp="if(event.keyCode==13)getInfo_Prod();" value="ѡ��" class="b_text">
			  <font class="orange">*</font>
            </TD>
          </TR>
          <TR >
            <TD class="blue">��Ա���Ӳ�Ʒ</TD>
            <TD  colspan=3>
              <input  type="text" name="product_append"   readonly   Class="InputGrey" v_must=0 v_type="string" v_name="��Ա���Ӳ�Ʒ" value="<%=addProduct%>">
              <input name="ProdAppendQuery" type="button" id="ProdAppendQuery"   onMouseUp="getInfo_ProdAppend();" onKeyUp="if(event.keyCode==13)getInfo_ProdAppend();" value="ѡ��" class="b_text">
            </TD>
          </TR>
<%
}
else
{
%>
		  
          </TR>
          <%if(nextFlag==1){%>
          <TR >
          	<TD class="blue">��������</TD>
          	<TD colspan=3>
          		<select name="opType" onchange="changeOp(this)">
          			<option value="0" <%=flag%>>����</option>
          			<option value="1" <%=flag1%>>ɾ��</option>
          		</select>
          	</TD>
          <%}%>    
            	
          </TR>
          <TR  >
          	<TD class="blue">��Ա�û��ֻ�����</TD>
          	<TD id="td3" colspan=3>
              <input  name="cust_code"   v_must=1 v_type=string v_name="��Ա�û�����" index="4" value="<%=cust_code%>" maxlength=11>
						  <input id="getUserOutNo" name="getUserOutNo" type="button"  onMouseUp="getCustCode();" onKeyUp="if(event.keyCode==13)getCustCode();" value="���" class="b_text">
						  <input id="verifyMebNo" name="verifyMebNo" type="button"  style="display:none " onMouseUp="DoVerifyMebNo();" onKeyUp="if(event.keyCode==13)DoVerifyMebNo();" value="У��" class="b_text">
						  <input id="queryInfo" name="queryInfo" type="button"  style="display:none " onMouseUp="queryInf();" onKeyUp="if(event.keyCode==13) queryInf();" value="��ѯ" disabled class="b_text">
              <font class="orange">*</font>
          	</TD>  
          	<TD id="td1" style="display:none" class="blue">�û�����</TD>
          	<TD id="td2" style="display:none" >
              <input  name="cust_name1"   readonly   Class="InputGrey" type=text>
          	</TD>          	
          </TR>
          <%if(nextFlag==1){%>
          <TR  id="tr3" style="display:none">
          	<TD class="blue">�ͻ��ֻ��ͺ�</TD>
          	<TD>
              <input  type="text" name="termType"   readOnly  Class="InputGrey" >
          	</TD>
          	<TD class="blue">�����ʺ�</TD>
          	<TD>
              <input  type="text" name="email"   readOnly  Class="InputGrey" >
          	</TD>
          </TR>

          <%}%>
          <TR id="productcode_div" style="display: " >
            <TD class="blue">���ײ�</TD>
            <TD colspan=3>
            	<input name="mainProduct"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="����Ʒ" index="8" value="<%=mainProduct%>" readonly   Class="InputGrey" >
				<input  name=selectMode onkeyup="if(event.keyCode==13){getMainBill()}" onmouseup="getMainBill()"  style="cursor:hand" type=button value=ѡ�� index="19" class="b_text">
            <font class="orange">*</font>
            </TD>
          </TR>
          <TR  id="tr1">
          	<TD class="blue" >��Ա�û�����</TD>
		   	 <TD  colspan="1">
		      <input  type="text" name="userType_hidden"    readonly   Class="InputGrey"  onChange="changeProdAttr()" v_must=1 v_type="string" v_name="��Ʒ����" value="<%=userType_hidden%>">
             <input type="hidden" name="userType" id="userType" value="<%=userType%>"/>
              <input name="UserTypeQuery" type="button" id="UserTypeQuery"   onMouseUp="getInfo_UserType();" onKeyUp="if(event.keyCode==13)getInfo_UserType();" value="ѡ��" class="b_text">
           <font class="orange">*</font>
            </TD>
			<TD  class="blue">�����ײ�</TD>
            <TD  >
           <input name="addProduct"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="���Ӳ�Ʒ" index="8" value="<%=addProduct%>" readonly  Class="InputGrey" >
		   <input  id="selectAdditive" onkeyup="if(event.keyCode==13)getAdditiveBill()" onmouseup="getAdditiveBill()" style="cursor:hand" type=button value=ѡ��  index="20"  class="b_text">
		   <font class="orange">*</font>
            </TD>
            
          </TR>
<%
}
%>
		  <TR  id="tr2">
            <TD class="blue">���ѷ�ʽ</TD>
            <TD>
			<%if(nextFlag==2)
			{
				//System.out.println("*********hid_pay_flag***********"+hid_pay_flag);
				if("0".equals(hid_pay_flag))
			  	{%>
			    	<select name="pay_flag" id="pay_flag" disabled >
						<option value="0" selected > 0--����ͳ�� </option> 
						<option value="2"> 2--���˸��� </option>
					</select>
				<%}
				else
				{%>
			    	<select name="pay_flag" id="pay_flag" disabled>
						<option value="0">0--����ͳ�� </option> 
						<option value="2" selected > 2--���˸��� </option>
					</select>
				<%}
		  }
		  else
		  {%>
		  	   <select name="pay_flag" id="pay_flag">
					<option value="0">0--����ͳ�� </option> 
					<option value="2">2--���˸��� </option>
				</select>
		  <%}%>
			<font class="orange">*</font>
			</select>
            </TD>
			<TD width="18%" class="blue">�Ʒ�ʱ��</TD>
            <TD width="82%" colspan="1">
           <input name="billTime" v_format="yyyyMMdd" type="text" readOnly   Class="InputGrey" v_must=1 v_maxlength=8 v_type="string" v_name="�Ʒ�ʱ��" index="8" value="<%=(billTime=="")?dateStr:billTime%>" maxlength=8>
		   <font class="orange">*</font>
		   <input name="billType"  type="hidden" v_must=1 v_maxlength=8 v_type="string" v_name="��������" index="8" value="<%=billType%>">
            </TD>
          </TR>

        </TABLE>


 <TABLE  cellSpacing="0">
	<%
		//Ϊinclude�ļ��ṩ����  
		int fieldCount=0;
		if (resultList != null)
			fieldCount = resultList.length;
		boolean isGroup = false;
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
			fieldGroupNo[iField]=resultList[iField][5];
			fieldGroupName[iField]=resultList[iField][6];
			fieldMaxRows[iField]=resultList[iField][7];
			fieldMinRows[iField]=resultList[iField][8]; 
			fieldCtrlInfos[iField]=resultList[iField][9];  
			iField++;
		}
	%>
	<%@ include file="fpubDynaFields.jsp"%>
		<%if(!sm_code.equals("BY")) {%>

			<TR >
		  <%
				try{
					sqlStr = "select hand_fee from sNewFunctionFee where function_Code ='3505'";
	               // retArray = callView.sPubSelect("1",sqlStr);
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<%	                
		     result = result_t2;
		     
					if (result[0][0]!=""){
						should_handfee_str = result[0][0];
					}
				}
				catch(Exception e){
					System.out.println("�����ѳ���!");
				}
			%>
				
				<TD width="18%" class="blue">Ӧ��������</TD>
				<TD width="32%">
				<input  name="should_handfee" id="should_handfee" value="<%=should_handfee_str%>" readonly  Class="InputGrey" >
				</TD>
				<TD width="18%" class="blue">ʵ��������</TD>
				<TD width="32%">
				<input  name="real_handfee" id="real_handfee" value="0" v_must=0 v_name="ʵ��������" v_type=money>
				<TD>
				
		   </TR>
		   <TR >
				<TD width="18%" class="blue">���ʽ</TD>
				<TD width="32%"><select name='payType' onchange='changePayType()'>
					<option value='0'>�ֽ�</option>
					<option value='9'>֧Ʊ</option>
					</select><font class="orange">*</font>
				</TD>
				<TD><font color=green>һ���Ը�����</font></TD>
				<TD colspan="1"><input name="cashNum"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="������" index="8" value="" readOnly  Class="InputGrey" >
				<input name=cash_num type=button id="cash_num"  onMouseUp="getCashNum();" onKeyUp="if(event.keyCode==13)getCashNum();" style="cursorhand" value=��ѯ  class="b_text">
				<font class="orange">*</font>
				</TD>
		   </TR>
		 <tr  id="cashPay_div" style="display:">
            <td></td>
            <td></td>
           <td class="blue">�ֽ𽻿� </td>
            <td>
			    <input  type="text" name="cashPay" maxlength="10" readOnly   Class="InputGrey" value="">
				<input name="checkPass" id="next5" type="button" onClick="check_cashPay()"  value="����У��" class="b_text">
				<font class="orange">*</font>
			</td>
         </tr>
		<tr  id="checkNo_div" style="display:none">
            <td class="blue">���д��� </td>
            <td>
				<input type="text" name="bank_code"  maxlength="12" size="12" onChange="changeBankCode()" value="">
				<input type="text" name="bank_name"  disabled value="">
				<input name="townCodeQuery" type="button" onClick="getBankCode()" value="��ѯ" class="b_text">
			</td>
           <td class="blue">֧Ʊ���� </td>
            <td>
				<input  type="text" name="checkNo" maxlength="20" value="">
				<font class="orange">*</font>
				<input name="checkPass" id="next4" type="button" onClick="check_checkNo()"  value="��֤" class="b_text">    
			</td>
         </tr>
		 <tr  id="checkPrePay_div" style="display:none">
            <td width="15%">֧Ʊ���� </td>
            <td width="35%">
			    <input  type="text" name="checkPay" maxlength="10" readOnly   Class="InputGrey" value="">
			</td>
			<td>֧Ʊ��� </td>
            <td>
				<input  type="text" name="checkPrePay" maxlength="10" readonly  Class="InputGrey" >
				<input name="checkPass" id="next6" type="button" onClick="check_checkPrePay()"  value="����У��" class="b_text">
				<font class="orange">*</font>
			</td>
         </tr>
         	<%}else{%>
				<input type="hidden" name="should_handfee" value="0">
				<input type="hidden" name="real_handfee" value="0">
				<input type="hidden" name="cashNum" value="0">
				<input type="hidden" name="cashPay" value="0">
				<input type="hidden" name="payType" value="0">
  <%
			 if("1".equals(hid_pay_flag)){%>
  <TR >
            <TD class="blue">����˳��</TD>
            <TD COLSPAN="1">
              <input  name="payOrder"     v_must=1 v_type=string v_name="����˳��" index="4" value="0">
            </TD>
			<TD class="blue">���ñ���</TD>
                        <TD>
		<input  name="feeRate"     v_must=1 v_type=string v_name="���ñ���" index="4" value="1">
			<font class="orange">*</font>
			</select>
           </TD>
          </TR>				

				<%}}%>
			
	<TR >
               <TD width="18%" class="blue">ϵͳ��ע</TD>
               <TD colspan="3">
               <input  name="sysnote" size="60" 
                <%if(sm_code.equals("BY")) {%>
                value="BlackBerry��Ա���<%=cust_code%>" readonly  class="InputGrey"
                <%}else{%>
                value="���Ų�Ʒ��Ա���� <%=cust_code%>" readonly  class="InputGrey"
                <%}%>
               >
               
                               <input  name="tonote" size="60" 
                <%if(sm_code.equals("BY")) {%>
                value="BlackBerry��Ա��� <%=cust_code%>"
                <%}else{%>
                value="���Ų�Ʒ��Ա���� <%=cust_code%>"
                <%}%>  type="hidden"
                >
                
               </TD>
           </TR>

       </TABLE>
 <!-----------���ص��б�--> 
        <TABLE  cellSpacing="0">
          <TBODY>
            <TR >
              <TD align=center >
			 <%
			 if (nextFlag==1){
			 %>
			  <input name="next"   type=button value="��һ��" onclick="nextStep()" disabled class="b_foot">
			  <input name="doDelete"   type=button value="ɾ��" onclick="dDelete()"  style="display:none" class="b_foot">
			 <%
			 }else {
			 %>
			 <script>
			 closefields();
				</script>
			 &nbsp;
			  <input  name="previous"  type=button value="��һ��" onclick="previouStep()" class="b_foot">
			  &nbsp;
              <input  name="sure"  type=button value="ȷ  ��" onclick="refMain()" class="b_foot" >
			  <input  name="sure2"  type=button value="��ӡ���" onclick="refMain2()"  class="b_foot_long">
			 <%
			 }
			 %>
              &nbsp; 
               <input  name=back  type=button value="�� ��" onclick='window.location="f3717_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";' class="b_foot">
			   &nbsp;
              <input  name="kkkk"  onClick="removeCurrentTab()" type=button value="�� ��" class="b_foot">
              </TD>
            </TR>
			<!-------------������--------------->
			<input type="hidden" name="modeCode" value="<%=(modeCode==null)?"":modeCode%>">
			<input type="hidden" name="modeType">
			<input type="hidden" name="typeName">
			<input type="hidden" name="addMode" value="<%=(addMode==null)?"":addMode%>">
			<input type="hidden" name="modeName">
			<input type="hidden" name="nameList">
			<input type="hidden" name="nameValueList">	
			<input type="hidden" name="nameGroupList">
			<input type="hidden" name="fieldNamesList">
			<input type="hidden" name="choiceFlag">
			<input type="hidden" name="grpProductCode">
			
			<!-------------������--------------->
			<input type="hidden" name="custname" value="<%=custname%>">
          </TBODY>
        </TABLE>
	<div id="relationArea" style="display:none"></div>
				<div id="wait" style="display:none">
				<img  src="/nresources/default/images/blue-loading.gif" />
			</div>
			<div id="beforePrompt"></div>
		</DIV>             
</DIV>
 <!--input type="hidden" name="billType" value="<%=billType%>"--><!--��������-->
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
		<%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
<script language="JavaScript">
	 <%if (nextFlag==1){%>
	document.frm.iccid.focus();
	<%}%>
	doOnLoad();
</script>
</BODY>
</HTML>

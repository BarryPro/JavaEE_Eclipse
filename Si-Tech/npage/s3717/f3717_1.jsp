   
<%
/********************
 version v2.0
 开发商 si-tech
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
	
	//取运行省份代码 -- 为吉林增加，山西可以使用session
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
	
//得到页面参数 
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

//得到列表操作
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
			 if(ProvinceRun.equals("16"))    //山西
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
			//得到数据的行数
			//得到具体数据


		sqlStr ="select b.field_name,"
		+"decode(pay_flag,'0','周期第一月','1','周期最后一月','2','周期第一天','3','周期最后一天',''),"
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

	//取流水
	//sqlStr = "select to_char(sMaxSysAccept.nextval) FROM dual";
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="maxAccept" /> 

<HTML>
<HEAD>
<TITLE>BlackBerry成员管理</TITLE>
</HEAD>
<SCRIPT type=text/javascript>


function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    self.status="";

    //---------------------------------------
    if(retType == "GrpCustInfo") //用户集团用户销户时客户信息查询
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
	 if(retType == "custCode") //得到成员用户编码
    {
        if(retCode == "000000")
        {
            var memIdNo = packet.data.findValueByName("memIdNo");
            document.frm.cust_code.value = memIdNo;
         }
        else
        {
            rdShowMessageDialog("没有得到帐户ID,请重新获取！",0);
        }
    }
     //---------------------------------------
     if(retType == "checkPwd") //集团客户密码校验
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false") {
    	    	rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
	        	frm.custPwd.value = "";
	        	frm.custPwd.focus();
    	    	return false;	        	
            } else {
                rdShowMessageDialog("客户密码校验成功！",2);
                //document.frm.sysnote.value ="IDC成员用户开户";
                //document.frm.tonote.value = "IDC成员用户开户";
                document.frm.next.disabled = false;
                document.frm.queryInfo.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("客户密码校验出错，请重新校验！",0);
    		return false;
        }
     }	
	 //取流水
	if(retType == "getSysAccept")
     {
        if(retCode == "000000")
        {
            var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.login_accept.value=sysAccept;
			showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
			if (rdShowConfirmDialog("是否提交确认操作？")==1){
				page = "f3505_2.jsp?sm_code="+document.all.sm_code.value;
				frm.action=page;
				frm.method="post";
				frm.submit();
			}
			else return false;
         }
        else
        {
                rdShowMessageDialog("查询流水出错,请重新获取！",0);
				return false;
        }
    }
	 if(retType == "getCheckInfo")
	{   //得到支票信息
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
                rdShowMessageDialog("该支票的帐户余额为0！",0);
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
	{   //得到支票信息 
        if(retCode=="0")
    	{
            var checkPrePay = packet.data.findValueByName("checkPrePay");
            if(checkPrePay == "0.00"){               
                frm.checkNo.focus();
                //document.all(obj).style.display = "none";
                rdShowMessageDialog("该支票的帐户余额为0！",0);
            }
            else {   
					document.all(obj).style.display = "";            
		            frm.checkPrePay.value = checkPrePay;
				document.frm.checkPay.value=Math.round(document.frm.real_handfee.value)
					+Math.round(document.frm.cashNum.value);//总费
					
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
	{   //得到客户地址 
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
    	    	rdShowMessageDialog("获取createFlag失败！",0);
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
					if(ProvinceRun.equals("16"))    //山西
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
					if(ProvinceRun.equals("16"))    //山西
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
            rdShowMessageDialog("获取createFlag失败，请重新获取！");
    		return false;
        }
	}
    if(retType == "verifycustcode")//add
	{   //验证cust_code 
        if(retCode == "0")
        {
				rdShowMessageDialog("用户编码信息校验成功！",2);
				frm.verifyMebNo.disabled=true;
         }
        else
        {
			var retMsg = packet.data.findValueByName("retMsg");
    		     	
    		     	if (rdShowConfirmDialog(retMsg+"<br>是否保存错误信息？")==1)	
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
	{   //得到客户地址 
        if(retCode == "0")
        {
            var custAddress = packet.data.findValueByName("custAddress");
            if (custAddress == "false") {
    	    	rdShowMessageDialog("获取客户地址失败！",0);
    	    	return false;	        	
            } else {
                document.frm.cust_address.value = custAddress;
            }
         }
        else
        {
            rdShowMessageDialog("获取客户地址失败，请重新获取！");
    		return false;
        }
	}
	if(retType == "getDeteilInfo")//add
	{   //得到成员终端类型和邮件地址
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
          rdShowMessageDialog("获取成员信息失败，请重新获取！");
  				return false;
  		}
 	}
	if(retType == "getSysAccept2")
  	{
    	if(retCode == "000000")
    	{		  
			var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.login_accept.value=sysAccept;
			var ret = showPrtDlg2("Detail","确实要进行电子免填单打印吗？","Yes"); 
		    if(typeof(ret)!="undefined")
			{
				if((ret=="confirm"))
		        {
					if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
		          	{
		            	page = "f3717_delete.jsp";
						frm.action=page;
						frm.method="post";
						frm.submit();
		          	}
			    }
			    if(ret=="continueSub")
			    {
		        	if(rdShowConfirmDialog('确认要提交信息吗？')==1)
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
		        if(rdShowConfirmDialog('确认要提交信息吗？')==1)
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
      		rdShowMessageDialog("查询流水出错,请重新获取！");
			return false;
    	}
	}
}


//调用公共界面，进行集团客户选择
function getInfo_Cust()
{
    var pageTitle = "集团客户选择";
    var fieldName = "证件号码|集团客户ID|集团客户名称|集团产品ID|集团产品编号|产品代码|产品名称|集团编号|集团产品付费帐户|业务品牌|品牌名称|";
//    var fieldName = "证件号码|客户ID|集团用户ID|集团产品编码|集团ID|业务品牌|";
	  var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "10|0|1|3|4|5|7|9|2|8|10|";
    var retToField = "iccid|cust_id|id_no|user_no|grpProductCode|unit_id|sm_code|custname|accountMsg|sm_name|";
    var cust_id = document.frm.cust_id.value;
    var custname = document.frm.custname.value;
    
    
    if(document.frm.iccid.value == "" &&
       document.frm.cust_id.value == "" &&
       document.frm.unit_id.value == "" &&
       document.frm.user_no.value == "")
    {
        rdShowMessageDialog("请输入身份证号、客户ID、集团ID或集团用户编号进行查询！",0);
        document.frm.iccid.focus();
        return false;
    }

    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("必须是数字！",0);
    	return false;
    }

    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
        rdShowMessageDialog("必须是数字！",0);
    	return false;
    }

    if(document.frm.user_no.value == "0")
    {
    	frm.user_no.value = "";
        rdShowMessageDialog("集团产品编号不能为0！",0);
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
    var fieldName = "证件号码|客户ID|集团客户名称|集团产品ID|集团产品编号|产品代码|产品名称|集团编号|集团产品付费帐户|业务品牌|品牌名称|";
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
//调用公共界面，进行产品信息选择
function getInfo_Prod()
{
    var pageTitle = "集团产品选择";
    var fieldName = "产品代码|产品名称|";
	var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "product_code|product_name|";

    //首先判断是否已经选择了服务品牌
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择服务品牌！",0);
        return false;
    }
    //首先判断是否已经选择了产品属性
    if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("请首先选择产品属性！",0);
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

//调用公共界面，进行产品属性选择
function getInfo_ProdAttr()
{
    var pageTitle = "产品属性选择";
    var fieldName = "产品属性代码|产品属性|";
	var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "1|0|";
    var retToField = "product_attr|";

    //首先判断是否已经选择了服务品牌
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择服务品牌！",0);
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
//调用公共界面，进行用户类型选择
function getInfo_UserType()
{
    var pageTitle = "用户类型选择";
    var fieldName = "用户类型代码|类型名称|";
		var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "1|0|";
    var retToField = "userType|";

    //首先判断是否已经选择了服务品牌
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择服务品牌！",0);
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

//集团附加产品选择
function getInfo_ProdAppend()
{
    var pageTitle = "集团附加产品选择";
    var fieldName = "产品代码|产品名称|";
	var sqlStr = "";
    var selType = "M";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "product_append|product_name|";
    var product_code = document.frm.product_code.value;
    //首先判断是否已经选择了服务品牌
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择服务品牌！",0);
        return false;
    }
    //首先判断是否已经选择了产品属性
    if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("请首先选择产品属性！",0);
        return false;
    }
    //首先判断是否已经申请了集团产品
    if(document.frm.product_code.value == "")
    {
        rdShowMessageDialog("请首先选择集团产品！",0);
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

//获得主套餐
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
		rdShowMessageDialog("请先选择用户类型");
		return false;
	}
		pageTitle = "主套餐查询";
		fieldName = "资费代码|资费名称|选择标志|备注|";
		sqlStr ="select a.mode_code,a.mode_name,to_char(sum(to_number(nvl(b.choiced_flag, '0')))),a.note from sbillmodecode a,cBillbadepend b where a.region_code = b.region_code(%2b) and a.mode_code = b.mode_code(%2b) and a.region_code ='"+regionCode+"' and a.sm_code = '"+sm_code+"' and a.MODE_TYPE ='"+md_type+"' and a.start_time<=sysdate and a.stop_time>sysdate and a.select_flag='0' and a.mode_flag ='0' group by a.mode_code , a.mode_name , a.note order by a.mode_code";
		var selType = "S";    //'S'单选；'M'多选
		var retQuence = "4|0|1|2|3|";
		var retToField = "modeCode|mainProduct|choiceFlag|";
		var returnNum="4";
		if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,returnNum)){
			//判断选择标记
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
	//得到可选资费信息
	if (document.frm.mainProduct.value==""){
		rdShowMessageDialog("请先选择主套餐");
		return false;
	}
*/
    var modeCode = document.frm.modeCode.value;
	var addMode = document.frm.addProduct.value;
    var path = "/npage/s3500/pubAdditiveBill_3505.jsp";
    path = path + "?pageTitle=" + "可选资费选择";
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
	//------可选资费发生变化-----s------
	/*if(addiMode!=frm1104.additiveCode.value)
	{
	  frm1104.serviceResult.value="";
	  
	  frm1104.serviceNow.value="";
  	  frm1104.serviceAfter.value="";
  	  frm1104.serviceAddNo.value="";
	  
	  frm1104.tfFlag.value ="n";
	}*/
	//------可选资费发生变化-----e------
	
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
    var checkPwd_Packet = new AJAXPacket("/npage/s3500/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("user_no",user_no);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;	
}
//获得成员用户编码
function getCustCode(){
	var getAccountId_Packet = new AJAXPacket("/npage/s3500/f3505_getCustcode.jsp","正在获得成员用户编码，请稍候......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","custCode");
	getAccountId_Packet.data.add("idType","2");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet = null;
}
//选择支付方式
function changePayType(){
	var val=document.frm.payType.value;//付费方式
	var div1=document.all.cashPay_div;//现金交款
	var div2=document.all.checkNo_div;//支票号码
	var div3=document.all.checkPrePay_div;//支票余额
	
			if(val=='0'){//现金
				div1.style.display="block";
				div2.style.display="none";
				div3.style.display="none";
			}else{//支票
				div1.style.display="none";
				div2.style.display="block";
				div3.style.display="block";
			}
	document.all.sure.disabled = true;
	document.all.sure2.disabled = true;
}
//查询支票号码
function getBankCode()
{ 
  	//调用公共js得到银行代码
    if((frm.checkNo.value).trim() == "")
    {
        rdShowMessageDialog("请输入支票号码！",0);
        frm.checkNo.focus();
        return false;
    }
    var getCheckInfo_Packet = new AJAXPacket("getBankCode.jsp","正在获得支票相关信息，请稍候......");
	getCheckInfo_Packet.data.add("retType","getCheckInfo");
    getCheckInfo_Packet.data.add("checkNo",document.frm.checkNo.value);
	core.ajax.sendPacket(getCheckInfo_Packet);
	getCheckInfo_Packet = null;
 }
 
 //查询支票号码New!!!
function check_checkNo()
{ 
  	//调用公共js得到银行代码
    if((frm.checkNo.value).trim() == "")
    {
        rdShowMessageDialog("请输入支票号码！",0);
        frm.checkNo.focus();
        return false;
    }
    var getCheckInfo_Packet = new AJAXPacket("check_checkNo.jsp","正在获得支票相关信息，请稍候......");
	getCheckInfo_Packet.data.add("retType","getCheckNoInfo");
    getCheckInfo_Packet.data.add("bank_code",document.frm.bank_code.value);
	getCheckInfo_Packet.data.add("checkNo",document.frm.checkNo.value);
	core.ajax.sendPacket(getCheckInfo_Packet);
	getCheckInfo_Packet = null;
 }
 //查询getCreateflag
function getCreateflag()
{ 
    if((frm.sm_code.value).trim() == "")
    {
        rdShowMessageDialog("请获取业务类型！",0);
        frm.sm_code.focus();
        return false;
    }
    var getCheckInfo_Packet = new AJAXPacket("f3505_getflag.jsp","正在获得相关信息，请稍候......");
	getCheckInfo_Packet.data.add("retType","getCreateflag");
    getCheckInfo_Packet.data.add("sm_code",document.frm.sm_code.value);
	core.ajax.sendPacket(getCheckInfo_Packet);
	getCheckInfo_Packet = null;
 }

//校验成员用户编码 
function DoVerifyMebNo()
{ 
    if((frm.cust_code.value).trim() == "")
    {
        rdShowMessageDialog("请输入成员用户编码！",0);
        frm.cust_code.focus();
        return false;
    }
    var getCheckInfo_Packet = new AJAXPacket("/npage/s3500/f3505_verifycustcode.jsp","正在获得相关信息，请稍候......");
	getCheckInfo_Packet.data.add("retType","verifycustcode");
    getCheckInfo_Packet.data.add("cust_code",document.frm.cust_code.value);
	getCheckInfo_Packet.data.add("sm_code",document.frm.sm_code.value);
	getCheckInfo_Packet.data.add("login_accept",document.frm.login_accept.value);
	core.ajax.sendPacket(getCheckInfo_Packet);
	getCheckInfo_Packet = null;
 }
 //获得总计金额
function getCashNum(){
	if(!checkDynaFieldValues(true)){//输入基本月租费
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
 //下一步
function nextStep()
{
	if ((frm.pay_flag.value).trim()=="")
	{
		rdShowMessageDialog("请先选择付款方式",0);
        return false;
	}
	if(document.frm.hid_createFlag.value=='Y'){
		if((document.frm.cust_code.value).trim() == ""){
		rdShowMessageDialog("请获取成员用户编码！",0);
        return false;
	    }
	}else{
		if(document.frm.verifyMebNo.disabled!=true){
			rdShowMessageDialog("请校验成员用户编码！",0);
			return false;
		}
	}
	<%if(ProvinceRun.equals("16"))   //山西
	  {
	%>
    if((document.frm.product_attr.value).trim() == "")
    {
        rdShowMessageDialog("请首先选择产品属性！",0);
        return false;
    }
	if(((document.frm.product_code.value).trim(); == "") && (document.frm.product_code.v_must==1))
    {
        rdShowMessageDialog("请选择成员主产品！",0);
        return false;
    }
    <%
      }
      else
      {
    %>
		    if((document.frm.userType.value).trim() == "")
		    {
		        rdShowMessageDialog("请首先选择用户类型！",0);
		        return false;
		    }
				if(((document.frm.mainProduct.value).trim() == "") && (document.frm.mainProduct.v_must==1))
		    {
		        rdShowMessageDialog("请选择主套餐！",0);
		        return false;
		    }
		    if(((document.frm.addProduct.value).trim() == "") && (document.frm.addProduct.v_must==1))
		    {
		        rdShowMessageDialog("请选择附加套餐！",0);
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
//上一步
function previouStep(){
	//frm.action="f3505_1.jsp";
	//frm.method="post";
	//frm.submit();
	history.go(-1);
}
//打印信息
function printInfo(printType)
{
     var retInfo = "";
    //getChinaFee(frm1104.sumPay.value);
    if(printType == "Detail")
    {	//打印电子免填单
    retInfo+=document.frm.iccid.value+"|"+"身份证号"+"|";
		retInfo+=document.frm.login_accept.value+"|"+"流水号"+"|";
		retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		retInfo = retInfo + "15|10|10|0|" +document.frm.cust_id.value+ "|";   //手机号
		retInfo = retInfo + "10|11|10|0|" + document.frm.iccid.value + "|";  //用户名 	
        retInfo = retInfo + "5|19|9|0|" + "集团产品成员开户（业务发票）" + "|"; //业务项目    
 	}  
 	return retInfo;	
}

function printInfo2(printType)
{		

	  	var retInfo = "";
      retInfo+='<%=workno%>  <%=workname%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>'+"|";
      
      retInfo+="证件号码"+document.all.iccid.value+"|";
      retInfo+="集团产品ID"+document.all.id_no.value+"|";
	    retInfo+="成员手机号码"+document.all.cust_code.value+"|";
      retInfo+="用户名称"+document.all.cust_name1.value +"|";
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
      
      retInfo+="办理业务"+"BlackBerry成员用户销户"+"|";
      retInfo+="流水号"+document.frm.login_accept.value+"|";
	    retInfo+=" "+"|";
	    retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";

	  return retInfo;
}

//显示打印对话框
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

//显示打印对话框
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

//取流水
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","正在生成操作流水，请稍候......");
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

		//说明检测分成两类,一类是数据是否是空,另一类是数据是否合法.
        if(  document.frm.iccid.value == "" ){
            rdShowMessageDialog("证件号码"+document.frm.iccid.value+",必须输入!!");
            document.frm.iccid.select();
            return false;
        }
        if(  document.frm.cust_id.value == "" ){
            rdShowMessageDialog("集团代码必须输入!!");
            document.frm.cust_id.select();
            return false;
        }
		//checkFlag = isValidYYYYMMDD(document.frm.billTime.value);
		
		if(!forDate(document.frm.billTime)){
			return ;
		}
		if(document.frm.cust_code.value==""){
			rdShowMessageDialog("成员用户编码不能为空!");
			return false;
		}
		if(document.frm.cashNum.value==""){
			rdShowMessageDialog("付款金额不能为空!");
			return false;
		}
		//判断金额
		if(!checkElement(document.frm.real_handfee)) return false;
		var hid_payType = document.frm.payType.value;
		if(hid_payType=='0'){//现金
			 var real_handfee = document.frm.real_handfee.value;
		     var cashNum = document.frm.cashNum.value;
			 var cashPay = document.frm.cashPay.value;
			 var totalPay = Math.round(real_handfee) + Math.round(cashNum);
			 document.frm.totalPay.value = totalPay;
			if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
			{
					rdShowMessageDialog("实收手续费不应大于应收手续费");
					document.frm.real_handfee.focus();
					return false;	
			}
			//应交金额 == 各金额之和？
			  if( Math.round( Math.round(real_handfee*100) + Math.round(cashNum*100)) != Math.round(cashPay*100) )
			  {
				   rdShowMessageDialog("现金交款计算有误，请确认!");		   
				   return false;
			  }

		}else{//支票
			var real_handfee = document.frm.real_handfee.value;
		    var cashNum = document.frm.cashNum.value;
			var totalPay = Math.round(real_handfee) + Math.round(cashNum);
			document.frm.totalPay.value = totalPay;
			var checkPay = document.frm.checkPay.value;
			var checkPrePay = document.frm.checkPrePay.value;
			if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
			{
					rdShowMessageDialog("实收手续费不应大于应收手续费");
					document.frm.real_handfee.focus();
					return false;	
			}
			if(Math.round( Math.round(checkPay*100)-Math.round(checkPrePay*100) ) > 0)
	       {
	           rdShowMessageDialog("支票交款不能大于支票余额!");
               document.form1.checkPay.focus();
		       return false;
	       }
		   if( Math.round( Math.round(real_handfee*100) + Math.round(cashNum*100)) != Math.round(checkPay*100) )
			{
				   rdShowMessageDialog("支票交款计算有误，请确认!");		   
				   return false;
			}
			if (parseFloat(document.frm.should_handfee.value)==0)
			{
				document.frm.real_handfee.value="0.00";
			}
		}
		//getSysAccept()
		//查询客户地址cust_address
		query_custaddress();

		var prtFlag=0;
		//var confirmFlag=0;
		prtFlag = rdShowConfirmDialog("是否提交本次操作？");

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
			//查询客户地址cust_address
		query_custaddress();
		var prtFlag=0;
		//var confirmFlag=0;
		prtFlag = rdShowConfirmDialog("是否打印电子免填单？");
       
        if (prtFlag==1) {
         	//alert("333");
         	//spellList();
	        //frm.action="sGrpPubPrint3505.jsp";
		var printPage="/npage/s3500/sGrpPubPrint.jsp?op_code=3718"
			+"&phone_no=" +document.all.cust_code.value       
			+"&function_name=BlackBerry成员用户开户"   
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
//查询客户地址
function query_custaddress()
{
			if(document.frm.cust_id.value == "")
			{
				return false;
			}
			    var getInfoPacket = new AJAXPacket("/npage/s3500/s3500_custaddress.jsp","正在查询客户地址，请稍候......");
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
    var pageTitle = "银行查询";
    var fieldName = "银行代码|银行名称|";
	var sqlStr="select bank_code, bank_name "
				+"  from sBankCode "
				+" where region_code ='"+document.all.region_code.value+"'"
				+"   and district_code = '"+document.all.OrgCodevalue.value+"'";

    if(document.all.bank_code.value != "")
    {
        sqlStr = sqlStr + " and bank_code like '" + document.all.bank_code.value + "%'";
    }
    sqlStr = sqlStr + " order by bank_code" ;
    var selType = "S";    //'S'单选；'M'多选
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
				rdShowMessageDialog("请查询付款金额!");
				return false;
			}
			var real_handfee = document.frm.real_handfee.value;
			var cashNum = document.frm.cashNum.value;
			if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
			{
					rdShowMessageDialog("实收手续费不应大于应收手续费");
					document.frm.real_handfee.focus();
					return false;	
			}
			document.frm.cashPay.value=Math.round(real_handfee)+Math.round(cashNum);//总费
			rdShowMessageDialog("交款计算成功!",2);
			document.frm.sure.disabled = false;
			document.frm.sure2.disabled = false;
}

function check_checkPrePay(){
			if(document.frm.cashNum.value==""){
				rdShowMessageDialog("请查询付款金额!");
				return false;
			}
			var real_handfee = document.frm.real_handfee.value;
			var cashNum = document.frm.cashNum.value;
			var checkPay = document.frm.checkPay.value;
			var checkPrePay = document.frm.checkPrePay.value;
			if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
			{
					rdShowMessageDialog("实收手续费不应大于应收手续费");
					document.frm.real_handfee.focus();
					return false;	
			}
		   if(Math.round( Math.round(checkPay*100)-Math.round(checkPrePay*100) ) > 0)
	       {
	           rdShowMessageDialog("支票交款不能大于支票余额!");
               document.form1.checkPay.focus();
		       return false;
	       }
		   if( Math.round( Math.round(real_handfee*100) + Math.round(cashNum*100)) != Math.round(checkPay*100) )
			{
				   rdShowMessageDialog("支票交款计算有误，请确认!");		   
				   return false;
			}
			rdShowMessageDialog("交款计算成功!",2);
			document.frm.sure.disabled = false;
			document.frm.sure2.disabled = false;
}
function closefields()//点击下一步时，已经填好的字段不可修改
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
			rdShowMessageDialog("'证件号码'不能为空！");
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
		document.all.op_name.value="BlackBerry成员删除";
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
		document.all.op_name.value="BlackBerry成员添加";
		getBeforePrompt("3718");
	}
}

function queryInf(){
	if(document.all.id_no.value==""){
		rdShowMessageDialog("请先通过证件号码查询集团信息!");
		return false;
	}
	var pageTitle = "BlackBerry成员查询";
  var fieldName = "成员号码|成员名称|开始时间|结束时间|";
	var sqlStr= " select b.phone_no, c.cust_name, a.begin_time, a.end_time "
							+" from dGrpUserMebMsg a, dCustMsg b, dCustDoc c"
							+" where a.id_no = "+document.all.id_no.value 
							+" and   a.member_id = b.id_no"
							+" and   b.cust_id = c.cust_id";
  var selType = "S";    //'S'单选；'M'多选
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
	var getDeteilInfo_Packet = new AJAXPacket("/npage/s3717/f3717_getDeteilInfo.jsp","正在获得相关信息，请稍候......");
	getDeteilInfo_Packet.data.add("retType","getDeteilInfo");
  	getDeteilInfo_Packet.data.add("phoneNo",phoneNo);
	core.ajax.sendPacket(getDeteilInfo_Packet);
	getDeteilInfo_Packet = null;
}

function dDelete(){
	getAfterPrompt(document.all.op_code.value);
	document.all.sysnote.value="BlackBerry成员用户销户";
	document.all.tonote.value="BlackBerry成员用户销户";
	getSysAccept2();

}

function getSysAccept2()
{
	var getSysAccept2_Packet = new AJAXPacket("/npage/s3500/pubSysAccept.jsp","正在生成操作流水，请稍候......");
	getSysAccept2_Packet.data.add("retType","getSysAccept2");
	core.ajax.sendPacket(getSysAccept2_Packet);
	getSysAccept2_Packet = null;
	
}
function getBeforePrompt(opCode)
{
	var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","请稍后...");
	packet.data.add("opCode" ,opCode);
  core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//异步
	packet =null;
}

function doGetBeforePrompt(data)
{
	$('#wait').hide();
	$('#beforePrompt').html(data);
}

function getAfterPrompt(opCode)
{
	var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","请稍后...");
	packet.data.add("opCode" ,opCode);
  core.ajax.sendPacket(packet,doGetAfterPrompt,false);//同步
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
		<div id="title_zi">BlackBerry成员管理</div>
	</div>
<input type="hidden" name="product_level"  value="1">
<input type="hidden" name="op_type" value="1">
<input type="hidden" name="grp_no" value="0">
<input type="hidden" name="tfFlag" value="n">
<input type="hidden" name="chgpkg_day"   value="">
<input type="hidden" name="TCustId"  value="">
<input type="hidden" name="unit_name"  value="">
<input type="hidden" name="login_accept"  value="<%=maxAccept%>"> <!-- 操作流水号 -->
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
              <div align="left" class="blue">证件号码</div>
            </TD>
            <TD width="32%">
                <input name="iccid"  <%if(nextFlag==2)out.println("readonly Class='InputGrey'");%> id="iccid"   maxlength="18" v_type="string" v_must=1 v_name="证件号码" index="1" value="<%=iccid%>">
                <input name=custQuery type=button id="custQuery"  onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursorhand" value=查询 class="b_text">
                <font class="orange">*</font>
            </TD>
            <TD width="18%" class="blue">集团客户ID</TD>
            <TD width="32%">
              <input  type="text" <%if(nextFlag==2)out.println("readonly Class='InputGrey'");%> name="cust_id"   maxlength="18" v_type="0_9" v_must=1 v_name="集团客户ID" index="2" value="<%=cust_id%>">
              <font class="orange">*</font>
            </TD>
          </TR>
          <TR >
            <TD>
               <div align="left" class="blue">集团编号</div>
            </TD>
            <TD>
		    <input name=unit_id  <%if(nextFlag==2)out.println("readonly Class='InputGrey'");%> id="unit_id"   maxlength="11" v_type="0_9" v_must=1 v_name="集团ID" index="3" value="<%=unit_id%>">
            <font class="orange">*</font>
            </TD>
            <TD class="blue">集团产品号码</TD>
            <TD>
              <input  name="user_no" <%if(nextFlag==2)out.println("readonly Class='InputGrey'");%>   v_must=1 v_type=string v_name="集团产品编号" index="4" value="<%=user_no%>">
              <font class="orange">*</font>
            </TD>
          </TR>
          <TR >
            <TD class="blue">集团产品ID</TD>
            <TD COLSPAN="1">
              <input  name="id_no"   readonly  Class="InputGrey" v_must=1 v_type=string v_name="集团用户ID" index="4" value="<%=id_no%>">
              <font class="orange">*</font>
            </TD>
            <TD class="blue">产品付费帐户</TD>
            <TD COLSPAN="1">
              <input  name="accountMsg"    readonly   Class="InputGrey"  v_must=1 v_type=string v_name="产品付费帐户" index="4" value="<%=accountMsg%>">
              <font class="orange">*</font>
            </TD>
			
          </TR>
           

          <TR >
            <TD class="blue">服务品牌</TD>
            <TD COLSPAN="1">
              <input  name="sm_name" value="<%=sm_name%>"  readonly  Class="InputGrey" >
              <input type="hidden"  name="sm_code"   readonly  Class="InputGrey"  v_must=1 v_type=string v_name="服务品牌" index="4" value="<%=sm_code%>">
            </TD>
			<TD class="blue">归属地区</TD>
                        <TD>
				<select name="belong_code" id="belong_code">
<%//add
				try
				{
					sqlStr = "select substr('"+orgCode+"',1,2),substr('"+orgCode+"',1,7),'工号所在地' from dual "
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
            <TD class="blue">集团产品密码</TD>
            <TD colspan="3">
<%
if(!ProvinceRun.equals("20"))  //不是吉林
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
	            <input name=chkPass type=button onClick="check_HidPwd();"  style="cursorhand" id="chkPass2" value=校验 class="b_text">
	            <font class="orange">*</font>
            </TD>
<%
if(ProvinceRun.equals("16"))  //山西
{
%>            
            <TD class="blue">产品属性</TD>
            <TD >
              <input  type="text" name="product_attr"   readonly   Class="InputGrey"  onChange="changeProdAttr()" v_must=1 v_type="string" v_name="产品属性" value="<%=userType%>">
              <input name="ProdAttrQuery" type="button" id="ProdAttrQuery"   onMouseUp="getInfo_ProdAttr();" onKeyUp="if(event.keyCode==13)getInfo_ProdAttr();" value="选择" class="b_text">
			  <font class="orange">*</font>
            </TD>
          </TR>
          <TR id="productcode_div" style="display: " >
            <TD class="blue">成员主产品</TD>
            <TD  id="productcode_div" style="display:" colspan=3>
              <input  type="text" name="product_code"   readonly  Class="InputGrey"  onChange="changeProduct()" v_must=1 v_type="string" v_name="成员主产品" value="<%=mainProduct%>">
              <input name="prodQuery" type="button" id="ProdQuery"   onMouseUp="getInfo_Prod();" onKeyUp="if(event.keyCode==13)getInfo_Prod();" value="选择" class="b_text">
			  <font class="orange">*</font>
            </TD>
          </TR>
          <TR >
            <TD class="blue">成员附加产品</TD>
            <TD  colspan=3>
              <input  type="text" name="product_append"   readonly   Class="InputGrey" v_must=0 v_type="string" v_name="成员附加产品" value="<%=addProduct%>">
              <input name="ProdAppendQuery" type="button" id="ProdAppendQuery"   onMouseUp="getInfo_ProdAppend();" onKeyUp="if(event.keyCode==13)getInfo_ProdAppend();" value="选择" class="b_text">
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
          	<TD class="blue">操作类型</TD>
          	<TD colspan=3>
          		<select name="opType" onchange="changeOp(this)">
          			<option value="0" <%=flag%>>新增</option>
          			<option value="1" <%=flag1%>>删除</option>
          		</select>
          	</TD>
          <%}%>    
            	
          </TR>
          <TR  >
          	<TD class="blue">成员用户手机号码</TD>
          	<TD id="td3" colspan=3>
              <input  name="cust_code"   v_must=1 v_type=string v_name="成员用户编码" index="4" value="<%=cust_code%>" maxlength=11>
						  <input id="getUserOutNo" name="getUserOutNo" type="button"  onMouseUp="getCustCode();" onKeyUp="if(event.keyCode==13)getCustCode();" value="获得" class="b_text">
						  <input id="verifyMebNo" name="verifyMebNo" type="button"  style="display:none " onMouseUp="DoVerifyMebNo();" onKeyUp="if(event.keyCode==13)DoVerifyMebNo();" value="校验" class="b_text">
						  <input id="queryInfo" name="queryInfo" type="button"  style="display:none " onMouseUp="queryInf();" onKeyUp="if(event.keyCode==13) queryInf();" value="查询" disabled class="b_text">
              <font class="orange">*</font>
          	</TD>  
          	<TD id="td1" style="display:none" class="blue">用户名称</TD>
          	<TD id="td2" style="display:none" >
              <input  name="cust_name1"   readonly   Class="InputGrey" type=text>
          	</TD>          	
          </TR>
          <%if(nextFlag==1){%>
          <TR  id="tr3" style="display:none">
          	<TD class="blue">客户手机型号</TD>
          	<TD>
              <input  type="text" name="termType"   readOnly  Class="InputGrey" >
          	</TD>
          	<TD class="blue">邮箱帐号</TD>
          	<TD>
              <input  type="text" name="email"   readOnly  Class="InputGrey" >
          	</TD>
          </TR>

          <%}%>
          <TR id="productcode_div" style="display: " >
            <TD class="blue">主套餐</TD>
            <TD colspan=3>
            	<input name="mainProduct"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="主产品" index="8" value="<%=mainProduct%>" readonly   Class="InputGrey" >
				<input  name=selectMode onkeyup="if(event.keyCode==13){getMainBill()}" onmouseup="getMainBill()"  style="cursor:hand" type=button value=选择 index="19" class="b_text">
            <font class="orange">*</font>
            </TD>
          </TR>
          <TR  id="tr1">
          	<TD class="blue" >成员用户类型</TD>
		   	 <TD  colspan="1">
		      <input  type="text" name="userType_hidden"    readonly   Class="InputGrey"  onChange="changeProdAttr()" v_must=1 v_type="string" v_name="产品属性" value="<%=userType_hidden%>">
             <input type="hidden" name="userType" id="userType" value="<%=userType%>"/>
              <input name="UserTypeQuery" type="button" id="UserTypeQuery"   onMouseUp="getInfo_UserType();" onKeyUp="if(event.keyCode==13)getInfo_UserType();" value="选择" class="b_text">
           <font class="orange">*</font>
            </TD>
			<TD  class="blue">附加套餐</TD>
            <TD  >
           <input name="addProduct"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="附加产品" index="8" value="<%=addProduct%>" readonly  Class="InputGrey" >
		   <input  id="selectAdditive" onkeyup="if(event.keyCode==13)getAdditiveBill()" onmouseup="getAdditiveBill()" style="cursor:hand" type=button value=选择  index="20"  class="b_text">
		   <font class="orange">*</font>
            </TD>
            
          </TR>
<%
}
%>
		  <TR  id="tr2">
            <TD class="blue">付费方式</TD>
            <TD>
			<%if(nextFlag==2)
			{
				//System.out.println("*********hid_pay_flag***********"+hid_pay_flag);
				if("0".equals(hid_pay_flag))
			  	{%>
			    	<select name="pay_flag" id="pay_flag" disabled >
						<option value="0" selected > 0--集团统付 </option> 
						<option value="2"> 2--个人付费 </option>
					</select>
				<%}
				else
				{%>
			    	<select name="pay_flag" id="pay_flag" disabled>
						<option value="0">0--集团统付 </option> 
						<option value="2" selected > 2--个人付费 </option>
					</select>
				<%}
		  }
		  else
		  {%>
		  	   <select name="pay_flag" id="pay_flag">
					<option value="0">0--集团统付 </option> 
					<option value="2">2--个人付费 </option>
				</select>
		  <%}%>
			<font class="orange">*</font>
			</select>
            </TD>
			<TD width="18%" class="blue">计费时间</TD>
            <TD width="82%" colspan="1">
           <input name="billTime" v_format="yyyyMMdd" type="text" readOnly   Class="InputGrey" v_must=1 v_maxlength=8 v_type="string" v_name="计费时间" index="8" value="<%=(billTime=="")?dateStr:billTime%>" maxlength=8>
		   <font class="orange">*</font>
		   <input name="billType"  type="hidden" v_must=1 v_maxlength=8 v_type="string" v_name="结算类型" index="8" value="<%=billType%>">
            </TD>
          </TR>

        </TABLE>


 <TABLE  cellSpacing="0">
	<%
		//为include文件提供数据  
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
					System.out.println("手续费出错!");
				}
			%>
				
				<TD width="18%" class="blue">应收手续费</TD>
				<TD width="32%">
				<input  name="should_handfee" id="should_handfee" value="<%=should_handfee_str%>" readonly  Class="InputGrey" >
				</TD>
				<TD width="18%" class="blue">实收手续费</TD>
				<TD width="32%">
				<input  name="real_handfee" id="real_handfee" value="0" v_must=0 v_name="实收手续费" v_type=money>
				<TD>
				
		   </TR>
		   <TR >
				<TD width="18%" class="blue">付款方式</TD>
				<TD width="32%"><select name='payType' onchange='changePayType()'>
					<option value='0'>现金</option>
					<option value='9'>支票</option>
					</select><font class="orange">*</font>
				</TD>
				<TD><font color=green>一次性付款金额</font></TD>
				<TD colspan="1"><input name="cashNum"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="付款金额" index="8" value="" readOnly  Class="InputGrey" >
				<input name=cash_num type=button id="cash_num"  onMouseUp="getCashNum();" onKeyUp="if(event.keyCode==13)getCashNum();" style="cursorhand" value=查询  class="b_text">
				<font class="orange">*</font>
				</TD>
		   </TR>
		 <tr  id="cashPay_div" style="display:">
            <td></td>
            <td></td>
           <td class="blue">现金交款 </td>
            <td>
			    <input  type="text" name="cashPay" maxlength="10" readOnly   Class="InputGrey" value="">
				<input name="checkPass" id="next5" type="button" onClick="check_cashPay()"  value="交款校验" class="b_text">
				<font class="orange">*</font>
			</td>
         </tr>
		<tr  id="checkNo_div" style="display:none">
            <td class="blue">银行代码 </td>
            <td>
				<input type="text" name="bank_code"  maxlength="12" size="12" onChange="changeBankCode()" value="">
				<input type="text" name="bank_name"  disabled value="">
				<input name="townCodeQuery" type="button" onClick="getBankCode()" value="查询" class="b_text">
			</td>
           <td class="blue">支票号码 </td>
            <td>
				<input  type="text" name="checkNo" maxlength="20" value="">
				<font class="orange">*</font>
				<input name="checkPass" id="next4" type="button" onClick="check_checkNo()"  value="验证" class="b_text">    
			</td>
         </tr>
		 <tr  id="checkPrePay_div" style="display:none">
            <td width="15%">支票交款 </td>
            <td width="35%">
			    <input  type="text" name="checkPay" maxlength="10" readOnly   Class="InputGrey" value="">
			</td>
			<td>支票余额 </td>
            <td>
				<input  type="text" name="checkPrePay" maxlength="10" readonly  Class="InputGrey" >
				<input name="checkPass" id="next6" type="button" onClick="check_checkPrePay()"  value="交款校验" class="b_text">
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
            <TD class="blue">冲销顺序</TD>
            <TD COLSPAN="1">
              <input  name="payOrder"     v_must=1 v_type=string v_name="冲销顺序" index="4" value="0">
            </TD>
			<TD class="blue">费用比率</TD>
                        <TD>
		<input  name="feeRate"     v_must=1 v_type=string v_name="费用比率" index="4" value="1">
			<font class="orange">*</font>
			</select>
           </TD>
          </TR>				

				<%}}%>
			
	<TR >
               <TD width="18%" class="blue">系统备注</TD>
               <TD colspan="3">
               <input  name="sysnote" size="60" 
                <%if(sm_code.equals("BY")) {%>
                value="BlackBerry成员添加<%=cust_code%>" readonly  class="InputGrey"
                <%}else{%>
                value="集团产品成员开户 <%=cust_code%>" readonly  class="InputGrey"
                <%}%>
               >
               
                               <input  name="tonote" size="60" 
                <%if(sm_code.equals("BY")) {%>
                value="BlackBerry成员添加 <%=cust_code%>"
                <%}else{%>
                value="集团产品成员开户 <%=cust_code%>"
                <%}%>  type="hidden"
                >
                
               </TD>
           </TR>

       </TABLE>
 <!-----------隐藏的列表--> 
        <TABLE  cellSpacing="0">
          <TBODY>
            <TR >
              <TD align=center >
			 <%
			 if (nextFlag==1){
			 %>
			  <input name="next"   type=button value="下一步" onclick="nextStep()" disabled class="b_foot">
			  <input name="doDelete"   type=button value="删除" onclick="dDelete()"  style="display:none" class="b_foot">
			 <%
			 }else {
			 %>
			 <script>
			 closefields();
				</script>
			 &nbsp;
			  <input  name="previous"  type=button value="上一步" onclick="previouStep()" class="b_foot">
			  &nbsp;
              <input  name="sure"  type=button value="确  认" onclick="refMain()" class="b_foot" >
			  <input  name="sure2"  type=button value="打印免填单" onclick="refMain2()"  class="b_foot_long">
			 <%
			 }
			 %>
              &nbsp; 
               <input  name=back  type=button value="清 除" onclick='window.location="f3717_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";' class="b_foot">
			   &nbsp;
              <input  name="kkkk"  onClick="removeCurrentTab()" type=button value="关 闭" class="b_foot">
              </TD>
            </TR>
			<!-------------隐藏域--------------->
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
			
			<!-------------隐藏域--------------->
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
 <!--input type="hidden" name="billType" value="<%=billType%>"--><!--结算类型-->
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

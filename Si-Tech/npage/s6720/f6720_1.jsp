<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-16
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s3500/pub.js"></script>

<%
    String opCode = "6720";
    String opName = "集团彩铃开户";
    String op_name ="集团彩铃开户";
    String [] paraIn = new String[2];
    
    Logger logger = Logger.getLogger("s6720_1.jsp");

    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    int iDate = Integer.parseInt(dateStr);
    String addDate = Integer.toString(iDate+1);
    String Date100 = Integer.toString(iDate+1000000);

    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String nopass  = (String)session.getAttribute("password");
    String Department = org_code;
    String regionCode = Department.substring(0,2);
    String districtCode = Department.substring(2,4);
    String townCode = Department.substring(4,7);
        
    String sqlStr = "";
	String cust_address = "";
    ArrayList retArray = new ArrayList();
    String[][] result = new String[][]{};
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    productCfg prodcfg = new productCfg();
	  String[][] resultList = new String[][]{};
		String[][] resultList_usr = new String[][]{};
	  /*产品和服务的访问权限*/
    int iPowerRight = Integer.parseInt(((String)session.getAttribute("powerRight")).trim()); //工号权限

	//取运行省份代码 -- 为吉林增加，山西可以使用session
	String[][] result2  = null;
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";//黑龙江agent_prov_code='21'
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
	
    //取工号密码和GROUP_ID
    String GroupId = "";
    String OrgId = "";
    if(ProvinceRun.equals("20"))  //吉林
    {
		String[][] result1  = null;
		sqlStr = "select group_id,'unknown' FROM dLoginMsg where login_no=:workno";
		//result1 = (String[][])callView.sPubSelect("2",sqlStr).get(0);
		
    paraIn[0] = sqlStr;    
    paraIn[1]="workno="+workNo;
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
	
	int nextFlag=1;
	String listShow="none";
	StringBuffer nameList=new StringBuffer();
	StringBuffer nameValueList=new StringBuffer();
	StringBuffer nameGroupList=new StringBuffer();
  
  //得到页面参数 
	String mainProduct="";
	String addProduct ="";
	String modeCode   ="";
	String addMode    ="";
	String iccid = "";
	String cust_id = request.getParameter("cust_id")==null?"":request.getParameter("cust_id");//wuxy alter 20090513
	
	System.out.println("------------------------------cust_id="+cust_id);
	String unit_id = "";
	String cust_code  ="";
	String cust_name = "";
	String province = "";
	String openType = "";
	String userType = "";
	String userTypeNew = "";
	String product_code = "";
	String product_append = "";
	String grp_id = "";
	String grp_name = "";
	String account_id = "";
	String grp_userno = "";
	String channel_code = "";
	String belong_code = "";
	String belong_codeNew = "";
	String group_id = "";/* add by daixy 20081127,group_id来自dCustDoc中的org_id */
	String sm_code = "";
	String hid_pay_flag = "";
	String hid_createFlag="";
	String billTime   ="";
	String productAttr = "";
	String userType_hidden = "";
	String product_attr_hidden = "";
	String custAddress = "";
	StringBuffer numberList=new StringBuffer();
	StringBuffer numberList_usr=new StringBuffer();
	

  //得到列表操作
	String action=request.getParameter("action");
	String modeType=request.getParameter("product_attr");
	int resultListLength=0;
	int resultListLength_usr=0;
	if (action!=null&&action.equals("select")){
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
			 product_code=request.getParameter("product_code");
			 product_append=request.getParameter("product_append");
			 grp_id=request.getParameter("grp_id");
			 grp_name=request.getParameter("grp_name");
			 account_id=request.getParameter("account_id");
			 grp_userno=request.getParameter("grp_userno");
			 channel_code=request.getParameter("channel_code");
			 belong_code = request.getParameter("belong_code");
			 belong_codeNew = request.getParameter("belong_codeNew");	
			 group_id = request.getParameter("group_id");	/* add by daixy 20081127,group_id来自dCustDoc中的org_id */
			 
	    String sqlStr123="";
   	  ArrayList retArray1 = new ArrayList();
			String[][] resultList123 = new String[][]{};			 
		  sqlStr123="select nvl(count(*),0)num from dgrpusermsg where cust_id='"+cust_id+"' and sm_code='"+sm_code+"' and run_code in('A','I')";		  
	  	//retArray1 = callView.sPubSelect("1",sqlStr123);
	  	
	  	paraIn[0] = sqlStr123;    
        paraIn[1]="cust_id="+cust_id+",sm_code"+sm_code;
%>
        <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode13" retmsg="retMsg13"  outnum="1">
        	<wtc:sql><%=sqlStr123%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr13" scope="end"/>
<%      
        if(retArr13.length>0 && retCode13.equals("000000")){
            resultList123 = retArr13;
        }

      //resultList123=(String[][])retArray1.get(0);      
      int recordNum = Integer.parseInt(resultList123[0][0].trim());
      System.out.println("sqlStr123====="+sqlStr123);
      System.out.println("recordNum====="+recordNum);
      System.out.println("resultList123====="+resultList123[0][0]);
      if(recordNum==1){      
      %>
        <script language='jscript'>
          rdShowMessageDialog("此集团客户已经是彩铃用户或用户是预销状态！");
	        this.location="f6720_1.jsp";
        </script>
      <%      
      }	      
			//取出集团数据
			sqlStr= "select a.field_code,a.field_name,a.field_purpose,a.field_type,a.field_length,"
			       +" b.field_grp_no,c.field_grp_name,c.max_rows,c.min_rows,b.ctrl_info,nvl(b.FIELD_DEFVALUE,' ')"
			       +"  from sUserFieldCode a,sGrpSmFieldRela b,sUserTypeGroup c"
					   +" where a.busi_type = b.busi_type"
					   +"   and a.field_code=b.field_code"
					   +"   and a.busi_type = '1000'"
					   +"   and b.user_type= '"+sm_code+"' "
					   +"   and a.busi_type = c.busi_type"
					   +"   and b.user_type = c.user_type"
					   +"   and b.field_grp_no = c.field_grp_no"
					   +" order by b.field_grp_no,b.field_order";
			//resultList=(String[][])callView.sPubSelect("11",sqlStr).get(0);
			
	        paraIn[0] = sqlStr;    
            paraIn[1]="sm_code="+sm_code;
%>
            <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode14" retmsg="retMsg14"  outnum="11">
            	<wtc:sql><%=sqlStr%></wtc:sql>
            </wtc:pubselect>
            <wtc:array id="retArr14" scope="end"/>
<%
            if(retArr14.length>0 && retCode14.equals("000000")){
                resultList = retArr14;
                System.out.println("^^^^^^^^^^^^^^^^^##########---"+retArr14[0][4]);
    			System.out.println("^^^^^^^^^^^^^^^^^##########---"+retArr14[0][3]);
    			System.out.println("^^^^^^^^^^^^^^^^^##########---"+retArr14[0][5]);
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
			//得到数据的行数
			//得到具体数据			
			//取出成员数据
			
			sqlStr= "select a.field_code,a.field_name,a.field_purpose,a.field_type,a.field_length,"
			       +" b.field_grp_no,c.field_grp_name,c.max_rows,c.min_rows,b.ctrl_info,nvl(b.FIELD_DEFVALUE,' ')"
			       +"  from sUserFieldCode a,sUserTypeFieldRela b,sUserTypeGroup c"
					   +" where a.busi_type = b.busi_type"
					   +"   and a.field_code=b.field_code"
					   +"   and a.busi_type = '1000'"
					   +"   and b.user_type=:user_type"
					   +"   and a.busi_type = c.busi_type"
					   +"   and b.user_type = c.user_type" 
					   +"   and b.field_grp_no = c.field_grp_no"
					   +" order by b.field_grp_no,b.field_order";
			System.out.println("member:"+sqlStr);
			//resultList_usr=(String[][])callView.sPubSelect("11",sqlStr).get(0);
			
			paraIn[0] = sqlStr;    
            paraIn[1]="user_type="+request.getParameter("userType");
%>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode15" retmsg="retMsg15" outnum="11" >
            	<wtc:param value="<%=paraIn[0]%>"/>
            	<wtc:param value="<%=paraIn[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr15" scope="end"/>
<%
            if(retArr15.length>0 && retCode15.equals("000000")){
                resultList_usr = retArr15;
            }
            
			System.out.println("############resultList_usr="+resultList_usr.length);
			
			if (resultList_usr != null)
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
			listShow="";
		}
		catch(Exception e){
		    e.printStackTrace();
		}
	}	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=op_name%></TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
</HEAD>
<SCRIPT type=text/javascript>
//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function(){
    document.all.checkPayTR.style.display="none";
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
            rdShowMessageDialog("没有得到用户ID,请重新获取！",0);
			      return false;
        }
		//得到集团用户编号的时候，得到集团代码
		//getGrpId();
    }
    if(retType == "GrpId") //得到集团代码
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
    if(retType == "GrpNo") //得到集团用户编号
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
            rdShowMessageDialog(retMessage, 0);
        }
	}
    //---------------------------------------
    if(retType == "GrpCustInfo") //用户开户时客户信息查询
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
    if(retType == "AccountId") //得到帐户ID
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
            rdShowMessageDialog("没有得到帐户ID,请重新获取！",0);
        }
    }
    //---------------------------------------
    if(retType == "UnitInfo")
    { 
        //集团信息查询
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
     if(retType == "checkPwd") //集团客户密码校验
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false") {
    	    	rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
	        	frm.next.disabled = true;
	        	frm.custPwd.value = "";
	        	frm.custPwd.focus();
    	    	return false;	        	
            } else {
                rdShowMessageDialog("客户密码校验成功！",2);
                document.frm.next.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("客户密码校验出错，请重新校验！",0);
            document.frm.doSubmit.disabled = true;
    		return false;
        }
     }	

     //---------------------------------------
     if(retType == "CheckMng_user") //管理员帐户校验
     {        
        if(retCode !=0)
        {     	
          rdShowMessageDialog(retMessage,0);
           document.frm.Mng_user.value = "";
	         document.frm.Mng_user.focus();
    		   return false;
         
         }
        else
        {
          rdShowMessageDialog("管理员账户校验成功",2);
          document.frm.sure.disabled = false;
          //document.frm.sure2.disabled = false; 
        }
     }     
     if(retType == "ProdAttr")
     {
        if(retCode == "000000")
        {
            var retnums = packet.data.findValueByName("retnums");
            var retname = packet.data.findValueByName("retname");
/*
            if (retnums == 1) { 
              //只有一个产品属性的时候，不需要用户选择
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
         rdShowMessageDialog("查询产品属性出错,请重新获取！",0);
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
						
						if(pay_flag=="0")
						{
							
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
                if(createFlag=='Y')//Y->N
					{
						//frm.getUserOutNo.style.display="";
						//frm.verifyMebNo.style.display="none";
						//document.all.productcode_div.style.display="";
						//frm.mainProduct.v_must=1;
					}
						else
						{
							//frm.cust_code.readOnly=false;
							//frm.cust_code.readOnly=true;
							//frm.getUserOutNo.style.display="none";
							//frm.verifyMebNo.style.display="";
							//document.all.productcode_div.style.display="none";
							//frm.mainProduct.v_must=0;
						}
          }
        }
        else
        {
            rdShowMessageDialog("获取客户地址失败，请重新获取！",0);
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
					var prtFlag=0;
					var confirmFlag=0;		
				  showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
	        if (rdShowConfirmDialog("是否提交确认操作？")==1){
						spellList_grp();
						spellList();				
						frm.action="f6720_2.jsp";
						frm.submit();
			      }
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
                rdShowMessageDialog("该支票的帐户余额为0！");
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
	{   //验证cust_code 
        if(retCode == "0")
        {
				rdShowMessageDialog("用户编码信息校验成功！",2);
				frm.verifyMebNo.disabled=true;
         }
        else
        {
			var retMsg = packet.data.findValueByName("retMsg");
    		rdShowMessageDialog(retMsg,0);  
			//rdShowMessageDialog("校验不成功！",0);
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
            rdShowMessageDialog("获取客户地址失败，请重新获取！",0);
    		return false;
        }
	}
	if(retType == "query_channelid")/////////////
	{   //得到query_channelid
        if(retCode == "0")
        {
            var channel_name = packet.data.findValueByName("channel_name");

			var channel_id = packet.data.findValueByName("channel_id");
			//alert(channel_id);
            if (channel_id == "false") {
    	    	rdShowMessageDialog("获取channelid失败！",0);
    	    	return false;	        	
            } else {
                document.frm.channel_id.value = channel_id;
            }
         }
        else
        {
            rdShowMessageDialog("获取channelid失败，请重新获取！",0);
    		return false;
        }
	}
	if(retType == "custCode") //得到成员用户编码
    {
        if(retCode == "000000")
        {
            var memIdNo = packet.data.findValueByName("memIdNo");
            //document.frm.cust_code.value = memIdNo;
            document.frm.getUserOutNo.disabled = true;
         }
        else
        {
            rdShowMessageDialog("没有得到帐户ID,请重新获取！",0);
        }
    }
}

function dateCompare(sDate1,sDate2){
	
	if(sDate1>sDate2)	//sDate1 早于 sDate2
		return 1;
	if(sDate1==sDate2)	//sDate1、sDate2 为同一天
		return 0;
	return -1;		//sDate1 晚于 sDate2
}

function refMain2()
{
    if(  document.frm.grp_userno.value == "" ){
            rdShowMessageDialog("集团用户编号必须输入!!");
            document.frm.grp_userno.select();
            return false;
        }
    
    		if(  document.frm.product_code.value == "" ){
            rdShowMessageDialog("集团产品必须输入!!");
            document.frm.product_code.select();
            return false;
        }
     	/*   
		  if((jtrim(document.frm.mainProduct.value) == "") && (document.frm.mainProduct.v_must==1))
        {
        	rdShowMessageDialog("主套餐必须输入!!");
            document.frm.mainProduct .select();
            return false;
        }   */
        
        	if(  document.frm.grp_id.value == "" ){
            rdShowMessageDialog("集团用户ID必须输入!!");
            document.frm.grp_id.select();
            return false;
        }
        
        
        if(  document.frm.grp_name.value == "" ){
            rdShowMessageDialog("用户名称:"+document.frm.grp_name.value+",必须输入!!");
            document.frm.grp_name.select();
            return false;
        }
         	if(  document.frm.account_id.value == "" ){
            rdShowMessageDialog("帐户ID必须输入!!");
            document.frm.account_id.select();
            return false;
        }
   /*      	if(  document.frm.cust_code.value == "" ){
            rdShowMessageDialog("成员用户编码必须输入!!");
            document.frm.cust_code.select();
            return false;
         }   */
        
          	if(  document.frm.credit_value.value == "" ){
            rdShowMessageDialog("信用度必须输入!!");
            document.frm.credit_value.select();
            return false;
        }
         	if(  document.frm.credit_code.value == "" ){
            rdShowMessageDialog("信用等级必须输入!!");
            document.frm.credit_code.select();
            return false;
        }
        
      //2.转换业务起始日期和业务结束日期的YYYYMMDD---->YYYY-MM-DD
		   checkFlag = isValidYYYYMMDD(document.frm.srv_start.value);
        if(checkFlag < 0){
            rdShowMessageDialog("业务起始日期:"+document.frm.srv_start.value+",日期不合法!!");
            document.frm.srv_start.select();
            return false;
        }
        checkFlag = isValidYYYYMMDD(document.frm.srv_stop.value);
        if(checkFlag < 0){
            rdShowMessageDialog("业务结束日期:"+document.frm.srv_stop.value+",日期不合法!!");
            document.frm.srv_stop.select();
            return false;
        }
          //业务起始日期和业务结束日期的时间比较
        checkFlag = dateCompare(document.frm.srv_start.value,document.frm.srv_stop.value);
        if( checkFlag == 1 ){
            rdShowMessageDialog("业务结束日期应该大于业务起始日期!!");
            document.frm.srv_stop.select();
            return false;
        }   
      
	   	
		//判断real_handfee
		if(!checkElement(document.frm.real_handfee)) return false;
        if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
        {
				rdShowMessageDialog("实收手续费不应大于应收手续费");
				document.frm.real_handfee.focus();
				return false;	
        }
		if (parseFloat(document.frm.checkPay.value)!=parseFloat(document.frm.real_handfee.value))
        {
				rdShowMessageDialog("支票交款应等于实收手续费");
				document.frm.checkPay.focus();
				return false;	
        }
		if (parseFloat(document.frm.checkPay.value)>parseFloat(document.frm.checkPrePay.value))
        {
				rdShowMessageDialog("支票交款应小于支票余额");
				document.frm.checkPay.focus();
				return false;	
        }
		if (parseFloat(document.frm.should_handfee.value)==0)
		{
			document.frm.real_handfee.value="0.00";
		}
		
		
				document.frm.chgsrv_start.value = changeDateFormat(document.frm.srv_start.value);
        document.frm.chgsrv_stop.value  = changeDateFormat(document.frm.srv_stop.value);
        document.frm.sysnote.value = "集团彩铃用户开户"+document.frm.grp_userno.value;
        document.frm.tonote.value = "集团彩铃用户开户"+document.frm.grp_userno.value;	
        
			 var real_handfee = document.frm.real_handfee.value;
		   var cashNum = document.frm.cashNum.value;
			 var cashPay = document.frm.cashPay.value;
			 var totalPay2 = Math.round(real_handfee) + Math.round(cashNum);
			 document.frm.totalPay2.value = totalPay2;
				
		var prtFlag=0;
		var subm = 0;
		refMain();  
}


function check_HidPwd()
{
    var cust_id = document.all.cust_id.value;
    var Pwd1 = document.all.custPwd.value;
    var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","正在进行密码校验，请稍候......");
    checkPwd_Packet.data.add("retType","checkPwd");
	  checkPwd_Packet.data.add("cust_id",cust_id);
	  checkPwd_Packet.data.add("Pwd1",Pwd1);
	  core.ajax.sendPacket(checkPwd_Packet);
	  checkPwd_Packet = null;
}

function check_mnguser()
{    
	 if(((document.frm.Mng_user.value).trim()) == "")
    {
        rdShowMessageDialog("管理员用户不能为空！");
        return false;
    } 
    var checkPwd_Packet = new AJAXPacket("CheckMng_user.jsp","正在进行密码校验，请稍候......");
    checkPwd_Packet.data.add("retType","CheckMng_user");
	  checkPwd_Packet.data.add("orgCode","<%=org_code%>");
	  checkPwd_Packet.data.add("LoginNo","<%=workNo%>");
	  checkPwd_Packet.data.add("op_code",document.frm.op_code.value);
	  checkPwd_Packet.data.add("Mng_user",document.frm.Mng_user.value);
	  core.ajax.sendPacket(checkPwd_Packet);
	  checkPwd_Packet = null;
}

function getAccountId()
{
	//得到帐户ID
  var getAccountId_Packet = new AJAXPacket("../s3500/f1100_getId.jsp","正在获得帐户ID，请稍候......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","AccountId");
	getAccountId_Packet.data.add("idType","1");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet = null;
	 //document.frm.sure.disabled = false;
   //document.frm.sure2.disabled = false;
}

//得到集团用户编号user_no
function getGrpUserNo()
{
    var sm_code = document.frm.sm_code.value;

    //首先判断是否已经选择了服务品牌
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择集团信息化产品！");
        return false;
    }

    var getgrp_Userno_Packet = new AJAXPacket("getGrpUserno.jsp","正在获得集团用户编号，请稍候......");
    getgrp_Userno_Packet.data.add("retType","GrpNo");
    getgrp_Userno_Packet.data.add("orgCode","<%=org_code%>");
    getgrp_Userno_Packet.data.add("smCode",sm_code);
    core.ajax.sendPacket(getgrp_Userno_Packet);
    getgrp_Userno_Packet = null;
}

function getGrpId()
{
    //得到智能网集团用户代码
    var getgrp_no_Packet = new RPCPacket("../s6720/getGrpId.jsp","正在获得集团代码，请稍候......");
    getgrp_no_Packet.data.add("retType","GrpId");
    getgrp_no_Packet.data.add("orgCode","<%=org_code%>");
    core.rpc.sendPacket(getgrp_no_Packet);
    delete(getgrp_no_Packet);
}

function getUserId()
{
  //得到集团用户ID，和个人用户ID一致
  var getUserId_Packet = new AJAXPacket("../s3500/f1100_getId.jsp","正在获得用户ID，请稍候......");
	getUserId_Packet.data.add("region_code","<%=regionCode%>");
	getUserId_Packet.data.add("retType","UserId");
	getUserId_Packet.data.add("idType","1");
	getUserId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getUserId_Packet);
	getUserId_Packet = null;
}
 //下一步
function nextStep()
{
  if(((document.frm.cust_id.value).trim()) ==""||((document.frm.unit_id.value).trim()) == ""||((document.frm.cust_name.value).trim()) == "")
  {
      rdShowMessageDialog("请首先选择集团用户基本信息！");
      return false;
  }  
	frm.action="f6720_1.jsp?action=select";
	frm.method="post";
	frm.submit();
}
//上一步
function previouStep(){
	frm.action="f6720_1.jsp";
	frm.method="post";
	frm.submit();
}
//查询客户地址
function query_custaddress()
{
			if(document.frm.cust_id.value == "")
			{
				return false;
			}
			  var getInfoPacket = new AJAXPacket("s6720_custaddress.jsp","正在查询客户地址，请稍候......");
				getInfoPacket.data.add("retType","custaddress");
				getInfoPacket.data.add("cust_id",document.frm.cust_id.value);
				core.ajax.sendPacket(getInfoPacket);
				getInfoPacket = null;
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
		//frm.getUserOutNo.style.display="";
		//frm.verifyMebNo.style.display="none";
		//document.all.productcode_div.style.display="";
		//frm.mainProduct.v_must=1;
	}
	else if(createFlag2=='N')
	{
		//frm.cust_code.readOnly=false;
		//frm.getUserOutNo.style.display="none";
		//frm.verifyMebNo.style.display="";
		//document.all.productcode_div.style.display="none";
		//frm.mainProduct.v_must=0;
	}
	else if(createFlag2=='')
	{
		//frm.getUserOutNo.style.display="";
		//frm.verifyMebNo.style.display="none";
		//document.all.productcode_div.style.display=""
		//frm.mainProduct.v_must=1;
	}
}

//查询channel_id
function query_channelid()
{
			  var getInfoPacket = new RPCPacket("s2890_channelid.jsp","正在查询，请稍候......");
				getInfoPacket.data.add("retType","query_channelid");
				getInfoPacket.data.add("org_code","<%=org_code%>");
				getInfoPacket.data.add("town_code",document.frm.town_code.value);
				core.rpc.sendPacket(getInfoPacket);
				delete(getInfoPacket);
}
//调用公共界面，进行集团帐户选择
function getInfo_Acct()
{
    var pageTitle = "集团帐户选择";
    var fieldName = "集团用户ID|集团用户名称|产品名称|集团帐号|";
	var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "4|0|1|2|3|";
    var retToField = "tmp1|tmp2|tmp3|account_id|"; //这里只需要返回帐号
    var cust_id = document.frm.cust_id.value;

    if(document.frm.cust_id.value == "")
    {
        rdShowMessageDialog("请先选择集团客户，才能进行集团帐户查询！");
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

//调用公共界面，进行集团客户选择
function getInfo_Cust()
{
    var pageTitle = "集团客户选择";
/** add by daixy 20081127,group_id来自dCustDoc中的org_id   
** var fieldName = "证件号码|客户ID|客户名称|集团ID|集团名称|归属地|";
**   var sqlStr = "";
** var selType = "S";    //'S'单选；'M'多选 
**    var retQuence = "6|0|1|2|3|4|5|";
**    var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_codeNew|";
**/
 	var fieldName = "证件号码|客户ID|客户名称|集团ID|集团名称|归属地|归属组织|";
	  var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
 	var retQuence = "7|0|1|2|3|4|5|6|";
    var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_codeNew|group_id|";  
    var cust_id = document.frm.cust_id.value;

    if(document.frm.iccid.value == "" &&
       document.frm.cust_id.value == "" &&
       document.frm.unit_id.value == "")
    {
        rdShowMessageDialog("请输入身份证号、客户ID或集团ID进行查询！");
        document.frm.iccid.focus();
        return false;
    }

    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("必须是数字！");
    	return false;
    }

    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
        rdShowMessageDialog("必须是数字！");
    	return false;
    }

    if(PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s6720/fpubcust_sel.jsp";
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
/** add by daixy 20081127,group_id来自dCustDoc中的org_id  
 ** var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_codeNew|";
**/
  	var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_codeNew|group_id|";
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
        document.all(obj).readOnly=true;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	document.all.grp_name.value = document.all.unit_name.value;
	query_custaddress();
	//getCreateflag();

}
//查询getCreateflag
function getCreateflag()
{ 
    if(((frm.sm_code.value).trim()) == "")
    {
        rdShowMessageDialog("请获取业务类型！");
        frm.sm_code.focus();
        return false;
    }
    var getCheckInfo_Packet = new RPCPacket("f3505_getflag.jsp","正在获得相关信息，请稍候......");
		getCheckInfo_Packet.data.add("retType","getCreateflag");
    getCheckInfo_Packet.data.add("sm_code",document.frm.sm_code.value);
		core.rpc.sendPacket(getCheckInfo_Packet);
		delete(getCheckInfo_Packet);     
 }
 
//根据客户ID查询客户信息
function getInfo_CustId()
{
    var cust_id = document.frm.cust_id.value;

    //根据客户ID得到相关信息
    if(document.frm.cust_id.value == "")
    {
        rdShowMessageDialog("请输入客户ID！");
        return false;
    }
    if(forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("客户ID必须是数字！");
    	return false;
    }

    var getInfoPacket = new RPCPacket("f1902_Infoqry.jsp","正在获得集团客户信息，请稍候......");
        var cust_id = document.frm.cust_id.value;
        getInfoPacket.data.add("region_code","<%=regionCode%>");
        getInfoPacket.data.add("retType","GrpCustInfo");
        getInfoPacket.data.add("cust_id",cust_id);
        core.rpc.sendPacket(getInfoPacket);
        delete(getInfoPacket);
}

//
function isDecimal(obj) {
   if (obj.search(/^\d+$/) != -1)
  {
   return true;
   }else{
    return false;
  }
}

//根据客户ID查询客户信息
function getInfo_UnitId()
{
    var cust_id = document.frm.cust_id.value;
    var unit_id = document.frm.unit_id.value;

    //根据客户ID得到相关信息
    if(document.frm.cust_id.value == "")
    {
        rdShowMessageDialog("请首先输入集团客户ID！");
        return false;
    }
    if(forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("集团客户ID必须是数字！");
    	return false;
    }
    if(document.frm.unit_id.value == "")
    {
        rdShowMessageDialog("请首先输入集团ID！");
        return false;
    }
    if(forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
        rdShowMessageDialog("集团ID必须是数字！");
    	return false;
    }

    var getInfoPacket = new RPCPacket("f1902_Infoqry.jsp","正在获得集团客户信息，请稍候......");
        var cust_id = document.frm.cust_id.value;
        getInfoPacket.data.add("region_code","<%=regionCode%>");
        getInfoPacket.data.add("retType","UnitInfo");
        getInfoPacket.data.add("cust_id",cust_id);
        getInfoPacket.data.add("unit_id",unit_id);
        core.rpc.sendPacket(getInfoPacket);
        delete(getInfoPacket);
}

//查询产品属性
function query_prodAttr()
{
    var sm_code = document.frm.sm_code.options[document.frm.sm_code.selectedIndex].value;
    if(document.frm.sm_code.value == "")
    {
        return false;
    }

    var getInfoPacket = new RPCPacket("fpubprodattr_qry.jsp","正在查询产品属性代码，请稍候......");
        getInfoPacket.data.add("retType","ProdAttr");
        getInfoPacket.data.add("sm_code",sm_code);
        core.rpc.sendPacket(getInfoPacket);
        delete(getInfoPacket);
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
        rdShowMessageDialog("请首先选择集团信息化产品！");
        return false;
    }

    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
//查询支票号码
function getBankCode()
{ 
  	//调用公共js得到银行代码
    if(((frm.checkNo.value).trim()) == "")
    {
        rdShowMessageDialog("请输入支票号码！");
        frm.checkNo.focus();
        return false;
    }
    var getCheckInfo_Packet = new AJAXPacket("../s3500/getBankCode.jsp","正在获得支票相关信息，请稍候......");
	  getCheckInfo_Packet.data.add("retType","getCheckInfo");
    getCheckInfo_Packet.data.add("checkNo",document.frm.checkNo.value);
	  core.ajax.sendPacket(getCheckInfo_Packet);
	  getCheckInfo_Packet = null;     
 }
function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s6720/fpubprodattr_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&groupFlag=Y";
	  path = path + "&op_code=" + document.all.op_code.value;
	  path = path + "&sm_code=" + document.all.sm_code.value; 
    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
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
    //document.frm.product_code.value = "";
    //document.frm.product_append.value = "";
    document.frm.ProdAttrQuery.disabled=true;
}
function changeTownCode(){
   document.all.town_name.value="";
}

function getTownCode()
{
    var pageTitle = "渠道商查询";
    var fieldName = "渠道商代码|渠道商名称|";
	  var sqlStr="SELECT a.town_code,a.town_name"
           +"  FROM sTownCode a,sAgType b"
           +"  WHERE a.region_code   = substr('"+document.all.OrgCode.value+"',1,2)"
           +"  AND a.region_code   = b.region_code"
           +"  AND a.district_code = substr('"+document.all.OrgCode.value+"',3,2)"
           +"  AND a.innet_type    = b.agent_type "
           +"  AND b.agent_flag    = 'Y' and rownum<290";
    if(document.all.town_code.value != "")
    {
        sqlStr = sqlStr + " and town_code like '" + document.all.town_code.value + "%'";
    }
    sqlStr = sqlStr + " order by town_code" ;
    var selType = "S";    //'S'单选；'M'多选
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
	//查询channel_id
	query_channelid();

}

//调用公共界面，进行产品信息选择
function getInfo_Prod()
{
    var pageTitle = "集团产品选择";
    var fieldName = "产品代码|产品名称|";
	  var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "product_code|";

    //首先判断是否已经选择了服务品牌
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择集团信息化产品！");
        return false;
    }
    //首先判断是否已经选择了产品属性
    if(document.frm.product_attr_hidden.value == "")
    {
        rdShowMessageDialog("请首先选择产品类型！");
        return false;
    }

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s6720/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	  path = path + "&op_code=" + document.all.op_code.value;
	  path = path + "&sm_code=" + document.all.sm_code.value; 
	  path = path + "&cust_id=" + document.all.cust_id.value; 
    path = path + "&product_attr=" + document.all.product_attr.value; 

    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    
	return true;
}

function getvalue(retInfo)
{
  var retToField = "product_code|";
  if(retInfo ==undefined)      
    {   return false;   }
    
  document.frm.product_code.value = retInfo ;
  document.frm.ProdQuery.disabled=true;
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
        rdShowMessageDialog("请首先选择集团信息化产品！");
        return false;
    }
    //首先判断是否已经选择了产品属性
    if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("请首先选择产品属性！");
        return false;
    }
    //首先判断是否已经申请了集团产品
    if(document.frm.product_code.value == "")
    {
        rdShowMessageDialog("请首先选择集团产品！");
        return false;
    }

    if(PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var product_code = document.all.product_code.value;
    var chPos = product_code.indexOf("|");
    product_code = product_code.substring(0,chPos);
    var path = "<%=request.getContextPath()%>/npage/s6720/fpubprodappend_sel.jsp";
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

  //document.all.product_append.value = retInfo;
}

function checkPwd(obj1,obj2)
{
        //密码一致性校验,明码校验
        var pwd1 = obj1.value;
        var pwd2 = obj2.value;        
        if(pwd1 != pwd2)
        {
            var message = "两次输入的密码不一致，请重新输入！";
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
//服务品牌变更事件
function changeSmCode() {
    document.frm.product_attr.value = "";
	  document.frm.product_code.value = "";
    //document.frm.product_append.value = "";
    document.frm.grp_userno.value = "";
    document.frm.getGrpNo.disabled = false;
    if (document.frm.sm_code.options.length > 0)
    {
	    if (document.frm.sm_code.options[document.frm.sm_code.options.selectedIndex].seqFlag == "Y")
	    {
	    	document.frm.grp_userno.readOnly = true;
	    	document.frm.getGrpNo.style.display = ""
	    }
	    else
	    {
	    	document.frm.grp_userno.readOnly = false;
	    	document.frm.getGrpNo.style.display = "none"	    	
	    }
	}
	getCreateflag();
  query_prodAttr();
}

//产品属性变更事件
function changeProdAttr() {
	document.frm.product_code.value = "";
  //document.frm.product_append.value = "";
}

//产品变更事件
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

function refMain(){

    getAfterPrompt();
//校验动态生成的字段
	if(!checkDynaFieldValues_grp(false))
			return false;
			
	if(!checkDynaFieldValues(false))
			return false;
			
    var checkFlag; //注意javascript和JSP中定义的变量也不能相同,否则出现网页错误.

    //说明:检测分成两类,一类是数据是否是空,另一类是数据是否合法.
   if(document.all.Mng_pwd.value.length<6)
  {
      rdShowMessageDialog("管理员账户密码长度有误！",0);
      document.all.Mng_pwd.value="";
      document.all.Mng_pwd.focus();
      return false;
   }  
  
   if(!isDecimal(document.all.Mng_pwd.value)){
   	  rdShowMessageDialog("管理员账户密码不是数字串！",0);
   	  document.all.Mng_pwd.value="";
      document.all.Mng_pwd.focus();
      return false;
    }
  
  if(  document.frm.grp_userno.value == "" ){
            rdShowMessageDialog("集团用户编号必须输入!!");
            document.frm.grp_userno.select();
            return false;
        }
    
    		if(  document.frm.product_code.value == "" ){
            rdShowMessageDialog("集团产品必须输入!!");
            document.frm.product_code.select();
            return false;
        } 
        
        
        	if(  document.frm.grp_id.value == "" ){
            rdShowMessageDialog("集团用户ID必须输入!!");
            document.frm.grp_id.select();
            return false;
        }
        
        
        if(  document.frm.grp_name.value == "" ){
            rdShowMessageDialog("用户名称:"+document.frm.grp_name.value+",必须输入!!");
            document.frm.grp_name.select();
            return false;
        }
         	if(  document.frm.account_id.value == "" ){
            rdShowMessageDialog("帐户ID必须输入!!");
            document.frm.account_id.select();
            return false;
        }
        
        	if(  document.frm.credit_value.value == "" ){
          rdShowMessageDialog("信用度必须输入!!");
          document.frm.credit_value.select();
          return false;
        }
         	if(  document.frm.credit_code.value == "" ){
            rdShowMessageDialog("信用等级必须输入!!");
            document.frm.credit_code.select();
            return false;
        }
        
        //2.转换业务起始日期和业务结束日期的YYYYMMDD---->YYYY-MM-DD
		    checkFlag = isValidYYYYMMDD(document.frm.srv_start.value);
        if(checkFlag < 0){
            rdShowMessageDialog("业务起始日期:"+document.frm.srv_start.value+",日期不合法!!");
            document.frm.srv_start.select();
            return false;
        }
        checkFlag = isValidYYYYMMDD(document.frm.srv_stop.value);
        if(checkFlag < 0){
            rdShowMessageDialog("业务结束日期:"+document.frm.srv_stop.value+",日期不合法!!");
            document.frm.srv_stop.select();
            return false;
        }
        //业务起始日期和业务结束日期的时间比较
        checkFlag = dateCompare(document.frm.srv_start.value,document.frm.srv_stop.value);
        if( checkFlag == 1 ){
            rdShowMessageDialog("业务结束日期应该大于业务起始日期!!");
            document.frm.srv_stop.select();
            return false;
        }   
        
      
		 //进行密码校验
		 if(((document.all.user_passwd.value).trim()).length>0)
        {
            if(document.all.user_passwd.value.length<6)
            {
                rdShowMessageDialog("用户密码长度有误！",0);
                document.all.user_passwd.focus();
                return false;
             }
             
             if(checkPwd(document.all.user_passwd,document.all.account_passwd)==false)
                return false;
                
             if(!(isDecimal(document.all.user_passwd.value)&&isDecimal(document.all.account_passwd.value))){
             	  rdShowMessageDialog("用户密码不为数字串！",0);
             	  document.all.user_passwd.value = "";
             	  document.all.account_passwd.value="";
               return false;
              }
        }
        else
        {
            rdShowMessageDialog("用户密码不能为空！",0);
            document.all.user_passwd.focus();
            return false;
        }

	   	
		//判断real_handfee
		if(!checkElement(document.frm.real_handfee)) return false;
        if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
        {
				rdShowMessageDialog("实收手续费不应大于应收手续费");
				document.frm.real_handfee.focus();
				return false;	
        }
		if (parseFloat(document.frm.checkPay.value)!=parseFloat(document.frm.real_handfee.value))
        {
				rdShowMessageDialog("支票交款应等于实收手续费");
				document.frm.checkPay.focus();
				return false;	
        }
		if (parseFloat(document.frm.checkPay.value)>parseFloat(document.frm.checkPrePay.value))
        {
				rdShowMessageDialog("支票交款应小于支票余额");
				document.frm.checkPay.focus();
				return false;	
        }
        
    if(  document.frm.Mng_pwd.value == "" ){
          document.frm.Mng_pwd.value="111111";
        }
        
		if (parseFloat(document.frm.should_handfee.value)==0)
		{
			document.frm.real_handfee.value="0.00";
		}
        //由于参数太多，需要通过form的post传输,因此,需要将传输的内容复制到隐含域中. yl.
        document.frm.chgsrv_start.value = changeDateFormat(document.frm.srv_start.value);
        document.frm.chgsrv_stop.value  = changeDateFormat(document.frm.srv_stop.value);  
        document.frm.sysnote.value = "集团"+document.frm.unit_id.value+"申请产品"+document.frm.product_code.value;
        document.frm.tonote.value =  "集团"+document.frm.unit_id.value+"申请产品"+document.frm.product_code.value;	
	 getSysAccept();  
}



//取流水
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("../s3500/pubSysAccept.jsp","正在生成操作流水，请稍候......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet = null;   
}

//选择支付方式
function changePayType(){
	if (document.all.checkPayTR.style.display==""){
		document.all.checkPayTR.style.display="none";
		document.all.cashPay_div.style.display="";
		
		if(document.frm.cashPay.value=='')
		{
		//document.frm.sure.disabled = true; 
		//document.frm.sure2.disabled = true;
		}
	}
	else {
		document.all.checkPayTR.style.display="";
		document.all.cashPay_div.style.display="none";
		
		//document.frm.sure.disabled = false;
		//document.frm.sure2.disabled = false;
	}
}

 //获得总计金额
function getCashNum(){

	if(!checkDynaFieldValues_grp(true)){//输入基本月租费
			return false;
		}
	if(!checkDynaFieldValues(true)){//输入基本月租费
		return false;
	}
	
	var addSub_grp = getCashNum_grp();
	var addSub_usr = getCashNum_usr();
	
	document.frm.cashNum.value=addSub_grp+addSub_usr;
}

 //获得集团总计金额
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
 //获得成员总计金额
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
				rdShowMessageDialog("请查询一次性付款金额!");
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
        rdShowMessageDialog("请首先选择服务品牌！");
        return false;
    }
    //判断是否选择了产品属性
    if(document.frm.product_attr_hidden.value == "")
    {
        rdShowMessageDialog("请首先选择产品属性！");
        return false;
    }

    if(PubSimpSelUserType(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
function PubSimpSelUserType(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s6720/fpubusertype_sel.jsp";
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
    
}
//计算集团和成员的计算字段
function calcAllFieldValues_all()
{
	calcAllFieldValues_grp();
	
	calcAllFieldValues();
}
   
function PubSimpSel_getMainBill(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,returnNum)
{
    var path = "<%=request.getContextPath()%>/npage/s6720/fPubSimpSel.jsp";
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
function closefields()//点击下一步时，已经填好的字段不可修改
{
		document.frm.custQuery.disabled=true;
		document.frm.chkPass.disabled=true;
		//document.frm.ProdAttrQuery.disabled=true;
		//document.frm.UserTypeQuery.disabled=true;				
}

function showPrtDlg(printType,DlgMessage,submitCfm) {  //显示打印对话框
   var h=154;
   var w=360;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var printStr = printInfo(printType);
   if(printStr == "failed")
   {    return false;   }

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
}

function printInfo(printType) { 
	
	    var retInfo = "";
			retInfo+='<%=workNo%>'+"|";
			retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			retInfo+="客户名称:"+document.all.cust_name.value+"|";
			retInfo+="集团客户ID:"+document.all.cust_id.value+"|";
			retInfo+="证件号码:"+document.all.iccid.value+"|";
			retInfo+="单位地址:"+document.all.cust_address.value+"|";
			retInfo+="办理业务:"+"集团彩铃业务申请"+"|";
			retInfo+="集团名称:"+document.all.grp_name.value+"|";
			retInfo+="集团彩铃账户:"+document.all.account_id.value+"|";
			retInfo+="业务套餐:"+"集团彩铃开户"+"|";
			retInfo+="变更生效时间:"+"当日"+"|";
			retInfo+="操作流水:"+document.all.login_accept.value+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			retInfo+=""+"|";
			//retInfo+=""+document.all.simBell.value+"|";
			return retInfo;
							
}

</script>
<BODY>
<FORM action="" method="post" name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">集团信息</div>
</div>
<input type="hidden" id=hidPwd name="hidPwd" v_name="原始密码">
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
<!--add by daixy 20081127,group_id来自dCustDoc中的org_id
<input type="hidden" name="group_id"  value="<%=GroupId%>">
-->
<input type="hidden" name="group_id"  value="<%=group_id%>">
<input type="hidden" name="login_accept"  value="0"> <!-- 操作流水号-->
<input type="hidden" name="bill_type"  value="0"> <!-- 出帐周期 -->
<input type="hidden" name="product_prices"  value="">
<input type="hidden" name="product_type"  value="">
<input type="hidden" name="service_code"  value="">
<input type="hidden" name="service_attr"  value="">
<input type="hidden" name="pay_no"  value="">
<input type="hidden" name="op_code"  value="6720">
<input type="hidden" name="OrgCode"  value="<%=org_code%>">
<input type="hidden" name="region_code"  value="<%=regionCode%>">
<input type="hidden" name="district_code"  value="<%=districtCode%>">
<input type="hidden" name="town_code1"  value="<%=townCode%>">
<input type="hidden" name="WorkNo"   value="<%=workNo%>">
<input type="hidden" name="NoPass"   value="<%=nopass%>">
<input type="hidden" name="ip_Addr"  value=<%=ip_Addr%>>
<input type="hidden" name="cust_address"  value="<%=custAddress%>">
<input type="hidden" name="channel_id"  value="">
<input type="hidden" name="hid_pay_flag"  value="<%=hid_pay_flag%>">
<input type="hidden" name="hid_sm_code"  value=""> 
<input type="hidden" name="hid_createFlag"  value="<%=hid_createFlag%>">
<input type="hidden" name="totalPay2"  value="">
<input name="srv_start"  type="hidden" class="button" id="srv_start"  onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>" size="20" maxlength="8" v_must=1 v_type="date" v_name="业务起始日期"> 
<input name="srv_stop"   type="hidden" class="button" id="srv_stop"  onKeyPress="return isKeyNumberdot(0)" value="20500101" size="20" maxlength="8" v_must=1 v_type="date" v_name="业务结束日期" > 
<input name="billTime"   type="hidden" v_must=1 v_maxlength=8 v_type="string" v_name="计费时间" index="8" value="<%=(billTime=="")?dateStr:billTime%>" >    

             
<TABLE cellSpacing=0>
    <TR>
        <TD class=blue>
            <div align="left">证件号码</div>
        </TD>
        <TD>
            <input name=iccid <%if(nextFlag==2)out.println("readonly");%> id="iccid" size="24" maxlength="20" v_type="string" v_must=1 index="1" value="<%=iccid%>" >
            <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=查询 >
            <font class="orange">*</font>
        </TD>
        <TD class=blue>集团客户ID</TD>
        <TD>
            <input type="text" name="cust_id" <%if(nextFlag==2)out.println("readonly");%> size="20" maxlength="20" v_type="0_9" v_must=1 vindex="2" value="<%=cust_id%>">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class=blue>
            <div align="left">集团编号</div>
        </TD>
        <TD>
            <input name=unit_id id="unit_id" <%if(nextFlag==2)out.println("readonly");%> size="24" maxlength="11" v_type="0_9" v_must=1 index="3" value="<%=unit_id%>">
            <font class="orange">*</font>
        </TD>
        <TD class=blue>集团客户名称</TD>
        <TD>
            <input name="cust_name" size="20" <%if(nextFlag==2)out.println("readonly");%> v_must=1 v_type=string index="4" value="<%=cust_name%>">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class=blue>集团客户密码</TD>
        <TD>
            <%if(!ProvinceRun.equals("20"))  //不是吉林
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
            <input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass2" value=校验>
            <font class="orange">*</font>
        </TD>
        <TD class=blue>服务品牌</TD>
        <TD>
            <select name="sm_code" id="sm_code"   onChange="changeSmCode()" v_must=1 v_type="string" index="10">
                <option class='button' value='CR' seqFlag='Y' payFlag='0' createFlag='Y'>CR->彩铃产品</option>
            </select>
            <font class="orange">*</font>
            <script>
            //added by hanfa 20070517
            <%
                if (nextFlag==2)
            {
            %>
                document.frm.sm_code.value="<%=sm_code%>";
                document.frm.hid_sm_code.value="<%=sm_code%>";
                document.frm.sm_code.disabled = true;						
            <%
                }
            %>
            </script>
        </TD>
    </TR>
</TABLE>

<!---- 隐藏的列表-->
  <!--集团数据-->
	<%
	  //通用变量
	  boolean calcButtonFlag_all = false;

		//为include文件提供数据 
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


  <!--成员数据-->
  <%
 
		//为include文件提供数据  
	
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
	<%@ include file="fpubDynaFields_usr.jsp"%>     

<%
    if (calcButtonFlag_all)//如果有计算字段则显示计算按钮
		{
   %>
			<TR>
				<TD colspan="4">
					<input value="计算蓝色星号的值" name=calcAll type=button id="calcAll" class="b_text" onMouseUp="calcAllFieldValues_all();" onKeyUp="if(event.keyCode==13)calcAllFieldValues_all();" style="cursor：hand">
				</TD>
			</TR>

		<TABLE cellSpacing=0 style="display:<%=listShow%>">
    <%
		}
	  %>	 
		
			 <TD style="display:none" class=blue>集团用户编号</TD>
          <TD  style="display:none">
              <input name="grp_userno" type="text" class="button" size="20" maxlength="12"  v_type="string" v_must=1>
              <input name="getGrpNo" type="button" class="b_text" id="getGrpNo" onMouseUp="getGrpUserNo();" onKeyUp="if(event.keyCode==13)getGrpUserNo();" value="获取">
              <font class="orange">*</font>
           </TD>          
        <TR>
          <TD class=blue>产品类型</TD>
           <TD >
              <input type="text"  name="product_attr_hidden" size="20"   onChange="changeProdAttr()" v_must=1 v_type="string" value="<%=product_attr_hidden%>">
              <input name="ProdAttrQuery" type="button" id="ProdAttrQuery"  class="b_text" onMouseUp="getInfo_ProdAttr();" onKeyUp="if(event.keyCode==13)getInfo_ProdAttr();" value="选择">
			  			<font class="orange">*</font>
                            <input type="hidden" name="product_attr" value="<%=productAttr%>"/> 
              <input class="button" type="hidden" name="province" size="20"  
						  <%
			        try
			        {
                sqlStr = "select AGENT_PROV_CODE from sprovinceCode where run_flag = 'Y'";
                //retArray = callView.sPubSelect("1",sqlStr);
            %>
            	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode16" retmsg="retMsg16"  outnum="1">
                	<wtc:sql><%=sqlStr%></wtc:sql>
                </wtc:pubselect>
                <wtc:array id="retArr16" scope="end" />
        	<%
        	    if(retArr16.length>0 && retCode16.equals("000000")){
        	        result = retArr16;
        	    }
                //result = (String[][])retArray.get(0);
                int recordNum = result.length;
                for(int i=0;i<recordNum;i++){
                    out.println("value='" + result[i][0] + "'");
                }
			         }catch(Exception e){
			          logger.error("查询集团省区号失败!");
			         }
			        %>
			        v_must=1 v_type="0_9" index="11"> 
            </TD>
            <TD class=blue>集团产品</TD>
            <TD>
              <input class="button" type="text" name="product_code" size="20" readonly onChange="changeProduct()" v_must=1 v_type="string" value="<%=product_code%>">
              <input name="prodQuery" type="button" id="ProdQuery"  class="b_text" onClick="getInfo_Prod();" onClick="if(event.keyCode==13)getInfo_Prod();" value="选择">
			        <font class="orange">*</font>
            </TD>
           </TR>          
          <TR>
            <TD class=blue>集团产品ID</TD>
            <TD>
              <input name="grp_id" type="text" size="20" maxlength="12" readonly v_type="0_9" v_must=1 value="<%=grp_id%>">
              <input name="grpQuery" type="button" id="grpQuery"  class="b_text" onClick="getUserId();" onClick="if(event.keyCode==13)getUserId();" value="获取">
              <font class="orange">*</font>
            </TD>
            <TD class=blue>用户名称</TD>
            <TD>
              <input name="grp_name" type="text" size="20" maxlength="60" v_must=1 v_maxlength=60 v_type="string" value="<%=grp_name%>">
            <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class=blue>产品帐户</TD>
            <TD colspan=3>
              <input name="account_id" type="text" size="20" maxlength="12" readonly v_type="0_9" v_must=1 value="<%=account_id%>">
              <input name="accountQuery" type="button" class="b_text" id="accountQuery" onClick="getAccountId();" onClick="if(event.keyCode==13)getAccountId();" value="获取" >
              <font class="orange">*</font>
            </TD>

          </TR>
      <TR>
       <%if(!ProvinceRun.equals("20"))  //不是吉林
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
			 	<div align="left">帐户密码</div>
			 </TD>
			 
			 <TD>
			 	<input name="user_passwd" type="password" class="button" maxlength=6 pwdlength="6">
			 	<font class="orange">*</font>
			 </TD>
			 
			 <TD class=blue> 
			 	<div align="left">密码校验</div>
			 </TD>
			 
			 <TD>
			 	<input  name="account_passwd" type="password" class="button" prefield="user_passwd" filedtype="pwd" maxlength=6 pwdlength=6 >	
			 	<font class="orange">*</font>
			 </TD>
			 <%}%> 
          </TR> 
            <input name="credit_value" type="hidden" class="button" value="1000" id="credit_value" size="20" maxlength="6" v_must=0 v_type="string"> 
            <input name="credit_code" type="hidden" class="button" id="credit_code3" value="E" size="20" maxlength="2" v_must=0 v_type="string">
		  <TR>
		  <%
		    String handfee2 = "0.00";
			try{
                sqlStr = "select hand_fee from sSmCode where function_Code ='6720'";
    	        //retArray = callView.sPubSelect("1",sqlStr);
	        %>
            	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode17" retmsg="retMsg17"  outnum="1">
                	<wtc:sql><%=sqlStr%></wtc:sql>
                </wtc:pubselect>
                <wtc:array id="retArr17" scope="end" />
        	<%
        	    if(retArr17.length>0 && retCode17.equals("000000")){
        	        handfee2 = retArr17[0][0];
        	    }
		        //result = (String[][])retArray.get(0);
				 }
				 catch(Exception e){
					System.out.println("手续费出错!");
				 }
			%>
				<TD class=blue>应收手续费</TD>
				<TD >
				<input name="should_handfee" id="should_handfee" value="<%=handfee2%>" readonly >
				</TD>
				<TD class=blue>实收手续费</TD>
				<TD>
				<input name="real_handfee" id="real_handfee" value="0" v_must=0 v_type=money>
				<TD>
		   </TR>  
		   
			<TR>
				<TD class=blue>付款方式</TD>
				<TD>
				    <select name='payType' onchange='changePayType()'>
					<option value='0'>现金</option>
					<option value='9'>支票</option>
					</select>
					<font class="orange">*</font>
					</TD>
					<TD><font color=green>一次性付款金额</font></TD>
				<TD colspan="1">
				    <input name="cashNum" type="text" v_must=1 v_maxlength=8 v_type="string" index="8" value="" readOnly >
				<input name=cash_num type=button id="cash_num" class="b_text" onMouseUp="getCashNum();" onKeyUp="if(event.keyCode==13)getCashNum();" style="cursor：hand" value=查询>
				<font class="orange">*</font>
				</TD>
			 </TR>
			  <tr id="cashPay_div" style="display:''">
           <td class=blue>现金交款</td>
            <td colspan=3>
			    <input type="text" name="cashPay" maxlength="10" readOnly value="">
				<input name="checkPass" id="next5" type="button" onClick="check_cashPay()" class="b_text" value="交款校验">
				<font class="orange">*</font>
			</td>
         </tr>
           <TBODY>
             <TR id='checkPayTR'> 
                <TD nowrap class=blue> 
                   <div align="left">支票号码</div>
                </TD>
           <TD nowrap> 
                    <input v_must=0 v_type="0_9" name=checkNo maxlength=20 onkeyup="if(event.keyCode==13)getBankCode();" index="50">
                    <font class="orange">*</font>
					<input name=bankCodeQuery type=button class="b_text" style="cursor:hand" onClick="getBankCode()" value=查询>
				  </TD>
                <TD nowrap class=blue> 
                    <div align="left">银行代码</div>
                </TD>
                <TD nowrap> 
                    <input name=bankCode size=12 maxlength="12" readonly>
					<input name=bankName size=20 readonly>
                </TD>                                              
            </TR>
           </TBODY>
          <TBODY> 
             <TR id='checkShow' style='display=none'> 
                  <TD nowrap class=blue> 
                    <div align="left">支票交款</div>
                  </TD>
             <TD width=34%>
              	    <input v_must=0 v_type=money v_account=subentry name="checkPay" value="0.00" maxlength=15 index="51">
                    <font class="orange">*</font> </TD> 
                  <TD class=blue> 
                    <div align="left">支票余额</div>
                  </TD>
                  <TD> 
                    <input name="checkPrePay" value=0.00 readonly>
                  </TD>               
            </TR>            
           </TBODY>
            <TR>
               <TD class=blue>管理员帐户</TD>
               <TD>
               <input name="Mng_user" type='text' size="20" maxlength="10">           
               <input class="b_text" name="check_Mng_user" type='button' onClick="check_mnguser()" size="30" value=校验>
               <font class="orange">*</font>
               </TD>
                <TD nowrap class=blue>帐户密码</TD>
                <TD nowrap>
                <input  name="Mng_pwd" type="password" v_type="0_9" v_minlength=6 maxlength=6 pwdlengthth="6" value="111111">&nbsp;(6位数字)
                </TD>
           </TR>
           <TR>
               <TD class=blue>备注</TD>
               <TD colspan="3">
               <input class="InputGrey" name="sysnote" size="60" readonly>
               </TD>
           </TR>
            <TR style="display:none">
                <TD class=blue>用户备注</TD>
                <TD colspan="3">
                <input name="tonote" size="60">
                </TD>
           </TR>
       </TABLE>
 <!-----------隐藏的列表------------> 
     <TABLE cellSpacing=0>
      <TBODY>
       <TR id="footer">
       <TD>
			 <%
			 if (nextFlag==1){
			 %>			
		  <input name="next" class="b_foot"  type=button value="下一步" onclick="nextStep()" disabled>
			 <%
			  }else {
			 %>
		  <script>
			 closefields();
				</script>
			  <input class="b_foot" name="previous"  type=button value="上一步" onclick="previouStep()">
            <input class="b_foot" name="sure"  type=button value="确认" onclick="refMain()" disabled>
					 <%
					 }
					 %>
               <input class="b_foot" name=back  type=button value="清除" onclick="window.location='f6720_1.jsp'">
              <input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="关闭">
              </TD>
            </TR>
			<!-------------隐藏域--------------->
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
			<!-------------隐藏域--------------->
          </TBODY>
        </TABLE>
      	<jsp:include page="/npage/common/pwd_comm.jsp"/>
 <%
 if (nextFlag==1){
 %>	      		
<%@ include file="/npage/include/footer_simple.jsp" %>
<%
}else {
%>
<%@ include file="/npage/include/footer.jsp" %>
<%
}
%>
</FORM>

 <script language="JavaScript">
<%
if (nextFlag==1)
{
%> 
	document.frm.iccid.focus();
	//query_prodAttr();
<%
}
%>
    if (document.frm.sm_code.options.length > 0)
    {
	    if (document.frm.sm_code.options[document.frm.sm_code.options.selectedIndex].seqFlag == "Y")
	    {
	    	document.frm.grp_userno.readOnly = true;
	    	document.frm.getGrpNo.style.display = ""
	    }
	    else
	    {
	    	document.frm.grp_userno.readOnly = false;
	    	document.frm.getGrpNo.style.display = "none"
	    }
	}
	//doOnLoad();
	<%
		if (nextFlag==2)
		{
	%>
			getGrpUserNo();
			//changeSmCode();			
	<%
		}
	%>
 </script>
</BODY>
</HTML>

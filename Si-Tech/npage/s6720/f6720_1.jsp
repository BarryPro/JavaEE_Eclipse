<%
/********************
 * version v2.0
 * ������: si-tech
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
    String opName = "���Ų��忪��";
    String op_name ="���Ų��忪��";
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
  
  //�õ�ҳ����� 
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
	String group_id = "";/* add by daixy 20081127,group_id����dCustDoc�е�org_id */
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
	

  //�õ��б����
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
			 group_id = request.getParameter("group_id");	/* add by daixy 20081127,group_id����dCustDoc�е�org_id */
			 
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
          rdShowMessageDialog("�˼��ſͻ��Ѿ��ǲ����û����û���Ԥ��״̬��");
	        this.location="f6720_1.jsp";
        </script>
      <%      
      }	      
			//ȡ����������
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
			//�õ����ݵ�����
			//�õ���������			
			//ȡ����Ա����
			
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
            rdShowMessageDialog("û�еõ��û�ID,�����»�ȡ��",0);
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
            document.frm.getGrpNo.disabled = true;
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
            rdShowMessageDialog("û�еõ��ʻ�ID,�����»�ȡ��",0);
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
	        	frm.next.disabled = true;
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
            rdShowMessageDialog("�ͻ�����У�����������У�飡",0);
            document.frm.doSubmit.disabled = true;
    		return false;
        }
     }	

     //---------------------------------------
     if(retType == "CheckMng_user") //����Ա�ʻ�У��
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
          rdShowMessageDialog("����Ա�˻�У��ɹ�",2);
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
              //ֻ��һ����Ʒ���Ե�ʱ�򣬲���Ҫ�û�ѡ��
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
    	if(retType == "getCreateflag")//add
		{   //�õ��ͻ���ַ 
		
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
    	    	rdShowMessageDialog("��ȡcreateFlagʧ�ܣ�",0);
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
            rdShowMessageDialog("��ȡ�ͻ���ַʧ�ܣ������»�ȡ��",0);
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
				  showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
	        if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1){
						spellList_grp();
						spellList();				
						frm.action="f6720_2.jsp";
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
            if (channel_id == "false") {
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
	if(retType == "custCode") //�õ���Ա�û�����
    {
        if(retCode == "000000")
        {
            var memIdNo = packet.data.findValueByName("memIdNo");
            //document.frm.cust_code.value = memIdNo;
            document.frm.getUserOutNo.disabled = true;
         }
        else
        {
            rdShowMessageDialog("û�еõ��ʻ�ID,�����»�ȡ��",0);
        }
    }
}

function dateCompare(sDate1,sDate2){
	
	if(sDate1>sDate2)	//sDate1 ���� sDate2
		return 1;
	if(sDate1==sDate2)	//sDate1��sDate2 Ϊͬһ��
		return 0;
	return -1;		//sDate1 ���� sDate2
}

function refMain2()
{
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
     	/*   
		  if((jtrim(document.frm.mainProduct.value) == "") && (document.frm.mainProduct.v_must==1))
        {
        	rdShowMessageDialog("���ײͱ�������!!");
            document.frm.mainProduct .select();
            return false;
        }   */
        
        	if(  document.frm.grp_id.value == "" ){
            rdShowMessageDialog("�����û�ID��������!!");
            document.frm.grp_id.select();
            return false;
        }
        
        
        if(  document.frm.grp_name.value == "" ){
            rdShowMessageDialog("�û�����:"+document.frm.grp_name.value+",��������!!");
            document.frm.grp_name.select();
            return false;
        }
         	if(  document.frm.account_id.value == "" ){
            rdShowMessageDialog("�ʻ�ID��������!!");
            document.frm.account_id.select();
            return false;
        }
   /*      	if(  document.frm.cust_code.value == "" ){
            rdShowMessageDialog("��Ա�û������������!!");
            document.frm.cust_code.select();
            return false;
         }   */
        
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
		
		
				document.frm.chgsrv_start.value = changeDateFormat(document.frm.srv_start.value);
        document.frm.chgsrv_stop.value  = changeDateFormat(document.frm.srv_stop.value);
        document.frm.sysnote.value = "���Ų����û�����"+document.frm.grp_userno.value;
        document.frm.tonote.value = "���Ų����û�����"+document.frm.grp_userno.value;	
        
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
    var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
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
        rdShowMessageDialog("����Ա�û�����Ϊ�գ�");
        return false;
    } 
    var checkPwd_Packet = new AJAXPacket("CheckMng_user.jsp","���ڽ�������У�飬���Ժ�......");
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
	//�õ��ʻ�ID
  var getAccountId_Packet = new AJAXPacket("../s3500/f1100_getId.jsp","���ڻ���ʻ�ID�����Ժ�......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","AccountId");
	getAccountId_Packet.data.add("idType","1");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet = null;
	 //document.frm.sure.disabled = false;
   //document.frm.sure2.disabled = false;
}

//�õ������û����user_no
function getGrpUserNo()
{
    var sm_code = document.frm.sm_code.value;

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��");
        return false;
    }

    var getgrp_Userno_Packet = new AJAXPacket("getGrpUserno.jsp","���ڻ�ü����û���ţ����Ժ�......");
    getgrp_Userno_Packet.data.add("retType","GrpNo");
    getgrp_Userno_Packet.data.add("orgCode","<%=org_code%>");
    getgrp_Userno_Packet.data.add("smCode",sm_code);
    core.ajax.sendPacket(getgrp_Userno_Packet);
    getgrp_Userno_Packet = null;
}

function getGrpId()
{
    //�õ������������û�����
    var getgrp_no_Packet = new RPCPacket("../s6720/getGrpId.jsp","���ڻ�ü��Ŵ��룬���Ժ�......");
    getgrp_no_Packet.data.add("retType","GrpId");
    getgrp_no_Packet.data.add("orgCode","<%=org_code%>");
    core.rpc.sendPacket(getgrp_no_Packet);
    delete(getgrp_no_Packet);
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
  if(((document.frm.cust_id.value).trim()) ==""||((document.frm.unit_id.value).trim()) == ""||((document.frm.cust_name.value).trim()) == "")
  {
      rdShowMessageDialog("������ѡ�����û�������Ϣ��");
      return false;
  }  
	frm.action="f6720_1.jsp?action=select";
	frm.method="post";
	frm.submit();
}
//��һ��
function previouStep(){
	frm.action="f6720_1.jsp";
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
			  var getInfoPacket = new AJAXPacket("s6720_custaddress.jsp","���ڲ�ѯ�ͻ���ַ�����Ժ�......");
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

//��ѯchannel_id
function query_channelid()
{
			  var getInfoPacket = new RPCPacket("s2890_channelid.jsp","���ڲ�ѯ�����Ժ�......");
				getInfoPacket.data.add("retType","query_channelid");
				getInfoPacket.data.add("org_code","<%=org_code%>");
				getInfoPacket.data.add("town_code",document.frm.town_code.value);
				core.rpc.sendPacket(getInfoPacket);
				delete(getInfoPacket);
}
//���ù������棬���м����ʻ�ѡ��
function getInfo_Acct()
{
    var pageTitle = "�����ʻ�ѡ��";
    var fieldName = "�����û�ID|�����û�����|��Ʒ����|�����ʺ�|";
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
/** add by daixy 20081127,group_id����dCustDoc�е�org_id   
** var fieldName = "֤������|�ͻ�ID|�ͻ�����|����ID|��������|������|";
**   var sqlStr = "";
** var selType = "S";    //'S'��ѡ��'M'��ѡ 
**    var retQuence = "6|0|1|2|3|4|5|";
**    var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_codeNew|";
**/
 	var fieldName = "֤������|�ͻ�ID|�ͻ�����|����ID|��������|������|������֯|";
	  var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
 	var retQuence = "7|0|1|2|3|4|5|6|";
    var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_codeNew|group_id|";  
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
/** add by daixy 20081127,group_id����dCustDoc�е�org_id  
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
//��ѯgetCreateflag
function getCreateflag()
{ 
    if(((frm.sm_code.value).trim()) == "")
    {
        rdShowMessageDialog("���ȡҵ�����ͣ�");
        frm.sm_code.focus();
        return false;
    }
    var getCheckInfo_Packet = new RPCPacket("f3505_getflag.jsp","���ڻ�������Ϣ�����Ժ�......");
		getCheckInfo_Packet.data.add("retType","getCreateflag");
    getCheckInfo_Packet.data.add("sm_code",document.frm.sm_code.value);
		core.rpc.sendPacket(getCheckInfo_Packet);
		delete(getCheckInfo_Packet);     
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
    if(forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("�ͻ�ID���������֣�");
    	return false;
    }

    var getInfoPacket = new RPCPacket("f1902_Infoqry.jsp","���ڻ�ü��ſͻ���Ϣ�����Ժ�......");
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
    if(forNonNegInt(frm.cust_id) == false)
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
    if(forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
        rdShowMessageDialog("����ID���������֣�");
    	return false;
    }

    var getInfoPacket = new RPCPacket("f1902_Infoqry.jsp","���ڻ�ü��ſͻ���Ϣ�����Ժ�......");
        var cust_id = document.frm.cust_id.value;
        getInfoPacket.data.add("region_code","<%=regionCode%>");
        getInfoPacket.data.add("retType","UnitInfo");
        getInfoPacket.data.add("cust_id",cust_id);
        getInfoPacket.data.add("unit_id",unit_id);
        core.rpc.sendPacket(getInfoPacket);
        delete(getInfoPacket);
}

//��ѯ��Ʒ����
function query_prodAttr()
{
    var sm_code = document.frm.sm_code.options[document.frm.sm_code.selectedIndex].value;
    if(document.frm.sm_code.value == "")
    {
        return false;
    }

    var getInfoPacket = new RPCPacket("fpubprodattr_qry.jsp","���ڲ�ѯ��Ʒ���Դ��룬���Ժ�......");
        getInfoPacket.data.add("retType","ProdAttr");
        getInfoPacket.data.add("sm_code",sm_code);
        core.rpc.sendPacket(getInfoPacket);
        delete(getInfoPacket);
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
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��");
        return false;
    }

    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
//��ѯ֧Ʊ����
function getBankCode()
{ 
  	//���ù���js�õ����д���
    if(((frm.checkNo.value).trim()) == "")
    {
        rdShowMessageDialog("������֧Ʊ���룡");
        frm.checkNo.focus();
        return false;
    }
    var getCheckInfo_Packet = new AJAXPacket("../s3500/getBankCode.jsp","���ڻ��֧Ʊ�����Ϣ�����Ժ�......");
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
    var pageTitle = "�����̲�ѯ";
    var fieldName = "�����̴���|����������|";
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
    var fieldName = "��Ʒ����|��Ʒ����|";
	  var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "product_code|";

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��");
        return false;
    }
    //�����ж��Ƿ��Ѿ�ѡ���˲�Ʒ����
    if(document.frm.product_attr_hidden.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ͣ�");
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
    if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�");
        return false;
    }
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
        //����һ����У��,����У��
        var pwd1 = obj1.value;
        var pwd2 = obj2.value;        
        if(pwd1 != pwd2)
        {
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

//��Ʒ���Ա���¼�
function changeProdAttr() {
	document.frm.product_code.value = "";
  //document.frm.product_append.value = "";
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

function refMain(){

    getAfterPrompt();
//У�鶯̬���ɵ��ֶ�
	if(!checkDynaFieldValues_grp(false))
			return false;
			
	if(!checkDynaFieldValues(false))
			return false;
			
    var checkFlag; //ע��javascript��JSP�ж���ı���Ҳ������ͬ,���������ҳ����.

    //˵��:���ֳ�����,һ���������Ƿ��ǿ�,��һ���������Ƿ�Ϸ�.
   if(document.all.Mng_pwd.value.length<6)
  {
      rdShowMessageDialog("����Ա�˻����볤������",0);
      document.all.Mng_pwd.value="";
      document.all.Mng_pwd.focus();
      return false;
   }  
  
   if(!isDecimal(document.all.Mng_pwd.value)){
   	  rdShowMessageDialog("����Ա�˻����벻�����ִ���",0);
   	  document.all.Mng_pwd.value="";
      document.all.Mng_pwd.focus();
      return false;
    }
  
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
        
        
        	if(  document.frm.grp_id.value == "" ){
            rdShowMessageDialog("�����û�ID��������!!");
            document.frm.grp_id.select();
            return false;
        }
        
        
        if(  document.frm.grp_name.value == "" ){
            rdShowMessageDialog("�û�����:"+document.frm.grp_name.value+",��������!!");
            document.frm.grp_name.select();
            return false;
        }
         	if(  document.frm.account_id.value == "" ){
            rdShowMessageDialog("�ʻ�ID��������!!");
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
		 if(((document.all.user_passwd.value).trim()).length>0)
        {
            if(document.all.user_passwd.value.length<6)
            {
                rdShowMessageDialog("�û����볤������",0);
                document.all.user_passwd.focus();
                return false;
             }
             
             if(checkPwd(document.all.user_passwd,document.all.account_passwd)==false)
                return false;
                
             if(!(isDecimal(document.all.user_passwd.value)&&isDecimal(document.all.account_passwd.value))){
             	  rdShowMessageDialog("�û����벻Ϊ���ִ���",0);
             	  document.all.user_passwd.value = "";
             	  document.all.account_passwd.value="";
               return false;
              }
        }
        else
        {
            rdShowMessageDialog("�û����벻��Ϊ�գ�",0);
            document.all.user_passwd.focus();
            return false;
        }

	   	
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
        
    if(  document.frm.Mng_pwd.value == "" ){
          document.frm.Mng_pwd.value="111111";
        }
        
		if (parseFloat(document.frm.should_handfee.value)==0)
		{
			document.frm.real_handfee.value="0.00";
		}
        //���ڲ���̫�࣬��Ҫͨ��form��post����,���,��Ҫ����������ݸ��Ƶ���������. yl.
        document.frm.chgsrv_start.value = changeDateFormat(document.frm.srv_start.value);
        document.frm.chgsrv_stop.value  = changeDateFormat(document.frm.srv_stop.value);  
        document.frm.sysnote.value = "����"+document.frm.unit_id.value+"�����Ʒ"+document.frm.product_code.value;
        document.frm.tonote.value =  "����"+document.frm.unit_id.value+"�����Ʒ"+document.frm.product_code.value;	
	 getSysAccept();  
}



//ȡ��ˮ
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("../s3500/pubSysAccept.jsp","�������ɲ�����ˮ�����Ժ�......");
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

 //����ܼƽ��
function getCashNum(){

	if(!checkDynaFieldValues_grp(true)){//������������
			return false;
		}
	if(!checkDynaFieldValues(true)){//������������
		return false;
	}
	
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
        rdShowMessageDialog("������ѡ�����Ʒ�ƣ�");
        return false;
    }
    //�ж��Ƿ�ѡ���˲�Ʒ����
    if(document.frm.product_attr_hidden.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�");
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
//���㼯�źͳ�Ա�ļ����ֶ�
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
function closefields()//�����һ��ʱ���Ѿ���õ��ֶβ����޸�
{
		document.frm.custQuery.disabled=true;
		document.frm.chkPass.disabled=true;
		//document.frm.ProdAttrQuery.disabled=true;
		//document.frm.UserTypeQuery.disabled=true;				
}

function showPrtDlg(printType,DlgMessage,submitCfm) {  //��ʾ��ӡ�Ի���
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
			retInfo+="�ͻ�����:"+document.all.cust_name.value+"|";
			retInfo+="���ſͻ�ID:"+document.all.cust_id.value+"|";
			retInfo+="֤������:"+document.all.iccid.value+"|";
			retInfo+="��λ��ַ:"+document.all.cust_address.value+"|";
			retInfo+="����ҵ��:"+"���Ų���ҵ������"+"|";
			retInfo+="��������:"+document.all.grp_name.value+"|";
			retInfo+="���Ų����˻�:"+document.all.account_id.value+"|";
			retInfo+="ҵ���ײ�:"+"���Ų��忪��"+"|";
			retInfo+="�����Чʱ��:"+"����"+"|";
			retInfo+="������ˮ:"+document.all.login_accept.value+"|";
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
	<div id="title_zi">������Ϣ</div>
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
<!--add by daixy 20081127,group_id����dCustDoc�е�org_id
<input type="hidden" name="group_id"  value="<%=GroupId%>">
-->
<input type="hidden" name="group_id"  value="<%=group_id%>">
<input type="hidden" name="login_accept"  value="0"> <!-- ������ˮ��-->
<input type="hidden" name="bill_type"  value="0"> <!-- �������� -->
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
<input name="srv_start"  type="hidden" class="button" id="srv_start"  onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>" size="20" maxlength="8" v_must=1 v_type="date" v_name="ҵ����ʼ����"> 
<input name="srv_stop"   type="hidden" class="button" id="srv_stop"  onKeyPress="return isKeyNumberdot(0)" value="20500101" size="20" maxlength="8" v_must=1 v_type="date" v_name="ҵ���������" > 
<input name="billTime"   type="hidden" v_must=1 v_maxlength=8 v_type="string" v_name="�Ʒ�ʱ��" index="8" value="<%=(billTime=="")?dateStr:billTime%>" >    

             
<TABLE cellSpacing=0>
    <TR>
        <TD class=blue>
            <div align="left">֤������</div>
        </TD>
        <TD>
            <input name=iccid <%if(nextFlag==2)out.println("readonly");%> id="iccid" size="24" maxlength="20" v_type="string" v_must=1 index="1" value="<%=iccid%>" >
            <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=��ѯ >
            <font class="orange">*</font>
        </TD>
        <TD class=blue>���ſͻ�ID</TD>
        <TD>
            <input type="text" name="cust_id" <%if(nextFlag==2)out.println("readonly");%> size="20" maxlength="20" v_type="0_9" v_must=1 vindex="2" value="<%=cust_id%>">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class=blue>
            <div align="left">���ű��</div>
        </TD>
        <TD>
            <input name=unit_id id="unit_id" <%if(nextFlag==2)out.println("readonly");%> size="24" maxlength="11" v_type="0_9" v_must=1 index="3" value="<%=unit_id%>">
            <font class="orange">*</font>
        </TD>
        <TD class=blue>���ſͻ�����</TD>
        <TD>
            <input name="cust_name" size="20" <%if(nextFlag==2)out.println("readonly");%> v_must=1 v_type=string index="4" value="<%=cust_name%>">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class=blue>���ſͻ�����</TD>
        <TD>
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
            <font class="orange">*</font>
        </TD>
        <TD class=blue>����Ʒ��</TD>
        <TD>
            <select name="sm_code" id="sm_code"   onChange="changeSmCode()" v_must=1 v_type="string" index="10">
                <option class='button' value='CR' seqFlag='Y' payFlag='0' createFlag='Y'>CR->�����Ʒ</option>
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
	<%@ include file="fpubDynaFields_usr.jsp"%>     

<%
    if (calcButtonFlag_all)//����м����ֶ�����ʾ���㰴ť
		{
   %>
			<TR>
				<TD colspan="4">
					<input value="������ɫ�Ǻŵ�ֵ" name=calcAll type=button id="calcAll" class="b_text" onMouseUp="calcAllFieldValues_all();" onKeyUp="if(event.keyCode==13)calcAllFieldValues_all();" style="cursor��hand">
				</TD>
			</TR>

		<TABLE cellSpacing=0 style="display:<%=listShow%>">
    <%
		}
	  %>	 
		
			 <TD style="display:none" class=blue>�����û����</TD>
          <TD  style="display:none">
              <input name="grp_userno" type="text" class="button" size="20" maxlength="12"  v_type="string" v_must=1>
              <input name="getGrpNo" type="button" class="b_text" id="getGrpNo" onMouseUp="getGrpUserNo();" onKeyUp="if(event.keyCode==13)getGrpUserNo();" value="��ȡ">
              <font class="orange">*</font>
           </TD>          
        <TR>
          <TD class=blue>��Ʒ����</TD>
           <TD >
              <input type="text"  name="product_attr_hidden" size="20"   onChange="changeProdAttr()" v_must=1 v_type="string" value="<%=product_attr_hidden%>">
              <input name="ProdAttrQuery" type="button" id="ProdAttrQuery"  class="b_text" onMouseUp="getInfo_ProdAttr();" onKeyUp="if(event.keyCode==13)getInfo_ProdAttr();" value="ѡ��">
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
			          logger.error("��ѯ����ʡ����ʧ��!");
			         }
			        %>
			        v_must=1 v_type="0_9" index="11"> 
            </TD>
            <TD class=blue>���Ų�Ʒ</TD>
            <TD>
              <input class="button" type="text" name="product_code" size="20" readonly onChange="changeProduct()" v_must=1 v_type="string" value="<%=product_code%>">
              <input name="prodQuery" type="button" id="ProdQuery"  class="b_text" onClick="getInfo_Prod();" onClick="if(event.keyCode==13)getInfo_Prod();" value="ѡ��">
			        <font class="orange">*</font>
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
            <TD class=blue>��Ʒ�ʻ�</TD>
            <TD colspan=3>
              <input name="account_id" type="text" size="20" maxlength="12" readonly v_type="0_9" v_must=1 value="<%=account_id%>">
              <input name="accountQuery" type="button" class="b_text" id="accountQuery" onClick="getAccountId();" onClick="if(event.keyCode==13)getAccountId();" value="��ȡ" >
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
			 	<font class="orange">*</font>
			 </TD>
			 
			 <TD class=blue> 
			 	<div align="left">����У��</div>
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
					System.out.println("�����ѳ���!");
				 }
			%>
				<TD class=blue>Ӧ��������</TD>
				<TD >
				<input name="should_handfee" id="should_handfee" value="<%=handfee2%>" readonly >
				</TD>
				<TD class=blue>ʵ��������</TD>
				<TD>
				<input name="real_handfee" id="real_handfee" value="0" v_must=0 v_type=money>
				<TD>
		   </TR>  
		   
			<TR>
				<TD class=blue>���ʽ</TD>
				<TD>
				    <select name='payType' onchange='changePayType()'>
					<option value='0'>�ֽ�</option>
					<option value='9'>֧Ʊ</option>
					</select>
					<font class="orange">*</font>
					</TD>
					<TD><font color=green>һ���Ը�����</font></TD>
				<TD colspan="1">
				    <input name="cashNum" type="text" v_must=1 v_maxlength=8 v_type="string" index="8" value="" readOnly >
				<input name=cash_num type=button id="cash_num" class="b_text" onMouseUp="getCashNum();" onKeyUp="if(event.keyCode==13)getCashNum();" style="cursor��hand" value=��ѯ>
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
                <TD nowrap class=blue> 
                   <div align="left">֧Ʊ����</div>
                </TD>
           <TD nowrap> 
                    <input v_must=0 v_type="0_9" name=checkNo maxlength=20 onkeyup="if(event.keyCode==13)getBankCode();" index="50">
                    <font class="orange">*</font>
					<input name=bankCodeQuery type=button class="b_text" style="cursor:hand" onClick="getBankCode()" value=��ѯ>
				  </TD>
                <TD nowrap class=blue> 
                    <div align="left">���д���</div>
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
                    <div align="left">֧Ʊ����</div>
                  </TD>
             <TD width=34%>
              	    <input v_must=0 v_type=money v_account=subentry name="checkPay" value="0.00" maxlength=15 index="51">
                    <font class="orange">*</font> </TD> 
                  <TD class=blue> 
                    <div align="left">֧Ʊ���</div>
                  </TD>
                  <TD> 
                    <input name="checkPrePay" value=0.00 readonly>
                  </TD>               
            </TR>            
           </TBODY>
            <TR>
               <TD class=blue>����Ա�ʻ�</TD>
               <TD>
               <input name="Mng_user" type='text' size="20" maxlength="10">           
               <input class="b_text" name="check_Mng_user" type='button' onClick="check_mnguser()" size="30" value=У��>
               <font class="orange">*</font>
               </TD>
                <TD nowrap class=blue>�ʻ�����</TD>
                <TD nowrap>
                <input  name="Mng_pwd" type="password" v_type="0_9" v_minlength=6 maxlength=6 pwdlengthth="6" value="111111">&nbsp;(6λ����)
                </TD>
           </TR>
           <TR>
               <TD class=blue>��ע</TD>
               <TD colspan="3">
               <input class="InputGrey" name="sysnote" size="60" readonly>
               </TD>
           </TR>
            <TR style="display:none">
                <TD class=blue>�û���ע</TD>
                <TD colspan="3">
                <input name="tonote" size="60">
                </TD>
           </TR>
       </TABLE>
 <!-----------���ص��б�------------> 
     <TABLE cellSpacing=0>
      <TBODY>
       <TR id="footer">
       <TD>
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
               <input class="b_foot" name=back  type=button value="���" onclick="window.location='f6720_1.jsp'">
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

		   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-16
********************/
%>
              
<%
  String opCode = "1428";
  String opName = "托收关系解除";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
  request.setCharacterEncoding("GBK");
%>


<html>
<head>
<title>托收关系解除</title>
<%
	Logger logger = Logger.getLogger("s1428_1.jsp");

    String work_no = (String)session.getAttribute("workNo");
    String org_code = (String)session.getAttribute("orgCode");
    String regionCode = (String)session.getAttribute("regCode");
    
	String op_code = "1428";
	String error_code = "";
    String error_msg = "";
	String[][] temfavStr= (String[][])session.getAttribute("favInfo");
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
	  favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
		boolean hfrf=false;
      
    //2011/9/2  diling添加 对密码权限整改 start
  	String pubOpCode = opCode;  
  %>
  	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
  <%
  	System.out.println("==第二批======s1428_1.jsp==== pwrf = " + pwrf);
  //2011/9/2  diling添加 对密码权限整改 end


    ArrayList retArray = new ArrayList();
    String[][] result = new String[][]{};
	

	String [][]feeStr;
	String [][]initStr_1= new String[][]{};
	String [][]initStr_2= new String[][]{};
	String [][]initStr_3= new String[][]{};
    String [][]initStr_4= new String[][]{};
    String [][]initStr_5= new String[][]{};
    
    String[][] result_t3 =new String[][]{};
    String[][] result_t4 =new String[][]{};
    String[][] result_t5 =new String[][]{};
    String[][] result_t6 =new String[][]{};
    String[][] result_t7 =new String[][]{};
    String[][] result_t9 =new String[][]{};
    String[][] result_t10 =new String[][]{};
    String[][] result_t11 =new String[][]{};
    
    
    String sysAcceptl = "";
    
 	String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
    String cus_pass="";
      try{
	Map map = (Map)session.getAttribute("contactInfoMap");
	ContactInfo contactInfo = (ContactInfo)map.get(srv_no);
	cus_pass=contactInfo.getPasswdVal(2);
	System.out.println("------------cus_pass---------------"+cus_pass);
 	}catch(Exception e){
 	}
	//-----------获得手续费-------------
	String sqHf="select hand_fee ,trim(favour_code) from snewFunctionFee where region_code=substr(:org_code,1,2) and FUNCTION_CODE=:op_code";
	System.out.println("------------sqHf---------------"+sqHf);
	//ArrayList handFeeArr=co.spubqry32("2",sqHf);
	String [] paraIn1 = new String[2];
	paraIn1[0]=sqHf;
	paraIn1[1]="org_code="+org_code+",op_code="+op_code;
%>

    <wtc:service name="TlsPubSelCrm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">	
	<wtc:param value="<%=paraIn1[0]%>"/>
 	<wtc:param value="<%=paraIn1[1]%>"/>
 	</wtc:service>
	<wtc:array id="result_t1" scope="end" />		

<%	
	
	
	
	String oriHandFee="0";
	String oriHandFeeFlag="";
    if(result_t1.length>0&&code1.equals("000000"))
	{
	   oriHandFee=result_t1[0][0];
	   oriHandFeeFlag=result_t1[0][1];
       if(Double.parseDouble(oriHandFee) < 0.01)
		   hfrf=true;
	   else
	   {
         if(!WtcUtil.haveStr(favStr,oriHandFeeFlag.trim()))
			hfrf=true;
	   }
	}
    else
	  hfrf=true;

	//-----------获得服务器端费用信息数组-------------
	String sq1="select trim(fee_code),trim(detail_code),trim(detail_name) from sFeecodedetail order by fee_code,detail_code";
	//feeArr=co.spubqry32("3",sq1);	 
   
    System.out.println();System.out.println();System.out.println();System.out.println();System.out.println();

%>

    <wtc:service name="TlsPubSelBoss" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sq1%>" />
		</wtc:service>
		<wtc:array id="result_t2" scope="end" />


<%		   
 feeStr=result_t2;
	if(feeStr.length==0)
      response.sendRedirect("s1428.jsp?ReqPageName=s1212Main&retMsg=2");

    //------------获得服务器端初始化信息数组-----------

 	//initArr=im1210.s1212Init(srv_no,work_no,op_code,org_code,"phone",srv_no);
	try{

%>

		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptlt" /> 

    <wtc:service name="s1428Init" outnum="42" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=work_no%>" />
			<wtc:param value="<%=srv_no%>" />
			<wtc:param value="<%=op_code%>" />
			<wtc:param value="<%=org_code%>" />			
		</wtc:service>
		<wtc:array id="result_t3t" scope="end"  start="0"  length="21" />
		<wtc:array id="result_t4t" scope="end"  start="21"  length="7" />
		<wtc:array id="result_t5t" scope="end"  start="28"  length="5" />
		<wtc:array id="result_t6t" scope="end"  start="33"  length="8" />
		<wtc:array id="result_t7t" scope="end"  start="41"  length="1" />				

<%            
						if(code3.equals("000000"))
						{
						result_t3 = result_t3t;
						result_t4 = result_t4t;
						result_t5 = result_t5t;
						result_t6 = result_t6t;
						result_t7 = result_t7t;
						}
						sysAcceptl = sysAcceptlt;
            error_code = code3;
            error_msg= msg3;


		
		System.out.println("-------------------------error_msg-----------------------"+error_msg);
		String errMsg_t="查询用户业务品牌时出错";
		
		if(error_msg.equals(""))
		error_msg = errMsg_t;

	}
	catch (Exception e)
	{
		System.out.println("调用服务s1212Init失败!!");
	}
	if(!error_code.equals("000000"))
    {
	   System.out.println("55555555555555555555555555555555555555555");
	   System.out.println("6666666666666+error_code"+error_code);

	%>
       <script language="javascript">
	 		 rdShowMessageDialog('<%=error_msg%>',0);
       history.go(-1);
	 		 </script>
	<%
	}else {
 	initStr_1=result_t3;

System.out.println("------------------s-------error_msg-----------------------"+error_msg);


	if(initStr_1.length==0) {
		String [][]errStr=result_t7;
		System.out.println("====" + errStr[0][0]);
        response.sendRedirect("s1428.jsp?ReqPageName=s1212Main&retMsg=101&errCode="+errStr[0][0]+"&errMsg="+errStr[0][1]);
		//System.out.println("====" + errStr[0][0]);
		//System.out.println("====" + errStr[0][1]);
	    //response.sendRedirect("s1428.jsp?ReqPageName=s1212Main&retMsg=10");
	}
	
	//twoFlag=im1210.s1210Index(srv_no,"phone",srv_no);
	String sq1_ejb = "select trim(attr_code) from dcustMsg where phone_no=:srv_no and substr(run_code,2,1)<'a' and rownum<2";
	String [] paraIn9 = new String[2];
	paraIn9[0]=sq1_ejb;
	paraIn9[1]="srv_no="+srv_no;
	
%>
	<wtc:service name="TlsPubSelCrm" outnum="10" retmsg="msg4" retcode="code4" routerKey="phone" routerValue="<%=srv_no%>">
  	<wtc:param value="<%=paraIn9[0]%>"/>
 	<wtc:param value="<%=paraIn9[1]%>"/>
 	</wtc:service>
	<wtc:array id="result_t9t" scope="end"/>

<%	
				System.out.println("------------sq1_ejb---------------"+sq1_ejb);
				System.out.println("------------code4---------------"+code4);
				System.out.println("------------msg4---------------"+msg4);	
			
			String temFlag = "";
			if (result_t9t.length== 0)
				temFlag = "00000";
			else
				temFlag = result_t9t[0][0];
			
			String sq2Buf = "";
			String sq2Buf2 = "";
			String [] paraIn10 = new String[2];
			String [] paraIn11 = new String[2];
			
				
			if (!temFlag.equals(""))
			{
				String bigFlag = temFlag.substring(2, 4);
				String grpFlag = temFlag.substring(4, 5);
				sq2Buf = "select trim(card_name) from sBigCardCode where card_type=:bigFlag";
				sq2Buf2="select trim(grp_name) from sGrpBigFlag where grp_flag=:grpFlag";
				paraIn10[0]=sq2Buf;
				paraIn10[1]="bigFlag="+bigFlag;
		
				paraIn11[0]=sq2Buf2;
				paraIn11[1]="grpFlag="+grpFlag;
			}
			
			
				
%>	
	<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg4" retcode="code4" routerKey="phone" routerValue="<%=srv_no%>">
  	<wtc:param value="<%=paraIn10[0]%>"/>
 	<wtc:param value="<%=paraIn10[1]%>"/>
 	</wtc:service>
	<wtc:array id="result_t10t" scope="end"/>
	 	
	 
	<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg4" retcode="code4" routerKey="phone" routerValue="<%=srv_no%>">
  	<wtc:param value="<%=paraIn11[0]%>"/>
 	<wtc:param value="<%=paraIn11[1]%>"/>
   </wtc:service>
	<wtc:array id="result_t11t" scope="end"/>

<%
				
				result_t9 = result_t9t;
				result_t10 = result_t10t;
				result_t11 = result_t11t;
				
    if(result_t9==null || result_t9.length==0)
      response.sendRedirect("s1428.jsp?ReqPageName=s1212Main&retMsg=11");

    if(WtcUtil.repNull(request.getParameter("ReqPageName")).equals("s1212Login"))
	{
	/*
 	  String passTrans=WtcUtil.repNull(request.getParameter("cus_pass"));
 	*/
 	  System.out.println("------------initStr_1[0][4]---------------"+initStr_1[0][4]);
 	  if(!pwrf)
	  {
	  /*
	   String passFromPage=Encrypt.encrypt(passTrans);
	   */
	   System.out.println("------------cus_pass---------------"+cus_pass);
       if(0==Encrypt.checkpwd2((initStr_1[0][4]).trim(),cus_pass))
		 response.sendRedirect("s1428.jsp?ReqPageName=s1212Main&retMsg=3");
	  }
	}
 	if(Double.parseDouble(initStr_1[0][18])>0)
	{
      //response.sendRedirect("s1428.jsp?ReqPageName=s1212Main&retMsg=100&oweAccount="+initStr_1[0][17].trim()+"&oweFee="+initStr_1[0][18].trim());
	}

 	initStr_2=result_t4;
	System.out.println("!!!!!!!!!!!!!!!!initStr_2="+initStr_2.length);
    if(initStr_2.length==0)	{
		initStr_2 = new String[1][7];
         initStr_2[0][0] = "0";
		 initStr_2[0][1] = "";
		 initStr_2[0][2] = "99999999";
		 initStr_2[0][3] = "0";
		 initStr_2[0][4] = "0";
		 initStr_2[0][5] = "N";
		 initStr_2[0][6] = "Y";

	}
    //  response.sendRedirect("s1428.jsp?ReqPageName=s1212Main&retMsg=12");

	initStr_3=result_t5;
	System.out.println("@@@@@@@@@@@@@@@@initStr_3="+initStr_3.length);
    //if(initStr_3.length==0)
    //  response.sendRedirect("s1428.jsp?ReqPageName=s1212Main&retMsg=13");

	initStr_4=result_t6;
	System.out.println("#####################initStr_4="+initStr_4.length);
    if(initStr_4.length==0) {
         initStr_4 = new String[1][8];
         initStr_4[0][0] = "";
		 initStr_4[0][1] = "";
		 initStr_4[0][2] = "";
		 initStr_4[0][3] = "";
		 initStr_4[0][4] = "";
		 initStr_4[0][5] = "";
		 initStr_4[0][6] = "";
		 initStr_4[0][7] = "";

	    //response.sendRedirect("s1428.jsp?ReqPageName=s1212Main&retMsg=13");
    }
    initStr_5=result_t7;
	System.out.println("#####################initStr_5="+initStr_5.length);
    if(initStr_5.length==0) {
         initStr_5 = new String[1][1];
         initStr_5[0][0] = "0";
		
    }else{
  
    System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa="+initStr_5[0][0].trim());
    }

	System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
	 }
 %>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  var js_fee = new Array(new Array(),new Array(),new Array());
  var js_init1=new Array(new Array());
  var js_init2=new Array(new Array(),new Array(),new Array(),new Array(),new Array(),new Array(),new Array());
  var js_init3=new Array(new Array(),new Array(),new Array(),new Array(),new Array());
  var opFlag="add";

  onload=function()
  {
 	self.status="";
	

	
<%
	//-----------获得客户端费用信息数组-------------
	for(int i=0;i<feeStr.length;i++)
    {
	  for(int j=0;j<feeStr[i].length;j++)
	  {
%>
	    js_fee[<%=j%>][<%=i%>]="<%=feeStr[i][j].trim()%>";
<%
 	  }
	}

    //------------获得客户端初始化信息数组-----------
	for(int i=0;i<initStr_1.length;i++)
    {
	  for(int j=0;j<initStr_1[i].length;j++)
	  {
%>
	    js_init1[<%=i%>][<%=j%>]="<%=initStr_1[i][j].trim()%>";
<%
 	  }
	}

	for(int i=0;i<initStr_2.length;i++)
    {
	  for(int j=0;j<initStr_2[i].length;j++)
	  {
%>
	    js_init2[<%=j%>][<%=i%>]="<%=initStr_2[i][j].trim()%>";
<%
 	  }
	}

	for(int i=0;i<initStr_3.length;i++)
    {
	  for(int j=0;j<initStr_3[i].length;j++)
	  {
%>
	    js_init3[<%=j%>][<%=i%>]="<%=initStr_3[i][j].trim()%>";
<%
 	  }
	}
%>
	initFace("FromStart");
	}

  function doProcess(packet)
  {
  	 var passFlag=packet.data.findValueByName("passFlag");
	 var billFlag=packet.data.findValueByName("billFlag");
	 var areaFlag=packet.data.findValueByName("areaFlag");
	 var dataFlag=packet.data.findValueByName("dataFlag");

	 if(passFlag=="n" || billFlag=="n" || areaFlag=="n" || dataFlag=="n")
	 {		
		 if(dataFlag=="n")
		 {
            rdShowMessageDialog("无此帐户！",0);
		    if(document.all.tr_t_account.style.display=="")
            {
 		     document.all.t_acc_pass1.value="";

            }
            else if(document.all.tr_s_account.style.display=="")
 	        {
             document.all.t_acc_pass.value="";
		     document.all.t_acc_pass.focus();
		    }
		 }
		 else if(billFlag=="n")
		 {   
		   rdShowMessageDialog("此帐户为默认帐户！",0);
		   if(document.all.tr_t_account.style.display=="")
		   {

			 document.all.t_acc_pass1.value="";

		   }
		   else if(document.all.tr_s_account.style.display=="")
		   {
			 document.all.t_acc_pass.value="";
			 document.all.t_acc_pass.focus();
		   }
		 }
		 else if(areaFlag=="n")
		 {
           rdShowMessageDialog("此帐户为异地帐户！",0);
		   if(document.all.tr_t_account.style.display=="")
           {
 		    
 		     document.all.t_acc_pass1.value="";

           }
           else if(document.all.tr_s_account.style.display=="")
 	       {
             document.all.t_acc_pass.value="";
		     document.all.t_acc_pass.focus();
		   }
		 }
		 else if(passFlag=="n")
		 {
           rdShowMessageDialog("帐户密码错误！",0);
    	   if(document.all.tr_t_account.style.display=="")
           {
 		     document.all.t_acc_pass1.value="";
		     document.all.t_acc_pass1.focus();
           }
           else if(document.all.tr_s_account.style.display=="")
 	       {
             document.all.t_acc_pass.value="";
		     document.all.t_acc_pass.focus();
		   }
		 }
	 }
	 else if(passFlag=="y" && billFlag=="y" && areaFlag=="y" && dataFlag=="y")
	 {
	   rdShowMessageDialog("帐户信息验证成功！",2);
	   document.all.b_print.disabled=false;
	 }
  }

 //--------1---------显示打印对话框----------------
function printCommit()
{          
	getAfterPrompt();
	// in here form check
	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");  	 
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{
     if(check(document.frm))
     {
        document.all.t_sys_remark.value="用户"+"<%=initStr_1[0][0].trim()%>"+"付费计划变更";
		if((document.all.t_op_remark.value).trim().length==0)
        {
			  document.all.t_op_remark.value="操作员<%=work_no%>"+"对用户"+"<%=initStr_1[0][0].trim()%>"+"进行托收关系解除"
		}
		if((document.all.assuNote.value).trim().length==0)
        {
			  document.all.assuNote.value="操作员<%=work_no%>"+"对用户"+"<%=initStr_1[0][0].trim()%>"+"进行托收关系解除"
		}
		

		//显示打印对话框 
        var h=210;
        var w=450;
        var t=screen.availHeight/2-h/2;
        var l=screen.availWidth/2-w/2;
        var printStr = printInfo(printType);
        var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
        
     var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =<%=sysAcceptl%>;                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = <%=activePhone%>;                            //客户电话
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
		
		
        
        if(typeof(ret)!="undefined")
        {
          if((ret=="confirm")&&(submitCfm == "Yes"))
          {
            if(rdShowConfirmDialog('确认电子免填单吗？')==1)
            {
		      conf();
            }
	      }
	      if(ret=="continueSub")
	      {
            if(rdShowConfirmDialog('确认要提交托收关系解除信息吗？')==1)
            {
		      conf();
            }
	      }
	    }
	    else
	    {
          if(rdShowConfirmDialog('确认要提交托收关系解除信息吗？')==1)
          {
		    conf();
          }
	    }
	 }
 }

function printInfo(printType)
{
     		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
		
		
		
	  cust_info+="客户姓名：		"+document.all.cust_name.value+"|";
	  cust_info+="客户地址：		"+document.all.comm_addr.value+"|";
	  opr_info+="托收关系解除。*手续费："+document.all.t_handFee.value+"|";
	  note_info1+="备注："+document.all.t_sys_remark.value+"|";
	  note_info2+="备注："+document.all.t_op_remark.value+"|";	
	  
	  

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
    return retInfo;	
}

//--------2----------提交处理函数-------------------
 function conf()
 {
	 var temFeeCode="";
	 var temDetailCode="";
	 var temFeeName="";
	 var temRateCode="";
	
	 document.all.b_print.disabled=true;
	 document.all.b_clear.disabled=true;
	 document.all.b_back.disabled=true;
	 document.all.transFeeCode.value=temFeeCode;
     document.all.transDetailCode.value=temDetailCode;
	 document.all.transFeeName.value=temRateCode;
	 frm.action="s1428Cfm.jsp";
     frm.submit();
 }

 function canc()
 {
   frm.submit();
 }

 //-------3--------实收栏专用函数----------------
 function ChkHandFee()
	 {
       if((document.all.oriHandFee.value).trim().length>=1 && (document.all.t_handFee.value).trim().length>=1)
	   {
         if(parseFloat(document.all.oriHandFee.value)<parseFloat(document.all.t_handFee.value))
	     {
          rdShowMessageDialog("实收手续费不能大于原始手续费！",0);
		  document.all.t_handFee.value=document.all.oriHandFee.value;
		  document.all.t_handFee.select();
		  document.all.t_handFee.focus();
		  return;
	     }
	   }
	  
	   if((document.all.oriHandFee.value).trim().length>=1 && (document.all.t_handFee.value).trim().length==0)
	   {
         document.all.t_handFee.value="0";
	   }
	 }
 function getFew()
 {
     if(window.event.keyCode==13)
     {
       var fee=document.all.t_handFee;
       var fact=document.all.t_factFee;
       var few=document.all.t_fewFee;

       if((fact.value).trim().length==0)
       {
 	     rdShowMessageDialog("实收金额不能为空！",0);
 	     fact.value="";
	     fact.focus();
	     return;
       }

       if(parseFloat(fact.value)<parseFloat(fee.value))
       {
  	     rdShowMessageDialog("实收金额不足！",0);
	     fact.value="";
	     fact.focus();
	     return;
       }

	   var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
	   var tem2=tem1;
	   if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
       few.value=(tem2/100).toString();
       few.focus();
	 }
 }

 //-------4--------点击操作类型单选框时--------------
 function chg_opType()
 {
   
  
	  
	 if(parseInt(document.all.ccount.value,10)>0){
	  rdShowMessageDialog("您是托收帐户,帐户有欠费不能删除帐户！",0);
	   document.all.r_acc_opType[0].checked=true;
	   return;
	 }
	 
	 opFlag="del";
	 initFace("FromStart");
 }

 //-------5-----------点击增加、删除按钮及双击列表时---------
 
 

 function f_chgAccount()
 {
    document.all.b_print.disabled=true;
	document.all.t_acc_pass.value="";
	document.all.t_acc_pass.focus();
 }

 function f_chk()
 {
   if((document.all.t_acc_pass.value).trim().length==0)
   {
     rdShowMessageDialog("帐户密码不能为空！",0);
	 document.all.t_acc_pass.focus();
	 return false;
   }
   var acc_name = (document.all.s_acc_name.options[document.all.s_acc_name.selectedIndex].value).trim();
   var acc_pass = (document.all.t_acc_pass.value).trim();
   var acc_area = (document.all.acc_area.value).trim();
   var user_id = (document.all.cust_id.value).trim();
   var myPacket = new AJAXPacket("chk_pass.jsp","正在验证帐户信息，请稍候......");
   myPacket.data.add("acc_name",acc_name);
   myPacket.data.add("acc_pass",acc_pass);
   myPacket.data.add("user_id",user_id);
   myPacket.data.add("acc_area",acc_area);
   myPacket.data.add("srv_no","<%=srv_no%>");
   myPacket.data.add("choice_type","d");
   myPacket.data.add("choice_type","nd");
   core.ajax.sendPacket(myPacket);
   myPacket = null;

 }

 function f_chk1()
 {
   

   if((document.all.t_acc_pass1.value).trim().length==0)
   {
     rdShowMessageDialog("帐户密码不能为空！",0);
	 document.all.t_acc_pass1.focus();
	 return false;
   }


   var acc_pass = (document.all.t_acc_pass1.value).trim();
   var acc_area = (document.all.acc_area.value).trim();
   var user_id = (document.all.cust_id.value).trim();
   var myPacket = new AJAXPacket("chk_pass.jsp","正在验证帐户信息，请稍候......");
   myPacket.data.add("acc_name",acc_name);
   myPacket.data.add("acc_pass",acc_pass);
   myPacket.data.add("user_id",user_id);
   myPacket.data.add("acc_area",acc_area);
   myPacket.data.add("srv_no","<%=srv_no%>");
   myPacket.data.add("choice_type","nd");
	 	 
   core.ajax.sendPacket(myPacket);
   delete(myPacket);
 }  

 function chgAcc()
 {
   document.all.b_print.disabled=true;
 }
 
 function chg_DetailFlag()
 {  
   if(document.all.r_detFlag[0].checked)
   {
 	 document.all.b_add.disabled=false;
   }   
   else if(document.all.r_detFlag[1].checked)	 
   {
     document.all.b_add.disabled=true;
     rdShowMessageDialog("明细标志选‘否’时，不能增加费用代码！",0);
   }
 }
 
 function m_feeLimit()
 {
   if((document.all.t_feeLimit.value).trim().length>0)
   {
      if(1*(document.all.t_feeLimit.value)<0.01)
	  {
	     rdShowMessageDialog('限额为"0"表示无限额！',0);
	  }
   }
 }
 </script>
</head>
<body   onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<form name="frm" method="POST"  onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">托收关系解除</div>
	</div>
  <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1212Main">
  <input type="hidden" name="cust_name" id="cust_name" value="<%=initStr_1[0][3].trim()%>">
  <input type="hidden" name="iccid" id="iccid" value="<%=initStr_1[0][14].trim()%>">
  <input type="hidden" name="comm_addr" id="comm_addr" value="<%=initStr_1[0][11].trim()%>">
  <input type="hidden" name="cust_id" id="cust_id" value="<%=initStr_1[0][0].trim()%>">
  <input type="hidden" name="srv_no" id="srv_no" value=<%=srv_no%>>
  <input type="hidden" name="transFeeCode" id="transFeeCode">
  <input type="hidden" name="transDetailCode" id="transDetailCode">
  <input type="hidden" name="transFeeName" id="transFeeName">
  <input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=initStr_1[0][20].trim()%>">
  <input type="hidden" name="acc_area" id="acc_area" value="<%=initStr_4[0][0].trim()%>">
  <input type="hidden" name="ccount" id="ccount" value="<%=initStr_5[0][0].trim()%>">
  <input type="hidden" name="loginAccept" value="<%=sysAcceptl%>"/>
 
        <table  cellspacing="0" >
          <tr > 
            <td width="16%" nowrap> 
              <div align="left" class="blue">大客户标志</div>
            </td>
            <td nowrap width="34%" colspan="2"> 
              <div align="left"><b> <font class="orange"><%=result_t10[0][0]%></font></b></div>
            </td>
            <td nowrap width="16%"> 
              <div align="left" class="blue">集团标志</div>
            </td>
            <td nowrap width="34%" colspan="2"> 
              <div align="left"><%=result_t11[0][0]%></div>
            </td>
          </tr>
          <tr > 
            <td width="16%" nowrap> 
              <div align="left" class="blue">当前预存</div>
            </td>
            <td nowrap width="34%" colspan="2"> 
              <div align="left"><%=initStr_1[0][16]%></div>
            </td>
            <td nowrap width="16%"> 
              <div align="left" class="blue">当前欠费</div>
            </td>
            <td nowrap width="34%" colspan="2"> 
              <div align="left"><%=initStr_1[0][15]%></div>
            </td>
          </tr>
          <tr > 
            <td width="16%" nowrap> 
              <div align="left" class="blue">客户名称</div>
            </td>
            <td nowrap width="34%" colspan="2"> 
              <div align="left"><%=initStr_1[0][3]%></div>
            </td>
            <td nowrap width="16%"> 
              <div align="left" class="blue">客户地址</div>
            </td>
            <td nowrap width="34%" colspan="2"> 
              <div align="left"><%=initStr_1[0][11]%></div>
            </td>
          </tr>
          <tr > 
            <td colspan="6" nowrap> 
              <hr>
            </td>
          </tr>
          <tr id="tr_r_opType" > 
            <td nowrap> 
              <div align="left" class="blue">帐号操作类型</div>
            </td>
            <td colspan="5" nowrap class="blue"> 
              <input type="radio" name="r_acc_opType" value="d" onclick="chg_opType()" checked index="2">
              托收关系解除 </td>
          </tr>
        </table>
              <table  cellspacing="0" >
                <tr > 
                  <td nowrap width="16%" class="blue"> 
                    <div align="left">付费帐户</div>
                  </td>
                  <td nowrap width="21%"> 
                    <div align="left"> 
                      <select name="s_acc_name" onchange="f_chgAccount()" index="5">
                      </select>
                    </div>
                  </td>
                  <td nowrap width="15%"> 
                    <div align="left" class="blue">帐户密码</div>
                  </td>
                  <td nowrap width="48%"> 
                    <div align="left"> 
                      <input   type="password" size="8" name="t_acc_pass" id="t_acc_pass" maxlength="6" v_type=0_9 index="6" onkeyup="if(event.keyCode==13)f_chk()">
                       <font class="orange">*</font> 
                      <input  type="button" name="b_chk2" value="验证" onClick="f_chk()" class="b_text">
                    </div>
                  </td>
                </tr>
              </table>
           <table  cellspacing="0" >
          <tr  id="tr_def"> 
            <td class=Lable nowrap width="16%"> 
              <div align="left" class="blue">默认付费帐户</div>
            </td>
            <td class=Lable nowrap colspan="5"> 
              <div align="left"><%=initStr_1[0][19]%></div>
            </td>
          </tr>
          <tr > 
            <td class=Lable nowrap colspan="6"> 
              <hr>
            </td>
          </tr>
          <tr > 
            <td nowrap width="16%"> 
              <div align="left" class="blue">手续费</div>
            </td>
            <td nowrap width="24%"> 
              <div align="left"> 
                <input type="text"  name="t_handFee" id="t_handFee" size="16"
	value="<%=(initStr_1[0][20].trim().equals(""))?("0"):(initStr_1[0][20].trim()) %>" v_type=float v_name="手续费" <%if(hfrf){%>readonly  Class="InputGrey"<%}%> onblur="ChkHandFee()" index="17">
              </div>
            </td>
            <td nowrap width="10%"> 
              <div align="left" class="blue">实收</div>
            </td>
            <td nowrap width="16%"> 
              <div align="left"> 
                <input type="text"  name="t_factFee" id="t_factFee" size="16" index="18" onKeyUp="getFew()" v_type=float v_name="实收"  <%
	                             if(hfrf)
	                             {									
							   %>
								   readonly  Class="InputGrey"
							  <%								
								 }
							   %>
							   >
              </div>
            </td>
            <td nowrap width="10%"> 
              <div align="left" class="blue">找零</div>
            </td>
            <td nowrap width="24%"> 
              <div align="left"> 
                <input type="text"  name="t_fewFee" id="t_fewFee" size="16" readonly Class="InputGrey">
              </div>
            </td>
          </tr>
          <tr > 
            <td nowrap width="16%"> 
              <div align="left" class="blue">系统备注</div>
            </td>
            <td nowrap colspan="5"> 
              <div align="left"> 
                <input type="text"  name="t_sys_remark" id="t_sys_remark" size="60" readonly  Class="InputGrey" maxlength=30>
                <input type="hidden"  name="t_op_remark" id="t_op_remark" size="60"  v_maxlength=60  v_type=string  v_name="用户备注" maxlength=60>
                <input type="hidden" name=assuNote  v_must=0 v_maxlength=60 v_type="string" v_name="用户备注" maxlength="60" size=60  index="19" value="">
              </div>
            </td>
          </tr>
  
          <tr > 
            <td colspan="7" id="footer"> 
              <div align="center"> 
                <input class="b_foot_long" type="button" name="b_print" value="确认&打印" onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" index="20">
                <input class="b_foot" type="button" name="b_clear" value="清除" onClick="frm.reset();" index="21">
                <input class="b_foot" type="button" name="b_back" value="返回" onClick="location='s1428.jsp?activePhone=<%=srv_no%>'" index="22">
              </div>
            </td>
          </tr>
        </table>
 
  <%@ include file="/npage/include/footer.jsp" %>
   </form>
</body>
</html>
<script>

  //-------1----------公用函数----------------------
 function initFace(startFlag)
 {

      //使打印按钮变为不可用
	  document.all.b_print.disabled=true;

      //填充付费帐户下拉框
	  document.all.s_acc_name.options.length=0;

      //document.all.s_acc_name.options.length=js_init2[0].length;
	    //从所有帐户中去掉bill_order='99999999'的帐户，因此，下拉框长度应减1		
        document.all.s_acc_name.options.length=js_init2[0].length;
		  
		  var seLoc=0;
		  for(var i=0;i<js_init2[0].length;i++)
		  {
			if(js_init2[2][i]!="99999999")
			{			
			  document.all.s_acc_name.options[seLoc].text=js_init2[0][i];
			  document.all.s_acc_name.options[seLoc].value=js_init2[0][i];
			  seLoc++;
			}
 		  }
	
 }
</script>

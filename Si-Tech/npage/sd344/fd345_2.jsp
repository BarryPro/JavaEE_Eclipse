<%
  /*
   * 功能: 电信管控恢复 d345
   * 版本: 1.0
   * 日期: 2011/3/25
   * 作者: huangrong 
   * 版权: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
	String opCode = request.getParameter("opCode");
	System.out.println(opCode);
	String opName = request.getParameter("opName");
	String phoneNo  = request.getParameter("phoneNo");
  	
	String[][] favInfo = (String[][])session.getAttribute("favInfo");//读取优惠资费代码
	String hdword_no = (String)session.getAttribute("workNo");//工号
	String hdorg_code = (String)session.getAttribute("orgCode");//org_code 操作权限归属
	String regCode = (String)session.getAttribute("regCode");

  String strNewRunCode = request.getParameter("new_run_code");            //操作类型 	
	
%>
<HEAD>
<TITLE>电信管控恢复</TITLE>

<SCRIPT>
<!--
function turnit()
{
	document.all.better.style.display="";
}

function checkexpDays()
{
	if(document.form1.expDays.value <= 0){
  	rdShowMessageDialog("请正确输入天数,天数不能为负或0天！");
    document.form1.expDays.value = "";
    document.form1.expDays.focus();
    return false;
  }
  
	if(document.form1.expDays.value > 10){
  	rdShowMessageDialog("请正确输入天数,天数不能超过10天！");
    document.form1.expDays.value = "";
    document.form1.expDays.focus();
    return false;
  }
}
//-->
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gbk"></HEAD>
<body>
<FORM action="" method=post name="form1"> 
<%@ include file="/npage/include/header.jsp" %>   
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
<%
/***********************************定义返回参数*********************************************/
	String oret_code="";              // 错误代码               
	String oret_msg="";		          // 错误信息
	String oid_no="";		  		  //0  用户id                
	String custName="";		      //1  客户名称             
	String statusCode="";		      //2  状态代码          
	String statusName="";		      //3  状态名称  
	String custAddr="";		      //4  客户住址          
	String idType="";		          //5  证件类型          
	String oid_name="";		          //6  证件名称          
	String idIccid="";		      //7  证件号码         
	String onew_run="";		          //8  新状态代码        
	String onew_runname="";           //9  新状态名称 
	String smName="";           //10  产品名称
	String preMsg="";	           //11  是否有预约特服的提示信息
	String noteMsg=""	;           //12  操作备注信息
/**************************调用s1246Init入参数****************************/ 
  String loginAccept = "";                                //操作流水
  String chnSource = "01";                                //渠道标识
	String workNo = hdword_no;                                 //操作工号
	String passWord = (String)session.getAttribute("password");//工号密码	
	String custWord = "";                                          //用户密码 
	String ChOpRunCode  =  request.getParameter("opFlag");          //操作运行状态
	try
	{
%>
		<wtc:service name="sd344Init" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="13">			
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=chnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=passWord%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=custWord%>"/>
		<wtc:param value="<%=ChOpRunCode%>"/>	
		</wtc:service>	
		<wtc:array id="result"  scope="end"/>
<%
		oret_code = retCode1;
		oret_msg = retMsg1;     
		System.out.println("2222:" + oret_code + ":" + oret_msg);
			
		oid_no  = result[0][0];                   //0 用户id    
		custName = result[0][1];					//1 客户名称              
		statusCode = result[0][2];					//2 状态代码           
		statusName = result[0][3];			       //3 状态名称                     
		custAddr = result[0][4];			       //4客户住址           
		idType = result[0][5];			        //5 证件类型           
		oid_name = result[0][6];			        //6 证件名称           
		idIccid = result[0][7];			         //7 证件号码                 
		onew_run = result[0][8];                   //8 新状态代码          
		onew_runname  = result[0][9];                   //9新状态名称
		smName  = result[0][10];                   //10 产品名称
	  preMsg=result[0][11];	           //11  是否有预约特服的提示信息
		noteMsg=result[0][12];           //12  操作备注信息
   }
		catch(Exception e){
       		System.out.println("Call services is Failed!");
     	}	
 if(!oret_code.equals("000000"))
	 {
		
%>
			  <script language='jscript'>
			   rdShowMessageDialog("<%=String.valueOf(oret_code)%>:"+"<%=oret_msg%>！",0);
			   history.go(-1);
			  </script>
<%}else{%>
			  <script language='jscript'>
			  </script>
<%}%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>"  id="seq"/>
	<TABLE cellSpacing="0">
  	<TR> 
			<TD class="blue">服务号码</TD>
			<TD>
				<input class="InputGrey" name="phoneNo" value="<%=request.getParameter("phoneNo")%>" v_type="mobphone" v_must=1 onBlur="if(this.value!=''){if(checkElement('phoneNo')==false){return false;}}"  readonly >
			</TD>
			<TD class="blue">客户名称</TD>
			<TD>
				<input class="InputGrey" name="custName" value="<%=custName%>" readonly >
			</TD>
   	</TR>
		<TR> 
			<TD class="blue">产品名称</TD>
			<TD>
				<input class="InputGrey" name="smName" value="<%=smName%>" readonly >
			</TD>
			<TD class="blue">客户地址</TD>
			<TD>
				<input class="InputGrey" size="60" name="custAddr" value="<%=custAddr%>" readonly>
			</TD>
   </TR>
	 <TR> 
	  	<TD class="blue">证件类型</TD>
	  	<TD ><input class="InputGrey" name="idType" value="<%=oid_name%>" readonly>
	  	</TD>
	  	<TD class="blue">证件号码</TD>
	  	<TD>
	  		<input class="InputGrey" name="idIccid" value="<%=idIccid%>"   readonly >
	  	</TD>
   </TR>
	 <TR> 
	 	  <TD class="blue">当前状态代码</TD>
		  <TD>
			  <input class="InputGrey" name="statusCode" value="<%=statusCode%>" readonly>
			</TD>
			<TD class="blue">当前状态名称</TD>
			<TD>
				<input class="InputGrey" name="statusName" value="<%=statusName%>" readonly>
			</TD>
   </TR>
	<TR> 
			<TD class="blue">恢复状态代码</TD>
			<TD>
				<input class="InputGrey" name="renewStatusCode" value="<%=onew_run%>" readonly>
			</TD>
			<TD class="blue">恢复状态名称</TD>
			<TD>
				<input class="InputGrey" name="renewStatusName" value="<%=onew_runname%>" readonly>
			</TD>
   </TR>
			 <%
				  String strsql = "";
				  String favor_code = "";
				  String hand_fee = "";
			  try{
				  strsql = "select HAND_FEE, FAVOUR_CODE from sNewFunctionFee where region_code='05' and function_code='1246'";
			%>
					<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
					<wtc:sql><%=strsql%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="result_favor" scope="end" />
			<%
				  hand_fee = result_favor[0][0];
				  favor_code = result_favor[0][1];
			  }catch(Exception e)
			  {
				  e.printStackTrace() ;
			  }
			   
			 %>
			 <%
			int m =0;
			   for(int p = 0;p< favInfo.length;p++){//优惠资费代码
						for(int q = 0;q< favInfo[p].length;q++)
						{
						 if(favInfo[p][q].trim().equals(favor_code.trim()))
							 {
							   ++m;
						   }
						}
         }
			%>
      <TR>
			   <%if(m != 0){%>		 
				 <TD class="blue">手续费</TD>
				 <TD>
						 <input name="ohand_cash" value="<%=hand_fee%>" v_must=1  v_type=float >
						 <input class="InputGrey" type="hidden" name="ishould_fee" value="<%=hand_fee%>" readonly>
				 </TD>
				 <script language="jscript">
				 document.all.ohand_cash.focus();
				 </script>
		     <%}else{%>
				 <TD class="blue">手续费</TD>
				 <TD>
					 <input class="InputGrey" name="ohand_cash" value="<%=hand_fee%>" readonly>
					 <input class="InputGrey" type="hidden" name="ishould_fee" value="<%=hand_fee%>" readonly>
				 </TD>
		      <%}%>
				  <TD class="blue">开关机命令函数</TD>
				  <TD>
				 		<input name="icmd_code" class="InputGrey" value="<%=onew_runname%>" readonly>
          	<div id=better style="display:none">
				  		<input name="expDays" v_name="天数" v_type="0_9" onChange="checkexpDays()" value="1"  onblur="if(this.value!=''){if(checkElement('expDays')==false){return false;}}">天
				  	</div>
				  </td>
        </TR>
	  
        <TR>
			   <TD class="blue">系统备注</TD>
			   <TD colspan="3">
			   	<input class="InputGrey" name="opNote" readonly size="80" value="<%=noteMsg%>">
			   </TD>
		   </TR>
	   </TABLE>
       <TABLE cellSpacing="0">
          <TBODY>
            <TR> 
              <TD align=center id="footer">
							  <input class="b_foot" name=sure  type=button value="确认&打印" onclick="if(checknum(ohand_cash,ishould_fee)) if(check(form1)) showPrtDlg(); ">
							  <input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
							  <input class="b_foot" name=back  onClick="history.go(-1)" type=button value=返回>
              </TD>
            </TR>
          </TBODY>
       </TABLE>
     <%@ include file="/npage/include/footer.jsp" %>  
	   <%@ include file="/npage/s1246/tail.jsp"%>
	   <!-----------------------------------设置隐藏域----------------------------------------------->
	   <input type="hidden" name="stream" value="<%=seq%>">
	   <input type="hidden" name="oid_no" value="<%=oid_no%>">
	   <input type="hidden" name="onew_run" value="<%=onew_run%>">
	   <input type="hidden" name="opName" value="<%=opName%>">
	   <input type="hidden" name="opCode" value="<%=opCode%>">
	   <input type="hidden" name="donote">
	   <!-------------------------------------------------------------------------------------------->
	   </FORM>
	    <%@ include file="/npage/include/footer.jsp" %>  
     </BODY>
   </HTML>
  
  <script language="javascript">
  onload=function()
  {
  	<%if(onew_runname.trim().equals("强开")){%>
	       turnit();
	  <%}%>
  }
/*-----------------------------页面跳转函数-----------------------------------------------*/
  function pageSubmit(page){
    document.form1.action="<%=request.getContextPath()%>/page/"+page;
	  form1.submit();
}
/*--------------------------手续费校验函数--------------------------*/	  

function checknum(obj1,obj2)
{
  var num2 = parseFloat(obj2.value);
  var num1 = parseFloat(obj1.value);

  if(num2<num1)
  {
    var themsg = "'" + obj1.v_name + "'不得大于'" + obj2.value + "'请重新输入！";
    rdShowMessageDialog(themsg,0);
    obj1.focus();
    return false;
  }

	if(document.all.icmd_code.value== "强开")
	{	
		var tmpDays = parseInt(document.all.expDays.value,10);
		if( tmpDays <= 0 || tmpDays > 365 || jtrim(document.all.expDays.value).length==0)
		{
			rdShowMessageDialog("强开时请输入正确的强开时间,强开时间在0-365之间!",0);
			return false;
		}
	}
    return true;
} 

/*----------------调用打印页面函数---------------------*/
function showPrtDlg()
{  
	getAfterPrompt();
	var imo_phone = '<%=phoneNo%>' ;
	var onew_runname=document.all.icmd_code.value;
    thesysnote = imo_phone + onew_runname                        //生成系统备注
    document.all.donote.value= thesysnote;                      //产生页面显示的系统备注
   /*弹出模式对话筐，并对用户操作进行处理*/
   var h=105;
   var w=260;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2; 
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
   var ret=rdShowConfirmDialog("是否打印电子免填单？");
    if(typeof(ret)!="undefined")
    {
        if(ret==1)                      //点击认可
        {
            conf("Detail","确实要进行电子免填单打印吗？","Yes");                          
        }
        else if(ret==0)                 //点击取消,问是否提交
        {    
            crmsubmit();                     
        }
    }
}
/*-------------------------打印流程提交处理函数-------------------*/
function conf(printType,DlgMessage,submitCfm)
{ 
	/***********************打印所需的参数**********************************/
	var phone = '<%=phoneNo%>';								//用户手机号码
	var date = '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>';                                                              //系统日期
	var name = '<%=custName%>';         						    //用户姓名
	var address = '<%=custAddr%>';							        //用户地址
	var cardno = '<%=idIccid%>'; 								    //证件号码
	var stream = document.all.stream.value;							//打印流水
	var work_no = '<%=hdword_no%>';                                 //得到工号
	var opNote = document.all.opNote.value;                        //到打印的系统日志
	/**********************打印所需的参数组织完毕****************************/

	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";  
	var printStr = printInfo(printType);
   
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	
	var sysAccept = document.all.stream.value;
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=2355&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
	    crmsubmit();
	  }
		if(ret=="continueSub")
		{
		    crmsubmit();   
		}
  }
  else
  {
	   crmsubmit();
  }   
 }
 
function printInfo(printType)
{ 
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	var phone = '<%=phoneNo%>';
	var name = '<%=custName%>';         						    //用户姓名
	var address = '<%=custAddr%>';							        //用户地址
	var cardno = '<%=idIccid%>'; 								    //证件号码  
	var retInfo = "";
	 
	cust_info+="手机号码：   "+phone+"|";
	cust_info+="客户姓名：   "+name+"|";
	cust_info+="客户地址：   "+address+"|";
	cust_info+="证件号码：   "+cardno+"|";
	
	opr_info+="业务类型：电信管控恢复"+"|";
	opr_info+="业务流水："+document.all.stream.value+"|";
	note_info1 +="备注："+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;	
}

function crmsubmit()
{
	if(rdShowConfirmDialog("是否提交此次操作？")==1){
  	form1.action="fd345Cfm.jsp";
    form1.submit();
	}else{
		return false;
	}
}

 </script>


<% 
  /*
   * 功能: 个人彩铃取消
　 * 版本: v1.00
　 * 日期: 2007/09/13
　 * 作者: liubo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   *  
   *
   *update:liutong@20080917
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../include/remark1.htm" %>

<%
	String opCode = "6711";
	String opName = "个人彩铃取消";
	String workno =(String)session.getAttribute("workNo");
	String workname =(String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String nopass = (String)session.getAttribute("password");
	
    int    nextFlag=1;   
    String OpCode ="6711";
    String sInOpNote  ="号码信息初始化"; 
    
     String phone="";
	    phone = request.getParameter("activePhone");
	    if(null==phone||phone.equals("")){
	      phone = request.getParameter("phone_no");
	    }
	    System.out.println(phone+"________________________________________________________________________");
    
    //String[][] temfavStr=(String[][])arr.get(3);
    //String[][]  temfavStr = (String[][])session.getAttribute("favInfo");
    //String[] favStr=new String[temfavStr.length];
    //for(int i=0;i<favStr.length;i++)
    //favStr[i]=temfavStr[i][0].trim();
    
	  String sqlStr1="";
	  String[][] retListString1 = null;
	  
	  //获取从上页得到的信息
	  String loginAccept = request.getParameter("login_accept");
	
		//SPubCallSvrImpl impl = new SPubCallSvrImpl();
		//ArrayList retList1 = new ArrayList();  
		if(loginAccept == null)
		{			
			//获取系统流水
			//sqlStr1 ="SELECT sMaxSysAccept.nextval FROM dual";
			//retList1 = impl.sPubSelect("1",sqlStr1,"region",regionCode);
			//retListString1 = (String[][])retList1.get(0);
			//loginAccept=retListString1[0][0];			
		
		%>
		 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="outRet"/>			
		<%
		  loginAccept = outRet; 
		}
	
	  String dateStr=new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
	  
	  String phone_no           ="";
	  String password           ="";
	  	  
	  String sOutCustId         ="";             //客户ID_NO          
	  String sOutCustName       ="";             //客户姓名           
	  String sOutSmCode         ="";             //服务品牌代码       
	  String sOutSmName         ="";             //服务品牌名称       
	  String sOutProductCode    ="";             //主产品代码         
	  String sOutProductName    ="";             //主产品名称         
	  String sOutPrePay         ="";             //可用预存           
	  String sOutRunCode        ="";             //运行状态代码       
	  String sOutRunName        ="";             //运行状态名称       
	  String sOutUsingCRProdCode="";             //已订购彩铃产品     
	  String sOutUsingCRProdName="";             //已订购彩铃产品名称 
	  String sOutCRColorType    ="";             //彩铃类型           
	  String sOutCRColorTypeName="";             //彩铃类型名称       
	  String sOutCRRunCode      ="";             //彩铃运行状态代码   
	  String sOutCRRunName      ="";             //彩铃运行状态名称   
	  String sOutCRBellBeginTime="";             //彩铃开通时间       
	  String sOutCRBellEndTime  ="";             //彩铃结束时间  
	  String minusDay ="";                      //距离彩铃结束时间差距时间
	  String opFlag="one";    
	   	  
	  String action=request.getParameter("action");     

	  if (action!=null&&action.equals("select")){
	    phone_no = request.getParameter("phone_no");     
	    password = request.getParameter("password");
	    opFlag   = request.getParameter("opFlag");
	    String Pwd1 = Encrypt.encrypt(password);      	//在此对用户传来的密码进行加密
	    	    
     
	 	    
	  //  SPubCallSvrImpl callView = new SPubCallSvrImpl();
		 	String paramsIn[] = new String[6];
		 	
		   paramsIn[0]=workno;                                 //操作工号         
	     paramsIn[1]=nopass;                                 //操作工号密码     
	     paramsIn[2]=OpCode;                                 //操作代码         
	     paramsIn[3]=sInOpNote;                              //操作描述         
	     paramsIn[4]=phone_no;                               //用户手机号码     
	     paramsIn[5]=Pwd1;                                   //用户密码         
		 	
		//	ArrayList acceptList = new ArrayList();
				   
		//	acceptList = callView.callFXService("s6714Init", paramsIn, "17");
		//	callView.printRetValue();
		
		%>
			<wtc:service name="s6714Init" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="19" >
			<wtc:param value="<%= paramsIn[0]%>"/>
			<wtc:param value="<%= paramsIn[1]%>"/>
			<wtc:param value="<%= paramsIn[2]%>"/>
			<wtc:param value="<%= paramsIn[3]%>"/>
			<wtc:param value="<%= paramsIn[4]%>"/>
			<wtc:param value="<%= paramsIn[5]%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
		<%
			   	
		  if(errCode.equals("0")||errCode.equals("000000")){
         		 System.out.println("调用服务s6714Init in f6711_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");

	 	        	if(result.length==0){
	 	            }else{
					 	         
	 	            	nextFlag = 2;		
	 	        	    sOutCustId          =result[0][0];           
						sOutCustName        =result[0][1];              
						sOutSmCode          =result[0][2];              
						sOutSmName          =result[0][3];              
						sOutProductCode     =result[0][4];              
						sOutProductName     =result[0][5];              
						sOutPrePay          =result[0][6].trim();           
						sOutRunCode         =result[0][7];              
						sOutRunName         =result[0][8];              
						sOutUsingCRProdCode =result[0][9];              
						sOutUsingCRProdName =result[0][10];             
						sOutCRColorType     =result[0][11];             
						sOutCRColorTypeName =result[0][12];             
						sOutCRRunCode       =result[0][13];             
						sOutCRRunName       =result[0][14];             
						sOutCRBellBeginTime =result[0][15];             
						sOutCRBellEndTime   =result[0][16]; 	        
						
						
						   String ColorType = request.getParameter("ColorType"); 
	  
							  if(!sOutCRColorType.equals("00")&&sOutCRColorType.equals("01")&&sOutCRColorType.equals("10")&&sOutCRColorType.equals("11")&&sOutCRColorType.equals("13"))
							   {
								  	{
											%>        
										    <script language='jscript'>
										       rdShowMessageDialog("选择的销户类型与目前的产品类型不符，请重新选择" ,0);
										       history.go(-1);
									      </script> 	         
											<%  
										}				  
							   }	 
								 if(sOutCRColorType.equals("00")||sOutCRColorType.equals("01"))
								 {
								    if(!ColorType.equals(sOutCRColorType))
										{
											%>        
										    <script language='jscript'>
										       rdShowMessageDialog("选择的销户类型与目前的产品类型不符，请选择<%=sOutCRColorTypeName%>类型。" ,0);
										       history.go(-1);
									      </script> 	         
											<%  
										}				
								 } 
								 if(sOutCRColorType.equals("01") || sOutCRColorType.equals("02") || sOutCRColorType.equals("03") || sOutCRColorType.equals("04"))
								 {
								    if(!ColorType.equals("01"))
										{
											%>        
										    <script language='jscript'>
										       rdShowMessageDialog("选择的销户类型与目前的产品类型不符，请选择<%=sOutCRColorTypeName%>类型。" ,0);
										       history.go(-1);
									      </script> 	         
											<%  
										}				
								 } 
								 if(sOutCRColorType.equals("10")||sOutCRColorType.equals("11"))
								 {
								    if(!ColorType.equals(""))
										{
											%>        
										    <script language='jscript'>
										       rdShowMessageDialog("选择的销户类型与目前的产品类型不符，请选择<%=sOutCRColorTypeName%>类型。" ,0);
										       history.go(-1);
									      </script> 	         
											<%  
										}				
								 } 
								 
								 
						   System.out.println("checked2---------------------");     
							 /*开发针对有效期未到退订业务的包年卡、包年客户的退订二次提醒*/
							 //两个时间之间的天数
						   java.text.SimpleDateFormat myFormatter = new java.text.SimpleDateFormat("yyyyMMdd");
						   java.util.Date date1= myFormatter.parse(dateStr); 
						   java.util.Date mydate= myFormatter.parse(sOutCRBellEndTime);
						   long  day1=(mydate.getTime()-date1.getTime())/(24*60*60*1000);
						   Long day2=new Long(day1);
						   minusDay=day2.toString();
						   System.out.println("minusDay===="+minusDay); 
						   if(day1<0){
						    %>        
							    <script language='jscript'>
							       rdShowMessageDialog("你的彩铃<%=sOutCRColorTypeName%>业务已经过期，请重新开通！" ,0);
							       history.go(-1);
						      </script> 	         
								<%    
						   }  
							
	 	        	   
	 	        	}
 	        	
 	     	}else{
 	         	System.out.println(errCode+"    errCode");
 	     		System.out.println(errMsg+"    errMsg");
 	     		System.out.println("调用服务s6714Init in f6711_1.jsp  失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	     		
 	     			%>        
					    <script language='jscript'>
					       rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
					       history.go(-1);
				       </script> 
			         
					<%  
 		
 			}
		
	}
%>      
        
<HTML><HEAD><TITLE>黑龙江BOSS-个人彩铃取消</TITLE>

<script language="JavaScript">
onload = function() {
	opchange();
}

  //确认提交
function refain()
{
  
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	 {
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	    document.all.opCode.value="6711";	    	
	  }else if(opFlag=="two")
	  {
	    document.all.opCode.value="6715";	    	
	  }else if(opFlag=="three"){
	  	document.all.opCode.value="6719";	    	
	  }
   } 
  }
  var op_code=document.all.opCode.value;
  getAfterPrompt(op_code);
if(document.all.CRColorType.value!="00"){
   	if(rdShowConfirmDialog("您将退订的彩铃"+document.all.CRColorTypeName.value+"业务还有"+document.all.day.value+"天未到期，退订后费用不退不转，如果继续使用彩铃业务，将按新开通业务处理。请确认是否退订！")==1){
   	    showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
				if (rdShowConfirmDialog("是否提交确认操作？")==1){
			  document.form.action="f6711_2.jsp";
				document.form.submit();
				return true; 
    	  }
    	}
 		}else{  
		    showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
				if (rdShowConfirmDialog("是否提交确认操作？")==1){
				     document.form.action="f6711_2.jsp";
					  document.form.submit();
					  return true;  
				   }    
    }
}

//输入手机号和密码，查询具体信息
function doQuery()
	{		
		
	var MobPhone=document.form.phone_no.value;
    if((MobPhone.substring(0,1) !=1) || (MobPhone.substring(1,2) !=3 && MobPhone.substring(1,2) !=5&& MobPhone.substring(1,2) !=8&& MobPhone.substring(1,2) !=4))
    {
    rdShowMessageDialog("手机号码只能以13、14或15开头，请重新输入手机号码！" );
    document.form.phone_no.focus();
    return false;
    }
    if((myParseInt(MobPhone.substring(0,3),10)<134) || (myParseInt(MobPhone.substring(0,3),10)>139 && myParseInt(MobPhone.substring(0,2),10) !=15&& myParseInt(MobPhone.substring(0,2),10) !=18&& myParseInt(MobPhone.substring(0,2),10) !=14))
    { 
    rdShowMessageDialog("手机号码范围应该在134~139之间或者是15X、14X号段");
    document.form.phone_no.focus();
    return false;	
    }	
	if(document.form.phone_no.value.length<11)
	{
		rdShowMessageDialog("手机号码应为11位！",0);
		return false;
	}

	 document.form.action = "f6711_1.jsp?action=select";
	 document.form.submit(); 
	
	}
//begin  add  by liutong
function myParseInt(nu)
{
  var ret=0;
  if(nu.length>0)
  {
    if(nu.substring(0,1)=="0")
	{
       ret=parseInt(nu.substring(1,nu.length));
	}
	else
	{
       ret=parseInt(nu);
	}
  }
  return ret;
}
//end add by  liutong
function opchange()
{
	 var op_code="";
	 if(document.all.opFlag[0].checked==true) 
	{	  	
	  	document.all.ColorType.value ="00";
	  	op_code="6711";
	  }else if(document.all.opFlag[1].checked==true) {
	    document.all.ColorType.value ="01";
	    op_code="6715";
	  }else{
	  	document.all.ColorType.value ="";
	  	op_code="6719";
	  }
	  beforePrompt(op_code);
}

function showPrtDlg(printType,DlgMessage,submitCfm) {  //显示打印对话框
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   	var pType="subprint";   
	var billType="1";  
	var sysAccept = '<%=loginAccept%>';
   var printStr = printInfo(printType);
   if(printStr == "failed")
   {    return false;   }
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var opCode="<%=opCode%>";
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
 	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo=<%=phone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,"",prop);
}
			
			function printInfo(printType) { 
					var retInfo = "";
					  var cust_info="";
					  var opr_info="";
					  var note_info1="";
					  var note_info2="";
					  var note_info3="";
					  var note_info4="";					
							retInfo+='<%=workname%>'+"|";
							retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
							cust_info+="手机号码："+document.all.phone_no.value+"|";
							cust_info+="客户姓名："+document.all.cust_name.value+"|";
							cust_info+="客户ID："+document.all.cust_id.value+"|";
							
							opr_info+="业务品牌:"+document.all.sm_name.value+"|";
							opr_info+="办理业务:"+"彩铃销户"+"|";
							opr_info+="操作流水:"+'<%=loginAccept%>'+"|";
							opr_info+="操作时间:"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
							opr_info+="业务生效时间:"+"当日"+"|";
							note_info1+="备注："+"|";
							if(document.all.CRColorType.value!="00"){
							note_info1+="您已退订彩铃"+document.all.CRColorTypeName.value+"业务，退订后包年费用不退不转"+"|";	
							note_info1+="如果继续使用彩铃"+document.all.CRColorTypeName.value+"业务，将按新开通业务处理。"+"|";	
							}

							note_info1+=""+document.all.simBell.value+"|";
							//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
							retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
							retInfo=retInfo.replace(new RegExp("#","gm"),"%23");							
							return retInfo;
			}	
function beforePrompt(op_code){
	var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","请稍后...");
	packet.data.add("opCode" ,op_code);
	core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//异步
	packet =null;
}
function doGetBeforePrompt(data)
{
	$('#wait').hide();
	$('#beforePrompt').html(data);
}
function getAfterPrompt(op_code)
{
	var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","请稍后...");
	packet.data.add("opCode" ,op_code);
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
</HEAD>
<BODY>
<FORM action="" method=post name=form>
  
        <%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">个人彩铃取消</div>
		</div>
    
    <table cellspacing="0">
    <tr> 
       <TR> 
	          <TD width="13%"  class="blue">操作类型</TD>
              <TD width="47%" colspan="3">
			         <input type="radio" name="opFlag" value="one" onclick="opchange()" <%if(opFlag.equals("one"))out.println("checked");  if(action!=null&&action.equals("select"))out.println("disabled");%> >包月取消(含动感地带0元)&nbsp;&nbsp;
			         <input type="radio" name="opFlag" value="two" onclick="opchange()" <%if(opFlag.equals("two"))out.println("checked");  if(action!=null&&action.equals("select"))out.println("disabled"); %> >包两年/包年/包半年/包季取消 &nbsp;&nbsp;
			         <input type="radio" name="opFlag" value="three" onclick="opchange()" <%if(opFlag.equals("three"))out.println("checked"); if(action!=null&&action.equals("select"))out.println("disabled");%> >彩铃卡取消
	          </TD>
		      <input type="hidden" name="opcode" >
         </TR>
        </tr>  
    <input type="hidden" name="opCode" > 
    <input type="hidden" name="loginAccept" value="<%=loginAccept%>">
    <input type="hidden" name="loginNo" value="<%=workno%>">
    <input type="hidden" name="loginPwd" value="<%=nopass%>">
    <input type="hidden" name="orgCode" value="<%=org_code%>">
    <input type="hidden" name="ip_Addr" value="<%=ip_Addr%>"> 
    <input type="hidden" name="ColorType" value="00">   		      
       
		     <TR>   
		  	     <td  class="blue" >手机号码</td>                                 
              <td colspan="3" >                     
               <input type="text"  v_type="string"  v_must=1 v_minlength=1 v_maxlength=11  value="<%=phone%>" name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()" <%if(true){out.print("readonly  Class=\"InputGrey\" ");}%>>
               <font class="orange">*</font>
               </td>
            </TR>
<%
	if(nextFlag==1)
	{
%>
            <tr>
				<td nowrap colspan="4">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4" id="footer">
					<div align="center">
					<input class="b_foot" name=sure22 type=button value="确定" onClick="doQuery();" style="cursor:hand">
            		<input class="b_foot" name=reset22 type=reset value="清除">
            		<input class="b_foot" name=close22 type=button value="关闭" onclick="removeCurrentTab()">
					</div>
				</td>
			</tr>
<%
	}
%>
            <%
             if(nextFlag==2)//查询后结果
             {
            %> 
                <tr style="display:none"> 
                  <td  class="blue"> 手机号码</td>
                  <td>
                    <input class="button" type="text" name="phoneNo" maxlength="11" class="button"  value="<%=phone%>">
                    <font class="orange">*</font>
                  </td>
                  <td  class="blue">客户ID</td>
                  <td> 
                    <input type="text" name="cust_id" maxlength="6"  class="button" value="<%=sOutCustId%>">
                    <font class="orange">*</font>
                  </td>
                </tr>
                <tr> 
                  <td width="13%"  class="blue">客户名称</td>
                  <td width="35%"> 
                    <input type="text" name="cust_name"  value="<%=sOutCustName%>"   readonly  Class="InputGrey" >
                    <font class="orange">*</font>
                  </td>
                  <td width="13%"  class="blue">业务品牌 </td>
                  <td width="35%"> 
                    <input type="text"   readonly  Class="InputGrey"  name="sm_name" value="<%=sOutSmName%>">
                    <font class="orange">*</font>
                    <input type="hidden" readonly  Class="InputGrey" name="sm_code"  value="<%=sOutSmCode%>">
                  </td>
                </tr>
                <tr> 
                  <td width="13%"  class="blue">资费套餐</td>
                  <td width="35%"> 
                   
                    <input type="text"   readonly  Class="InputGrey"  name="ProductName" maxlength="5"   value="<%=sOutProductName%>">
                    <font class="orange">*</font>
                     <input type="hidden" readonly  Class="InputGrey"  name="ProductCode" maxlength="5"  value="<%=sOutProductCode%>">
                  </td>
                  <td width="13%"  class="blue">运行状态</td>
                  <td width="39%"> 
               
                    <input type="text"   readonly name="RunName"  Class="InputGrey"  value="<%=sOutRunName%>">
                    <font class="orange">*</font>
                   <input type="hidden" readonly name="RunCode"  Class="InputGrey"  value="<%=sOutRunCode%>">
                  </td>
                </tr>
               <tr> 
                  <td width="13%"  class="blue">业务类型</td>
                  <td width="35%"> 
               
                    <input type="text"   readonly name="CRColorTypeName" maxlength="5"      Class="InputGrey"  value="<%=sOutCRColorTypeName%>">
                    <font class="orange">*</font>
                    <input type="hidden" readonly name="CRColorType" maxlength="5"  Class="InputGrey"  value="<%=sOutCRColorType%>">
                  </td>
                  <td width="13%"  class="blue">开户时间</td>
                  <td width="39%"> 
                    <input type="text" readonly  name="CRBellBeginTime"  Class="InputGrey"  maxlength="20" value="<%=sOutCRBellBeginTime%>">
                    <font class="orange">*</font>
                    <input type="hidden" name="day" value="<%=minusDay%>" > 
                  </td>
               </tr>
              <tr> 
                  <td width="13%"  class="blue">已订购彩铃产品</td>
                  <td width="35%"> 
                    <input type="text"   readonly name="UsingCRProdName" maxlength="5"     Class="InputGrey"  value="<%=sOutUsingCRProdName%>">
                    <font class="orange">*</font>
                     <input type="hidden" readonly name="UsingCRProdCode" maxlength="5"  Class="InputGrey"  value="<%=sOutUsingCRProdCode%>">
                  </td>
                  <td width="13%"  class="blue">彩铃运行状态</td>
                  <td width="39%"> 
                    <input type="text" readonly  name="CRRunName"  Class="InputGrey"  maxlength="20" value="<%=sOutCRRunName%>">
                    <font class="orange">*</font>
               </td>
              </tr> 
            </table>                
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td width=13%  class="blue">备注</td>
                  <td width="87%">
                    <input  Class="InputGrey"  readonly name=sysNote value="员工<%=workno%>对手机号码<%=phone_no%>取消个人彩铃业务"  size=60 maxlength="60">
                  </td>
                </tr>
                <tr style="display:none"> 
                  <td width="13%"  class="blue">用户备注</td>
                  <td width="87%"> 
                    <input class="button" name=opNote size=60 value="员工<%=workno%>对手机号码<%=phone_no%>取消个人<%=sOutUsingCRProdName%>业务" maxlength="60">
                  </td>
                </tr>
                </tbody> 
              </table>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td align=center  id="footer"> 
                    <input class="b_foot" name=sure type="button" value=确认 onclick="refain()">
                    &nbsp;
                    <input class="b_foot" name=clear type=reset value=上一步 onClick="location = 'f6711_1.jsp?phone_no=<%=phone%>';">
                    &nbsp;
                    <input class="b_foot" name=reset type=button value=关闭 onClick="removeCurrentTab()">
                  </td>
                </tr>                
                </tbody> 
             
            
				    <%
				    }
				   %>
 </table>
<div id="relationArea" style="display:none"></div>
			<div id="wait" style="display:none">
			<img  src="/nresources/default/images/blue-loading.gif" />
		</div>
		<div id="beforePrompt"></div>
	 <%@ include file="/npage/include/footer_simple.jsp" %>  
 
</FORM>
</BODY>
</HTML>

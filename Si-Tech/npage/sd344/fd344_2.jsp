<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 电信管控 d344
   * 版本: 1.0
   * 日期: 2011/3/25
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String hdword_no =(String)session.getAttribute("workNo");//工号
	String hdpowerright =(String)session.getAttribute("powerRight");//角色权限
	String hdorg_code = (String)session.getAttribute("orgCode");//org_code 操作权限归属
	String hdwork_pwd =(String)session.getAttribute("password");//工号密码		
	String hdthe_ip =  (String)session.getAttribute("ipAddr");//登陆IP	
	String[][] favInfo = (String[][])session.getAttribute("favInfo");//读取优惠资费代码	
	String regionCode = (String)session.getAttribute("regCode");
%>

<%
	String opCode="d344";
	String opName="电信管控";
	String phoneNo = request.getParameter("phoneNo");
%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=hdorg_code.substring(0,2)%>"  id="retListString1"/>	
<head>
<SCRIPT language="javascript">
function turnit()
{
	document.all.better.style.display="";
}
function checkexpDays()
{
	if(document.form1.expDays.value <= 0)
    {
        rdShowMessageDialog("请正确输入天数,天数不能为负或0天！");
        document.form1.expDays.value = "";
        document.form1.expDays.focus();
        return false;
    }
	if(document.form1.expDays.value > 365)
    {
        rdShowMessageDialog("请正确输入天数,天数不能超过365天！");
        document.form1.expDays.value = "";
        document.form1.expDays.focus();
        return false;
    }

}

/*----------------调用打印页面函数---------------------*/
	function showPrtdlg1246()
	{  
		getAfterPrompt();
		var op_note=document.all.opNote.value;
		var preMsg=document.all.preMsg.value;
		thesysnote =op_note.trim()+"，"+preMsg+"。";      //生成系统备注    
		document.all.opNote.value= thesysnote;                      //产生页面显示的系统备注
		
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
				conf();                          
			}
			else if(ret==0)                 //点击取消,问是否提交
			{    
				crmsubmit();                     
			}
		}
	}	

</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<body>
<form action="" method=post name="form1"> 
	<input type="hidden" name="oret_code" value="">
	<%@ include file="/npage/include/header.jsp" %>

<%      
 	String outList[][] = new String [][]{{"0","26"}};
%>
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
	String passWord = hdwork_pwd;                                 //操作工号	
	String custWord = "";                                          //用户密码 
	String ChOpRunCode  = ReqUtil.get(request,"opFlag");                //操作运行状态
%>
	<wtc:service name="sd344Init" routerKey="region" routerValue="<%=regionCode%>" outnum="13" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=chnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=passWord%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=custWord%>"/>
		<wtc:param value="<%=ChOpRunCode%>"/>			
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%	
		oret_code = retCode;
		oret_msg = retMsg;
		            
		if(!oret_code.equals("000000"))
	 	{
%>
<script language="javascript">
	rdShowMessageDialog("<%=String.valueOf(oret_code)%>:"+"<%=oret_msg%>",0);
	history.go(-1);
</script>
<%
		}
		else{
		oid_no=result[0][0];		  		  //0  用户id                
		custName=result[0][1];		      //1  客户名称             
		statusCode=result[0][2];		      //2  状态代码          
		statusName=result[0][3];		      //3  状态名称  
		custAddr=result[0][4];		      //4  客户住址          
		idType=result[0][5];		          //5  证件类型          
		oid_name=result[0][6];		          //6  证件名称          
		idIccid=result[0][7];		      //7  证件号码         
		onew_run=result[0][8];		          //8  新状态代码        
		onew_runname=result[0][9];           //9  新状态名称 
		smName=result[0][10];           //10  产品名称
		preMsg=result[0][11];	           //11  是否有预约特服的提示信息
		noteMsg=result[0][12];           //12  操作备注信息
		System.out.println("---------------------------------"+preMsg);
		if(!"".equals(preMsg))
		{
%>
				<script language="javascript">
					rdShowMessageDialog("<%=preMsg%>"+"！");
				</script>
<%				
    }
   }%> 
<div class="title">
		<div id="title_zi">客户资料</div>
</div>

<table cellspacing="0">
	<tr> 
		<td class="blue">服务号码 </td>
		<td>
			<input name="phoneNo" value="<%=ReqUtil.get(request,"phoneNo")%>" size="20" v_type="mobphone" 
				 v_must=1 onBlur="if(this.value!=''){if(checkElement('phoneNo')==false){return false;}}" 
				 Class="InputGrey" readOnly>
		</td>
		<td class="blue">客户名称 </td>
		<td >
			<input name="custName" size="20"  value="<%=custName%>" Class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td class="blue">品牌名称  </td>
		<td >
			<input name="smName" size="20"  value="<%=smName%>" Class="InputGrey" readOnly>
		</td>
		<td class="blue">客户地址</td>
		<td >
			<input name="custAddr" size="20"  value="<%=custAddr%>" Class="InputGrey" readOnly>
		</td>
	</tr>
	<tr > 
		<td class="blue">证件类型</td>
		<td ><input name="idType" value="<%=idType%>" size="20" Class="InputGrey" readOnly>
		</td>
		<td class="blue">证件号码</td>
		<td>
			<input name="idIccid" size="20"  value="<%=idIccid%>"   Class="InputGrey" readOnly >
		</td>
	</tr>
	<tr> 
		<td class="blue">状态代码</td>
		<td >
			<input name="statusCode" size="20"  value="<%=statusCode%>" Class="InputGrey" readOnly>
		</td>
		<td class="blue">状态名称 </td>
		<td >
			<input name="statusName" size="20"  value="<%=statusName%>" Class="InputGrey" readOnly>
		</td>
	</tr>
	<%
		String strsql = "";
		String favor_code = "";
		String hand_fee = "";

		strsql = "select HAND_FEE, FAVOUR_CODE from sNewFunctionFee where region_code='05' and function_code='1246'";
	%>
		<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
			<wtc:sql><%=strsql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="handFeeArr" scope="end" />
	<%
		if(retCode.equals("000000")){
			if(handFeeArr.length>0){
				hand_fee = handFeeArr[0][0];
				favor_code = handFeeArr[0][1];				
			}
		}
	%>
	<tr >
		
			<input name="ohand_cash" v_name='手续费' type="hidden" size="20" maxlength=20 value="0">
			<input type="hidden" name="ishould_fee" size="20" maxlength=20 value="0" Class="InputGrey" readOnly>
		
		<td class="blue">开关机命令函数 </td>
		<td nowrap colspan="3">
			<input name="icmd_code" value="<%=onew_runname%>" size="4" Class="InputGrey" readOnly>
			<span id=better style="DISPLAY: none">
				<input name="expDays" size="12" v_type="0_9" onChange="checkexpDays()" maxlength=20 value="1"  onblur="if(this.value!=''){if(checkElement(this)==false){return false;}}">天
			</span>
		</td>
	</tr>
	<tr>
		<td class="blue">备注</td>
		<td colspan="3">
			<input name="opNote" size="80" value="<%=phoneNo%><%=onew_runname%>">
		</td>
	</tr>

	<tr> 
		<td align=center colspan="4">
			<input class="b_foot_long" name=sure  type=button value="确认&打印" onclick="if(checknum(ohand_cash,ishould_fee)) if(check(form1)) showPrtdlg1246();">
			<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
			<input class="b_foot" name=back  onClick="history.go(-1)" type=button value=返回>
		</td>
	</tr>
</table>
	   <!-----------------------------------设置隐藏域----------------------------------------------->
	   <input type="hidden" name="stream" value="<%=retListString1%>">
	   <input type="hidden" name="oid_no" value="<%=oid_no%>">
	   <input type="hidden" name="onew_run" value="<%=onew_run%>">
	   <input type="hidden" name="preMsg" value="<%=preMsg%>">	   

	   <!-------------------------------------------------------------------------------------------->
	  <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

<script language="javascript">
	onload=function()
	{
		<%if(onew_runname.trim().equals("强开")){%>
		turnit();
		<%}%>
	}
/*-----------------------------页面跳转函数-----------------------------------------------*/
	function pageSubmit(page){
		document.form1.action="<%=request.getContextPath()%>/npage/"+page;
		form1.submit();
		/*if(flag==1){
		document.form1.action="<%=request.getContextPath()%>/npage/change/f1274_3.jsp";  
		form1.submit();
		}*/
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
		
			if( tmpDays <= 0 || tmpDays > 365 || (document.all.expDays.value).trim().length==0)
			{
				rdShowMessageDialog("强开时请输入正确的强开时间,强开时间在0-365之间!",0);
				return false;
			}
		}
		return true;
	} 
	
	var thesysnote = ""; //定义全局变量－系统备注
	
	function printInfo(printType)
	{
		var cust_info=""; //客户信息
		var opr_info=""; //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
		var retInfo = "";  //打印内容
		
		cust_info+="手机号码："+'<%=ReqUtil.get(request,"phoneNo")%>'+"|";
		cust_info+="客户姓名："+'<%=custName%>'+"|";         	
		cust_info+="客户地址："+'<%=custAddr%>'+"|";
		cust_info+="证件号码："+'<%=idIccid%>'+"|";
		
		opr_info+="业务类型：电信管控"+"|";
		opr_info+="业务流水："+document.all.stream.value+"|";
		note_info1+="备注: "+document.all.opNote.value+"|";
	
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		
	  return retInfo;	
	}

/*-------------------------打印流程提交处理函数-------------------*/
	function conf()
	{ 
		var h=200;
		var w=400;
		var t=screen.availHeight/2-h/20;
		var l=screen.availWidth/2-w/2;
		
		var DlgMessage = "确实要进行电子免填单打印吗?";
		var submitCfm = "Yes";
	
		var pType="subprint";                                     // 打印类型：print 打印 subprint 合并打印
		var billType="1";                                         //  票价类型：1电子免填单、2发票、3收据
		var sysAccept=document.all.stream.value;                  // 流水号
		var printStr=printInfo("Detail");                         //调用printinfo()返回的打印内容
		var mode_code=null;                                        //资费代码
		var fav_code=null;                                         //特服代码
		var area_code=null;                                        //小区代码
		var phoneNo="<%=phoneNo%>"              						//客户电话
		
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path+=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=1246&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret_value=window.showModalDialog(path,printStr,prop);

	/**********************打印所需的参数组织完毕****************************/
      if (typeof(ret_value) != "undefined") {
			crmsubmit();
		}
	
	}
	
	function crmsubmit()
	{
		if(rdShowConfirmDialog("是否提交此次操作？")==1){
			form1.action="fd344Cfm.jsp";
			form1.submit();
		 }else{
			return false;
		 }
	}

 </script>


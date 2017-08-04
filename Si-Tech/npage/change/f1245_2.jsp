<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 赠品领取查询1245
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	request.setCharacterEncoding("GBK");%>

<%
	String opCode="1245";
	String opName="赠品领取查询";
	System.out.println(".....................phone............."+request.getParameter("i1"));
	String phoneNo = (String)request.getParameter("i1");
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	System.out.println(".....................phone............."+phoneNo);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>黑龙江BOSS-信息点播－赠品领取查询</TITLE>
</HEAD>
<body>
<FORM action="" method=post name="form1"> 
	<%@ include file="/npage/include/header.jsp" %>

<%
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String[] paraAray=new String[2];
	paraAray[0]=phoneNo;
	paraAray[1]=workNo;
//	ArrayList list = impl.callFXService("s1295_Valid",paraAray,"17");
%>
	<wtc:service name="s1295_Valid" routerKey="region" routerValue="<%=regionCode%>" outnum="17" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
	</wtc:service>
	<wtc:array id="temp" scope="end"/>
	<wtc:array id="res1" start="7" length="1" scope="end"/>
	<wtc:array id="res2" start="8" length="1" scope="end"/>
	<wtc:array id="res4" start="10" length="1" scope="end"/>
	<wtc:array id="res5" start="11" length="1" scope="end"/>
	<wtc:array id="res6" start="12" length="1" scope="end"/>
	<wtc:array id="res7" start="13" length="1" scope="end"/>	
	<wtc:array id="res8" start="14" length="1" scope="end"/>
	<wtc:array id="res10" start="16" length="1" scope="end"/>	
<%
if(!retCode.equals("000000")){
System.out.println("调用服务s1295_Valid in f1245_2.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
System.out.println(retCode);
%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>");
				 location = "f1245_1.jsp?activePhone=<%=phoneNo%>";
			</script>
<%
}
/***********************************定义返回参数*********************************************/
	String ret_username="";										  // 用户名	
	String ret_userpwd="";										  // 用户密码
	String ret_userunit="";										  // 用户单位
	String ret_prepayfee="";									  // 预存款
	String ret_dialcount="";									  // 点播次数
	//单个数值的取出赋值
	ret_username=temp[0][2];
	ret_userpwd=temp[0][3];
	ret_userunit=temp[0][4];
	ret_prepayfee=temp[0][5];
	ret_dialcount=temp[0][6];
	System.out.println("ret_dialcountret_dialcountret_dialcount================"+temp[0][6]);
	System.out.println("res1.length================"+res1.length);
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>

<script language="javascript">

function printCommit()//点击确认按钮后，直接第一步触发的函数
{   	
	if(!check(form1)) return false; 
	if(document.form1.note.value==""){
		document.form1.note.value="手机号码:["+document.form1.i1.value+"]"+
	 	"客户:["+document.form1.owner_name.value+"]"+" "+"";
	}
    			
	var doc = document.form1;
	if(isNaN(doc.radio1.length)){
		doc.bz.value="0";
		if(eval("doc.gift_flag0.value")=="T"){//要改
			rdShowConfirmDialog("0-已经确认过了！"); 
			
		}
		else{
			//rdShowConfirmDialog("0-还没确认！");
			showPrtDlg("Detail","确实要进行打印吗？","Yes");//触发showPrtDlg函数
		}
	}
	else{
		for(var i=0; i<doc.radio1.length; i++){
			if ( doc.radio1[i].checked){

				if(eval("doc.gift_flag"+i+".value")=="T"){
					rdShowConfirmDialog("1-已经确认过了！"); 
					break;
				}
				else{
					doc.bz.value=i;
					showPrtDlg("Detail","确实要进行打印吗？","Yes");
				}
			}
		}
	}
		
         
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
	var h=180;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
   
	var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=loginAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="1245" ;                   			 		//操作代码
	var phoneNo="<%=phoneNo%>";                  	 		//客户电话
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+<%=loginAccept%>+
			"&phoneNo="+document.form1.i1.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
    //if(typeof(ret)!="undefined")
   {
       //if((ret=="confirm")&&(submitCfm == "Yes"))
       {
	       if(rdShowConfirmDialog("确认要提交吗？")==1)
	       {
		       form1.action="f1245_cfm.jsp";
		       form1.submit();
		   }
		}		        
   }
}

function printInfo(printType)
{
   
    var cust_info="客户地址:|";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1="备注:|"; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
    if(printType == "Detail")
    {	
		//打印电子免填单
		//opr_info+='操作时间:<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		opr_info+="当前积分:1000|";
		//retInfo+=" |";
		//retInfo+=" "+"|";
		//opr_info+= "受理内容:|";
		opr_info+= "手机号码:13900000000|";
		retInfo+=" |";

	}  
    if(printType == "Bill")
    {	//打印发票
	}
	retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;	
}
</script>
 <div class="title">
		<div id="title_zi">客户信息</div>
	</div>     
<TABLE cellSpacing="0">
	<TR> 
		<TD class="blue" width="14%">服务号码</TD>
		<TD width="36%"> 
			<input class="InputGrey" name="i1" value="<%=phoneNo%>" size="20"  readonly>
		</TD>
		<TD class="blue" width="14%">客户名称</TD>
		<TD width="36%"> 
			<input class="InputGrey" name="owner_name" size="20"  value="<%=ret_username%>"  readonly >
		</TD>
	</TR>
	<TR> 
		<TD class="blue">客户单位</TD>
		<TD> 
			<input class="InputGrey" name="owner_unit" size="45"  value="<%=ret_userunit%>" readonly>
		</TD>	
		<TD class="blue">预存款</TD>
		<TD> 
			<input class="InputGrey" name="prepay_fee" size="20"  value="<%=ret_prepayfee%>" readonly>
		</TD>
	</TR>
	<TR> 
		<TD class="blue">点播次数</TD>
		<TD colspan="3"> 
			<input class="InputGrey" name="owner_unit" size="20"  value="<%=ret_dialcount%>" readonly>
		</TD>	
	</TR>
</TABLE>
</div>
	<div id="Operation_Table"> 
	<div class="title">
		<div id="title_zi">赠品信息</div>
	</div>
<TABLE cellSpacing="0">
	<TR> 
		<th width="9%">&nbsp;</th>
		<th width="13%" >赠送名称</th>
		<th width="13%" >礼品名称</th>
		<th width="13%" >礼品金额</th>
		<th width="13%" >领取标志</th>
		<th width="13%" >领取截止时间</th>
		<th width="13%" >工号</th>
		<th width="13%" >操作时间</th>
	</TR>
	<% if(res1.length==0){
	%>	
		<TR>
			<TD width="9%"><input type=radio name="radio1" checked></TD>
			<TD width="13%" >&nbsp;</TD>
			<TD width="13%" >&nbsp;</TD>
			<TD width="13%" >&nbsp;</TD>
			<TD width="13%" >未领取</TD>
			<TD width="13%" >&nbsp;</TD>
			<TD width="13%" >&nbsp;</TD>
			<TD width="13%" >&nbsp;</TD>
		</TR>
			<input name="gift_flag0" type="hidden" value="">
			<input name="login_no0" type="hidden" value="">
			<input name="present_code0" type="hidden" value="">
			<input name="end_time0" type="hidden" value="">
		
	<%}%>
	<%
	for (int j=0;j<res1.length;j++){
	%>
		<TR>
			<TD width="9%"><input type=radio name="radio1" value="<%=j%>" checked></TD>
			<TD width="13%" ><%=res2[j][0]%>&nbsp;</TD>
			<TD width="13%" ><%=res4[j][0]%>&nbsp;</TD>
			<TD width="13%" ><%=res5[j][0]%>&nbsp;</TD>
			<TD width="13%" ><%if (res6[j][0].trim().equals("T")) out.print("已领取");else out.print("未领取");%><%=res6[j][0]%></TD>
			<TD width="13%" ><%=res7[j][0]%>&nbsp;</TD>
			<TD width="13%" ><%=res8[j][0]%>&nbsp;</TD>
			<TD width="13%" ><%=res10[j][0]%>&nbsp;</TD>
			
			<input name="gift_flag<%=j%>" type="hidden" value="<%=res6[j][0]%>">
			<input name="login_no<%=j%>" type="hidden" value="<%=res8[j][0]%>">
			<input name="present_code<%=j%>" type="hidden" value="<%=res1[j][0]%>">
			<input name="end_time<%=j%>" type="hidden" value="<%=res7[j][0]%>">
		</TR>
	<%
	}
	%>
</TABLE>
</div>
	<div id="Operation_Table"> 
	<div class="title">
		<div id="title_zi">操作信息</div>
	</div>	  
<TABLE cellSpacing="0">
	<TR> 
		<TD class="blue">备注</TD>
		<TD > 
			<input class="InputGrey" readOnly name="note" size="60" value="" >
		</TD>
	</TR>
	<TR> 
		<TD align="center" id="footer" colspan="2">
			<input class="b_foot" name=link type=button value="确认" onclick="printCommit()">
			<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
			<input class="b_foot" name=back  onClick="history.go(-1)" type=button value=返回>
		</TD>
	</TR>
</TABLE>
	   <!-----------------------------------设置隐藏域----------------------------------------------->
	    <input type="hidden" name="bz" value=""> 
		<%@ include file="/npage/include/footer.jsp" %>
	   </FORM>
     </BODY>
   </HTML>
   <%/*-----------------------------确认按钮的javascript区-------------------------------------*/%>
   <script language="javascript">
   function pageconfirm(){
   }
   </script>
  

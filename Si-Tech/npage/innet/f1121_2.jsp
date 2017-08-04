<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 全球通开户冲正1121
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String opCode="1121";
	String opName="全球通开户冲正";
	String phoneNo = (String)request.getParameter("my_phone");
%>

<%
	Logger logger = Logger.getLogger("f1121_2.jsp");

    String workNo =(String)session.getAttribute("workNo");    		         //工号
	String workName =(String)session.getAttribute("workName");               //工号名称
	String info =  (String)session.getAttribute("ipAddr");                   //登陆IP
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");	
	String regionCode = (String)session.getAttribute("regCode");
	
	String orgCode =(String)session.getAttribute("orgCode");
	String stream = getMaxAccept();												//冲正流水
%>

<%
	String s1 = ReqUtil.get(request,"s1");                            //获得下拉筐的值
	String geti1 = ReqUtil.get(request,"i1");                         //获得查询输入筐的值－手机
	String is = ReqUtil.get(request,"ii");                            //获得查询输入筐的值－流水
	if(s1.equals("手机号码")&&!is.equals(""))                //如果用手机查，并且流水不为空将流水变为空
	{
		is = "";
	}
	if(s1.equals("服务流水")&&!geti1.equals(""))            //如果用流水查，并且手机号码不为空，将手机变为空
	{
		geti1 = "";
	}
	String and = geti1 +is;
%>

<%
	String loginNote="";
	String sqlStr9 = "select back_char1 from snotecode where region_code='"+regionCode+"' and op_code='XXXX'";
	
%>

	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
   		<wtc:sql><%=sqlStr9%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="result9" scope="end" />
    	
<%
	System.out.println("@@@@@@@@@result9="+result9);
	
	for(int i=0;i<result9.length;i++){
		 loginNote = (result9[i][0]).trim();
		}
	loginNote = loginNote.replaceAll("\"","");
	loginNote = loginNote.replaceAll("\'","");
	loginNote = loginNote.replaceAll("\r\n","   ");  
	loginNote = loginNote.replaceAll("\r","   "); 
	loginNote = loginNote.replaceAll("\n","   "); 
%>

<html>
<head>
<title>黑龙江BOSS-入网－全球通开户冲正</title>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<%
/*----------------------------组织调用s1121Init服务的参数---------------------------------*/
	String flag ="";                                                   //输入标志位 1:流水 2:手机号
	if(s1.equals("服务流水")){
		flag = "1";
	}
	else{
		flag = "2";		//手机号
	}					//对操作类别进行判断
	String glide=is;                                                   //输入流水，如果输入的是手机号则为空
	String phone=geti1;                                                //输入手机号，如果输入流水则为空
	String op_code="1121";                                             //页面代码
	String org_code=orgCode;                                        //org_code
	String ret_code = "";
	String ret_msg = "";
	String openrandom ="";
	String i3="";
	String i4="";
	String i5="";
	String i6="";
	String i7="";
	String i8="";
	String i9="";
	String i10="";
	String i11="";
	String i12="";
	String i13="";
	String i14="";
	String i15="";
	String i16="";
	String i17="";
	String i18="";
%>

	<wtc:service name="s1121Init" routerKey="region" routerValue="<%=regionCode%>" outnum="19" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=flag%>"/>
		<wtc:param value="<%=glide%>"/>
		<wtc:param value="<%=phone%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=orgCode%>"/>
	    <wtc:param value="<%=workNo%>"/>
	</wtc:service>
	<wtc:array id="s1121InitArr" scope="end"/>
		
<%
	String errCode = retCode ;
	ret_msg = retMsg ;
	if(s1121InitArr.length<1)
	{
		ret_msg = "查询号码基本信息为空";
	}
	else
	{
		if(!errCode.equals("000000"))
		{
			if(i9.trim().compareTo("")==0)
			{
				i9="0.00";
			}
			if(i10.trim().compareTo("")==0)
			{
				i10="0.00";
			}
			if(i11.trim().compareTo("")==0)
			{
				i11="0.00";
			}
			if(i12.trim().compareTo("")==0)
			{
				i12="0.00";
			}
			if(i13.trim().compareTo("")==0)
			{
				i13="0.00";
			}
			if(i14.trim().compareTo("")==0)
			{
				i14="0.00";
			}
			if(i15.trim().compareTo("")==0)
			{
				i15="0.00";
			}
			if(i16.trim().compareTo("")==0)
			{
				i16="0.00";
			}
%>
<script language="JavaScript">
	rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=ret_msg%>",0);
	history.go(-1);
</script>
<%	  }else{
				openrandom = s1121InitArr[0][2];	//操作流水 
				i3 = s1121InitArr[0][3];			//客户ID 
				i4 = s1121InitArr[0][4];			//证件类型 
				i5 = s1121InitArr[0][5];			//客户ID 
				i6 = s1121InitArr[0][6];			//客户ID 
				i7 = s1121InitArr[0][7];			//客户ID 
				i8 = s1121InitArr[0][8];			//客户ID 
				i9 = s1121InitArr[0][9];			//客户ID 
				i10 = s1121InitArr[0][10];			//客户ID 
				i11 = s1121InitArr[0][11];			//客户ID 
				i12 = s1121InitArr[0][12];          //客户ID 
				i13 = s1121InitArr[0][13];			//客户ID 
				i14 = s1121InitArr[0][14];			//客户ID 
				i15 = s1121InitArr[0][15];			//客户ID 
				i16 = s1121InitArr[0][16];			//客户ID 
				i17 = s1121InitArr[0][17];			//客户ID 
				i18 = s1121InitArr[0][18];			//客户ID 
			}
			if(i9.trim().compareTo("")==0)
			{
				i9="0.00";
			}
			if(i10.trim().compareTo("")==0)
			{
				i10="0.00";
			}
			
			if(i11.trim().compareTo("")==0)
			{
				i11="0.00";
			}
			
			if(i12.trim().compareTo("")==0)
			{
				i12="0.00";
			}
			
			if(i13.trim().compareTo("")==0)
			{
				i13="0.00";
			}
			
			if(i14.trim().compareTo("")==0)
			{
				i14="0.00";
			}
			
			if(i15.trim().compareTo("")==0 ||i15==null )
			{
				i15="0.00";
				System.out.println("eeeeeeeeeeeeeeei15="+i15);
			}
			
			if(i16.trim().compareTo("")==0)
			{
				i16="0.00";
			}
		
		}
	ret_code="000000";
	
%>

</head>
<%
	if(!ret_code.equals("000000"))
	{
%>
<script language="javascript">
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。",0);
	document.location.replace("<%=request.getContextPath()%>/npage/innet/f1121_1.jsp?activePhone=<%=phoneNo%>");
</script>
	  
  <%}%>

<script language="javascript">

function printInfo(printType)
{
     var cust_info=""; //客户信息
	 var opr_info=""; //操作信息
	 var note_info1=""; //备注1
	 var note_info2=""; //备注2
	 var note_info3=""; //备注3
	 var note_info4=""; //备注4
     var retInfo = "";  //打印内容

    if(printType == "Detail")
    {	
    	//打印电子免填单
		cust_info+= "手机号码：     "+"<%=i8%>"+"|";
		cust_info+= "客户姓名：     "+"<%=i6%>"+"|";
		cust_info+= "证件号码：     "+"<%=i5%>"+"|";
		cust_info+= "客户地址：     "+"<%=i7%>"+"|";
		opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		opr_info+= "业务类型："+"开户冲正"+"    操作流水："+"<%=stream%>"+"|";
		opr_info+= "SIM卡费：      "+"<%=WtcUtil.formatNumber(i13,2)%>"+"|";
		if(document.all.i13.value=="0.00")
		{	
			opr_info+= "付费方式：     "+"支票"+"|";
		}
		else{
			opr_info+= "付费方式：     "+"现金"+"|";
		}
		opr_info+= "预存款：       "+"<%=WtcUtil.formatNumber(i11,2)%>"+"|";
		note_info1+=document.all.note1.value+"|";
		note_info2+=" "+"|";
		note_info2+="备注:"+document.all.i222.value+"|";
	
	}  
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 

	return retInfo;	
}

function printCommit()
{
	getAfterPrompt();
	var userid = "客户ID["+document.all.i2.value+"]";
    var openrandom = "操作流水["+ <%=stream%> +"]";
    var sysnote = userid + "<%=stream%>";	
	var note1 = document.all.i7.value + "开户冲正,"+"局方应退："+document.all.i15.value; 
	document.all.note1.value = note1;
	window.document.all.sysnote.value = sysnote;
	if((document.all.i222.value).trim().length==0)
	{
         document.all.i222.value="操作员[<%=workName%>]"+"对客户["+(document.all.i5.value).trim()+"]进行全球通普通开户冲正业务。"
	}
	showPrtdlg1("Detail","确实要打印电子免填单吗？","No");
	if(rdShowConfirmDialog("确认要提交全球通开户冲正信息吗？")==1)
	{    
		document.all.printcount.value="1";
		conf();
    }
	else
	{   
		document.all.printcount.value="0"; 
		canc();
	}

}

 function showPrtdlg1(printType,DlgMessage,submitCfm)
 {
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="print";             				// 打印类型：print 打印 subprint 合并打印
	var billType="1";              				 	//  票价类型：1电子免填单、2发票、3收据
	var sysAccept ="<%=stream%>";               // 流水号
	var printStr = printInfo(printType);			//调用printinfo()返回的打印内容
	var mode_code=null;               				//资费代码
	var fav_code=null;                				//特服代码
	var area_code=null;             				//小区代码
	var opCode="1121" ;                   			//操作代码
	var phoneNo="<%=phoneNo%>";                  	//客户电话

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.form1.i1.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	 
 }
/*-------------------------打印流程提交处理函数-------------------*/
 function conf()
 {
   form1.action="f1121_3.jsp";
   form1.submit();
 }

 function canc()
 {
   /*
   form1.action="f1121_1.jsp";
   form1.submit();
   */
 }
/*-------------------------页面提交跳转函数----------------------------*/

function pageSubmit(){
	document.form1.action="<%=request.getContextPath()%>/npage/innet/f1121_1.jsp?activePhone=<%=phoneNo%>";  
    form1.submit();
	  }
/*-------------------------页面提交跳转函数----------------------------*/
</script>

		
<body>
<form action="" method=post name="form1"> 
		<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">客户资料</div>
</div>
<table cellspacing="0">
	<tr> 
		<td class="blue">
			查询类型
		</td>
		<td>
			<input type="text" value="<%=s1%>" size="20" class="InputGrey" readOnly>
		</td>
		<td colspan="2">
			<input name="i1" size="11" maxlength=11 value="<%=and%>" class="InputGrey" readOnly> 
			<input class="b_text" name=verify  type=button value="查询" onclick = "if(check(form1)) pageSubmit(); " disabled >
		</td>
	</tr>
	
	<tr> 
		<td width="16%" class="blue">客户ID </td>
		<td width="34%">
			<input name="i2" size="20" maxlength=30  value="<%=i3%>" class="InputGrey" readOnly>
		</td>
		<td width="16%" class="blue">客户证件类型 </td>
		<td width="34%">
		<%
			String subi4 = "";
			if(!i4.equals("")){
			subi4 = i4.substring(4);
			}
		%>
			<input name="i3" type="inpwd" size="20" maxlength=30  value="<%=subi4%>" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td width="16%" class="blue">客户证件号码 </td>
		<td width="34%">
			<input name="i4" size="20" maxlength=30 value="<%=i5%>"  class="InputGrey" readOnly>
		</td>
		<td width="16%" class="blue">客户名称 </td>
		<td width="34%">
			<input name="i5" size="20" maxlength=30 value="<%=i6%>" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td width="16%" class="blue">客户住址 </td>
		<td width="34%">
			<input type="text" name="i6" size="30" maxlength=20 value="<%=i7%>" class="InputGrey" readOnly>
		</td>
		<td width="16%" class="blue">手机号码 </td>
		<td width="34%">
			<input type="text" name="i7" size="20"maxlength=20 value="<%=i8%>" class="InputGrey" readOnly>
		</td>
	</tr>
</table>
	</div>
	
	<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">相关费用 </div>
</div>

	<table cellspacing="0">	
	<tr> 
		<td width="16%" class="blue">手续费 </td>
		<td width="34%">
			<input name="i8" size="20" maxlength=2 value="<%=WtcUtil.formatNumber(i9,2)%>"  class="InputGrey" readOnly>
		</td>
		<td width="16%" class="blue">选号费 </td>
		<td width="34%">
			<input name="i9" size="20"maxlength=20 value="<%=WtcUtil.formatNumber(i10,2)%>"  class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td width="16%" class="blue">预存款 </td>
		<td width="34%">
			<input name="i10" size="20" maxlength=2  value="<%=WtcUtil.formatNumber(i11,2)%>" class="InputGrey" readOnly>
		</td>
		<td width="16%" class="blue">机器费 </td>
		<td width="34%">
			<input name="i11" size="20" maxlength=20 value="<%=WtcUtil.formatNumber(i12,2)%>" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td width="16%" class="blue">SIM卡费 </td>
		<td width="34%">
			<input name="i12" size="20"maxlength=20 value="<%=WtcUtil.formatNumber(i13,2)%>" class="InputGrey" readOnly>
		</td>
		<td width="16%" class="blue">现金交款 </td>
		<td width="34%">
			<input type="text" name="i13" size="20" maxlength=20 value="<%=WtcUtil.formatNumber(i14,2)%>" class="InputGrey" readOnly>
		</td>  
	</tr>
	<tr> 
		<td width="16%" class="blue">支票交款 </td>
		<td width="34%" >
			<input name="i14" size="20" maxlength=20 value="<%=WtcUtil.formatNumber(i15,2)%>" class="InputGrey" readOnly>
		</td>
		<%
			double theback=0.00;
			if(!i14.equals("")&&!i15.equals("")){
				double thei14 = Double.parseDouble(i14);
				double thei15 = Double.parseDouble(i15);
				theback = thei14+thei15;			
			}
		%>
		<td width="16%" class="blue">退款总额 </td>
		<td width="34%" >
			<input name="i15" size="20" maxlength=20 value="<%=WtcUtil.formatNumber(theback,2)%>" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td width=16% class="blue">备注 </td>
		<td colspan="3"><input name=sysnote size=75 maxlength="60" class="InputGrey" readOnly></td>
	      <TR style="display:none"> 
				  <TD>操作备注：</TD>
				  <TD><input name=i222 class="button" size=75 maxlength="60" ></TD>
          </TR>
	</tr>
	
	<tr>
		<td colspan="4" align="center">
			<input class="b_foot" name="doSure"  onclick="if(check(form1)) printCommit();" type=button value=确认>
			<input class="b_foot" name=reset onClick="pageSubmit()" type=reset value=清除>
			<input class="b_foot" name=kkkk  onClick="history.go(-1)" type=button value=返回>
		</td>
	</tr>
<!------------设置隐藏字段，开户流水，包括客户ID，用户ID------------------------按顺序-------->
			<input type="hidden" name="userid" value="<%=i17%>">
			<input type="hidden" name="accountid" value="<%=i18%>">
            <input type="hidden" name="openrandom" value="<%=openrandom%>">
			<input type="hidden" name="mob_phone" value="<%=i8%>">
			<input type="hidden" name="note1" >
			<input type="hidden" name="innetFee" value="<%=i16%>">
			<input type="hidden" name="stream" value="<%=stream%>">
      		<input type="hidden" name="opr_info">
      		<input type="hidden" name="note_info1">
      		<input type="hidden" name="note_info2">
      		<input type="hidden" name="note_info3">
      		<input type="hidden" name="note_info4">
      		<input type="hidden" name="printcount">
      		<input type="hidden" name="activePhone" value="<%=phoneNo%>">
<!--------------------------------------------------------------------------------------->

</table>
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

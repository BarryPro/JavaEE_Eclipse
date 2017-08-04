<%@ page contentType= "text/html;charset=gb2312" %>
 
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="../../page/common/pwd_comm.jsp" %>
<%@ page import="com.sitech.boss.s1310.viewBean.*" %>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%/*
* name    :
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%  	  
   String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
    String workno = baseInfo[0][2];
    String workname = baseInfo[0][3];
	String belongName = baseInfo[0][16];	//orgcode

	String orgcode = "ap";
	String op_code = "zg66";
	String opCode1 = "zg66"  ;
	String opName1 = "铁通宽带补收"  ;
	String contractno=request.getParameter("contractno");
	String phoneno=request.getParameter("phoneNo");
	String sm_code=request.getParameter("sm_code");
  	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String sRegionCode = belongName.substring(0,2);

ArrayList arlist = new ArrayList();

	//xl add 资费信息查询 begin
	String s_zt="";//状态
	String s_zf="";//资费
	String s_ym="";//包月还是包年
	String[] inParas_zf =new String[2];
	inParas_zf[0]="SELECT case WHEN a.eff_date>sysdate then 'o' else 'n' end,to_char(round(c.offer_attr_value,2)),'m' from  product_offer_instance a, product_offer b,product_offer_attr c where a.serv_id=(select id_no from dcustmsg where phone_no = :s_no)  and a.offer_id = b.offer_id  and a.offer_id = c.offer_id  and b.offer_attr_type = 'YnKD'  and b.offer_type=10 and c.offer_attr_seq=50001 and a.exp_date>sysdate union SELECT case WHEN a.eff_date > sysdate then 'o' else 'n' end,to_char(round(to_char(to_number(c.offer_attr_value)/to_number(d.offer_attr_value)), 2)), 'y' from product_offer_instance a,product_offer b,product_offer_attr c,product_offer_attr d where a.serv_id=(select id_no from dcustmsg where phone_no = :s_no) and a.offer_id=b.offer_id and a.offer_id=c.offer_id and b.offer_attr_type='YnKB' and b.offer_type = 10 and c.offer_attr_seq=5070 and a.exp_date>sysdate and d.offer_attr_seq=5080 and d.offer_id=c.offer_id";
	inParas_zf[1]="s_no="+phoneno+",s_no="+phoneno;

	%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneno%>"  retcode="retCode_zf" retmsg="retMsg_zf" outnum="3">
		<wtc:param value="<%=inParas_zf[0]%>"/>
		<wtc:param value="<%=inParas_zf[1]%>"/>
	</wtc:service>
	<wtc:array id="ret_val_zf" scope="end" />
   <%
		//取length长度 如果length>1 则说明有当前和预约的资费 取预约资费
		//length=1 只有当前
	 
		//取length长度 如果length>1 则说明有当前和预约的资费 取预约资费
		//length=1 只有当前
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ret_val_zf.length is "+ret_val_zf.length);
		if(ret_val_zf.length>0)
		{
			System.out.println("11111111111111111111");
			if(ret_val_zf.length>1)
			{
				System.out.println("33333333333333333");
				//怎么判断取出当前or预约? 取s_zt=o的 表示预约
				for(int i =0;i<ret_val_zf.length;i++)
				{
					System.out.println("fffffffaaaaaaaaaaaaaaaaaa ret_val_zf[i][0] is "+ret_val_zf[i][0]);
					if(ret_val_zf[i][0]=="o" ||ret_val_zf[i][0].equals("o"))
					{
						s_zt=ret_val_zf[i][0];
						s_zf=ret_val_zf[i][1];
						s_ym=ret_val_zf[i][2];
						System.out.println("5555555555555555555");
						//break;
					}
					else
					{
						System.out.println("6666666666666666666666666");
						%>
							<script language="javascript">
								//rdShowMessageDialog("用户存在多条非预约资费!");
								//history.go(-1);
								//alert("test ret_val_zf[i][0] is "+"<%=ret_val_zf[i][0]%>");
							</script>
						<%
					}
				}
			}
			else
			{
				System.out.println("44444444444444444444");
				s_zt=ret_val_zf[0][0];
				s_zf=ret_val_zf[0][1];
				s_ym=ret_val_zf[0][2];
			}
		}
		else
		{
			System.out.println("222222222222222222");
			s_zt="0";
			s_zf="0";
			s_ym="0";
		}
	%>
 
	<wtc:service name="s2201Init" retcode="retCode3" retmsg="retMsg3" outnum="5">
			<wtc:param value="<%=phoneno%>"/> 
			<wtc:param value="<%=contractno%>"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=belongName%>"/>
			<wtc:param value="<%=op_code%>"/>
		</wtc:service>
	<wtc:array id="result2" scope="end" />
	<%
String [][] result = new String[][]{};
result =result2;
String return_code =result[0][0];
String return_message =result[0][1];
String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
%>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<%
if (!return_code.equals("000000")) {
%><script language="JavaScript">
rdShowMessageDialog("查询错误！<br>错误代码：'<%=return_code%>'。<br>错误信息：'<%=return_message%>'。",0);
history.go(-1);
</script>
<%}
String run_name = result[0][2];
String cust_name =result[0][3];
String cust_info =result[0][4];
run_name=run_name.trim();
cust_info=cust_info.trim();
cust_name=cust_name.trim();
%>

<HTML><HEAD><TITLE>黑龙江BOSS-单个号码费用补收</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script type="text/javascript" src="../../js/rpc/src/core_c.js"></script>
<script language="JavaScript">


onload=function()
{
}
core.loadUnit("debug");
core.loadUnit("rpccore"); 
onload=function()
{		
	core.rpc.onreceive = doProcess;	
}

function doProcess(packet)
{

<%System.out.println("#########################################");%>
	//使用RPC的时候,以下三个变量作为标准使用.
	error_code = packet.data.findValueByName("errorCode");
	error_msg =  packet.data.findValueByName("errorMsg");
	verifyType = packet.data.findValueByName("verifyType");
	backArrMsg = packet.data.findValueByName("backArrMsg");

	self.status="";
		
	var tmpObj="";
	var i=0;
	var j=0;
	var ret_code=0;
	var tmpstr="";
	
	ret_code =  parseInt(error_code);
	//alert("111111111111111111111111" +error_code ); 
	//alert("111111111111111111111111" +error_msg ); 
	//alert("111111111111111111111111----------"            +   verifyType ); 
	//alert("111111111111111111111111" +backArrMsg );
	
	if( ret_code == 0 ){
	  tmpObj = "balanceType" 
	  document.all(tmpObj).options.length=0;
	  document.all(tmpObj).options.length=backArrMsg.length;	
      // alert("2222222222222222222222222222222"+backArrMsg);
		

       for(i=0;i<backArrMsg.length;i++)
	    {
		// alert("3333333333333333333333333333333" +backArrMsg.length );


		    document.all(tmpObj).options[i].text=backArrMsg[i][1];
		    document.all(tmpObj).options[i].value=backArrMsg[i][0];
 	        document.all(tmpObj).options[i].nv1=backArrMsg[i][1];
	        document.all(tmpObj).options[i].nv2=backArrMsg[i][0];
	//	 alert("33333333333333333   " + document.all(tmpObj).options[i].nv1);
	//	 alert("33333333333333333   " + document.all(tmpObj).options[i].nv2);

		
		 }
		}else{
			rdShowMessageDialog("取信息错误:"+error_msg+"!");
			return false;			
		}
	//changew();
}
function change()
{
		
	var dealType="";
	var sqlBuf="";
	var myPacket = new RPCPacket("../e005/getBalanceType.jsp","正在获得送费明细信息，请稍候......");
	dealType = document.all.dealType[document.all.dealType.selectedIndex].value;
	
	sqlBuf="51" ;
	var s_region="<%=sRegionCode%>";
	var s_date1="<%=dateStr%>";
	var s_date2="<%=dateStr%>";
	myPacket.data.add("verifyType","1");
	myPacket.data.add("sqlBuf",sqlBuf);
	myPacket.data.add("recv_number",2);
	myPacket.data.add("s_region",s_region);
	myPacket.data.add("s_date1",s_date1);
	myPacket.data.add("s_date2",s_date2);
	myPacket.data.add("dealType",dealType);
	core.rpc.sendPacket(myPacket);
	delete(myPacket);		
}
/*function changew(){
alert("aaa");
with(document.form){
	balanceType.text=balanceType.options[balanceType.selectedIndex].nv1;
	balanceType.value=balanceType.options[balanceType.selectedIndex].nv2;
	}
}
*/

function isKeyNumberdot(ifdot)
{
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0)
		if(s_keycode>=48 && s_keycode<=57)
			return true;
		else
			return false;
    else
    {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
		{
		      return true;
		}
		else if(s_keycode==45)
		{
		    return true;
		}
		else
			  return false;
    }
}
function form_load()
{
dynAddRow();
}

function checkfee()
{
var total_fee=0;
var prtFlag=0;
 if ( form.lines.value=="0"){
        rdShowMessageDialog("请选择增加一行后再确认！");
      document.form.inp.focus();
	  return false;
  }
if (typeof(document.form.fee_detail.length)!="undefined"){
for (var i=0;i< document.form.fee_detail.length;i++) {
		for (var j=i+1;j< document.form.fee_detail.length;j++) {
		if (document.form.fee_name[i].value==document.form.fee_name[j].value)
		       {   rdShowMessageDialog("同一种费用名称只能选择一次！");
      			  document.form.fee_name[j].focus();
				  return false; }
		}
		}
for (var i=0;i< document.form.fee_detail.length;i++) {
  if (document.form.fee_name[i].value=="0"){
  		rdShowMessageDialog("请选择费用名称！");
		document.form.fee_name[i].focus();
		return false;
  		}
  if (document.form.fee_detail[i].value==""||parseFloat(document.form.fee_detail[i].value,10)==0){
  		rdShowMessageDialog("输入金额不能为空或0！");
		document.form.fee_detail[i].focus();
		return false;
  		}
  var v_fee=document.form.fee_detail[i].value;
  var pos=v_fee.indexOf(".");
     if(pos!=-1)
   {
		if(pos>10)
		{
			rdShowMessageDialog("输入金额小数点前不能大于10位！");
			document.form.fee_detail[i].focus();
			return false;
		}
		if(v_fee.length-pos>3)
		{
			rdShowMessageDialog("输入金额小数点后不能大于2位！");
			document.form.fee_detail[i].focus();
			return false;
		}
		if(v_fee<-3000)
    {
	      rdShowMessageDialog("单笔负补收金额不能超过3000元！");
	      document.form.fee_detail[i].focus();
	      return false;
    }
    if(v_fee>1000000)
    {
	      rdShowMessageDialog("单笔正补收金额不能超过1000000元！");
	      document.form.fee_detail[i].focus();
	      return false;
    }
   }
   else
   {
		if(v_fee.length>10)
		{
			rdShowMessageDialog("输入金额小数点前不能大于10位！");
			document.form.fee_detail[i].focus();
			return false;
		}
		if(v_fee<-3000)
    {
	      rdShowMessageDialog("单笔负补收金额不能超过3000元！");
	      document.form.fee_detail[i].focus();
	      return false;
    }
    if(v_fee>1000000)
    {
	      rdShowMessageDialog("单笔正补收金额不能超过1000000元！");
	      document.form.fee_detail[i].focus();
	      return false;
    }
   }
 	 }
for (var i=0;i< document.form.fee_detail.length;i++) {
  total_fee=parseFloat(total_fee,10)+parseFloat(form.fee_detail[i].value,10);
  }
  var tmp1=toString(total_fee*100+0.5);
		if (tmp1.indexOf(".")!=-1){
			var tmp2 = tmp1.substring(0,tmp1.indexOf("."));
			var tmp3 = parseFloat(tmp2);
			total_fee=toString(tmp3/100);
		}
  document.form.total_pay.value=total_fee;
for (var i=0;i< document.form.fee_detail.length;i++) {
  if (parseFloat(document.form.fee_detail[i].value,10)*parseFloat(total_fee,10) <= 0.0 ){
		rdShowMessageDialog("对不起，不能同时做正补收和负补收！");
		document.form.fee_detail[i].focus();
		return false;
  }
  }

} //end if
else {
   if (document.form.fee_name.value=="0"){
  		rdShowMessageDialog("请选择费用名称！");
		document.form.fee_name.focus();
		return false;
  		}
  if (document.form.fee_detail.value=="" ||parseFloat(document.form.fee_detail.value,10)==0){
  		rdShowMessageDialog("输入金额不能为空或0！");
		document.form.fee_detail.focus();
		return false;
  		}
  var v_fee=document.form.fee_detail.value;
  var pos=v_fee.indexOf(".");
     if(pos!=-1)
   {
		if(pos>10)
		{
			rdShowMessageDialog("输入金额小数点前不能大于10位！");
			document.form.fee_detail.select();
			return false;
		}
		if(v_fee.length-pos>3)
		{
			rdShowMessageDialog("输入金额小数点后不能大于2位！");
			document.form.fee_detail.select();
			return false;
		}
		if(v_fee<-3000)
    {
	      rdShowMessageDialog("单笔负补收金额不能超过3000元！");
	      document.form.fee_detail[i].focus();
	      return false;
    }
    if(v_fee>1000000)
    {
	      rdShowMessageDialog("单笔正补收金额不能超过1000000元！");
	      document.form.fee_detail[i].focus();
	      return false;
    }
   }
   else
   {
		if(v_fee.length>10)
		{
			rdShowMessageDialog("输入金额小数点前不能大于10位！");
			document.form.fee_detail.select();
			return false;
		}
		if(v_fee<-3000)
    {
	      rdShowMessageDialog("单笔负补收金额不能超过3000元！");
	      document.form.fee_detail[i].focus();
	      return false;
    }
    if(v_fee>1000000)
    {
	      rdShowMessageDialog("单笔正补收金额不能超过1000000元！");
	      document.form.fee_detail[i].focus();
	      return false;
    }
   }
    total_fee=parseFloat(total_fee,10)+parseFloat(form.fee_detail.value,10);
      document.form.total_pay.value=total_fee;
}

	if(document.form.dealType.value.length == 0)
	{	
		rdShowMessageDialog("必须选择送费类型!");
		document.form.dealType.focus();
		return false;
	}
	if(document.form.balanceType.value.length == 0)
	{	
		rdShowMessageDialog("必须选择送费明细!");
		document.form.balanceType.focus();
		return false;
	}
	//xl add for lixs 单个正补 金额>0 单个负补 金额<0 begin
	var balanceType_value = document.form.balanceType[document.form.balanceType.selectedIndex].text;
	var total_pay_value = document.form.total_pay.value;
	//alert("test balanceType_value is "+balanceType_value+" and total_pay_value is "+total_pay_value);
	//balanceType_value="单笔正补";
	if(balanceType_value=="单个正补" && total_pay_value<0)
	{
		rdShowMessageDialog("单笔正补的费用总金额应大于0!");
		return false;
	}
	else if(balanceType_value=="单个负补" && total_pay_value>0)
	{
		rdShowMessageDialog("单笔负补的费用总金额应小于0!");
		return false;
	}
	//xl add for lixs end

	//xl add 金额判断 begin
	//xl add for 判断资费是包年or包月 比较金额 begin
	 var s_ym = "<%=s_ym%>";
	 var s_zf = "<%=s_zf%>";
	 var i_count=0;//判断是否可以整除
	 i_count=total_fee%s_zf;
	 //alert("s_ym is "+s_ym+" and i_count is "+i_count);// m or y 代表包月 包年
	 if(i_count=="0")
	 {
		prtFlag = rdShowConfirmDialog("本次补收金额为"+total_fee+"元，是否确认补收？");
					if (prtFlag==1){
					form.sure.disabled=true;
		form.reset.disabled=true;
		document.form.action="zg66_2.jsp";
		form.submit();
		}
	 }
	 else
	 {
		 rdShowMessageDialog("补收金额为"+total_fee+"元,用户资费为"+s_zf+"元,补收金额不是资费的整数倍,不允许补收!");
		 return false;
	 } 
	//xl add 金额判断 end
	
}

function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
for (Count=0; Count < InString.length; Count++)  {
	TempChar= InString.substring (Count, Count+1);
	if (RefString.indexOf (TempChar, 0)==-1)
	return (false);
}
return (true);
}

function dynAddRow(){
			//
			form.lines.value=parseInt(form.lines.value)+1;
			var tr1=dyntb.insertRow();
	        tr1.id="tr";
			//alert("form.lines.value is "+form.lines.value);
			var s_tmp;
			s_tmp="<td><div align=center><select name=fee_name width=800px><option class=button value=0 selected></option>";
		 
      	  <%	
		 
      		String [][] result_dyn1 = new String[][]{};
			//sm_code="kd";
			
      		String sqlStr ="select * from (select trim(fee_code) || '|' || trim(detail_code) as a,trim(fee_code) || '-' || trim(detail_code) || '--' ||trim(detail_name) from sFeeCodeDetail where fee_code != '*' and decode(sm_flag,'1','kd','2','ke','3','kf','4','kg','5','kh') ='"+sm_code+"' )  order by a";
			  //System.out.println("ZZZZZZZZZZZZZZZZZZZZZZZZZZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA sql is "+sqlStr);
      		
		  %>
			<wtc:service name="TlsPubSelBoss" retcode="retCode4" retmsg="retMsg4" outnum="2">
				<wtc:param value="<%=sqlStr%>"/> 
			</wtc:service>
			<wtc:array id="result_dyn" scope="end" />		  
		  <%
        
      		 
			int recordNum = result_dyn.length;
			System.out.println("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ111111111111111111111111111111111111 recordNum is "+recordNum);
		 
      		
			for(int i=0;i<recordNum;i++){
        		//out.print("<option class=button value=" + result_dyn[i][0] + ">" + result_dyn[i][1] + "</option>");
				%>
					s_tmp +="<option class=button value= '<%=result_dyn[i][0]%>' ><%=result_dyn[i][1]%></option>";	
				<%
      			 
			}%>
			s_tmp +="</select><input type=text name=fee_detail value='0.00' class=button  onKeyPress='return isKeyNumberdot(1)'></div></td>";
			//alert(s_tmp);
			tr1.insertCell().innerHTML =s_tmp;
 
         
 
}

//-->

</script>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">

</HEAD>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" onLoad="form_load();">
<FORM action="" method=post name=form>
 
<input type="hidden" name="lines" value="0">
  <input type = "hidden" name = "phone_kd" value="<%=phoneno%>" >
<input type=hidden name=optype value="<%=request.getParameter("optype")%>">
  <table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td background="<%=request.getContextPath()%>/images/jl_background_1.gif">
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr>
            <td align="right" width="45%">
              <p><img src="<%=request.getContextPath()%>/images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
            <td width="55%" align="right"><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">工号：<%=workno%><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">操作员：<%=workname%></td>
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr>
            <td align="right" background="<%=request.getContextPath()%>/images/jl_background_3.gif" height="69">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td><img src="<%=request.getContextPath()%>/images/jl_logo.gif"></td>
                  <td align="right"><img src="<%=request.getContextPath()%>/images/jl_head_1.gif"></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
		
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr>
            <td align="right" width="73%">
              <table width="535" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                  <td valign="bottom" width="493">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b>单个号码费用补收</b></font></td>
                        <td><img src="<%=request.getContextPath()%>/images/jl_ico_3.gif" width="389" height="30"></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
            <td width="27%">
              <table border="0" cellspacing="0" cellpadding="4" align="right">
                <tr>
                  <td><img src="<%=request.getContextPath()%>/images/jl_ico_4.gif" width="60" height="50"></td>
                  <td><img src="<%=request.getContextPath()%>/images/jl_ico_5.gif" width="60" height="50"></td>
                  <td><img src="<%=request.getContextPath()%>/images/jl_ico_6.gif" width="60" height="50"></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr>
            <td width="45%"> <br>
              <table width=100% height=25 border=0 align="center" cellspacing=2 cellpadding="4">
                <tbody>
                <tr bgcolor="649ECC">
                  <td width="13%">操作类型：</td>
                  <td width="35%">
              <%
              String i1="无主追加";
              String i2="单个号码费用补收";
              String op1=request.getParameter("optype");
              if (op1.equals("0") ) {
              %>
              <%=i1%>
              <%}else if (op1.equals("1") ) {
              %>
              <%=i2%>
              <%
              }%>
                  </td>
                  <td width="13%"></td>
                  <td width="39%">部门：<%=belongName%></td>
                </tr>
                </tbody>
              </table>
              <table width=100% height=25 border=0 align="center" cellspacing=2>
                <tr bgcolor="#E8E8E8">
                  <td width="13%">手机号码：</td>
                  <td width="35%">
                    <input type="text"  class="button" readonly name="phoneno" maxlength="11" value=<%=request.getParameter("phoneno")%>>
                  </td>
                  <td width="13%" align="left">归属年月：</td>
                  <td width="39%">
                   <input type="text" class="button" readonly name="billmonth" value=<%=request.getParameter("billmonth")%>>
                  </td>
                </tr>
                <tr bgcolor="#F5F5F5">
                  <td width="13%">帐户号码：</td>
                  <td width="35%">
                    <input type="text" readonly class="button" name="contractno" value="<%=request.getParameter("contractno")%>">
                  </td>
                  <td width="13%">客户名称：</td>
                  <td width="39%">
                    <input type="text" readonly name="textfield7" size="60" class="button" value="<%=cust_name%>">
                  </td>
                </tr>
                <tr bgcolor="#E8E8E8">
                  <td width="13%">运行状态： </td>
                  <td width="35%">
                     <input type="text" readonly class="button" name="textfield5" value="<%=run_name%>">
                  </td>
                  <td width="13%">客户信息：</td>
                  <td width="39%">
                     <input type="text" readonly name="textfield72" size="60" class="button" value="<%=cust_info%>">
                  </td>
                </tr>
              </table>
			  <table width=100% height=25 border=0 align="center" cellspacing=2>
				  <tr>
					<td>
						用户资费：<input type="text" id="i_zf_money" readonly value="<%=s_zf%>">(补收总金额应为用户资费的整数倍)
					</td>
				  </tr>
			  </table>

              <table width=100% height=25 border=0 align="center" cellspacing=2>
                <tr bgcolor="#F5F5F5">
                  <td colspan="4">以下为可调整的费用信息：</td>
                </tr>
              </table>

			<table width=100% height=25 border=0 align="center" cellspacing=2>
				<tr id="DealType" bgcolor="#E8E8E8" > 
					<td width="13%" >
						<div align="left" >送费类型</div></td>
					<td width="35%">
                  <select name="dealType" onChange="change()">
                  <option value="" selected></option>
                    <% 	try
		   {
		  		ArrayList retArray = new ArrayList();
      			String [][] result1 = new String[][]{};
      
      			String sqlStr1 ="select  deal_name,to_char(deal_type) from sDealType ";
	      		//System.out.println(sqlStr);      		
		  	//	retArray = callView.s1330Query("2",sqlStr);
      			%>
<wtc:service name="TlsPubSelBoss"   outnum="2">
	  <wtc:param value="<%=sqlStr1%>"/>
</wtc:service >
<wtc:array id="retList"   scope="end" />
           <%
      		//	int recordNum = Integer.parseInt((String)retArray.get(0));
      			 result1=retList;
				  int recordNum1 =result1.length;
      		 
      			result1 =retList;
      			for(int i=0;i<recordNum1;i++){
        		out.print("<option class=button value= "+result1[i][1]+">"+result1[i][0] + "</option>");
      			}
	     	}catch(Exception e){
       		//System.out.println("Call queryView Failed!");
     		}          
		%>
						</select>
					</td>
				<td width="13%" >
					<div align="left"  >送费明细</div>
				</td>
                <td width="39%">
					<select name="balanceType" id="balanceType"  >
		            <option value="" selected></option>
					</select> 
				</td>			
			</tr>
			
			</table>
              <TABLE id=dyntb width=100%  bgcolor="#F5F5F5" height=23 border=0 align="center" cellpadding="2" cellSpacing=1>
          <TBODY>
		  
			
          <tr bgcolor="#E8E8E8">
            <td width="40%" >
              <div align="center">费用名称 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;金额</div>
            </td>
            <input type="button" name="inp" class="button" id="inp" value="添加" onClick="dynAddRow()">
          </tr>
		  </TBODY>
          </TABLE>
              <table width=100% height=25 border=0 align="center" cellspacing=1 cellpadding="4">
                <tbody>
                <tr bgcolor="#F5F5F5">
                  <td width=13%>金额总计：</td>
                  <td width="87%">
                     <input type="text"  class="button" name="total_pay" readonly value="">
                  </td>
                </tr>
                <tr bgcolor="#E8E8E8">
                  <td width="13%">备注信息：</td>
                  <td width="87%">
                    <input type="text"  class="button" name="remark" maxlength="60" size="80">
                  </td>
                </tr>
                </tbody>
              </table>
              <table width="100%" border=0 align=center cellpadding="4" cellspacing=1>
                <tbody>
                <tr bgcolor="#EEEEEE">
                  <td align=center bgcolor="F5F5F5" width="100%">
                    <input class="button" name=sure type=button value=确认 onclick="checkfee()">
                    <input class="button" name=reset type=reset value=返回 onClick="window.location.href='zg66_1.jsp'">
                    &nbsp; </td>
                </tr>
                </tbody>
              </table>
              <p>&nbsp;</p>
            </td>
          </tr>
        </table>
        <br>
      </td>
    </tr>
  </table>
 </FORM>
</BODY></HTML>

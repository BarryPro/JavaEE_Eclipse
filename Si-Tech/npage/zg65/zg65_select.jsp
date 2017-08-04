<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 退预存款1362
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode=(String)request.getParameter("opCode");
	String opName=(String)request.getParameter("opName");
	String phoneno = (String)request.getParameter("phoneNo");
	String contractno=request.getParameter("contractno");
	String busy_type = request.getParameter("busy_type");
	String orgcode = (String)session.getAttribute("orgCode");
	String regionCode= (String)session.getAttribute("regCode");
//    ScallSvrViewBean viewBean = new ScallSvrViewBean();
//    CallRemoteResultValue  value1 = null;
    String[] inParas1 = new String[2];
//	String[][] result1  = null ;
	String count_num="0";
	String contract_num="0";

	//xl add 资费信息查询 begin
	String s_zt="";//状态
	String s_zf="";//资费
	String s_ym="";//包月还是包年
	String[] inParas_zf =new String[2];
	inParas_zf[0]="SELECT case WHEN a.eff_date>sysdate then 'o' else 'n' end,to_char(round(c.offer_attr_value,2)),'m' from  product_offer_instance a, product_offer b,product_offer_attr c where a.serv_id=(select id_no from dcustmsg where phone_no = :s_no)  and a.offer_id = b.offer_id  and a.offer_id = c.offer_id  and b.offer_attr_type = 'YnKD'  and b.offer_type=10 and c.offer_attr_seq=50001 and a.exp_date>sysdate union SELECT case WHEN a.eff_date > sysdate then 'o' else 'n' end,to_char(round(to_char(to_number(c.offer_attr_value)/to_number(d.offer_attr_value)),2)),'y' from product_offer_instance a,product_offer b,product_offer_attr c,product_offer_attr d where a.serv_id=(select id_no from dcustmsg where phone_no = :s_no) and a.offer_id=b.offer_id and a.offer_id=c.offer_id and b.offer_attr_type='YnKB' and b.offer_type = 10 and c.offer_attr_seq=5070 and a.exp_date>sysdate and d.offer_attr_seq=5080 and d.offer_id=c.offer_id";
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
			//xl add for 包年不减资费
			if(s_ym=="y" ||s_ym.equals("y"))
			{
				s_zf="0";
			}
		}
		else
		{
			System.out.println("222222222222222222");
			s_zt="0";
			s_zf="0";
			s_ym="0";
		}
		System.out.println("fffffffffffffffffffffffff final test s_zt is "+s_zt+" and s_zf is "+s_zf+" and s_ym is "+s_ym);
		String[] inParas_diff_date =new String[2];
		inParas_diff_date[0]="select to_char(round(to_number(TO_DATE(substr(acc_day,0,8),'yyyymmdd')-TO_DATE(substr(end_time,0,8),'yyyymmdd')))) ,substr(acc_day,0,8),substr(end_time,0,8) from ttkd_account_msg where trim(Phone_no)=:s_no";
		inParas_diff_date[1]="s_no="+phoneno;
		//inParas_diff_date[1]="s_no=20904523315";
	%>
	<wtc:service name="TlsPubSelBoss"  outnum="3" >
		<wtc:param value="<%=inParas_diff_date[0]%>"/>
		<wtc:param value="<%=inParas_diff_date[1]%>"/> 
	</wtc:service>
	<wtc:array id="result_diff_date" scope="end"/>
	
<%
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaffffffffffffffffffff result_diff_date is "+result_diff_date.length);
	if(result_diff_date.length==0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("查询用户账期信息报错!");
				history.go(-1);
			</script>
		<%
	}
	else
	{
	String phoneno_out=request.getParameter("phoneno"); 
    System.out.println("QQQQQQQQQQQQQQQQQQQQQQQQQQQQaaaaaaaaaaaaaaaaaaaaaaa test service=s1362Init；  opCode is "+opCode+" and contractno is "+contractno+" and phoneno is  "+phoneno+" and phoneno_out is "+phoneno_out);
	inParas1[0] = "select to_char(nvl(count(*),0)) from dConShort where contract_no = '"+ contractno +"'";
	inParas1[1] = "contractno="+contractno;
//		value1 = viewBean.callService("0", null, "sPubSelect", "1",inParas1);
%>
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/> 
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
<%	
		
//		System.out.println("tempArr================"+tempArr[0][0]);
//        result1 = value1.getData();
//       System.out.println("result1================"+result1[0][0]);
		if (result1.length == 1) {
		   count_num = result1[0][0];
		}
		if(count_num.equals("0")) {
			inParas1[0] = "select to_char(nvl(count(*),0)) from dconusermsg where contract_no = '"+ contractno +"'";
//			value1 = viewBean.callService("0", null, "sPubSelect", "1", inParas1);
%>
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/> 
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
<%				
//			result1 = value1.getData();
			if (result1.length == 1) {
			  contract_num = result1[0][0];
			}
		}

	//ScallSvrViewBean viewBean = new ScallSvrViewBean();

		 String[] inParas = new String[4];
         inParas[0] = contractno;
         inParas[1] = orgcode;
         inParas[2] = busy_type;
         inParas[3] = phoneno;
 
//    CallRemoteResultValue  value  = viewBean.callService("1",orgcode.substring(0,2),  "s1362Init", "7" ,  inParas) ;
%>  
	<wtc:service name="s1362Init" routerKey="region" routerValue="<%=regionCode%>" outnum="7" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="zg65"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
//           String [][] result  = value.getData();

	   	  String return_code =result[0][0];
		  String return_message = result[0][1];
 
 if ( return_code.equals("000000")) 
{
	String return_money = result[0][2].trim();
	//可退金额需要减去资费 并判断
	/**/
	System.out.println("cccccccccccccccccccccccccccc 服务取出的 可退金额="+return_money);
	String unbill_total =result[0][3].trim();
	String prepay_fee =result[0][4].trim();
	String cust_name =result[0][5].trim();
	String interest = result[0][6].trim();
 %>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE><%=opName%></TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript" src="/npage/s1300/common_1300.js"></script>
 
<script language="JavaScript">
<!--

function form_load()
{
　form.nopay_money.focus();
}
function conShort()
{
	rdShowMessageDialog("此帐户号码没有配置退费短信接收号码，请配置缴、退费短信接收号码！");
	window.open("<%=request.getContextPath()%>/page/s1211/f1771.jsp?contractNo="+document.all.contractno.value,"","width=1000,height=600");
}
function docheck()
{
   getAfterPrompt();
   var v_fee = document.form.nopay_money.value;  
   var pay_message="退费金额不能小于0!"; 
   var null_message="退费金额不能为空!"; 
   var NaN_message="退费金额应为数字型!";
   var larger_message="退费金额不能大于可退金额!";
   var pos;
   if(document.form.count_num.value ==0 && document.form.contract_num.value ==0 || document.form.contract_num.value >=2){
		conShort();
   }
	var	prtFlag = rdShowConfirmDialog("是否确定退费？");
	if (prtFlag !=1)
		return false;

   if(v_fee == null || v_fee == "") 
   {        
	    rdShowMessageDialog(null_message); 
	    document.form.nopay_money.value=<%=return_money%>; 
	    document.form.nopay_money.select(); 
		return false; 
   } 
 
   if(v_fee><%=return_money%>) 
   {        
	    rdShowMessageDialog(larger_message); 
	    document.form.nopay_money.value=<%=return_money%>; 
	    document.form.nopay_money.select(); 
		return false; 
   } 
   if(parseFloat(v_fee) == 0) 
   {        
	    rdShowMessageDialog(pay_message); 
	    document.form.nopay_money.value=<%=return_money%>; 

	    document.form.nopay_money.select(); 
		return false; 
   }        
   if(isNaN(parseFloat(v_fee)))   
   {        
		rdShowMessageDialog(NaN_message); 
	    document.form.nopay_money.value=<%=return_money%>; 
	    document.form.nopay_money.select(); 
	    return false; 
   }
   if(v_fee>9999999999.99)
   {
		rdShowMessageDialog("退费金额不能大于9999999999.99");
	    document.form.nopay_money.value=<%=return_money%>; 

		document.form.nopay_money.select(); 
		return false;
   }
  
   var  tmp_fee = v_fee.toString().replace(/\$|\,/g,'');
    if(isNaN(tmp_fee))
	{
		rdShowMessageDialog("退费金额的格式不对！");
	    document.form.nopay_money.value=<%=return_money%>; 

		document.form.nopay_money.select(); 
		return false;
	}

   
   pos=v_fee.indexOf(".");
   if(pos!=-1)
   {
 		if(v_fee.length-pos>3)
		{
			rdShowMessageDialog("退费金额小数点后不能大于2位！");
	       document.form.nopay_money.value=<%=return_money%>; 

			document.form.nopay_money.select(); 
			return false;
		}
   }
   //退费金额不能大于max_money 这里逻辑有问题哈 怎么退不了呢 余额不足?
   //应该是退费金额 nopay_money 和 可退金额 ktje 作比较
   //rdShowMessageDialog("document.all.nopay_money.value is "+document.all.nopay_money.value+" and document.all.max_money.value is "+document.all.max_money.value);
   if(parseFloat(document.all.nopay_money.value)>parseFloat(document.all.max_money.value))
   {
	   rdShowMessageDialog("退费金额已大于可退费最大金额！");
	   return false;
   }
   document.form.sure.disabled=true;
   document.form.reset.disabled=true;
   document.form.action="s1362_2.jsp";
   document.form.submit();
}

 function showSelWindow() {
	var h=500;
	var w=500;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	var returnValue=window.showModalDialog('getPreAcount.jsp?contractno=<%=contractno%>',"",prop);
    
	if(typeof(returnValue) != "undefined") {   
	    rdShowMessageDialog(returnValue);	   
	}
 }
 	//计算日期之差
function getDays(strDateStart,strDateEnd){
   var strSeparator = "-"; //日期分隔符
   var oDate1;
   var oDate2;
   var iDays;
   //oDate1= strDateStart.split(strSeparator);
   //oDate2= strDateEnd.split(strSeparator);
   oDate1= strDateStart;
   oDate2= strDateEnd;
    var strDateS = new Date(oDate1.substr(0,4), oDate1.substr(4,2)-1, oDate1.substr(6,2));
    var strDateE = new Date(oDate2.substr(0,4), oDate2.substr(4,2)-1, oDate2.substr(6,2));
   //alert("strDateS is "+strDateS+" and strDateE is "+strDateE);
   iDays = parseInt(Math.abs(strDateS - strDateE ) / 1000 / 60 / 60 /24)//把相差的毫秒数转换为天数 
   //alert(iDays);
   return iDays ;
   
}
	function inits()
	{
	   //xl add for 金额判断 begin pre-资费的钱 ＜半月取一半 大于半月取全月
	   /*var sDate1=document.all.kssj.value.substr(0,8) ;
	   var sDate2=document.all.jssj.value.substr(0,8) ;
	   var i_days=getDays(sDate1,  sDate2);

	   nopay_money 这个是输入框的值
	   */
 
	   var i_days="<%=result_diff_date[0][0]%>";
	   //alert("i_days is "+i_days);
	   if(i_days>15)//取整月
	   {
			document.form.sfby.value="是";
			var value1=document.form.nopay_money.value-document.form.yhzf.value;
			document.form.ktje.value=value1.toFixed(2);
			document.form.nopay_money.value=document.form.ktje.value;
	   }
	   else
	   {
		   document.form.sfby.value="否";
		   var value1=document.form.nopay_money.value-document.form.yhzf.value/2;
		   document.form.ktje.value=value1.toFixed(2);
		   document.form.nopay_money.value=document.form.ktje.value;
	   }
	   //如果<0 取成0
	   if(document.form.nopay_money.value<0)
	   {
		   document.form.nopay_money.value=0;
		   document.form.max_money.value =0;
	   } 	
	   document.form.max_money.value= document.form.nopay_money.value;
	   //xl add for 金额判断 end 
	}
//-->
</script>
</HEAD>
<BODY onload="inits()">
<FORM action="" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="busy_type"  value="<%=busy_type%>">
<input type="hidden" name="count_num"  value="<%=count_num%>">
<input type="hidden" name="contract_num"  value="<%=contract_num%>">
<input type="hidden" name="opCode"  value="<%=opCode%>">
<input type="hidden" name="opName"  value="<%=opName%>">
<table cellspacing="0">
	<tr> 
		<th class="blue">服务号码</th>
		<th> 
			<input type="text" name="phoneno" maxlength="11" value="<%=phoneno%>" class="InputGrey" readOnly>
		</th>
		<th colspan="4">部门：<%=orgcode%></th>
	</tr>
	<tr> 
		<td class="blue">帐户号码</td>
		<td> 
			<input type="text" name="contractno" value="<%=contractno%>" class="InputGrey" readOnly>
		</td>
		<td class="blue">用户名称</td>
		<td>
			<input type="text" name="cust_name" value="<%=cust_name%>" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td class="blue"> 现有预存金额 </td>
		<td> 
			<input type="text" name="prepay_fee" value="<%=prepay_fee%>" class="InputGrey" readOnly>
		</td>
		<td class="blue">总欠费</td>
		<td> 
			<input type="text" name="unbill_total" value="<%=unbill_total%>" class="InputGrey" readOnly>
		</td>
	</tr>
 
	<tr> 
		<td class="blue"> 可退金额 </td>
		<td> 
			<input type="text" name="ktje" value="<%=return_money%>" class="InputGrey" readOnly>
		</td>
			<% if (busy_type.equals("1")) {%>
		<td colspan="2">
			<input type="hidden" name="interest" value="<%=interest%>" class="InputGrey" readOnly>
		</td>
			<%} else {%>
		<td class="blue">结息</td>
		<td> 
			<input type="text" name="interest" value="<%=interest%>" class="InputGrey" readOnly>
		</td>
			<%}%>
	</tr>
	 
	<tr> 
		<td class="blue"> 用户资费 </td>
		<td >
			<input type="text" name="yhzf" value="<%=s_zf%>" class="InputGrey" readOnly>
		</td>
		<td></td> 
		<td></td> 
	</tr>
	<tr> 
		<td class="blue">账期日</td>
		<td> 
		 
			<input type="text" name="dqr" value="<%=result_diff_date[0][1]%>" class="InputGrey" readOnly>
		</td>
		<td class="blue">失效时间</td>
		<td> 
		    <input type="text" name="sxsj" value="<%=result_diff_date[0][2]%>" class="InputGrey" readOnly>
			 
		</td>
	</tr>
	
	<tr> 
		<td class="blue">日期差 </td>
		<td> 
			<input type="text" name="sjc" value="<%=result_diff_date[0][0]%>" class="InputGrey" readOnly>
		</td>
		<td class="blue">是否取整月</td>
		<td> 
			<input type="text" name="sfby"  class="InputGrey" readOnly>
		</td>
	</tr>

	<tr> 
		<td class="blue">退费金额</td>
		<td colspan="3"> 
			<input class="button" name=nopay_money value="<%=return_money%>" onKeyPress="return isKeyNumberdot(1)">
		</td>
		<input type="hidden" name=max_money  >
	</tr>
	<tr> <input type="hidden" name="phoneno_out" value="<%=phoneno_out%>">
		<td align=center id="footer" colspan="4"> 
			<!--
			<input class="button" name=predetail type=button value=预存明细 onclick="showSelWindow()">
			&nbsp;
			-->
			<input class="b_foot" name=sure type=button value=确认 onclick="docheck()">
			&nbsp;
			<input class="b_foot" name=reset type=reset value=返回 onClick="history.go(-1)">
			&nbsp;				  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<%}
else
{
%>
	 <script language="JavaScript">
			rdShowMessageDialog("查询错误!<br>错误代码：'<%=return_code%>'，错误信息：'<%=return_message%>'。",0);
			window.location.href="zg65_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	 </script>
<%
	}
 
	}
	
%>


<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/public.css" rel="stylesheet" type="text/css" />
<title>宽带选号界面</title>
</head>
<%   
System.out.println("**************************进入页面************************************");  
   
	 opName="宽带选号界面";
 String  city_id=request.getParameter("cityId");  
 String  site_id=request.getParameter("siteId");
 String  staff_id=request.getParameter("workNo");    
 String  adsl_use="03";
 String  order_id=request.getParameter("workFormId");
 String  object_id=request.getParameter("objectId");
 String  seltype=request.getParameter("selType")==null?"0":request.getParameter("selType"); /*接入方式 0 虚拨 1 专线*/
 String  branch_no=request.getParameter("branchNo"); 
 String  svc_inst_id=request.getParameter("svcInstId"); 
 String  product_id=request.getParameter("prodId");/*主产品*/
 String  vasProds=request.getParameter("vasProds"); /*增值产品串*/
 String test=null;
   String  prodStr1="";
   String[][] result=null; 
   String purpose="71";
   String sufstr="";
   String v_prefix="222";
   String v_suffix="333";
   String v_newaccount="444";
   String name_jp ="";
   System.out.println("**************************调服务"+object_id+"************************************");  
%>
<wtc:service name="MRM_QR_0021" outnum="2">
  <wtc:param  value="<%=object_id.trim()%>"/>
  <wtc:param  value="<%=product_id.trim()%>"/>
  <wtc:param  value="<%=vasProds.trim()%>"/>
</wtc:service>
<wtc:array id="rows">
 	 <%result = rows;%>	
</wtc:array>
<%if(!retCode.trim().equals("000000"))
	{
		purpose="-1";
	}
	else
	{
		purpose=result[0][0];
		prodStr1=result[0][1];
		
	} 
	System.out.println("**************~~~"+object_id+"~~~~************purpose**、、"+purpose+"、、****prodstr.."+prodStr1+"..******************************");  
	System.out.println("**************************调用结束************************************");  
	sufstr="select distinct suffix ,suffix b  from trm_adsl_accsuffix where bureau_id ='"+city_id.trim()+"' and purpose ='"+purpose.trim()+"' and state ='1'";
  System.out.println("sufstr="+sufstr);
  
	String prestr="select distinct prefix,prefix from trm_adsl_accsuffix where bureau_id ='"+city_id.trim() +"' and purpose ='" + purpose.trim()+"'";
	prestr=prestr+" and suffix = ( select suffix from ("+sufstr+") where rownum=1)";
  System.out.println("prestr="+prestr);
  
	%>
<script>	
onload=function()
{ 
	var objTest="<%=object_id%>";
	if(objTest=='null'||objTest=='')alert("处理局传入值为空！");
	var proTest="<%=product_id.trim()%>";
	if(proTest=='null'||proTest=='')alert("主产品ID不能为空！");
	<%if(purpose.trim().equals("-1")&&seltype.trim().equals("0"))
	{%>
		rdShowMessageDialog("查询宽带用途失败",0);
	    window.close();
	<%}%>
	var seltype ="<%=seltype.trim()%>";
	document.all.conn_flag.value =seltype;
	if(seltype=="0")//虚拨
	{ 
		document.all.prefix.disabled=false;
		document.all.suffix.disabled=false;
		document.all.newaccount.readOnly=false;
		document.all.conn_flag.value="1";
		document.all.tbs1.style.display="";
		document.all.tbs2.style.display="none";
		document.all.tbs3.style.display="";
		document.all.tbs4.style.display="none";
		document.all.tbs5.style.display="";
		document.all.tbs6.style.display="none";

		document.all.r2.disabled=true;
		document.all.r1.checked=true;
	}
	else//专线
	{
		document.all.prefix.disabled=true;
	 	document.all.suffix.disabled=true;
	 	document.all.newaccount.readOnly=true;
		document.all.conn_flag.value="2";

		document.all.tbs1.style.display="none";
	 	document.all.tbs2.style.display="";
		document.all.tbs3.style.display="none";
	 	document.all.tbs4.style.display="";
	 	document.all.tbs5.style.display="none";
	 	document.all.tbs6.style.display="";

		document.all.r1.disabled=true;
		document.all.r2.checked=true;
	}
	
} 

function getallprefix()
{  
	var account ="";
	var prefix =document.all.hid_prefix.value;
	var suffix =document.all.hid_suffix.value;
	var conn_flag =document.all.conn_flag.value;
	if(document.all.select7.options.length > 0)      
	{      
		for(var i=0;i < document.all.select7.options.length;i++ )
		{      
			account = account+document.all.select7.options[i].text.trim()+"|";
		}      
	}      
	account = account+document.all.accountshow.value.trim()+"|";    
  document.all.hid_suffix.vlaue=document.all.suffix.options[document.all.suffix.selectedIndex].value;
	var tmp_suffix =document.all.suffix.options[document.all.suffix.selectedIndex].value;
	var myPacket = new AJAXPacket("getprefix.jsp","正在获得前缀信息，请稍候......");
	<%if(city_id.equals("04"))
	{%>
		var sqlStr =" select distinct prefix from trm_adsl_accsuffix where bureau_id ='"+<%=city_id%> +"' and purpose ='" +'<%=purpose.trim()%>' +"'"  ;
		if(tmp_suffix.length==0)
		{
			sqlStr=sqlStr+" and suffix is null";
		}
		else
		{
			sqlStr=sqlStr+" and suffix ='"+tmp_suffix+"'";
		}
	<%}
	else
	{%>
		var sqlStr =" select distinct prefix from trm_adsl_accsuffix where bureau_id ='"+'<%=city_id%>' +"' and purpose ='" +'<%=purpose.trim()%>'+"'";
		if(tmp_suffix.length==0)
		{
			sqlStr=sqlStr+" and suffix is null";
		}
		else
		{
			sqlStr=sqlStr+" and suffix ='"+tmp_suffix+"'";
		}
	<%}%>
	myPacket.data.add("retType","getprefix");
	myPacket.data.add("sqlStr",sqlStr);
	myPacket.data.add("account",account);
	myPacket.data.add("city_id","<%=city_id%>");
	myPacket.data.add("work_form_id","<%=order_id%>");
	myPacket.data.add("conn_flag",conn_flag);
	myPacket.data.add("branch_no","<%=branch_no%>");	
	myPacket.data.add("svc_inst_id","<%=svc_inst_id%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;	
}
function transValue()
{
	document.all.hid_account.value = document.all.select7.options[document.all.select7.selectedIndex].text.trim();
	document.all.accountshow.value =  document.all.select7.options[document.all.select7.selectedIndex].value.trim();
}
function qry_number()
{
	var NUM	= "";//号码串    
	if(document.all.select7.options.length > 0)      
	{      
		for(var i=0;i < document.all.select7.options.length;i++ )
		{      
			NUM = NUM+document.all.select7.options[i].text.trim()+"|";
		}      
	}      
	NUM = NUM+document.all.accountshow.value.trim()+"|";    
	var myPacket = new AJAXPacket("qry_number.jsp","正在获得号码信息，请稍候......");
	var prod_str="<%=product_id.trim()%>"+"|"+"<%=vasProds.trim()%>";
	var oldsuffix =document.all.hid_suffix.value;
	var oldprefix =document.all.hid_prefix.value;
	if(document.all.suffix.selectedIndex>-1)
		{
	    var suffix =document.all.suffix.options[document.all.suffix.selectedIndex].value;
	    var prefix =document.all.prefix.options[document.all.prefix.selectedIndex].value;
   }
	var conn_flag = document.all.conn_flag.value;
	document.all.accountshow.value="";
	myPacket.data.add("retType","getnum");
	myPacket.data.add("oldsuffix",oldsuffix);
	myPacket.data.add("oldprefix",oldprefix);
	myPacket.data.add("suffix",suffix);
	myPacket.data.add("prefix",prefix);
	myPacket.data.add("city_id","<%=city_id%>");
	myPacket.data.add("site_id","<%=site_id%>");
	myPacket.data.add("flag","2");
	myPacket.data.add("NUM",NUM);
	myPacket.data.add("purpose","<%=purpose%>");
	myPacket.data.add("work_form_id","<%=order_id%>");
	myPacket.data.add("conn_flag",conn_flag);
	myPacket.data.add("branch_no","<%=branch_no%>");
	myPacket.data.add("prod_id",prod_str);
	myPacket.data.add("staff_id","<%=staff_id%>");
	myPacket.data.add("svc_inst_id","<%=svc_inst_id%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;	
}
function autoselwideaccount()
{
	var myPacket = new AJAXPacket("selone.jsp","正在获取帐号信息，请稍候......"); 
	var prod_str="<%=product_id.trim()%>"+"|"+"<%=vasProds.trim()%>";
	var conn_flag=document.all.conn_flag.value;
	var tmp_account =document.all.hid_account.value;
	var tmp_prefix = document.all.hid_prefix.value;
	var tmp_suffix = document.all.hid_suffix.value;
	if(document.all.suffix.selectedIndex>-1)
		{
	    var tmp2_prefix = document.all.prefix.options[document.all.prefix.selectedIndex].value.trim(); 
	    var tmp2_suffix = document.all.suffix.options[document.all.suffix.selectedIndex].value.trim(); 
	  }
	myPacket.data.add("retType","getone");
	myPacket.data.add("account",tmp_account);
	myPacket.data.add("prefix",tmp_prefix);
	myPacket.data.add("suffix",tmp_suffix);
	myPacket.data.add("flag","1");
	myPacket.data.add("prefix2",tmp2_prefix);
	myPacket.data.add("suffix2",tmp2_suffix);
	myPacket.data.add("purpose","<%=purpose%>");
	myPacket.data.add("site_id",'<%=site_id%>');
	myPacket.data.add("city_id",'<%=city_id%>');
	myPacket.data.add("order_id",'<%=order_id%>');
	myPacket.data.add("conn_flag",conn_flag);
	myPacket.data.add("branch_no",'<%=branch_no%>');
	myPacket.data.add("prod_id",prod_str);
	myPacket.data.add("staff_id",'<%=staff_id%>');
    myPacket.data.add("svc_inst_id",'<%=svc_inst_id%>');
	core.ajax.sendPacket(myPacket);
	myPacket=null;	  
	
		var ret =document.all.accountshow.value+"~" +document.all.conn_flag.value+"~";
	window.returnValue = document.all.accountshow.value+"~" +document.all.conn_flag.value+"~";
	document.all.accountshow.value="";
	window.close();
}

function checkaccount()
{
 	var conn_flag =document.all.conn_flag.value;
	var NUM	= "";//号码串
	if(document.all.select7.options.length > 0)
	{
		for(var i=0;i < document.all.select7.options.length;i++ )
		{
			NUM = NUM+document.all.select7.options[i].text.trim()+"|";
		}
	}
	NUM=NUM+document.all.hid_account.value.trim();
	var myPacket = new AJAXPacket("cancelFreeNum.jsp","正在提交，请稍候......");
	myPacket.data.add("retType","quxiao");
	myPacket.data.add("account",NUM);
	myPacket.data.add("city_id","<%=city_id%>");
	myPacket.data.add("work_form_id","<%=order_id%>");
	myPacket.data.add("conn_flag",conn_flag);
	myPacket.data.add("svc_inst_id","<%=svc_inst_id%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
	
	var myPacket = new AJAXPacket("select_singleId.jsp","正在校验号码信息，请稍候......"); 
	if(document.all.suffix.selectedIndex>-1)
		{
	   var suffix =document.all.suffix.options[document.all.suffix.selectedIndex].value.trim();
    	var prefix =document.all.prefix.options[document.all.prefix.selectedIndex].value.trim(); 
    }
	var inputacc =document.all.newaccount.value.trim();
    var sqlStr ="select state from trm_adsl_account where bureau_id ='" +'<%=city_id%>' +"'  and  account = '" + inputacc + "'" ;
	myPacket.data.add("retType","checkacc");
	myPacket.data.add("sqlStr",sqlStr);
	core.ajax.sendPacket(myPacket);
	myPacket=null;	     
}
function changeprefix()
{
	document.all.hid_prefix.vlaue=document.all.prefix.options[document.all.prefix.selectedIndex].value;
}
function quxiao()
{
	var conn_flag =document.all.conn_flag.value;
	var NUM	= "";//号码串
	if(document.all.select7.options.length > 0)
	{
		for(var i=0;i < document.all.select7.options.length;i++ )
		{
			NUM = NUM+document.all.select7.options[i].text.trim()+"|";
		}
	}
	NUM=NUM+document.all.hid_account.value.trim();
	var myPacket = new AJAXPacket("cancelFreeNum.jsp","正在提交，请稍候......");
	myPacket.data.add("retType","quxiao");
	myPacket.data.add("account",NUM);
	myPacket.data.add("city_id","<%=city_id%>");
	myPacket.data.add("work_form_id","<%=order_id%>");
	myPacket.data.add("conn_flag",conn_flag);
	myPacket.data.add("svc_inst_id","<%=svc_inst_id%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
	window.close();
}
function choose()
{
	var conn_flag =document.all.conn_flag.value;
	var NUM	= "";//号码串
	var accountshow=document.all.accountshow.value;
	if(document.all.select7.options.length > 0)
	{
		for(var i=0;i < document.all.select7.options.length;i++ )
		{
			NUM = NUM+document.all.select7.options[i].text.trim()+"|";
		}
	}
	NUM=NUM+document.all.hid_account.value.trim();
	var lastaccount =document.all.accountshow.value;   	   
	var myPacket = new AJAXPacket("okFreeNum.jsp","正在提交，请稍候......");
	myPacket.data.add("retType","delNum");
	myPacket.data.add("account",NUM);
	myPacket.data.add("city_id","<%=city_id%>");
	myPacket.data.add("work_form_id","<%=order_id%>");
	myPacket.data.add("conn_flag",conn_flag);
	myPacket.data.add("staff_id","<%=staff_id%>");
	myPacket.data.add("lastaccount",lastaccount);
	myPacket.data.add("branch_no","<%=branch_no%>");
	myPacket.data.add("prod_id","<%=product_id%>");
	myPacket.data.add("svc_inst_id","<%=svc_inst_id%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
	document.all.select7.options.length=0;	
	var ret =document.all.accountshow.value+"~" +document.all.conn_flag.value+"~";
	//alert(ret+"[444444444444444444]")
	window.returnValue = document.all.accountshow.value+"~" +document.all.conn_flag.value+"~";
	document.all.accountshow.value="";
	window.close();
}
function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");	  
	self.status="";
    if(retType=="getnum")
    {   
		var retCode = packet.data.findValueByName("retCode");
		var retMsg =packet.data.findValueByName("retMessage");
		document.all.select7.options.length=0;
		if(retCode != "000000")
		{
			rdShowMessageDialog("读取号码失败！"+retMsg ,0);
	   		return false;
		}
		else
		{	
			var result = packet.data.findValueByName("mulit_list");
			for(var i=0;i<result.length&&i<20;i++)
			{
				document.all.select7.options.add(new Option(result[i][0],result[i][0])); 
			}
		}
	}	
	if(retType=="getprefix")
	{
	    document.all.hid_suffix.vlaue=document.all.suffix.options[document.all.suffix.selectedIndex].value;
	 	document.all.prefix.options.length=0;
		document.all.select7.options.length=0;
		var retCode1 = packet.data.findValueByName("retCode1");
		var retCode2 = packet.data.findValueByName("retCode2");
		if(retCode1 != "000000")
		{
			rdShowMessageDialog("释放号码失败！请与管理员联系。",0);
		}
	 	if(retCode2 != "000000")
		{
			rdShowMessageDialog("读取前缀失败！",0);
	   		return false;
		}
		else
		{	
			var result = packet.data.findValueByName("mulit_list");
			for(var i=0;i<result.length&&i<20;i++)
			{
			document.all.prefix.options.add(new Option(result[i][0],result[i][0])); 
			}
		}
	}	
	if(retType =="delNum")
	{
		document.all.select7.options.length=0;
		var retCode = packet.data.findValueByName("retCode"); 
		if(retCode!="000000")
		{
			rdShowMessageDialog("释放号码失败！请与管理员联系。",0);
	   	    return false;
		}  
	}
	if(retType =="quxiao")
	{
		document.all.select7.options.length=0;
		var retCode = packet.data.findValueByName("retCode");
		if(retCode!="000000")
		{
			rdShowMessageDialog("释放号码失败！请与管理员联系。",0);
	   	    return false;
		}   
	}
   	if(retType =="add")
	{
		var retCode = packet.data.findValueByName("retCode"); 
		if(retCode!="000000") 
		{
			rdShowMessageDialog("添加帐号错误！",0);
	   	    return false;
		} 
	}
   
	if(retType=="checkacc")
	{
	   var retCode = packet.data.findValueByName("retCode");
	   var retMsg =packet.data.findValueByName("retMessage");
	   if(retCode != "000000")
	   {
			rdShowMessageDialog(retMsg,0);
	   	    return false; 
	   }
	   var state = packet.data.findValueByName("retnewId");
	   var account = document.all.newaccount.value.trim();
	   if(document.all.suffix.selectedIndex>-1)
	   	{
	    var suffix =document.all.suffix.options[document.all.suffix.selectedIndex].value.trim();
		   var prefix =document.all.prefix.options[document.all.prefix.selectedIndex].value.trim(); 
		  }
	   if(state=="0")
	   {
	   	   var city_id="<%=city_id%>";
	   	   var purpose="<%=adsl_use%>";
		   var site_id="<%=site_id%>";
		   var staff_id="<%=staff_id%>";
		   var order_id="<%=order_id%>";
		   var conn_flag =document.all.conn_flag.value;	
			var myPacket = new AJAXPacket("fadd.jsp","正在获取帐号信息，请稍候......"); 
			myPacket.data.add("retType","add");
			myPacket.data.add("account",account);
			myPacket.data.add("prefix",prefix);
			myPacket.data.add("suffix",suffix);
			myPacket.data.add("flag","2");
			myPacket.data.add("purpose",<%=adsl_use%>);
			myPacket.data.add("site_id",<%=site_id%>);
			myPacket.data.add("city_id",'<%=city_id%>');
			myPacket.data.add("order_id",'<%=order_id%>');
			myPacket.data.add("staff_id",'<%=staff_id%>');
			myPacket.data.add("conn_flag",conn_flag);
			myPacket.data.add("lastaccount","");
			myPacket.data.add("branch_no",'<%=branch_no%>');
			myPacket.data.add("svc_inst_id",'<%=svc_inst_id%>');
			core.ajax.sendPacket(myPacket);
			myPacket=null;	
			document.all.accountshow.value=account;
			document.all.hid_account.value = account;
	   }
       else if (state=="05")
       	{
       	document.all.accountshow.value= account;
       	choose();	
       	}
       	else
	   {
			rdShowMessageDialog("帐号"+account+"已经被使用！",0);
	   	    return false;
	   } 

	 }  
     if(retType =="getone")
	 {
	   var retCode = packet.data.findValueByName("retCode");
	   var retMsg = packet.data.findValueByName("retMessage");
	   if(retCode != "000000")
	   {
			rdShowMessageDialog(retMsg,0);
	   	    return false; 
	   }
	   var onerow = packet.data.findValueByName("selonerow"); 	   
     document.all.hid_account.value = onerow[0][0];
	   document.all.hid_prefix.value = onerow[0][1];
	   document.all.hid_suffix.value = onerow[0][2];	   
	   document.all.accountshow.value = onerow[0][0];
	}
}
window.onbeforeunload=function LeaveWin()
{
	var conn_flag =document.all.conn_flag.value;
	var NUM	= "";//号码串
	if(document.all.select7.options.length > 0)
	{
		for(var i=0;i < document.all.select7.options.length;i++ )
		{
			NUM = NUM+document.all.select7.options[i].text.trim()+"|";
		}
	NUM=NUM+document.all.accountshow.value.trim();
	var myPacket = new AJAXPacket("cancelFreeNum.jsp","正在提交，请稍候......");
	myPacket.data.add("retType","quxiao");
	myPacket.data.add("account",NUM);
	myPacket.data.add("city_id","<%=city_id%>");
	myPacket.data.add("work_form_id","<%=order_id%>");
	myPacket.data.add("conn_flag",conn_flag);
	myPacket.data.add("svc_inst_id","<%=svc_inst_id%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
	}
	if(!window.returnValue) window.returnValue="";
}
</script>
<body>
		<div id="operation">
			<form action="" name="aa" method="post" id="frm1100">
				<%@ include file="/npage/include/header_pop.jsp"%>
				<div id="operation_table">
							<div class="input">	
					<table id="tabCustInfoQry">
						<tr>
							<td colspan="2">
								<div class="title"><div class="text">
    	            接入方式
    	          </div></div>
    	            </td>
            <td width="50%" rowspan="8"  align="justify"  valign="middle" bordercolor="eeeeee" ><select name="select7" multiple="multiple" size="7" style="font-size:30px;color:blue;width:100%"  onChange="transValue()" >
            </select></td>
          </tr>
          <tr>
            <td colspan="2" >
              <input id="r1" type="radio" name="radiobutton" value="rb_1">
              虚拨接入
            </td>
          </tr>
          <tr>
            <td colspan="2" >
              <input id="r2"  type="radio" name="radiobutton" value="rb_2">
              专线接入
            </td>
          </tr>
          <tr>
            <td height="22" colspan="2" >
              <div id="tbs5" style="display:block">帐号选号信息</div>
              <div id="tbs6" style="display:none">专线选号信息</div>
             </td>
          </tr>
          <tr>
            <td width="12%" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;后缀</td>
            <td width="38%">
              <select name="suffix" style="width:100px"  onChange="getallprefix()" >
              <!--  <option value="">--请选择--</option>  -->
                <wtc:qoption name="sPubSelect" outnum="2">
                  <wtc:sql>
		         <%=sufstr%>
             </wtc:sql>
                </wtc:qoption>
              </select>
            </td>
          </tr>
          <tr>
            <td align="right" width="12%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;前缀</td>
            <td width="38%">
              <select name="prefix" style="width:100px" onChange="changeprefix()" >
            <!--  <option value="">--请选择--</option>   -->
                <wtc:qoption name="sPubSelect" outnum="2">
                  <wtc:sql>
		               <%=prestr%>
                 </wtc:sql>
                </wtc:qoption>
                </select>
            </td>
          </tr>
          <tr>
            <td align="right" width="12%">
            	<div id="tbs1" style=display="">&nbsp;&nbsp;手输帐号 </div>
              <div id="tbs2" style=display="none">手输专线号 </div></td>
            <td width="38%">
              <input type="text" name="newaccount" value="" onKeyDown="if(event.keyCode==13) checkaccount()" > <label style="color:red">(输入结束请按回车)</label>
            </td>
          </tr>
          <tr>
            <td align="right" width="12%"><div id="tbs3" style=display="">&nbsp;&nbsp;帐号展示</div>
              <div id="tbs4" style=display="none">专线号展示</div></td>
            <td width="38%">
              <input type="text" name="accountshow" value="" readOnly="true">
            </td>
          </tr>
					</table>
					<div>		
				</div>
	<div id="operation_button">
        <input name="getoneacc" type="button" class="b_foot_long" value="随机选号" onClick="autoselwideaccount()">
        &nbsp;
        <input name="qry_num" type="button" class="b_foot" value="查&nbsp;询" onClick="qry_number()">
        &nbsp;
        <input name="sel_num" type="button" class="b_foot" value="确&nbsp;定"  onClick="choose()">
        &nbsp;
        <input name="cancel" type="button" class="b_foot" value="取&nbsp;消"  onClick="quxiao()" >
        <input type="hidden" name="hid_prefix" value="">
        <input type="hidden" name="hid_suffix" value="">
        <input type="hidden" name="hid_account" value="">
        <input type="hidden" name="conn_flag" value="">
      </div>
				<%@ include file="/npage/include/footer.jsp"%>    
  </form>
</div>
</body>
</html>

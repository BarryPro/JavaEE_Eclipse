<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 赠送预存款 8379
   * 版本: 1.0
   * 日期: 2010/3/12
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投诉退费统计查询</title>
<%
  //String opCode="8379";
 //String opName="赠送预存款";

    String opCode="zg87";
	String opName="积分计算要素管理";	
 
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	String contextPath = request.getContextPath();
%>
<%
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
	
  String[] inParas2 = new String[1];
  inParas2[0]="select distinct rule_id from act_markcompute_conf";
%>
<!--    routerKey="region" routerValue="<%=regionCode%>" -->
 
	<wtc:service name="TlsPubSelBoss"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=inParas2[0]%>"/>
	</wtc:service>
	<wtc:array id="SpecResult" scope="end" /> 
 
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>  
<body onload="inits()">
<form action="" name="frm" method="POST">
 	<input type="hidden" name="opcode" value = "zg87" >
	<input type="hidden" name="opname" value = "积分计算要素管理" >
	<%@ include file="/npage/include/header.jsp" %>
  
<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">积分计算要素管理</div>
</div>	 
	
	               <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue" width="15%">配置方式</td>
                  <td colspan="3"> 
                  	<q vType="setNg35Attr">
                    <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" >
                    查询 
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel2()" value="2"  >
                    增加
                    </q>
		<q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel3()" value="3"  >
                    删除
                    </q>
		<q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel4()" value="4"  checked>
                    修改
                    </q>
                  </tr>   
                </tbody> 
              </table>


	<table cellspacing="0" id="tabList">
			<tr> 
			  <td class="blue">地市信息</td>
				<td class="blue">	<select name="dsxx" id="dsxxId" >
					<option value="00">全省</option>
				</select>

			   </td>            
			<td class="blue">品牌信息</td>
			<td class="blue">
			<select name="ppxx" id="pxxxId" >
					<option value="111" selected>所有品牌</option>
					<option value="100" >动感地带</option>
					<option value="010" >全球通</option>
					<option value="001" >神州行</option>
					<option value="110" >动感地带/全球通</option>
					<option value="101" >动感地带/神州行</option>
					<option value="011" >全球通/神州行</option>
					<option value="000" >所有品牌均不支持</option>				
				</select>

				</td>
			</tr> 
			<!--计算要素-->
			<tr> 
			<td class="blue">计算要素</td>
			<td class="blue">	
				<select id=jsysId name=jsys onChange="chkJfys(this,ys,ys_value)" >
					<option value="0" selected>---请选择</option>
					<option value="CON_TYPE" >消费积分</option>
					<option value="ON_LINE">网龄积分</option>
					<option value="VIP_TYPE">VIP类型</option>
					<option value="BILL_TYPE">星级积分</option>
				</select>

			</td>            
			<td class="blue">计算要素值</td>
			<td class="blue">
				<select name="jsysz" id="jsyszId" >
				</select>	
			</td>
    		 	</tr>
			<!--end of 计算要素-->
			<!--以下的值查询时均不需要 可以隐藏 begin-->
			<tr style="display:block" id="wlinfo_id"> 
			  <td class="blue">网龄配置最大值</td>
				<td class="blue">	
					<input type="text" name="wl_max" onKeyPress="return isKeyNumberdot(0)">
			  </td>            
			  <td class="blue">网龄配置最小值</td>
				<td class="blue">	
					<input type="text" name="wl_min" onKeyPress="return isKeyNumberdot(0)">
			  </td>  
			</tr>
			 
			<tr style="display:block" id="jfbl_id"> 
			  <td class="blue">积分类型</td>
				<td class="blue">	
					<select name="jflx" id="jflxId" >
						<option value="C" selected>消费积分</option>
						<option value="I">网龄积分</option>
					</select>

				</td> 
			  <td class="blue">积分计划名称</td>
				<td class="blue">
					<select name="jfjhmc" class="button"">
	            	<%for(int i = 0 ; i < SpecResult.length ; i ++){%>
						<option value="<%=SpecResult[i][0]%>"><%=SpecResult[i][0]%></option>
					<%}%>
	            </select>
				</td>
				 
			</tr>
			<!--end of 隐藏的值-->
		 
		<tr >
			<td align=center colspan=4><input type=button class="b_foot" name="check2" value="查询" id="cz" onclick="docfm()" >
			<!--
			<input type=button class="b_foot" value="生成报表" onclick="printTable(tabList)" >
			-->
			
			<input type=reset class="b_foot" value="重置" >
			</td>
		<tr>
		</tr>
		
	</table>
</div>
 
 
 
</table>
 
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
 	//定义全局变量
  	var ys = new Array();
         var ys_value = new Array();
	function inits()
	{
		document.getElementById("wlinfo_id").style.display="none";
	}
	function chkJfys(choose,ItemArray,GroupArray)
    {
		//alert("1");
		//先清空处理second 
		//alert("?"+document.all.jsysz.options.length);  
		
		//alert("已经removed");
		//获取选择的值   
		var selectedValue = document.all.jsysz.value;   
		//var selectedText = document.all.jsysz[document.all.jsysz.selectedIndex].text;   
		//判断积分要素的值
		var jsys_new = document.all.jsys[document.all.jsys.selectedIndex].value;
		//wlinfo_id默认不展示 其实查询的时候根本就不展示
		document.getElementById("wlinfo_id").style.display="none";
		if(jsys_new=="0")
		{
			rdShowMessageDialog("请选择计算要素类型!");
		} 
		else
		{
			//alert("4");
			/*
			CON_TYPE-消费积分(计算要素值=1)
			ON_LINE-网龄积分'才显示6.7最大值、最小值, 计算要素值是空
			VIP_TYPE-VIP类型( 0-非VIP,1-是VIP)
			BILL_TYPE-星级积分(计算要素值：0-5)
			*/
			//document.all.sxzt.disabled=false;
			//document.all.sxzt.options[0].selected = true;
			if(jsys_new=="CON_TYPE")
			{
				document.getElementById("jsyszId").innerHTML="";
				var newItem = new Option("计算要素值=1","1"); 
				document.all.jsysz.options.add(newItem);   
			}
			else if(jsys_new=="ON_LINE")//网龄积分 wlinfo_id展示
			{
				document.getElementById("jsyszId").innerHTML="";
				var newItem = new Option("计算要素值=空","");  
				document.all.jsysz.options.add(newItem);
				document.getElementById("wlinfo_id").style.display="block";
			}
			else if(jsys_new=="VIP_TYPE")
			{
				document.getElementById("jsyszId").innerHTML="";
				//new begin
				var newItem =new Array();
				newItem[0] = new Option("非VIP","0");
				newItem[1] = new Option("VIP","1");
				for(var i=0;i<2;i++)
				{
					var obj  = document.all.jsysz.options;
					//alert(obj+" and newItem is "+newItem[i].text);
					obj.add(newItem[i]);
					//newItem[0] = new Option("非VIP","0");
					//newItem[1] = new Option("VIP","1");
				}		

				//new end
				/*
				var newItem = new Option("非VIP","0");
				var newItem1 = new Option("VIP","1");
				document.all.jsysz.options.add(newItem); 
				document.all.jsysz.options.add(newItem1);
				*/
				//sxzt只能是失效 document.getElementById("Select"+rowID).options[index].selected=true; 
				//document.all.sxzt.options[1].selected = true;
				//document.all.sxzt.disabled=true;
			}
			else if(jsys_new=="BILL_TYPE")
			{
				document.getElementById("jsyszId").innerHTML="";
				var newItem0 = new Option("0星级","0");
				var newItem1 = new Option("1星级","1");
				var newItem2 = new Option("2星级","2");
				var newItem3 = new Option("3星级","3");
				var newItem4 = new Option("4星级","4");
				var newItem5 = new Option("5星级","5");
				document.all.jsysz.options.add(newItem0); 
				document.all.jsysz.options.add(newItem1);  
				document.all.jsysz.options.add(newItem2);
				document.all.jsysz.options.add(newItem3);
				document.all.jsysz.options.add(newItem4);
				document.all.jsysz.options.add(newItem5);	   
			}

			  

		}
	}
	 
 
	function docfm()
	{
		//var ThirdClass_new = 
		var jsys_id = document.all.jsys[document.all.jsys.selectedIndex].value;
		var jfjhmc =  document.all.jfjhmc[document.all.jfjhmc.selectedIndex].value;// document.all.jfjhmc.value;
		//var shengxiao_time = document.all.shengxiao_time.value;
		//var shixiao_time = document.all.shixiao_time.value;
		if(jsys_id=="0")
		{
			rdShowMessageDialog("请选择计算要素!");
			return false;
		}	
		
		else if (jsys_id=="ON_LINE" && (document.all.wl_max.value=="" || document.all.wl_min.value==""))//网龄积分 最大最小值非空
		{
			rdShowMessageDialog("网龄积分请输入配置的最大值和最小值!");
			return false;
		}
		
		else
		{
			var actions = "zg87_update_qry.jsp";
			document.all.frm.action=actions;
			document.all.frm.submit();	
		}
	}
         function sel1()
         {
              window.location.href='zg87_1.jsp';
         }
         function sel2()
         {
              window.location.href='zg87_add.jsp';
         }
	function sel3()
         {
              window.location.href='zg87_del.jsp';
         }
	function sel4()
         {
              window.location.href='zg87_update.jsp';
         }
function fPopUpCalendarDlg(ctrlobj)
{
	showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
	showy = event.screenY - event.offsetY + 18; // + deltaY;
	newWINwidth = 210 + 4 + 18;
	retval = window.showModalDialog("/js/common/date/CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
	if(retval != null)
	{
		ctrlobj.value = retval;
	}
	else
	{
		//alert("canceled");
	}
}

</script>
 
 
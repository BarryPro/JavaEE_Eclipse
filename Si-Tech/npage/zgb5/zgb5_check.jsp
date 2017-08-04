<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
 <%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
 <%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>

<%@ page import="java.util.*"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
    String opCode = "zgb5";
    String opName = "离网交费信息查询";
    String phoneNo = request.getParameter("phoneNo");
	String count = request.getParameter("contractNo");
	String cust_name = request.getParameter("cust_name");
    String otherFlag = "0";//按号码查询	
	String beginTime = request.getParameter("begin_ym");
	String endTime = request.getParameter("end_ym");
	String rwsj = request.getParameter("rwsj");
	String id_no = request.getParameter("id_no");

    String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code = org_code.substring(0,2);
	String busy_name="";
     
 
	String op_code = "zgb5";
	busy_name="交费信息";
	// tianyang 修改 20090818
	//ArrayList arlist = new ArrayList();
	String inParas[] = new String[7];
	inParas[0] = phoneNo;
	inParas[1] = count;
	inParas[2] = beginTime;
	inParas[3] = beginTime ;
	inParas[4] = otherFlag;
	inParas[5] = region_code;
	inParas[6] = "2";      //0 在网, 1 离网 2=zhaoyanyan需求
System.out.println("inParas[0]==="+inParas[0]);
System.out.println("inParas[1]==="+inParas[1]);
System.out.println("inParas[2]==="+inParas[2]);
System.out.println("inParas[3]==="+inParas[3]);
System.out.println("inParas[4]==="+inParas[4]);
System.out.println("inParas[5]==="+inParas[5]);
System.out.println("inParas[6]==="+inParas[6]);
 
%>
 

 
 
 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript">
	function check_jl()
	{
		//得把按钮置为不可用状态
		var objSel = document.getElementById("jyid").value;
		//alert(objSel);
		if(objSel=="0")
		{
			rdShowMessageDialog("请选择校验内容!");
			return false;
		}
		else if(objSel=="1")// khxmid jfjlid jffpjlid 
		{
			document.getElementById("rwsjid").style.display="block";
			document.getElementById("simid").style.display="none";
			document.getElementById("khxmid").style.display="none";
			document.getElementById("jfjlid").style.display="none";
			document.getElementById("jffpjlid").style.display="none";
		}
		else if(objSel=="2")
		{
			document.getElementById("simid").style.display="block";
			document.getElementById("rwsjid").style.display="none";
			document.getElementById("khxmid").style.display="none";
			document.getElementById("jfjlid").style.display="none";
			document.getElementById("jffpjlid").style.display="none";
		}
		else if(objSel=="3")
		{
			document.getElementById("khxmid").style.display="block";
			document.getElementById("rwsjid").style.display="none";
			document.getElementById("simid").style.display="none";
			document.getElementById("jfjlid").style.display="none";
			document.getElementById("jffpjlid").style.display="none";
		}
		else if(objSel=="4")
		{
			document.getElementById("jfjlid").style.display="block";
			document.getElementById("wpayjg").style.display="block";
			document.getElementById("rwsjid").style.display="none";
			document.getElementById("simid").style.display="none";
			document.getElementById("khxmid").style.display="none";
			document.getElementById("jffpjlid").style.display="none";
			document.form.sure.disabled=true;
		}
		else if(objSel=="5")
		{
			document.getElementById("jffpjlid").style.display="block";
			document.getElementById("wpayjg").style.display="none";
			document.getElementById("rwsjid").style.display="none";
			document.getElementById("simid").style.display="none";
			document.getElementById("khxmid").style.display="none";
			document.getElementById("jfjlid").style.display="none";
			document.all.s_fpjl.checked=false;
			document.form.sure.disabled=true;
		}
	}
	function inits()
	{
		document.getElementById("wpayjg").style.display="none";
		//document.getElementById("Operation_Table").style.display="none";
		
		document.getElementById("rwsjid").style.display="none";
		document.getElementById("simid").style.display="none";
		document.getElementById("rwsjid").style.display="none";
		document.getElementById("khxmid").style.display="none";
		document.getElementById("jfjlid").style.display="none";
		document.getElementById("jffpjlid").style.display="none";
		document.form.sure.disabled=true;
	}	
	function checks()
	{
		//根据入口不同 调用不同的sql
		var objSel = document.getElementById("jyid").value;
		var check_value =""; //用不到
		var rwsj = document.all.rwsj.value;
		var sim_vlaue = document.all.sim.value;
		var khxm = document.all.khxm.value;
		//
		var jftime = document.all.jftime.value;
		var jfje   = document.all.jfje.value;
		if(objSel=="0")
		{
			rdShowMessageDialog("请输入校验信息!");
			return false;
		}
		else
		{
			
			if(rwsj=="" &&objSel=="1")
			{
				rdShowMessageDialog("请输入入网时间!");
				return false;
			}
			else if(sim_vlaue=="" &&objSel=="2")
			{
				rdShowMessageDialog("请输入SIM卡信息!");
				return false;
			}
			else if(khxm=="" &&objSel=="3")
			{
				rdShowMessageDialog("请输入客户姓名!");
				return false;
			}
			else if((jftime=="" ||jfje=="") &&objSel=="4")
			{
				rdShowMessageDialog("请输入缴费时间、缴费金额!");
				return false;
			}
			else
			{
				if(objSel!="2")//非SIM卡的 调用boss
				{
					var myPacket = new AJAXPacket("szgb5_jy.jsp","正在提交，请稍候......");
					myPacket.data.add("objSel",objSel);//传入
					myPacket.data.add("rwsj",rwsj);
					myPacket.data.add("sim_vlaue",sim_vlaue);
					myPacket.data.add("khxm",khxm);
					myPacket.data.add("phoneNo","<%=phoneNo%>");
					myPacket.data.add("id_no","<%=id_no%>");
					myPacket.data.add("coutract_no","<%=count%>");
					//传入时间 金额 
					myPacket.data.add("jftime",jftime);
					myPacket.data.add("jfje",jfje);
					myPacket.data.add("ym",jftime.substring(0,6));
					//alert(objSel);
					core.ajax.sendPacket(myPacket,getCheck);
					myPacket=null;
				}
				else
				{
					var myPacket = new AJAXPacket("szgb5_jyCrm.jsp","正在提交，请稍候......");
					myPacket.data.add("objSel",objSel);//传入
					myPacket.data.add("rwsj",rwsj);
					myPacket.data.add("sim_vlaue",sim_vlaue);
					myPacket.data.add("khxm",khxm);
					myPacket.data.add("phoneNo","<%=phoneNo%>");
					myPacket.data.add("id_no","<%=id_no%>");
					//alert(objSel);
					core.ajax.sendPacket(myPacket,getCheckCrm);
					myPacket=null;
				}
				
				
			}
		}
	}
	function getCheck(packet)
	{
		//alert("ok~");
		var s_flag=packet.data.findValueByName("s_flag");
		//alert("s_flag is "+s_flag);
		if(s_flag=="0")
		{
			document.form.sure.disabled=false;
		}
		else
		{
			rdShowMessageDialog("校验不通过!");
			document.form.sure.disabled=true;
			return false;
		}

	}
	function getCheckCrm(packet)
	{
		var s_flag=packet.data.findValueByName("s_flag");
		//alert("s_flag is "+s_flag);
		if(s_flag=="0")
		{
			document.form.sure.disabled=false;
		}
		else
		{
			rdShowMessageDialog("校验不通过!");
			if(document.all.s_simjl.checked)
			{
				document.all.s_simjl.checked=false;
			}
			document.form.sure.disabled=true;
			return false;
		}
	}
	function tt_sim()
	{
		var sim_vlaue = document.all.sim.value;
		if(sim_vlaue=="")
		{
			rdShowMessageDialog("请输入SIM卡号!");
			document.all.s_simjl.checked=false;
			return false;
		}
		else
		{
			//ajax调用
			var myPacket = new AJAXPacket("szgb5_jyCrm.jsp","正在提交，请稍候......");
			myPacket.data.add("sim_vlaue",sim_vlaue);
			myPacket.data.add("phoneNo","<%=phoneNo%>");
			myPacket.data.add("id_no","<%=id_no%>");
			//alert("<%=id_no%>");
			core.ajax.sendPacket(myPacket,getCheckCrm);
			myPacket=null;
			/*
			if(document.all.s_simjl.checked)
			{
				document.form.sure.disabled=false;
			}
			else
			{
				document.form.sure.disabled=true;
			}
			*/
		}
		
		
	}
	function tt()
	{
		var fphm=document.all.fphm.value;
		var fpdm=document.all.fpdm.value;
		if(fphm=="" ||fpdm=="")
		{
			rdShowMessageDialog("请输入发票号码和发票代码!");
			document.all.s_fpjl.checked=false;
			return false;
		}
		else
		{
			if(document.all.s_fpjl.checked)
			{
				document.form.sure.disabled=false;
			}
			else
			{
				document.form.sure.disabled=true;
			}
		}
		
		
	}
	function checksjf(sj,je,i)
	{
		var s_sj = document.getElementById("jfsj"+i).value;
		var s_je = document.getElementById("jiaofeije"+i).value;
		s_je = formatAsMoney(s_je);
		//alert("check~~ sj js "+sj+" and je is "+je+" and i is "+i+" and s_sj is "+s_sj+" and s_je is "+s_je );
		//一条记录的还得单独处理 造个数据试试
		if(s_sj==sj && s_je==je)
		{
			document.all.sj_name.value=s_sj;
			document.all.je_name.value=s_je;
			document.form.sure.disabled=false;
		}
		else
		{
			rdShowMessageDialog("校验不通过!");
			document.form.sure.disabled=true;
		}

	}

</script>


<title>交费信息查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>

<BODY onload="inits()">
<FORM action=" " method="post" name="form"  >
<%@ include file="/npage/include/header.jsp" %>
 
<input type="hidden" name="Op_Code"  value="zgb5">
<div id="Operation_Table">

        
</div>        

<!--校验区---->
<div id="shows">
<table cellspacing="0">
	<tr>
		<td>校验条件</td>
		<td>
			<select name="jy" id="jyid" onChange="check_jl()">
				<option value="0">---请选择---</option>
				<!--
				<option value="1">入网时间</option>
				<option value="2">SIM卡信息</option>
				<option value="3">客户姓名</option>
				
				<option value="4">缴费记录</option>
				-->
				<option value="2">SIM卡信息</option>
				<option value="5">缴费发票记录</option>
			</select>
			<!--
			<input type="button" name="check1" class="b_foot" value="校验" onclick="checks()">
			-->
		</td>
	</tr>
	 
	<tr id="rwsjid">
		<td class="blue">入网时间</td>
		<td class="blue" colspan="3">			
			<input type="text" name="rwsj">
		</td>
		
	</tr>
	<tr id="simid">
		<td class="blue">SIM卡信息</td>
		<td class="blue" colspan="3">			
			<input type="text" name="sim"><input type="checkbox" name="s_simjl" onclick="tt_sim()">校验
		</td>
	</tr>
	<tr id="khxmid">
		<td class="blue">客户姓名</td>
		<td class="blue" colspan="3">			
			<input type="text" name="khxm">
		</td>
	</tr>
	<tr id="jfjlid">
		<!--
		<td class="blue">缴费记录</td>
		
		<td  colspan="3">			
			缴费时间<input type="text" name="jftime">(YYYYMMDD)
			 
			缴费金额<input type="text" name="jfje">
		</td>
		-->
	</tr>
	<tr id="jffpjlid">
		<td class="blue">缴费发票记录</td>
		<td class="blue" colspan="3">			
			请营业员确认缴费发票是否正确后并留存。<input type="checkbox" name="s_fpjl" onclick="tt()">校验
			<p>
			发票号码:<input type="text" name="fphm">
			<p>
			发票代码:<input type="text" name="fpdm">
		</td>
	</tr>
</table>

	   <table cellspacing="0">
	     <tr id="footer">
           <TD nowrap colspan="8"> 
               <input type="button" name="sure" class="b_foot" value="确认" onClick="docfm()">
			   <input type="button" name="return" class="b_foot" value="返回" onClick="window.history.go(-1)">
               <input type="button" name="return" class="b_foot" value="关闭" onClick="removeCurrentTab()">
           </TD>
         </TR>
        </table>
<%@ include file="/npage/include/footer.jsp" %>
</div>
<div id="wpayjg">
		<div class="title">
			<div id="title_zi">缴费记录查询结果</div>
		</div>
		<table cellspacing="0" vColorTr='set'>
          
		  
           
		  <input type="hidden" name="sj_name">
		  <input type="hidden" name="je_name">
        </table>
		</div>
</Form>
 
</body>
</html>
<script language="javascript">
	function docfm()
	{
		//var objSel = document.getElementById("jyid").value;
		//alert(objSel);
		/*
		var checkbox = document.getElementsByName("box"); 
		 
		var j = 0;  
		for(var i=0;i<checkbox.length;i++)
		{      
			if(checkbox[i].checked)
			{          
				j++;      
			}
		}
		if(j>=1)
		{
			document.form.action="zgb5_select.jsp?phoneno="+"<%=phoneNo%>"+"&contractno="+"<%=count%>";
			document.form.submit();
		}
		else
		{
			rdShowMessageDialog("校验不通过!");
			return false;
		}*/
		//加入 营业员点选的校验条件
		var sj_name = document.all.sj_name.value;
		var je_name = document.all.je_name.value;
		//加入sim信息
		var sim_vlaue = document.all.sim.value;
		var fphm = document.all.fphm.value; 
		var fpdm = document.all.fpdm.value; 
		var ThirdClass_new = document.all.jy[document.all.jy.selectedIndex].value;
		//alert("ThirdClass_new is "+objSel.value);
		//document.form.action="zgb5_select.jsp?phoneno="+"<%=phoneNo%>"+"&contractno="+"<%=count%>"+"&selectValue="+ThirdClass_new+"&sj_name="+sj_name+"&je_name="+je_name+"&fphm="+fphm+"&fpdm="+fpdm;
		document.form.action="zgb5_select.jsp?phoneno="+"<%=phoneNo%>"+"&contractno="+"<%=count%>"+"&selectValue="+ThirdClass_new+"&sim_vlaue="+sim_vlaue+"&fphm="+fphm+"&fpdm="+fpdm;
		document.form.submit();
	}
</script>
 

 

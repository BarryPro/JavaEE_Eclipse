<%
/********************
 * version v2.0
 * ������: si-tech
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
    String opCode = "zgb6";
    String opName = "����������Ϣ��ѯ";
    String phoneNo = request.getParameter("phoneNo");
	String count = request.getParameter("contractNo");
	String cust_name = request.getParameter("cust_name");
    String otherFlag = "0";//�������ѯ	
	String beginTime = request.getParameter("begin_ym");
	String endTime = request.getParameter("end_ym");
	String rwsj = request.getParameter("rwsj");
	String id_no = request.getParameter("id_no");

    String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code = org_code.substring(0,2);
	String busy_name="";
    String user_passwd=  request.getParameter("user_passwd");
 
	String op_code = "zgb6";
	busy_name="������Ϣ";
	// tianyang �޸� 20090818
	//ArrayList arlist = new ArrayList();
	String inParas[] = new String[7];
	inParas[0] = phoneNo;
	inParas[1] = count;
	inParas[2] = beginTime;
	inParas[3] = beginTime ;
	inParas[4] = otherFlag;
	inParas[5] = region_code;
	inParas[6] = "2";      //0 ����, 1 ���� 2=zhaoyanyan����
System.out.println("inParas[0]==="+inParas[0]);
System.out.println("inParas[1]==="+inParas[1]);
System.out.println("inParas[2]==="+inParas[2]);
System.out.println("inParas[3]==="+inParas[3]);
System.out.println("inParas[4]==="+inParas[4]);
System.out.println("inParas[5]==="+inParas[5]);
System.out.println("inParas[6]==="+inParas[6]);
	//String outNum="17";
	//int[] lens={17,13,3};
	//HashMap map = new HashMap();
	//map.put("0" , "000000"); 	 
	//ScallSvrViewBean viewBean = new ScallSvrViewBean();//ʵ����viewBean
	//CallRemoteResultValue value=  viewBean.callService("0",null,"sConMoreQry",outNum,lens, inParas,map);	
%>
  
 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript">
	function check_jl()
	{
		var objSel = document.getElementById("jyid").value;
		//alert(objSel);
		if(objSel=="0")
		{
			rdShowMessageDialog("��ѡ��У������!");
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
			document.getElementById("wpayjg").style.display="block";
			document.getElementById("jfjlid").style.display="block";
			document.getElementById("rwsjid").style.display="none";
			document.getElementById("simid").style.display="none";
			document.getElementById("khxmid").style.display="none";
			document.getElementById("jffpjlid").style.display="none";
		}
		else if(objSel=="5")
		{
			document.getElementById("wpayjg").style.display="none";
			document.getElementById("jffpjlid").style.display="block";
			document.getElementById("rwsjid").style.display="none";
			document.getElementById("simid").style.display="none";
			document.getElementById("khxmid").style.display="none";
			document.getElementById("jfjlid").style.display="none";
		}
	}
	function inits()
	{
		document.getElementById("wpayjg").style.display="none";
		document.getElementById("rwsjid").style.display="none";
		document.getElementById("simid").style.display="none";
		document.getElementById("rwsjid").style.display="none";
		document.getElementById("khxmid").style.display="none";
		document.getElementById("jfjlid").style.display="none";
		document.getElementById("jffpjlid").style.display="none";
		document.form.dosuer.disabled=true;
	}
	function checks()
	{
		//������ڲ�ͬ ���ò�ͬ��sql
		var objSel = document.getElementById("jyid").value;
		var check_value =""; //�ò���
		var rwsj = document.all.rwsj.value;
		var sim_vlaue = document.all.sim.value;
		var khxm = document.all.khxm.value;
		//
		var jftime = document.all.jftime.value;
		var jfje   = document.all.jfje.value;
		if(objSel=="0")
		{
			rdShowMessageDialog("������У����Ϣ!");
			return false;
		}
		else
		{
			
			if(rwsj=="" &&objSel=="1")
			{
				rdShowMessageDialog("����������ʱ��!");
				return false;
			}
			else if(sim_vlaue=="" &&objSel=="2")
			{
				rdShowMessageDialog("������SIM����Ϣ!");
				return false;
			}
			else if(khxm=="" &&objSel=="3")
			{
				rdShowMessageDialog("������ͻ�����!");
				return false;
			}
			else if((jftime=="" ||jfje=="") &&objSel=="4")
			{
				rdShowMessageDialog("������ɷ�ʱ�䡢�ɷѽ��!");
				return false;
			}
			else
			{
				if(objSel!="2")//��SIM���� ����boss
				{
					var myPacket = new AJAXPacket("../zgb5/szgb5_jy.jsp","�����ύ�����Ժ�......");
					myPacket.data.add("objSel",objSel);//����
					myPacket.data.add("rwsj",rwsj);
					myPacket.data.add("sim_vlaue",sim_vlaue);
					myPacket.data.add("khxm",khxm);
					myPacket.data.add("phoneNo","<%=phoneNo%>");
					myPacket.data.add("id_no","<%=id_no%>");
					myPacket.data.add("coutract_no","<%=count%>");
					//����ʱ�� ��� 
					myPacket.data.add("jftime",jftime);
					myPacket.data.add("jfje",jfje);
					myPacket.data.add("ym",jftime.substring(0,6));
					//alert(objSel);
					core.ajax.sendPacket(myPacket,getCheck);
					myPacket=null;
				}
				else
				{
					var myPacket = new AJAXPacket("../zgb5/szgb5_jyCrm.jsp","�����ύ�����Ժ�......");
					myPacket.data.add("objSel",objSel);//����
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
			document.form.dosuer.disabled=false;
		}
		else
		{
			rdShowMessageDialog("У�鲻ͨ��!");
			document.form.dosuer.disabled=true;
			return false;
		}

	}
	function getCheckCrm(packet)
	{
		var s_flag=packet.data.findValueByName("s_flag");
		//alert("s_flag is "+s_flag);
		if(s_flag=="0")
		{
			document.form.dosuer.disabled=false;
		}
		else
		{
			rdShowMessageDialog("У�鲻ͨ��!");
			if(document.all.s_simjl.checked)
			{
				document.all.s_simjl.checked=false;
			}
			document.form.dosuer.disabled=true;
			return false;
		}
	}
	function tt()
	{
		var fphm=document.all.fphm.value;
		var fpdm=document.all.fpdm.value;
		if(fphm=="" ||fpdm=="")
		{
			rdShowMessageDialog("�����뷢Ʊ����ͷ�Ʊ����!");
			document.all.s_fpjl.checked=false;
			return false;
		}
		else
		{
			if(document.all.s_fpjl.checked)
			{
				document.form.dosuer.disabled=false;
			}
			else
			{
				document.form.dosuer.disabled=true;
			}
		}
		
		
	} 
	function checksjf(sj,je,i)
	{
		var s_sj = document.getElementById("jfsj"+i).value;
		var s_je = document.getElementById("jiaofeije"+i).value;
		s_je = formatAsMoney(s_je);
		//alert("check~~ sj js "+sj+" and je is "+je+" and i is "+i+" and s_sj is "+s_sj+" and s_je is "+s_je );
		//һ����¼�Ļ��õ������� �����������
		if(s_sj==sj && s_je==je)
		{
			document.all.sj_name.value=s_sj;
			document.all.je_name.value=s_je;
			document.form.dosuer.disabled=false;
		}
		else
		{
			rdShowMessageDialog("У�鲻ͨ��!");
			document.form.dosuer.disabled=true;
		}

	}
	function tt_sim()
	{
		var sim_vlaue = document.all.sim.value;
		if(sim_vlaue=="")
		{
			rdShowMessageDialog("������SIM����!");
			document.all.s_simjl.checked=false;
			return false;
		}
		else
		{
			//ajax����
			var myPacket = new AJAXPacket("../zgb5/szgb5_jyCrm.jsp","�����ύ�����Ժ�......");
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
</script>


<title>������Ϣ��ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>

<BODY onload="inits()">
<FORM action=" " method="post" name="form"  >
<%@ include file="/npage/include/header.jsp" %>
 
<input type="hidden" name="Op_Code"  value="zgb6">

</div>
<div id="Operation_Table">

<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>
       <div id="wpayjg">
		 
           
      </div>  
<input type="hidden" name="sj_name">
<input type="hidden" name="je_name">
<!--У����---->
<table cellspacing="0">
	<tr>
		<td>У������</td>
		<td>
			<select name="jy" id="jyid" onChange="check_jl()">
				<option value="0">---��ѡ��---</option>
				<!--
				<option value="1">����ʱ��</option>
				
				<option value="3">�ͻ�����</option>
				<option value="4">�ɷѼ�¼</option>
				-->
				<option value="2">SIM����Ϣ</option>
				<option value="5">�ɷѷ�Ʊ��¼</option>
			</select>
		 <!--
			<input type="button" name="check1" class="b_foot" value="У��" onclick="checks()">
			-->
		</td>
	</tr>
	<tr id="rwsjid">
		<td class="blue">����ʱ��</td>
		<td class="blue" colspan="3">			
			<input type="text" name="rwsj">
		</td>
		
	</tr>
	<tr id="simid">
		<td class="blue">SIM����Ϣ</td>
		<td class="blue" colspan="3">			
			<input type="text" name="sim"><input type="checkbox" name="s_simjl" onclick="tt_sim()">У��
		</td>
	</tr>
	<tr id="khxmid">
		<td class="blue">�ͻ�����</td>
		<td class="blue" colspan="3">			
			<input type="text" name="khxm">
		</td>
	</tr>
	<tr id="jfjlid">
		<!--<td class="blue">�ɷѼ�¼</td>
		
		<td  colspan="3">			
			�ɷ�ʱ��<input type="text" name="jftime">(YYYYMMDD)
			&nbsp;&nbsp;&nbsp;
			�ɷѽ��<input type="text" name="jfje">
		</td>
		-->
	</tr>
	<tr id="jffpjlid">
		<td class="blue">�ɷѷ�Ʊ��¼</td>
		<td class="blue" colspan="3">			
			��ӪҵԱȷ�Ͻɷѷ�Ʊ�Ƿ���ȷ�����档<input type="checkbox" name="s_fpjl" onclick="tt()">У��
			<p>
			��Ʊ����:<input type="text" name="fphm">
			<p>
			��Ʊ����:<input type="text" name="fpdm">
		</td>
		</td>
	</tr>
</table>

	   <table cellspacing="0">
	     <tr id="footer">
           <TD nowrap colspan="8"> 
               <input type="button" name="dosuer" class="b_foot" value="ȷ��" onClick="docfm()">
			   <input type="button" name="return" class="b_foot" value="����" onClick="window.history.go(-1)">
               <input type="button" name="return" class="b_foot" value="�ر�" onClick="removeCurrentTab()">
           </TD>
         </TR>
        </table>
<%@ include file="/npage/include/footer.jsp" %>
</Form>
 
</body>
</html>
<script language="javascript">
	function docfm()
	{
		var sj_name = document.all.sj_name.value;
		var je_name = document.all.je_name.value;
		var fphm = document.all.fphm.value; 
		var fpdm = document.all.fpdm.value; 
		var ThirdClass_new = document.all.jy[document.all.jy.selectedIndex].value;
		var sim_vlaue = document.all.sim.value;
		document.form.action="zgb6_select.jsp?phoneno="+"<%=phoneNo%>"+"&contractno="+"<%=count%>"+"&user_passwd="+"<%=user_passwd%>"+"&id_no="+"<%=id_no%>"+"&selectValue="+ThirdClass_new+"&sim_vlaue="+sim_vlaue+"&fphm="+fphm+"&fpdm="+fpdm;;
		document.form.submit();
	}
</script>
 

 

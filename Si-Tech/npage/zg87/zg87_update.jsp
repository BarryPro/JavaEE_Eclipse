<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����Ԥ��� 8379
   * �汾: 1.0
   * ����: 2010/3/12
   * ����: sunaj
   * ��Ȩ: si-tech
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
<title>Ͷ���˷�ͳ�Ʋ�ѯ</title>
<%
  //String opCode="8379";
 //String opName="����Ԥ���";

    String opCode="zg87";
	String opName="���ּ���Ҫ�ع���";	
 
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	String contextPath = request.getContextPath();
%>
<%
  /****�õ���ӡ��ˮ****/
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
	<input type="hidden" name="opname" value = "���ּ���Ҫ�ع���" >
	<%@ include file="/npage/include/header.jsp" %>
  
<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">���ּ���Ҫ�ع���</div>
</div>	 
	
	               <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue" width="15%">���÷�ʽ</td>
                  <td colspan="3"> 
                  	<q vType="setNg35Attr">
                    <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" >
                    ��ѯ 
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel2()" value="2"  >
                    ����
                    </q>
		<q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel3()" value="3"  >
                    ɾ��
                    </q>
		<q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel4()" value="4"  checked>
                    �޸�
                    </q>
                  </tr>   
                </tbody> 
              </table>


	<table cellspacing="0" id="tabList">
			<tr> 
			  <td class="blue">������Ϣ</td>
				<td class="blue">	<select name="dsxx" id="dsxxId" >
					<option value="00">ȫʡ</option>
				</select>

			   </td>            
			<td class="blue">Ʒ����Ϣ</td>
			<td class="blue">
			<select name="ppxx" id="pxxxId" >
					<option value="111" selected>����Ʒ��</option>
					<option value="100" >���еش�</option>
					<option value="010" >ȫ��ͨ</option>
					<option value="001" >������</option>
					<option value="110" >���еش�/ȫ��ͨ</option>
					<option value="101" >���еش�/������</option>
					<option value="011" >ȫ��ͨ/������</option>
					<option value="000" >����Ʒ�ƾ���֧��</option>				
				</select>

				</td>
			</tr> 
			<!--����Ҫ��-->
			<tr> 
			<td class="blue">����Ҫ��</td>
			<td class="blue">	
				<select id=jsysId name=jsys onChange="chkJfys(this,ys,ys_value)" >
					<option value="0" selected>---��ѡ��</option>
					<option value="CON_TYPE" >���ѻ���</option>
					<option value="ON_LINE">�������</option>
					<option value="VIP_TYPE">VIP����</option>
					<option value="BILL_TYPE">�Ǽ�����</option>
				</select>

			</td>            
			<td class="blue">����Ҫ��ֵ</td>
			<td class="blue">
				<select name="jsysz" id="jsyszId" >
				</select>	
			</td>
    		 	</tr>
			<!--end of ����Ҫ��-->
			<!--���µ�ֵ��ѯʱ������Ҫ �������� begin-->
			<tr style="display:block" id="wlinfo_id"> 
			  <td class="blue">�����������ֵ</td>
				<td class="blue">	
					<input type="text" name="wl_max" onKeyPress="return isKeyNumberdot(0)">
			  </td>            
			  <td class="blue">����������Сֵ</td>
				<td class="blue">	
					<input type="text" name="wl_min" onKeyPress="return isKeyNumberdot(0)">
			  </td>  
			</tr>
			 
			<tr style="display:block" id="jfbl_id"> 
			  <td class="blue">��������</td>
				<td class="blue">	
					<select name="jflx" id="jflxId" >
						<option value="C" selected>���ѻ���</option>
						<option value="I">�������</option>
					</select>

				</td> 
			  <td class="blue">���ּƻ�����</td>
				<td class="blue">
					<select name="jfjhmc" class="button"">
	            	<%for(int i = 0 ; i < SpecResult.length ; i ++){%>
						<option value="<%=SpecResult[i][0]%>"><%=SpecResult[i][0]%></option>
					<%}%>
	            </select>
				</td>
				 
			</tr>
			<!--end of ���ص�ֵ-->
		 
		<tr >
			<td align=center colspan=4><input type=button class="b_foot" name="check2" value="��ѯ" id="cz" onclick="docfm()" >
			<!--
			<input type=button class="b_foot" value="���ɱ���" onclick="printTable(tabList)" >
			-->
			
			<input type=reset class="b_foot" value="����" >
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
 	//����ȫ�ֱ���
  	var ys = new Array();
         var ys_value = new Array();
	function inits()
	{
		document.getElementById("wlinfo_id").style.display="none";
	}
	function chkJfys(choose,ItemArray,GroupArray)
    {
		//alert("1");
		//����մ���second 
		//alert("?"+document.all.jsysz.options.length);  
		
		//alert("�Ѿ�removed");
		//��ȡѡ���ֵ   
		var selectedValue = document.all.jsysz.value;   
		//var selectedText = document.all.jsysz[document.all.jsysz.selectedIndex].text;   
		//�жϻ���Ҫ�ص�ֵ
		var jsys_new = document.all.jsys[document.all.jsys.selectedIndex].value;
		//wlinfo_idĬ�ϲ�չʾ ��ʵ��ѯ��ʱ������Ͳ�չʾ
		document.getElementById("wlinfo_id").style.display="none";
		if(jsys_new=="0")
		{
			rdShowMessageDialog("��ѡ�����Ҫ������!");
		} 
		else
		{
			//alert("4");
			/*
			CON_TYPE-���ѻ���(����Ҫ��ֵ=1)
			ON_LINE-�������'����ʾ6.7���ֵ����Сֵ, ����Ҫ��ֵ�ǿ�
			VIP_TYPE-VIP����( 0-��VIP,1-��VIP)
			BILL_TYPE-�Ǽ�����(����Ҫ��ֵ��0-5)
			*/
			//document.all.sxzt.disabled=false;
			//document.all.sxzt.options[0].selected = true;
			if(jsys_new=="CON_TYPE")
			{
				document.getElementById("jsyszId").innerHTML="";
				var newItem = new Option("����Ҫ��ֵ=1","1"); 
				document.all.jsysz.options.add(newItem);   
			}
			else if(jsys_new=="ON_LINE")//������� wlinfo_idչʾ
			{
				document.getElementById("jsyszId").innerHTML="";
				var newItem = new Option("����Ҫ��ֵ=��","");  
				document.all.jsysz.options.add(newItem);
				document.getElementById("wlinfo_id").style.display="block";
			}
			else if(jsys_new=="VIP_TYPE")
			{
				document.getElementById("jsyszId").innerHTML="";
				//new begin
				var newItem =new Array();
				newItem[0] = new Option("��VIP","0");
				newItem[1] = new Option("VIP","1");
				for(var i=0;i<2;i++)
				{
					var obj  = document.all.jsysz.options;
					//alert(obj+" and newItem is "+newItem[i].text);
					obj.add(newItem[i]);
					//newItem[0] = new Option("��VIP","0");
					//newItem[1] = new Option("VIP","1");
				}		

				//new end
				/*
				var newItem = new Option("��VIP","0");
				var newItem1 = new Option("VIP","1");
				document.all.jsysz.options.add(newItem); 
				document.all.jsysz.options.add(newItem1);
				*/
				//sxztֻ����ʧЧ document.getElementById("Select"+rowID).options[index].selected=true; 
				//document.all.sxzt.options[1].selected = true;
				//document.all.sxzt.disabled=true;
			}
			else if(jsys_new=="BILL_TYPE")
			{
				document.getElementById("jsyszId").innerHTML="";
				var newItem0 = new Option("0�Ǽ�","0");
				var newItem1 = new Option("1�Ǽ�","1");
				var newItem2 = new Option("2�Ǽ�","2");
				var newItem3 = new Option("3�Ǽ�","3");
				var newItem4 = new Option("4�Ǽ�","4");
				var newItem5 = new Option("5�Ǽ�","5");
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
			rdShowMessageDialog("��ѡ�����Ҫ��!");
			return false;
		}	
		
		else if (jsys_id=="ON_LINE" && (document.all.wl_max.value=="" || document.all.wl_min.value==""))//������� �����Сֵ�ǿ�
		{
			rdShowMessageDialog("����������������õ����ֵ����Сֵ!");
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
 
 
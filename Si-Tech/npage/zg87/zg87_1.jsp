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
<body>
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
                    <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1"  checked>
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
                    <input name="busyType1" type="radio" onClick="sel4()" value="4"  >
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
			<td class="blue">���ּƻ�����</td>
			<td class="blue">
				<select name="jfjhmc1" class="button"">
				<%for(int i = 0 ; i < SpecResult.length ; i ++){%>
					<option value="<%=SpecResult[i][0]%>"><%=SpecResult[i][0]%></option>
				<%}%>
			</select>
			</td>
    		 	</tr>
			<!--end of ����Ҫ��-->
			 
			<tr style="display:block" id="jflx_id"> 
			<td class="blue">��������</td>
			<td class="blue">	
				<select name="jflx" id="jflxId" >
					<option value="C" selected>���ѻ���</option>
					<option value="I">�������</option>
				</select>

			</td>            
			<td class="blue">��Ч״̬</td>
			<td class="blue">
			<select name="sxzt1" id="sxztId1" >
					<option value="1" selected>��Ч</option>
					<option value="0" >ʧЧ</option>
					<option value="2" >ȫ��</option>				
				</select>

				</td>
    		 	</tr>
<!--
    		 	<tr> 
        <td class="blue">��ע</td>
				<td class="blue" colspan=3>
					<input type="text" name="beizhu" >
				</td>
					</tr>
	-->		 
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
		document.getElementById("jfbl_id").style.display="none";
		document.getElementById("ssxsj_id").style.display="none";
		document.getElementById("jflx_id").style.display="none";
	}
	function chkJfys(choose,ItemArray,GroupArray)
    {
		//alert("1");
		//����մ���second 
		//alert("?"+document.all.jsysz.options.length);  
		
		//alert("�Ѿ�removed");
		//��ȡѡ���ֵ   
		//var selectedValue = document.all.jsysz.value;   
		//var selectedText = document.all.jsysz[document.all.jsysz.selectedIndex].text;   
		//�жϻ���Ҫ�ص�ֵ
		var jsys_new = document.all.jsys[document.all.jsys.selectedIndex].value;
		//wlinfo_idĬ�ϲ�չʾ ��ʵ��ѯ��ʱ������Ͳ�չʾ
		//document.getElementById("wlinfo_id").style.display="none";
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
			document.all.sxzt1.disabled=false;
			document.all.sxzt1.options[0].selected = true;
			if(jsys_new=="CON_TYPE")
			{
				   
			}
			else if(jsys_new=="ON_LINE")//������� wlinfo_idչʾ
			{
				
			}
			else if(jsys_new=="VIP_TYPE")
			{
				document.all.sxzt1.options[1].selected = true;
				document.all.sxzt1.disabled=true;
			}
			else if(jsys_new=="BILL_TYPE")
			{
					   
			}

			  

		}
	}
	 
	function docfm()
	{
		//var ThirdClass_new = 
		var jsys_id = document.all.jsys[document.all.jsys.selectedIndex].value;
		//var beizhu = document.all.beizhu.value;
		if(jsys_id=="0")
		{
			rdShowMessageDialog("��ѡ�����Ҫ��");
			return false;
		}	
		/*
		else if(beizhu=="")
		{
			rdShowMessageDialog("�����뱸ע��Ϣ");
			return false;
		}*/
		else
		{
			var actions = "zg87_qry.jsp";
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
 
 
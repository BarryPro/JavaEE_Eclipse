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
<title>����Ԥ���</title>
<%
    //String opCode="8379";
	//String opName="����Ԥ���";

    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
 
%>
<%
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();

 
%>
 		
 
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>  
<body onload="checkRight()">
<form action="" name="frm" method="POST">
 	<input type="hidden" name="opcode" value = "e470" >
	<input type="hidden" name="opname" value = "�����ֹ���ֵ" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">���ſͻ���ֵ���ֹ���ֵ</div>
</div>	 
	<table cellspacing="0" id="tabList">
	   
		<tr >
			<td class="blue" >��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� <input type="text" name="kahao"> 
	 &nbsp;&nbsp;&nbsp;
			 ��&nbsp;&nbsp;&nbsp;&nbsp;�� <input type="password" name="kamima"    maxlength="18">
			 &nbsp;&nbsp;&nbsp;
			 ��&nbsp;&nbsp;&nbsp;&nbsp;ֵ <input type="text" name="kamianzhi">
			 </td>
		</tr>
		<tr > 
			<td class="blue" colspan=2>�ֻ����� <input type="text" name="phoneNo">&nbsp;&nbsp;&nbsp;  
			 ���Ŵ��� <input type="text" name="uid">  
				 &nbsp;&nbsp;&nbsp;�������� <input type="text" name="grpName" readonly > <input type=button class="b_foot" name="check2" value="��ѯ" onclick="getName()" >
			</td>
		
		</tr>
		<tr>
			<td class=blue>��ʼ���� <input type="text" name="beginDt" maxlength=6  >&nbsp;&nbsp;&nbsp;&nbsp;�������� <input type="text" name="endDt" maxlength=6  >(YYYYMM)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=button class="b_foot" value="�����ѯ" id="bbcx" onclick="doQuery2(document.all.beginDt.value,document.all.endDt.value)" ></td>
		</tr>
		<tr>
			<td align=center><input type=button class="b_foot" name="check2" value="��ֵ" id="cz" onclick="docfm()" >
			<!--
			<input type=button class="b_foot" value="���ɱ���" onclick="printTable(tabList)" >
			-->
			
			<input type=reset class="b_foot" value="����" >
			</td>
		<tr>
		</tr>
		
	</table>
</div>
<div id="showResult">
	<table cellspacing="0">
		<!--���� ���� ��ֵʱ�� ��ֵ�ֻ����� Ӫ�������� �������Ŵ��� ������������ ��ֵ���-->
		<tr><th>����</th><th>����</th><th>��ֵʱ��</th><th>��ֵ�ֻ�����</th><th>Ӫ��������</th><th>�������Ŵ���</th><th>������������</th><th>��ֵ���</th><tr> 
	</table>
</div>
 
 
</table>
 
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
	function doQuery2(d1,d2)
	{
		 var year1 =  d1.substr(0,4);
		  var year2 =  d2.substr(0,4); 
		  var month1 = d1.substr(4,2);
		  var month2 = d2.substr(4,2);
		  var myDate = new Date(); 
		  var year31 =  myDate.getFullYear();
		 // alert("year31 is "+year31);
		  //var year3 =  year31.substr(0,4);   
		  var month31=myDate.getMonth();
		 // alert("month31 is "+month31);
		 // var month3=month31.substr(4,2);
		//  var len=(year2-year1)*12+(month2-month1);
		var len=(year31-year1)*12+(month31-month1+1);
		 if(document.all.beginDt.value=="" ||document.all.endDt.value=="")
		 {
			rdShowMessageDialog("�������ѯ�Ŀ�ʼ�ͽ���ʱ�䣡ʱ���ʽΪYYYYMM��");
			return false;
		 }
		 
			// alert("year1 is "+year1);
			  
              if(len<0)
			  {
				  rdShowMessageDialog("��ѯ��ʼ�·ݲ��ܱȲ�ѯ��ֹ�·ݴ�!");
				  return false;
			  }
			  if(len>6)
			  {
				  rdShowMessageDialog("ֻ���Բ�ѯ��6���µļ�¼!");
				  return false;
			  }			
				
		 	
		 var actions = "e470_show.jsp?beginDt="+document.all.beginDt.value+"&endDt="+document.all.endDt.value;
		 document.all.frm.action=actions;
		 document.all.frm.submit();
	}
	function doQuery()
	{
		 if(document.all.beginDt.value=="" ||document.all.endDt.value=="")
		 {
			rdShowMessageDialog("�������ѯ�Ŀ�ʼ�ͽ���ʱ�䣡ʱ���ʽΪYYYYMM��");
			return false;
		 }
		 document.getElementById("showResult").innerHTML="";
		 var myPacket = new AJAXPacket("e470_query.jsp","�����ύ�����Ժ�......");
		 myPacket.data.add("beginDt",document.all.beginDt.value);
		 myPacket.data.add("endDt",document.all.endDt.value);
		 core.ajax.sendPacket(myPacket);
    	 myPacket=null;
	}
	function getName()
	{
		/*if(document.all.phoneNo.value=="")
		{
			rdShowMessageDialog("�����뼯���ֻ����룡");
			return false;
		}*/
		if(document.all.uid.value=="")
		{
			rdShowMessageDialog("�����뼯�Ŵ��룡");
			return false;
		}
		//alert("unitId is "+document.all.uid.value);
		var myPacket = new AJAXPacket("e470_getName.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("phoneNo",document.all.phoneNo.value);
		myPacket.data.add("unitId",document.all.uid.value);
		core.ajax.sendPacket(myPacket);
    	myPacket=null;
	}
	function checkRight()
	{
		document.getElementById("bbcx").disabled=true;
		document.getElementById("cz").disabled=true;
		document.getElementById("showResult").style.display="none";
		var myPacket = new AJAXPacket("e470_check.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("loginNo","<%=workNo%>");
		core.ajax.sendPacket(myPacket);
    	myPacket=null;
	}
	
	function doProcess(packet)
	{
		var flagConfirm =  packet.data.findValueByName("flag1");
		 
		if(flagConfirm==2 )
		{
			rdShowMessageDialog("���Ų���ʧ��");
			return false;
		}
		if(flagConfirm==1 )
		{
			rdShowMessageDialog("���Ų��߱�����Ȩ��!");
			return false;
		}
		if(flagConfirm==0 )
		{
			//rdShowMessageDialog("ok! ά���ֲỹҪ����һ��Ȩ�ޱ�~");
			document.getElementById("bbcx").disabled=false;
			document.getElementById("cz").disabled=false;
			return true;
		}
		var flagName =  packet.data.findValueByName("flagName");  
		var grpName =  packet.data.findValueByName("grpName"); 
		if(flagName==1)
		{
			rdShowMessageDialog("��ѯ�������Ƴ���!");
			return false;
		}
		if(flagName==0)
		{
			document.all.grpName.value=grpName;
			
		}
		//xl add for �����ѯ
		var flag_show =packet.data.findValueByName("flag_show"); 
		if(flag_show==1)
		{
			rdShowMessageDialog("�������ݲ�����!");
			return false;
		}
		if(flag_show==1)
		{
			rdShowMessageDialog("�����ѯ����!");
			return false;
		}
		if(flag_show==0)
		{
			document.getElementById("showResult").style.display="block";
			var counts = packet.data.findValueByName("count_is");
			document.getElementById("showResult").innerHTML+="<table id='showIds'><tr><th>����</th><th>����</th><th>��ֵʱ��</th><th>��ֵ�ֻ�����</th><th>Ӫ��������</th><th>�������Ŵ���</th><th>������������</th><th>��ֵ���</th></tr> "; 
			for(i =0;i<counts;i++)
			{
				var region_name = packet.data.findValueByName("region_name"+i);
				var phone_No1 = packet.data.findValueByName("phone_No1"+i);
				//document.getElementById("showResult").innerHTML+="<tr><td>"+region_name+"</td><td>"+phone_No1 +"</td></tr>";
				document.getElementById("showResult").innerHTML+="<table id='table'"+i+"><tr><td>"+region_name+"</td><td>"+phone_No1+"</td></tr></table>";
		 
			}
			document.getElementById("showResult").innerHTML+=" <tr><td><input type='button' class='b_foot' value='��������' onclick='printTable(showIds,)'></td><tr></table>"; 
		}
	}
	function docfm()
	{
		var groupName = document.all.grpName.value;
		if(groupName=="")
		{
			rdShowMessageDialog("�����뼯�Ŵ���,��������ѯ��ť,���ؼ�������!");
			return false;
		}
		else if(document.all.kamima.value=="" ||document.all.kahao.value==""||document.all.kamianzhi.value=="")
		{
			rdShowMessageDialog("�������ֵ���š�����ֵ�ͳ�ֵ������!");
			return false;
		}	
		else
		{
			var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ����ֵ��");
			if (prtFlag==1)
			{
				var actions = "e470_2.jsp?phoneNo="+document.all.phoneNo.value+"&cardNo="+document.all.kahao.value+"&kmm="+document.all.kamima.value+"&grpName="+document.all.grpName.value+"&grpId="+document.all.uid.value+"&kmz="+document.all.kamianzhi.value;
				document.all.frm.action=actions;
				document.all.frm.submit();
			}
			
		}
		
		
	}

	
function printTable(obj){
	var excelObj;
	var excelObj2;
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.tabList.length > 1)	
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
		excelObj.WorkBooks.Add;
		for(a=0;a<document.all.tabList.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						for(j=0;j<cells;j++)
							excelObj.Cells(i+1+(total_row),j+1).Value=obj[a].rows[i].cells[j].innerText;
					}
				}
				catch(e)
				{
					//alert('����excelʧ��!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
		alert("1");
		//new
		for(a=0;a<document.all.tabList.length;a++)
		{
			alert("2");
			rows2=obj2[a].rows.length;
			if(rows2>0)
			{
 				try
				{
					for(i=0;i<rows2;i++)					{
						cells2=obj2[a].rows2[i].cells.length;
						for(j=0;j<cells2;j++)
							excelObj.Cells(i+1+(total_row),j+1).Value=obj2[a].rows2[i].cells2[j].innerText;
					}
				}
				catch(e)
				{
					//alert('����excelʧ��!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
		//end new
	}
	else
	{
		 
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
		excelObj.WorkBooks.Add;
		rows=obj.rows.length;
	 
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					for(j=0;j<cells;j++)
						excelObj.Cells(i+1,j+1).Value=obj.rows[i].cells[j].innerText;
				}
			}
			catch(e)
			{
				//alert('����excelʧ��!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
		 
	}
}
 

</script>
 
 
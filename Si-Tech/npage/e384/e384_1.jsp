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
    String[][] favInfo=(String[][])session.getAttribute("favInfo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("k"))
		workNoFlag=true;
%>
<%
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();

  //xl add for ��ѯwchargecardmsgnew
  String card_sql = "select card_no from wchargecardmsg where phone_no1='?' and op_code='e384'  ";
  //end
%>
<wtc:pubselect name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=card_sql%></wtc:sql>
		<wtc:param value="<%=phoneNo%>"/>	
	</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
<%
	String errCode2 = retCode2;
	String errMsg2 = retMsg2;
	String[] cardNo =new String[]{""};
	
	//xl add for sunaj e384������ �����
	String[] inParas2 = new String[2]; 
	inParas2[0]="select b.award_detail_code||'-->'||b.award_detail_name,b.award_code||','||b.award_detail_code from dbgiftrun.schnresactivecode a,sawarddetail b where b.region_code=:s_region and a.child_code in ('026664','029319','029448','028738') and a.child_code = b.award_code||b.award_detail_code and a.valid_flag=1 ";
	//����inParas2[0]="select b.award_detail_code||'-->'||b.award_detail_name,b.award_code||','||b.award_detail_code from dbgiftrun.schnresactivecode a,sawarddetail b where b.region_code=:s_region and a.child_code in ('026664','029319','029448','028738','027128') and a.child_code = b.award_code||b.award_detail_code and a.valid_flag=1 ";
	inParas2[1]="s_region="+regionCode;
%>		
<!--����-->
<script language="javascript">
	var card_code = new Array();
	var  str; 
<%
	System.out.println("qweqwe1888888888888888888888888888881111111111111");
	if(result2.length >0){
		for(int m=0;m<result2.length;m++)
		  {
			out.println("card_code["+m+"]='"+result2[m][0]+"';\n");
			 
		  }
	}
	else{
	System.out.println("qweqwe9888800000000000000000111");
	}

	
%>
	
	//alert("str is "+str.split(","));
</script>

<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="SpecCode" retmsg="SpecMsg" outnum="2">
<wtc:param value="<%=inParas2[0]%>"/>
<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="SpecResult"  scope="end" />

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>  
<body onload="init1()">
<form action="" name="frm" method="POST">
 	<input type="hidden" name="opcode" value = "e384" >
	<input type="hidden" name="opname" value = "���ͳ�ֵ����ֵ" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">���ͳ�ֵ���ֹ���ֵ</div>
</div>	 
	<table cellspacing="0">
	   
		<tr> 
			<td class="blue">�ֻ����� </td>
			<td> 
				<input type="text" size="12" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				&nbsp;&nbsp;&nbsp;&nbsp;	 
		 
				
			 
				 
			</td>
		</tr>
		<tr> 
			<td class="blue">����� </td>
			<td> 
				<select name="pay_note" id="selOp" width=3100px>
					<option value="0" selected>---��ѡ��</option>
					<%for(int i=0; i<SpecResult.length; i++){%>
					<option value="<%=SpecResult[i][1]%>">
					
					<%=SpecResult[i][0]%></option>
					<%}%>

				</select>	 
		 
				
			 
				<input type=button class="b_foot" name="check2" value="��ѯ" onclick="check1()" >
			</td>
		</tr>
		
		
	</table>
</div>
 
<!-- xl add ��Է�ת���ͻ�-->
<input type="hidden" name="beginNo"><!--Ϊ���㿨��-->
<input type="hidden" name="oGroupSize">
<div id="Operation_Table2"> 
<div class="title">
	<div id="title_zi">�ֹ���ֵ</div>
</div>
 
</div>
<!--  xl add end ��Է�ת���ͻ�--> 
 
</table>
<input type = "hidden" name="custName">
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
	
	function init1()
	{
		document.getElementById("Operation_Table2").style.display="none";
		//check1();
		
		 
	}
	function check1()
	{
		var objSel = document.getElementById("selOp");
		var detail_id = objSel.value;
		//alert(detail_id);
		if(detail_id==0)
		{
			rdShowMessageDialog("��ѡ�����룡");
			return false;
		}
		else
		{
			var myPacket = new AJAXPacket("e384_check.jsp","�����ύ�����Ժ�......");
			myPacket.data.add("phoneNo",document.frm.srv_no.value);
			var cpid = document.all.pay_note[document.all.pay_note.selectedIndex].value;
			//alert(cpid);
			myPacket.data.add("cpid",cpid);
			myPacket.data.add("detail_id",detail_id);
			core.ajax.sendPacket(myPacket);
			myPacket=null;
		}
		
	}
	
	function doProcess(packet)
	{
		var flagConfirm =  packet.data.findValueByName("flag1");
		var iNumLen = packet.data.findValueByName("iNumLen");//��2������
		//alert("flagConfirm is "+flagConfirm);
		//flagConfirm=0;
		if(flagConfirm==1 )
		{
			var errCode2 =  packet.data.findValueByName("errCode");
			var errMsg2 =  packet.data.findValueByName("errMsg");
			rdShowMessageDialog("����ʧ�ܣ�������룺"+errCode2+",ʧ��ԭ��"+errMsg2);
			return false;
		}
		
		if(flagConfirm==0)
		{
			document.getElementById("Operation_Table2").style.display="block";
			document.all.check2.disabled=true;
			<%
					String rownumNew = request.getParameter("rownumNew");
					int j =0;
					
			%>
			//���ֵ������� ��ѡѡ��~~��һ��
			//iNumLen=1;
			 
			for(k=0;k<iNumLen;k++)
			{
				
				 
				var oStoreNo  = packet.data.findValueByName("oStoreNo"+k);
				document.all.beginNo.value=oStoreNo;
				var oEndStoreNo  = packet.data.findValueByName("oEndStoreNo"+k); //�����
				var oTranMianzhi  = packet.data.findValueByName("oTranMianzhi"+k);
				var icardNum = packet.data.findValueByName("icardNum"+k);
				 
			//	alert("�� "+k+" ��ļ�¼��oStoreNo is "+oStoreNo+"���������� "+oEndStoreNo+" and �п�Ƭ "+icardNum+"��");
				//var rowNum = parseInt(oEndStoreNo-oStoreNo);
				var cardNoNew = "";
				var str1 = card_code.join();
			//alert("11 oStoreNo is "+oStoreNo+" and oEndStoreNo is "+oEndStoreNo);
			     
				for(i=0;i<icardNum;i++)
				{
					var newNo = oStoreNo.substr(oStoreNo.length-16);//β��
					var cardNoPre = parseInt(newNo)+i;
					var cardNo = oStoreNo.replace(oStoreNo.substr(oStoreNo.length-16),cardNoPre) ;//�ַ����滻
					
					//var cardNo = oStoreNo+i;
				//	alert("�� "+k+"�� ,�� "+i+"�� ");
					//alert("�� "+i+" ������ cardNoPre "+cardNoPre+" and cardNo is "+cardNo+" and oStoreNo is "+oStoreNo);
					var test = str1.match(cardNo);
					if(test!=null)
					{
						//alert("2 ");
						document.getElementById("Operation_Table2").innerHTML += '<table cellspacing="0" id="table1"><tr><td>���ţ�<input type="text" name="cardNo"  value="'+cardNo+'" readOnly></td><td>����ֵ��<input type="text" name="mz" value="'+oTranMianzhi+'" readOnly></td><td><input type="button" " value="�ѳ�ֵ" class="b_foot"    disabled></td></tr></table>';
						 
						 
					}	
					else 
					{
						//alert("3 ");
						document.getElementById("Operation_Table2").innerHTML += '<table cellspacing="0" id="table1"><tr><td>���ţ�<input type="text" name="cardNo"  value="'+cardNo+'" readOnly></td><td>����ֵ��<input type="text" name="mz" value="'+oTranMianzhi+'" readOnly></td><td><input type="button" id="cfms'+i+'" readOnly value="��ֵ" class="b_foot" name="cfm"  onClick=docfm("'+cardNo+'","'+oTranMianzhi+'")></td></tr></table>';
						
						
					}
					
				} //end of �ڲ�ѭ��
			} //end of ���ѭ��

		}
		
		
		

	}
	function docfm(rowId,mz)
	{
		/*var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

		var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		var phoneNo = document.all.srv_no.value;
		var cardNo = document.all.beginNo.value;
		var returnValue = window.showModalDialog('e384_2.jsp?rowId='+rowId+"&phoneNo="+phoneNo+"&cardNo="+cardNo,"",prop);
		*/
		var phoneNo = document.all.srv_no.value;
		var cardNo = document.all.beginNo.value;
		var rowIds = rowId;
		//alert("Id is "+rowIds+" and tes is "+rowId);
		var cardNoNew = parseFloat(cardNo)+rowId;
		var kmz = mz;
		//alert("mz is "+kmz);
		var actions = "e384_2.jsp?rowId="+rowId+"&phoneNo="+phoneNo+"&cardNoNew="+rowIds+"&kmz="+kmz;
		document.all.frm.action=actions;
		document.all.frm.submit();
		
	}
	
 

</script>
 
 
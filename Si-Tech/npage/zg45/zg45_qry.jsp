=<%
/********************
 * version v2.0
 * ������: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	
	String opCode = "zg45";
	String opName = "����Ԥ����Ʊ";
	
	       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	
	String unit_id= request.getParameter("unit_id");
	String work_no = (String)session.getAttribute("workNo");
	 
	String contextPath = request.getContextPath(); 
	 
	String paraAray[] = new String[4]; 
	paraAray[0] = "select to_char(unit_id),unit_name,to_char(grp_phone_no),to_char(grp_contract_no) from DvirtualgrpMSGdetail where unit_id = :s_id";
	paraAray[1] = "s_id="+ unit_id;
 
		//xl add ��ƱԤռ�ӿ�
	String paySeq="";
	String groupId = (String)session.getAttribute("groupId");
	//String s_invoice_tmp="";
	String return_flag="";
	String return_note="";
	String ocpy_begin_no="";
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code="";
	String bill_accept="";
	String s_invoice_flag="";
	String sparas_accept[] = new String[1]; 
	sparas_accept[0]="select to_char(sMaxPayAccept.nextval) from dual";
	String sparas_name[] = new String[2];
	sparas_name[0]="select trim(bank_cust) from dconmsg where contract_no=:s_contract_no";
%>
<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="sCode2_accept" retmsg="sMsg2_accept" outnum="1" >
    <wtc:param value="<%=sparas_accept[0]%>"/>
</wtc:service>
<wtc:array id="s_invoice_accept" scope="end"/>
<%
	paySeq=s_invoice_accept[0][0];
 
	 
	 %>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="sCode" retmsg="sMsg" outnum="4" >
			<wtc:param value="<%=paraAray[0]%>"/>
			<wtc:param value="<%=paraAray[1]%>"/> 
		 
		</wtc:service>
		<wtc:array id="sArr" scope="end"/>
<%
	String retCode1= sCode;
	String retMsg1 = sMsg;
   

	String errMsg = sMsg;
	if(sArr!=null&&sArr.length>0)
	{
 
%>
	<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>���⼯�Ų�ѯ���</TITLE>
</HEAD>
<body>
<script language="javascript">
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
	function doqx(packet)
	{
		var s_flag = packet.data.findValueByName("s_flag");	
		var s_code = packet.data.findValueByName("s_code");	//ò��ûɶ��
		var s_note = packet.data.findValueByName("s_note");	
		var s_invoice_code  = packet.data.findValueByName("s_invoice_code");//ò��Ҳûɶ��	
		//alert("s_flag is "+s_flag+" and s_code is "+s_code+" and s_note is "+s_note);
		//s_flag="1";
		//alert("s_flag is "+s_flag+" and s_code is "+s_code+" and s_note is "+s_note);
		if(s_flag=="1")
		{
			rdShowMessageDialog("Ԥռȡ���ӿڵ����쳣!");
			window.location.href="zg45_1.jsp";
		}
		else
		{
			if(s_flag=="0")
			{
				rdShowMessageDialog("��ƱԤռȡ���ɹ�,��ӡ���!",2);
				window.location.href="zg45_1.jsp";
			}
			else
			{
				rdShowMessageDialog("��ƱԤռʧ��! �������:"+s_code,0);
				window.location.href="zg45_1.jsp";
			}
		}
	 }
	 function doyz(packet)
	 {
		var ocpy_begin_no = packet.data.findValueByName("ocpy_begin_no");	 
		var ocpy_end_no = packet.data.findValueByName("ocpy_end_no");	
		var ocpy_num  = packet.data.findValueByName("ocpy_num"); 
		var res_code= packet.data.findValueByName("res_code"); 
		var bill_code= packet.data.findValueByName("bill_code");
		var bill_accept= packet.data.findValueByName("bill_accept");
		var s_invoice_flag= packet.data.findValueByName("s_invoice_flag");
		var u_id = document.getElementById("u_id").value;
		var u_name = document.getElementById("u_name").value;
		//����һ��ҳ��ajax��������ֵ
		//var grp_phone_no = packet.data.findValueByName("grp_phone_no");
		var grp_phone_no =document.getElementById("s_phone_id").value;
		var grp_contract_no=document.getElementById("s_contract_id").value;//packet.data.findValueByName("grp_contract_no");
		var s_money = document.getElementById("s_money_id").value;//packet.data.findValueByName("s_money");
		var s_accepts = packet.data.findValueByName("s_accepts");
		if(s_invoice_flag=="1")
		{
			rdShowMessageDialog("Ԥռ�ӿڵ����쳣!");
			window.location.href="zg45_1.jsp";
		}
		else
		{
			if(s_invoice_flag=="0")
			{
				var prtFlag=0;
				prtFlag=rdShowConfirmDialog("��ǰ��Ʊ������"+ocpy_begin_no+",��Ʊ������"+bill_code+",�Ƿ��ӡ��Ʊ?");
				if (prtFlag==1)
				{
					var  begin_time = document.frm1508_2.begin_time.value;
					var manager_name = document.frm1508_2.manager_name.value;
					var begin_time1 = begin_time.substring(0,4)+begin_time.substring(5,7)+begin_time.substring(8,10);
					document.frm1508_2.action="zg45_add.jsp?grp_phone_no="+grp_phone_no+"&grp_contract_no="+grp_contract_no+"&s_money="+s_money+"&u_id="+u_id+"&u_name="+u_name+"&invoice_number="+ocpy_begin_no+"&invoice_code="+bill_code+"&manager_name="+manager_name+"&login_accept="+"<%=paySeq%>"+"&begin_time="+begin_time1;
					//alert("��ӡʱgrp_phone_no "+grp_phone_no);
					//alert("grp_contract_no "+grp_contract_no);
					//alert("s_money "+s_money);
					document.frm1508_2.submit();
				}
				else
				{
					var pactket2 = new AJAXPacket("../s1300/sdis_ocpy.jsp","���ڽ��з�ƱԤռȡ�������Ժ�......");
					//alert("1 ������Ӧ���ǰ���ˮ��״̬ ���ǲ�����");
					pactket2.data.add("ocpy_begin_no",ocpy_begin_no);
					pactket2.data.add("bill_code",bill_code);
					pactket2.data.add("paySeq","<%=paySeq%>");
					pactket2.data.add("bill_code",bill_code);
					pactket2.data.add("op_code","zg45");
					pactket2.data.add("phoneNo","<%=unit_id%>");
					pactket2.data.add("contractno","");
					pactket2.data.add("payMoney",document.getElementById("s_sum").value);
					pactket2.data.add("userName",document.frm1508_2.items.value);
					core.ajax.sendPacket(pactket2,doqx);
					pactket2=null;
				}
			}
			else
			{
				rdShowMessageDialog("��ƱԤռʧ��!",0);
				window.location.href="zg45_1.jsp";
			}
		}
	 }
	function doCfm()
	{
		//xl add for ���ӵ���ʱ��
		var  begin_time = document.frm1508_2.begin_time.value;
		var  grp_phone_no=[];
		var  grp_contract_no=[];
		var  s_money=[];
		var  s_sum_money = 0.0;
		var len = "";
		len=document.frm1508_2.regionCheck.length;
		//alert("test "+len);
		var i_flag=0;//�����Բ���
		var u_id = document.getElementById("u_id").value;
		var u_name = document.getElementById("u_name").value;

		//��Ʊ��Ŀ
		var items = document.frm1508_2.items.value;
		//�ͻ���������
		var manager_name = document.frm1508_2.manager_name.value;
		if(items=="")
		{
			rdShowMessageDialog("�����뿪Ʊ��Ŀ!");
			return false;
		}
		else if (manager_name=="")
		{
			rdShowMessageDialog("������ͻ���������!");
			return false;
		}
		else if(begin_time=="")
		{
			rdShowMessageDialog("��ѡ��Ԥ�Ƶ�������!");
			return false;
		}
		else
		{
			if(len==undefined)
			{
				
				if (document.frm1508_2.regionCheck.checked == true)
				{
					len=1;
					i=0;
					var s_phone = document.getElementById("s_phone"+i).value;
					grp_phone_no.push(s_phone);
					var s_contract = document.getElementById("s_contract"+i).value;
					grp_contract_no.push(s_contract);
					var s_moneys = document.getElementById("s_money"+i).value;
					if(s_moneys=="")
					{
						rdShowMessageDialog("�����������߷�Ʊ���");
					}
					else
					{
						s_money.push(s_moneys);
						document.getElementById("s_sum").value=s_moneys;
						var ss = parseFloat(document.getElementById("s_money"+i).value);
						s_sum_money += ss;
						document.getElementById("s_sum").value=s_sum_money.toFixed(2);
						i_flag=1;
					}
					
					//alert("click 1:grp_phone_no is "+grp_phone_no+" and grp_contract_no is "+grp_contract_no+" and s_money is "+s_money);
				}
				 
				
			}
			else
			{
				for (i = 0; i < len; i++) 
				{
					if (document.frm1508_2.regionCheck[i].checked == true) 
					{
						var s_phone = document.getElementById("s_phone"+i).value;
						grp_phone_no.push(s_phone);
						var s_contract = document.getElementById("s_contract"+i).value;
						grp_contract_no.push(s_contract);
						var s_moneys = document.getElementById("s_money"+i).value;
						if(s_moneys=="")
						{
							rdShowMessageDialog("�����������߷�Ʊ���");
						}
						else
						{
							s_money.push(s_moneys);
							var ss = parseFloat(document.getElementById("s_money"+i).value);
							//alert("test ss is "+ ss);
							s_sum_money += ss;
							document.getElementById("s_sum").value=s_sum_money.toFixed(2);
							//alert("s_sum_money is "+s_sum_money.toFixed(2));
							i_flag=1;
						}
						
						
					}
					 
				}
				//alert("2click grp_phone_no is "+grp_phone_no);
			}
		}
		
		if(i_flag==1)
		{
			//�°淢Ʊbegin
			var h=480;
			var w=650;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
			var path="../s1300/select_invoice.jsp";
			var returnValue = window.showModalDialog(path,"",prop);
			if(returnValue=="1")
			{
				var pactket1 = new AJAXPacket("../s1300/sfp_ocpy_1322.jsp","���ڽ��з�ƱԤռ�����Ժ�......");
				pactket1.data.add("ocpy_begin_no","<%=ocpy_begin_no%>");
				pactket1.data.add("bill_code","<%=bill_code%>");
				pactket1.data.add("paySeq","<%=paySeq%>");
				pactket1.data.add("op_code","zg45");
				pactket1.data.add("phoneNo","<%=unit_id%>");
				pactket1.data.add("contractno","");
				pactket1.data.add("payMoney",document.getElementById("s_sum").value);
				pactket1.data.add("userName",document.frm1508_2.items.value);
				pactket1.data.add("grp_phone_no",grp_phone_no);
				pactket1.data.add("grp_contract_no",grp_contract_no);
				pactket1.data.add("s_money",s_money);
				pactket1.data.add("s_invoice_accept","");
				//alert("Ԥռ��ֵ grp_phone_no is "+grp_phone_no);
				document.getElementById("s_phone_id").value=grp_phone_no;
				document.getElementById("s_contract_id").value=grp_contract_no;
				document.getElementById("s_money_id").value=s_money;
				core.ajax.sendPacket(pactket1,doyz);
				pactket1=null;
			}
			else if(returnValue=="3")
			{
				//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ begin
				var h=300;
			  var w=680;
			  var t=screen.availHeight/2-h/2;
			  var l=screen.availWidth/2-w/2;
			  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
			  var path1="../s1300/getNsrsbh.jsp?param_no="+"<%=unit_id%>"+"&param_type=1";
			  var returnValue1 = window.showModalDialog(path1,"",prop);
			  //alert("test returnValue1 is "+returnValue1);
				//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ end
				
				//alert("���ӵ�");
				var s_kpxm="zg45_����Ԥ����Ʊ";
				var s_ghmfc=document.frm1508_2.items.value;
				var s_jsheje=s_sum_money.toFixed(2);//��˰�ϼƽ��
				var s_hjbhsje=0;//�ϼƲ���˰���
				var s_hjse=0;
				var s_xmmc="����Ԥ����Ʊ";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
				var s_ggxh="";
				var s_hsbz="1";//��˰��־ 1=��˰
				var s_xmdj=s_sum_money.toFixed(2);
				var s_xmje=s_sum_money.toFixed(2);
				var s_sl="*";
				var s_se="0";

				var op_code="zg45";
				var payaccept="<%=paySeq%>";
				var id_no="0";
				var sm_code="0";
				var phone_no="<%=unit_id%>";
				var pay_note=s_kpxm;
				var returnPage="../zg45/zg45_1.jsp";
				var chbz="1";
				var contractno="0";
				var kphjje=s_xmje;
				//xl add ������� begin
				var u_id = document.getElementById("u_id").value;
				var u_name = document.getElementById("u_name").value;
				var  begin_time = document.frm1508_2.begin_time.value;
				var manager_name = document.frm1508_2.manager_name.value;
				var begin_time1 = begin_time.substring(0,4)+begin_time.substring(5,7)+begin_time.substring(8,10);
				var s_moneys  = document.getElementById("s_sum").value;
				//alert("grp_phone_no is "+grp_phone_no+" and grp_contract_no is "+grp_contract_no);
				//end of �������
				//document.frm1508_2.action="PrintInvoice_dz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code=zg45&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note=zg45Ԥ����Ʊ&chbz=1"+"&returnPage="+returnPage+"&xmsl=1"+"&contractno="+contractno+"&hjbhsje="+s_hjbhsje+"&kphjje="+kphjje+"&u_id="+u_id+"&u_name="+u_name+"&begin_time="+begin_time1+"&manager_name="+manager_name+"&begin_time1="+begin_time1+"&grp_phone_no="+grp_phone_no+"&grp_contract_no="+grp_contract_no+"&payaccept="+payaccept+"&s_moneys="+s_moneys+"&s_money="+s_money;//s_money������
				//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ begin
				document.frm1508_2.action="PrintInvoice_dz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code=zg45&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note=zg45Ԥ����Ʊ&chbz=1"+"&returnPage="+returnPage+"&xmsl=1"+"&contractno="+contractno+"&hjbhsje="+s_hjbhsje+"&kphjje="+kphjje+"&u_id="+u_id+"&u_name="+u_name+"&begin_time="+begin_time1+"&manager_name="+manager_name+"&begin_time1="+begin_time1+"&grp_phone_no="+grp_phone_no+"&grp_contract_no="+grp_contract_no+"&payaccept="+payaccept+"&s_moneys="+s_moneys+"&s_money="+s_money+"&s_gmfsbh="+returnValue1;//s_money������
				//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ end
				document.frm1508_2.submit(); 
				
			}
			else
			{
				//Ҳ���ô�ӡ�վݵ��Ǹ��ӿ� ��ʱ��úú�����Ū
				//alert("����ȡ���ӿ�");
				var paySeq="<%=paySeq%>";
				var phoneno="<%=unit_id%>";
				var s_money1 = document.getElementById("s_sum").value;
				var kphjje=s_money1;//��Ʊ�ϼƽ��
				var s_hjbhsje=0;//�ϼƲ���˰���
				var s_hjse=0;
				var s_xmmc=document.frm1508_2.items.value;//��Ŀ���� crm����Ϊ����? ����zg17������ô����
				//+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=���Žɷ�";
				document.frm1508_2.action="../s1300/PrintInvoice_qx.jsp?opCode=zg44&paySeq="+paySeq+"&phoneno="+phoneno+"&kphjje="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage=../zg45/zg45_1.jsp&paynote=����Ԥ����Ʊ&hsbz=1&xmdj="+s_money1+"&contractno=0&id_no=0&sm_code=0&chbz=1&s_xmmc="+s_xmmc;
				
				document.frm1508_2.submit();
			 
			}
			//end of �°淢Ʊ
			 
			 
		}
		else
		{
			rdShowMessageDialog("�빴ѡ�����߷�Ʊ�ļ�����Ϣ!");
			return false;
		}
	}
	   
	//ȫѡ
	function doSelectAllNodes()
	{
		//document.all.sure.disabled=false;
		if(document.getElementById("check_all_id").checked)
		{
			var regionChecks = document.getElementsByName("regionCheck");
			for(var i=0;i<regionChecks.length;i++){
				regionChecks[i].checked=true;
			}
			document.getElementById("check_not_id").checked=false;
		}
		
		 
	}
	function doCancelChooseAll()
	{
		if(document.getElementById("check_not_id").checked)
		{
			var regionChecks = document.getElementsByName("regionCheck");
			for(var i=0;i<regionChecks.length;i++){
				regionChecks[i].checked=false;
			}
			document.getElementById("check_all_id").checked=false;
		}	
	}
</script>

<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>
<input type="hidden" id="s_phone_id">
<input type="hidden" id="s_contract_id">
<input type="hidden" id="s_money_id">
      <table cellspacing="0"  >
                <tr> 
                  <th>���⼯�ź���</th>
				  <th >���⼯������</th>
				  <th >��Ʊ��Ŀ</th>
				  <th >�ͻ���������</th>
				  <!--xl add for -->
				  <th >Ԥ�Ƶ�������</th>
                </tr>
			    <tr>
					<td  ><%=sArr[0][0]%></td>
					<td><%=sArr[0][1]%></td>
					<td><input type="text" name="items" maxlength="33"></td>
					<td><input type="text" name="manager_name"></td>
					<input type="hidden" id="u_id" value="<%=sArr[0][0]%>">
					<input type="hidden" id="u_name" value="<%=sArr[0][1]%>">
					<td width="35%">
						<input type="text" name="begin_time" id="begin_time" size="18" readonly="true"/>&nbsp;
						<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(begin_time);return false' alt=�������������˵� align=absMiddle readonly></td>
					</td>
				</tr>
				<tr> 
                  <th>���ų�Ա�ֻ�����</th>
				  <th>���ų�Ա�˻�����</th>
				  <th>���ų�Ա����</th>
				  <th>Ԥ����Ʊ���</th>
				  <th>
					 
					<input type="checkbox" id="check_all_id" onclick="doSelectAllNodes()">ȫѡ &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" id="check_not_id" onclick="doCancelChooseAll()">ȡ��ȫѡ 
				 
				  </th>
                </tr>
		<%
			for(int i=0;i<sArr.length;i++)
			{
							sparas_name[1]="s_contract_no="+sArr[i][3];
							%>
							<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="sCodename" retmsg="sMsgname" outnum="1" >
								<wtc:param value="<%=sparas_name[0]%>"/>
								<wtc:param value="<%=sparas_name[1]%>"/> 
							</wtc:service>
							<wtc:array id="sArr_name" scope="end"/>
							<%
								if(sArr_name.length>0)
								{
									%>
									   <tr>
											<td><input type="hidden" id="s_phone<%=i%>" value="<%=sArr[i][2]%>"><%=sArr[i][2]%></td>
											<td><input type="hidden" id="s_contract<%=i%>" value="<%=sArr[i][3]%>"><%=sArr[i][3]%></td>
											<td><%=sArr_name[0][0]%></td>
											<td><input type="text" id="s_money<%=i%>" ></td>
											<td><input type="checkbox" name="regionCheck" id="chks<%=i%>"></td>
										</tr>
									<%
								}
								else
								{
									%>
										<script language="javascript">
											alert("�û������ѯ������!");
											//rdShowMessageDialog("�û�������� ���������!");
											return false;
										</script>
									<%
								}
							
						}
				%>
        <input type="hidden" id="s_sum" name="s_sum1"> 
          <tr id="footer"> 
      	    <td colspan="5">
			  <input class="b_foot" name=back onClick="doCfm() " type=button value=Ԥ�����ŷ�Ʊ>
    	      <input class="b_foot" name=back onClick="window.location = 'zg45_1.jsp'  " type=button value=����>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
 
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("��ѯʧ��: <%=retMsg1%>,<%=retCode1%>",0);
	window.location="zg45_1.jsp?opCode=zg27&opName=��ֵ˰���ַ�Ʊ��������";
	</script>
<%}
%>
		 



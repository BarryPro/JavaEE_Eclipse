<%
/********************
 * version v2.0
 * ������: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String opCode = "zgaj";
    String opName = "һ���˷�";
	String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	String op_code = "zgaj";  //��������
	String s_tf_type = request.getParameter("searchType");//��������ԭ��
	String work_no = (String)session.getAttribute("workNo"); 
	String phone_no = request.getParameter("phone_no"); 
	String beginTime =  request.getParameter("beginTime");
	String endTime = request.getParameter("endTime");

	String sqlCheckType = "42";
	String sqlBillType="43";
	String time_sql="40";
	String tsdzls = request.getParameter("tsdzls");
	System.out.println("ffffffffffffffffffffffffffffffffffffffffffffffff zgaj phone_no is "+phone_no+" and beginTime is "+beginTime+" and searchType is "+s_tf_type); 
	// ������
	String sql_reason = "select first_code,first_name from SREFUNDCheckType where valid_flag='2' union all select first_code,first_name from SREFUNDCheckType where valid_flag='3' order by first_code desc";
	int i_count=0;//�ܼ�¼��
	int pageCount = 0;//�ּ�ҳ

	//xl add ��ѯ�����޶� begin
	int i_login_count=0;
	String[] inPara2 = new String[2];
	inPara2[0]="select to_char(count(*)) from shighlogin_boss where login_no=:s_login_no and op_code='zgau' ";
	inPara2[1]="s_login_no="+work_no;
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode1count" retmsg="retMsg1count" outnum="1">
		<wtc:param value="<%=inPara2[0]%>"/>
		<wtc:param value="<%=inPara2[1]%>"/>
	</wtc:service>
	<wtc:array id="ret_val_count" scope="end" />
	<%
	if(ret_val_count.length>0)
	{
		i_login_count=Integer.parseInt(ret_val_count[0][0]);
	}
	%>
<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=sql_reason%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end" />

	<wtc:service name="sBossDefSqlSel"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=time_sql%>"/> 
	  </wtc:service>
  	<wtc:array id="returnTime" scope="end" /> 
	<wtc:service name="sBossDefSqlSel"  outnum="2" >
		<wtc:param value="<%=sqlCheckType%>"/> 
	</wtc:service>
	<wtc:array id="sCheckTypeStr" scope="end"/>
	
	<wtc:service name="sBossDefSqlSel"  outnum="2" >
		<wtc:param value="<%=sqlBillType%>"/> 
	</wtc:service>
	<wtc:array id="sBillTypeStr" scope="end"/>

<wtc:service name="s4141_showinfo" routerKey="phone" routerValue="<%=phone_no%>" retcode="retcode2" retmsg="regmsg2" outnum="12" >
    <wtc:param value="<%=phone_no%>"/>
	<wtc:param value="<%=beginTime%>"/>
	 
	<wtc:param value="1"/><!--�ڼ�ҳ-->
	<wtc:param value="50"/><!--ÿҳ��50����¼-->
	<wtc:param value="<%=s_tf_type%>"/>
</wtc:service>
<wtc:array id="r_return_code" scope="end" start="0"  length="2"/>
<wtc:array id="sretshow" scope="end" start="2"  length="9"/>
<wtc:array id="r_count" scope="end" start="11"  length="1"/>
<%
	if ( retcode2=="000000"|| retcode2.equals("000000"))
	{
		i_count = Integer.parseInt(r_count[0][0]);
		pageCount = (i_count%50==0)?(i_count/50):(i_count/50+1);
		System.out.println("fffffffffffffffffffffffffffffffffffffffffffffffffff i_count is "+i_count+" and pageCount is "+pageCount);
		


%>
 
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>һ���˷��굥��¼��ѯ</TITLE>
</HEAD>
<body onload="inits()">


<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
<script language="javascript">
	function tochange()
	{
		var s_test = document.all.searchType1[document.all.searchType1.selectedIndex].value;
		if(s_test=="1")
		{
			document.getElementById("reason_id").style.display="block";
		}
		else
		{
			document.getElementById("reason_id").style.display="none";
		}

	}
	function docal()
	{
		 
		var len = "";
		len=document.frm.checkname.length;
		var check_flag=0;//0����ûѡ�� 1������ѡ��
		var s_sum="";//�ܽ�� Ϊ��������ȷ��չʾ
		var s_ds_flag="";//1->����  2->˫��
		var s_btje = document.frm.btje.value;
	//	alert(s_btje);
		if(len==undefined)//�굥ֵֻ��һ�� �������� ��һ�������ļ�¼
		{
			i=0;
		//	alert("test here Number(s_btje) is "+Number(s_btje));
			len=1;
			check_flag=1;
			if(document.frm.checkname.checked)
			{
				 
				var s_fy = document.getElementById("tfje"+i).value;
				 
				fyArrays.push(s_fy);
				s_sum=Number(s_sum)+Number(s_fy);
			}
			s_sum = Number(s_sum)+Number(s_btje);
			//alert("s_sum is "+s_sum);
		}	
		else
		{
			for (i = 0; i < len; i++)
			{
				if(document.frm.checkname[i].checked) 
				{
		 
					var s_fy = document.getElementById("tfje"+i).value;
					 
					s_sum=Number(s_sum)+Number(s_fy) ;
					//alert("i is "+i+" and s_fy is "+s_fy+" and s_sum is "+s_sum); 
					//len++;
				}
			}
			s_sum= Number(s_sum)+Number(s_btje);
		}
		//�жϵ�˫�� checkds
		if(document.frm.checkds.checked)
		{
			//alert("˫�� s_sum is "+s_sum*2);
			s_ds_flag="2";
			s_sum=s_sum*2;
		}
		else
		{
			s_ds_flag="1";
		}
	 
		document.all.stze.value=s_sum.toFixed(2);
		document.all.tfnote.value=<%=phone_no%>+"�˷�:"+document.all.stze.value;
		 
	}
	function doallckeck()
	{
		if(document.getElementById("allcheck").checked)
		{
			var regionChecks = document.getElementsByName("checkname");
			for(var i=0;i<regionChecks.length;i++){
				if(regionChecks[i].disabled!=true)
				{
					regionChecks[i].checked=true;
				}
				
			}
		}
	}
	function inits()
	{
	   document.getElementById("reason_id").style.display="none";
	}
	function dotf()
	{
		var ywsysjArrays=[];//ҵ��ʹ��ʱ��
		var syfsArrays=[];//ʹ�÷�ʽ		
		var ywmcArrays=[];//ҵ������
		//  �����ṩ�� ��ҵ���� �������� ���� �Ƿ��˷�
		var ywdmArrays=[];//ҵ�����
		var fwtgsArrays=[];//�����ṩ��
		var qydmArrays=[];//��ҵ����
		var fylxArrays=[];//��������
		var fyArrays=[];//����
		var len = "";
		len=document.frm.checkname.length;
		var check_flag=0;//0����ûѡ�� 1������ѡ��
		var s_sum="";//�ܽ�� Ϊ��������ȷ��չʾ
		var s_ds_flag="";//1->����  2->˫��
		var s_btje = document.frm.btje.value;
	//	alert(s_btje);
		if(len==undefined)//�굥ֵֻ��һ�� �������� ��һ�������ļ�¼
		{
			i=0;
		//	alert("test here Number(s_btje) is "+Number(s_btje));
			len=1;
			check_flag=1;
			if(document.frm.checkname.checked)
			{
				var s_ywsysj = document.getElementById("ywsysj"+i).value;
				//var s_syfs = document.getElementById("syfs"+i).value;
				var s_ywmc = document.getElementById("ywmc"+i).value;
				var s_ywdm = document.getElementById("ywdm"+i).value;
				var s_fwtgs = document.getElementById("tgs"+i).value;
				var s_qydm = document.getElementById("qydm"+i).value;
				var s_fylx = document.getElementById("fylx"+i).value;
				var s_fy = document.getElementById("tfje"+i).value;
				ywsysjArrays.push(s_ywsysj);
				//syfsArrays.push(s_syfs);
				ywmcArrays.push(s_ywmc);
				ywdmArrays.push(s_ywdm);
				fwtgsArrays.push(s_fwtgs);
				qydmArrays.push(s_qydm);
				fylxArrays.push(s_fylx);
				fyArrays.push(s_fy);
				s_sum=Number(s_sum)+Number(s_fy);
			}
			s_sum = Number(s_sum)+Number(s_btje);
			//alert("s_sum is "+s_sum);
		}	
		else
		{
			for (i = 0; i < len; i++)
			{
				if(document.frm.checkname[i].checked) 
				{
					check_flag=1;
					var s_ywsysj = document.getElementById("ywsysj"+i).value;
					//var s_syfs = document.getElementById("syfs"+i).value;
					var s_ywmc = document.getElementById("ywmc"+i).value;
					var s_ywdm = document.getElementById("ywdm"+i).value;
					var s_fwtgs = document.getElementById("tgs"+i).value;
					var s_qydm = document.getElementById("qydm"+i).value;
					var s_fylx = document.getElementById("fylx"+i).value;
					var s_fy = document.getElementById("tfje"+i).value;
					ywsysjArrays.push(s_ywsysj);
					//syfsArrays.push(s_syfs);
					ywmcArrays.push(s_ywmc);
					ywdmArrays.push(s_ywdm);
					fwtgsArrays.push(s_fwtgs);
					qydmArrays.push(s_qydm);
					fylxArrays.push(s_fylx);
					fyArrays.push(s_fy);
					s_sum=Number(s_sum)+Number(s_fy) ;
					//alert("i is "+i+" and s_fy is "+s_fy+" and s_sum is "+s_sum); 
					//len++;
				}
			}
			s_sum= Number(s_sum)+Number(s_btje);
		}
		//�жϵ�˫�� checkds
		if(document.frm.checkds.checked)
		{
			//alert("˫�� s_sum is "+s_sum*2);
			s_ds_flag="2";
			s_sum=s_sum*2;
		}
		else
		{
			s_ds_flag="1";
		}
		//alert("s_ds_flag is "+s_ds_flag+" and s_sum is "+s_sum);
		document.all.stze.value=s_sum.toFixed(2);
		document.all.tfnote.value=<%=phone_no%>+"�˷�:"+document.all.stze.value;
		/*
		if(ywmcArrays=="")
		{
			rdShowMessageDialog("������ѡ��һ�н����˷Ѳ���!");
		}
		else
		{*/
			var url="zgaj_Cfm.jsp?tfhm=<%=phone_no%>&ywsysjArrays="+ywsysjArrays+"&ywmcArrays="+ywmcArrays+"&ywdmArrays="+ywdmArrays+"&fwtgsArrays="+fwtgsArrays+"&qydmArrays="+qydmArrays+"&fylxArrays="+fylxArrays+"&fyArrays="+fyArrays+"&s_ds_flag="+s_ds_flag;
			var url_new =url;//URLencode(url);
			//alert(url);
			document.frm.action=url_new;
			//xl add �������
			var s_money=s_sum.toFixed(2);
			if("<%=work_no.substring(0,2)%>"=="80")
			{
				if("<%=i_login_count%>">=1 &&s_money>300)
				{
					rdShowMessageDialog("�˷��ܽ����Դ���300Ԫ!");
					return;
				}
				else if("<%=i_login_count%>"==0 &&s_money>150)
				{
					rdShowMessageDialog("�˷��ܽ����Դ���150Ԫ!");
					return;
				}
			}		
			
			 

			var	prtFlag = rdShowConfirmDialog("�˷��ܽ��Ϊ"+s_sum.toFixed(2)+"Ԫ,�Ƿ�ȷ�����β���?");
			if (prtFlag==1)
			{
				//alert("bizcodeArrays is "+bizcodeArrays);
				document.frm.yjtf.disabled=true;
				document.frm.submit();  
			}
			else
			{
				return false;
			}
		//}
	}
	function dofy()
	{
		var toPage = Number(document.all.s_fenye[document.all.s_fenye.selectedIndex].value)+1;
		//alert("fy"+toPage);
		location = "zgaj_fy.jsp?toPage=" + toPage+"&tfhm=<%=phone_no%>&beginTime=<%=beginTime%>&endTime=<%=endTime%>&s_tf_type=<%=s_tf_type%>&tsdzls=<%=tsdzls%>&i_login_count=<%=i_login_count%>";
	}
</script>
<div class="title">
	<div id="title_zi">һ���˷��굥��¼��ѯ���</div>
</div>

      <table cellspacing="0">
		<tr>
			<td class="blue">���</td>
			<td class="blue">�˷Ѻ���</td>
			<td class="blue">ҵ��ʹ��ʱ��</td>
			<td class="blue">ʹ�÷�ʽ</td>
			<td class="blue">ҵ������</td>
			<td class="blue">ҵ�����</td>
			<td class="blue">��ҵ����</td>
			<td class="blue">��ҵ����</td>
			<td class="blue">��������</td>
			<td class="blue">����</td>
			<td class="blue">�Ƿ��˷�</td>
		</tr>
		<%
			for(int i=0;i<sretshow.length;i++)
			{	
				%>
					<tr>
						<td>
							<%=i+1%>
						</td>
						<td>
							<%=phone_no%>
						</td>
						<td>
							<%=sretshow[i][0]%>
							<input type="hidden" id="ywsysj<%=i%>" value="<%=sretshow[i][0]%>">
						</td>
						<td>
							<%=sretshow[i][1]%>
						</td>
						<td>
							<%=sretshow[i][2]%>
							<input type="hidden" id="ywmc<%=i%>" value="<%=sretshow[i][2]%>">
						</td>
						<td>
							<%=sretshow[i][3]%>
							<input type="hidden" id="ywdm<%=i%>" value="<%=sretshow[i][3]%>">
						</td>
						<td>
							<%=sretshow[i][4]%>
							<input type="hidden" id="tgs<%=i%>" value="<%=sretshow[i][4]%>">
						</td>
						<td>
							<%=sretshow[i][5]%>
							<input type="hidden" id="qydm<%=i%>" value="<%=sretshow[i][5]%>">
						</td>
						<td>
							<%=sretshow[i][6]%>
							<input type="hidden" id="fylx<%=i%>" value="<%=sretshow[i][6]%>">
						</td>
						<td>
							<%=sretshow[i][7]%>
							<input type="hidden" id="tfje<%=i%>" value="<%=sretshow[i][7]%>">
						</td>
						<td>
							<%
								if(sretshow[i][8]=="Y" ||sretshow[i][8].equals("Y"))
								{
									%><input type="checkbox" name="checkname" style="background-color:blue;color:red;border-color:black" id="jtCheck<%=i%>" disabled/><%
								}
								else
								{	%>
										<input type="checkbox" name="checkname" id="jtCheck<%=i%>">
									<%
								}
							%>
							
						</td>
					</tr>
				<%
			}
		%>
		
		 <input type="hidden" name="s_tf_type" value="<%=s_tf_type%>">
		 <input type="hidden" name="tsdzls" value="<%=tsdzls%>">
			
	</table>          
	<table>
		<!--
		tui
		�����˷�ҵ�����ƣ�ҵ���б�ͬ�˷�ҵ���б����ӡ������������롰������ʱ�����ڱ�ע�ı�����ע������ҵ�����ƣ����� �����Զ�չʾ������ע
		-->
		<tr>
			<td>˫���˷� <input type="checkbox" name="checkds" ></td>
			<td>�˷����� <select name="tfzl"><option value="2" selected>��Ԥ��</option></td>
			<td>�Ʒ����� <select size=1 name=jflx  >
						  <%for(int i = 0 ; i < sBillTypeStr.length ; i ++)
							{
							if(sBillTypeStr[i][1].equals("����/�����Ʒ�")){
								%>
								<option value="<%=sBillTypeStr[i][0]%>" selected >
					
									  <%=sBillTypeStr[i][1]%></option>
								<%
							}else{
								%>
								<option value="<%=sBillTypeStr[i][0]%>">
					
										 <%=sBillTypeStr[i][1]%></option>
								<%
								}
							}
						  %>
					</select>
				</td>
		</tr>
		
		<tr>
			<td>�˼����� <select size=1 name=hjlx>
							  <%for(int i = 0 ; i < sCheckTypeStr.length ; i ++){
							  if(sCheckTypeStr[i][1].equals("�˷�")){
									%>
									<option value="<%=sCheckTypeStr[i][0]%>" selected >
						
						                  <%=sCheckTypeStr[i][1]%></option>
									<%
								}
							   else
							   {
									%>
									<option value="<%=sCheckTypeStr[i][0]%>"><%=sCheckTypeStr[i][1]%></option>
							 		<%
							   }		 
							 
							  }%>
							</select>
							
	        </td>		
	        <td colspan="2">�˼�ʱ�� <input name="hjsj" type="text" id="hjsjId" value="<%=returnTime[0][0]%>" >
			</td>
		</tr>
		
		<tr>
			<td>
				�����˷�ҵ������ <select name="searchType1" onchange="tochange()" >
									<%
										for(int i=0;i<ret_val.length;i++)
										{
											%>
											<option value="<%=ret_val[i][0]%>"><%=ret_val[i][1]%></option>
											<%
										}
									%>
								 </select>
			</td>
			<td colspan="2">�����˷ѽ�� <input type="text" name="btje" onKeyPress="return isKeyNumberdot(1)" ></td>
		</tr>
		<tr id="reason_id">
			<td colspan="4">����ҵ������ <input type="text" name="otherReason">
			</td>
		</tr>
		<tr>
			<td colspan="4">
				��ע <input type="text" name="tfnote" size="100">
			</td>
		</tr>
		<tr>
			<td >ʵ���ܶ� <input type="text" name="stze" readonly></td>
			<td colspan="3"><input class="b_foot" name="jisuan" onClick="docal()" type=button value=����></td>
		</tr>
		<!--
		<tr>
			<td rowspan="3">
				ȫѡ<input type="checkbox" id="allcheck" onclick="doallckeck()">
			</td>
		</tr>
		-->
		<tr>
			<td colspan="3">
				��<%=i_count%>����¼,ÿҳ50����¼.��<%=pageCount%>ҳ,��ǰ��1ҳ.&nbsp;&nbsp;��ҳ:<select name="s_fenye" onchange="dofy()"> 
						<%
							for(int i=0;i<pageCount;i++)	
							{
								if(i==0){//��һҳ Ĭ��д�� ����Ŀɴ���
									%>
									<option value="<%=i%>" selected >
										��<%=i+1%>ҳ</option>
									<%
								}
								else
								{
									%>
									<option value="<%=i%>">
										��<%=i+1%>ҳ
									</option>
									<%
								}
							}	
						%>
					</select>
			</td>
		</tr>
	</table>  
    <table cellspacing="0" >     
          <tr id="footer"> 
      	    <td colspan="10">
			  <input class="b_foot" name="yjtf" onClick="dotf()" type=button value=�˷�>&nbsp;&nbsp;
    	      <input class="b_foot" name=back onClick="window.location.href='zgaj_1.jsp'" type=button value=����>
			</td>
          </tr>
          
      </table>
      
   
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("�굥�ļ���ѯ����ʧ��,�������:<%=retcode2%>,����ԭ��:<%=regmsg2%>",0);
	window.location="zgaj_1.jsp";
	</script>
<%}
%>


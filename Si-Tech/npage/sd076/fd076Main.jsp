<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����ͨ��ԭ���������˷�����������ҵ��
   * �汾: 2.0
   * ����: 2011/1/5
   * ����: weigp
   * ��Ȩ: si-tech
   * update: wanglma 20110527
   */
%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String phoneNo = request.getParameter("phoneNo");
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	String custSql = "   select doc.cust_name,doc.id_iccid,doc.id_type,sm.sm_name from dcustmsg msg,dcustdoc doc ,ssmcode sm where msg.cust_id = doc.cust_id and substr(msg.run_code,2,1) = 'A'  and msg.phone_no='"+phoneNo+"'  and substr(msg.belong_code,0,2)=sm.region_code and msg.sm_code=sm.sm_code";
	String custName = "";
	String propBirthday = "";
	String idNo = "";
	java.util.Date date = new java.util.Date();
	java.text.DateFormat format = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
	String todayTime = format.format(date);

	String chnSource		= "10";	//������ʶ
	String loginNo			= (String)session.getAttribute("workNo");	//��������
	String loginPwd			= (String)session.getAttribute("password");	//��������
	String userPwd			= "";	//��������
	String type_flag		= "";
	String offer_id			= "";
	String startTime		= "";
	String endTime			= "";
	//String custName			= "";
	String sm_name      ="";
	String custSex			= "";
	//String propBirthday		= "";
	//String idNo		= "";
	String propDistrict		= "";
	String custAddr		= "";
	String propTelephone	= "";
	String feeFlag			= "";
	String feePhone			= "";
	String password			= "";
	String userAccounts		= "";
	String propCommunity	= "";
	String propUrgentRoutes	= "";
	String propLifeStyle	= "";
	String isReportSafe		= "";
	String reportCycle		= "";
	String reportName		= "";
	String reportMobile		= "";
	String reportWay		= "";
	String famRelaInfoStr	= "";
	String firstRelaInfoStr	= "";
	String friRelaInfoStr	= "";
	String neiRelaInfoStr	= "";
	String PrintAccept="";
	
	String d076OfrIds="";
	String d076OfrNms="";
	String d076OfrCms="";
	
  PrintAccept = getMaxAccept();
%>

<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>����ͨ</title>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
		<wtc:sql><%=custSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result11" scope="end" />
<%
		if(result11.length <= 0){
%>
<script language="JavaScript">
			rdShowMessageDialog("���û����������û���״̬��������");
			window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
			return ;
		}else{
			String isIdCarOpen=result11[0][2];
			if(isIdCarOpen.equals("0")||isIdCarOpen.equals("00"))
			{
				custName = result11[0][0];
				idNo = result11[0][1];
				sm_name = result11[0][3];
				if(idNo.length() == 18){
					propBirthday = idNo.substring(6, 14);
				}else{
					propBirthday = "";
				}
			}else
				{
%>
<script language="JavaScript">
			rdShowMessageDialog("�����֤�������û����ܰ���");
			window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
				}


		}
%>
<%
		if("d077".equals(opCode)){ 
%>
		<wtc:service name="sD076Qry" routerKey="regionCode" 
			routerValue="<%=regionCode%>" 
			retcode="rcD076" retmsg="rmD076"  outnum="28">
			<wtc:param value="<%=PrintAccept%>" />
			<wtc:param value="<%=chnSource%>" />
			<wtc:param value="d076" />
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=loginPwd%>" />
			<wtc:param value="<%=phoneNo%>" /> 
			<wtc:param value="<%=userPwd%>" />
		</wtc:service>
		<wtc:array id="rstD076Qry" scope="end" />
		<%
		if ( !rcD076.equals("000000") )
		{
		%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=rcD076%>��������Ϣ��<%=rmD076%>",0);
				window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
			</script>					
		<%
		}
		
		if (rstD076Qry.length==0)
		{
		%>
			<script language="JavaScript">
				rdShowMessageDialog("����û�з��ض�Ӧ�ʷ�!",0);
				window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
			</script>			
		<%
		}
		
		d076OfrIds =rstD076Qry[0][0];
		d076OfrNms =rstD076Qry[0][1];
		d076OfrCms =rstD076Qry[0][2];
	
		System.out.println("d077~~~~d076OfrIds="+d076OfrIds
			+"~~~~d076OfrNms="+d076OfrNms
			+"~~~~d076OfrCms="+d076OfrCms);	
		%>

		<wtc:service name="sD077Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="28">
			<wtc:param value="<%=PrintAccept%>" />
			<wtc:param value="<%=chnSource%>" />
			<wtc:param value="<%=opCode%>" />
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=loginPwd%>" />
			<wtc:param value="<%=phoneNo%>" /> 
			<wtc:param value="<%=userPwd%>" />
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
		if(!errCode.equals("000000")){
%>
<script language="JavaScript">
			rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
			window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
		}
		if(result1.length <= 0){
%>
<script language="JavaScript">
			rdShowMessageDialog("���û�δ�����������ͨҵ��");
</script>
<%
			return ;
		}else{

			type_flag			= ("NULL".equals(result1[0][2]))?"":result1[0][2];
			startTime			= ("NULL".equals(result1[0][3]))?"":result1[0][3];
			endTime				= ("NULL".equals(result1[0][4]))?"":result1[0][4];
			custName			= ("NULL".equals(result1[0][5]))?"":result1[0][5];
			custSex				= ("NULL".equals(result1[0][6]))?"":result1[0][6];
			propBirthday		= ("NULL".equals(result1[0][7]))?"":result1[0][7];
			idNo				= ("NULL".equals(result1[0][8]))?"":result1[0][8];
			propDistrict		= ("NULL".equals(result1[0][9]))?"":result1[0][9];
			custAddr			= ("NULL".equals(result1[0][10]))?"":result1[0][10];
			propTelephone		= ("NULL".equals(result1[0][11]))?"":result1[0][11];
			feeFlag				= ("NULL".equals(result1[0][12]))?"":result1[0][12];
			feePhone			= ("NULL".equals(result1[0][13]))?"":result1[0][13];
			userAccounts		= ("NULL".equals(result1[0][14]))?"":result1[0][14];
			propCommunity		= ("NULL".equals(result1[0][15]))?"":result1[0][15];
			propUrgentRoutes	= ("NULL".equals(result1[0][16]))?"":result1[0][16];
			propLifeStyle		= ("NULL".equals(result1[0][17]))?"":result1[0][17];
			isReportSafe		= ("NULL".equals(result1[0][18]))?"":result1[0][18];
			reportCycle			= ("NULL".equals(result1[0][19]))?"":result1[0][19];
			reportName			= ("NULL".equals(result1[0][20]))?"":result1[0][20];
			reportMobile		= ("NULL".equals(result1[0][21]))?"":result1[0][21];
			reportWay			= ("NULL".equals(result1[0][22]))?"":result1[0][22];
			famRelaInfoStr		= ("NULL".equals(result1[0][23]))?"":result1[0][23];
			firstRelaInfoStr	= ("NULL".equals(result1[0][24]))?"":result1[0][24];
			friRelaInfoStr		= ("NULL".equals(result1[0][25]))?"":result1[0][25];
			neiRelaInfoStr		= ("NULL".equals(result1[0][26]))?"":result1[0][26];
			offer_id 			= ("NULL".equals(result1[0][27]))?"":result1[0][27];
		}
%>
		<script type="text/javascript">
			$(document).ready(function(){
				if("<%=opCode%>" == "d077")//��Ϊ����ͨҵ���� ҳ���չʾ��ʽ
				{
				//alert("<%=type_flag%>")
					$("#type_flag").css("display","none");
					$("#type_flag_delete").css("display","block");
					document.all.startTime.readOnly=true;
					document.all.endTime.readOnly=true;
					if("<%=offer_id%>"=="34515")
					{
						$("#type_flag_delete").val("����ͨҵ������ײ�--34515");
					}
					if("<%=offer_id%>"=="34517")
					{
						$("#type_flag_delete").val("����ͨҵ�������ײ�--34517");
					}
					if("<%=offer_id%>"=="36724")
					{
						$("#type_flag_delete").val("����ͨA�ƻ�3Ԫ-0.50--36724");
					}
					if("<%=offer_id%>"=="36725")
					{
						$("#type_flag_delete").val("����ͨB�ƻ�5Ԫ-0.40--36725");
					}
					if("<%=offer_id%>"=="36726")
					{
						$("#type_flag_delete").val("����ͨC�ƻ�8Ԫ-0.20--36726");
					}
					if("<%=offer_id%>"=="46865")
					{
						$("#type_flag_delete").val("����ͨD�ײ�--46865");
					}
					if("<%=feeFlag%>"=="Y")
					{
					//ava	$("#trd1").css("display","block");
					}
				}
			//	$("#d0").css("display","none");
			/*	$("#tab0").css("display","none");*/
				/*====innet====*/
				$("#type_flag").val("<%=type_flag%>");
				$("#offerId").val("<%=offer_id%>");
				$("#startTime").val("<%=startTime%>");
				$("#endTime").val("<%=endTime%>");
				$("#custName").val("<%=custName%>");
				$("#idNo").val("<%=idNo%>");
				$("#custSex").val("<%=custSex%>");
				$("#propBirthday").val("<%=propBirthday%>");
				/*$("#propCommunity").val("<%=propCommunity%>");*/
				if("01" == "<%=type_flag%>"){
					$("#propDistrict").val("<%=propDistrict%>");
				}else{
					var len = $("#propDistrict_select option").length;
					$("#propDistrict_select option").each(function(){
					   if($(this).text() == "<%=propDistrict%>"){
					   	  $(this).attr("selected","selected");
					   	  changePropCommunity();
					   }	
					});
					var len = $("#propCommunity_select option").length;
					$("#propCommunity_select option").each(function(){
					   if($(this).text() == "<%=propCommunity%>"){
					   	  $(this).attr("selected","selected");
					   }	
					});
				}
				//alert($("#propDistrict_select option").length);
				$("#custAddr").val("<%=custAddr%>");
				$("#propTelephone").val("<%=propTelephone%>");
				$("#feeFlay").val("<%=feeFlag%>");
				$("#feePhone").val("<%=feePhone%>");
				$("#feePhone1").val("<%=feePhone%>");
				$("#userAccounts").val("<%=userAccounts%>");
				
				$("#propUrgentRoutes").val("<%=propUrgentRoutes%>");
				$("#propLifestyle").val("<%=propLifeStyle%>");
				$("#isReportSafe").val("<%=isReportSafe%>");
				//alert($("#isReportSafe").val());
				$("#reportCycle").val("<%=reportCycle%>");
				$("#reportName").val("<%=reportName%>");
				$("#reportMobile").val("<%=reportMobile%>");
				$("#reportWay").val("<%=reportWay%>");
				var famRelaInfo   = "<%=famRelaInfoStr%>";
				var firstRelaInfo = "<%=firstRelaInfoStr%>";
				var friRelaInfo   = "<%=friRelaInfoStr%>";
				var neiRelaInfo   = "<%=neiRelaInfoStr%>";
				var tab1 = document.getElementById("tab1");
				//alert($("#type_flag").val());
					if(famRelaInfo!="")
					{
						var fams = famRelaInfo.split("|");
						for(var i=0;i<fams.length;i++){
						/*�����޸İ�ť
						var tempData = fams[i].replace("~","-").replace("~","-").replace("~","-").replace("~","-").replace("~","-").replace("~","-").replace("~","-");
						fams[i] += "~<input type='button' class='b_text' value='�޸�' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode),window.open(\"fd076_personInfo.jsp?method=addRela&tabData="+tempData+"\",\"������Ϣ\",\"width=400,height=360,left=400,top=200\");'/>";
						*/
						fams[i] += "~<input type='button' class='b_text' value='ɾ��' onclick='deleteTR(this,2);'/>";
						//alert(fams[i]);
						var tabData = fams[i].replace(new RegExp("~","gm"),"|");
						addTr(tab1,9,tabData);
					}
				}
				if("<%=type_flag%>" == "02"){//if �����ײ�
					$("#sq").css("display","block");
					$("#sq2").css("display","block");
					
					$("#sq3").css("display","none");
					$("#sq4").css("display","block");
					
					$("#t3").css("display","block");
					$("#t4").css("display","block");
					//$("#isReportSafe")[0].options(0).selected = true; huangrong ע��  ԭ��d077ҳ����Ƿ���Ҫ��ƽ���������ʾ������
					//alert("<%=isReportSafe%>");
					if("<%=isReportSafe%>"=="02")
					{
						$("#t1").css("display","none");
						$("#t2").css("display","none");
					}else{
						$("#t1").css("display","block");
						$("#t2").css("display","block");
					}
					//��ϵ����Ϣ
					$("#d1").css("display","none");
					$("#tab1").css("display","none");
					$("#d2").css("display","block");
					$("#tab2").css("display","block");
					$("#d3").css("display","block");
					$("#tab3").css("display","block");
					$("#d4").css("display","block");
					$("#tab4").css("display","block");
					//begin huangrong add
					//��һ��ϵ����Ϣ
					if(firstRelaInfo!="")
					{
						var tab2 = document.getElementById("tab2");
						var firsts = firstRelaInfo.split("|");
						for(var i=0;i<firsts.length;i++){
						firsts[i] += "~<input type='button' class='b_text' value='ɾ��' onclick='deleteTR(this,2);'/>";
						var tabData = firsts[i].replace(new RegExp("~","gm"),"|");
						addTr(tab2,10,tabData);
						var j = i + 1 ;
						var r = $("#tab2 tr:eq("+j+") td:eq(5)").html();
						if(r == "0"){
							$("#tab2 tr:eq("+j+") td:eq(5)").html("��") ;
						}else{
							$("#tab2 tr:eq("+j+") td:eq(5)").html("��") ;
						}
						}
					}
				//������Ϣ
					if(friRelaInfo!="")
					{
						var tab3 = document.getElementById("tab3");
						var friRelas = friRelaInfo.split("|");
						for(var i=0;i<friRelas.length;i++){
						friRelas[i] += "~<input type='button' class='b_text' value='ɾ��' onclick='deleteTR(this,3);'/>";
						var tabData = friRelas[i].replace(new RegExp("~","gm"),"|");
						addTr(tab3,7,tabData);
						var j = i + 1 ;
						var r = $("#tab3 tr:eq("+j+") td:eq(4)").html();
						if(r == "0"){
							$("#tab3 tr:eq("+j+") td:eq(4)").html("��") ;
						}else{
							$("#tab3 tr:eq("+j+") td:eq(4)").html("��") ;
						}
						}
					}
				//�ھ���Ϣ
			//	alert(neiRelaInfo);
					if(neiRelaInfo!="")
					{
						var tab4= document.getElementById("tab4");
						var neiRelas = neiRelaInfo.split("|");
						for(var i=0;i<neiRelas.length;i++){
						neiRelas[i] += "~<input type='button' class='b_text' value='ɾ��' onclick='deleteTR(this,2);'/>";
						var tabData = neiRelas[i].replace(new RegExp("~","gm"),"|");
						addTr(tab4,6,tabData);
						var j = i + 1 ;
						var r = $("#tab4 tr:eq("+j+") td:eq(3)").html();
						if(r == "0"){
							$("#tab4 tr:eq("+j+") td:eq(3)").html("��") ;
						}else{
							$("#tab4 tr:eq("+j+") td:eq(3)").html("��") ;
						}
						}
					}
				  //end huangrong add
				}
				/*====innet====*/
			});
//ɾ����¼����¼�ƶ��绰����
			function deleteTR(bing,phone_address){
			  if(rdShowConfirmDialog('�Ƿ�ȷ��ɾ����')==1)
				{
					  var phoneList="";
          	var tr=bing.parentNode.parentNode;
          	var tds=tr.childNodes; 
					  var phoneList=tds[phone_address].innerHTML;
					  if(document.all.phoneList.value=="")
					  {
					  	document.all.phoneList.value=phoneList;
					  }else
					  {	
				    document.all.phoneList.value =document.all.phoneList.value+"~"+phoneList;
				    }
						bing.parentNode.parentNode.parentNode.removeChild(bing.parentNode.parentNode);
						return true;
				}else
				{
					return false;
				}

			}
		</script>
<%
		}//����ͨҵ����end
		else if("d076".equals(opCode))
		{//����ͨҵ������start
			String tempSql1 = "select * from dRelaBaseMsg where id_no=(select id_no from dcustmsg where phone_no='"+phoneNo+"') and endtime =to_char(last_day(sysdate),'YYYYMMDDHH24miss') ";
			String tempSql2 = "select * from dRelaBaseMsgHis where OprType='1' and to_char(sysdate,'yyyymm')=to_char(update_time,'yyyymm') and id_no=(select id_no from dcustmsg where phone_no='"+phoneNo+"')";
	String[] inParamsss1 = new String[2];
	inParamsss1[0] = "select b.cust_address from dcustmsg a ,dcustdoc b where a.id_no =b.cust_id and a.phone_no=:phonesNO";
	inParamsss1[1] = "phonesNO="+phoneNo;
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode22" retmsg="retMsg22" outnum="2">
		<wtc:sql><%=tempSql1%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result22" scope="end" />
<%
		if(result22.length > 0){
%>
<script language="JavaScript">
			rdShowMessageDialog("���û��Ѿ����������ͨҵ��");
			window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
			return ;
		}
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcustss" scope="end" />
<!--ȡ�ͻ���ϸ��Ϣ-->

<%
if(dcustss.length>0) {
  custAddr=dcustss[0][0];
  }
		}
%>
		<script type="text/javascript">
			$(document).ready(function () {
				//���Ƿ���Ҫ�����ֻ���
				$("#feeFlay").change(function(){
					if("<%=opCode%>" == "d076")
					{
						if($("#feeFlay").val() == "Y"){
							//ava $("#trd").css("display","block");

						}else{
							$("#trd").css("display","none");
						}
					}
					if("<%=opCode%>" == "d077")
					{
						if("<%=feeFlag%>"=="Y")
						{
							if($("#feeFlay").val() == "N")
							{
								//ava $("#trd1").css("display","none");
								//ava $("#trd2").css("display","block");
							}
							else
							{
		  					//ava	$("#trd1").css("display","block");
								//ava	$("#trd2").css("display","none");
							}
						}else if("<%=feeFlag%>"=="N")
						{
							if($("#feeFlay").val() == "Y")
							{
								//ava $("#trd").css("display","block");
							}
							else
							{
		  					$("#trd").css("display","none");
							}
						}

					}
				});
				//���Ƿ���ܱ�ƽ������
				$("#isReportSafe").change(function(){
					if($("#isReportSafe").val() == "01"){
						$("#t1").css("display","block");
						$("#t2").css("display","block");
					}else{
						$("#t1").css("display","none");
						$("#t2").css("display","none");
					}
				});
				//���ײ����
				$("#type_flag").change(function(){
					if($("#type_flag").val() == "34517" ){
						$("#sq").css("display","block");
						$("#sq2").css("display","block");
						$("#sq3").css("display","none");
						$("#sq4").css("display","block");
						$("#t3").css("display","block");
						$("#t4").css("display","block");
						$("#isReportSafe")[0].options(0).selected = true;
						//�Ƿ���Ҫ��ƽ������ Ĭ������Ҫ��ƽ������ģ���˶�ҳ�汨ƽ�����ڵ���Ϣ��չʾ
						if($("#isReportSafe").val() == "01"){
							$("#t1").css("display","block");
							$("#t2").css("display","block");
						}else{
							$("#t1").css("display","none");
							$("#t2").css("display","none");
						}
						//��ϵ����Ϣ
						$("#d1").css("display","none");
						$("#tab1").css("display","none");
						$("#d2").css("display","block");
						$("#tab2").css("display","block");
						$("#d3").css("display","block");
						$("#tab3").css("display","block");
						$("#d4").css("display","block");
						$("#tab4").css("display","block");
					}else{
						$("#sq").css("display","none");
						$("#sq2").css("display","none");
						$("#sq3").css("display","block");
						$("#sq4").css("display","none");
						$("#t1").css("display","none");
						$("#t2").css("display","none");
						$("#t3").css("display","none");
						$("#t4").css("display","none");
						//��ϵ����Ϣ
						$("#d1").css("display","block");
						$("#tab1").css("display","block");
						$("#d2").css("display","none");
						$("#tab2").css("display","none");
						$("#d3").css("display","none");
						$("#tab3").css("display","none");
						$("#d4").css("display","none");
						$("#tab4").css("display","none");
					}
				});
				//�����������ť�����֤
				$("#addRela").click(function () {
					if(tab1.rows.length > 3){
						rdShowMessageDialog("������3��������Ϣ!",1);
						return ;
					}
					window.open('fd076_personInfo.jsp?method=addRela','��Ȩ��λ����Ϣ','width=400,height=360,left=400,top=200');
				});
				//�������ϵ�������֤
				$("#addFirst").click(function () {
					if(tab2.rows.length > 1){
						rdShowMessageDialog("������1����һ��ϵ����Ϣ!",1);
						return ;
					}
					window.open('fd076_personInfo.jsp?method=addFirst','��һ��ϵ����Ϣ','width=400,height=390,left=400,top=200');
				});
				//��������� �����֤
				$("#addFrid").click(function () {
					if(tab3.rows.length > 3){
						rdShowMessageDialog("������3��������ϵ����Ϣ!",1);
						return ;
					}
					window.open('fd076_personInfo.jsp?method=addFrid','������Ϣ','width=400,height=330,left=400,top=200');
				});
				//������ھ� �����֤
				$("#addNaber").click(function() {
					if(tab4.rows.length > 3){
						rdShowMessageDialog("������3���ھ���Ϣ!",1);
						return ;
					}
					window.open('fd076_personInfo.jsp?method=addNaber','�ھ���Ϣ','width=400,height=330,left=400,top=200');
				});
				//�ύ��ť
				$("#confirm").click(function() { //ȷ�ϣ�����Ϣ���
					//20120912 gaopeng�޸� �жϵ�����ǲ�����Ϣ������������Ϣ��������������ֵ��ԭ��0���Ա���������߼����� begin
					var th = $(this);
					if(th.val()=="��Ϣ���")
					{
						$("#ofrId").val("0");
					}
					//20120912 gaopeng�޸� �жϵ�����ǲ�����Ϣ������������Ϣ��������������ֵ��ԭ��0���Ա���������߼����� end
					document.all.opFlag.value="1";
						if( <%if(type_flag==null || type_flag=="" || type_flag.equals("")) {out.print("$('#type_flag').val() != '34517'");}else {out.print("'01'=="+type_flag);}%>){
						//alert($("#type_flag").val()+"qqqqqqqqqqq");
							if("<%=opCode%>" == "d076")
							{
									if($("#feeFlay").val() == "Y"){
										if($("#feePhone").val() == ""){
										rdShowMessageDialog("�����븶�Ѻ���!",1);
										return ;
										}
										if(document.all.password.value == ""){
										rdShowMessageDialog("�����븶�Ѻ�����û�����!",1);
										return ;
										}
								}
							}else if("<%=opCode%>" == "d077")
								{
									if("<%=feeFlag%>"=="Y")
										{
											if($("#feeFlay").val() == "N")
											{
												if(document.all.password1.value == ""){
												rdShowMessageDialog("�����븶�Ѻ�����û�����!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password1.value;
										}else if("<%=feeFlag%>"=="N")
										{
											if($("#feeFlay").val() == "Y")
											{
												if(document.all.password.value == ""){
												rdShowMessageDialog("�����븶�Ѻ�����û�����!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password.value;
										}


								}
							
							
							if($("#propBirthday").val() != ""){
							if($("#propBirthday").val().length!=8) {
									rdShowMessageDialog("�������ڸ�ʽ����ȷ��",1);
									return ;
								}
								if (/[^\d]/.test($("#propBirthday").val())){
									rdShowMessageDialog("�������ڸ�ʽ����ȷ��",1);
									return ;
								}

							}
							/*
							if($("#propDistrict").val() == ""){
									rdShowMessageDialog("����д������!",0);
									return ;
							}
							if($("#propTelephone").val() == ""){
									rdShowMessageDialog("����д��ס�ع̻�!",0);
									return ;
							}
							if($("#custAddr").val() == ""){
									rdShowMessageDialog("����д�ͻ���ַ!",0);
									return ;
							}
							*/
							
							//��֤������Ϣ�б��У�������������ϼ��������ж���������ƶ��绰�����Ƿ�һ��

							
							//��Ҫƴ��������ϵ�˺������
							//var affectionNoStr = joinData("relaPhone",6);
							var t = document.getElementById("tab1");
							var famRelaInfoStr = getTableData(t,0,7,1,t.rows.length);
							//alert(famRelaInfoStr);
							/*if(famRelaInfoStr == ""){
								rdShowMessageDialog("�������һ��������Ϣ!",0);
								return ;
							}
							*/
							$("#famRelaInfoStr").val(famRelaInfoStr);

						}else {//�����ײ�
							//alert($("#type_flag").val()+"-----");
							//��Ҫƴ������ź͵�һ��ϵ��   ������Ϣ   �ھ���Ϣ
							/*===========�����ײ����� start=============*/
							if($("#propBirthday").val() != ""){
							if($("#propBirthday").val().length!=8) {
									rdShowMessageDialog("�������ڸ�ʽ����ȷ��",1);
									return ;
								}
								if (/[^\d]/.test($("#propBirthday").val())){
									rdShowMessageDialog("�������ڸ�ʽ����ȷ��",1);
									return ;
								}

							}
							/*if($("#propBirthday").val() == ""){
									rdShowMessageDialog("����д��������!",0);
									return ;
							}
							
							if($("#propDistrict_select").val() == "0"){
									rdShowMessageDialog("��ѡ��������!",0);
									return ;
							}
							if($("#propCommunity_select").val() == "0"){
									rdShowMessageDialog("��ѡ������!",0);
									return ;
							}
							if($("#propTelephone").val() == ""){
									rdShowMessageDialog("����д��ס�ع̻�!",0);
									return ;
							}
							if($("#custAddr").val() == ""){
									rdShowMessageDialog("����д�ͻ���ַ!",0);
									return ;
							}
							if($("#propUrgentRoutes").val() == ""){
									rdShowMessageDialog("�����뼱�ȳ������ﳣס�ص�·��!",0);
									return ;
							}
							*/
							/*
							if($("#propLifestyle").val() == "05"){
									rdShowMessageDialog("��ѡ���������������!",0);
									return ;
							}
							*/
							if($("#isReportSafe").val() == "01"){
								if($("#reportCycle").val() == ""){
									rdShowMessageDialog("�����뱨ƽ����������Ϊ��λ!",1);
									return ;
								}
								if($("#reportName").val() == ""){
									rdShowMessageDialog("���������������!",1);
									return ;
								}
								if($("#reportMobile").val() == ""){
									rdShowMessageDialog("������������ƶ��绰!",1);
									return ;
								}
							}
							//if(feeFlay = Y)  feePhone password need



							if("<%=opCode%>" == "d076")
							{
									if($("#feeFlay").val() == "Y"){
										if($("#feePhone").val() == ""){
											rdShowMessageDialog("�����븶�Ѻ���!",1);
											return ;
										}
										if(document.all.password.value == ""){
										rdShowMessageDialog("�����븶�Ѻ�����û�����!",1);
										return ;
										}
								}
							}else if("<%=opCode%>" == "d077")
								{
									if("<%=feeFlag%>"=="Y")
										{
											if($("#feeFlay").val() == "N")
											{
												if(document.all.password1.value == ""){
												rdShowMessageDialog("�����븶�Ѻ�����û�����!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password1.value;
										}else if("<%=feeFlag%>"=="N")
										{
											if($("#feeFlay").val() == "Y")
											{
												if(document.all.password.value == ""){
												rdShowMessageDialog("�����븶�Ѻ�����û�����!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password.value;
										}

								}
							/*===========�����ײ����� end=============*/
							var firstRelaInfoStr = "";
							var friRelaInfoStr = "";
							var neiRelaInfoStr = "";
							//var affectionNoStr = joinData("relaPhone",6);
							var t2 = document.getElementById("tab2");
							var t3 = document.getElementById("tab3");
							var t4 = document.getElementById("tab4");
							firstRelaInfoStr = getTableData(t2,0,8,1,t2.rows.length);
							friRelaInfoStr = getTableData(t3,0,5,1,t3.rows.length);
							neiRelaInfoStr = getTableData(t4,0,4,1,t4.rows.length);
							//�� ��ʾ �ƶ��绰�Ƿ�������˶�λ Ϊ���ǡ��Ļ��� 0 �� ���񡱵Ļ��� 1
							firstRelaInfoStr=firstRelaInfoStr.replace(new RegExp("~��~","gm"),"~0~");
							firstRelaInfoStr=firstRelaInfoStr.replace(new RegExp("~��~","gm"),"~1~");
							friRelaInfoStr=friRelaInfoStr.replace(new RegExp("~��~","gm"),"~0~");
							friRelaInfoStr=friRelaInfoStr.replace(new RegExp("~��~","gm"),"~1~");
							neiRelaInfoStr=neiRelaInfoStr.replace(new RegExp("~��~","gm"),"~0~");
							neiRelaInfoStr=neiRelaInfoStr.replace(new RegExp("~��~","gm"),"~1~");
							/*** ningtn ����Э����������ͨABC�ײ͵ĺ� (��������) ����ɾ������
							if(firstRelaInfoStr == ""){
								rdShowMessageDialog("�������һ����һ��ϵ����Ϣ!",0);
								return ;
							}
							if(friRelaInfoStr == ""){
								rdShowMessageDialog("�������һ��������Ϣ!",0);
								return ;
							}
							*/
/*	//wanghfa 2011/8/30�޸�
							if(neiRelaInfoStr == ""){
								rdShowMessageDialog("�������һ���ھ���Ϣ!",0);
								return ;
							}
*/
						//	$("#affectionNoStr").val(affectionNoStr);
							$("#firstRelaInfoStr").val(firstRelaInfoStr);
							$("#friRelaInfoStr").val(friRelaInfoStr);
							$("#neiRelaInfoStr").val(neiRelaInfoStr);

						}
						//�� ������ �� ��������Ϣ �������ر�
						$("#propDistrict_select_hidd").val($("#propDistrict_select option:selected").val());
						$("#propCommunity_select_hidd").val($("#propCommunity_select option:selected").val());
						if("<%=opCode%>" == "d076"){
						 //��ӡ�������ύ��
						  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
						  if(typeof(ret)!="undefined")
						  {
						    if((ret=="confirm"))
						    {
						      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
						      {
							   		frmCfm();
						      }
							}
							if(ret=="continueSub")
							{
						      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
						      {
							    	frmCfm();
						      }
							}
						  }
						  else
						  {
						     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
						     {
							     frmCfm();
						     }
						  }	
						  return true;				
						}else if("<%=opCode%>" == "d077"){
						var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
						  if(typeof(ret)!="undefined")
						  {
						    if((ret=="confirm"))
						    {
						      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
						      {
							   		frmCfm1();
						      }
							}
							if(ret=="continueSub")
							{
						      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
						      {
							    	frmCfm1();
						      }
							}
						  }
						  else
						  {
						     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
						     {
							     frmCfm1();
						     }
						  }	
						  return true;

						}
				});
				$("#ofrCfm").click(function() {
					document.all.opFlag.value="0";
					if ( document.all.ofrId.value=="0" )
					{
						rdShowMessageDialog("����ʷѱ���ѡ��!",1);
						return false;
					}
						if( <%if(type_flag==null || type_flag=="" || type_flag.equals("")) {out.print("$('#type_flag').val() != '34517'");}else {out.print("'01'=="+type_flag);}%>){
						//alert($("#type_flag").val()+"qqqqqqqqqqq");
							if("<%=opCode%>" == "d076")
							{ 
									if($("#feeFlay").val() == "Y"){
										if($("#feePhone").val() == ""){
										rdShowMessageDialog("�����븶�Ѻ���!",1);
										return ;
										}
										if(document.all.password.value == ""){
										rdShowMessageDialog("�����븶�Ѻ�����û�����!",1);
										return ;
										}
								}
							}else if("<%=opCode%>" == "d077")
								{
									if("<%=feeFlag%>"=="Y")
										{
											if($("#feeFlay").val() == "N")
											{
												if(document.all.password1.value == ""){
												rdShowMessageDialog("�����븶�Ѻ�����û�����!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password1.value;
										}else if("<%=feeFlag%>"=="N")
										{
											if($("#feeFlay").val() == "Y")
											{
												if(document.all.password.value == ""){
												rdShowMessageDialog("�����븶�Ѻ�����û�����!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password.value;
										}


								}
							
							
							if($("#propBirthday").val() != ""){
							if($("#propBirthday").val().length!=8) {
									rdShowMessageDialog("�������ڸ�ʽ����ȷ��",1);
									return ;
								}
								if (/[^\d]/.test($("#propBirthday").val())){
									rdShowMessageDialog("�������ڸ�ʽ����ȷ��",1);
									return ;
								}

							}
							/*
							if($("#propDistrict").val() == ""){
									rdShowMessageDialog("����д������!",0);
									return ;
							}
							if($("#propTelephone").val() == ""){
									rdShowMessageDialog("����д��ס�ع̻�!",0);
									return ;
							}
							if($("#custAddr").val() == ""){
									rdShowMessageDialog("����д�ͻ���ַ!",0);
									return ;
							}
							*/
							
							//��֤������Ϣ�б��У�������������ϼ��������ж���������ƶ��绰�����Ƿ�һ��

							
							//��Ҫƴ��������ϵ�˺������
							//var affectionNoStr = joinData("relaPhone",6);
							var t = document.getElementById("tab1");
							var famRelaInfoStr = getTableData(t,0,7,1,t.rows.length);
							//alert(famRelaInfoStr);
							/*if(famRelaInfoStr == ""){
								rdShowMessageDialog("�������һ��������Ϣ!",0);
								return ;
							}
							*/
							$("#famRelaInfoStr").val(famRelaInfoStr);

						}else {//�����ײ�
							//alert($("#type_flag").val()+"-----");
							//��Ҫƴ������ź͵�һ��ϵ��   ������Ϣ   �ھ���Ϣ
							/*===========�����ײ����� start=============*/
							if($("#propBirthday").val() != ""){
							if($("#propBirthday").val().length!=8) {
									rdShowMessageDialog("�������ڸ�ʽ����ȷ��",1);
									return ;
								}
								if (/[^\d]/.test($("#propBirthday").val())){
									rdShowMessageDialog("�������ڸ�ʽ����ȷ��",1);
									return ;
								}

							}
							/*if($("#propBirthday").val() == ""){
									rdShowMessageDialog("����д��������!",0);
									return ;
							}
							
							if($("#propDistrict_select").val() == "0"){
									rdShowMessageDialog("��ѡ��������!",0);
									return ;
							}
							if($("#propCommunity_select").val() == "0"){
									rdShowMessageDialog("��ѡ������!",0);
									return ;
							}
							if($("#propTelephone").val() == ""){
									rdShowMessageDialog("����д��ס�ع̻�!",0);
									return ;
							}
							if($("#custAddr").val() == ""){
									rdShowMessageDialog("����д�ͻ���ַ!",0);
									return ;
							}
							if($("#propUrgentRoutes").val() == ""){
									rdShowMessageDialog("�����뼱�ȳ������ﳣס�ص�·��!",0);
									return ;
							}
							*/
							/*
							if($("#propLifestyle").val() == "05"){
									rdShowMessageDialog("��ѡ���������������!",0);
									return ;
							}
							*/
							if($("#isReportSafe").val() == "01"){
								if($("#reportCycle").val() == ""){
									rdShowMessageDialog("�����뱨ƽ����������Ϊ��λ!",1);
									return ;
								}
								if($("#reportName").val() == ""){
									rdShowMessageDialog("���������������!",1);
									return ;
								}
								if($("#reportMobile").val() == ""){
									rdShowMessageDialog("������������ƶ��绰!",1);
									return ;
								}
							}
							//if(feeFlay = Y)  feePhone password need



							if("<%=opCode%>" == "d076")
							{
									if($("#feeFlay").val() == "Y"){
										if($("#feePhone").val() == ""){
											rdShowMessageDialog("�����븶�Ѻ���!",1);
											return ;
										}
										if(document.all.password.value == ""){
										rdShowMessageDialog("�����븶�Ѻ�����û�����!",1);
										return ;
										}
								}
							}else if("<%=opCode%>" == "d077")
								{
									if("<%=feeFlag%>"=="Y")
										{
											if($("#feeFlay").val() == "N")
											{
												if(document.all.password1.value == ""){
												rdShowMessageDialog("�����븶�Ѻ�����û�����!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password1.value;
										}else if("<%=feeFlag%>"=="N")
										{
											if($("#feeFlay").val() == "Y")
											{
												if(document.all.password.value == ""){
												rdShowMessageDialog("�����븶�Ѻ�����û�����!",1);
												return ;
												}
											}
											document.all.feePwdEnd.value=document.all.password.value;
										}

								}
							/*===========�����ײ����� end=============*/
							var firstRelaInfoStr = "";
							var friRelaInfoStr = "";
							var neiRelaInfoStr = "";
							//var affectionNoStr = joinData("relaPhone",6);
							var t2 = document.getElementById("tab2");
							var t3 = document.getElementById("tab3");
							var t4 = document.getElementById("tab4");
							firstRelaInfoStr = getTableData(t2,0,8,1,t2.rows.length);
							friRelaInfoStr = getTableData(t3,0,5,1,t3.rows.length);
							neiRelaInfoStr = getTableData(t4,0,4,1,t4.rows.length);
							//�� ��ʾ �ƶ��绰�Ƿ�������˶�λ Ϊ���ǡ��Ļ��� 0 �� ���񡱵Ļ��� 1
							firstRelaInfoStr=firstRelaInfoStr.replace(new RegExp("~��~","gm"),"~0~");
							firstRelaInfoStr=firstRelaInfoStr.replace(new RegExp("~��~","gm"),"~1~");
							friRelaInfoStr=friRelaInfoStr.replace(new RegExp("~��~","gm"),"~0~");
							friRelaInfoStr=friRelaInfoStr.replace(new RegExp("~��~","gm"),"~1~");
							neiRelaInfoStr=neiRelaInfoStr.replace(new RegExp("~��~","gm"),"~0~");
							neiRelaInfoStr=neiRelaInfoStr.replace(new RegExp("~��~","gm"),"~1~");
							/*** ningtn ����Э����������ͨABC�ײ͵ĺ� (��������) ����ɾ������
							if(firstRelaInfoStr == ""){
								rdShowMessageDialog("�������һ����һ��ϵ����Ϣ!",0);
								return ;
							}
							if(friRelaInfoStr == ""){
								rdShowMessageDialog("�������һ��������Ϣ!",0);
								return ;
							}
							*/
/*	//wanghfa 2011/8/30�޸�
							if(neiRelaInfoStr == ""){
								rdShowMessageDialog("�������һ���ھ���Ϣ!",0);
								return ;
							}
*/
						//	$("#affectionNoStr").val(affectionNoStr);
							$("#firstRelaInfoStr").val(firstRelaInfoStr);
							$("#friRelaInfoStr").val(friRelaInfoStr);
							$("#neiRelaInfoStr").val(neiRelaInfoStr);

						}
						//�� ������ �� ��������Ϣ �������ر�
						$("#propDistrict_select_hidd").val($("#propDistrict_select option:selected").val());
						$("#propCommunity_select_hidd").val($("#propCommunity_select option:selected").val());
						if("<%=opCode%>" == "d076"){
						 //��ӡ�������ύ��
						  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
						  if(typeof(ret)!="undefined")
						  {
						    if((ret=="confirm"))
						    {
						      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
						      {
							   		frmCfm();
						      }
							}
							if(ret=="continueSub")
							{
						      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
						      {
							    	frmCfm();
						      }
							}
						  }
						  else
						  {
						     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
						     {
							     frmCfm();
						     }
						  }	
						  return true;				
						}else if("<%=opCode%>" == "d077"){
						var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
						  if(typeof(ret)!="undefined")
						  {
						    if((ret=="confirm"))
						    {
						      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
						      {
							   		frmCfm1();
						      }
							}
							if(ret=="continueSub")
							{
						      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
						      {
							    	frmCfm1();
						      }
							}
						  }
						  else
						  {
						     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
						     {
							     frmCfm1();
						     }
						  }	
						  return true;

						}
				});				
			});
			
			function chgOfr( ofrId)
			{
				document.all.ofrId.value=ofrId;	
			}
			
			function frmCfm()
			{
				document.f1.action="fd076Cfm.jsp";
				$("#f1").submit();
				$("#confirm").attr("disabled",true);
				$("#ofrCfm").attr("disabled",true);
			}
			function frmCfm1()
			{
							document.f1.action="fd077Cfm.jsp";
							$("#f1").submit();
							document.all.confirm.disabled = true;//Ϊ��ֹ����ȷ��
			}
			
			function showPrtDlg(printType,DlgMessage,submitCfm)
			{  //��ʾ��ӡ�Ի���
				var h=180;
				var w=350;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				
				var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
				var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
				var sysAccept ="<%=PrintAccept%>";  
<%
		if("d077".equals(opCode)){
%> 
       var printStr =  printInfo1(printType);			 		//����printinfo()���صĴ�ӡ����
        //alert("<%=opCode%>"+"-111111");
<%
		}
	  if("d076".equals(opCode))
		{
%>
       var printStr =  printInfo(printType);
        //alert("<%=opCode%>"+"-222222");
<%          			
							 	
    }
%>				
				var mode_code=null;           							//�ʷѴ���
				var fav_code=null;                				 		//�ط�����
				var area_code=null;             				 		//С������
				var opCode="d076" ;                   			 		//��������
				var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";  
				var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
				path+="&mode_code="+mode_code+
					"&fav_code="+fav_code+"&area_code="+area_code+
					"&opCode=<%=opCode%>&sysAccept="+sysAccept+
					"&phoneNo="+document.f1.phoneNo.value+
					"&submitCfm="+submitCfm+"&pType="+
					pType+"&billType="+billType+ "&printInfo=" + printStr; 
				var ret=window.showModalDialog(path,printStr,prop);
				return ret;   
			}
			
			function printInfo(printType)
			{
				var cust_info="";  				//�ͻ���Ϣ
				var opr_info="";   				//������Ϣ
				var note_info1=""; 				//��ע1
				var note_info2=""; 				//��ע2
				var note_info3=""; 				//��ע3
				var note_info4=""; 				//��ע4
				var retInfo = "";  				//��ӡ����
				
				cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
				cust_info+="�ͻ�������"+document.all.custName.value+"|";
				cust_info+="֤�����룺"+document.all.idNo.value+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				if($("#type_flag").val() == "34515"){
				   opr_info+="����ҵ������ͨҵ������ײ�"+"|";
			    }else if($("#type_flag").val() == "34517"){
			       opr_info+="����ҵ������ͨҵ�������ײ�"+"|";
			    }
			    else if($("#type_flag").val() == "36724"){
			       opr_info+="����ҵ������ͨA�ƻ�3Ԫ-0.50"+"|";
			    }
			    else if($("#type_flag").val() == "36725"){
			       opr_info+="����ҵ������ͨB�ƻ�5Ԫ-0.40"+"|";
			    }
			    else if($("#type_flag").val() == "36726"){
			       opr_info+="����ҵ������ͨC�ƻ�8Ԫ-0.20"+"|";
			    }
			    else if($("#type_flag").val() == "46865"){
			       opr_info+="����ҵ������ͨD�ײ�"+"|";
			    }
				opr_info+="������ˮ��"+document.all.loginAccept.value+"|";
				opr_info+="ҵ������ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>"+"|";
				opr_info+="�û�Ʒ�ƣ�<%=sm_name%>"+"|";
					
		    if($("#type_flag").val() != "34517")
		    {
		    	opr_info+="��λ��Ȩ������:"+"|";
		    	var t1 = document.getElementById("tab1");
					var trs=t1.rows;
					var changdu=trs.length;
			if(changdu>1)
	      	{
	      	 for(var i=1;i<changdu;i++)
		       {  
		      		var tds=trs[i].childNodes; 
			    	  opr_info+=i+"��"+tds[0].innerHTML+"/"+tds[2].innerHTML+"  ";
			    }  
		    }else{
		   			 		opr_info+="��  |";
		   		}
		   	
		   	/* begin for ��������������ͨ���ײ��ʷѺ�����Ӫ�������ĺ� @2014/12/2 */
		   	var note1 = "";
		   	var note2 = "";
				var chkPacket = new AJAXPacket ("fd076_ajax_getPrintNotes.jsp","��ȴ�������");
				chkPacket.data.add("type_flag" , $("#type_flag").val());
				core.ajax.sendPacket(chkPacket,function(packet){
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					var note1 = packet.data.findValueByName("note1");
					var note2 = packet.data.findValueByName("note2");
					if(retCode!="000000"){
	          rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
	          return false;
          }else{
          	note_info1 = note1 + "��" + note2 + "|";
          }
				});
				chkPacket =null; 		   	
		   	/* end for ��������������ͨ���ײ��ʷѺ�����Ӫ�������ĺ� @2014/12/2 */
		   	
		   	/*
		    if($("#type_flag").val() == "34515") {
		    	note_info1+="����ͨҵ������ײͣ����ܷ�8Ԫ/�£����������Ͳ��֣��򰴳�������ʷѱ�׼���շ��ã���������룺������6��������룬";
		    	note_info1+="ÿ�����ͱ��ز��������������ʱ��100���ӣ��������Ͳ���0.10Ԫ/���ӣ�������ѣ��������Ϊ���ص��й��ƶ��ֻ����룬�������ÿ��ֻ���޸�һ�Σ��޸ĺ�������Ч��";
		    	note_info1+="��λ��������ÿ��10�ζ�λ���񣬳�������1��/Ԫ��������������ĺ���Ȩ��λ�ֻ����뷢���";
		    	note_info1+="��λ�������������ձ�׼�ʷ���ȡ��|";	
		    	}	  
		    if($("#type_flag").val() == "36724") {
		    	note_info1+="����ͨA�ƻ�3Ԫ-0.50���¹��ܷ�3Ԫ�����������������������30���ӣ���������һ��������루�����ƶ������ʡ���ƶ����룩��";
		    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
		    	note_info1+="���鶨λ0.50Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";
					note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"
		    	}  
		     if($("#type_flag").val() == "36725") {
		    	note_info1+="����ͨB�ƻ�5Ԫ-0.40���¹��ܷ�5Ԫ�����������������������50���ӣ�5�����鶨λ/�£���������3��������루�����ƶ������ʡ���ƶ����룬ʡ���ƶ����벻����1������";
		    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
		    	note_info1+="���鶨λ0.40Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";
		    	note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"	
		    	}
		    	if($("#type_flag").val() == "36726") {
		    	note_info1+="����ͨC�ƻ�8Ԫ-0.20���¹��ܷ�8Ԫ�����������������������150���ӣ���������6��������루�����ƶ������ʡ���ƶ����룬ʡ���ƶ����벻����2������";
		    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
		    	note_info1+="���鶨λ0.20Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";	
		    	note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"
		    	}*/	    	
		    	
		    }else
	    	{
	    		var t2 = document.getElementById("tab2");
				var tr2s=t2.rows;
				var changdu1 = tr2s.length;
				if(changdu1>1){//ֻ��һ�� �� �Ͳ���ѭ���ˡ�
				   	var td2s=tr2s[1].childNodes; 					
		    		opr_info+="1����һ��ϵ�ˣ�"+td2s[0].innerHTML+"/"+td2s[2].innerHTML+"|";
				}
				
		        opr_info+="2�����ѣ�";
		        			
	    		var t3 = document.getElementById("tab3");
				var tr3s=t3.rows;
				var changdu3 = tr3s.length;
				 if(changdu3>1)
	      	     {
	      	      for(var i=1;i<changdu3;i++)
		            {  
		           		var td3s=tr3s[i].childNodes;  
			         	opr_info+=td3s[0].innerHTML+"/"+td3s[3].innerHTML+";";
			         }  
		         } 
	    		opr_info+="|";
	    		opr_info+="3���ھӣ�";
	    		
	    		var t4 = document.getElementById("tab4");
					var tr4s=t4.rows;
					var changdu4 = tr4s.length;
				 if(changdu4>1){
	  	      for(var i=1;i<changdu4;i++)
	          {  
	         		var td4s=tr4s[i].childNodes;  
	         		opr_info+=td4s[0].innerHTML+"/"+td4s[2].innerHTML+";";
	         }  
	       } 
          opr_info+="|";
	    		note_info1+="����ͨҵ�������ײͣ��¹��ܷ�15Ԫ/�£����������Ͳ��֣��򰴳�������ʷѱ�׼���շ��ã���������6��������룬ÿ�����ͱ��ز������������ʱ��100���ӣ��������Ͳ���0.10Ԫ/���ӣ�����";
		    	note_info1+="��ѣ��������Ϊ���ص��й��ƶ��ֻ����룬�������ÿ��ֻ���޸�һ�Σ��޸ĺ�������Ч������Ԯ������Ѱδ��˹�����ƽ̨9679566�����޴�����������ѯ��ÿ������30������ѽ����˹�����ƽ";
		    	note_info1+="̨967956ͨ��ʱ��������ʱ���ͳ�������ʱ���ļƷѣ��������ֱ��ػ����Σ����������Ͳ���0.1";
		    	note_info1+="Ԫ/���ӣ����е��˹���λ����������ն�λ�����ķ��á��������ձ�׼�ʷ���ȡ��|";		    
	    	}
		    
		  	note_info1+="|";
			
				retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
			  return retInfo;
			}		
			function printInfo1(printType)
			{
				var ofrIdneed = document.getElementById("ofrId").value;
				var cust_info="";  				//�ͻ���Ϣ
				var opr_info="";   				//������Ϣ
				var note_info1=""; 				//��ע1
				var note_info2=""; 				//��ע2
				var note_info3=""; 				//��ע3
				var note_info4=""; 				//��ע4
				var retInfo = "";  				//��ӡ����
				
				cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
				cust_info+="�ͻ�������"+document.all.custName.value+"|";
				cust_info+="֤�����룺"+document.all.idNo.value+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";

				//�������Ϣ���
				if(ofrIdneed=="0")
				{
					opr_info+="����ҵ������ͨҵ����Ϣ���"+"|";
					var note1 = "";
			   	var note2 = "";
					var chkPacket = new AJAXPacket ("fd076_ajax_getPrintNotes.jsp","��ȴ�������");
					chkPacket.data.add("type_flag" , "<%=offer_id%>");
					core.ajax.sendPacket(chkPacket,function(packet){
						var retCode = packet.data.findValueByName("retCode");
						var retMsg = packet.data.findValueByName("retMsg");
						var note1 = packet.data.findValueByName("note1");
						var note2 = packet.data.findValueByName("note2");
						if(retCode!="000000"){
		          rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		          return false;
	          }else{
	          	note_info1 = note1 + "��" + note2 + "|";
	          }
					});
					chkPacket =null; 	
					
					/*
						if("<%=offer_id%>"=="34515"){
		    	note_info1+="����ͨҵ������ײͣ����ܷ�8Ԫ/�£����������Ͳ��֣��򰴳�������ʷѱ�׼���շ��ã���������룺������6��������룬";
		    	note_info1+="ÿ�����ͱ��ز��������������ʱ��100���ӣ��������Ͳ���0.10Ԫ/���ӣ�������ѣ��������Ϊ���ص��й��ƶ��ֻ����룬�������ÿ��ֻ���޸�һ�Σ��޸ĺ�������Ч��";
		    	note_info1+="��λ��������ÿ��10�ζ�λ���񣬳�������1��/Ԫ��������������ĺ���Ȩ��λ�ֻ����뷢���";
		    	note_info1+="��λ�������������ձ�׼�ʷ���ȡ��|";	
		    	}
		    			if("<%=offer_id%>"=="36724"){
		    	note_info1+="����ͨA�ƻ�3Ԫ-0.50���¹��ܷ�3Ԫ�����������������������30���ӣ���������һ��������루�����ƶ������ʡ���ƶ����룩��";
		    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
		    	note_info1+="���鶨λ0.50Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";
		    	note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"
		    	}  
		     			if("<%=offer_id%>"=="36725") {
		    	note_info1+="����ͨB�ƻ�5Ԫ-0.40���¹��ܷ�5Ԫ�����������������������50���ӣ�5�����鶨λ/�£���������3��������루�����ƶ������ʡ���ƶ����룬ʡ���ƶ����벻����1������";
		    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
		    	note_info1+="���鶨λ0.40Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";	
		    	note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"
		    	}
		    			if("<%=offer_id%>"=="36726") {
		    	note_info1+="����ͨC�ƻ�8Ԫ-0.20���¹��ܷ�8Ԫ�����������������������150���ӣ���������6��������루�����ƶ������ʡ���ƶ����룬ʡ���ƶ����벻����2������";
		    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
		    	note_info1+="���鶨λ0.20Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";	
		    	note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"
		    	}*/
				}
				if(ofrIdneed!="0")
				{
						opr_info+="����ҵ������ͨҵ���ʷѱ��"+"|";
				}
				opr_info+="������ˮ��"+document.all.loginAccept.value+"|";
				opr_info+="ҵ������ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>"+"|";
				opr_info+="�û�Ʒ�ƣ�<%=sm_name%>"+"|";
		    if("<%=offer_id%>"!="34517")
		    {
		   		if(ofrIdneed=="0") //��Ϣ���
					{
			    	opr_info+="�����λ��Ȩ������:"+"|";
			    	var t1 = document.getElementById("tab1");
						var trs=t1.rows;
						var changdu=trs.length;
						if(changdu>1)
		      	{
			      	for(var i=1;i<changdu;i++)
				      {  
			      		var tds=trs[i].childNodes; 
				    	  opr_info+=i+"��"+tds[0].innerHTML+"/"+tds[2].innerHTML+"  ";
					    }  
				    }else{
			   			opr_info+="��  |";
			   		} 
			   	}	
		   		
		   		if(ofrIdneed!="0") //�ʷѱ��
					{
						/* begin for ��������������ͨ���ײ��ʷѺ�����Ӫ�������ĺ� @2014/12/2 */
				   	if("<%=offer_id%>" =="34515" || "<%=offer_id%>"=="36724" || "<%=offer_id%>"=="36725" || "<%=offer_id%>"=="36726" || "<%=offer_id%>"=="46865"){
		          var note1 = "";
				   		var note2 = "";
		          var chkPacket = new AJAXPacket ("fd076_ajax_getPrintNotes.jsp","��ȴ�������");
							chkPacket.data.add("type_flag" , "<%=offer_id%>");
							core.ajax.sendPacket(chkPacket,function(packet){
								var retCode = packet.data.findValueByName("retCode");
								var retMsg = packet.data.findValueByName("retMsg");
								var note1 = packet.data.findValueByName("note1");
								var note2 = packet.data.findValueByName("note2");
								if(retCode!="000000"){
				          rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
				          return false;
			          }else{
			          	note_info1 += "ԭ�ײ����ƣ�"+ note1 + "|";
			          	note_info1 += "ԭ�ײ�������"+ note2 + "|";
			          }
							});
							chkPacket =null; 	
		        }
						/* end for ��������������ͨ���ײ��ʷѺ�����Ӫ�������ĺ� @2014/12/2 */
						/*
				    if("<%=offer_id%>"=="34515"){
				    	note_info1+="ԭ�ײ����ƣ�����ͨҵ������ײ͡�|";
				    	note_info1+="ԭ�ײ����������ܷ�8Ԫ/�£����������Ͳ��֣��򰴳�������ʷѱ�׼���շ��ã���������룺������6��������룬";
				    	note_info1+="ÿ�����ͱ��ز��������������ʱ��100���ӣ��������Ͳ���0.10Ԫ/���ӣ�������ѣ��������Ϊ���ص��й��ƶ��ֻ����룬�������ÿ��ֻ���޸�һ�Σ��޸ĺ�������Ч��";
				    	note_info1+="��λ��������ÿ��10�ζ�λ���񣬳�������1��/Ԫ��������������ĺ���Ȩ��λ�ֻ����뷢���";
				    	note_info1+="��λ�������������ձ�׼�ʷ���ȡ��|";	
				    	}	  
				    if("<%=offer_id%>"=="36724"){
				    	note_info1+="ԭ�ײ����ƣ�����ͨA�ƻ�3Ԫ-0.50��|";
				    	note_info1+="ԭ�ײ��������¹��ܷ�3Ԫ�����������������������30���ӣ���������һ��������루�����ƶ������ʡ���ƶ����룩��";
				    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
				    	note_info1+="���鶨λ0.50Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";
				    	note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"
				    	}  
				     if("<%=offer_id%>"=="36725") {
				      note_info1+="ԭ�ײ����ƣ�����ͨB�ƻ�5Ԫ-0.40��|";
				    	note_info1+="ԭ�ײ��������¹��ܷ�5Ԫ�����������������������50���ӣ�5�����鶨λ/�£���������3��������루�����ƶ������ʡ���ƶ����룬ʡ���ƶ����벻����1������";
				    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
				    	note_info1+="���鶨λ0.40Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";	
				    	note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"
				    	}
				    	if("<%=offer_id%>"=="36726") {
				    	note_info1+="ԭ�ײ����ƣ�����ͨC�ƻ�8Ԫ-0.20��|";
				    	note_info1+="ԭ�ײ��������¹��ܷ�8Ԫ�����������������������150���ӣ���������6��������루�����ƶ������ʡ���ƶ����룬ʡ���ƶ����벻����2������";
				    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
				    	note_info1+="���鶨λ0.20Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";	
				    	note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"
				    	}*/ 
			    	}
		    	/* begin for ��������������ͨ���ײ��ʷѺ�����Ӫ�������ĺ� @2014/12/2 */
		    	var note3 = "";
		    	var note4 = "";
	    		var chkPacket2 = new AJAXPacket ("fd076_ajax_getPrintNotes.jsp","��ȴ�������");
					chkPacket2.data.add("type_flag" , ofrIdneed);
					core.ajax.sendPacket(chkPacket2,function(packet){
						var retCode = packet.data.findValueByName("retCode");
						var retMsg = packet.data.findValueByName("retMsg");
						var note3 = packet.data.findValueByName("note1");
						var note4 = packet.data.findValueByName("note2");
						if(retCode!="000000"){
		          rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		          return false;
	          }else{
	          	note_info1 += "���ײ����ƣ�"+ note3 + "|";
	          	note_info1 += "���ײ�������"+ note4 + "|";
	          }
					});
					chkPacket2 =null; 	
					/* end for ��������������ͨ���ײ��ʷѺ�����Ӫ�������ĺ� @2014/12/2 */
		    	/*
		    	if(ofrIdneed=="34515"){
		    	note_info1+="���ײ����ƣ�����ͨҵ������ײ͡�|";
		    	note_info1+="���ײ����������ܷ�8Ԫ/�£����������Ͳ��֣��򰴳�������ʷѱ�׼���շ��ã���������룺������6��������룬";
		    	note_info1+="ÿ�����ͱ��ز��������������ʱ��100���ӣ��������Ͳ���0.10Ԫ/���ӣ�������ѣ��������Ϊ���ص��й��ƶ��ֻ����룬�������ÿ��ֻ���޸�һ�Σ��޸ĺ�������Ч��";
		    	note_info1+="��λ��������ÿ��10�ζ�λ���񣬳�������1��/Ԫ��������������ĺ���Ȩ��λ�ֻ����뷢���";
		    	note_info1+="��λ�������������ձ�׼�ʷ���ȡ��|";	
		    	}	  
		    if(ofrIdneed=="36724"){
		    	note_info1+="���ײ����ƣ�����ͨA�ƻ�3Ԫ-0.50��|";
		    	note_info1+="���ײ��������¹��ܷ�3Ԫ�����������������������30���ӣ���������һ��������루�����ƶ������ʡ���ƶ����룩��";
		    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
		    	note_info1+="���鶨λ0.50Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";
		    	note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"
		    	}  
		     if(ofrIdneed=="36725") {
		      note_info1+="���ײ����ƣ�����ͨB�ƻ�5Ԫ-0.40��|";
		    	note_info1+="���ײ��������¹��ܷ�5Ԫ�����������������������50���ӣ�5�����鶨λ/�£���������3��������루�����ƶ������ʡ���ƶ����룬ʡ���ƶ����벻����1������";
		    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
		    	note_info1+="���鶨λ0.40Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";	
		    	note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"
		    	}
		    	if(ofrIdneed=="36726") {
		    	note_info1+="���ײ����ƣ�����ͨC�ƻ�8Ԫ-0.20��|";
		    	note_info1+="���ײ��������¹��ܷ�8Ԫ�����������������������150���ӣ���������6��������루�����ƶ������ʡ���ƶ����룬ʡ���ƶ����벻����2������";
		    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
		    	note_info1+="���鶨λ0.20Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";	
		    	note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"
		    	}		
		    	*/
		    }else
	    	{
	    		if(ofrIdneed=="0")
					{
		    		var t2 = document.getElementById("tab2");
						var tr2s=t2.rows;
						var changdu1 = tr2s.length;
						if(changdu1>1){//ֻ��һ�� �� �Ͳ���ѭ���ˡ�
						   	var td2s=tr2s[1].childNodes; 					
				    		opr_info+="1����һ��ϵ�ˣ�"+td2s[0].innerHTML+"/"+td2s[2].innerHTML+"|";
						}
					
			      opr_info+="2�����ѣ�";
			        			
		    		var t3 = document.getElementById("tab3");
						var tr3s=t3.rows;
						var changdu3 = tr3s.length;
					  if(changdu3>1)
	    	    {
		  	      for(var i=1;i<changdu3;i++)
		          {  
			         	var td3s=tr3s[i].childNodes;  
			         	opr_info+=td3s[0].innerHTML+"/"+td3s[3].innerHTML+";";
			        }  
	         	} 
		    		opr_info+="|";
		    		opr_info+="3���ھӣ�";
		    	}
		    	var t4 = document.getElementById("tab4");
					var tr4s=t4.rows;
					var changdu4 = tr4s.length;
					if(changdu4>1)
	    	  {
	  	      for(var i=1;i<changdu4;i++)
	          {  
	         		var td4s=tr4s[i].childNodes;  
	         		opr_info+=td4s[0].innerHTML+"/"+td4s[2].innerHTML+";";
	          }  
	        }
	        opr_info+="|";
	    		note_info1+="����ͨҵ�������ײͣ��¹��ܷ�15Ԫ/�£����������Ͳ��֣��򰴳�������ʷѱ�׼���շ��ã���������6��������룬ÿ�����ͱ��ز������������ʱ��100���ӣ��������Ͳ���0.10Ԫ/���ӣ�����";
		    	note_info1+="��ѣ��������Ϊ���ص��й��ƶ��ֻ����룬�������ÿ��ֻ���޸�һ�Σ��޸ĺ�������Ч������Ԯ������Ѱδ��˹�����ƽ̨9679566�����޴�����������ѯ��ÿ������30������ѽ����˹�����ƽ";
		    	note_info1+="̨967956ͨ��ʱ��������ʱ���ͳ�������ʱ���ļƷѣ��������ֱ��ػ����Σ����������Ͳ���0.1";
		    	note_info1+="Ԫ/���ӣ����е��˹���λ����������ն�λ�����ķ��á��������ձ�׼�ʷ���ȡ��|";		    
	    	}
		    
		  	note_info1+="|";
			
				retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
			  return retInfo;
			}		
			/*
			*����ƴ��~���������
			function joinData(idStr,num){
				var dataInfo = "";
				for(var i=1;i<=num;i++){
					dataInfo += $("#"+idStr+i).val() + "~";
				}
				return dataInfo;
			}
			*/
			/*
			*���ڸ�ָ����tab���TR
			*/
			function addTr(dyntb,cols,tabInfo){
				tr1=dyntb.insertRow();
				var info = tabInfo.split("|");
				for(var i=0;i<cols;i++){
					if(info[i].trim()==""){
						info[i]="NULL"
					}
					tr1.insertCell().innerHTML = info[i];
				}
			}
			/*
			*����ɾ��ָ��tab�е�TR
			*/
			function delTr(dyntb){
				dyntb.deleteRow(dyntb.rows.length-1);
			}
			/*
			*���ܣ����ڻ��tab�е�TD������Ϣ���TD����input���򷵻�input��valueֵ
			*dyntb��ָ��table����
			*fromCol��ָ����ʼ������
			*toCol��ָ������������
			*fromRow��ָ����ʼ����
			*toRow��ָ����������
			*���أ�����ÿ����Ϣʹ��"|"�ָһ���еĸ����ֶ�������"~"�ָ�
			*/
			function getTableData(dyntb,fromCol,toCol,fromRow,toRow){
				var dataInfo="";
				var table=dyntb;
				for(var i=fromRow;i<toRow;i++){
				   for(var j=fromCol;j<toCol;j++){
					  var td=table.rows[i].cells[j];
					  if(td.hasChildNodes()){
						  var input = td.getElementsByTagName("input");
							if (input && input[0]){
							  dataInfo += input[0].value + "~";
							}else{
								dataInfo += td.innerHTML + "~";
							}
					  }
				   }
				   dataInfo = dataInfo + i + "~" + "|"
				}
				return dataInfo;
			}
			
			function changePropCommunity(){
				var chkPacket = new AJAXPacket ("fd076_ajaxGetPropCommunity.jsp","��ȴ�������");
				chkPacket.data.add("propDistrictId" , $("#propDistrict_select option:selected").val());
				core.ajax.sendPacketHtml (chkPacket,getPropCommunity);
				chkPacket =null; 
			}
			function getPropCommunity(data){
				$("#propCommunity_select").empty().append(data);
			}
		</script>
	</head>
	<body>
		<form method="post" id="f1" name="f1" onKeyUp="chgFocus(f1)">
			<%@ include file="/npage/common/pwd_comm.jsp" %>
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">����ͨҵ�������Ϣ(�����ײ�:����ֽ����������ϵ��˳����ҳ����ʾ˳��Ϊ׼)</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td width="10%" class="blue">�ײ�����</td>
					<td width="20%" class="blue">
						<select name="type_flag" id="type_flag" style="width:190px">
							<option value="34515" selected>����ͨҵ������ײ�--34515</option>						
							<option value="36724">����ͨA�ƻ�3Ԫ-0.50--36724</option>
							<option value="36725">����ͨB�ƻ�5Ԫ-0.40--36725</option>
							<option value="36726">����ͨC�ƻ�8Ԫ-0.20--36726</option>
							<option value="34517">����ͨҵ�������ײ�--34517</option>
							<option value="46865">����ͨD�ײ�--46865</option>
						</select>
						<input type="text" value="" name="type_flag_delete" id="type_flag_delete" readonly display : none class="InputGrey" style="width:145px"/>
					</td>
					<td width="10%" class="blue">��������</td>
					<td width="20%" class="blue">
						<input type="text" value="����ͨҵ��" readonly class="InputGrey"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">��ͨ����</td>
					<td width="20%" class="blue">
						<input class="InputGrey" readonly  type="text" size="12" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 index="0">
					</td>
					<td width="10%" class="blue">�û���¼�ʺ�</td>
					<td width="20%" class="blue">
						<input type="text" v_minlength=1 v_maxlength=16  id="userAccounts" name="userAccounts" v_must=1 v_name="�û���¼�ʺ�" value="<%=phoneNo%>" maxlength="20" onblur="checkElement(this)"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">�ͻ�����</td>
					<td width="20%" class="blue">
						<input type="text" name="custName" id="custName" value="<%=custName%>" readonly class="InputGrey"/>
					</td>
					<td width="10%" class="blue">�û�ID</td>
					<td width="20%" class="blue">
						<input type="text" name="idNo" id="idNo" value="<%=idNo%>" readonly class="InputGrey"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">�Ա�</td>
					<td width="20%" class="blue">
						<select name="custSex" id="custSex" style="width:135px" >
							<option value="0">��</option>
							<option value="1">Ů</option>
						</select>
					</td>
					<td width="10%" class="blue">��������</td>
					<td width="20%" class="blue">
						<input type="text" name="propBirthday" id="propBirthday" value="<%=propBirthday%>" v_type="date" v_must=1  /><font class="orange">(��ʽΪ��YYYYMMDD)</font>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">������</td>
					<td width="20%" class="blue">
						<div id="sq3" >
							<input type="text" maxlength="10" name="propDistrict" id="propDistrict" v_must=1 />
					    </div>
					    <div id="sq4" style="display:none">
					    	<select name="propDistrict_select" id="propDistrict_select" onChange="changePropCommunity()">
					    		<option value="">��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
								<wtc:sql>select distinct a.location_id ,a.location_name from sCommunityMsg a ,dloginmsg b where a.region_code = substr(org_code,0,2)  and b.login_no = '<%=loginNo%>'   </wtc:sql>
							</wtc:qoption>
						</select>
						
						</div>
					</td>
					<td width="10%" class="blue"><span id="sq" style="display:none">����</span></td>
					<td width="20%" class="blue">
						<div id="sq2" style="display:none">
						<select name="propCommunity_select" id="propCommunity_select" >
							<option value="">��ѡ��</option>
						</select>
						
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">��ס�ع̻�</td>
					<td width="20%" class="blue">
						<input type="text" maxlength="20" name="propTelephone" id="propTelephone" v_must=1   />
					</td>
					<td width="10%" class="blue">�ͻ���ַ</td>
					<td width="20%" class="blue">
						<input type="text" name="custAddr" id="custAddr" value="<%=custAddr%>" size="40" maxlength="100"  v_must=1 >
					</td>
				</tr>
				<tr id="t3" style="display:none">
					<td width="10%" class="blue">���ȳ������ﳣס�ص�·��</td>
					<td width="20%" class="blue">
						<input type="text" name="propUrgentRoutes" id="propUrgentRoutes" size="40" maxlength="150" />
					</td>
					<td width="10%" class="blue">�������������</td>
					<td width="20%" class="blue">
						<select name="propLifestyle" id="propLifestyle" style="width:135px">
							<option value="05">����</option>
							<option value="01">����Ůͬס</option>
							<option value="02">����ż����</option>
							<option value="03">����������</option>
							<option value="04">��������</option>
						</select>
					</td>
				</tr>
				<tr id="t4" style="display:none">
					<td width="10%" class="blue">�Ƿ���Ҫ��ƽ������</td>
					<td width="20%" class="blue">
						<select name="isReportSafe" id="isReportSafe" style="width:135px">
							<option value="02">��</option>
							<option value="01">��</option>
						</select>
					</td>
					<td width="10%" class="blue">&nbsp;</td>
					<td width="20%" class="blue">
							&nbsp;
					</td>
				</tr>
				<tr id="t1" style="display:none">
					<td width="10%" class="blue">��ƽ������</td>
					<td width="20%" class="blue">
						<input type="text" name="reportCycle" value="7" id="reportCycle"/><font class="orange">��*</font>
					</td>
					<td width="10%" class="blue">����������</td>
					<td width="20%" class="blue">
						<input type="text" name="reportName" id="reportName"/><font class="orange">*</font>
					</td>
				</tr>
				<tr id="t2" style="display:none">
					<td width="10%" class="blue">�������ƶ��绰</td>
					<td width="20%" class="blue">
						<input type="text" name="reportMobile" id="reportMobile"/><font class="orange">*</font>
					</td>
					<td width="10%" class="blue">���ܷ�ʽ</td>
					<td width="20%" class="blue">
						<select name="reportWay" id="reportWay" style="width:135px">
							<option value="02">����</option>
							<option value="01" selected >�绰+����</option>
						</select>
					</td>
				</tr>
				<tr id="t2" style="display:none">
					<td width="10%" class="blue">�Ƿ��趨���Ѻ���</td>
					<td width="20%" class="blue" >
						<select name="feeFlay" id="feeFlay" style="width:135px">
							<option value="N" selected >��</option>
							<option value="Y">��</option>
						</select>
					</td>
					<td>&nbsp;</td><td>&nbsp;</td>
				</tr>
				<tr style="display:none" id="trd">
					<td width="10%" class="blue">���Ѻ���</td>
					<td width="20%" class="blue">
						<input type="text" name="feePhone"  id="feePhone" v_minlength=1 v_maxlength=16 v_type="mobphone" index="0">
					</td>
					<td width="10%" class="blue">����</td>
					<td width="20%" class="blue">
						<jsp:include page="/npage/common/pwd_one_new.jsp">
							<jsp:param name="width1" value="16%"  />
							<jsp:param name="width2" value="34%"  />
							<jsp:param name="pname" value="password"  />
							<jsp:param name="pwd" value=""  />
						</jsp:include>
					</td>
				</tr>

				<tr style="display:none" id="trd1">
					<td width="10%" class="blue">���Ѻ���</td>
					<td width="20%" class="blue">
						<input type="text" name="feePhone1"  id="feePhone1" v_minlength=1 v_maxlength=16 v_type="mobphone" index="0">
					</td>
					<td>&nbsp;</td><td>&nbsp;</td>
				</tr>

				<tr style="display:none" id="trd2">
					<td width="10%" class="blue">����</td>
					<td width="20%" class="blue">
						<jsp:include page="/npage/common/pwd_one_new.jsp">
							<jsp:param name="width1" value="16%"  />
							<jsp:param name="width2" value="34%"  />
							<jsp:param name="pname" value="password1"  />
							<jsp:param name="pwd" value=""  />
						</jsp:include>
					</td>
					<td>&nbsp;</td><td>&nbsp;</td>
				</tr>


				<tr>
					<td width="10%" class="blue">��ʼʱ��</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 id="startTime" value="<%=todayTime%>" name="startTime" v_name="��ʼʱ��" maxlength="6"/>
						<font class="orange">*</font>
					</td>
					<td width="10%" class="blue">����ʱ��</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 id="endTime" value="20500101235959" name="endTime" v_name="����ʱ��" maxlength="6"/>
						<font class="orange">*</font>
					</td>
				</tr>
			</table>
			<!--
			<div class="title" id="d0">
				<div id="title_zi">������б�</div>
			</div>
			<table cellspacing="0" id="tab0">
				<tr>
					<td  class="blue">�������1</td>
					<td  class="blue">�������2</td>
					<td  class="blue">�������3</td>
					<td  class="blue">�������4</td>
					<td  class="blue">�������5</td>
					<td  class="blue">�������6</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="relaPhone1" id="relaPhone1"/>
					</td>
					<td>
						<input type="text" name="relaPhone2" id="relaPhone2"/>
					</td>
					<td>
						<input type="text" name="relaPhone3" id="relaPhone3"/>
					</td>
					<td>
						<input type="text" name="relaPhone4" id="relaPhone4"/>
					</td>
					<td>
						<input type="text" name="relaPhone5" id="relaPhone5"/>
					</td>
					<td>
						<input type="text" name="relaPhone6" id="relaPhone6"/>
					</td>
				</tr>
			</table>
			-->
			<%
			if ( opCode.equals("d077") )
			{
				/*
				d076OfrIds="36725|";
				d076OfrNms="����ͨB�ƻ�5Ԫ-0.40|";
				d076OfrCms="�¹��ܷ�5Ԫ�����������������������50���ӣ�5�����鶨λ/�£���������3��������루�����ƶ������ʡ���ƶ����룬ʡ���ƶ����벻����1���������򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ����鶨λ0.40Ԫ/�Ρ��������ձ�׼�ʷ���ȡ|";
			*/
				String d076OfrId[]=d076OfrIds.split("\\|");
				String d076OfrNm[]=d076OfrNms.split("\\|");
				String d076OfrCm[]=d076OfrCms.split("\\|");
				
			%>
			<div class="title" id="d1">
				<div id="title_zi">��Ӧ�ʷ�</div>
			</div>		
			<table cellspacing="0" id="tabOfr">
				<tr>
					<th>ѡ��</th>
					<th>�ʷ�ID</th>
					<th>�ʷ�����</th>
					<th>�ʷ�����</th>
				</tr>
				
				<%
				for ( int i=0; i<d076OfrId.length;i++ )
				{
				%>
					<tr>
						<td>
							<input type='radio' name='d076Ofr' id='d076Ofr' 
								onclick='chgOfr(<%=d076OfrId[i]%>)'>
						</td>
						<td><%=d076OfrId[i]%></td>
						<td><%=d076OfrNm[i]%></td>
						<td>
							<textarea id="offerCmt" name="offerCmt" readOnly
								cols='100' rows='3' align='left'><%=d076OfrCm[i]%></textarea>								
						</td>		
					</tr>
				<%
				}
				%>
			</table>
			<%
			}
			%>
			
			<div class="title" id="d1">
				<div id="title_zi">��Ȩ��λ����Ϣ�б�&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" value="�����Ȩ��λ����Ϣ" id="addRela" /></div>
			</div>
			<table cellspacing="0" id="tab1">
				<tr>
					<td class="blue">��������</td>
					<td class="blue">������ϵ</td>
					<td class="blue">�����ƶ��绰</td>
					<td class="blue">����ס���绰</td>
					<td class="blue">����ס����ַ</td>
					<td class="blue">������λ�绰</td>
					<td class="blue">������λ��ַ</td>
					<td class="blue">�����˶�λ�����Ƿ���Ч</td>
					<td class="blue">����</td>
				</tr>
			</table>
			<div class="title" id="d2" style="display:none">
				<div id="title_zi">��һ��ϵ����Ϣ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" value="��ӵ�һ��ϵ��" id="addFirst"/></div>
			</div>
			<table cellspacing="0" id="tab2" style="display:none">
				<tr>
					<td class="blue">��һ��ϵ������</td>
					<td class="blue">��һ��ϵ�˹�ϵ</td>
					<td class="blue">��һ��ϵ���ƶ��绰</td>
					<td class="blue">��һ��ϵ��ס���绰</td>
					<td class="blue">��һ��ϵ��ס����ַ</td>
					<td class="blue">�ƶ��绰�Ƿ�������˶�λ</td>
					<td class="blue">��һ��ϵ�˵�λ�绰</td>
					<td class="blue">��һ��ϵ�˵�λ��ַ</td>
					<td class="blue">�����˶�λ�����Ƿ���Ч</td>
					<td class="blue">����</td>
				</tr>
			</table>
			<div class="title" id="d3" style="display:none">
				<div id="title_zi">������Ϣ�б�&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" value="���������Ϣ" id="addFrid"/></div>
			</div>
			<table cellspacing="0" id="tab3" style="display:none">
				<tr>
					<td class="blue">��������</td>
					<td class="blue">���ѹ�ϵ</td>
					<td class="blue">���ѹ̶��绰</td>
					<td class="blue">�����ƶ��绰</td>
					<td class="blue">�ƶ��绰�Ƿ�������˶�λ</td>
					<td class="blue">�����˶�λ�����Ƿ���Ч</td>
					<td class="blue">����</td>
				</tr>
			</table>
			<div class="title" id="d4" style="display:none">
				<div id="title_zi">�ھ���Ϣ�б�&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" value="����ھ���Ϣ" id="addNaber" disabled="true"/></div>
			</div>
			<table cellspacing="0" id="tab4" style="display:none">
				<tr>
					<td class="blue">�ھ�����</td>
					<td class="blue">�ھӹ̶��绰</td>
					<td class="blue">�ھ��ƶ��绰</td>
					<td class="blue">�ƶ��绰�Ƿ�������˶�λ</td>
					<td class="blue">�����˶�λ�����Ƿ���Ч</td>
					<td class="blue">����</td>
				</tr>
			</table>
			<table cellspacing="0">
				<tr>
					<td colspan="4" id="footer">
			           <div align="center">

						<%
						if ( opCode.equals("d077") )
						{
						%>
							<input class="b_foot" type="button" 
			              		id="confirm" name="confirm" value="��Ϣ���" index="2">						
							<input class="b_foot" type="button" 
			              		id="ofrCfm" name="ofrCfm" value="�ʷѱ��" index="2">
						<%
						}
						else
						{
						%>
							<input class="b_foot" type="button" 
			              		id="confirm" name="confirm" value="ȷ��" index="2">						
						<%
						}
						%>

			              <input class="b_foot" type="button" name="back" id="back" value="���" onclick="window.location.reload()">
					      <input class="b_foot" type="button" name=qryP value="����" onClick="history.go(-1)">
			            </div>
			        </td>
				</tr>
			</table>
			<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>"/>
			<input type="hidden" name="opName" id="opName" value="<%=opName%>"/>
			<!--��Ϣ��������ʷѱ��-->
			<input type="hidden" name="opFlag" id="opFlag" value=""/>			
			<input type="hidden" name="famRelaInfoStr" id="famRelaInfoStr"/>
			<input type="hidden" name="firstRelaInfoStr" id="firstRelaInfoStr"/>
			<input type="hidden" name="friRelaInfoStr" id="friRelaInfoStr"/>
			<input type="hidden" name="neiRelaInfoStr" id="neiRelaInfoStr"/>
			<input type="hidden" name="feePwdEnd" id="feePwdEnd"/>
			<input type="hidden" name="phoneList" id="phoneList"/>
			<input type="hidden" name="loginAccept" id="loginAccept" value="<%=PrintAccept%>"/>
			<input type="hidden" name="offerId" id="offerId"/>
			<input type="hidden" name="propDistrict_select_hidd" id="propDistrict_select_hidd"/>
			<input type="hidden" name="propCommunity_select_hidd" id="propCommunity_select_hidd"/>
			<!--����ͨ���ʱ��ѡ���ʷ�ID-->
			<input type="hidden" name="ofrId" id="ofrId" value="0"/>
		<!--	<input type="hidden" name="affectionNoStr" id="affectionNoStr"/>-->
			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>
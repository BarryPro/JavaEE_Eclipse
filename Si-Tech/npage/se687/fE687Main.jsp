<%
/*
 * ����: ʡ��Я��
 * �汾: 1.0
 * ����: 2012/3/9 14:19:13
 * ����: zhangyan
 * ��Ȩ: si-tech
 * update:
*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String opCode="e687";
String opName="ʡ��Я������";
String regCode=(String)session.getAttribute("regCode");
String groupId = (String)session.getAttribute("groupId");
String workNo = (String)session.getAttribute("workNo");  
String password =(String)session.getAttribute("password"); 
String phoneNo=request.getParameter("activePhone");
String custOrderId = WtcUtil.repNull(request.getParameter("custOrderId"));	  //�ͻ�������
String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));    //�ͻ��������

String retCodeM="";
String retMsgM="";
String sqlE687ServId = "select  "
	+" to_char(id_no)  , phone_no ,t1.region_name "
	+"from dcustmsg t ,  sregioncode t1 "
	+"  where t1.region_code = substr(t.belong_code ,1,2) and  t.phone_no=:phoneNo";
	
String sqlE687ServIdPhone= "phoneNo="+phoneNo;

java.util.Date sysdate = new java.util.Date();
java.text.SimpleDateFormat sf 
	= new java.text.SimpleDateFormat("yyyy��MM��dd�� HHʱmm��ss��");
String createTime = sf.format(sysdate);

java.text.SimpleDateFormat sf1 
	= new java.text.SimpleDateFormat("yyyy��MM��dd�� HHʱmm��");
String createTime1 = sf1.format(sysdate);

java.text.SimpleDateFormat sf2
	= new java.text.SimpleDateFormat("yyyy��MM��dd��");
String createTime2 = sf2.format(sysdate);


%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String create_accept = sLoginAccept; 

%>
<wtc:service name="TlsPubSelCrm" outnum="3" retmsg="msg" 
	retcode="code" routerKey="region" routerValue="<%=regCode%>">	
	<wtc:param value="<%=sqlE687ServId%>"/>
	<wtc:param value="<%=sqlE687ServIdPhone%>"/>
</wtc:service>
<wtc:array id="rstE687ServId" scope="end" />	
<%
	String servId=rstE687ServId[0][0];
	String regNm=rstE687ServId[0][2];
	/*
	*��ѯ��ֵҵ����Ϣ yanpx 20120425
	*����platBusiQry
	*���  ��׼���
	*����  1 oRetCode 2 oRetMsg 3 ocatalog ��� 4 ocatalogName		������� 5 ophoneNo �ֻ����� 6 oofferId �ʷ�id
	*/
		String paraAray[] = new String[43];	
		paraAray[0] = "0";  									     // ��ӡ��ˮ                
		paraAray[1] = "01"; 											 //������ʶ
		paraAray[2] = opCode; 							     //���ܴ���   
		paraAray[3] = workNo;								     //��������               
		paraAray[4] = password; 								 //��������                
		paraAray[5] = phoneNo; 									 //�ƶ�����               
		paraAray[6] = "";    										 //�ƶ����� ����
%>
	<wtc:service name="platBusiQry" routerKey="region"
		routerValue="<%=regCode%>" retcode="pbRtCode" retmsg="pbRtMsg" outnum="4" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>			
	</wtc:service>
	<wtc:array id="platBusiQryResult" scope="end"/>

	<%
	if (!pbRtCode.equals("000000"))
	{
	%>
		<script>
		rdShowMessageDialog("platBusiQry:<%=pbRtCode%>:<%=pbRtMsg%>");
		removeCurrentTab();
		</script>
	<%
	}
	%>
  	
	<wtc:service name="sSaleQry"  outnum="19" retcode="saleRtCode" retmsg="saleRtMsg"
		routerKey="region" routerValue="<%=regCode%>" >
	    <wtc:param value="<%=create_accept%>"/>
	    <wtc:param value="01"/>
	    <wtc:param value="e687"/>
	    <wtc:param value="<%=workNo%>"/>
	    <wtc:param value="<%=password%>"/>
	    <wtc:param value="<%=phoneNo%>"/>
	    <wtc:param value=""/>
	</wtc:service>
	<wtc:array id="arrSaleQry" scope="end"/> 
	<%
	if (!saleRtCode.equals("000000"))
	{
	%>
		<script>
		rdShowMessageDialog("sSaleQry:<%=saleRtCode%>:<%=saleRtMsg%>");
		removeCurrentTab();
		</script>
	<%
	}
	%>
	 	
			
	<wtc:service name="s9127Qry"  outnum="42" retcode="code9127" retmsg="msg9127"
		routerKey="region" routerValue="<%=regCode%>" >
	    <wtc:param value="<%=create_accept%>"/>
	    <wtc:param value="01"/>
	    <wtc:param value="e687"/>
	    <wtc:param value="<%=workNo%>"/>
	    <wtc:param value="<%=password%>"/>
	    <wtc:param value="<%=phoneNo%>"/>
	    <wtc:param value=""/>
	</wtc:service>	
	<wtc:array id="a9127Qry0" start="0" length="6" scope="end" />
	<wtc:array id="a9127Qry1" start="6" length="36" scope="end" />					
	
	<%
	if (!code9127.equals("000000"))
	{
	%>
		<script>
		rdShowMessageDialog("s9127Qry:<%=code9127%>:<%=msg9127%>");
		removeCurrentTab();
		</script>
	<%
	}
	%>
				
<html>
	<head>
		<script src="../public/json2.js" type="text/javascript"></script>
		<script src="fE687OfferObj.js" type="text/javascript"></script>

		<script language="javascript">
			/*
			*��ֵҵ��java����ת��Ϊjs���� yanpx 20120425
			*/
			var valueAddedServices=new Array();
			var pntAddSvc=""; 
			<%
			for (int i=0; i<platBusiQryResult.length ; i++)
			{
			%>
				valueAddedServices["<%=i%>"]=new Array(); 
				pntAddSvc+="<%=platBusiQryResult[i][1]%>ҵ��(<%=platBusiQryResult[i][1]%>)"+"|"; 
				<%
				for (int j=0 ; j<platBusiQryResult[i].length ; j++)
				{
				%>
					valueAddedServices["<%=i%>"]["<%=j%>"]="<%=platBusiQryResult[i][j]%>"; 
				<%
				}
			}%>  	
			
			/* zhangyan ��Ʒ������ֵҵ��*/
			
			var var9127Qry=new Array();
			<%
			if (  !a9127Qry0[0][3].equals("0" ) )
			{
				for (int i=0; i<a9127Qry1.length ; i++)
				{
					%>
					var9127Qry["<%=i%>"]=new Array(); 
					pntAddSvc+="<%=a9127Qry1[i][11-6]%>ҵ��(<%=a9127Qry1[i][11-6]%>)"+"|"; 
					<%
					for (int j=0 ; j<a9127Qry1[i].length ; j++)
					{
					%>
						var9127Qry["<%=i%>"]["<%=j%>"]="<%=a9127Qry1[i][j]%>"; 
					<%
					}
				}		
			}
			
			%>  				
					
			var thisMonthOfferIdArr=new Array();
			
			function doCfm()
			{
				var eff_time="";
				if( !( "<%=arrSaleQry.length%>"==0) )
				{
					rdShowMessageDialog("�û���Ӫ������Ϣ,���ܰ����ҵ��!",0);
					return false;					
				}
				
				
				if ($("#offerId").val()==0)
				{
					rdShowMessageDialog("����ѡ���ʷ�!",0);
					return false;
				}
				
				if ($("#attrFlag").val()=="1")
				{
					if ($("#attrFlagHv").val()=="0")
					{
						rdShowMessageDialog("���ʷѱ�������С������!",0);
						return false;
					}
				}
				$("#confirm").attr("disabled",true);
				var publicinfo1	= new	pubicinfo();
				var offerList1	= new	OfferList();
					
				publicinfo1.setCreate_accept( "<%=create_accept%>" );
				publicinfo1.setPhone_no("<%=phoneNo%>");
				publicinfo1.setOpCode("e687");
				publicinfo1.setLoginNo("<%=workNo%>");
				publicinfo1.setOp_note("e687ʡ��Я������");

				/*չʾ*/
				offerList1.setPubicinfo(publicinfo1);					
				/*������ѡ�ʷѴ�ӡ��*/
				var pntOfr1="��������Ŀ�ѡ�ʷѣ�";
				/*�˶���ѡ�ʷѴ�ӡ��*/
				var pntOfr3="����ȡ���Ŀ�ѡ�ʷѣ�";
				/*�������ʷѴ�ӡ��*/
				var pntOfr10="";
				
				for ( var i=0;i<offers.length;i++ )
				{
				
					var param1		= new	param();
					var business1	= new	business();			
					if (offers[i][4]=="1")/*����*/
					{
						if (offers[i][3]=="0")/*���ʷ�*/
						{						
							business1.setFuncname("pubChgCityOfferChg");
							if (offers[i][7]=="Y")/*ֻ�����ʷ���С������*/
							{
								param1.setAreacode($("#attrFlagHv").val());
							}
							
							pntOfr10+="ԤԼ���ʷѣ�("+offers[i][0]+"��"
								+document.getElementById("smCode").value+"��"+offers[i][1]+")";
							param1.setOper("1");
							eff_time=offers[i][5]; 
							param1.setBegin_time(offers[i][5]);
							param1.setNewofferid(offers[i][0]);
							param1.setEnd_time(offers[i][6]);
							business1.setParam(param1);
						}
						else if(offers[i][3]=="1")/*��ѡ�ʷ�*/
						{
							
							pntOfr1+="("+offers[i][0]+"��"+offers[i][1]+") ";
							business1.setFuncname("pubChgCityOfferChg");					
							param1.setOper("1");
							param1.setBegin_time(offers[i][5]);
							param1.setNewofferid(offers[i][0]);
							param1.setEnd_time(offers[i][6]);
							business1.setParam(param1);
						}
						else/*�ط�*/
						{
							business1.setFuncname("pubChgCityProdChg");					
							param1.setOper("1");
							param1.setBegin_time(offers[i][5]);
							param1.setProduct_id(offers[i][0]);
							param1.setEnd_time(offers[i][6]);
							business1.setParam(param1);
						}	
					}
					else if(offers[i][4]=="3") /*�˶�*/
					{
						if (offers[i][3]=="0")/*���ʷ�*/
						{
							business1.setFuncname("pubChgCityOfferChg");					
							param1.setOper("3");
							param1.setBegin_time(offers[i][5]);
							param1.setNewofferid(offers[i][0]);
							param1.setEnd_time(offers[i][6]);
							business1.setParam(param1);
						}
						else if(offers[i][3]=="1")/*��ѡ�ʷ�*/
						{		
							
							pntOfr3+="("+offers[i][0]+"��"+offers[i][1]+")�� ";																	
							business1.setFuncname("pubChgCityOfferChg");					
							param1.setOper("3");
							param1.setBegin_time(offers[i][5]);
							param1.setNewofferid(offers[i][0]);
							param1.setEnd_time(offers[i][6]);
							business1.setParam(param1);
						}
						else/*�ط�*/
						{
							if(offers[i][7]=="A")
							{
								business1.setFuncname("pubChgCityProdChg");
								param1.setOper("3");
								param1.setBegin_time(offers[i][5]);
								param1.setProduct_id(offers[i][0]);
								param1.setEnd_time(offers[i][6]);
								business1.setParam(param1);							
							}
							else
							{
								continue;	
							}

						}					
					}
					offerList1.setBusiness(business1);	
				}				
				/*
				*��ֵҵ������ƴ��json yanpx 20120425 add
				*/
				for(var j=0;j<valueAddedServices.length;j++){
					
					var paramAdd		= new	param();
					var businessAdd	= new	business();		
					businessAdd.setFuncname("platBusiOper");					
					paramAdd.setOper("06");
					paramAdd.setBusitype(valueAddedServices[j][0]);
					businessAdd.setParam(paramAdd);	
						
					offerList1.setBusiness(businessAdd);								
				}
				
				/*��Ʒ��*/
				for(var j=0;j<var9127Qry.length;j++){
					
					var paramAdd		= new	param();
					var businessAdd	= new	business();		
					businessAdd.setFuncname("spBusiOper");	
					paramAdd.setBiztype(var9127Qry[j][10-6]);
					paramAdd.setSpid(var9127Qry[j][12-6]);
					paramAdd.setBizcode(var9127Qry[j][14-6]);
					paramAdd.setOper("06");
					businessAdd.setParam(paramAdd);	
						
					offerList1.setBusiness(businessAdd);								
				}				
				
				
				/*
				*Я���ƴ��json yanpx 20120426 add
				*/				
				var in_group_id		=document.getElementById("groupId").value;    /*Я���group_id*/
				var send_status = "N";
				if(parseInt(giftCount)>0){    /*�������Ҫ�콱��Ӫ���� ��send_statusΪY*/
					send_status = "Y"
				}
				var paramBelong		= new	param();
				var businessBelong	= new	business();	
				businessBelong.setFuncname("pubPhoneBelongChg");
				paramBelong.setOper("06");	
				paramBelong.setGroup_id("");
				paramBelong.setIn_group_id(in_group_id);
				paramBelong.setSend_status(send_status);
				paramBelong.setSms_release("");
				paramBelong.setBack_accept("");
				businessBelong.setParam(paramBelong);
				offerList1.setBusiness(businessBelong);
				/*ƴjson��*/
				var myJSONText = JSON.stringify(offerList1,function(key,value){
					return value;
				});
				
				document.getElementById("myJSONText").value=myJSONText;
				
				/*�������˶������ʷѵ���Чʱ��,ʧЧʱ�䶼������1��,
					������ȡһ��ʱ�����*/	
				pntOfr1+="          �����ѡ�ʷ���Чʱ�䣺"+eff_time;	
				pntOfr3=	pntOfr3.substring(0,pntOfr3.length-2);																						
				pntOfr3+="          �����ѡ�ʷ�ʧЧʱ�䣺"+eff_time;				
				pntOfr10+="         ԤԼ���ʷ���Чʱ�䣺"+eff_time;				
				document.all.busiEffTime.value=eff_time;
				/*����ѡ�ʷѴ�ӡ����ֵ*/																				
				document.getElementById("pntOfr1").value=pntOfr1;																									
				document.getElementById("pntOfr3").value=pntOfr3;																									
				document.getElementById("pntAddSvc").value=pntAddSvc;		
				document.getElementById("pntOfr10").value=pntOfr10;																							
				/*document.e687MainForm.action="fE687Cfm.jsp";
				document.e687MainForm.submit();				
				
				alert(myJSONText);*/	
				
				
				
				var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
				if(typeof(ret)!="undefined")
				{ 
					if((ret=="confirm"))
					{
						if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
						{
							conf();
						}
					}
					if(ret=="continueSub")
					{
						if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
						{
							conf();
						}
					}
				}
				else
				{
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
					{
						conf();
					}
				}		
							
			}
			
		function conf()
		{
				document.e687MainForm.action="fE687Cfm.jsp";
				document.e687MainForm.submit();				
		}
		

		function showPrtDlg(printType,DlgMessage,submitCfm)
		{  //��ʾ��ӡ�Ի���
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var pType="subprint";
			var billType="1";
			var sysAccept = "<%=create_accept%>";
			var printStr = printInfo(printType);
		
			var mode_code=null;
			var fav_code=null;
			var area_code=null
		
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp"
				+"?DlgMsg="+DlgMessage;
			var path = path  + "&mode_code="+mode_code
				+"&fav_code="+fav_code
				+"&area_code="+area_code
				+"&opCode=<%=opCode%>&sysAccept="+sysAccept
				+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm
				+"&pType="+pType+"&billType="+billType
				+ "&printInfo=" + printStr;

			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
		}	
			
		</script>
	</head>
	<FORM name="e687MainForm" action="" method=post>
		<%@ include file="/npage/include/header.jsp" %>	
		<input type="hidden" name="custOrderId" value="<%=custOrderId%>"/>
		<input type="hidden" name="custOrderNo" value="<%=custOrderNo%>"/>
		<input type="hidden" id="opCode" name="opCode" value="<%=opCode%>">
		<input type="hidden" id="opName" name="opName" value="<%=opName%>">
		<input type="hidden" id="phoneNo" name="phoneNo" value="<%=phoneNo%>">
		<!--ҵ����Чʱ��, ,�����-->
		<input type="hidden" id="busiEffTime" name="busiEffTime" value="">
		<!--������ѡ�ʷѴ�ӡ��-->
		<input type="hidden" id="pntOfr1" name="pntOfr1" value="">
		<!--�˶���ѡ�ʷѴ�ӡ��-->
		<input type="hidden" id="pntOfr3" name="pntOfr3" value="">
		<!--��ֵҵ���˶���ӡ��-->
		<input type="hidden" id="pntAddSvc" name="pntAddSvc" value="">
		<!--���������ʷѴ�ӡ��-->
		<input type="hidden" id="pntOfr10" name="pntOfr10" value="">
		<div id="userInfoDiv">
			<div class="title">
				<div id="title_zi">�û�������Ϣ </div>
			</div>
			<%@include file="fE687UserInfo.jsp"%>
		</div>
		<div id="offerDiv">
			<div class="title">
				<div id="title_zi">�ʷ��б� </div>
			</div>
			<%@include file="fE687OfferInfo.jsp"%>
		</div>
		<div id="bizDiv">
			<div class="title">
				<div id="title_zi">Ӫ����Ϣ </div>
			</div>
			
	    <table>
			<tr align="center">
				<th>���ܴ��� </th>
				<th>����� </th>
				<th>���ʼʱ�� </th>
				<th>�����ʱ�� </th>
			</tr>
			
			<%
			if (arrSaleQry.length!=0)
			{
				for ( int i=0; i<arrSaleQry.length ; i++ )
				{
					String tbCls= (i%2==0 )? "Grey" : "";
				%>
	          		<tr>
					<td class="<%=tbCls%>"><%=arrSaleQry[i][0]%></td>
					<td class="<%=tbCls%>"><%=arrSaleQry[i][1]%></td>
					<td class="<%=tbCls%>"><%=arrSaleQry[i][2]%></td>
					<td class="<%=tbCls%>"><%=arrSaleQry[i][3]%></td>   
				</tr>				
				<%	
				}
			}
			else
			{%>
				<tr>
					<td colspan="4" align="center">���û�û��Ӫ����Ϣ��</td>  
				</tr>	
			<%
			}
			%>
	    </table>
			
		</div>	
		
		<div id="bizDiv">
			<div class="title">
				<div id="title_zi">��ֵҵ�� </div>
			</div>
		</div>	
			
		<!--�û���������ֵҵ��b-->				
		<table>
			<tr>
				<th>���</th>
				<th>�������</th>
				<th>�ֻ�����</th>
				<th>�ʷ�id</th>
			</tr>
			<%
				if(platBusiQryResult.length>0 ||!a9127Qry0[0][3].equals("0" )){
					for(int i=0;i<platBusiQryResult.length;i++)
					{
					%>
						<tr>
							<td><%=platBusiQryResult[i][0]%></td>
							<td><%=platBusiQryResult[i][1]%></td>
							<td><%=platBusiQryResult[i][2]%></td>
							<td><%=platBusiQryResult[i][3]%></td>
						</tr>
					<%
					}
					
					for ( int i=0;i<a9127Qry1.length;i++ )
					{
					%>
						<tr>
							<td><%=a9127Qry1[i][4]%></td>
							<td><%=a9127Qry1[i][5]%></td>
							<td><%=a9127Qry1[i][2]%></td>
							<td><%=a9127Qry1[i][9]%></td>
						</tr>
					<%					
					}
					
				}else{
			%>
			<tr>
				<td colspan="4" align="center">
					���û�û����ֵҵ��
				</td>
			</tr>				
			<%
				}
			%>
		</table>
		<!--�û���������ֵҵ��e-->	
		<!--��Ʒ��-->
		<div id="offerDiv">
			<%@include file="fE687GiftInfo.jsp"%>
		</div>
		<!--��Ʒ��-->		
		<!--����Ʒ������b-->
		<div id="offerDiv">
			<%@include file="fE687AddOffer.jsp"%>
		</div>
		<!--����Ʒ������e-->
		
		<div id="footer" align="center">
			<input class="b_foot" name=confirm id="confirm" type=button
				onClick="doCfm()" value="ȷ��">
			&nbsp;
			<input class="b_foot" name=back onClick="removeCurrentTab()"
				type=button value="�ر�">
		</div>
		<%@ include file="/npage/include/footer_new.jsp"%>
	</form>
	<script>
		/*��װ��ӡ��Ϣ*/		
		function printInfo(printType)
		{    
			var inRegNm="";
			var obj=document.getElementById("groupId");
			
			for(i=0;i<obj.length;i++)
			{
				if(obj[i].selected==true)
				{
					inRegNm=obj[i].innerText; //�ؼ���ͨ��option�����innerText���Ի�ȡ��ѡ���ı�
				}
			}
			
			/*�ͻ���Ϣ*/
			var cust_info="";
			/*ҵ����Ϣ*/
			var opr_info="";
			
			/*��ע��Ϣ*/
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			var busiEffTime=document.getElementById("busiEffTime").value;
			cust_info+= "�ֻ����룺     "+"<%=phoneNo%>"+"|";
			cust_info+= "�ͻ�������     "+"<%=stPMcust_name%>"+"|";
		
			opr_info+="�ͻ�Ʒ�ƣ�"+"<%=stPMsm_name%>"
				+"          ����ҵ��ԤԼʡ��Я��          ��Ч��ʽ��ԤԼ��Ч"+"|";
			opr_info+="������ˮ��"+"<%=create_accept%>"+"|"; 	
			opr_info+="ҵ�����ʱ�䣺"+"<%=createTime2%>"
				+"          ҵ����Чʱ�䣺"+busiEffTime.substring(0,4)+"��"
				+busiEffTime.substring(4,6)+"��"
				+busiEffTime.substring(6,8)+"��|"; 
			opr_info+="ԤԼЯ���أ�"+"<%=regNm%>"
				+"          ԤԼЯ��أ�:"+inRegNm+"|"; 				
			opr_info+="��ǰ���ʷѣ�("+document.getElementById("curOfferId").value
				+"��"+document.getElementById("curOfferNm").value+")"+"|";

			/*�������ʷ�*/
			opr_info+=document.getElementById("pntOfr10").value+"|";
			/*��������Ŀ�ѡ�ʷѣ�*/
			opr_info+=document.getElementById("pntOfr1").value+"|";
			/*�����˶��Ŀ�ѡ�ʷѣ�*/
			note_info2+=document.getElementById("pntOfr3").value+"|";
			note_info2+="ҵ��˵����|";
			note_info2+="1. Я����Ч��Я��ͻ���ͬ��Я�����ͨ�ͻ��Ʒѡ�"+"|";
			note_info2+="2. Я���ؼ�Я����ƶ��ͻ��ڷ�����״̬�£�����Я�ſͻ���������ձ���ͨ���Ʒѡ�"+"|";
			note_info2+="3. Я��ط��ƶ��ͻ��ڷ�����״̬�²���Я�ſͻ����룬������Я�����ƶ��ͻ�ͨ����ԭ��Ʒѡ�"+"|";
			note_info2+= "4��ʡ��Я��ҵ����ʽ��Ч�󣬲����Գ�����"+"|";
			note_info2+= "5���ڰ���ʡ��Я��ҵ�����Я�����Ч���6�������Ժ󣬲ſ������������һ��ʡ��Я��ҵ��"+"|";
			note_info2+= "6��ʡ��Я�ſͻ���������Я��ع�����"+"|";
			if ("<%=s2266InitNewArr.length%>"!="0" 
				||"<%=s6842SelArr.length%>"!="0"  )
			{
				note_info2 +="��Ŀǰ����δ��ȡ��Ӫ�����Ʒ��������������ȡ����Я��ҵ����Ч�󣬽��޷���ȡ��"+"|";
			}
			
			var grpObj=document.getElementById("groupId");
			/*
			var inRegNm="";
			for(i=0;i<grpObj.length;i++)
			{
				if(grpObj[i].selected==true)
				{
					inRegNm=grpObj[i].innerText; //�ؼ���ͨ��option�����innerText���Ի�ȡ��ѡ���ı�
				}
			}
			*/			
			
			note_info2 +="����"+"<%=createTime1%>"+"������������ֵҵ��Ϊ��"+"|";
			note_info2 +=document.getElementById("pntAddSvc").value;
			note_info2 +="����ҵ����ʡ��Я��ҵ����Ч���Զ�ȡ���������Ը�����Ҫ���¶�����"+"|";
			note_info2 +="��ҵ����Чǰ�������ܲ���Я���ص�Ӫ���������Я���ص������ʷѡ�����ҵ�����ֵҵ����ҵ����Ч���ܰ���Я��صļ���V��ҵ��"+"|";
			note_info2 +="��ҵ����Ч�������Ը�����Ҫ�����в���Я���"+inRegNm+"��Ӫ����������������Ҫ���ʷѡ����޷�����Я��صļ���V��ҵ��"+"|";
			note_info2 +="��Я��ҵ����Ч����������������ǰ���μ�Ӫ����Ļ��ѷ�����"+"|";

			retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		    return retInfo;
		}
					
	</script>
</html>
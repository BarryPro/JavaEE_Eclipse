<%
/*
 * 功能: 省内携号
 * 版本: 1.0
 * 日期: 2012/3/9 14:19:13
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String opCode="e687";
String opName="省内携号申请";
String regCode=(String)session.getAttribute("regCode");
String groupId = (String)session.getAttribute("groupId");
String workNo = (String)session.getAttribute("workNo");  
String password =(String)session.getAttribute("password"); 
String phoneNo=request.getParameter("activePhone");
String custOrderId = WtcUtil.repNull(request.getParameter("custOrderId"));	  //客户订单号
String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));    //客户订单编号

String retCodeM="";
String retMsgM="";
String sqlE687ServId = "select  "
	+" to_char(id_no)  , phone_no ,t1.region_name "
	+"from dcustmsg t ,  sregioncode t1 "
	+"  where t1.region_code = substr(t.belong_code ,1,2) and  t.phone_no=:phoneNo";
	
String sqlE687ServIdPhone= "phoneNo="+phoneNo;

java.util.Date sysdate = new java.util.Date();
java.text.SimpleDateFormat sf 
	= new java.text.SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒");
String createTime = sf.format(sysdate);

java.text.SimpleDateFormat sf1 
	= new java.text.SimpleDateFormat("yyyy年MM月dd日 HH时mm分");
String createTime1 = sf1.format(sysdate);

java.text.SimpleDateFormat sf2
	= new java.text.SimpleDateFormat("yyyy年MM月dd日");
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
	*查询增值业务信息 yanpx 20120425
	*服务platBusiQry
	*入参  标准入参
	*返回  1 oRetCode 2 oRetMsg 3 ocatalog 类别 4 ocatalogName		类别名称 5 ophoneNo 手机号码 6 oofferId 资费id
	*/
		String paraAray[] = new String[43];	
		paraAray[0] = "0";  									     // 打印流水                
		paraAray[1] = "01"; 											 //渠道标识
		paraAray[2] = opCode; 							     //功能代码   
		paraAray[3] = workNo;								     //操作工号               
		paraAray[4] = password; 								 //工号密码                
		paraAray[5] = phoneNo; 									 //移动号码               
		paraAray[6] = "";    										 //移动号码 密码
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
			*增值业务java数组转换为js数组 yanpx 20120425
			*/
			var valueAddedServices=new Array();
			var pntAddSvc=""; 
			<%
			for (int i=0; i<platBusiQryResult.length ; i++)
			{
			%>
				valueAddedServices["<%=i%>"]=new Array(); 
				pntAddSvc+="<%=platBusiQryResult[i][1]%>业务(<%=platBusiQryResult[i][1]%>)"+"|"; 
				<%
				for (int j=0 ; j<platBusiQryResult[i].length ; j++)
				{
				%>
					valueAddedServices["<%=i%>"]["<%=j%>"]="<%=platBusiQryResult[i][j]%>"; 
				<%
				}
			}%>  	
			
			/* zhangyan 产品部的增值业务*/
			
			var var9127Qry=new Array();
			<%
			if (  !a9127Qry0[0][3].equals("0" ) )
			{
				for (int i=0; i<a9127Qry1.length ; i++)
				{
					%>
					var9127Qry["<%=i%>"]=new Array(); 
					pntAddSvc+="<%=a9127Qry1[i][11-6]%>业务(<%=a9127Qry1[i][11-6]%>)"+"|"; 
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
					rdShowMessageDialog("用户有营销案信息,不能办理该业务!",0);
					return false;					
				}
				
				
				if ($("#offerId").val()==0)
				{
					rdShowMessageDialog("必须选择资费!",0);
					return false;
				}
				
				if ($("#attrFlag").val()=="1")
				{
					if ($("#attrFlagHv").val()=="0")
					{
						rdShowMessageDialog("该资费必须设置小区代码!",0);
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
				publicinfo1.setOp_note("e687省内携号申请");

				/*展示*/
				offerList1.setPubicinfo(publicinfo1);					
				/*订购可选资费打印串*/
				var pntOfr1="本次申请的可选资费：";
				/*退订可选资费打印串*/
				var pntOfr3="本次取消的可选资费：";
				/*订购主资费打印串*/
				var pntOfr10="";
				
				for ( var i=0;i<offers.length;i++ )
				{
				
					var param1		= new	param();
					var business1	= new	business();			
					if (offers[i][4]=="1")/*订购*/
					{
						if (offers[i][3]=="0")/*主资费*/
						{						
							business1.setFuncname("pubChgCityOfferChg");
							if (offers[i][7]=="Y")/*只有主资费有小区代码*/
							{
								param1.setAreacode($("#attrFlagHv").val());
							}
							
							pntOfr10+="预约主资费：("+offers[i][0]+"、"
								+document.getElementById("smCode").value+"、"+offers[i][1]+")";
							param1.setOper("1");
							eff_time=offers[i][5]; 
							param1.setBegin_time(offers[i][5]);
							param1.setNewofferid(offers[i][0]);
							param1.setEnd_time(offers[i][6]);
							business1.setParam(param1);
						}
						else if(offers[i][3]=="1")/*可选资费*/
						{
							
							pntOfr1+="("+offers[i][0]+"、"+offers[i][1]+") ";
							business1.setFuncname("pubChgCityOfferChg");					
							param1.setOper("1");
							param1.setBegin_time(offers[i][5]);
							param1.setNewofferid(offers[i][0]);
							param1.setEnd_time(offers[i][6]);
							business1.setParam(param1);
						}
						else/*特服*/
						{
							business1.setFuncname("pubChgCityProdChg");					
							param1.setOper("1");
							param1.setBegin_time(offers[i][5]);
							param1.setProduct_id(offers[i][0]);
							param1.setEnd_time(offers[i][6]);
							business1.setParam(param1);
						}	
					}
					else if(offers[i][4]=="3") /*退订*/
					{
						if (offers[i][3]=="0")/*主资费*/
						{
							business1.setFuncname("pubChgCityOfferChg");					
							param1.setOper("3");
							param1.setBegin_time(offers[i][5]);
							param1.setNewofferid(offers[i][0]);
							param1.setEnd_time(offers[i][6]);
							business1.setParam(param1);
						}
						else if(offers[i][3]=="1")/*可选资费*/
						{		
							
							pntOfr3+="("+offers[i][0]+"、"+offers[i][1]+")、 ";																	
							business1.setFuncname("pubChgCityOfferChg");					
							param1.setOper("3");
							param1.setBegin_time(offers[i][5]);
							param1.setNewofferid(offers[i][0]);
							param1.setEnd_time(offers[i][6]);
							business1.setParam(param1);
						}
						else/*特服*/
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
				*增值业务数据拼如json yanpx 20120425 add
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
				
				/*产品部*/
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
				*携入地拼如json yanpx 20120426 add
				*/				
				var in_group_id		=document.getElementById("groupId").value;    /*携入地group_id*/
				var send_status = "N";
				if(parseInt(giftCount)>0){    /*如果有需要领奖的营销案 则send_status为Y*/
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
				/*拼json串*/
				var myJSONText = JSON.stringify(offerList1,function(key,value){
					return value;
				});
				
				document.getElementById("myJSONText").value=myJSONText;
				
				/*订购和退订的主资费的生效时间,失效时间都是下月1日,
					因此随便取一个时间就行*/	
				pntOfr1+="          申请可选资费生效时间："+eff_time;	
				pntOfr3=	pntOfr3.substring(0,pntOfr3.length-2);																						
				pntOfr3+="          申请可选资费失效时间："+eff_time;				
				pntOfr10+="         预约主资费生效时间："+eff_time;				
				document.all.busiEffTime.value=eff_time;
				/*给可选资费打印表单赋值*/																				
				document.getElementById("pntOfr1").value=pntOfr1;																									
				document.getElementById("pntOfr3").value=pntOfr3;																									
				document.getElementById("pntAddSvc").value=pntAddSvc;		
				document.getElementById("pntOfr10").value=pntOfr10;																							
				/*document.e687MainForm.action="fE687Cfm.jsp";
				document.e687MainForm.submit();				
				
				alert(myJSONText);*/	
				
				
				
				var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
				if(typeof(ret)!="undefined")
				{ 
					if((ret=="confirm"))
					{
						if(rdShowConfirmDialog('确认电子免填单吗？')==1)
						{
							conf();
						}
					}
					if(ret=="continueSub")
					{
						if(rdShowConfirmDialog('确认要提交信息吗？')==1)
						{
							conf();
						}
					}
				}
				else
				{
					if(rdShowConfirmDialog('确认要提交信息吗？')==1)
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
		{  //显示打印对话框
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
		<!--业务生效时间, ,免填单用-->
		<input type="hidden" id="busiEffTime" name="busiEffTime" value="">
		<!--订购可选资费打印串-->
		<input type="hidden" id="pntOfr1" name="pntOfr1" value="">
		<!--退订可选资费打印串-->
		<input type="hidden" id="pntOfr3" name="pntOfr3" value="">
		<!--增值业务退订打印串-->
		<input type="hidden" id="pntAddSvc" name="pntAddSvc" value="">
		<!--订购的主资费打印串-->
		<input type="hidden" id="pntOfr10" name="pntOfr10" value="">
		<div id="userInfoDiv">
			<div class="title">
				<div id="title_zi">用户基本信息 </div>
			</div>
			<%@include file="fE687UserInfo.jsp"%>
		</div>
		<div id="offerDiv">
			<div class="title">
				<div id="title_zi">资费列表 </div>
			</div>
			<%@include file="fE687OfferInfo.jsp"%>
		</div>
		<div id="bizDiv">
			<div class="title">
				<div id="title_zi">营销信息 </div>
			</div>
			
	    <table>
			<tr align="center">
				<th>功能代码 </th>
				<th>活动名称 </th>
				<th>活动开始时间 </th>
				<th>活动结束时间 </th>
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
					<td colspan="4" align="center">该用户没有营销信息！</td>  
				</tr>	
			<%
			}
			%>
	    </table>
			
		</div>	
		
		<div id="bizDiv">
			<div class="title">
				<div id="title_zi">增值业务 </div>
			</div>
		</div>	
			
		<!--用户订购的增值业务b-->				
		<table>
			<tr>
				<th>类别</th>
				<th>类别名称</th>
				<th>手机号码</th>
				<th>资费id</th>
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
					该用户没有增值业务！
				</td>
			</tr>				
			<%
				}
			%>
		</table>
		<!--用户订购的增值业务e-->	
		<!--礼品区-->
		<div id="offerDiv">
			<%@include file="fE687GiftInfo.jsp"%>
		</div>
		<!--礼品区-->		
		<!--销售品订购区b-->
		<div id="offerDiv">
			<%@include file="fE687AddOffer.jsp"%>
		</div>
		<!--销售品订购区e-->
		
		<div id="footer" align="center">
			<input class="b_foot" name=confirm id="confirm" type=button
				onClick="doCfm()" value="确定">
			&nbsp;
			<input class="b_foot" name=back onClick="removeCurrentTab()"
				type=button value="关闭">
		</div>
		<%@ include file="/npage/include/footer_new.jsp"%>
	</form>
	<script>
		/*组装打印信息*/		
		function printInfo(printType)
		{    
			var inRegNm="";
			var obj=document.getElementById("groupId");
			
			for(i=0;i<obj.length;i++)
			{
				if(obj[i].selected==true)
				{
					inRegNm=obj[i].innerText; //关键是通过option对象的innerText属性获取到选项文本
				}
			}
			
			/*客户信息*/
			var cust_info="";
			/*业务信息*/
			var opr_info="";
			
			/*备注信息*/
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			var busiEffTime=document.getElementById("busiEffTime").value;
			cust_info+= "手机号码：     "+"<%=phoneNo%>"+"|";
			cust_info+= "客户姓名：     "+"<%=stPMcust_name%>"+"|";
		
			opr_info+="客户品牌："+"<%=stPMsm_name%>"
				+"          办理业务：预约省内携号          生效方式：预约生效"+"|";
			opr_info+="操作流水："+"<%=create_accept%>"+"|"; 	
			opr_info+="业务办理时间："+"<%=createTime2%>"
				+"          业务生效时间："+busiEffTime.substring(0,4)+"年"
				+busiEffTime.substring(4,6)+"月"
				+busiEffTime.substring(6,8)+"日|"; 
			opr_info+="预约携出地："+"<%=regNm%>"
				+"          预约携入地：:"+inRegNm+"|"; 				
			opr_info+="当前主资费：("+document.getElementById("curOfferId").value
				+"、"+document.getElementById("curOfferNm").value+")"+"|";

			/*订购主资费*/
			opr_info+=document.getElementById("pntOfr10").value+"|";
			/*本次申请的可选资费：*/
			opr_info+=document.getElementById("pntOfr1").value+"|";
			/*本次退订的可选资费：*/
			note_info2+=document.getElementById("pntOfr3").value+"|";
			note_info2+="业务说明：|";
			note_info2+="1. 携号生效后，携入客户等同于携入地普通客户计费。"+"|";
			note_info2+="2. 携出地及携入地移动客户在非漫游状态下，拨打携号客户号码均按照本地通话计费。"+"|";
			note_info2+="3. 携入地非移动客户在非漫游状态下拨打携号客户号码，按照与携出地移动客户通话的原则计费。"+"|";
			note_info2+= "4．省内携号业务正式生效后，不可以撤销。"+"|";
			note_info2+= "5．在办理省内携号业务后，在携入地生效后第6个账期以后，才可以申请办理下一次省内携号业务。"+"|";
			note_info2+= "6．省内携号客户不可以在携入地过户。"+"|";
			if ("<%=s2266InitNewArr.length%>"!="0" 
				||"<%=s6842SelArr.length%>"!="0"  )
			{
				note_info2 +="您目前有尚未领取的营销活动奖品，建议您尽快领取，在携号业务生效后，将无法领取。"+"|";
			}
			
			var grpObj=document.getElementById("groupId");
			/*
			var inRegNm="";
			for(i=0;i<grpObj.length;i++)
			{
				if(grpObj[i].selected==true)
				{
					inRegNm=grpObj[i].innerText; //关键是通过option对象的innerText属性获取到选项文本
				}
			}
			*/			
			
			note_info2 +="截至"+"<%=createTime1%>"+"，您订购的增值业务为："+"|";
			note_info2 +=document.getElementById("pntAddSvc").value;
			note_info2 +="上述业务将在省内携号业务生效后自动取消，您可以根据需要重新订购。"+"|";
			note_info2 +="在业务生效前，您不能参与携出地的营销活动，办理携出地的其他资费、集团业务或增值业务。在业务生效后不能办理携入地的集团V网业务。"+"|";
			note_info2 +="在业务生效后，您可以根据需要，自行参与携入地"+inRegNm+"的营销活动，或办理您所需要的资费。但无法办理携入地的集团V网业务。"+"|";
			note_info2 +="在携号业务生效后，您将不再享受以前所参加营销活动的话费返还。"+"|";

			retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		    return retInfo;
		}
					
	</script>
</html>
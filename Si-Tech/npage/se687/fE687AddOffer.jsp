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
<script>	
function g(o)
{
	return document.getElementById(o);
}	
	
function HoverLi(n, t) 
{
	document.all.offerId.value = "";
	for ( var i = 1; i <= t; i++) 
	{
		g('tb_' + i).className = 'normaltab';
		g('tb_' + i).checked = false;
	}
	g('tb_' + n).className = 'current';
	g('tb_' + n).checked = true;
	if (n == 1) 
	{
		$("#qryOfferBtn").unbind();
		$("#qryOfferBtn").bind("click", qryMainOffer);
		$("[name='searchType'][value='0']").attr("checked", true);
		$("#offerType").parent().show();
		$("#bindId").parent().show();
		$("#custType").parent().show();
		$("#roleInfoP").hide();
		operateFlag = 1;
	} 
	else if (n == 2) 
	{
		$("#qryOfferBtn").unbind();
		$("#qryOfferBtn").bind("click", qryAddOffer);
		$("#offerListDiv").empty(); //��տ�ѡ����Ʒչʾ��
		$("#offerType").parent().hide(); //���ز�ѯ���� $("#bindId").parent().hide();
		//����ҵ��Ʒ�� $("#custType").parent().hide(); //���ؿͻ�����
		$("#roleInfoP").show();
		operateFlag = 2;
	} 
	else if (n == 3) {}
}

function toLeft() 
{
	if ($("#LRImg").attr("name") == "left") 
	{
		$('#left').animate( {
			'marginLeft' :"-395px"
		}, 'slow');
		$("#LRImg").attr( {
			src :"/nresources/default/images/arrow_left.gif",
			name :"right"
		});
		$("#right").removeClass();
		$("#leftSpan").attr("class", "item-50 col-1");
	} 
	else 
	{
		$('#left').animate
		(
			{
				'marginLeft' :"0px"
			}, 
			'slow', 
			function() 
			{
				$("#right").addClass("item-col col-2");
				$("#leftSpan").attr("class", "item-col2 col-1");
			}
		);
		$("#LRImg").attr
		( 
			{
				src :"/nresources/default/images/arrow_right.gif",
				name :"left"
			}
		);
	}
}

//��������Ʒ�б�
function getOffer()
{	
	var objGroupId		=document.getElementById("groupId");
	var objCurOfferId	=document.getElementById("curOfferId");
	var objSmCode 		=document.getElementById("smCode");
	//alert(objGroupId.value);
	if (objGroupId.value=="")
	{
		rdShowMessageDialog("ת���������ѡ��",0);
		return false;
	}
	
	if (objSmCode.value=="$$$$$$")
	{
		rdShowMessageDialog("Ʒ�Ʊ���ѡ��",0);
		return false;		
	}
	var packet = new AJAXPacket("fE687GetOffer.jsp","���Ժ�...");
	packet.data.add("groupId",objGroupId.value);
	packet.data.add("curOfferId",objCurOfferId.value);
	packet.data.add("smCode",objSmCode.value);
	packet.data.add("phoneNo","<%=phoneNo%>");
	core.ajax.sendPacket(packet,setOffer);
	packet =null;	
	
}

function setOffer(packet)
{
	var errorCode 	= packet.data.findValueByName("errorCode");
	var errorMsg 	= packet.data.findValueByName("errorMsg");	
	if(errorCode == "000000")
	{
		var offers = packet.data.findValueByName("offers");
		$("#offerListDiv table").remove();
		$("#offerListDiv").append("<table id='offerListTab'><thead><tr style='cursor:hand'>"
			+"<th  onclick=\"sortTable('offerListTab',0,'zh')\">����ƷID</th>"
			+"<th  onclick=\"sortTable('offerListTab',1,'zh')\">����Ʒ����</th>"
			+"<th>����&nbsp;����</th></tr></thead></table>");
		for(var i=0 ; i<offers.length; i++)
		{
			var offer_id 	= 	offers[i][0];
			var offer_name 	= 	offers[i][1];
			//var attrFlag = offers[i][6];	
			var offerIds=offer_id+"|";
			var divOfferIds= "coltr_"+offer_id+"|";
			$("#offerListTab")
				.append(
					"<tr><td>"
					+ offer_id
					+ "</td><td  id='coltr_"
					+ offer_id
					+ "'>"
					+ offer_name
					+ "</td>"
					+"<td><img src='/nresources/default/images/ab1.gif' style='cursor:hand' alt='����' id='col_"
					+ offer_id
					+ "' onClick='getBookOffer("
					+ offer_id
					+ ")' />&nbsp;&nbsp;&nbsp;</span>"
					+"<img src='/nresources/default/images/child.gif' "
					+"style='cursor:hand' name='' alt='�鿴��ϸ��Ϣ' id='detail_"+offer_id
					+"' onClick='showdesc("+offer_id+",0)'>"
					+"</td></tr>");
		}
		btcGetMidPrompt("10442", offerIds, divOfferIds);		
	}
	else
	{
		rdShowMessageDialog(errorMsg);
		return false;	
	}
}

function getBookOffer(offerId)
{
	var objGroupId		=document.getElementById("groupId");
	var objCurOfferId	=document.getElementById("curOfferId");
	var objSmCode 		=document.getElementById("smCode");
	var packet = new AJAXPacket("fE687Get40Offer.jsp","���Ժ�...");
	packet.data.add("groupId",objGroupId.value);
	packet.data.add("curOfferId",objCurOfferId.value);
	packet.data.add("smCode",objSmCode.value);
	packet.data.add("phoneNo","<%=phoneNo%>");
	packet.data.add("offerId",offerId);
	core.ajax.sendPacket(packet,setBookOffer);
	packet =null;		
}
function delOffer()
{
	$("#addedOfferTab tr:gt(1)").remove();
	$("#addedProdTab tr:gt(1)").remove();
	$("#addedProdTab").hide();
	$("#offerUnbookTab tr:gt(1)").remove();
	$("#prodUnbookTab tr:gt(1)").remove();
	$("#prodUnbookTab").hide();	
	
	$("#myJSONText").val("");	
	$("#attrFlagHv").val("0");	
	$("#attrFlag").val("0");	
	$("#attrOfferId").val("0");	
	$("#offerId").val("0");	
}

var offers 	="";
function setBookOffer(packet)
{
	if ($("#offerId").val()!=0)
	{
		rdShowMessageDialog("�����ظ������ʷ�!",0);
		return false;
	}
	
	var errorCode 	= packet.data.findValueByName("errorCode");
	var errorMsg 	= packet.data.findValueByName("errorMsg");	
	offers	= packet.data.findValueByName("offers");

	if (errorCode=="000000")
	{	
		$("#addedOfferTab tr:gt(1)").remove();
		$("#addedProdTab tr:gt(1)").remove();
		$("#addedProdTab").show();
		$("#offerUnbookTab tr:gt(1)").remove();
		$("#prodUnbookTab tr:gt(1)").remove();
		$("#prodUnbookTab").show();	
		
		$("#myJSONText").val("");	
		$("#attrFlagHv").val("0");	

		$("#attrOfferId").val("0");	
		$("#offerId").val("0");			
			
		for ( var i=0;i<offers.length;i++ )
		{
			if (offers[i][4]=="1")/*����*/
			{
				if (offers[i][3]=="0")/*���ʷ�*/
				{
					$("#offerId").val(offers[i][0]);
					$("#addedOfferTab").append("<tr id='tr_"+offers[i][0]
						+"' style='cursor:hand' name='' ><td>"
						+"<img src='/nresources/default/images/icon_no.gif' "
						+"style='cursor:hand' name='' alt='' id=''></td><td>"
						+offers[i][0]+"</td><td>"+offers[i][1]
						+"</td><td id='effTimeTd_"+offers[i][0]+"'>"
						+offers[i][5].substring(0,9)+"</td><td id='expTimeTd_"
						+offers[i][0]+"'>"+offers[i][6].substring(0,9)+"</td>"
						+"<td><img src='/nresources/default/images/task-item-close1.gif' style='cursor:Pointer;' "
						+"class='del_cls' name='offerCancel' alt='ɾ��ѡ�������Ʒ' id='offerCancel'"
						+"onclick='delOffer()'	></td>");
					if (offers[i][7]=="Y")/*��С������*/
					{
						$("#attrFlag").val("1");	
						$("#attrOfferId").val(offers[i][0]);
						var buttonStr="<input  type='button' name='offe_"+offers[i][1]
						+"'  value='С������'"
						+"' _offerInstId='"+0+"' effT='"+offers[i][5]
						+"' id='att_"+offers[i][0]
						+"' offid='"+offers[i][0]+"' class='but_property' />";
						$("#addedOfferTab").append("<tr class='setInfoTr_"+offers[i][0]
						+"' ><td colspan='6'>"+buttonStr+"</td></tr>");
						$("#addedOfferTab :button[id^='att']").bind('click', showAttribute);
					}							
				}
				else if(offers[i][3]=="1")/*��ѡ�ʷ�*/
				{

					$("#addedOfferTab").append("<tr id='tr_"+offers[i][0]
						+"' style='cursor:hand' name='' ><td>"
						+"<img src='/nresources/default/images/icon_no.gif' "
						+"style='cursor:hand' name='' alt='' id=''></td><td>"
						+offers[i][0]+"</td><td>"+offers[i][1]
						+"</td><td id='effTimeTd_"+offers[i][0]+"'>"
						+offers[i][5].substring(0,9)+"</td><td id='expTimeTd_"
						+offers[i][0]+"'>"+offers[i][6].substring(0,9)+"</td>"
						+"<td><img src='/nresources/default/images/task-item-close.gif' style='cursor:Pointer;' class='del_cls' name='' alt='ɾ��ѡ�������Ʒ' id=''></td>");					
				}
				else/*�ط�*/
				{
					$("#addedProdTab").append("<tr id='tr_"+offers[i][0]
						+"' style='cursor:hand' name='' ><td>"
						+"<img src='/nresources/default/images/icon_no.gif' "
						+"style='cursor:hand' name='' alt='' id=''></td><td>"
						+offers[i][0]+"</td><td>"+offers[i][1]
						+"</td><td id='effTimeTd_"+offers[i][0]+"'>"
						+offers[i][5].substring(0,9)+"</td><td id='expTimeTd_"
						+offers[i][0]+"'>"+offers[i][6].substring(0,9)+"</td>"
						+"<td><img src='/nresources/default/images/task-item-close.gif' style='cursor:Pointer;' class='del_cls' name='' alt='ɾ��ѡ�������Ʒ' id=''></td>");					
				}	
			}
			else if(offers[i][4]=="3") /*�˶�*/
			{
				if (offers[i][3]=="0")/*���ʷ�*/
				{
					$("#offerUnbookTab").append("<tr id='tr_"+offers[i][0]
						+"' style='cursor:hand' name='' ><td>"
						+"<img src='/nresources/default/images/icon_no.gif' "
						+"style='cursor:hand' name='' alt='' id=''></td><td>"
						+offers[i][0]+"</td><td>"+offers[i][1]
						+"</td><td id='effTimeTd_"+offers[i][0]+"'>"
						+offers[i][5].substring(0,9)+"</td><td id='expTimeTd_"
						+offers[i][0]+"'>"+offers[i][6].substring(0,9)+"</td>"
						+"<td><img src='/nresources/default/images/task-item-close.gif' style='cursor:Pointer;' class='del_cls' name='' alt='ɾ��ѡ�������Ʒ' id=''></td>");					
					
				}
				else if(offers[i][3]=="1")/*��ѡ�ʷ�*/
				{
					$("#offerUnbookTab").append("<tr id='tr_"+offers[i][0]
						+"' style='cursor:hand' name='' ><td>"
						+"<img src='/nresources/default/images/icon_no.gif' "
						+"style='cursor:hand' name='' alt='' id=''></td><td>"
						+offers[i][0]+"</td><td>"+offers[i][1]
						+"</td><td id='effTimeTd_"+offers[i][0]+"'>"
						+offers[i][5].substring(0,9)+"</td><td id='expTimeTd_"
						+offers[i][0]+"'>"+offers[i][6].substring(0,9)+"</td>"
						+"<td><img src='/nresources/default/images/task-item-close.gif' style='cursor:Pointer;' class='del_cls' name='' alt='ɾ��ѡ�������Ʒ' id=''></td>");					
					
				}
				else/*�ط�*/
				{
					
					$("#prodUnbookTab").append("<tr id='tr_"+offers[i][0]
						+"' style='cursor:hand' name='' ><td>"
						+"<img src='/nresources/default/images/icon_no.gif' "
						+"style='cursor:hand' name='' alt='' id=''></td><td>"
						+offers[i][0]+"</td><td>"+offers[i][1]
						+"</td><td id='effTimeTd_"+offers[i][0]+"'>"
						+offers[i][5].substring(0,9)+"</td><td id='expTimeTd_"
						+offers[i][0]+"'>"+offers[i][6].substring(0,9)+"</td>"
						+"<td><img src='/nresources/default/images/task-item-close.gif' style='cursor:Pointer;' class='del_cls' name='' alt='ɾ��ѡ�������Ʒ' id=''></td>");							
				}					
			}
		}	
	}
	else
	{
		rdShowMessageDialog(errorCode+":"+errorMsg);
		return false;
	}
}

function showAttribute(){
	var queryType = this.name.substring(0,4);
	var queryId = this.id.substring(4);
	var offerName = this.name.substring(4);
	var effT = this.effT;
	var offerInstId = this._offerInstId;

	var offid=this.offid;
	var h=600;
	var w=800;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; "
		+"dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; "
		+"menubar:no; scrollbars:no; scroll:no; resizable:no;"
		+"location:no;status:no;help:no";
	var ret=window.showModalDialog("/npage/se687/fE687ShowAttr.jsp?phoneNo="
		+"<%=phoneNo%>"+"&offerId="+$("#offerId").val(),"",prop);

	if (ret!="")
	{	
		$("#attrFlagHv").val(ret);		
		$("#attrFlag").val("1");		
	}
}

function clearInfo()
{
	$("#groupId").val("");
	$("#groupName").val("");
	$("#smCode").val("$$$$$$");
}
</script>
<script src="sortTable.js" type="text/javascript"></script>
<%
String strStyle="";
%>
<input type="hidden"	id="myJSONText"		name="myJSONText"	value= "">
<input type="hidden"	id="attrFlagHv"		name="attrFlagHv"	value="0"/>
<input type="hidden"	id="attrFlag"		name="attrFlag" 	value="0"/>
<input type="hidden"	id="attrOfferId"	name="attrOfferId" 	value="0"/>
<input type="hidden"	id="offerId"		name="offerId" 		value="0"/>

<div id="items">
	<div class="item-row col-1" id="left">
		<div class="title">
			<div id="title_zi">����Ʒ������</div>
			<span style="float: right; padding: 3px 1px 0px 2px;">
				<img src='/nresources/default/images/arrow_right.gif'
					style='cursor: hand' name='left' alt='����۵�����Ʒ������' id='LRImg'
					onClick="toLeft()">
			</span>
		</div>
		<%
		strStyle="overflow-y: hidden; overflow-x: hidden;"
			+" background-color: #F7F7F7; border-right: 1px solid #95CBDD; "
			+"border-left: 1px solid #95CBDD; border-bottom: 1px solid #95CBDD; "
			+"height: 388px; FONT-WEIGHT: normal; FONT-SIZE: 13px;";
		%>
		<div style="<%=strStyle%>" class="list">
			<%
			strStyle="display: block; border-right: 0px solid #95CBDD; border-left: 0px solid #95CBDD;"
				+" border-bottom: 1px solid #95CBDD; height: 388px; PADDING-LEFT: 20px; COLOR: #0256b8; "
				+"FONT-WEIGHT: normal; FONT-SIZE: 12px;" ;
			%>
			<div id="searchOfferConDiv"
				style="<%=strStyle%>">
				<p align="center">ת����У�
					<wtc:service name="sGroupQry"  outnum="2"
						routerKey="region" routerValue="<%=regCode%>"  
						retcode="gqRc" retmsg="gqRm"  >
						<wtc:param value="<%=create_accept%>"/>
						<wtc:param value="01"/>
						<wtc:param value="e687"/>
						<wtc:param value="<%=workNo%>"/>
						<wtc:param value="<%=password%>"/>
						<wtc:param value="<%=phoneNo%>"/>
						<wtc:param value=""/>
					</wtc:service>
					<wtc:array id="resultBl" scope="end" />	
					<select id='groupId' name='groupId'>
					<%
					for ( int i=0;i<resultBl.length ; i++ )
					{
					%>
						<option value='<%=resultBl[i][0]%>'><%=resultBl[i][1]%></option>
					<%
					}
					%>
					</select>				
				</p>
				<p> &nbsp;&nbsp;ҵ��Ʒ��:
					<select class="b_text" name="smCode" id="smCode">
						<option value="$$$$$$">----��ѡ��----</option>
						<option value="gn" >gn-->ȫ��ͨ</option>
						<option value="dn" >dn-->���еش�</option>
						<option value="zn" >zn-->������</option>
					</select>
				</p>
				<p align="center">
					<input type="button" class="b_text" value="����" id="qryOfferBtn" 
						onclick = "getOffer()">
					<input type="button" class="b_text" value="���"
						onclick="clearInfo()" />
					&nbsp;&nbsp;&nbsp;
				</p>
			</div>
		</div>
	</div>

	<div class="item-col col-2" id="right">
		<span class="item-col2 col-1" id="leftSpan"
			style="overflow-y: auto; overflow-x: hidden; background-color: #F7F7F7; height: 415px; border-right: 1px solid #95CBDD; border-left: 1px solid #95CBDD; border-bottom: 1px solid #95CBDD;">
			<div class="title">
				<div id="title_zi">
					��ѡ����Ʒչʾ��
				</div>
				<span style="float: right; padding: 3px 1px 0px 2px;"><img
						src='/nresources/default/images/arrow_left.gif'
						style='cursor: hand' name='right' alt='����۵�����Ʒ������' id='LRImg'
						onClick="toLeft()">
				</span>
			</div>
			<div>
				<div id="offerListDiv">
				</div>
			</div> 
		</span>

		<span class="item-col3 col-2" id="rightSpan"> 
			<div class="title" id="addedOfferTitDiv">
				<div id="title_zi" style="cursor: hand;">
					��������������
				</div>
			</div>
			<div id="addedOfferDiv" class="list"
				style="overflow-x: auto; overflow-y: auto; height: 199px; width: 99%; border-width: 1px; border-color: #add3d0; border-style: solid; background-color: #F7F7F7;">
				<table id="addedOfferTab">
					<tr>
						<td colspan='6' class="blue">
							<b><����Ʒ>
							</b>
						</td>
					</tr>
					<tr id="addedOfferHeadTr">
						<td class="blue">״̬</td>
						<td class="blue">����</td>
						<td class="blue">����</td>
						<td class="blue">��Чʱ��</td>
						<td class="blue">ʧЧʱ��</td>
						<td class="blue">����</td>
					</tr>
				</table>
				<table id="addedProdTab">
					<tr>
						<td colspan='6' class="blue">
							<b><��Ʒ>
							</b>
						</td>
					</tr>
					<tr id="addedProdHeadTr">
						<td class="blue">
							״̬
						</td>
						<td class="blue">
							����
						</td>
						<td class="blue">
							����
						</td>
						<td class="blue">
							��Чʱ��
						</td>
						<td class="blue">
							ʧЧʱ��
						</td>
					</tr>
				</table>
			</div> 
			<div class="title" id="offerUnbookTitDiv">
				<div id="title_zi" style="cursor: hand;">
					���������˶���
				</div>
			</div>
			<div class="list" id="offerUnbookDiv"
				style="overflow-y: auto; overflow-x: auto; height: 160px; width: 99%; border-width: 1px; border-color: #add3d0; border-style: solid; background-color: #F7F7F7;">
				<div>
				<table id="offerUnbookTab">
					<tr>
						<td colspan='5' class="blue">
							<b><����Ʒ>
							</b>
						</td>
					</tr>
					<tr>
						<td class="blue">״̬</td>
						<td class="blue">
							����
						</td>
						<td class="blue">
							����
						</td>
						<td class="blue">
							��Чʱ��
						</td>
						<td class="blue">
							ʧЧʱ��
						</td>
					</tr>
				</table>

				<table id="prodUnbookTab">
					<tr>
						<td colspan='5' class="blue">
							<b><��Ʒ>
							</b>
						</td>
					</tr>
					<tr>
						<td class="blue">
							����
						</td>
						<td class="blue">
							����
						</td>
						<td class="blue">
							��Чʱ��
						</td>
						<td class="blue">
							ʧЧʱ��
						</td>
						<td class="blue">����</td>
					</tr>
				</table>
			</div>
			</div>
		
		</span>
	</div>
</div>
<!--end items-->
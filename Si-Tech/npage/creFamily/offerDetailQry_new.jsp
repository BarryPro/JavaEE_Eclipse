<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
System.out.println("--------------------------------offerDetailQry_new.jsp--------------------------------------");
System.out.println("----------------------------------------------------------------------");
	String offerId = WtcUtil.repNull(request.getParameter("offerId"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	
	String workNo = (String)session.getAttribute("workNo");
	String groupId = (String)session.getAttribute("groupId");
	String goodNo = WtcUtil.repNull(request.getParameter("goodNo"));
	String regionCode = (String)session.getAttribute("regCode");
	System.out.println("---------------------------------goodNo-------------------------------------"+goodNo);
	String offp_s = "";
	String offBandFlag = "";
	String offBandId = "";
	String off_month="";
	if(goodNo!=null&&(!"".equals(goodNo))){
	%>
	
	  <wtc:service name="sGoodNoCheck" outnum="16" retmsg="retMsg" retcode="retCode" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=goodNo%>" />
			<wtc:param value="<%=workNo%>" />
		</wtc:service>
		<wtc:array id="rows" scope="end" />
	
	<%
		 if(retCode.equals("000000")&&rows.length>0)
		{
		    offBandFlag = rows[0][4];
		    offBandId = rows[0][5];
				offp_s = rows[0][6];
				off_month = rows[0][15];
		}
	System.out.println("------------------offp_s---------------------"+offp_s);
	System.out.println("------------------offBandId------------------"+offBandId);
	System.out.println("------------------offBandFlag----------------"+offBandFlag);
	System.out.println("------------------off_month------------------"+off_month);
	}
	String currentTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date()); //当前时间
	
	String errCode = "";
	String errMsg = "";
	int valid = 1;	//0:正确，1：系统错误，2：业务错误
	int recordNum = 0; //查询结果记录数量
	
	StringBuffer sb = new StringBuffer(80);
	
	UType sendInfo = new UType();
	
	sendInfo.setUe("LONG", offerId);
	sendInfo.setUe("STRING", workNo);
	sendInfo.setUe("LONG", groupId);
	sendInfo.setUe("STRING", opCode);
	
	System.out.println("-----------------opCode---------------"+opCode);
%>

<%String regionCode_sPMGOfferDet = (String)session.getAttribute("regCode");%>
<wtc:utype name="sPMGOfferDet" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode_sPMGOfferDet%>">
	<wtc:uparam value="<%=sendInfo%>" type="UTYPE"/>   
</wtc:utype>

<%
	errCode = String.valueOf(retVal.getValue(0));
	System.out.println("# return by sPMGOfferDet -> errCode = "+errCode); 
	if(!errCode.equals("0")){
		valid = 1;
		errMsg = retVal.getValue(1);
	}
	else{
		recordNum = retVal.getUtype("2").getSize();
		if(recordNum == 0)
		{
			valid = 2;
      errMsg = "没有查询到相关信息!";
		}
		else
		{
			valid = 0;
		}
	}	
%>

<%
if( valid == 0 )
{ 
	if(retVal.getUtype(2).getSize() > 1){
		for(int i=0;i<retVal.getUtype("2.1").getSize();i++)
		{
			UType roleUtype = retVal.getUtype("2.1."+i);	//取第一层的角色
			String roleId = roleUtype.getValue(0);
			String roleName  =roleUtype.getValue(1);
			String type = "role";		
			String parentId = "";
		  String maxNum =  roleUtype.getValue(2);
		  String minNum =  roleUtype.getValue(3);
			sb.append("role"+roleId+"= new roleClass('"+roleId+"');");
			sb.append("role"+roleId+".setId('"+roleId+"');");
			sb.append("role"+roleId+".setName('"+roleName+"');");
			sb.append("role"+roleId+".setType('"+type+"');");
			sb.append("role"+roleId+".setParentId('"+parentId+"');");
			sb.append("role"+roleId+".setMaxNum('"+maxNum+"');");
			sb.append("role"+roleId+".setMinNum('"+minNum+"');");
			sb.append("nodesHash['"+roleId+"']=role"+roleId+";");
			
			sb.append("baseClass.addNode(role"+roleId+");");
			for(int j=0;j<roleUtype.getUtype("4").getSize();j++){
				UType offerUtype = roleUtype.getUtype("4."+j);	//取角色下的销售品层
				sb.append("offer"+offerUtype.getValue(1)+" = new offerClass('");
				sb.append(offerUtype.getValue(0)+"','");
				sb.append(offerUtype.getValue(3)+"','");
				sb.append(offerUtype.getValue(5)+"','");
				sb.append(offerUtype.getValue(9)+"','");
				sb.append(offerUtype.getValue(14)+"','");
				sb.append(offerUtype.getValue(15)+"','");
				sb.append(offerUtype.getValue(16)+"','");
				sb.append(offerUtype.getValue(10)+"','"); //生效时间
				sb.append(offerUtype.getValue(11)+"','"); //失效时间
				sb.append(offerUtype.getValue(12)+"','");	//失效时间偏移量
				sb.append(offerUtype.getValue(13)+"','");	//失效时间偏移单位
				sb.append(offerUtype.getValue(17)+"','");
				sb.append(offerUtype.getValue(18)+"');");	//
				sb.append("offer"+offerUtype.getValue(1)+".setId('"+offerUtype.getValue(1)+"');");
				sb.append("offer"+offerUtype.getValue(1)+".setName('"+offerUtype.getValue(4)+"');");
				sb.append("offer"+offerUtype.getValue(1)+".setType('"+offerUtype.getValue(2)+"');");
				sb.append("offer"+offerUtype.getValue(1)+".setParentId('"+roleId+"');");
				sb.append("offer"+offerUtype.getValue(1)+".setSelFlag('"+offerUtype.getValue(8)+"');");
				sb.append("offer"+offerUtype.getValue(1)+".setMaxNum('"+offerUtype.getValue(6)+"');");
				sb.append("offer"+offerUtype.getValue(1)+".setMinNum('"+offerUtype.getValue(7)+"');");
				sb.append("nodesHash['"+offerUtype.getValue(1)+"']=offer"+offerUtype.getValue(1)+";");
				sb.append("role"+roleId+".addNode(offer"+offerUtype.getValue(1)+");");
					if(offerUtype.getSize() > 19&&offerUtype.getUtype(19)!=null){
						for(int k=0;k<offerUtype.getUtype(19).getSize();k++){
							UType subRoleUtype = offerUtype.getUtype(19).getUtype(k);
							if(subRoleUtype.getSize()>0)//角色
							{
							   		String subRoleId = subRoleUtype.getValue(0);
										String subRoleName  = subRoleUtype.getValue(1);
										System.out.println("#######"+subRoleName);
										String subRoleType = "role";
										String subRoleParentId = offerUtype.getValue(1);
									  String subRoleMaxNum =  subRoleUtype.getValue(2);
									  String subRoleMinNum =  subRoleUtype.getValue(3);
										sb.append("role"+subRoleId+"= new roleClass('"+subRoleId+"');");
										sb.append("role"+subRoleId+".setId('"+subRoleId+"');");
										sb.append("role"+subRoleId+".setName('"+subRoleName+"');");
										sb.append("role"+subRoleId+".setType('"+subRoleType+"');");
										sb.append("role"+subRoleId+".setParentId('"+subRoleParentId+"');");
										sb.append("role"+subRoleId+".setMaxNum('"+subRoleMaxNum+"');");
										sb.append("role"+subRoleId+".setMinNum('"+subRoleMinNum+"');");
										sb.append("nodesHash['"+subRoleId+"']=role"+subRoleId+";");
										
										sb.append("offer"+offerUtype.getValue(1)+".addNode(role"+subRoleId+");");
									  for(int l=0;l<subRoleUtype.getUtype(4).getSize();l++){
									  UType prodcutUtype = subRoleUtype.getUtype(4).getUtype(l);
									  String offerProdId = offerUtype.getValue(1)+"A"+prodcutUtype.getValue(1);
											sb.append("product"+offerProdId+" = new productClass('");
											sb.append(prodcutUtype.getValue(0)+"','");
											sb.append(prodcutUtype.getValue(5)+"','");
											sb.append(prodcutUtype.getValue(9)+"','");
											sb.append(prodcutUtype.getValue(10)+"','");
											sb.append(prodcutUtype.getValue(11)+"','");
											sb.append(prodcutUtype.getValue(12)+"');");
											sb.append("product"+offerProdId+".setId('"+offerProdId+"');");
											sb.append("product"+offerProdId+".setName('"+prodcutUtype.getValue(4)+"');");
											sb.append("product"+offerProdId+".setType('"+prodcutUtype.getValue(2)+"');");
											sb.append("product"+offerProdId+".setParentId('"+subRoleId+"');");
											sb.append("product"+offerProdId+".setSelFlag('"+prodcutUtype.getValue(8)+"');");
											sb.append("product"+offerProdId+".setMaxNum('"+prodcutUtype.getValue(6)+"');");
											sb.append("product"+offerProdId+".setMinNum('"+prodcutUtype.getValue(7)+"');");
											sb.append("nodesHash['"+offerProdId+"']=product"+offerProdId+";");		                                      
									    sb.append("role"+subRoleId+".addNode(product"+offerProdId+");");
									  }  
							}
						}	
				}	
			}
			
		}
   }
}
//System.out.println("# sb.toString() = "+sb.toString()); 
%>
<script>
	 var offerClass = function(parentOffer,offerCode,description,prodExistFlag,attrFlag,groupFlag,priceFlag,begTime,expireTime,expDateOffset,expDateOffsetUnit,groupTypeId,expType)
	{ 
	   prodBaseClass.call(this);
	   this.parentOffer = parentOffer;
	   this.offerCode = offerCode;
	   this.description = description;
	   this.attrFlag = attrFlag;
	   this.groupFlag = groupFlag;
	   this.priceFlag = priceFlag;
	   this.prodExistFlag = prodExistFlag;
	   this.begTime = begTime;
	   this.expireTime = expireTime;
	   this.expDateOffset = expDateOffset;
	   this.expDateOffsetUnit = expDateOffsetUnit;
	   this.groupTypeId = groupTypeId;
	   this.expType = expType;
	}

	var roleClass = function()
	{ 
    prodBaseClass.call(this);
	}

  var productClass = function(parentOffer,description,prodExistFlag,begTime,expireTime,attrFlag)
	{ 
	  
	   prodBaseClass.call(this);
	   this.parentOffer = parentOffer;
	   this.description = description;
	   this.prodExistFlag = prodExistFlag;
	   this.begTime = begTime;
	   this.expireTime = expireTime;
	   this.attrFlag = attrFlag;
	}
	
	
  offerClass.prototype = new prodBaseClass();
	roleClass.prototype = new prodBaseClass();
	productClass.prototype = new prodBaseClass();
	     
var baseClass = new prodBaseClass();

<%=sb.toString()%>

/**************
 * add by qidp @ 2009-08-17 for 增加附加销售品限制 
 * 如果构成中不存在绑定附加资费则提示“基本资费中构成中不存在绑定附加资费”，然后关闭新装页面 . 
 **************/
/* 2009-09-14 HLJ
var offFlag = false;
function checkInfo(node){
    <% if("1".equals(offBandFlag)){ %> // 是否绑定附加销售品标识：0为不绑定 ; 1为绑定 .
        if(node.getId()=="<%=offBandId%>"){
            offFlag = true;
        }
                
        for(var i=0;i<node.item.length;i++)
        {
         checkInfo(node.item[i]);
        }	
    <% }else{ %>
        offFlag = true;
    <% } %>
    
}
*/
/* end by qidp @ 2009-08-17 for 增加附加销售品限制 */
var offerRoleID = "";
 

//初始化页面时，如果已经订购则展示出来 modify by liubo 加入flag


function showInfo(node){
 
	if(node.getType() == "role"){
		showRole(node);
	}
	if(node.getType() == offerType){
		showOffer(node);
	}
	if(node.getType() == prodType || node.getType() == majorProdType){	//产品,主产品
		showProd(node);
	}
	
	for(var i=0;i<node.item.length;i++)
  {
	 showInfo(node.item[i]);
  }	
}

	
function showRole(node){
		if(node.getParentId() == ""){ //第一层角色,父节点为空
			if($("#roles_"+offerId).length == 0){
				$("#offer_"+offerId).after("<div id='roles_"+offerId+"'></div>");
			}	
			
			$("#roles_"+offerId).append("<span><input type='checkbox' name='chkbox_"+node.getId()+"' id='"+node.getId()+"'    h_offerName='"+node.getName()+"' class='cls_"+offerId+"' checked>"+node.getName()+"</span>"); //展示角色层
			$("#roles_"+offerId).after("<div id='div_"+node.getId()+"'  class='list'></div>");		//生成角色所属DIV
			$("#div_"+node.getId()).append("<div class='title'><div id='title_zi'>"+node.getName()+"</div></div>");	//生成角色title
			$("#div_"+node.getId()).append("<table  cellSpacing=0 id='tab_"+node.getId()+"'><tr><th width=30%>销售品名称</th><th width=15% style='display:none'>生效方式</th><th width=15%>生效时间</th><th width=15%>失效时间</th><th width=25%>销售品描述</th></tr></table>");
		}
		else{
			if($("#roles_"+node.getParentId()).length == 0){
				$("#offer_"+node.getParentId()).after("<tr><td colspan='4'><div id='div_"+node.getParentId()+"' style='margin-left:30px;display:none'><div id='roles_"+node.getParentId()+"' ></div></div></td></tr>");	//生成子角色所属区域
			}
			$("#roles_"+node.getParentId()).append("<span><input type='checkbox'   h_offerName='"+node.getName()+"' name='chkbox_"+node.getId()+"' id='"+node.getId()+"'   class='cls_"+node.getParentId()+"'>"+node.getName()+"</span>");		//展示子角色层
			$("#roles_"+node.getParentId()).after("<div id='div_"+node.getId()+"'></div>");
		}
}

function showOffer(node){
	  if(node.getName()=="<%=offp_s%>"){
			$("#tab_"+node.getParentId()).append("<tr id='offer_"+node.getId()+"'><td width=30% id='offer_td_"+node.getId()+"'><input  type='checkbox'  h_offerName='"+node.getName()+"'  h_groupId='"+node.groupTypeId+"' name='offer_"+node.getId()+"' id='"+node.getId()+"' class='cls_"+node.getParentId()+"'  checked disabled />"+node.getName()+"</td><td width=15% style='display:none'><select id='effType_"+node.getId()+"' disabled ><option value='0'>立即生效</option><option value='1'>下月生效</option></select></td><td width=15% id='effTime_"+node.getId()+"' name='"+node.begTime+"' >"+node.begTime.substring(0,8)+"</td><td width=15% id='expTime_"+node.getId()+"' name='"+node.expireTime+"' >"+node.expireTime+"</td><td width=25%><span title='"+node.description+"' class='text_long'>"+node.description+"</span></td></tr>");	
	  	}else{
	  $("#tab_"+node.getParentId()).append("<tr id='offer_"+node.getId()+"'><td width=30% id='offer_td_"+node.getId()+"'><input  type='checkbox'  h_offerName='"+node.getName()+"'  h_groupId='"+node.groupTypeId+"' name='offer_"+node.getId()+"' id='"+node.getId()+"' class='cls_"+node.getParentId()+"' />"+node.getName()+"</td><td width=15% style='display:none'><select id='effType_"+node.getId()+"' ><option value='0'>立即生效</option><option value='1'>下月生效</option></select></td><td width=15% id='effTime_"+node.getId()+"' name='"+node.begTime+"' >"+node.begTime.substring(0,8)+"</td><td width=15% id='expTime_"+node.getId()+"' name='"+node.expireTime+"' >"+node.expireTime.substring(0,8)+"</td><td width=25%><span title='"+node.description+"' class='text_long'>"+node.description+"</span></td></tr>");			
	  		}
		
		if(node.groupTypeId != 0){
			//$("#offer_"+node.getId()+" td:eq(0)").append("<input name='"+node.getName()+"' type='button' value='群组' id='group_"+node.getId()+"' _groupId='"+node.groupTypeId+"' class='b_text but_groups' />");
		}
		
		if(node.attrFlag == 1){
			$("#offer_"+node.getId()+" td:eq(0)").append("<input  type='button' name='offe_"+node.getName()+"' value='属性' id='att_"+node.getId()+"' class='b_text' />");
		}
		
		var arrClassValue = new Array();
        arrClassValue.push(node.getId());
        getMidPrompt("10442",arrClassValue,"offer_td_"+node.getId());
}

function showProd(node){
		$("#div_"+node.getParentId()).append("<span id='prod_"+node.getId()+"' style='margin-left:30px'><input type='checkbox'  h_offerName='"+node.getName()+"'  h_groupId='"+node.groupTypeId+"' name='prod_"+node.getId()+"' id='"+node.getId()+"' class='cls_"+node.getParentId()+"'>"+node.getName()+"</span>");
	if(node.attrFlag == 1){
		$("#prod_"+node.getId()).append("<input  type='button' name='prod_"+node.getName()+"' value='属性' id='att_"+node.getId()+"' class='but_property' />");
	}
}
function trea(blindAddComboVar){

}
//初始化销售品构成展示
function initInfo(node){
	var vId = node.getId();
	var vgroupFlag=node.groupFlag;
	

	if(typeof(vId) != "undefined"){
		var selFlag = node.getSelFlag();
		if(selFlag == "0"){	
			if(vgroupFlag!=0){
			   showGroup(vId,document.getElementById(vId).h_offerName,document.getElementById(vId).h_groupId);
		  }
			
			$("#"+vId).attr("checked",true);
			$("#"+vId).attr("disabled",true);
			$("#expOffset_"+vId).attr("disabled",false);	//将失效时间偏移量输入框置为可用
			$("#sel_"+vId).attr("disabled",false);
		}
		if(selFlag == "1"){
			$("#"+vId).attr("checked",true);
			$("#expOffset_"+vId).attr("disabled",false);	//将失效时间偏移量输入框置为可用
			$("#sel_"+vId).attr("disabled",false);
		}

		if($("#"+vId).attr("checked") == true && node.getType() == prodType){ //产品默认选中时
			$("#"+node.getParentId()).attr("checked",true);
			if(selFlag == "0"){
				$("#"+node.getParentId()).attr("disabled",true);
			}
		}
		
		if($("#"+vId).attr("checked") == true && node.getType() == offerType){	//选中时,将信息加入已选择附加销售品信息table
			$("#div_"+vId).css("display","");																			//销售品默认选中时,展示出下属的结构
			$("#tab_order").append("<tr id='orderTr_"+node.getId()+"'><td>"+node.getId()+"</td><td>"+node.getName()+"</td><td>"+node.begTime.substring(0,8)+"</td><td>"+node.expireTime.substring(0,8)+"</td><td>"+node.description+"</td></tr>");
		}
		
	}
	for(var i=0;i<node.item.length;i++)
  {
	 initInfo(node.item[i]);
  }	
}

</script>


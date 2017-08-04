<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
    Calendar today =   Calendar.getInstance();  
    today.add(Calendar.MONTH,3);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
    String addThreeMonth = sdf.format(today.getTime());
    System.out.println("### addThreeMonth = "+addThreeMonth);
    
  String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String currTime = new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new Date());
	String current_time=new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date());
	String currentTime = new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date()); //当前时间
	Calendar calendar = Calendar.getInstance();
	String expTime=currentTime+"-"+calendar.getActualMaximum(Calendar.DAY_OF_MONTH)+" 23:59:59";
	String offerSrvId=WtcUtil.repNull(request.getParameter("offerSrvId"));
  System.out.println("=====客户id===="+offerSrvId);	
	String custOrderId=WtcUtil.repNull(request.getParameter("custOrderId"));
	String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));
	String servOrderId=WtcUtil.repNull(request.getParameter("servOrderId"));
  System.out.println("客户服务定单号="+servOrderId);	
  String regionCode =((String)session.getAttribute("orgCode")).substring(0,2);	
	String orderArrayId=WtcUtil.repNull(request.getParameter("orderArrayId"));
	String closeId=WtcUtil.repNull(request.getParameter("closeId"));
	String servBusiId=WtcUtil.repNull(request.getParameter("servBusiId"));
	String prtFlag=WtcUtil.repNull(request.getParameter("prtFlag"));
	String workNo=(String)session.getAttribute("workNo");
	String cust_id=WtcUtil.repNull(request.getParameter("gCustId"));
	String gCustId=WtcUtil.repNull(request.getParameter("gCustId"));
	String groupId=(String)session.getAttribute("groupId");//区域标识
	    //String siteId =(String)session.getAttribute("siteId");//新区域标识
	String siteId =(String)session.getAttribute("groupId");//新区域标识
	String phone_no= WtcUtil.repNull(request.getParameter("phoneNo"));
	/* liujian add workNo and password 2012-4-5 15:59:15 begin */
	String password = (String) session.getAttribute("password");
	String op_code=WtcUtil.repNull(request.getParameter("opCode"));
	/* liujian add workNo and password 2012-4-5 15:59:15 end */
	String   sqlStrTempV1 = "select c.band_name from product_offer_instance a,product_offer b , band c where  a.offer_id = b.offer_id  and    b.band_id = c.band_id and    b.offer_type = 10 and    sysdate between a.eff_date and a.exp_date and    serv_id = "+offerSrvId;
	System.out.println("sqlStrTempV1|||"+sqlStrTempV1);
	String custPPv1 = "";
%>
	<wtc:utype name="sPMQryUserInfo" id="retUserInfo" scope="end">
     <wtc:uparam value="0" type="LONG"/>
     <wtc:uparam value="<%=phone_no%>" type="STRING"/>
     <wtc:uparam value="<%=workNo%>" type="string"/>
     <wtc:uparam value="<%=password%>" type="string"/>	
     <wtc:uparam value="<%=op_code%>" type="string"/>	
    </wtc:utype>
    
		<wtc:pubselect name="sPubSelect" outnum="1">
			<wtc:sql>select nvl(b.service_no,a.phone_no) from dcustmsg a,daccountidinfo b where a.id_no='<%=offerSrvId%>' and a.phone_no=b.msisdn(+)</wtc:sql>
		</wtc:pubselect>	
		<wtc:array id="row" scope="end" />
			
			
		<wtc:pubselect name="sPubSelect" outnum="1">
			<wtc:sql><%=sqlStrTempV1%></wtc:sql>
		</wtc:pubselect>	
		<wtc:array id="result_y1" scope="end" />	
<%		

if(result_y1.length>0&&result_y1[0][0]!=null){
custPPv1 = result_y1[0][0];
}
	phone_no=row[0][0];	
	%>
		<wtc:pubselect name="sPubSelect" outnum="1">
			<wtc:sql>select  decode(substr(attr_code, 5, 1),'0','0','1','1','2','2','3','3','0')  from  dCustMsg where  phone_no = '<%=phone_no%>' and substr(run_code, 2, 1) < 'a' </wtc:sql>
		</wtc:pubselect>	
		<wtc:array id="row1" scope="end" />	
		
		<wtc:pubselect name="sPubSelect" outnum="1">
			<wtc:sql>select  nvl(grp_name,'NULL')  from  sGrpBigFlag  where  grp_flag='<%=row1[0][0]%>' </wtc:sql>
		</wtc:pubselect>	
		<wtc:array id="row2" scope="end" />	
	<%
	String servId  = WtcUtil.repNull(request.getParameter("offerSrvId"));
	String proName="";
	String proEff="";
	String proExi="";
	String prodCompFlag="";
	String offerId =WtcUtil.repNull(request.getParameter("offerId"));
	String opCode=WtcUtil.repNull(request.getParameter("opCode"));
	String opName="产品变更"; 
	int num2=0;
	String Band_Id="";
	String custName="";
	String idIccid="";
	String custLevel="";
	String addr="";
	String Product_id="";
	String[] oldAttr=null;
	String offerMainInst="";
	String offerDis="";
	System.out.println("offerId================="+offerId);
%>
<wtc:utype name="sInstance" id="mainInst" scope="end">
	<wtc:uparam value="<%=servId%>" type="long" />
	<wtc:uparam value="<%=offerId%>" type="long" />		
</wtc:utype>	
<%
	String retCode2=mainInst.getValue(0);
	String retMsg2=mainInst.getValue(1);
	
	if(retCode2.equals("0"))
	{
	  if(mainInst.getUtype(2).getSize()>0)
	  {
			if(mainInst.getUtype("2.0").getSize()>0)
			{
				offerMainInst=mainInst.getValue("2.0.0");
			}else
			{
%>		
<script>
			rdShowMessageDialog("查询主销售品实例Id错误");
			window.parent.removeTab("<%=closeId%>");
</script>			
<%
			}	
		}else
		{
%>		
<script>
			rdShowMessageDialog("查询主销售品实例Id错误");
			window.parent.removeTab("<%=closeId%>");
</script>			
<%
		}		
	}
System.out.println("主销售品实例ID===="+offerMainInst);	

String sm_code = "";
String sqll = "select sm_code from product_offer a, band b where a.band_id = b.band_id and a.offer_id = '"+offerId+"'";
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="sPubSelectCode" retmsg="sPubSelectMsg"  outnum="1">
	<wtc:sql><%=sqll%></wtc:sql>
</wtc:pubselect>
<wtc:array id="sPubSelectArr" scope="end" />
<%
    if("000000".equals(sPubSelectCode) && sPubSelectArr.length>0){
        sm_code = sPubSelectArr[0][0];
        System.out.println("# sm_code = "+sm_code);
    }else{
    %>
        <script>
            rdShowMessageDialog("查询smCode出错！",0);
        </script>
    <%
        System.out.println("# return from changeProduce.jsp -> 查询smCode出错！");
    }
%>
<wtc:utype name="sGetUsrMain" id="mainProd" scope="end">
	<wtc:uparam value="<%=offerSrvId%>" type="long"/>   
</wtc:utype>
<%

System.out.println("-------------1-----new Date()-----------------"+new Date());
	StringBuffer logBuffer9 = new StringBuffer(80);
	WtcUtil.recursivePrint(mainProd,1,"2",logBuffer9);
//	System.out.println(logBuffer9.toString());
	String retCode9=mainProd.getValue(0);
	String retMsg9=mainProd.getValue(1);
	if(retCode9.equals("0"))
	{
//System.out.println("size====="+mainProd.getUtype("2").getSize());	
		Product_id=mainProd.getValue("2.0");
		proEff=mainProd.getValue("2.1");
		proExi=mainProd.getValue("2.2");
		prodCompFlag=mainProd.getValue("2.3");
		proName=mainProd.getValue("2.4");
		
		//System.out.println("----------------------------proEff-------------######################------"+proEff);
	}
	//System.out.println("----------------------------proEff-------------######################------"+proEff);
//System.out.println("主产品ID===="+Product_id);	
%>
<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql>select band_id from product_offer where offer_id='<%=offerId%>'</wtc:sql>
</wtc:pubselect>	
<wtc:array id="rows" scope="end" />
<%

System.out.println("-------------2-----new Date()-----------------"+new Date());
	if(retCode.equals("000000"))
	{
		Band_Id=rows[0][0];
	}

%>
<wtc:sequence name="sPubSelect"  key="sMaxSysAccept" id="loginAccept"/>
	
<%
System.out.println("-------------3-----new Date()-----------------"+new Date());
%>	
<wtc:utype name="sGetCustOrdMsg" id="retCustVal" scope="end">
		<wtc:uparam value="<%=cust_id%>" type="long" />
		<wtc:uparam value="<%=workNo%>" type="string"/>
		<wtc:uparam value="<%=groupId%>" type="string"/>	
</wtc:utype>
<%

System.out.println("-------------4-----new Date()-----------------"+new Date());
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retCustVal,1,"2",logBuffer);
	//System.out.println(logBuffer.toString());
	String retCode0=retCustVal.getValue(0);
	String retMsg0=retCustVal.getValue(1);
	if(retCode0.equals("0"))
	{
		UType userOrdInfo=(UType)retCustVal.getUtype(2);
		custName=userOrdInfo.getValue(1);
		idIccid=userOrdInfo.getValue(2);
		custLevel=userOrdInfo.getValue(5);
		addr=userOrdInfo.getValue(4);
		for(int i=0;i<retCustVal.getUtype("2.6").getSize();i++)
		{
			if(retCustVal.getValue("2.6."+i+".0").equals(offerSrvId))
			{
				offerDis=retCustVal.getValue("2.6."+i+".9");//基本销售品描述
			}
		}
%>
<%
}else
{
%>
<script>
	rdShowMessageDialog("查询用户信息出错,"+"<%=retCode0%>"+"<%=retMsg0%>");
</script>
<%
}
%>	
<wtc:utype name="sQProdIntAtr" id="retVal1" scope="end" >
	<wtc:uparam value="1" type="int" />
	<wtc:uparam value="<%=servId%>" type="long" />	
</wtc:utype>
<%
System.out.println("-------------5-----new Date()-----------------"+new Date());
  	StringBuffer logBuffer2 = new StringBuffer(80);
		//System.out.println(logBuffer2.toString());  
		WtcUtil.recursivePrint(retVal1,1,"2",logBuffer2);
		String retCode1 = retVal1.getValue(0);
		if(retCode1.equals("0"))
		{
//System.out.println("====属性组的数量==="+retVal1.getUtype(2).getSize());	
		oldAttr=new String[retVal1.getUtype(2).getSize()];
  	for(int i=0;i<retVal1.getUtype(2).getSize();i++)
  	{
  				if(retVal1.getValue("2."+i+".4").equals(""))
  				{
  					oldAttr[i]=retVal1.getValue("2."+i+".3")+"~M^";
  				}else
  				{
  					oldAttr[i]=retVal1.getValue("2."+i+".3")+"~"+retVal1.getValue("2."+i+".4");
  				}	
  	}
  	}	
 System.out.println("-------------6-----new Date()-----------------"+new Date()); 	
%>		
	 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
	<%
	 System.out.println("-------------7-----new Date()-----------------"+new Date()); 	
	%> 	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=opName%></title>
<!-- <link href="<%=request.getContextPath()%>/nresources/default/css_sx/FormText.css" rel="stylesheet"type="text/css"> -->
<link href="<%=request.getContextPath()%>/nresources/default/css/products.css" rel="stylesheet"type="text/css">
</head>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/autocomplete_ms.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/product.js"></script>
<script type="text/javascript">
var offerId ="<%=offerId%>";
var offerNodes;
var trNum=0;
var nodesHash = new Object(); 


$(document).ready(function () {
	$("#complex_pro").append("<div id='complex_"+offerId+"'></div>"); 
	$("#complex_"+offerId).after("<div id='complex_pro_"+offerId+"' ></div>");
	$("#pro_component").append("<div id='prod_"+offerId+"'></div>"); 
	$("#prod_"+offerId).after("<div id='pro_"+offerId+"' ></div>");
	$("#pro_"+offerId).append("<table id='tab_pro' cellspacing=0></table>");
	$("#tab_pro").append("<tr><th>产品名称</th><th>开始时间</th><th>结束时间</th><th>状态</th><th>操作</th></tr>");
	    var packet = new AJAXPacket("GetProdAttr2.jsp","请稍后...");
			packet.data.add("servId" ,"<%=servId%>"); 	
			packet.data.add("flag" ,"1");	
			packet.data.add("ProdId" ,"<%=Product_id%>");
			packet.data.add("isNew" ,"0");
			core.ajax.sendPacketHtml(packet,doGetAttrHtml);
			packet =null;
			loading("正在加载产品信息，请稍候······");
			var packet = new AJAXPacket("complexPro.jsp","请稍后...");//组合产品子产品展示
			packet.data.add("servId" ,"<%=servId%>");
			packet.data.add("offerId" ,"<%=offerId%>"); 		
			packet.data.add("opCode" ,"<%=opCode%>");
			packet.data.add("com_pro_id" ,"<%=Product_id%>"); 	
			packet.data.add("com_pro_intId" ,"<%=offerSrvId%>");
			core.ajax.sendPacketHtml(packet,doGetHtml2,true);
			packet =null;
  })

function doGetAttrHtml(data)
{
	$("#attrlist").html(data);
	$("#attrlist :input").not(":button").each(chkDyAttribute);
}  
  
function doGetHtml(data)
{
	$("#offer_component").html(data);
	offerNodes = baseClass;
	showInfo(offerNodes);		//生成销售品构成展示
	initInfo(offerNodes);		//初始化构成,必选 可选 默认选中
	$("#div_offerComponent :checkbox").bind("click",fn);		
	var majorProductId = "";
	if(majorProductArr.length > 0){
	 	majorProductId = majorProductArr[1];
	}
	else{
		rdShowMessageDialog("无主产品信息!");
		return false;	
	}
	if(majorProductArr[9]=="1")
	{
			var packet = new AJAXPacket("complexPro.jsp","请稍后...");//组合产品子产品展示
			packet.data.add("servId" ,"<%=servId%>");
			packet.data.add("com_pro_id" ,majorProductId); 	
			packet.data.add("com_pro_intId" ,majorProductArr[13]);
			core.ajax.sendPacketHtml(packet,doGetHtml2,true);
			packet =null;
	}else
	{	
			var packet2 = new AJAXPacket("getOfferRel2.jsp","请稍后...");
			packet2.data.add("offerId" ,offerId);
			packet2.data.add("maxNum" ,majorProductArr[6]);
			core.ajax.sendPacketHtml(packet2,getOfferRel,true);
			packet2 =null;
	}
}
function doGetHtml2(data)
{
	$("#complex_component").html(data);
	offerNodes2 = baseClass2;
	showInfo2(offerNodes2);		//生成销售品构成展示
	initInfo2(offerNodes2);		//初始化构成,必选 可选 默认选中
	for(var i=0;i<offerNodes2.item.length;i++)
	{
		//if(offerNodes2.item[i].statu=="已订购")
		//{
			if(offerNodes2.item[i].getType() == "M"||offerNodes2.item[i].getType() == "O"){
				 getMidPrompt("10431",offerNodes2.item[i].getId(),"p_"+offerNodes2.item[i].getId(),"<%=sm_code%>");
			}
		//}
	}	
	 $("#complex_pro :checkbox").bind("click",fn2);
	var packet2 = new AJAXPacket("getOfferRel2.jsp","请稍后...");
			packet2.data.add("offerId" ,offerId);
			packet2.data.add("maxNum" ,"");
			packet2.data.add("opCode" ,"<%=opCode%>");
			packet2.data.add("phoneNo" ,"<%=phone_no%>");
			core.ajax.sendPacketHtml(packet2,getOfferRel,true);
			packet2 =null;
	loading();
}
function getOfferRel(data)
{
	//$("#offer_component").html(data);
	$("#complex_component").html(data);
	unLoading();
}
function fn(){
	try{ 	
		var vId = "div_"+this.id;
		checkRel(this);
		
		if(this.checked == true){
			$("#"+vId).css("display","");
		}
		else{
			$("#"+vId).css("display","none");	
			nodesHash[this.id].cancelChecked(nodesHash[this.id]);
		}
	}catch(E){
		 	  rdShowMessageDialog("正在加载销售品构成,请稍候....");
		 	  return false;
	}	
}
function fn2(){
    var oid = this.id;
    var obj = this;
	try{
		var vId = "div_"+this.id;
		checkRel2(this);
		
		if(this.checked == true){
			$("#"+vId).css("display","");
			
			var arrClassValue = new Array();
            arrClassValue.push(this.id);
		}
		else{
			$("#"+vId).css("display","none");	
			nodesHash[this.id].cancelChecked(nodesHash[this.id]);
		}
	}catch(E){
		 	  rdShowMessageDialog("正在加载销售品构成,请稍候....");
		 	  if(obj.checked == true){
		 	    nodesHash[oid].cancelChecked(nodesHash[oid]);
		 	    $("#pro_detail_"+oid).remove();
		 	  }else{
		 	    
		 	  }
		 	  return false;
	}
}
function checkRel2(obj)
{   
	var retCo="";
	var retMs="";
  var _id = obj.id;
  if(itemHash != null){
  	var items = itemHash[_id];
  }	
  /*if(!chkDependens2(obj))
	{
		return false;
	}*/
	

	if(obj.checked==false){
		  var dependItems=new Object();
	  	if(dependHash != null){
		  	 dependItems= dependHash[_id];
		  }
		  if(typeof(dependItems) != "undefined"){
		  	/*$("#div_offerComponent :checked").each(function(){
			     if(dependItems.hasElement(this.id))
			     {
			     	 $("#"+this.id).attr('checked','');
			     	 chgDetailProd(_id);//联动取消右边产品那条记录
			     	 $("#div_"+this.id).css("display","none");	
			     	 nodesHash[this.id].cancelChecked(nodesHash[this.id]);
			     }
				});*/
					$("#complex_pro :checked").each(function(){
			     if(dependItems.hasElement(this.id))
			     {
			     	 $("#"+this.id).attr('checked','');
			     	 chgDetailProd2(_id);//联动取消右边产品那条记录
			     	 chgDetailProd2(this.id);//联动取消右边产品那条记录
			     	 $("#div_"+this.id).css("display","none");	
			     	 nodesHash[this.id].cancelChecked(nodesHash[this.id]);
			     }
				});
		  }
		  
		  /*add by qidp @ 2009-07-21 for 销售品限制*/
        	if(nodesHash[_id].statu=="已订购")
           	{		 
        		 var retArr=chkLimit(_id,"0").split("@");
        	     retCo=retArr[0].trim();
        	     retMg=retArr[1];
        	     if(retCo!="0")
        	     {
        	     	   rdShowMessageDialog(retMg);
        	     	   $("#"+_id).attr('checked','checked');
        	     	   chgDetailProd2(_id);//联动取消右边产品那条记录
        	     	   return false;
        	     }
        	}
        /*end by qidp*/
	  }

		if(obj.checked==true)
		{
			if(typeof(items) != "undefined")
  		{
			/*$("#div_offerComponent :checkbox").each(function(){
			     if(items.raletionWith(this.id) == 1 && $("#"+this.id)[0].checked == true)
			     {
			     	 rdShowMessageDialog(nodesHash[_id].getName()+"与"+nodesHash[this.id].getName()+"互斥!");
			     	 $("#"+_id).attr('checked','');
			     	 chgDetailProd(_id);//联动取消右边产品那条记录
			     	 return false;
			     }
			     
			     if(items.raletionWith(this.id) == 0 && $("#"+this.id)[0].checked == false)
			     {
			     	 rdShowMessageDialog(nodesHash[_id].getName()+"依赖于"+nodesHash[this.id].getName()+",请选择"+nodesHash[this.id].getName()+"!");
			     	 $("#"+_id).attr('checked','');
			     	 chgDetailProd(_id);//联动取消右边产品那条记录
			     	 return false;
			     }
			});*/
			$("#complex_pro :checkbox").each(function(){
			     if(items.raletionWith(this.id) == 1 && $("#"+this.id)[0].checked == true)
			     {
			     	 rdShowMessageDialog(nodesHash[_id].getName()+"与"+nodesHash[this.id].getName()+"互斥!",0);
			     	 $("#"+_id).attr('checked','');
			     	 chgDetailProd2(_id);//联动取消右边产品那条记录
			     	 return false;
			     }
			     
			     if(items.raletionWith(this.id) == 0 && $("#"+this.id)[0].checked == false)
			     {
			     	 rdShowMessageDialog(nodesHash[_id].getName()+"依赖于"+nodesHash[this.id].getName()+",请选择"+nodesHash[this.id].getName()+"!",0);
			     	 $("#"+_id).attr('checked','');
			     	 chgDetailProd2(_id);//联动取消右边产品那条记录
			     	 return false;
			     }
			    
			});
	  }
	  
/*add by qidp @ 2009-07-21 for 销售品限制*/

	if(nodesHash[_id].statu=="未订购")
   	{		 
		 var retArr=chkLimit(_id,"1").split("@");
	     retCo=retArr[0].trim();
	     retMg=retArr[1];
	     if(retCo!="0")
	     {
	     	   rdShowMessageDialog(retMg);
	     	   $("#"+_id).attr('checked','');
	     	   chgDetailProd2(_id);//联动取消右边产品那条记录
	     	   return false;
	     }
	} 

/*end by qidp*/
/*add by yanpx @ 2009-07-21 for 销售品限制*/
/*
	   var retArr=chkLimit(_id).split("@");
			      retCo=retArr[0].trim();
			     retMg=retArr[1];
			     if(retCo!="0" && nodesHash[_id].statu=="未订购")
			     {
			     	   rdShowMessageDialog(retMg);
			     	   $("#"+_id).attr('checked','');
			     	   chgDetailProd2(_id);//联动取消右边产品那条记录
			     	   return false;
			     }
*/			     
/*end by yanpx*/			 
  }

}	
/*
function chkLimit(id)
{
	var retList="";
	var phoneNo="<%=offerSrvId%>";
	var opCode="<%=opCode%>";
	var senddata={};
	senddata["phoneNo"] = phoneNo;
	senddata["opCode"] = opCode;
	senddata["prodId"] = id;
	senddata["vQtype"] = "1";
	
		$.ajax({
		  url: 'limitChk.jsp',
		  type: 'POST',
		  data: senddata,
		  async: false,//同步
		  error: function(data){
				if(data.status=="404")
				{
				  alert( "文件不存在!");
				}
				else if (data.status=="500")
				{
				  alert("文件编译错误!");
				}
				else{
				  alert("系统错误!");  					
				}
		  },
		  success: function(data)
		  {		   
		          retList = data;
		  }
		});
		senddata = null;
		return  retList;
}
*/
/*add by qidp @ 2009-07-22 for 销售品限制*/
function chkLimit(id,iOprType)
{
	var retList="";
	var phoneNo="<%=offerSrvId%>";
	var opCode="<%=opCode%>";
	var senddata={};
	senddata["opCode"] = opCode;
	senddata["prodId"] = id;
	senddata["iOprType"] = iOprType;
	senddata["vQtype"] = "1";
	senddata["idNo"] = "<%=offerSrvId%>";
		$.ajax({
		  url: 'limitChk.jsp',
		  type: 'POST',
		  data: senddata,
		  async: false,//同步
		  error: function(data){
				if(data.status=="404")
				{
				  alert( "文件不存在!");
				}
				else if (data.status=="500")
				{
				  alert("文件编译错误!");
				}
				else{
				  alert("系统错误!");  					
				}
		  },
		  success: function(data)
		  {		   
		          retList = data;
		  }
		});
		senddata = null;
		return  retList;
}
/*end by qidp*/
	function queryInfo(obj){
		var tmpStr = document.all("query"+obj).v_sql.split("~"); //拆分sql语句和fieldName
		var sqlStr = tmpStr[0];
		var fieldName = tmpStr[1];
		if(sqlStr.indexOf("#")>-1){
			var chPos1 = sqlStr.indexOf("#");
			var chPos2;
			var chObj;
			var chStr;
			var tmp = "";
			while(chPos1>-1){
				chStr = sqlStr.substring(chPos1+1);
				chPos2 = chStr.indexOf("#");
				chObj = chStr.substring(0,chPos2);
				tmp = "#"+chObj+"#";
				sqlStr = sqlStr.replace(tmp,"'"+document.all(chObj).value+"'");
				chPos1 = sqlStr.indexOf("#");
			}
		}
		var pageTitle = document.all(obj).v_name+"查询";               	
		var selType = "S";    //'S'单选；'M'多选      
		var retQuence = "1|0";             
		var retToField = obj+"";
		PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
	}
</script>
<script language="javascript">
	function shutdown()
	{
		window.parent.removeTab("<%=closeId%>");
	}
	function next()
	{


document.all.sys_note.value = "用户<%=retUserInfo.getValue("2.0.2.1")%>特服变更";				
if(document.all.op_note.value =="")
document.all.op_note.value = "操作员<%=workNo%>对客户<%=retUserInfo.getValue("2.0.2.1")%>进行特服变更";		

	    getAfterPrompt();
		//if(!checksubmit(document.frm))return false;
		var mainProAttr="";
		var attrCode = [];				//群组属性ID
  	var attrValue = [];		//群组属性value
  	   $("#attrlist :input").each(function(){
			if(this.value != "")
			{
				attrCode.push(this.name.substring(2));
				attrValue.push(this.value);	
			}	
		});
		for(var i=0;i<attrCode.length;i++)
		{
			mainProAttr=mainProAttr+attrCode[i]+"~"+attrValue[i]+",";
		}
		$("input[name='mainProAttrCode']").val(mainProAttr);
		var tempAttr="";
		var sonParentArr = []; //存放子~父
		var prodEffectDate = []; //产品生效时间
		var prodExpireDate = []; //产品失效时间
		var isMainProduct = [];//是否主产品标识
		var productStatu=[];//产品目前订购状态
		var attrFlag=[];//复合产品标志
		var prodNameArr =new Array();//产品名称（打印用）
		var proOptFlag=new Array();//产品操作代码
		var offerIdArr = new Array();//销售品代码
		var pordIdArr = new Array();//产品代码
		var offerEffectTime = new Array();//销售品生效时间
		var offerExpireTime = new Array();//销售品失效时间
		var offerStatu=new Array();//销售品状态(无用)
		var proAttrOptFlag=new Array();//产品属性操作代码
		var newStatu=new Array();//产品提交后状态
		var proIntIdArr= new Array();//产品实例ID
		var offerIntIdArr=new Array();//销售品实例ID
		var parentInstId = new Array();//上级产品实例ID
		var sureGG="true";//确定前的控制标记，如果新购产品有属性而未进行设置，不让提交。
		var adslPrint="";//速率打印
		proOptFlag.push("0");//主产品不会更改，操作代码填充0
		proIntIdArr.push("<%=offerSrvId%>");//塞入基本产品实例ID
		$("input[name='majorProductId']").val("<%=Product_id%>");
		pordIdArr.push("<%=Product_id%>");//塞入基本产品代码
		prodNameArr.push("<%=proName%>");
		productStatu.push("已订购");//塞入基本产品目前状态
		newStatu.push("A");//塞入基本产品提交后状态
		prodEffectDate.push("<%=proEff%>");
		prodExpireDate.push("<%=proExi%>");
		isMainProduct.push(1);//塞入是否基本产品代码
		offerIntIdArr.push("<%=offerMainInst%>");//塞入基本销售品实例ID
		
			
<%
		if(oldAttr!=null)
		{
			System.out.println("======oldAttr.length======"+oldAttr.length);				
					for(int i=0;i<oldAttr.length;i++)
					{
						System.out.println("第"+i+"个属性："+oldAttr[i]);	
							String[] attTmp=oldAttr[i].split("~");			
							String attrid=attTmp[0];
							String attrval=attTmp[1];
							if(attrval.equals("M^"))
							{
								attrval="";
							}
%>
							$("#attrlist :input").each(function(){
							  if(this.name.substring(2)=="<%=attrid%>" && this.value!="<%=attrval%>")
							  {
							  	if(this.v_type=="5")
							  	{
							  		var temp=this.options[this.selectedIndex].text;
							  		adslPrint=adslPrint+this.v_name+"："+temp.substring(temp.indexOf(">")+1)+"^1|";
							  	}else
							  	{
							  		adslPrint=adslPrint+this.v_name+"："+this.value+"^1|";
							  	}	
							  	if(this.value==""||typeof(this.value)=="undefined"||this.value==null)
							  	{
							  		tempAttr=tempAttr+this.name.substring(2)+"~"+"M^,";
							  	}else
							  	{	
										tempAttr=tempAttr+this.name.substring(2)+"~"+this.value+",";
									}	
								}	
							});
							
<%							
					}	
		}		
%>		
		if(tempAttr=="")
		{
			if($("input[name='mainProAttrCode']").val()=="")//主产品属性没变且空的话定义一个值填充位置，解析的时候注意。
			{
				$("input[name='mainProAttrCode']").val("M");
			}	
			tempAttr="M";
			proAttrOptFlag.push("0");//塞入主产品属性操作代码
		}else
		{
			proAttrOptFlag.push("2");
		}	
		var prodAttrValueArr = tempAttr+"@";		
		attrFlag.push("<%=prodCompFlag%>");//塞入主产品复合产品标识
		parentInstId.push("0");//主产品的上级实例ID为0
		sonParentArr.push("<%=Product_id%>"+"~"+"<%=offerId%>");
		offerIdArr.push("<%=offerId%>");//主销售品代码
/*---------------------------------------------begin对主产品附加产品树的解析拼串过程begin------------------------------------------------*/				
				
				var vFlag = true;
$("#complex_pro :checkbox").each(function(){
				if($("#"+this.id)[0].checked == false && $("#proName_"+this.id).text()=="")//未定购的且这次没选中的，不做任何操作
				{
				}else
				{	
					if($("#"+this.id)[0].checked == true && $("#proName_"+this.id).text()=="新购" && nodesHash[this.id].haveAttr==1 && $("#att_"+this.id).attr("class")=="but_property")
					{
						rdShowMessageDialog("请设置"+nodesHash[this.id].getName()+"的属性");
						sureGG="false";
						return false;
					}
					/***************************begin  拼产品的操作代码(0 无变化,1 增加,2 修改,3 删除)*********************/		
							if($("#"+this.id)[0].checked == true && $("#proName_"+this.id).text()=="正常")
							{
								if(nodesHash[this.id].proStatu=="G")
								{
									proOptFlag.push("2");
									proIntIdArr.push(nodesHash[this.id].proIntId);
								}else if($(document.getElementById("startDate_"+this.id)).attr("class") != "InputGrey" && $(document.getElementById("startDate_"+this.id)).val() != $(document.getElementById("startDateSave_"+this.id)).val().substring(0,8)){
										if($(document.getElementById("startDate_"+this.id)).val()>"<%=dateStr2%>"){
											  proOptFlag.push("5");
											}else{										
								    		proOptFlag.push("2");
								      }
									  proIntIdArr.push(nodesHash[this.id].proIntId);
								}else if($(document.getElementById("stopDate_"+this.id)).attr("class") != "InputGrey" && $(document.getElementById("stopDate_"+this.id)).val() != $(document.getElementById("stopDateSave_"+this.id)).val().substring(0,8)){
								    proOptFlag.push("2");
									proIntIdArr.push(nodesHash[this.id].proIntId);
								}else
								{
									proOptFlag.push("0");
									proIntIdArr.push(nodesHash[this.id].proIntId);
								}
							}else if($("#"+this.id)[0].checked == false && $("#proName_"+this.id).text()=="退订")
							{
								proOptFlag.push("3");
								proIntIdArr.push(nodesHash[this.id].proIntId);
							}else if($("#"+this.id)[0].checked == true && $("#proName_"+this.id).text()=="新购")
							{
								proOptFlag.push("1");
								proIntIdArr.push("0");
							}else	
							{
								if(nodesHash[this.id].proStatu=="G")
								{
									proOptFlag.push("0");
									proIntIdArr.push(nodesHash[this.id].proIntId);
								}else
								{	
									proOptFlag.push("2");
									proIntIdArr.push(nodesHash[this.id].proIntId);
								}
							}
				/***************************end  拼产品的操作代码(0 无变化,1 增加,2 修改,3 删除)*********************/					
				/**********************begin  拼产品属性的操作代码(0 无变化,1 增加,2 修改,3 删除)*****************/ 
							offerIntIdArr.push("0");//主产品的附加产品的销售品实例ID为0
							/*如果是产品没属性的话proAttrOptFlag拼什么也就无所谓了*/
							if($("#proAttr_"+this.id).val()==""||typeof($("#proAttr_"+this.id).val())=="undefined")//变化的属性串值为空
							{
										proAttrOptFlag.push("0"); //不变
							}else  //新的不为空
							{
									if($("#newFlag_"+this.id).val()=="1")
									{
										proAttrOptFlag.push("1");
									}else
									{	
										proAttrOptFlag.push("2"); //有变化的属性，修改
									}	
							}
					 /*****************************end    拼产品属性的操作代码 *********************************************/							
					 /********************************begin  拼属性串***************************************************/		
									tempAttr=$("#proAttr_"+this.id).val();
									if($("#proAttr_"+this.id).val()==""||typeof($("#proAttr_"+this.id).val())=="undefined")//产品没属性
									{
										tempAttr="M";
									}
									prodAttrValueArr=prodAttrValueArr+tempAttr+"@";//产品属性总串		
						/********************************end  拼属性串****************************************************/	
						/****************************begin  拼新的产品状态(A 正常  B 注销  C 暂停，用户要求停机)************/	
								if($("#proName_"+this.id).text()=="正常"||$("#proName_"+this.id).text()=="新购")
								{
									newStatu.push("A");
								}else if($("#proName_"+this.id).text()=="退订")
								{
									newStatu.push("a");
								}else if($("#proName_"+this.id).text()=="暂停"||$("#proName_"+this.id).text()=="报停")
								{
									newStatu.push("G");
								}		
		       /***************************end  拼新的产品状态(A 正常  B 注销  C 暂停，用户要求停机)***************/
					 /*************************************如果是产品节点************************************************/
									productStatu.push(nodesHash[this.id].statu);
									if(proOptFlag[proOptFlag.length-1]=="0"&&proAttrOptFlag[proAttrOptFlag.length-1]=="0")
									{
										pordIdArr.push("mshow");
									}else
									{	
										pordIdArr.push(this.id);
									}	
									prodNameArr.push(nodesHash[this.id].getName());
									attrFlag.push("0");
									parentInstId.push("<%=offerSrvId%>");
									if(proOptFlag[proOptFlag.length-1]=="1")
									{
									    if(compareDates((document.getElementById("startDate_"+this.id)),(document.getElementById("stopDate_"+this.id)))==-1){
                                            rdShowMessageDialog("开始时间格式不正确,请重新输入!",0);
                                            (document.getElementById("startDate_"+this.id)).select();
                                            vFlag = false;
                                            return false;
                                        }
                                        if(compareDates((document.getElementById("startDate_"+this.id)),(document.getElementById("stopDate_"+this.id)))==-2){
                                            rdShowMessageDialog("结束时间格式不正确,请重新输入!",0);
                                            (document.getElementById("stopDate_"+this.id)).select();
                                            vFlag = false;
                                            return false;
                                        }
                                        
									                     if($(document.getElementById("startDate_"+this.id)).val() < "<%=dateStr2%>"){
                                            rdShowMessageDialog("开始时间应不小于当前时间,请重新输入!",0);
                                            (document.getElementById("startDate_"+this.id)).select();
                                            vFlag = false;
                                            return false;
                                        }
                                        if(($(document.getElementById("stopDate_"+this.id)).val() <= "<%=dateStr2%>")&&($(document.getElementById("stopDate_"+this.id)).val()!=$(document.getElementById("stopDateSave_"+this.id)).val().substring(0,8))){
                                            rdShowMessageDialog("结束时间应大于当前时间,请重新输入!",0);
                                            (document.getElementById("stopDate_"+this.id)).select();
                                            vFlag = false;
                                            return false;
                                        }
                                        
                                        if(compareDates((document.getElementById("startDate_"+this.id)),(document.getElementById("stopDate_"+this.id)))==1 || $(document.getElementById("startDate_"+this.id)).val()==$(document.getElementById("stopDate_"+this.id)).val()){
                                            rdShowMessageDialog("开始时间应小于结束时间,请重新输入!",0);
                                            (document.getElementById("stopDate_"+this.id)).select();
                                            vFlag = false;
                                            return false;
                                        }
                                        
                                        
                                        if($(document.getElementById("startDate_"+this.id)).val() > "<%=addThreeMonth%>"){
                        	                rdShowMessageDialog("开始时间必须是三个月内,请重新输入!",0);
                        	                (document.getElementById("startDate_"+this.id)).select();
                        	                vFlag = false;
                        	                return false;
                        	            }
                        	             
                    
										//prodExpireDate.push("20500101000000");
										var effDate = "";
										var expDate = "";
										if($(document.getElementById("startDate_"+this.id)).val() == "<%=dateStr2%>"){
										    effDate = "<%=currTime%>";
										}else{
																							
										    effDate = $(document.getElementById("startDate_"+this.id)).val() + "000000";
										}
										
										expDate = $(document.getElementById("stopDate_"+this.id)).val() + "000000";
										prodEffectDate.push(effDate);
										prodExpireDate.push(expDate);
									}else if(proOptFlag[proOptFlag.length-1]=="3")
									{
										prodEffectDate.push(document.getElementById("startDateSave_"+this.id).value);
						        prodExpireDate.push("<%=currTime%>");
									}else 
									{	
                                        if(compareDates((document.getElementById("startDate_"+this.id)),(document.getElementById("stopDate_"+this.id)))==-2){
                                            rdShowMessageDialog("结束时间格式不正确,请重新输入!",0);
                                            (document.getElementById("stopDate_"+this.id)).select();
                                            vFlag = false;
                                            return false;
                                        }
                                        
                                        if(($(document.getElementById("stopDate_"+this.id)).val() <= "<%=dateStr2%>")&&($(document.getElementById("stopDate_"+this.id)).val()!=$(document.getElementById("stopDateSave_"+this.id)).val().substring(0,8))){
                                            rdShowMessageDialog("结束时间应大于当前时间,请重新输入!",0);
                                            (document.getElementById("stopDate_"+this.id)).select();
                                            vFlag = false;
                                            return false;
                                        }
                                        if($(document.getElementById("startDate_"+this.id)).attr("class") != "InputGrey" && $(document.getElementById("startDate_"+this.id)).val() < "<%=dateStr2%>"){
                                            rdShowMessageDialog("开始时间应不小于当前时间,请重新输入!",0);
                                            (document.getElementById("startDate_"+this.id)).select();
                                            vFlag = false;
                                            return false;
                                        }
                                        
                                        if($(document.getElementById("startDate_"+this.id)).val() > "<%=addThreeMonth%>"){
                        	                rdShowMessageDialog("开始时间必须是三个月内,请重新输入!",0);
                        	                (document.getElementById("startDate_"+this.id)).select();
                        	                vFlag = false;
                        	                return false;
                        	            }
                    
                    
                                        var effDate = "";
										var expDate = "";
									if(proOptFlag[proOptFlag.length-1]!=5){
										if($(document.getElementById("startDate_"+this.id)).val() == "<%=dateStr2%>"){
										    effDate = "<%=currTime%>";
										}else if($(document.getElementById("startDate_"+this.id)).val() > "<%=dateStr2%>"){
										   effDate =$(document.getElementById("startDate_"+this.id)).val()+"000000";
										}else{
											 effDate =$(document.getElementById("startDateSave_"+this.id)).val();
											}
											
									}else{
										effDate = $(document.getElementById("startDateSave_"+this.id)).val()+"#"+$(document.getElementById("startDate_"+this.id)).val()+"000000";
										}
										
										expDate = $(document.getElementById("stopDate_"+this.id)).val() + "000000";
										prodEffectDate.push(effDate);
										prodExpireDate.push(expDate);
									}
									isMainProduct.push(0);	
				}			
		})
		if(!vFlag){
				    return false;
				}
/*---------------------------------------------end对主产品附加产品树的解析拼串过程end------------------------------------------------*/				
		
/*---------------------------------------------begin对产品树的解析拼串过程begin------------------------------------------------*/		
		if(sureGG=="false")
			return false;
/*---------------------------------------------end对产品树的解析拼串过程end------------------------------------------------*/				

			
		$("input[name='adslPrint']").val(adslPrint);
		$("input[name='proOptFlag']").val(proOptFlag);
		$("input[name='proIntIdArr']").val(proIntIdArr);
		$("input[name='parentInstId']").val(parentInstId);
		$("input[name='offerIntIdArr']").val(offerIntIdArr);
		$("input[name='proAttrOptFlag']").val(proAttrOptFlag);
		$("input[name='prodAttrValueArr']").val(prodAttrValueArr);
		$("input[name='sonParentArr']").val(sonParentArr);
		$("input[name='attrFlag']").val(attrFlag);
		$("input[name='productIdArr']").val(pordIdArr);
		$("input[name='prodNameArr']").val(prodNameArr);
		$("input[name='prodEffectDate']").val(prodEffectDate);
		$("input[name='prodExpireDate']").val(prodExpireDate);
		$("input[name='isMainProduct']").val(isMainProduct);
		$("input[name='productStatu']").val(productStatu);
		$("input[name='offerStatu']").val(offerStatu);
		$("input[name='offerIdArr']").val(offerIdArr);
		$("input[name='offerEffectTime']").val(offerEffectTime);
		$("input[name='offerExpireTime']").val(offerExpireTime);
		$("input[name='newStatu']").val(newStatu);
		
		//alert("操作类型proOptFlag|"+$("input[name='proOptFlag']").val()+"\n"+"失效时间prodEffectDate|"+$("input[name='prodEffectDate']").val()+"\n"+"生效时间prodExpireDate|"+$("input[name='prodExpireDate']").val()+"\n"+"特服名称prodNameArr|"+$("input[name='prodNameArr']").val());
		document.frm.action="changeProduceConfirm.jsp";
		showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
		if(rdShowConfirmDialog("请确认是否进行产品变更？")==1)
			{	
				var cust_id='<%=cust_id%>'; 
				document.all.sys_note.value="用户"+cust_id+"特服变更";
				
				if((document.all.op_note.value).trim()==""){
					document.all.op_note.value="用户"+cust_id+"特服变更";
				}	

				document.frm.submit();
			}
	}	
	
	function showPrtDlg(printType,DlgMessage,submitCfm)
  {   
   var h=198;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var pType="subprint";
   var billType="1";
   var sysAccept = "<%=sysAcceptl%>";
   var phone_no = "<%=phone_no%>";
   var offerIdArr = $("input[name='productIdArr']").val().split(",");
   var offerIdV1 = "";
   for(var io=0;io<offerIdArr.length;io++){
   	if(offerIdArr[io]!="mshow")
   	offerIdV1 +=offerIdArr[io]+"|";
   	}
   var mode_code = null;
   var fav_code = offerIdV1;
   var area_code = null;
   var printStr = printInfo(printType);

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
   var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);

   return ret;
  }

  function printInfo(printType)
  {
   var retInfo = "";
   var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	 
    if(printType == "Detail")
    {	//打印电子免填单
    <%
    String currTimeFPrt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date());
    %>    
		var currTime = "<%=currTime%>".substring(0,8);
		
    cust_info+="客户姓名：	"+"<%=custName%>"+"|";
    cust_info+="手机号码：	"+"<%=phone_no%>"+"|";
    cust_info+="证件号码：	"+"<%=idIccid%>"+"|";
    cust_info+="客户地址：	"+"<%=addr%>"+"|";
		
			opr_info+= opr_info+="业务受理时间："+"<%=currTimeFPrt%>"+"  用户品牌：<%=custPPv1%>"+"|";
			opr_info+="办理业务：产品变更 "+"  "+"操作流水："+"<%=sysAcceptl%>"+"|";
			opr_info+="|";
	 
 			var tProOptFlagArr = 	$("input[name='proOptFlag']").val().split(",");		        //操作类型
 			var tProdNameArrArr = 	$("input[name='prodNameArr']").val().split(",");		    //特服名称
 			var tProdEffectDateArr = 	$("input[name='prodEffectDate']").val().split(",");		//生效时间
 			var tProdExpireDateArr = 	$("input[name='prodExpireDate']").val().split(",");		//失效时间
 			
			var tempV1 = "";
			var tempV1n = "";
			
			var tempV1yn = "";
			var tempV1yt = "";
			
			var tempV2 = ""; 	
			var tempV2n = "";		
			var tempV2t = "";		
			
			var tempV3 = "";
			var tempV3n = "";
			
			var tempV5 = "";
			var tempV5n = "";
			var tempV5t = "";
			
			
			var tempAddVn1 = "";
			var tempAddVt1 = "";
 			
 			
 			for(var i=0;i<tProOptFlagArr.length;i++){
					if(tProOptFlagArr[i]=="1"){
						if(tProdEffectDateArr[i].substring(0,8)==currTime){
							tempV1n+=tProdNameArrArr[i]+",";
						}else{
							tempV1yn+=tProdNameArrArr[i]+",";
							tempV1yt+=tProdEffectDateArr[i].substring(0,8)+",";
						}
					}
					if(tProOptFlagArr[i]=="2"){
						if(tProdEffectDateArr[i].substring(0,8)>currTime){
								tempAddVn1 += tProdNameArrArr[i]+",";
								tempAddVt1 += tProdEffectDateArr[i].substring(0,8)+",";
							}else{
								tempV2n+=tProdNameArrArr[i]+",";
								tempV2t+=tProdExpireDateArr[i].substring(0,8)+",";
							} 
					}
					if(tProOptFlagArr[i]=="3"){
						tempV3n+=tProdNameArrArr[i]+","; 
					}  		
					if(tProOptFlagArr[i]=="5"){
						tempV5n+=tProdNameArrArr[i]+",";
						tempV5t+=(tProdEffectDateArr[i].substring(tProdEffectDateArr[i].indexOf("#")+1,tProdEffectDateArr[i].length)).substring(0,8)+",";
					} 		
 				}
 			
 			
 			tempV1n = replaceStrDf(tempV1n);	
 			tempV1yn = replaceStrDf(tempV1yn);	
 			tempV5n = replaceStrDf(tempV5n);	
 			tempV1yt = replaceStrDf(tempV1yt);	
 			tempV5t = replaceStrDf(tempV5t);	
 			tempV3n = replaceStrDf(tempV3n);	
 			tempV2n = replaceStrDf(tempV2n);	
 			tempV2t = replaceStrDf(tempV2t);	
 			
 			tempAddVt1 = replaceStrDf(tempAddVt1);	
 			tempAddVn1 = replaceStrDf(tempAddVn1);	
 			
 			
 			var tempV1d = "";
 			var tempV2d = "";
      if(tempV1n!=""&&tempV5n!="") tempV1d = ","; else tempV1d = "";
 			if(tempV1yt!=""&&tempV5t!="") tempV2d = ","; else tempV2d = "";
 				
 				
 			opr_info+="新增特服(24小时之内生效)："+tempV1n+"|";			
 			
 			opr_info+="新增特服(预约生效)："+tempV1yn+tempV1d+tempV5n+tempAddVn1+"|";	
 			opr_info+="生效时间："+tempV1yt+tempV2d+tempV5t+tempAddVt1+"|";
 			
 			opr_info+="取消特服(24小时之内生效)："+tempV3n+"|";		
 			
 			opr_info+="取消特服(预约生效)："+tempV2n+"|";
 			opr_info+="生效时间："+tempV2t+"|";
 			
   	  note_info4+="备注： <%=workNo%>为客户<%=custName%>做产品变更 "+"|";
  }
  
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
 	return retInfo;	
}
function replaceStrDf(tranStr){
		var retStr = "";
		if(tranStr!=""){
				retStr=tranStr.substring(0,tranStr.length-1);
			}
			
		return 	retStr;
	}
</script>

<body>
	<form  name="frm" action="" method="post">
	    <input type="hidden" name="adslPrint" />
		<input type="hidden" name="workNo" value="<%=workNo%>"/>
		<input type="hidden" name="phoneNo" value="<%=phone_no%>">
		<input type="hidden" name="mainProAttrCode" value="">
		<input type="hidden" name="offerDis" value="<%=offerDis%>"/>
		<input type="hidden" name="prtFlag" value="<%=prtFlag%>">
		<input type="hidden" name="orderArrayId" value="<%=orderArrayId%>">
		<input type="hidden" name="offerSrvId" value="<%=offerSrvId%>">
		<input type="hidden" name="closeId" value="<%=closeId%>">
		<input type="hidden" name="gCustId" value="<%=gCustId%>">
		<input type="hidden" name="offerid" value="<%=offerId%>">
		<input type="hidden" name="str" value="">
		<input type="hidden" name="sonParentArr"/>
		<input type="hidden" name="selNum" value="<%=phone_no%>">
		<input type="hidden" name="Band_Id" value="<%=Band_Id%>">  
		<input type="hidden" name="custOrderId" value="<%=custOrderId%>"/>
		<input type="hidden" name="custOrderNo" value="<%=custOrderNo%>"/>
		<input type="hidden" name="servOrderId" value="<%=servOrderId%>"/>
		<input type="hidden" name="servBusiId" value="<%=servBusiId%>"/>
	  <input type="hidden" name="regionCode" value="<%=regionCode%>">
		<input type="hidden" name="opCode" value="<%=opCode%>">
		<input type="hidden" name="opName" value="<%=opName%>">
		
		<!--销售品信息-->
		<input type="hidden" name="offerIdArr"/>
		<input type="hidden" name="offerEffectTime"/>
		<input type="hidden" name="offerExpireTime"/>
		<input type="hidden" name="offerStatu"/>
		<input type="hidden" name="offerIntIdArr"/>
		<!--产品信息-->
		<input type="hidden" name="prodNameArr" />
		<input type="hidden" name="newStatu" />
		<input type="hidden" name="proOptFlag" />
		<input type="hidden" name="proAttrOptFlag" />
		<input type="hidden" name="productIdArr" />
		<input type="hidden" name="attrFlag" />
		<input type="hidden" name="prodEffectDate"/>
		<input type="hidden" name="prodExpireDate"/>
		<input type="hidden" name="isMainProduct"/>
		<input type="hidden" name="prodAttrIdArr"/>
		<input type="hidden" name="prodAttrValueArr"/>
		<input type="hidden" name="productStatu"/>
		<input type="hidden" name="proIntIdArr"/>
		<input type="hidden" name="parentInstId"/>
		
		<input type="hidden" name="sysAcceptl" id="sysAcceptl"  value="<%=sysAcceptl%>"/>
		
	
      
		<%
		
		String stPMtotalPrepay    = retUserInfo.getValue("2.0.2.34");
		String stPMtype_name      = retUserInfo.getValue("2.0.2.15");  /*用户类型名称*/
		String stPMowner_type     = retUserInfo.getValue("2.0.2.14");  /*用户类型代码*/
		String stPMcard_name      = retUserInfo.getValue("2.0.2.21");  /*客户卡类型名称*/
		String stPMgrpbig_name    = retUserInfo.getValue("2.0.2.24");  /*集团客户名称*/

		if(stPMtotalPrepay.indexOf(".")!=-1){
		  		stPMtotalPrepay = stPMtotalPrepay+"00";
		  	}else{
		  		stPMtotalPrepay = stPMtotalPrepay+".00";
		  		}
		  		
		  	stPMtotalPrepay = stPMtotalPrepay.substring(0,stPMtotalPrepay.indexOf(".")+3);	
		  String 	stPMtotalOwe       = retUserInfo.getValue("2.0.2.33");
		  	if(stPMtotalOwe.indexOf(".")!=-1){
		  		stPMtotalOwe = stPMtotalOwe+"00";
		  	}else{
		  		stPMtotalOwe = stPMtotalOwe+".00";
		  		}
		  		
		  	stPMtotalOwe = stPMtotalOwe.substring(0,stPMtotalOwe.indexOf(".")+3);	
		%>
		
		<%@ include file="/npage/include/header.jsp" %>
        <div class="title">
            <div id="title_zi">客户基本信息【CV001】</div>
        </div>

				<table cellspacing=0>
				<tr> <td class="blue">大客户标志</td> <td><%=stPMcard_name%></td>   <td class="blue">集团标志</td> <td><%=stPMgrpbig_name%></td>   </tr>
<tr> <td class="blue">用户ID</td> <td><%=retUserInfo.getValue("2.0.2.1")%></td>   <td class="blue">客户名称</td> <td><%=retUserInfo.getValue("2.0.2.8")%></td>   </tr>

<tr> <td class="blue">当前状态</td> <td><%=retUserInfo.getValue("2.0.2.11")%></td>   <td class="blue">级别</td> <td><%=retUserInfo.getValue("2.0.2.13")%></td>   </tr>
<tr> <td class="blue">证件类型</td> <td><%=retUserInfo.getValue("2.0.2.18")%></td>   <td class="blue">证件号码</td> <td><%=retUserInfo.getValue("2.0.2.19")%></td>   </tr>
<tr> <td class="blue">当前预存</td> <td><%=stPMtotalPrepay%></td>   <td class="blue">当前欠费</td> <td><%=stPMtotalOwe%></td>   </tr>
				</table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">基本产品信息</div>
</div>

			<table cellspacing=0>
			<tr>
			<td class="blue" nowrap>产品标识</td>
			<td><%=Product_id%>
			</td>
			<td class="blue">产品名称</td>
			<td><%=proName%>
			</td>
			</tr>	
			</table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">基本产品属性</div>
</div>
<div id="attrlist"></div>

</div>
<div id="Operation_Table">
    
<div id="items">
<div class="item-col2 col-1">

<div class="title">
	<div id="title_zi">附属产品构成信息</div>
</div>
			<!--<div class="title"><div class="text">附属产品构成信息</div></div>-->
			<div id="complex_component"></div> 
			<div id="rootTree1"><div id="complex_pro"></div></div>
<!--			<div class="title"><div class="text">可选产品构成信息：</div></div>
		  <div id="offer_component"></div> 
		  <div id="div_offerComponent"></div>-->
</div>
<div class="item-row2 col-2">

<div class="title">
	<div id="title_zi">已定购产品信息</div>
</div> 
		  
		  <div id="pro_component"></div>
			</div>

			</div>
			<%@ include file="/npage/common/qcommon/bd_0007.jsp" %>	<!--sys_note op_note-->
		<div id="footer">
		<input type="button" class="b_foot" value="确定" onclick="next()"/>
	<!--	<input type="button" class="b_foot" value="返回" onclick="window.location='custInfo.jsp?closeId=<%=closeId%>&gCustId=<%=gCustId%>'" /> -->
		<input type="button" class="b_foot" value="关闭" onclick="shutdown()"/>
		</div>
		<%@ include file="/npage/include/footer_new.jsp" %>
	</form>
</body>
</html>



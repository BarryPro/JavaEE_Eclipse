<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
	System.out.println("<<--------------complexPro.jsp--------------------->>"+new Date()); 
	String workNo = (String)session.getAttribute("workNo");
	String groupId = (String)session.getAttribute("groupId");
	String siteId = (String)session.getAttribute("siteId");
	String errCode = "";
	String errMsg = "";
	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
	int recordNum = 0; //��ѯ�����¼����
	StringBuffer sb = new StringBuffer(80);
	String offerId = WtcUtil.repNull(request.getParameter("offerId"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	//System.out.println("------------------offerId-----------------------"+offerId);
	String com_pro_id= WtcUtil.repNull(request.getParameter("com_pro_id")); 
	String com_pro_intId= WtcUtil.repNull(request.getParameter("com_pro_intId")); 
	String iServId = WtcUtil.repNull(request.getParameter("servId"));
	
 long s1=System.currentTimeMillis();	
	
	
 //System.out.println("--------------------------------------------"+new Date());
%>
<wtc:utype name="sQCompMemInfo" id="retVal" scope="end">
			<wtc:uparam value="<%=com_pro_intId%>" type="long"/>
			<wtc:uparam value="<%=com_pro_id%>" type="long"/>
			<wtc:uparam value="<%=offerId%>" type="long"/>
			<wtc:uparam value="<%=workNo%>" type="string"/>
			<wtc:uparam value="<%=opCode%>" type="string"/>			
</wtc:utype>
<%

//System.out.println("--------------------------------------------"+new Date());
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	errCode = String.valueOf(retVal.getValue(0));
	if(retVal.getUtype("2") == null)
	{
		valid = 1;
		errMsg = retVal.getValue(1);
	}
	else{
		recordNum = retVal.getUtype("2").getSize();
		if(recordNum == 0)
		{
			valid = 2;
      errMsg = "û�в�ѯ�������Ϣ!";
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
	for(int i=0;i<retVal.getUtype("2").getSize();i++)
	{                   
						UType prodcutUtype = retVal.getUtype("2."+i);


						sb.append("product"+prodcutUtype.getValue(1)+" = new productClass('");
						sb.append(com_pro_id+"','");//�ϼ���ƷID
						sb.append(prodcutUtype.getValue(0)+"','");//����״̬
						sb.append(prodcutUtype.getValue(4)+"','");//��Ʒʵ��״̬
						sb.append(prodcutUtype.getValue(3)+"','");//��Ʒʵ��ID
						sb.append(prodcutUtype.getValue(6)+"');");//�Ƿ�������
						sb.append("product"+prodcutUtype.getValue(1)+".setId('"+prodcutUtype.getValue(1)+"');");
						sb.append("product"+prodcutUtype.getValue(1)+".setName('"+prodcutUtype.getValue(2)+"');");
						sb.append("product"+prodcutUtype.getValue(1)+".setType('O');");
						sb.append("product"+prodcutUtype.getValue(1)+".setParentId('"+com_pro_id+"');");
						sb.append("product"+prodcutUtype.getValue(1)+".setSelFlag('"+prodcutUtype.getValue(5)+"');");
						sb.append("product"+prodcutUtype.getValue(1)+".setEffTime('"+prodcutUtype.getValue(7)+"');");
						sb.append("product"+prodcutUtype.getValue(1)+".setExpTime('"+prodcutUtype.getValue(8)+"');");
						sb.append("nodesHash['"+prodcutUtype.getValue(1)+"']=product"+prodcutUtype.getValue(1)+",");
						sb.append("baseClass2.addNode(product"+prodcutUtype.getValue(1)+");");
		}  
}	
%>

<script>
	var prodBaseClass = function()
	{ 
		this.length = 0;
		this.item = [];
		this.addNode=function(node) 
		{
			this.item[this.length++] = node;
		}
		this.cancelChecked=function(node)
		{
			
			  $("#"+node.id).attr('checked','');
			  for(var i=0;i<node.item.length;i++)
			  {
				 node.cancelChecked(node.item[i]);
			  }
		}
		this.getNode=function(i)
		{ 
			 return this.item[i];
		}
		this.hasChildren=function()
		{
			 return (this.length>0);
		}
		this.setId=function(id)
		{
		  this.id = id;
		}
		this.getId=function()
		{
		  return this.id;
		}
		this.setName=function(name)
		{
		  this.name = name;
		}
		this.getName=function()
		{
		  return this.name;
		}
		this.setType=function(type)
		{
		   this.type = type;
		}
	    this.getType=function()
		{
		  return this.type;
		}
		this.setParentId=function(parentId)
		{
		   this.parentId = parentId;
		}
	    this.getParentId=function()
		{
		  return this.parentId;
		}
		this.setSelFlag=function(selFlag)
		{
		   this.selFlag = selFlag;
		}
	    this.getSelFlag=function()
		{
		  return this.selFlag;
		}
		this.setMaxNum=function(maxNum)
		{
		   this.maxNum = maxNum;
		}
	    this.getMaxNum=function()
		{
		  return this.maxNum;
		}
		this.setMinNum=function(minNum)
		{
		   this.minNum = minNum;
		}
	    this.getMinNum=function()
		{
		  return this.minNum;
		}
		this.getLength=function()
		{
		  return this.length;
		}
		this.setCode=function(code)
		{
		  this.code=code;
		}
		this.getCode=function()
		{
		  return this.code;
		}
		this.setEffTime=function(begTime)
		{
		  this.begTime=begTime;
		}	
		this.getEffTime=function()
		{
		  return this.begTime;
		}	
		this.setExpTime=function(expireTime)
		{
		  this.expireTime=expireTime;
		}	
		this.getExpTime=function()
		{
		  return this.expireTime;
		}			
	}
    var productClass = function(parentOffer,statu,proStatu,proIntId,haveAttr)
	{ 
	  
	   prodBaseClass.call(this);
	   this.parentOffer = parentOffer;
	   this.statu = statu;
	   this.proStatu=proStatu;
	   this.proIntId=proIntId;
	   this.haveAttr=haveAttr;
	}
	
	productClass.prototype = new prodBaseClass();  

var baseClass2 = new prodBaseClass();
	
<%=sb.toString()%>

function showInfo2(node)
{
		for(var i=0;i<node.item.length;i++)
  	{
		 showProd2(node.item[i]);
  	}	
}

function fucCheckLength(strTemp)  
{  
 var i,sum;  
 sum=0;  
 for(i=0;i<strTemp.length;i++)  
 {  
  if ((strTemp.charCodeAt(i)>=0) && (strTemp.charCodeAt(i)<=255))  
   sum=sum+1;  
  else  
   sum=sum+2;  
 }  
 return sum;  
}  

function showProd2(node){
        var spaceStr = "";
        var strLen = fucCheckLength(node.getName());
 
        if(strLen<16){
    	    var len = 16 - strLen;
    	    for(var li=0;li<len;li++){
    	        spaceStr = spaceStr + "&nbsp;";
    	    }
    	}
				
				
		$("#complex_pro_"+offerId).append("<span id='p_"+node.getId()+"'><input type='checkbox' name='complex_produce"+node.getId()+"' id='"+node.getId()+"' class='cls_"+node.getParentId()+"'  onClick=chgDetailProd2('"+node.getId()+"') >"+node.getName()+"</span>"+spaceStr);
		trNum=trNum+1;
		if(trNum%3==0)
		{
			$("#complex_pro_"+offerId).append("<br/>");
		}
}

/*---------------չʾѡ�в�Ʒ��һ����¼-----------------------*/
function showDetailProd2(node,showStatu,flag,startFlag,effTime,expTime)
{
        node2 = node;
        var packet = new AJAXPacket("complexPro_ajax.jsp","���Ժ�...");
		//packet.data.add("node" ,node);
		packet.data.add("nodeId" ,node.getId());
		packet.data.add("showStatu" ,showStatu);
		packet.data.add("flag" ,flag);
		packet.data.add("startFlag",startFlag);
		packet.data.add("servId","<%=iServId%>");
		packet.data.add("effTime",effTime);
		packet.data.add("expTime",expTime);		
		core.ajax.sendPacketHtml(packet,doShowDetailProd2);
		packet =null;
		
}
function doShowDetailProd2(data){
    eval(data);
}
/*----------------�����ͣ���޸Ĳ�Ʒ״̬Ϊ��ͣ-----------*/
function chkStop(id)
{
		var node = nodesHash[id];
		if($("#proName_"+node.getId()).text()=="�˶�")
		{
			$("#proName_"+node.getId()).text("�˶�");
		}else
		{
			$("#proName_"+node.getId()).text("��ͣ");
		}	
}

/*-------------�ָ���Ʒ״̬---------------------------*/
function returnStop(id)
{
		var node = nodesHash[id];
		if(($("#proName_"+node.getId()).text()=="��ͣ")||($("#proName_"+node.getId()).text()=="��ͣ"))
		{
				$("#proName_"+node.getId()).text("����");
		}
}	

/*----------�޸Ĳ�Ʒ�Ķ�̬����------------------------*/
function setAttr2(id,showStatu)
{
		var node = nodesHash[id];
		var nodeId=node.getId();
		var proName=node.getName();
		var productId=node.proIntId;
		var h=600;
	var w=800;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var returnval=window.showModalDialog("chgProAttr.jsp?servId="+productId+"&proName="+proName+"&ProdId="+nodeId+"&isNew="+showStatu+"&opCode=<%=opCode%>","",prop);
		if(typeof(returnval) != "undefined"){
			$("#proAttr_"+node.getId()).val(returnval.newVal);
			$("#newFlag_"+node.getId()).val(returnval.newFlag);
			$("#att_"+node.getId()).attr("class","b_text");
		}	
}

/*---------�޸Ĳ�Ʒ����ѡ��״̬,��Ʒչʾ״̬�Ķ�̬�ı�----------*/
function chgDetailProd2(id)
{   
	  var showStatu;
		var initStatu=nodesHash[id].statu;
		var node=nodesHash[id];
		if($("#"+node.getId()).attr("checked")==true && initStatu=="�Ѷ���")
		{
			showStatu="����";
			$("#proName_"+node.getId()).text("����");
			if($("#stopDate_"+node.getId()).attr("modFlag") == "true"){
    			$("#stopDate_"+node.getId()).removeClass("InputGrey");
    			$("#stopDate_"+node.getId()).attr("readOnly",false);
    			
    		}
		}else if($("#"+node.getId()).attr("checked")==undefined && initStatu=="�Ѷ���")
		{
			showStatu="�˶�";
			$("#proName_"+node.getId()).text("�˶�");
			if($("#stopDate_"+node.getId()).attr("modFlag") == "true"){
    			$("#stopDate_"+node.getId()).addClass("InputGrey");
    			$("#stopDate_"+node.getId()).attr("readOnly",true);
    		}
		}else if($("#"+node.getId()).attr("checked")==true && initStatu=="δ����")
		{ 
			showStatu="�¹�";
			showDetailProd2(node,showStatu,0,9999,node.getEffTime(),node.getExpTime());	
		}else if($("#"+node.getId()).attr("checked")==undefined && initStatu=="δ����")
		{
			$("#pro_detail_"+node.getId()).remove();
		}
}
//��ʼ������Ʒ����չʾ
function initInfo2(node,porEff,proExi){
	var showStatu=node.statu;
	if(node.statu=="�Ѷ���")
	{
	 if(node.proStatu=="G")
			{
					showStatu="��ͣ";
			}else 
			{
				  showStatu="����";
			}        //ֻ��������״̬���û��ܽ����Ʒ���
	}		
	
	if(node.statu=="δ����")
	 showStatu="�¹�"; 
	 
	var vId = node.getId();
	if(typeof(vId) != "undefined"){
		var selFlag = node.getSelFlag();
		var statu=node.statu;
		if(selFlag == "0")//��ѡ
		{
			$("#"+vId).attr("checked",true);
			$("#"+vId).attr("disabled",true);
			if(node.getType() == "M"||node.getType() == "O"){	
				showDetailProd2(node,showStatu,1,0,node.getEffTime(),node.getExpTime());    //չʾѡ�еĲ�Ʒ����Ϣ
			}	
			$("#"+vId).attr("disabled",true);
		}else if(selFlag == "2")//��ѡ
		{
			if(node.statu=="�Ѷ���")
			{
				$("#"+vId).attr("checked",true);
				if(node.getType() == "M"||node.getType() == "O"){	
					showDetailProd2(node,showStatu,1,2,node.getEffTime(),node.getExpTime());
				}
			}else
			{
				$("#"+vId).attr("checked",false);
			}	
		}else//Ĭ��ѡ��
		{
			if(node.statu=="�Ѷ���")
			{
				$("#"+vId).attr("checked",true);
				if(node.getType() == "M"||node.getType() == "O"){	
					showDetailProd2(node,showStatu,1,1,node.getEffTime(),node.getExpTime());
				}
			}
		}	
	}
	for(var i=0;i<node.item.length;i++)
  {
	 initInfo2(node.item[i],porEff,proExi);
  }	
}
</script>

<%
long s2=System.currentTimeMillis();
//System.out.println("s2-s1  complexPro.jsp===="+(s2-s1));	
System.out.println("<<--------------complexPro.jsp--------------------->>"+new Date()); 
%>
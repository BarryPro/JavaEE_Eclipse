<%
   /*���ƣ����ſͻ���Ŀ���� - ��ѯdParterOperation
�� * �汾: v1.0
�� * ����: 2007/2/7
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.10
 ģ�飺�������ҵ������
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%

	String regCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

	String parterId = request.getParameter("parterId");
	String queryType = request.getParameter("oTypeCode");
	String parterName = request.getParameter("parterName");
	String grpParamSet="";
	String grpParamSetName="";
	String sqlStr ="";
	String Basetype ="";
	String biztype ="";
	String[] inParams = new String[2];

%>
	 
	<wtc:service name="s2889QryServMsg" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6" >
            	<wtc:param value=""/>
            	<wtc:param value=""/>
              <wtc:param value="2889"/>
              <wtc:param value="<%=workNo%>"/>
              <wtc:param value="<%=workPwd%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value="<%=queryType%>"/>
              <wtc:param value="<%=parterId%>"/>
   </wtc:service>
   <wtc:array id="colNameArrTemp" scope="end" />
	<%
	String[][] colNameArr = colNameArrTemp;
	
	if (colNameArr.length==0)
	{
		colNameArr = null;
	}	 

 sqlStr = "select net_attr,net_name from sNetAttr";
	 
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="netArrTemp" scope="end" />
<%
	 String[][] netArr = netArrTemp;
	 
	 if (netArr.length==0)
	 {
		 netArr = null;
	 }	 
	 
	 String bizLabel = "";
	 if("1".equals(queryType)){
	 	 bizLabel = "MAS";
	 }else{
	 	 bizLabel = "";
	 }
	 inParams[0] = "select parter_type from dpartermsg where parter_id=:parter_id";
	 inParams[1] = "parter_id="+parterId;		
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
	<wtc:param value="<%=inParams[0]%>"/>
	<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service> 
	<wtc:array id="bizLabelArr" scope="end" />
<%
    if("000000".equals(retCode1) && bizLabelArr.length>0){
        String bizLabelTemp = bizLabelArr[0][0];
        System.out.println("bizLabelTemp = " + bizLabelTemp);
        /* 
         * 02 26 : ADC
         * 25 27 : MAS
         */
        /*if("25".equals(bizLabelTemp) || "27".equals(bizLabelTemp)){
            bizLabel = "MAS";
        }else */
        if("02".equals(bizLabelTemp) || "26".equals(bizLabelTemp)){
            bizLabel = "ADC";
        }
    }
%>

<html>
<head>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>

<script language="javascript">
	
	function accessNumberChg(){

		 if((document.all.queryType.value=="2")&&(document.form1.BaseServCodeProp.value!="02")&&(document.form1.biztype.value=="1"))
		 {
		 	document.getElementById("accessNumber").setAttribute("readOnly", false);

		 	}else{
		 	document.getElementById("accessNumber").setAttribute("readOnly", true);
		 	}
}
	
	//��ʾ����ҵ����Ϣ���
	function showAddBusiInfo()
	{	
		tabBusiAdd.style.display="";
		tabAddBtn.style.display="none";
		tabAddSubmitBtn.style.display="";
		if(document.all.queryType.value=="2")
		{
			
			document.getElementById("YYYY").style.display="none";
		  document.getElementById("XXXX").style.display="none";
		  document.getElementById("cylx1").style.display="none";

		 }
		

	}
	
	function changeCF()
{
	var rBList = document.form1.rBList.value;
	if(rBList=="4")
	{
			var ln=document.form1.CreateFlag.options.length;
      while(ln--)
      {
        	document.form1.CreateFlag.options[ln] = null;
	   	}
	   	var option =new Option("--��ѡ��--","*");  
	   	document.form1.CreateFlag.add(option); 
	   	var option =new Option("B-C/P��","0");  
	   	document.form1.CreateFlag.add(option); 
	   	var option =new Option("B-E/M��","1");  
	   	document.form1.CreateFlag.add(option); 
	}
else//�ڰ�����
	{
      var ln=document.form1.CreateFlag.options.length;
      while(ln--)
      {
        	document.form1.CreateFlag.options[ln] = null;
	   	}
	    var option =new Option("B-E/M��","1");  
	   	document.form1.CreateFlag.add(option); 
		}
	
}

	//ѡ��EC/SI���������
	function getBaseCode()
	{
		var accModel= document.form1.accessModel.value;
		window.open("f2889_querydBaseCodeMsg.jsp?&queryInfo="+<%=parterId%>+"&queryType="+<%=queryType%>+"&accModel="+accModel,"","height=500,width=400,scrollbars=yes");
	}
	
	//����ҳ��
	function resetPage()
	{
		if(document.all.queryType.value=="1")
		{
			document.all.biztype.value="0";
			document.all.biztype.disabled=true;
		}
		else
		{
			document.all.biztype.disabled=false;
			document.all.biztype.value="0";
			tabAddinfo.style.display="none";
		}
	}
	
	//��ʼ��ҳ��Ԫ��
	function init()
	{
		document.all.TextSignEn.value="";
		document.all.TextSignZh.value="";
		document.all.MaxItemPerDay.value="";
		document.all.MaxItemPerMon.value="";
		if("<%=bizLabel%>"!="MAS"){
			document.all.LimitAmount.value="";
		}
		document.all.InvalidTimeSpanList.value="";
		document.all.MOList.value="";
		document.all.StartTime.value="";
		document.all.EndTime.value="";
		document.all.MOCode.value="";
		document.all.CodeMathMode.value="";
		document.all.MOType.value="";
		document.all.DestServCode.value="";
		document.all.ServCodeMathMode.value="";

		
	}
	
	//���ò������·�ʱ����б�
	function setTime()
	{
		window.open('f2889_setTime.jsp','','height=500,width=1000,left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
		
	}
	//��������ҵ��ָ��
	function setMO()
	{
		window.open('f2889_setMo.jsp','','height=600,width=1000,left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}
	
	/************************ ����ҵ����Ϣ ***********************/
	function addCfm()
	{
		
		if(!checkElement(document.all.accessNumber)){
			return false;
		}
		
		var iaccNum=document.form1.accNum.value;	
		if($.trim(iaccNum).length == 0){
			rdShowMessageDialog("��ѡ���������ţ�");
			return false;	
		}
		var iaccessNumber=document.form1.accessNumber.value;	
		var iaccess=iaccessNumber.substring(0,iaccNum.length);
		if(iaccNum!=iaccess)
		{
			rdShowMessageDialog("��������ŵ��޸�ֻ����ԭ����Ż����Ͻ����������");
			return false;	
		}
		
		if((document.all.queryType.value=="1")||(document.all.bizType.value=="1")){
		if(document.form1.rBList.value=="*")
		{
			rdShowMessageDialog("ҵ�����Բ���Ϊ��");
			return false;	
		}
		}
		//alert(document.form1.biztype.value);
		
		document.form1.bizType.value=document.form1.biztype.value;
		
		//alert(document.form1.bizType.value);
		
		/****************** ͨ��У��  begin ********************/		
		if(!check(form1)) return false;	
		//����������ƶ�OA���˰���ʾ��Ϣ��20081106
		if(document.form1.bussId.value.substring(6,8)=="21")
		{
			rdShowMessageDialog("��ҵ��Ϊ�ƶ�OA���˰棬����Ҫ����BBOSS��ҵ������Ӧ��ϵ���뵽[ҵ�����ͷ�������Ӧ��ϵά��]�����ã�");
		}
		
		var vBizLabel = "<%=bizLabel%>";
		var vBussId = $("#bussId").val();
	    vBussId=vBussId.substring(0,1);



		var vBizTypeL = $("#bizTypeL").val();
		var vBizTypeS = $("#bizTypeS").val();
		
		if(vBizTypeL == ""){
		    rdShowMessageDialog("��ѡ��ҵ�����!",0);
		    $("#bizTypeL").focus();
		    return false;
		}
		
		if(vBizTypeS == ""){
		    rdShowMessageDialog("��ѡ��ҵ��С��!",0);
		    $("#bizTypeS").focus();
		    return false;
		}

		if(document.form1.netAttr.value=="*")
		{
			rdShowMessageDialog("�������Բ���Ϊ��");
			return false;
		}				

		if(document.form1.oprEffTime.value == "")
		{
			rdShowMessageDialog("�����롰������Чʱ�䡱��");
			return false;
		}
		if(document.form1.grpParamSet.value == "")
		{
			rdShowMessageDialog("�������Ͳ���Ϊ��");
			return false;
		}

		if(!validDate(document.all.oprEffTime))	return false;

		if(parseInt(document.all.oprEffTime.value) < parseInt("<%=strDate%>"))
		{
			rdShowMessageDialog("��������Чʱ�䡱����С��ϵͳ����ʱ�䣡");
			return false;
		}

			if(document.form1.provURL.value != "" && document.form1.provURL.value.substr(0,7)!="http://")
			{
				rdShowMessageDialog("URL����http://��ͷ��");
				document.form1.provURL.select();
				return false;
			}
		
			if(chkwww(document.form1.provURL.value)==0)
			{
				rdShowMessageDialog("URL�Ƿ���");
				document.form1.provURL.select();
				return false;
			}


   if(document.form1.introURL.value != "" && document.form1.introURL.value.substr(0,7)!="http://")
			{
				rdShowMessageDialog("URL����http://��ͷ��");
				document.form1.introURL.select();
				return false;
			}

			if(chkwww(document.form1.introURL.value)==0)
			{
				rdShowMessageDialog("URL�Ƿ���");
				document.form1.introURL.select();
				return false;
			}

		
		if(document.all.queryType.value=="0"&&document.all.biztype.value=="1")
		{
			//SI��������ҵ��,��Ҫ�Ա��������У��
			if(document.all.MaxItemPerDay.value=="")
			{
				rdShowMessageDialog("������ÿ���·������������");
			    return false;
			}
			if(isNaN(document.all.MaxItemPerDay.value)==true)
			{
				rdShowMessageDialog("ÿ���·����������ֻ���������֣�");
			    return false;
			}
			
			if(document.all.MaxItemPerMon.value=="")
			{
				rdShowMessageDialog("������ÿ���·������������");
			    return false;
			}
			
			if(isNaN(document.all.MaxItemPerMon.value)==true)
			{
				rdShowMessageDialog("ÿ���·����������ֻ���������֣�");
			    return false;
			}	
				
			if(document.all.TextSignEn.value=="")
			{
				rdShowMessageDialog("������Ӣ������ǩ����");
			    return false;
			}
			if(document.all.TextSignZh.value=="")
			{
				rdShowMessageDialog("��������������ǩ����");
			    return false;
			}
			if((document.form1.rBList.value=="3")||(document.form1.rBList.value=="4"))
			{
				if(vBizLabel != "MAS"){
					if(document.all.LimitAmount.value=="")
			    {
					rdShowMessageDialog("�����������·�������");
			    	return false;
			    }
				}
			}
			
			if(!forInt(document.all.MaxItemPerDay)) return false;
			if(!forInt(document.all.MaxItemPerMon)) return false;
			if(vBizLabel != "MAS"){
				if(!forInt(document.all.LimitAmount)) return false;
			}
		
			
		}
		
		if((document.all.queryType.value=="1")&&((document.form1.rBList.value=="3")||(document.form1.rBList.value=="4")))
			{	
				if(vBizLabel != "MAS"){
					if(document.all.LimitAmount.value=="")
			    {
					rdShowMessageDialog("�����������·�������");
			    	return false;
			    }
				}
			}
		if((document.all.queryType.value=="1")||(document.all.bizType.value=="1")){
		if(document.form1.billingType.value == "00"&&document.form1.price.value != "0")
		{
			rdShowMessageDialog("�Ʒ�����Ϊ���ʱ������ֻ����0��");
			return false;
		}
		}
		document.all.accessModel.disabled=false;
		
		//alert ("end");
		
		/****************** ͨ��У��  end ********************/		
		
		
		/*2015/05/04 16:02:06 gaopeng �����·�ʡ��ҵ������MASҵ��֧��ʵʩ������֪ͨ 
			2889���������ҵ������
			��ѯ���ͣ����ű���  ���Լ��ţ� 4510224035 
			��ѯ���ſͻ���Ϣ�󣬵������ѯҵ����Ϣ���͡�����ҵ����Ϣ�� ҳ�����ʾ��������ҵ����Ϣ
			�����������ġ���������š� 1065097 ����ͷ���򡰷���ģʽ������Ϊ��01-SMS������ҵ�����ԡ�����Ϊ����������
			
			�����������ġ���������š� 1065096 ����ͷ���򡰷���ģʽ������ѡ��01-SMS���͡�02-MMS������ҵ�����ԡ�����Ϊ�����ƴ�����������
			accessNumber
			
			accessModel
			
			rBList
			var option =new Option("������","2");  
	   	document.form1.rBList.add(option); 
	   	var option =new Option("���ƴ���������","3");  
	   	
	   	bizTypeL
	   	bizTypeS
			
		*/
		
		var accessModelVal = $("select[name='accessModel']").find("option:selected").val();
		var rBListVal = $("select[name='rBList']").find("option:selected").val();
		
		var bizTypeLVal = $("select[name='bizTypeL']").find("option:selected").val();
		var bizTypeSVal = $("select[name='bizTypeS']").find("option:selected").val();
		
		var accessNumberVal = $.trim($("#accessNumber").val());
		if(accessNumberVal >= 7){
			var subAccessNumber = accessNumberVal.substring(0,7);
			if(subAccessNumber == "1065097"){
				if(accessModelVal != "01"){
					rdShowMessageDialog("����������ԡ�1065097����ͷʱ������ģʽֻ��ѡ��SMS����");
					return false;
				}
				if(rBListVal != "2"){
					rdShowMessageDialog("����������ԡ�1065097����ͷʱ��ҵ������ֻ��ѡ�񡰺���������");
					return false;
				}
				if(bizTypeLVal != "04" && bizTypeSVal != "03"){
					rdShowMessageDialog("����������ԡ�1065096����1065097����ͷʱ��ҵ�����ֻ��ѡ��04-ȫ��ҵ�񡱣�ҵ��С��ֻ��ѡ��03-ʡ��ҵ���ض�������MAS����");
					return false;
				}
			}
			if(subAccessNumber == "1065096"){
				if(accessModelVal != "01" && accessModelVal != "02"){
					rdShowMessageDialog("����������ԡ�1065097����ͷʱ������ģʽֻ��ѡ��SMS����MMS����");
					return false;
				}
				if(rBListVal != "3"){
					rdShowMessageDialog("����������ԡ�1065097����ͷʱ��ҵ������ֻ��ѡ�����ƴ�������������");
					return false;
				}
				if(bizTypeLVal != "04" && bizTypeSVal != "03"){
					rdShowMessageDialog("����������ԡ�1065096����1065097����ͷʱ��ҵ�����ֻ��ѡ��04-ȫ��ҵ�񡱣�ҵ��С��ֻ��ѡ��03-ʡ��ҵ���ض�������MAS����");
					return false;
				}
			}
			
		}

		document.form1.action="f2889_modCfm.jsp?OprCode=01";
		document.form1.submit();					
	}
	
function validDate(obj)
{
  var theDate="";
  var one="";
  var flag="0123456789";
  for(i=0;i<obj.value.length;i++)
  { 
     one=obj.value.charAt(i);
     if(flag.indexOf(one)!=-1)
		 theDate+=one;
  }
  if(theDate.length!=8)
  {
	rdShowMessageDialog("���ڸ�ʽ������ȷ��ʽΪ�����������������ա������������룡");
	//obj.value="";
	obj.select();
 	obj.focus();
	return false;
  }
  else
  {
     var year=theDate.substring(0,4);
	 var month=theDate.substring(4,6);
	 var day=theDate.substring(6,8);
	 if(myParseInt(year)<1900 || myParseInt(year)>3000)
	 {
       rdShowMessageDialog("��ĸ�ʽ������Ч���Ӧ����1900-3000֮�䣬���������룡");
	   //obj.value="";
	   obj.select();
	   obj.focus();
	   return false;
	 }
     if(myParseInt(month)<1 || myParseInt(month)>12)
	 {
       rdShowMessageDialog("�µĸ�ʽ������Ч�·�Ӧ����01-12֮�䣬���������룡");
  	   //obj.value="";
	   obj.select();
	   obj.focus();
	   return false;
	 }
     if(myParseInt(day)<1 || myParseInt(day)>31)
	 {
       rdShowMessageDialog("�յĸ�ʽ������Ч����Ӧ����01-31֮�䣬���������룡");
	   //obj.value="";
	   obj.select();
       obj.focus();
	   return false;
	 }

     if (month == "04" || month == "06" || month == "09" || month == "11")  	         
	 {
         if(myParseInt(day)>30)
         {
	 	     rdShowMessageDialog("���·����30��,û��31�ţ�");
 	         //obj.value="";
			 obj.select();
	         obj.focus();
             return false;
         }
      }                 
       
      if (month=="02")
      {
         if(myParseInt(year)%4==0 && myParseInt(year)%100!=0 || (myParseInt(year)%4==0 && myParseInt(year)%400==0))
		 {
           if(myParseInt(day)>29)
		   {
 		     rdShowMessageDialog("������·����29�죡");
      	     //obj.value="";
			 obj.select();
	         obj.focus();
             return false;
		   }
		 }
		 else
		 {
           if(myParseInt(day)>28)
		   {
 		     rdShowMessageDialog("��������·����28�죡");
      	     //obj.value="";
			 obj.select();
	         obj.focus();
             return false;
		   }
		 }
      }
  }
  return true;
}	
	
	
	
function changeRBList()
{
	var billingType = document.form1.billingType.value;
	if(billingType=="00"||billingType=="02")//��ѻ򰴴�
	{
			var ln=document.form1.rBList.options.length;
      while(ln--)
      {
        	document.form1.rBList.options[ln] = null;
	   	}
	   	var option =new Option("--��ѡ��--","*");  
	   	document.form1.rBList.add(option); 
	    var option =new Option("�����԰�����","1");  
	   	document.form1.rBList.add(option); 
	   	var option =new Option("������","2");  
	   	document.form1.rBList.add(option); 
	   	var option =new Option("���ƴ���������","3");  
	   	document.form1.rBList.add(option); 
	   	//var option =new Option("�㲥ҵ��","4");  
	   	//document.form1.rBList.add(option); 
	}
else//����
	{
			var ln=document.form1.rBList.options.length;
      while(ln--)
      {
        	document.form1.rBList.options[ln] = null;
	   	}
	   	var option =new Option("--��ѡ��--","*");  
	   	document.form1.rBList.add(option); 
	   	var option =new Option("�����԰�����","1");  
	   	document.form1.rBList.add(option); 
	   	
	}
	
}	
function changeCreateFlag()
{
	var rbiztype = document.form1.biztype.value;
	
		if(rbiztype=="1")// �������
	{
		tabAddinfo.style.display="";
		document.getElementById("YYYY").style.display="";
		document.getElementById("XXXX").style.display="";
		document.getElementById("cylx1").style.display="none";

		accessNumberChg();
	}
	else{
		tabAddinfo.style.display="none";
		document.getElementById("YYYY").style.display="none";
		document.getElementById("XXXX").style.display="none";
		document.getElementById("cylx1").style.display="none";


	}
	
}


function getAccessModel()
{
	var j_bussId = $("#bussId").val();
	if(j_bussId.length!=10){
		rdShowMessageDialog("ҵ������ʽ����ȷ");
		$("#bussId").val("");
	}else{
		var yelx_sub = j_bussId.substring(6,8);
		if(yelx_sub!="51"&&yelx_sub!="52"&&yelx_sub!="53"&&yelx_sub!="54"){
			rdShowMessageDialog("ҵ�����Ͳ���ȷ");
			$("#bussId").val("");
		}else{
			 $("#yelx").val(yelx_sub);
		}
		
		var hybm_sub = j_bussId.substring(3,5);
		
		if($("#bizhybm_list").val().indexOf(hybm_sub)==-1){
			rdShowMessageDialog("��ҵ���벻��ȷ");
			$("#bussId").val("");
		}
		
	}
	
	
	document.all.accessModel.disabled=false;

changeBizCode();	
}

function changeBizCode(){
    var vBussId = document.form1.bussId.value;
	  vBussId=vBussId.substring(0,1);
    
    var packet = new AJAXPacket("fgetBizTypeL.jsp","���Ժ�...");
    packet.data.add("bizMode" ,vBussId);
    core.ajax.sendPacket(packet,doChangeBizCode,false);
    packet = null;
}

function doChangeBizCode(packet){
    var retCode = packet.data.findValueByName("retCode");
    var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
    
    if(retCode == "000000")
    {
		var backString = packet.data.findValueByName("backString");
     	var temLength = backString.length+1;
		var arr = new Array(temLength);
		arr[0] = "<option value=''>--- ��ѡ�� ---</option>";
		for(var i = 0 ; i < temLength-1 ; i ++)
		{
			arr[i+1] = "<OPTION value="+backString[i][0]+">" +backString[i][1] + "</OPTION>";
		}
		$("#bizTypeL").empty();
      	$(arr.join()).appendTo("#bizTypeL");
      	
      	$("#bizTypeS").empty();
      	$("<option value=''>--- ��ѡ�� ---</option>").appendTo("#bizTypeS");
	}
    else
    {
        rdShowMessageDialog("��ȡҵ�����ʧ��[������룺"+retCode+",������Ϣ��"+retMessage+"]",0);
		return false;
    }   
    
}

function changeBizTypeL(){
    var vBizTypeL = $("#bizTypeL").val();

    if(vBizTypeL == ""){
        $("#bizTypeS").empty();
      	$("<option value=''>--- ��ѡ�� ---</option>").appendTo("#bizTypeS");
      	return;
    }
    var vBussId = document.form1.bussId.value;
	vBussId=vBussId.substring(0,1);
    
    var packet = new AJAXPacket("fgetBizTypeS.jsp","���Ժ�...");
    packet.data.add("bizMode" ,vBussId);
    packet.data.add("bizTypeL" ,vBizTypeL);
    core.ajax.sendPacket(packet,doChangeBizTypeL,false);
    packet = null;
}

function doChangeBizTypeL(packet){
    var retCode = packet.data.findValueByName("retCode");
    var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
    
    if(retCode == "000000")
    {
		var backString = packet.data.findValueByName("backString");
     	var temLength = backString.length;
		var arr = new Array(temLength);
		for(var i = 0 ; i < temLength ; i ++)
		{
			arr[i] = "<OPTION value="+backString[i][0]+">" +backString[i][1] + "</OPTION>";
		}
		$("#bizTypeS").empty();
      	$(arr.join()).appendTo("#bizTypeS");
	}
    else
    {
        rdShowMessageDialog("��ȡҵ��С��ʧ��[������룺"+retCode+",������Ϣ��"+retMessage+"]",0);
		return false;
    }
}

function getBizType(bizTypeL,bizTypeS,bizYelx,bizhybm_list){
    //$("#trBizType").css("display","");
    $("#bizTypeL").empty();
    $("#bizTypeS").empty();
    $("<option value='"+bizTypeL.value+"'>"+bizTypeL.text+"</option>").appendTo("#bizTypeL");
    $("<option value='"+bizTypeS.value+"'>"+bizTypeS.text+"</option>").appendTo("#bizTypeS");
    
     $("#yelx").val(bizYelx);
     $("#bizhybm_list").val(bizhybm_list);
}
		//���
	function  queryMod(v_id)
	{				
			var str = "?operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + document.all.queryType.value+ "&parterName=" + document.all.spBizName.value;
			var url="f2889_mod.jsp" + str;
			window.open(url,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}
	
	//��ʾĳ��ҵ����Ϣ
	function showInfo(v_id)
	{  
        var str = "?operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + document.all.queryType.value+ "&parterName=" + document.all.spBizName.value;
        var path="f2889_showInfo.jsp" + str;
		window.open(path,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}

//��ֹ
function  queryModEnd(OprCode,v_id)
	{	
		var myPacket = new AJAXPacket("f2889_modEnd.jsp?OprCode="+OprCode+"&operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + v_id,"���ڻ����Ϣ�����Ժ�......");
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	}
  function doProcess(packet)
	{
		var errCode    = packet.data.findValueByName("errCode");
		var retMessage = packet.data.findValueByName("errMsg");//�������ص���Ϣ
		var retFlag    = packet.data.findValueByName("retFlag");

		if (errCode==0)
		{  
			if(retFlag=="queryModEnd")
			{			
				rdShowMessageDialog("�����ɹ���",2);
				window.parent.document.all.queryBusiBtn.onclick();
			}
		}else{
			rdShowMessageDialog(retMessage,0);	
		}
	}

//��������̬��
var addflag3 = 1;
function dynAdd3()
{
					var tr1=dyntb3.insertRow();
					tr1.bgcolor="F5F5F5";
	        tr1.id="tr";
	       	tr1.align="center";
	       
	 				tr1.insertCell().innerHTML = '<td><input type="text" name="tb3_col1"  v_type="string" v_must="1" v_minlength="1" v_maxlength="32" v_name="��ͨ��������" maxlength="32" value="" ></td>';
	 				tr1.insertCell().innerHTML = '<td><input type="text" name="tb3_col2"  v_type="string" v_must="1" v_minlength="1" v_maxlength="32" v_name="��ʾ����" maxlength="32" value="" ></td>';
	 				tr1.insertCell().innerHTML = '<td><input name="delbutton" class="button"  type=button value="ɾ��" onclick="dynDel3(this)" style="cursor:hand"></td>';
	addflag3++;
}

function dynDel3()
{
			var args=dynDel3.arguments[0];
			var objTD =args.parentElement;
			var objTR =objTD.parentElement;
			var currRowIndex = objTR.rowIndex;
			dyntb3.deleteRow(currRowIndex);  
			addflag3--;
}

function getBizCode()
{
	var accModel= document.form1.accessModel.value;
	window.open("getBizCode.jsp?biz_label=<%=bizLabel%>&accModel="+accModel,"","height=600,width=600,scrollbars=yes");
}

function chkwww(a)
{ 	  
	 var i=a.length;
   if(i>0)
   { 
		  var temp = a.indexOf('.');
		  var tempd = a.indexOf('.');
		  if (temp >= 1) {
		   if ((i-temp) > 3){
					if ((i-tempd)>1){
					  return 1;
					}
		   }
		  }
		       return 0;
		}
	return 1;
}

function getParamSet(flag)
{
    var pageTitle = "ҵ�����ѡ��";
    var fieldName = "��������|��������|";
    var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "";
    if (flag==1) {  
     	retToField="grpParamSet|grpParamSetName|";
    } 
    
    PubSimpSelParam_Set(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,flag);
}
function PubSimpSelParam_Set(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,flag)
{

 var path = "fqueryParamSet.jsp";
  path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
  path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
  path = path + "&selType=" + selType + "&retToField=" + retToField+ "&flag=" + flag;
    
  retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

  return true;
}

function PubSimpSelParam_Check()
{
	if(document.form1.bizCode.value.substring(6,8)=="21")
	{
		rdShowMessageDialog("wuxy");
	}
}

function getValueParamSet(retInfo,flag)
{
  if(retInfo ==undefined)      
    {   return false;   }
    
    if(flag==1)
      {  
     	retToField="grpParamSet|grpParamSetName|";
      }
   
     
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");        
    }
}

function changeAccModel(){
	document.form1.accessNumber.value="";
}
</script>


<body>

<form name="form1" method="post" action="">	
		<input type="hidden" name"OprCode" value="01" >
		<input type="hidden" name="queryType" value="<%=queryType.trim()%>">
		<input type="hidden" name="StartTime" value="">
		<input type="hidden" name="EndTime" value="">
		<input type="hidden" name="MOCode" value="">
		<input type="hidden" name="CodeMathMode" value="">
		<input type="hidden" name="MOType" value="">
		<input type="hidden" name="BaseServCodeProp" value="">
		<input type="hidden" name="ServCodeMathMode" value="">
		<input type="hidden" name="DestServCode" value="">
		<input type="hidden" name="bizType" value="">
		<input type="hidden" name="bizLabel" value="<%=bizLabel%>">
		<input type="hidden" name="accNum" value="">
		<input type="hidden" name="biztype" id="biztype" value="0" />
		<input type="hidden" name="bizhybm_list" id="bizhybm_list" value="" />
		
	<div id="Operation_Table">	
		
	<%
	if(colNameArr!=null)
 	{	
	%>
		<TABLE id="tabList" cellSpacing="0">			
	      	<TR id="line_1"> 
				<TD colspan="6" class="blue"><strong>ҵ����Ϣ</strong></TD>	            						    		            	              
	         </TR> 	
			<tr>				
				<th nowrap align='center'><div>ҵ�����</div></th>
				<th nowrap align='center'><div>EC/SI����</div></th>
				<th nowrap align='center'><div>ҵ������</div></th>
				<th nowrap align='center'><div>ҵ��״̬</div></th>
				<th nowrap align='center'><div>������ʽ</div></th>
			</tr>
	<%	
		int len = colNameArr.length;			

			for(int i = 0; i < len; i++)
			{		  
	
	%>			
			<tr id="tr<%=i+1%>">
				<input type="hidden" name="operId<%=i+1%>" value="<%=colNameArr[i][0].trim()%>">
				<input type="hidden" name="parterId<%=i+1%>" value="<%=colNameArr[i][1].trim()%>">

							
				<td nowrap align='center'><a style="CURSOR: hand; TEXT-DECORATION: none" href="javascript:showInfo(<%=i+1%>)"><%=colNameArr[i][0].trim()%></a></td>
				<td nowrap align='center'><%=colNameArr[i][1].trim()%></td>
				<td nowrap align='center'><%=colNameArr[i][2].trim()%></td>
				<td nowrap align='center'><%=colNameArr[i][3].trim()%></td>
				<td nowrap align='center'>
					<%
						String modend="";  		
						if("2".equals(queryType))
						{
							modend="disabled";
						}
						
					%>
					<input name="operator<%=i+1%>" style="cursor:hand" type="button" value="���" class="b_text" onclick="queryMod(<%=i+1%>)">	
					<input name="operator<%=i+1%>" <%=modend%> style="cursor:hand" type="button" value="��ֹ" class="b_text" onclick="queryModEnd('02',<%=i+1%>)" >	
				</td> 
			</tr>
	<%
		}
	%>
		</TABLE>
<%}%>		
     		
		<TABLE id="tabBusiAdd" style="display:none" cellSpacing="0"> 
			<TR id="line_1"> 
				<TD colspan="5" class="blue"><strong>�½�ҵ����Ϣ</strong></TD>	            						    		            	              
	         </TR> 	         
             <TR id="line_1">
	            	<input type="hidden" name="svrCode" maxlength="4" value="ADXX" v_type="string" v_must="1" v_minlength="4" v_maxlength="4" v_name="�������" >
	              	<input type="hidden" name="spId" readonly v_type="string" v_must="1" v_minlength="1" v_maxlength="6" v_name="��ҵ����" maxlength="6" value="<%=parterId%>" >
				    <input type="hidden"  name="spBizName" v_type="string" v_must="1" v_minlength="1" v_maxlength="256" v_name="��ҵ����" maxlength="256" value="<%=parterName%>" >
				  
				<TD class="blue" >ҵ�����</TD>
	            <TD>
	            	<input type="text" name="bussId" id="bussId" v_type="string" v_must="1" v_minlength="1" v_maxlength="10"  maxlength="10"  onChange='getAccessModel()'><font color="orange">*</font>
	              	<input type="hidden" name="bizCode" readonly v_type="string" v_must="0" v_minlength="0" v_maxlength="18" maxlength="18" value="" >
	                <input name="bizCodeButton" style="cursor:hand" type="button" class="b_text" value="����" onClick="getBizCode()">
	            </TD> 	
	            <TD colspan="2" class="blue" >ҵ������</TD>
	            <TD>
	              	<input type="text" name="bizName"  v_type="string" v_must="1" v_minlength="1" v_maxlength="256"  maxlength="256" value="" >&nbsp;<font color="orange">*</font>	
	            </TD>	
	                    								    		            	              
	         </TR>
	          <TR id="trBizType" style="display:">
							<TD class="blue" >ҵ�����</TD>
						    <TD>
						        <select id="bizTypeL" name="bizTypeL" onChange="changeBizTypeL()">
						            <option value=''>---��ѡ��---</option>
						        </select>
						    </TD> 	
						    <TD class="blue" colspan="2">ҵ��С��</TD>
						    <TD>
						        <select id="bizTypeS" name="bizTypeS">
						            <option value=''>---��ѡ��---</option>
						        </select>
						    </TD>	         								    		            	              
						 </TR>
 
	         <TR id="line_1"> 
	         	 
				<TD class="blue" >����ģʽ</TD>
	            <TD>
	           		 <select id="accessModel" name="accessModel" onChange="changeAccModel()">
      					<option value='01'>SMS</option>
      					<option value='02'>MMS</option>
      					<option value='03'>WAP</option>
      					<option value='04'>����</option>
	              	</select>	             
	            </TD>	
	            <TD class="blue" colspan="2">��������� </TD>
	            <TD>
	            		
	              	<input type="text" id="accessNumber" name="accessNumber"  v_type="string" v_must="1"  maxlength="21" v_name="���������"  value=""  readOnly>
	              	<input type="button" name="checkFatherBtn1" value="ѡ��" class="b_text" onClick="getBaseCode()" >&nbsp;<font color="#FF0000">*</font>
									
	            </TD>        		            	              
	         </TR>
	         
	         <TR id="YYYY" name="YYYY" class="YYYY">
					<TD class="blue" >�Ʒ�����</TD>
	            <TD>
	            	<select name="billingType"  onchange="changeRBList()">
          					<option value='00'>���</option>
          					<option value='01'>����</option>
          					<%/*%>
          					<option value='02'>����</option>
          					<%*/%>
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>
				<TD class="blue" colspan="2">���� </TD>
	            <TD>
	              	<input type="text" name="price" v_type="0_9" v_must="1" v_minlength="1" v_maxlength="9" maxlength="9" value="0" >&nbsp;<font color="orange">*</font>	
	            (Ԫ)
	            </TD>	         								    		            	              
	         </TR>
	         
	         
	         <TR id="line_1">
	         	
	         	<TD class="blue" >��Чʱ��</TD>
	            <TD>
	              	<input type="text" name="oprEffTime" v_type="date" value="<%=strDate%>" >&nbsp;<font color="orange">*</font>
	            </TD>	
	            <TD class="blue" colspan="2">�������� </TD>
	            <TD>
	            	<select name="netAttr">
	            		<option value='*'>--��ѡ��--</option>
	            		<%
	            		
	            		if(netArr!=null) {
		            		for(int i = 0; i < netArr.length; i++)
										{		  
		            		%>
          					<option value="<%=netArr[i][0]%>"><%=netArr[i][1]%></option>
          			<%	}
          			}else
          				{
          				%>
          				<option ></option>
          				<%
          				}
          			%>	
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>	  			         								    		            	              
	         </TR>

	         <TR id="line_1"> 
				
	    				<!--
	          	<TD class="blue" >ҵ�񿪷���� </TD>
	            <TD >
	            <select id="biztype" style="width:133px;"  onchange="changeCreateFlag()" >
          			<%
	            if("2".equals(queryType)){
	              %>
	              
          					<option value='0'>����EC</option>
          					<option value='1'>�������</option>
          			<%
	              }
	            else{
	              %>
	              <option value='0'>����EC</option>
	              <%
	               }
	              %>

          			
	            </TD> 
	            -->
	         	<TD class="blue" >ҵ��״̬</TD>
	            <TD >
	            	<select name="bizStatus">
	  					<option value='A'>��������</option>
	  					<option value='S'>�ڲ�����</option>
	  					<option value='T'>���Դ���</option>
	  					<option value='R'>������</option>
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>
						 
							
							 <TD class="blue" colspan="2">ҵ������ </TD>
	            <TD>
	            	<select name="yelx" id="yelx">
					   				<option value="51" >�ڲ�������</option>
					   				<option value="52" >�ⲿ������</option>
					   				<option value="53" >Ӫ���ƹ���</option>
					   				<option value="54" >������</option>
								</select>
								<font color="orange">*</font>						
	            </TD>	  			    
	         </TR>
	         <TR id="XXXX" name="XXXX" class="XXXX"> 	         	
						<TD class="blue" >ҵ������ </TD>
		            <TD  <%if("MAS".equals(bizLabel)){%>colspan="4"<%}%>>
		            	<select name="rBList"  onchange="changeCF()">
	      					<option value='1'>�����԰�����</option>
	          			<option value='2'>������</option>
	          			<option value='3'>���ƴ���������</option>
	          			<% /* <option value='4'>�㲥ҵ��</option> */ %>
		              	</select>&nbsp;<font color="orange">*</font>
		            </TD>
		          <%if(!"MAS".equals(bizLabel)){%>
		          		<TD class="blue" >�����·�����</TD>
			            <TD colspan="2">
			           		<input type="text" name="LimitAmount" v_name="�����·�����" v_type="0_9"   >
			            </TD> 
		          <%}%>
	         </TR>
			     <TR>
			     	<TD class="blue" >�������� </TD>
	          	<TD  <%if("ADC".equals(bizLabel)){%>colspan="4"<%}%>>
					<input name="grpParamSet" type="hidden" value="<%=grpParamSet%>" size="16" maxlength=8 readonly v_type="string">
					<input name="grpParamSetName" type="text" value="<%=grpParamSetName%>" size="16" v_must="1" class="InputGrey" maxlength=8 readonly v_type="string">
					<input type="button" class="b_text" name="checkFatherBtn1" value="��ѯ" onClick="getParamSet(1)" >&nbsp;<font color="orange">*</font>
	        </TD>	
	        <%if(!"ADC".equals(bizLabel)){%>
	          <TD class="blue">ҵ�����ȼ�</TD>
	            <TD colspan="2">
	              	<select name="bizPRI">
	           		 	<option value='00'>00</option>
	      					<option value='01'>01</option>
	      					<option value='02'>02</option>
	      					<option value='03'>03</option>
	      					<option value='04'>04</option>
	      					<option value='05'>05</option>
	      					<option value='06'>06</option>
	      					<option value='07'>07</option>
	      					<option value='08'>08</option>
	      					<option value='09'>09</option>
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>	  	
	         <%}%>
         </TR>
         <TR id="cylx1" name="cylx1" >
         	<TD class="blue"  >��Ա���� </TD>
		            <TD  colspan="4">
		           		 <select name="CreateFlag">
	           		 		<option value='*'>--��ѡ��--</option>
	      					<option value='0'>B-C/P��</option>
	      					<option value='1'>B-E/M��</option>
		              	</select>&nbsp;<font color="orange">*</font>
		            </TD>	 
         
	        </TR> 
	         <TR id="line_1">	         	
				<TD class="blue" >SIProvision��URL</TD>
	            <TD colspan="4">
	              	<input type="text" name="provURL" maxlength="128" value="http://" size="60">&nbsp;&nbsp;(��120���ַ�)
	            </TD>	         								    		            	              
	         </TR>
	         
	         <TR id="line_1">
	         	<TD class="blue" >ʹ�÷�������</TD>
	            <TD colspan="4">
	              	<input type="text" name="usageDesc" v_type="string"  v_minlength="1" v_maxlength="512"  maxlength="512" value="" size="60">&nbsp;&nbsp;(��500���ַ�)	
	            </TD> 					         								    		            	              
	         </TR>
	         
	         <TR id="line_1">	         	 
				<TD class="blue" >ҵ�������ַ</TD>
	            <TD colspan="4" >
	              	<input type="text" name="introURL" maxlength="128" value="http://" size="60">&nbsp;&nbsp;(��120���ַ�)
	            </TD>	         								    		            	              
	         </TR>
	         

	         
		</TABLE>	      
 

	        <TABLE id="tabAddinfo" style="display:none" width="100%" border=0 align="center" cellSpacing=0 bgcolor="#EEEEEE"> 
	         	<TR bgcolor="#F5F5F5" id="line_1">
	         		<TD class="blue" >�Ƿ�Ԥ����ҵ��</TD>
	            <TD >
	           		 <select name="isPrepay" style="width:133px;">
          					<option value='0'>��</option>
          					<option value='1'>��</option>
	              	</select>
	            </TD>
	            <TD class="blue" >ȱʡǩ�����ԣ�</TD>
	            <TD >
	           		 <select name="defaultSign" style="width:133px;">
          					<option value='1'>����</option>
          					<option value='2'>Ӣ��</option>
	              	</select>
	            </TD>
	            
	            </TR>
	         	<TR bgcolor="#F5F5F5" id="line_1">
	         		<TD class="blue" >Ӣ������ǩ����</TD>
	            <TD >
	           		<input type="text" name="TextSignEn" v_type="string"  ><font color="#FF0000">*</font>
	            </TD>
	            <TD class="blue" >��������ǩ����</TD>
	            <TD >
	           		 <input type="text" name="TextSignZh" v_type="string"  ><font color="#FF0000">*</font>
	            </TD>
	              </TR>	
	            <TR bgcolor="#F5F5F5" id="line_1">
	         		<TD class="blue" >�Ƿ�֧������ǩ����</TD>
	            <TD >
	           		 <select name="ISTextSign" style="width:133px;">
          					<option value='0'>��֧��</option>
          					<option value='1'>֧��</option>
	              	</select>
	            </TD>
	            <TD class="blue" >ҵ�����ż�Ȩ��ʽ��</TD>
	            <TD >
	           		 <select name="AuthMode" style="width:133px;">
          					<option value='0'>��ȷƥ��</option>
          					<option value='1'>ģ��ƥ��</option>
	              	</select>
	            </TD>	
	         	</TR>	
	         	<TR bgcolor="#F5F5F5" id="line_1">
	         		<TD class="blue" >ÿ���·������������</TD>
	            <TD >
	           		<input type="text" name="MaxItemPerDay" v_name="ÿ���·����������" v_type="0_9"  ><font color="#FF0000">*</font>
	            </TD>
	            <TD class="blue" >ÿ���·������������</TD>
	            <TD >
	           		 <input type="text" name="MaxItemPerMon" v_name="ÿ���·����������" v_type="0_9"  ><font color="#FF0000">*</font>
	            </TD>
	              </TR>	

	             <TR bgcolor="#F5F5F5" id="line_1">	         	 
				   <TD class="blue"  >�������·�ʱ����б�</TD>
	              <TD colspan="3" >
	              	<input type="text" name="InvalidTimeSpanList" maxlength="128" value="" size="60" readOnly>&nbsp;
	              	<input type="button" class="b_text" name="setTimeBtn1" value="����" onClick="setTime()" >&nbsp;
	                </TD>	
	                        								    		            	              
	         </TR>
	         <TR bgcolor="#F5F5F5" id="line_1">	         	 
				   <TD class="blue" >����ҵ��ָ�</TD>
	              <TD colspan="3" >
	              	<input type="text" name="MOList" maxlength="128" value="" size="60" readOnly>&nbsp;
	              	<input type="button" class="b_text"  name="setMOBtn1" value="����" onClick="setMO()" >&nbsp;
	                </TD>	
	                       								    		            	              
	         </TR>
	         </TABLE>	 
 
		<TABLE id="tabAddBtn" style="display:''" cellSpacing="0">
			 <TR> 
	         	<TD align="center"> 		         	    
	         	    <input name="addBtn" style="cursor:hand" type="button" class="b_text" value="����ҵ����Ϣ" onClick="showAddBusiInfo()">
	         	    &nbsp;
			 	</TD>
	       </TR>
	    </TABLE>
	    
	    <TABLE id="tabAddSubmitBtn" style="display:none" cellSpacing="0">
			 <TR> 
	         	<TD id="footer" align="center"> 		         	    
	         	    <input name="addSubmitBtn" style="cursor:hand" type="button" class="b_foot" value="�� ��" onClick="addCfm()">
	         	    &nbsp;
					<input type="reset" name="reset" value="�� ��"  style="cursor:hand" class="b_foot" onClick="resetPage()" >
			 	</TD>			 	
	       </TR>
	    </TABLE>
	    <script>
	     changeRBList();
	    </script>
	 	   	
	</div>   
</form>
</body>
</html>


<%
 /**
 * version v2.0
 * ������: si-tech
 * author: huangrong
 * date  : 20101103
 **/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>

<%@ page import="java.io.*" %>

<%
    String opCode = "b882";
    String opName = "ʡ���ֶһ���Ʒ";
    
    String workNo = (String)session.getAttribute("workNo");
    String nopass = "111111";
    String OrgCode = (String)session.getAttribute("orgCode");
    String regionCode = (String)session.getAttribute("regCode");
		String op_code = " ";
    String ip_Addr = (String)session.getAttribute("ipAddr");
		String phoneNo = (String)request.getParameter("activePhone");
    /* ҵ����� */
    String passflag = "0";

    //�Ż���Ϣ
    //String[][] favInfo = (String[][])arr.get(3);   //���ݸ�ʽΪString[0][0]---String[n][0]
    String[][] favInfo = (String[][])session.getAttribute("favInfo"); //�Żݴ���Ϊ����
    String tempStr = "";
    String passValue ="";
    String smCode="";
    String itemPoints="";
    String itemState="";
    String itemNumber="";
    
    String card_name="";//���������� huangrong add
    String card_type="";//������ huangrong add    
    //begin add by diling for ������Ȩ������ @2012/3/13 
    boolean pwrf = false;
	  String pubOpCode = opCode;
%>
	  <%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
    System.out.println("==������======fb882.jsp==== pwrf = " + pwrf);
    if(pwrf){
        passflag = "1";  
    }
    //end add by diling for ������Ȩ������ @2012/3/13 
    
    if(passflag.equals("0")){
         Map map = (Map)session.getAttribute("contactInfoMap");
		     ContactInfo contactInfo = (ContactInfo) map.get(activePhone);
         passValue=contactInfo.getPasswdVal(2);
    }
    
    String printAccept="";
		printAccept = getMaxAccept();
		System.out.println(printAccept);

	String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
//******************�õ�����������***************************//	
	 //����
 	String cityNameStr = " select cityid,cityname from oneboss.TOBMARKADDRINFO group by cityid,cityname";

  //����
  String districtNameStr = "select cityid,districtid,districtname from oneboss.TOBMARKADDRINFO";
	//С����Ʒ
	String subTypeSql="select subtype from dbcustadm.TOBMARKCHANGEMSG group by subtype";
	String smCodeSql="select sm_code from dcustmsg where phone_no='"+activePhone+"'";
	//paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
	//begin huangrong add ��ȡ�û�����
	String brandSql="select card_name, card_type  from sBigCardCode where card_type=(select substr(attr_code,3,2) from dcustmsg where phone_no='"+activePhone+"')";
%>

<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg4" retcode="code4" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=cityNameStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="cityNameString" scope="end"/>

<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg5" retcode="code5" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=districtNameStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="districtNameString" scope="end"/>

    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
    <wtc:sql><%=prtSql%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="paraStr" scope="end"/>
		
	
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3" outnum="1">
    <wtc:sql><%=subTypeSql%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="subTypeStr" scope="end"/>
		
	 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">
    <wtc:sql><%=smCodeSql%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="smCodeStr" scope="end"/>	
<%
    System.out.println("paraStr[0][0]---SysAccept==========" +paraStr[0][0]);
    if(retCode2.equals("0")||retCode2.equals("000000"))
    {
			if(smCodeStr.length>0)
			{
				smCode=smCodeStr[0][0];
				if(smCode=="gn" || smCode.equals("gn"))
				{
					op_code="1250";
				}
			  else if(smCode=="dn" || smCode.equals("dn"))
		  	{
		  		op_code="1299";
		  	}
		  	 else if(smCode=="zn" || smCode.equals("zn"))
		  	 {
		  	 op_code="1250";
		  	 }
		  	 else
	  		{
%>
					<SCRIPT type=text/javascript>
						rdShowMessageDialog("���û���ȫ��ͨ�������л��߶��еش��û������ܰ����ҵ��");
						parent.removeTab('<%=opCode%>');	
					</SCRIPT>
<%	  			
	  		}
			}
		}
%>


	 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4" outnum="2">
    <wtc:sql><%=brandSql%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="brandSqlStr" scope="end"/>	
<%
    if(retCode4.equals("0")||retCode4.equals("000000"))
    {
			if(brandSqlStr!=null && brandSqlStr.length>0)
			{
				card_name=brandSqlStr[0][0];
				card_type=brandSqlStr[0][1];
			}
		}
%>		

<%
		String[] inParams = new String[2];
		String getCitySql = "SELECT case "
								         +" when a.ilevel = '0' then '12'"
								         +" when a.ilevel = '1' then '11'"
								         +" when a.ilevel = '2' then '10'"
								         +" when a.ilevel = '3' then '09'"
								         +" when a.ilevel = '4' then '08'"
								         +" when a.ilevel = '5' then '07'"
								         +" when a.ilevel = '6' then '06'"
								         +" when a.ilevel = '7' then '05'"
								         +" else '13'"
								       +" end"
								  +" FROM dCustLevel a, dcustmsg c"
								 +" WHERE a.id_no = c.id_no"
								   +" and c.phone_no = :phoneNo"
								   +" and sysdate between a.eff_time and a.exp_time";
		inParams[0] = getCitySql;
		inParams[1] = "phoneNo=" + phoneNo;
%>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg0" retcode="code0" outnum="1">
			<wtc:param value="<%=inParams[0]%>"/>
			<wtc:param value="<%=inParams[1]%>"/>
		</wtc:service>
		<wtc:array id="result0" scope="end" />
		
<%
		String starLevel = "13";

		if("000000".equals(code0)){
			if(result0 != null && result0.length > 0){
				starLevel = result0[0][0];
			}
		}
		
		System.out.println(" === ningtn sb882 starLevel " + starLevel);
%>

<HEAD><TITLE>ʡ������Ʒ�һ�</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META http-equiv=Content-Type content="text/html; charset=gb2312">

<SCRIPT type=text/javascript>
	var city_Id = new Array();
	var district_Id = new Array();
	var district_Name = new Array();
	<%
  for(int i=0;i<districtNameString.length;i++)
  {
	out.println("city_Id["+i+"]='"+districtNameString[i][0]+"';\n");
	out.println("district_Id["+i+"]='"+districtNameString[i][1]+"';\n");
	out.println("district_Name["+i+"]='"+districtNameString[i][2]+"';\n");
  }
  %>
	
/****************���ݵ��ж�̬��������������************************/
 function selectChange(control, controlToPopulate, districtName, cityId)
 {
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values

   myEle = document.createElement("option") ;
   myEle.value = "";
   myEle.text ="--��ѡ��--";
   controlToPopulate.add(myEle) ;
   for ( x = 0 ; x < districtName.length  ; x++ )
   {
      if ( cityId[x] == control.value )
      {
        myEle = document.createElement("option") ;
        myEle.value = district_Id[x];
        myEle.text = districtName[x] ;
        controlToPopulate.add(myEle) ;
        document.all.type_code.value=district_Id[x];
      }
   }
 }

onload=function(){
	
}

//---------1------RPC������------------------
function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    var retMessage = packet.data.findValueByName("retMessage");

    //--------------------------------
    if(retType == "call_s1250Init")
    {
        //��ȡԭ�п�������
        if(retCode=="000000")
        {
            var iCount = packet.data.findValueByName("iCount");
            var retFavourCode = packet.data.findValueByName("FavourCode");
            var retCust_name = packet.data.findValueByName("Cust_name");
            var retRun_name = packet.data.findValueByName("Run_name");
            var retSm_name = packet.data.findValueByName("Sm_name");
            var retId_name = packet.data.findValueByName("Id_name");
            var retId_iccid = packet.data.findValueByName("Id_iccid");
            var retGrade_code = packet.data.findValueByName("Grade_code");
            var retGrade_name = packet.data.findValueByName("Grade_name");

            var retCurrent_point = packet.data.findValueByName("Current_point");
            var higmsg=packet.data.findValueByName("higmsg");
            var id_address=packet.data.findValueByName("id_address");

            document.frm.custName.value = retCust_name;
            document.frm.status.value = retRun_name;
            document.frm.itemPoint.value = retCurrent_point;
            document.frm.present_point.value = retCurrent_point;
            
            document.frm.idType.value = retId_name;
            document.frm.idIccid.value = retId_iccid;
            document.frm.Ed_Sm_name.value = retSm_name;
            document.frm.Ed_Grade_name.value = retGrade_name;
            
            document.all.custRegCode.value = packet.data.findValueByName ( "custRegCode" );
            document.all.custRegName.value = packet.data.findValueByName ( "custRegName" );
            if(higmsg>0){rdShowMessageDialog("���û�Ϊ�и߶��û�!");}
        }
        else
        {
            retMessage = retMessage + "[errorCode:" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
        }
    }
   	if(retType == "call_queryGift")
  	{  
  		var hs=packet.data.findValueByName("hs");
  		var tab=document.getElementById("dyntb");
  		var tr=tab.rows[hs];
  		var tds=tr.childNodes;
  		var jfz=tds[2].innerHTML;
  		var sls=tds[5].childNodes[0].value;
  		
  			var present_point=document.frm.present_point.value;
    		present_point=Number(present_point);
    		present_point=present_point-Number(sls)*Number(jfz);
    		document.frm.present_point.value=present_point;

  		if(retCode=="000000")
        {
            var cd = packet.data.findValueByName("cd");
            if(cd>0)
            {
            	var itemPoints=packet.data.findValueByName("itemPoints");
            	var itemState=packet.data.findValueByName("itemState");
            	var itemNumber=packet.data.findValueByName("itemNumber");
            
            	if ( itemNumber == -1 )
            	{

					if(present_point>0)
					{
									//is_reCode();
									//gono_change();
									rdShowMessageDialog("��֤ͨ����");		
						
					}else
					{
						rdShowMessageDialog("���ֲ��㲻�ܶһ���");
						//document.frm.flag.value="0";	
					}
            	}
            	else
            	{
	            	if(Number(itemNumber)< Number(sls))
		            {
						rdShowMessageDialog("��Ʒ�������"+sls+",����ٶһ�������");
						return false;
		            }
		            else
	            	{	
	
						if(present_point>0)
						{
										//is_reCode();
										//gono_change();
										rdShowMessageDialog("��֤ͨ����");		
							
						}else
						{
							rdShowMessageDialog("���ֲ��㲻�ܶһ���");
							//document.frm.flag.value="0";	
						}
	            	}
            	}
            } 
        }
        else
        {
        		//document.frm.flag.value="0";	
            retMessage = retMessage + "[errorCode:" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
            tab.deleteRow(tr.rowIndex);
        }
  		
  	}	
   // huangrong add 	��ȡ�ж϶һ���Ϣ�Ƿ�Ϊ�ֻ����ķ�����Ϣ�ͶԵ�ǰ�һ���Ϣ��Ȩ 2011-5-20   	
   	if(retType == "call_isPaperOpraAndValidate")     
   {
   	

  		if(retCode=="000000")
      {
        var hs=packet.data.findValueByName("hs");
	  		var tab=document.getElementById("dyntb");
	  		var tr=tab.rows[hs];
	  		var tds=tr.childNodes;
	  		var sls=tds[5].childNodes[0].value;//�һ�����
	  		var code=tds[0].innerHTML;//�һ�����
				document.frm.codes.value =code;
				document.frm.numbers.value =tds[5].childNodes[0].value;
				
				 var isPaperFlag = packet.data.findValueByName("isPaperFlag");

         if(Number(isPaperFlag)>0)
      		{
      			
      			if(Number(sls)>1)
      			{
      				rdShowMessageDialog("�һ���ƷΪ�ֻ�������˶һ�����ֻ����1��");
      				tds[5].childNodes[0].value="1";
      			}
    				tds[6].childNodes[2].value="1";  
      		}else
			{
				tds[6].childNodes[2].value="0";  
			}
    		var is_flag=is_reCode();	//��֤�Ƿ���ڲ���ͬʱ�һ�����Ʒ
    		if(is_flag==true)
    		{

					var queryGift_Packet = new AJAXPacket("queryGift.jsp","������֤��Ʒ�����Ժ�......");
					queryGift_Packet.data.add("retType","call_queryGift");
					queryGift_Packet.data.add("hs",hs);
					queryGift_Packet.data.add("codes",document.frm.codes.value);
					queryGift_Packet.data.add("op_code","<%=opCode%>");
					queryGift_Packet.data.add("phone_no",document.frm.phoneNo.value);
					queryGift_Packet.data.add("user_pass",document.frm.Ed_UserPass.value);
					queryGift_Packet.data.add( "custRegCode" , document.frm.custRegCode.value );
					queryGift_Packet.data.add( "custDisCode" , document.frm.custDisCode.value );
					core.ajax.sendPacket(queryGift_Packet);
					queryGift_Packet=null;   			
    		}else
  			{
				  		var tab=document.getElementById("dyntb");
				  		var tr=tab.rows[hs];
				  		var tds=tr.childNodes;
				  		var butt=tds[6].childNodes[0];		  		
				  		butt.disabled=false;
  			}
      }else
      {
      		//document.frm.flag.value="0";	
          retMessage = retMessage + "[errorCode:" + retCode + "]";
          rdShowMessageDialog(retMessage,0);
          tab.deleteRow(tr.rowIndex);
      }
  	}
   
   
   
}

//huangrong add 2011-5-21 �ж��Ƿ���ڶһ���Ʒ����ͬʱ��������
function is_reCode()
{
  var tab=document.getElementById("dyntb");
	var trs=tab.rows;
	var changdu=trs.length;
	if(changdu>3)
	{	
		var num="0";//��ʶ��0��ʶû�в���ͬʱ�һ�����Ʒ��1����ʶ�һ�һ�����ϡ�ȫ��ͨ����ܿ�����2��ʶ�һ�һ�����ϡ�ȫ��ͨ��˹۲졷
		//�������е��У���ȡ�һ���Ʒ��id
		for(var i=2;i<changdu;i++)
		{  
			var first_tds=trs[i].childNodes; 		
			var first_gift_id=first_tds[0].innerHTML//��Ʒid																						
			if(first_gift_id=="358470" || first_gift_id=="358471" || first_gift_id=="358472" || first_gift_id=="358473")
			{
				for(var j=i+1;j<changdu;j++)
				{
					var tds=trs[j].childNodes; 
					var gift_id=tds[0].innerHTML//��Ʒid	
					if(first_gift_id=="358470" && (gift_id=="358470" || gift_id=="358471"))
					{
						num="1";													
					}else	if(first_gift_id=="358472" && (gift_id=="358472" || gift_id=="358473"))
					{
						num="2";														
					}
				}	
			}
      for(var j=i+1;j<changdu;j++)
			{
				var tds=trs[j].childNodes; 
				var gift_id=tds[0].innerHTML//��Ʒid	
				if(first_gift_id==gift_id)
				{
					num="3";													;														
				}
			}																			
		}	
		if(num=="1")
		{
			rdShowMessageDialog("���ܶһ�һ�����ϡ�ȫ��ͨ����ܿ�������ɾ��һ����");
			return false;			
		}else if(num=="2")
		{	
			rdShowMessageDialog("���ܶһ�һ�����ϡ�ȫ��ͨ��˹۲졷����ɾ��һ����");							
			return false;				
		}else if(num=="3")
		{	
			rdShowMessageDialog("�һ��б��в��ܳ����ظ��Ķһ���¼������Ҫ�һ���2�����ϣ���ֱ���޸Ķһ���������ɾ��һ����");							
			return false;				
		}else
		{
			return true;				
		}

	}else
	{
			return true;		
	}
}



function s1250Init()
{
    //��ȡԭ�п�������
    if (checkPhone() != true)
    {
        return false;
    }
   
    document.frm.phoneNo.readOnly=true;
    document.frm.tmp_phone_no.value=document.frm.custName.value;
     
    var s1250Init_Packet = new AJAXPacket("fb882_chk.jsp","������֤���룬���Ժ�......");
    s1250Init_Packet.data.add("retType","call_s1250Init");
    s1250Init_Packet.data.add("region_code","<%=regionCode%>");
    s1250Init_Packet.data.add("OrgCode","<%=OrgCode%>");
    s1250Init_Packet.data.add("op_code","<%=op_code%>");

    s1250Init_Packet.data.add("phone_no",document.frm.phoneNo.value);
    s1250Init_Packet.data.add("user_pass",document.frm.Ed_UserPass.value);
    s1250Init_Packet.data.add("PassFlag","<%=passflag%>");
    
    core.ajax.sendPacket(s1250Init_Packet);
    s1250Init_Packet=null;
}

function checkPhone()
{
    var password_flag = "<%= passflag %>";   
    if(document.frm.phoneNo.value == "")
    {
        rdShowMessageDialog("�������ֻ����룡",0);
        document.frm.phoneNo.focus();
        return false;
    }
    if(checkElement(document.frm.phoneNo) == false)
		return false;
    return true;
}


 function getInfo_code()
{
	if((document.frm.itemPoint.value).length==0)
	{
		    rdShowMessageDialog("���ȵ����֤��ť����֤�û���Ϣ��");
        return false;
	}
	var regionCode = "<%=regionCode%>";
	var pageTitle = "�һ���Ʒѡ��";
	var fieldName = "��Ʒ����|��Ʒ����|����ֵ|����|С��|";//����������ʾ���С�����
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "5|0|1|2|3|4|";//�����ֶ�
	var retToField = "giftCode|giftName|Item_Ponint|Main_Type|subType|";//���ظ�ֵ����
//huangrong update sqlStr	
// ningtn SQLע�����
	var sqlStr ="";
	document.all.flag_sql.value=sqlStr;
	//rdShowMessageDialog(document.all.OLD_PROJECT_TYPE.value);
	
	var starLevel			= '<%=starLevel%>';
	var giftCode			= document.all.giftCode.value;
	var giftName			= document.all.giftName.value;
	var subType				= document.all.subType.value;
	var accountMark		= document.all.accountMark.value;
	var sortType			= document.all.sortType.value;
	var present_point	= document.all.present_point.value;
	
	if(MySimpSel(pageTitle,fieldName,codeChg(sqlStr),selType,retQuence,retToField,80,starLevel,giftCode,giftName,subType,accountMark,sortType,present_point));
	//document.all.do_note.value = "ͳһԤ�����񣬷������룺"+document.all.Gift_Code.value;
	// rdShowMessageDialog(document.all.OLD_PROJECT_TYPE.value);
}

function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth,starLevel,giftCode,giftName,subType,accountMark,sortType,present_point)
{
    var path = "<%=request.getContextPath()%>/npage/sb881/fb882Sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&starLevel=" +starLevel;
    path = path + "&giftCode=" +giftCode;
    path = path + "&giftName=" +giftName;
    path = path + "&subType=" +subType;
    path = path + "&accountMark=" +accountMark;
    path = path + "&sortType=" +sortType;
    path = path + "&present_point=" +present_point;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    
    if(retInfo ==undefined)
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
  	var tab=document.getElementById("dyntb");
  	var tr=tab.insertRow();    
    while(chPos_field > -1)
    {
    	  var td=tr.insertCell();  
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        td.innerHTML=valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
    }
//��������  
var td1=tr.insertCell(); 
var tex=document.createElement("<input type=text name=sl>");
tex.onblur=function()
{
	if(this.value=="" || isNaN(this.value)||this.value=="0")
	{
		rdShowMessageDialog("�һ���Ʒ��������Ϊ�գ��������Լ�0��ϵͳĬ������Ϊ1");
		this.value="1";
		this.focus();
	}
}
tex.onfocus=function()
{
	var tr=this.parentNode.parentNode;
	var td=tr.childNodes[6];
	var yz=td.childNodes[0];
	if(yz.disabled)
	{
//			var tr=this.parentNode.parentNode;
			var tds=tr.childNodes;
			var jf=tds[2].innerHTML;
			var t=tds[5].childNodes;
			var sls=t[0].value;
			var present_point=document.frm.present_point.value;
			present_point=Number(present_point);
			present_point=present_point+Number(jf)*Number(sls);
			document.frm.present_point.value=present_point;
			yz.disabled=false;
			document.frm.flag.value="0"//��� �ύ��������1�������ύ�������0�������ύ��
	}
}
tex.value="1";
//begin huangrong add �жϵ�ǰ��ѡ��Ķһ���Ϣ��SITEMCORRECFG���Ƿ���� 2011-5-20 


function isPaperOpr(bing,returnType)
{   
	var tr=bing.parentNode.parentNode;
	var tds=tr.childNodes;
	var t=tds[5].childNodes;	
	var hs=tr.rowIndex;//���ڵ���
	document.frm.codes.value =tds[0].innerHTML;//�����жһ�����Ʒ���
	var isPaperOpr_Packet = new AJAXPacket("isPaperOpr.jsp","������֤��Ʒ�����Ժ�......");
	isPaperOpr_Packet.data.add("retType",returnType);
	isPaperOpr_Packet.data.add("hs",hs);
	isPaperOpr_Packet.data.add("codes",document.frm.codes.value);
	core.ajax.sendPacket(isPaperOpr_Packet);
	isPaperOpr_Packet=null;
}
//end huangrong add �жϵ�ǰ��ѡ��Ķһ���Ϣ��SITEMCORRECFG���Ƿ���� 2011-5-20  
var butt=document.createElement("<input type=button name=yz class=b_text>");
butt.value="��֤";
butt.onclick=function()
{
	
  queryGift(this);
}
var td2=tr.insertCell(); 
var butt2=document.createElement("<input type=button name=butt class=b_text>");
butt2.value="ɾ��";
//butt2.disabled=true;
butt2.onclick=function()
{
	var opFlag=document.frm.opFlag;
  opFlag[0].checked=false ;
  opFlag[1].checked=false;
	var tr=this.parentNode.parentNode;
	var tds=tr.childNodes;
	var jf=tds[2].innerHTML;
	var t=tds[5].childNodes;
	var sls=t[0].value;
	var yz=this.parentNode.childNodes[0];
	
	if(yz.disabled)
	{
		if(document.frm.flag.value="1")
		{
			var present_point=document.frm.present_point.value;
			present_point=Number(present_point);
			present_point=present_point+Number(jf)*Number(sls);
			document.frm.present_point.value=present_point;
		}

	}
	    tab.deleteRow(tr.rowIndex);
	    is_reCode();
} 
//huangrong add 2011-5-21  ���еĵ�4�в����ı��򣬴�������Ƿ��Ƕһ��ֻ���ҵ��0�����ǣ���1��Ϊ�ֻ���ҵ��Ĭ����0     
var texflag=document.createElement("<input type=hidden name=isFlagPaper>");
texflag.value="2";

//end add ���еĵ�4�в����ı��򣬴�������Ƿ��Ƕһ��ֻ���ҵ��0�����ǣ���1��Ϊ�ֻ���ҵ��Ĭ����0     
td1.appendChild(tex);
td2.appendChild(butt);
td2.appendChild(butt2);
td2.appendChild(texflag);
	return true;
}

function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}


function queryGift(bing)
{   	
	/*
	if ( document.all.custDisCode.value == "" )
	{
		rdShowMessageDialog( "����ѡ�����͵�" , 0 );
		return false;
	}	*/ 
	var opFlag=document.frm.opFlag;
  opFlag[0].checked=false ;
  opFlag[1].checked=false
	bing.disabled=true;
	document.frm.flag.value="1";
  var tr=bing.parentNode.parentNode;
	var tds=tr.childNodes;
	var t=tds[5].childNodes;	
	var hs=tr.rowIndex;//���ڵ���
	document.frm.codes.value =tds[0].innerHTML;//�����жһ�����Ʒ���
	var isPaperOpr_Packet = new AJAXPacket("isPaperOpr.jsp","������֤��Ʒ�����Ժ�......");
	isPaperOpr_Packet.data.add("retType","call_isPaperOpraAndValidate");
	isPaperOpr_Packet.data.add("hs",hs);
	isPaperOpr_Packet.data.add("codes",document.frm.codes.value);
	core.ajax.sendPacket(isPaperOpr_Packet);
	isPaperOpr_Packet=null;
}

//begin huangrong add ���ӷ��������ж��Ƿ�չʾ�ռ�����Ϣ
function addressInfo(bing)
{
	  var custInfo=document.getElementById("custInfo");
	  var  flag="none";
		document.frm.query.disabled=true;
		var tab=document.getElementById("dyntb");
		var trs=tab.rows;
		var changdu=trs.length;
		var sun="0";//���ֻ���ҵ��ĸ���
		var no_yz="0";//û��֤����Ʒ����
		if(changdu>2)
		{	
			
			 for(var i=2;i<changdu;i++)
			 { 
				 	var tds=trs[i].childNodes; 
				 	var t=tds[6].childNodes[2].value;//�Ƿ�Ϊ�ֻ���ҵ��

				 	if(Number(t)==0)
				 	{	
				 		sun=Number(sun)+1;
				 	} 	 	
				 	if(tds[6].childNodes[0].disabled==false)
				 	{
				 		no_yz=Number(no_yz)+1;			 		
				 	}	
			 }
			 
			 if(Number(no_yz)!=0)
			 {
						rdShowMessageDialog("��δ��֤����Ʒ������ѡ���Ƿ���Ҫ¼���ռ�����Ϣ");
						var opFlag=document.frm.opFlag;
					  opFlag[0].checked=false ;
					  opFlag[1].checked=false;
						return;				 	
			 }
			 
			 if(Number(sun)!=0)
			 {
			     	if(bing.value=="0")
				 		{
							//rdShowMessageDialog("�һ�������Ϣ����Ҫ�ռ�����Ϣ����ѡ���ǣ�");
							//return;				 			
				 		}else
			 			{
			 		     flag="black";	
		     			 				
			 			}
			 }else
		 	 {
			     	if(bing.value=="0")
				 		{			
				 			 flag="none";				 			
				 		}else
			 			{
							//rdShowMessageDialog("�һ�������Ϣ������Ҫ�ռ�����Ϣ����ѡ���");
							//return;		
							flag="black";			 				
			 			}		 		
		 	 }	 									
		}else
		{
             flag="none";    
	        
		}	
		if(flag=="black")
		{
			custInfo.style.display=""
		}else
		{
				custInfo.style.display="none"		
		}
				document.frm.confirmAndPrint.disabled=false;	
}

function selDis()
{
	var retVal=window.showModalDialog("fb881_dis.jsp"
		+"?custRegCode="+document.all.custRegCode.value
		,"","dialogWidth=800px;dialogHeight=600px");	
	if ( typeof (retVal)!="undefined" )
	{
		document.all.custDisCode.value=retVal.split("@")[0];
		document.all.custDisName.value=retVal.split("@")[1];	
	}	
}
</SCRIPT>

<!--**************************************************************************************-->

</HEAD>
<body>   
      <FORM method=post name="frm" action="fb882_2.jsp">
      	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">�ͻ�����</div>
		</div>         

        <TABLE cellspacing="0">        
          <TR>
              <TD class="blue">�ֻ�����</TD>
	            <TD>
		        	<input v_must="1" v_type="mobphone" name="phoneNo" id="phoneNo" class="InputGrey" maxlength=11 value="<%=activePhone%>" readOnly>
		        	<font color="orange">*</font> 		            
		            <input name="Bt_Qry1" type=button class="b_text" onclick="s1250Init()" value=��֤>
		            <input type="hidden" name="Ed_UserPass" value="<%=passValue%>">
	             <TD class="blue">�ͻ�����</TD>
	            <TD>
		            <input class="InputGrey" v_must=1  name=custName  readonly>
	            </TD>   
            </TR>
            <TR>
               
                <TD class="blue">����ֵ</TD>
                <TD>
                    <input class="InputGrey" name="itemPoint"  v_must=1 readonly>
                 </TD>
                 <TD class="blue">֤������</TD>
	            <TD>
		            <input class="InputGrey" v_must=1 name=idType  readonly>
	            </TD>
            </TR>
            <TR>  
                <TD class="blue">֤������</TD>
                <TD>
                    <input class="InputGrey" v_must=1 name=idIccid  readonly>
                    <input type="hidden" name=Ed_Sm_name >
                </TD>
                <TD class="blue">��ǰ״̬</TD>
	            <TD colspan="3">
		            <input class="InputGrey" v_must=1  name=status  readonly>
                    <input v_must=1  type="hidden" name=Ed_Grade_name readonly>
	            </TD>	
            </TR>
        </table>
    	</div>
    	<div id="Operation_Table">
        <div class="title">
		<div id="title_zi">�һ���Ϣ</div>
		</div> 
		<table cellspacing="0">
            <TR>
                <TD class="blue">��Ʒ����&nbsp;&nbsp;&nbsp;&nbsp;</TD>
	            <TD>
		            <input type="text" name="giftCode" >
	            </TD>
	            <TD class="blue">��Ʒ����</TD>
        		<TD>
					<input type="text" name="giftName" value="" id="giftName">   			
        		</TD>
            </TR>
            <TR>
            	<TD class="blue">���</TD>
            	<TD>       								
              		<select name="subType" id="subType" v_must=1 v_name="���">
										<option value ="">--��ѡ��--</option>			    							
										<%for(int i = 0 ; i < subTypeStr.length ; i ++){%>
			            		<option value="<%=subTypeStr[i][0]%>"><%=subTypeStr[i][0]%></option>
			            	<%}%>		
									</select>
              			
            	</TD>
            	<TD class="blue">����ʽ</TD>
            	<TD>
		   					  <select  name="sortType" id="sortType" v_name="����ʽ">
		   					  	<option value ="">--��ѡ��--</option>			    							
										<option value ="1">�һ�������</option>
								    <option value ="0">����ֵ</option>
									</select>
            	</TD> 
            </TR>
			<TR>
            	<TD class="blue">����</TD>
            	<TD >
						<input  type="text" name=accountMark value="30000">
				</td>
            	<TD class="blue">���͵�:</TD>
            	<TD >
					<input type = "text" id = "" name = "custRegName" value = "" class = "InputGrey" size = '10' readOnly> 
					<input type = "text" id = "" name = "custDisName" value = "" class ="InputGrey" readOnly> 
					<input type = 'button' id = 'btnSel' name = '' value = 'ѡ��' class = 'b_text' onclick = 'selDis()' >
					<input type="hidden" id="" name="custRegCode" value="" > 
					<input type="hidden" id="" name="custDisCode" value="" > 
				</td>				
            </TR>
       <tr id="footer"> 
	      <td colspan="4" align="center"><input class="b_foot" name="query" type=button value=��ѯ onclick="getInfo_code()"></td>
	    </tr>   	          	
        </table>
              
		<table id="dyntb" cellspacing="0">
    		<tr>	  			     		 	
          		<th nowrap align="center">	
          			��Ʒ����
          		</th>
         	 	<th nowrap align="center">
          			��Ʒ����
          		</th>
          		<th nowrap align="center">
          			����ֵ
          		</th>
          		<th nowrap align="center">
          			����
          		</th>
          		<th nowrap align="center">
          			С��
          		</th>        
          		<th nowrap align="center">
          			�һ�����
          		</th>   
          		<th nowrap align="center">
          			��������
          		</th>      	
      		</tr>
      		<tr align="center" style="display:none" id="informations">
						<td nowrap><input type="text" name="Gift_Name" class="InputGrey" readOnly></td>
						<td nowrap><input type="text" name="Base_Fee" class="InputGrey" readOnly></td>
						<td nowrap><input type="text" name="Free_Fee" class="InputGrey" readOnly></td>
						<td nowrap><input type="text" name="Mark_Subtract" class="InputGrey" readOnly></td>
						<td nowrap><input type="text" name="Mark_Subtract" class="InputGrey" readOnly></td>
						<td nowrap><input type="text" name="Consume_Term"></td>
				
					</tr>
        </TABLE>
         <TABLE cellspacing="0">         
            <TR>
                <TD class="blue" width="15%">�Ƿ���Ҫ¼���ռ�����Ϣ</TD>
	            	<TD colspan="6">	
	            		 <input type="radio" name="opFlag" value="0" onClick="addressInfo(this)">��
                   <input type="radio" name="opFlag" value="1" onClick="addressInfo(this)">��
	              </TD>
            </TR>               
        </TABLE>        
<div id="custInfo" style="display:none">
<div id="Operation_Table">
        <div class="title">
		<div id="title_zi">�ռ�����Ϣ</div>
		</div> 
		<table cellspacing="0">
            <TR>
                <TD class="blue">����&nbsp;&nbsp;&nbsp;&nbsp;</TD>
	            <TD>

									
									
								<select id="regionName" name="regionName" v_must=1  onchange="selectChange(this, sesionCounty, district_Name, city_Id);" v_name="�ֻ�������">
						     	<option value ="">--��ѡ��--</option>
			            <%for(int i = 0 ; i < cityNameString.length ; i ++){%>
			            <option value="<%=cityNameString[i][0]%>"><%=cityNameString[i][1]%></option>
			            <%}%>			              
								</select>
									
									
									<font color="orange">*</font> 	
	            </TD>
	            <TD class="blue">����</TD>
        		<TD>
		   				    <select  name=sesionCounty" id="sesionCounty" v_must=1 v_name="����">
										<option value ="">--��ѡ��--</option>
								    			<input type="hidden" name="type_code" id="type_code" >
									</select>
									
									<font color="orange">*</font> 	   			       		        		    
        		</TD>
            </TR>
            <TR>
            	<TD class="blue">���͵�ַ</TD>
            	<TD>
              		<input type="text" name="sendAddress" v_must=1>
              		<font color="orange">*</font> 	
            	</TD>
            	<TD class="blue">�ʱ�</TD>
            	<TD>
				   			<input type="text" name="postCode" v_must=1 v_type="zip">
				   			<font color="orange">*</font> 	
            	</TD>
            </TR>
						<TR>
            	<TD class="blue">�ռ���</TD>
            	<TD>
								<input type="text" name="addressPerson" v_must=1 v_maxlength=60>
								<font color="orange">*</font> 	
							</TD>
            	<TD class="blue">��ϵ�绰</TD>
            	<TD>
              	<input type="text" name="phoneNum" v_must=1 v_maxlength=11 v_type="phone">
              	<font color="orange">*</font> 	
            	</TD>  
        		</TR>
        
        		<TR>
                <TD class="blue">����ʱ��&nbsp;&nbsp;&nbsp;&nbsp;</TD>
	            	<TD colspan="3">	
								<select id="sendTime" name="sendTime" v_must=1 >
						     	<option value ="">--��ѡ��--</option>
						     	<option value ="01">���ϰ�ʱ���ͻ�</option>
						     	<option value ="02">��ĩ�ͻ�</option>
						     	<option value ="03">��һ�������ͻ�</option>
								</select>
									
									
									<font color="orange">*</font> 	
	            </TD>
	          </TR>    	  	          	
        </table>
        
   </div>     
        
      </div>
      
         <TABLE cellspacing="0">         
            <TR>
              <TD align="center">
              <input class="b_foot" name=confirmAndPrint  onClick="printCommit()" type=button disabled  value=ȷ��&��ӡ> &nbsp;
              <input class="b_foot" name=colse  onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
             </TD>
            </TR>               
        </TABLE>
      

  <!------------------------>
  <input type="hidden" name="tmp_phone_no" value="">  
  <input type="hidden" name="codes" value="">  
  <input type="hidden" name="numbers" value="">  
  <input type="hidden" name="present_point" value="30000"> <!-----------��ǰ����------------->
  <input type="hidden" name="opCode" value="<%=opCode%>"> 
  <input type="hidden" name="login_accept" value="<%=printAccept%>"> 
  <input type="hidden" name="ItemCode" value="">  
  <input type="hidden" name="ItemNum" value=""> 
  <input type="hidden" name="flag" value="0"> <!---------��֤��ť�Ƿ񶼰���--------------->
  <input type="hidden" name="flag_sql" value="0"> <!---------��֤��ť�Ƿ񶼰���--------------->
	<%@ include file="../../include/remark.htm" %>
    <%@ include file="/npage/include/footer.jsp" %>   
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>


<script language="JavaScript">

function printCommit(){
	getAfterPrompt();
	var tab=document.getElementById("dyntb");
	var trs=tab.rows;
	var changdu=trs.length;
	if(changdu>2)
	{	
		for(var i=2;i<changdu;i++)
		{  
		  var tds=trs[i].childNodes; 

		  var bm=tds[0].innerHTML;
			if(bm.length==0)
			{
				rdShowMessageDialog("������ѡ���Ʒ���öһ���Ʒû��ȷ������Ʒ����!");
				return false;
			}
			if(tds[6].childNodes[0].disabled==false)
			{
				rdShowMessageDialog("��δ��֤����Ʒ�������ύ!");
				return false;				
			}
		
		}
	}else
	{	
			if(document.frm.query.disabled)
			{
				document.frm.query.disabled=false;
			}
			rdShowMessageDialog("��ѡ��һ�����Ʒ!");
			return false;
	
	/*
	if(document.frm.flag.value=="0")
	{
		
			rdShowMessageDialog("��δ��֤����Ʒ�������ύ!");
			return false;
	}
	*/}
  if(checkPhone() != true)
  {
     return false;
  }
  //huangrong add �ռ�����Ϣ��ѡ��ť�Ƿ�ѡ��
  var opFlag=document.frm.opFlag;
  if(opFlag[0].checked==false && opFlag[1].checked==false)
  {
			rdShowMessageDialog("��ѡ���Ƿ���Ҫ¼���ռ�����Ϣ��");
			return false;  	
  }
	var custInfo=document.getElementById("custInfo");
  if(custInfo.style.display=="")
  {
    with (document.frm)
    {
        if(!checkElement(regionName))
        {
        		regionName.focus();
						return false;
				}	
        if(!checkElement(sesionCounty))
        {
        		sesionCounty.focus();
						return false;
				}	
        if(!checkElement(sendAddress))
        {
        		sendAddress.focus();
						return false;
				}	        
        if(!checkElement(postCode))
        {
        		postCode.focus();
						return false;
				}	
				if(!checkElement(addressPerson))
        {
        		addressPerson.focus();
						return false;
				}
				if(!checkElement(phoneNum))
        {
        		phoneNum.focus();
						return false;
				}	
				if(!checkElement(sendTime))
        {
        		sendTime.focus();
						return false;
				}		        
    }
  

}

	getItemInf();
	document.frm.confirmAndPrint.disabled=true;//huangrong add ��ֹ����ȷ��
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
}

  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի���
     var h=210;
     var w=400;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;

		 var pType="subprint";                           // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		 var billType="1";                            // Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		 var sysAccept=<%=printAccept%>;            // ��ˮ��
		 var printStr = printInfo(printType);         //����printinfo()���صĴ�ӡ����
		 var mode_code=null;                          //�ʷѴ���
		 var fav_code=null;                			  //�ط�����
		 var area_code=null;           			      //С������
     var opCode="b882";                  			  //��������
     var phoneNo=<%=activePhone%>;                //�ͻ��绰    

     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
     
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	 	 path = path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
  }
  

  function printInfo(printType)
  {
//		var after = parseInt(document.all.init_user_point.value)-parseInt(document.all.Ed_Favour_point_this.value);
		
		var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
   
    cust_info+="�ͻ�������"+document.all.custName.value+"|";
    cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
    cust_info+="֤�����룺"+document.all.idIccid.value+"|";
    opr_info+="�û�Ʒ�ƣ�"+document.all.Ed_Sm_name.value+"|";
    
    opr_info+="�����ζһ�����Ʒ������"+ "|";
    
    var tab=document.getElementById("dyntb");
		var trs=tab.rows;
		var changdu=trs.length;
		if(changdu>2)
		{
			for(var i=2;i<changdu;i++)
			{  
			  var tds=trs[i].childNodes; 
			  var bm=tds[0].innerHTML;
			  var mc=tds[1].innerHTML;
			  var djf=tds[2].innerHTML;
				var t=tds[5].childNodes;
				var sls=t[0].value;
				var jf=sls*djf;
				opr_info+="��Ʒ���ƣ�"+mc+"����Ʒ���룺"+bm+"��������Ʒ���֣�"+djf+"����Ʒ������"+sls+"��ʵ�����Ļ��֣�"+jf+"��"+"|";
			
			}
		}
		note_info1+="��ע��"+"|"
		note_info1+="���ɵ�½http://jf.10086.cn/���жһ���������Ʒʱ�뵱����������������벦��10086��"+"|";
	
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    
    return retInfo;
  }
  

 

function frmCfm()
{
	frm.submit();
	return true;	
}
//���öһ���Ʒ�Ĵ��������
function getItemInf()
{
	var tab=document.getElementById("dyntb");
	var trs=tab.rows;
	var changdu=trs.length;
	var ItemCodeStr=""
	var ItemNumStr="";
	if(changdu>2)
	{
		for(var i=2;i<changdu;i++)
		{  
		  var tds=trs[i].childNodes; 
		  var bm=tds[0].innerHTML;
			var t=tds[5].childNodes;
			var sls=t[0].value;
			ItemCodeStr+=bm;
			ItemNumStr+=sls;
			ItemCodeStr+="|";
			ItemNumStr+="|";
		}
			document.frm.ItemCode.value=ItemCodeStr;
			document.all.ItemNum.value=ItemNumStr;
		}
}

</script>
</body>
</html>


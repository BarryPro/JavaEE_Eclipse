<%
 /**
 * version v2.0
 * 开发商: si-tech
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
    String opName = "省积分兑换礼品";
    
    String workNo = (String)session.getAttribute("workNo");
    String nopass = "111111";
    String OrgCode = (String)session.getAttribute("orgCode");
    String regionCode = (String)session.getAttribute("regCode");
		String op_code = " ";
    String ip_Addr = (String)session.getAttribute("ipAddr");
		String phoneNo = (String)request.getParameter("activePhone");
    /* 业务变量 */
    String passflag = "0";

    //优惠信息
    //String[][] favInfo = (String[][])arr.get(3);   //数据格式为String[0][0]---String[n][0]
    String[][] favInfo = (String[][])session.getAttribute("favInfo"); //优惠代码为数组
    String tempStr = "";
    String passValue ="";
    String smCode="";
    String itemPoints="";
    String itemState="";
    String itemNumber="";
    
    String card_name="";//卡类型名称 huangrong add
    String card_type="";//卡类型 huangrong add    
    //begin add by diling for 对密码权限整改 @2012/3/13 
    boolean pwrf = false;
	  String pubOpCode = opCode;
%>
	  <%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
    System.out.println("==第四批======fb882.jsp==== pwrf = " + pwrf);
    if(pwrf){
        passflag = "1";  
    }
    //end add by diling for 对密码权限整改 @2012/3/13 
    
    if(passflag.equals("0")){
         Map map = (Map)session.getAttribute("contactInfoMap");
		     ContactInfo contactInfo = (ContactInfo) map.get(activePhone);
         passValue=contactInfo.getPasswdVal(2);
    }
    
    String printAccept="";
		printAccept = getMaxAccept();
		System.out.println(printAccept);

	String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
//******************得到下拉框数据***************************//	
	 //地市
 	String cityNameStr = " select cityid,cityname from oneboss.TOBMARKADDRINFO group by cityid,cityname";

  //区县
  String districtNameStr = "select cityid,districtid,districtname from oneboss.TOBMARKADDRINFO";
	//小类礼品
	String subTypeSql="select subtype from dbcustadm.TOBMARKCHANGEMSG group by subtype";
	String smCodeSql="select sm_code from dcustmsg where phone_no='"+activePhone+"'";
	//paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
	//begin huangrong add 获取用户类型
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
						rdShowMessageDialog("该用户非全球通、神州行或者动感地带用户，不能办理此业务！");
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

<HEAD><TITLE>省积分礼品兑换</TITLE>
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
	
/****************根据地市动态生成区县下拉框************************/
 function selectChange(control, controlToPopulate, districtName, cityId)
 {
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values

   myEle = document.createElement("option") ;
   myEle.value = "";
   myEle.text ="--请选择--";
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

//---------1------RPC处理函数------------------
function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    var retMessage = packet.data.findValueByName("retMessage");

    //--------------------------------
    if(retType == "call_s1250Init")
    {
        //读取原有库中数量
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
            if(higmsg>0){rdShowMessageDialog("该用户为中高端用户!");}
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
									rdShowMessageDialog("验证通过！");		
						
					}else
					{
						rdShowMessageDialog("积分不足不能兑换！");
						//document.frm.flag.value="0";	
					}
            	}
            	else
            	{
	            	if(Number(itemNumber)< Number(sls))
		            {
						rdShowMessageDialog("礼品存货不足"+sls+",请减少兑换数量！");
						return false;
		            }
		            else
	            	{	
	
						if(present_point>0)
						{
										//is_reCode();
										//gono_change();
										rdShowMessageDialog("验证通过！");		
							
						}else
						{
							rdShowMessageDialog("积分不足不能兑换！");
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
   // huangrong add 	获取判断兑换信息是否为手机报的返回信息和对当前兑换信息鉴权 2011-5-20   	
   	if(retType == "call_isPaperOpraAndValidate")     
   {
   	

  		if(retCode=="000000")
      {
        var hs=packet.data.findValueByName("hs");
	  		var tab=document.getElementById("dyntb");
	  		var tr=tab.rows[hs];
	  		var tds=tr.childNodes;
	  		var sls=tds[5].childNodes[0].value;//兑换数量
	  		var code=tds[0].innerHTML;//兑换代码
				document.frm.codes.value =code;
				document.frm.numbers.value =tds[5].childNodes[0].value;
				
				 var isPaperFlag = packet.data.findValueByName("isPaperFlag");

         if(Number(isPaperFlag)>0)
      		{
      			
      			if(Number(sls)>1)
      			{
      				rdShowMessageDialog("兑换礼品为手机报，因此兑换数量只能是1！");
      				tds[5].childNodes[0].value="1";
      			}
    				tds[6].childNodes[2].value="1";  
      		}else
			{
				tds[6].childNodes[2].value="0";  
			}
    		var is_flag=is_reCode();	//验证是否存在不能同时兑换的礼品
    		if(is_flag==true)
    		{

					var queryGift_Packet = new AJAXPacket("queryGift.jsp","正在验证礼品，请稍候......");
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

//huangrong add 2011-5-21 判断是否存在兑换礼品不能同时办理的情况
function is_reCode()
{
  var tab=document.getElementById("dyntb");
	var trs=tab.rows;
	var changdu=trs.length;
	if(changdu>3)
	{	
		var num="0";//标识：0标识没有不能同时兑换的礼品，1，标识兑换一个以上《全球通凤凰周刊》，2标识兑换一个以上《全球通凤凰观察》
		//遍历所有的行，获取兑换礼品的id
		for(var i=2;i<changdu;i++)
		{  
			var first_tds=trs[i].childNodes; 		
			var first_gift_id=first_tds[0].innerHTML//礼品id																						
			if(first_gift_id=="358470" || first_gift_id=="358471" || first_gift_id=="358472" || first_gift_id=="358473")
			{
				for(var j=i+1;j<changdu;j++)
				{
					var tds=trs[j].childNodes; 
					var gift_id=tds[0].innerHTML//礼品id	
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
				var gift_id=tds[0].innerHTML//礼品id	
				if(first_gift_id==gift_id)
				{
					num="3";													;														
				}
			}																			
		}	
		if(num=="1")
		{
			rdShowMessageDialog("不能兑换一个以上《全球通凤凰周刊》，请删除一条！");
			return false;			
		}else if(num=="2")
		{	
			rdShowMessageDialog("不能兑换一个以上《全球通凤凰观察》，请删除一条！");							
			return false;				
		}else if(num=="3")
		{	
			rdShowMessageDialog("兑换列表中不能出现重复的兑换记录，如需要兑换在2个以上，可直接修改兑换数量，请删除一条！");							
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
    //读取原有库中数量
    if (checkPhone() != true)
    {
        return false;
    }
   
    document.frm.phoneNo.readOnly=true;
    document.frm.tmp_phone_no.value=document.frm.custName.value;
     
    var s1250Init_Packet = new AJAXPacket("fb882_chk.jsp","正在验证密码，请稍候......");
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
        rdShowMessageDialog("请输入手机号码！",0);
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
		    rdShowMessageDialog("请先点击验证按钮，验证用户信息！");
        return false;
	}
	var regionCode = "<%=regionCode%>";
	var pageTitle = "兑换礼品选择";
	var fieldName = "礼品编码|礼品名称|积分值|大类|小类|";//弹出窗口显示的列、列名
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "5|0|1|2|3|4|";//返回字段
	var retToField = "giftCode|giftName|Item_Ponint|Main_Type|subType|";//返回赋值的域
//huangrong update sqlStr	
// ningtn SQL注入改造
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
	//document.all.do_note.value = "统一预存赠礼，方案代码："+document.all.Gift_Code.value;
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
//插入数量  
var td1=tr.insertCell(); 
var tex=document.createElement("<input type=text name=sl>");
tex.onblur=function()
{
	if(this.value=="" || isNaN(this.value)||this.value=="0")
	{
		rdShowMessageDialog("兑换礼品数量不能为空，非数字以及0，系统默认设置为1");
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
			document.frm.flag.value="0"//标记 提交与否，如果是1代表能提交，如果是0代表不能提交。
	}
}
tex.value="1";
//begin huangrong add 判断当前所选择的兑换信息在SITEMCORRECFG中是否存在 2011-5-20 


function isPaperOpr(bing,returnType)
{   
	var tr=bing.parentNode.parentNode;
	var tds=tr.childNodes;
	var t=tds[5].childNodes;	
	var hs=tr.rowIndex;//所在的行
	document.frm.codes.value =tds[0].innerHTML;//所在行兑换的礼品编号
	var isPaperOpr_Packet = new AJAXPacket("isPaperOpr.jsp","正在验证礼品，请稍候......");
	isPaperOpr_Packet.data.add("retType",returnType);
	isPaperOpr_Packet.data.add("hs",hs);
	isPaperOpr_Packet.data.add("codes",document.frm.codes.value);
	core.ajax.sendPacket(isPaperOpr_Packet);
	isPaperOpr_Packet=null;
}
//end huangrong add 判断当前所选择的兑换信息在SITEMCORRECFG中是否存在 2011-5-20  
var butt=document.createElement("<input type=button name=yz class=b_text>");
butt.value="验证";
butt.onclick=function()
{
	
  queryGift(this);
}
var td2=tr.insertCell(); 
var butt2=document.createElement("<input type=button name=butt class=b_text>");
butt2.value="删除";
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
//huangrong add 2011-5-21  在行的第4列插入文本框，代表该行是否是兑换手机报业务，0，不是，；1，为手机报业务，默认是0     
var texflag=document.createElement("<input type=hidden name=isFlagPaper>");
texflag.value="2";

//end add 在行的第4列插入文本框，代表该行是否是兑换手机报业务，0，不是，；1，为手机报业务，默认是0     
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
		rdShowMessageDialog( "必须选择配送地" , 0 );
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
	var hs=tr.rowIndex;//所在的行
	document.frm.codes.value =tds[0].innerHTML;//所在行兑换的礼品编号
	var isPaperOpr_Packet = new AJAXPacket("isPaperOpr.jsp","正在验证礼品，请稍候......");
	isPaperOpr_Packet.data.add("retType","call_isPaperOpraAndValidate");
	isPaperOpr_Packet.data.add("hs",hs);
	isPaperOpr_Packet.data.add("codes",document.frm.codes.value);
	core.ajax.sendPacket(isPaperOpr_Packet);
	isPaperOpr_Packet=null;
}

//begin huangrong add 增加方法用于判断是否展示收件人信息
function addressInfo(bing)
{
	  var custInfo=document.getElementById("custInfo");
	  var  flag="none";
		document.frm.query.disabled=true;
		var tab=document.getElementById("dyntb");
		var trs=tab.rows;
		var changdu=trs.length;
		var sun="0";//非手机报业务的个数
		var no_yz="0";//没验证的礼品数量
		if(changdu>2)
		{	
			
			 for(var i=2;i<changdu;i++)
			 { 
				 	var tds=trs[i].childNodes; 
				 	var t=tds[6].childNodes[2].value;//是否为手机报业务

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
						rdShowMessageDialog("有未验证的礼品，不能选择是否需要录入收件人信息");
						var opFlag=document.frm.opFlag;
					  opFlag[0].checked=false ;
					  opFlag[1].checked=false;
						return;				 	
			 }
			 
			 if(Number(sun)!=0)
			 {
			     	if(bing.value=="0")
				 		{
							//rdShowMessageDialog("兑换以上信息，需要收件人信息，请选择是！");
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
							//rdShowMessageDialog("兑换以上信息，不需要收件人信息，请选择否！");
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
			<div id="title_zi">客户资料</div>
		</div>         

        <TABLE cellspacing="0">        
          <TR>
              <TD class="blue">手机号码</TD>
	            <TD>
		        	<input v_must="1" v_type="mobphone" name="phoneNo" id="phoneNo" class="InputGrey" maxlength=11 value="<%=activePhone%>" readOnly>
		        	<font color="orange">*</font> 		            
		            <input name="Bt_Qry1" type=button class="b_text" onclick="s1250Init()" value=验证>
		            <input type="hidden" name="Ed_UserPass" value="<%=passValue%>">
	             <TD class="blue">客户名称</TD>
	            <TD>
		            <input class="InputGrey" v_must=1  name=custName  readonly>
	            </TD>   
            </TR>
            <TR>
               
                <TD class="blue">积分值</TD>
                <TD>
                    <input class="InputGrey" name="itemPoint"  v_must=1 readonly>
                 </TD>
                 <TD class="blue">证件类型</TD>
	            <TD>
		            <input class="InputGrey" v_must=1 name=idType  readonly>
	            </TD>
            </TR>
            <TR>  
                <TD class="blue">证件号码</TD>
                <TD>
                    <input class="InputGrey" v_must=1 name=idIccid  readonly>
                    <input type="hidden" name=Ed_Sm_name >
                </TD>
                <TD class="blue">当前状态</TD>
	            <TD colspan="3">
		            <input class="InputGrey" v_must=1  name=status  readonly>
                    <input v_must=1  type="hidden" name=Ed_Grade_name readonly>
	            </TD>	
            </TR>
        </table>
    	</div>
    	<div id="Operation_Table">
        <div class="title">
		<div id="title_zi">兑换信息</div>
		</div> 
		<table cellspacing="0">
            <TR>
                <TD class="blue">礼品代码&nbsp;&nbsp;&nbsp;&nbsp;</TD>
	            <TD>
		            <input type="text" name="giftCode" >
	            </TD>
	            <TD class="blue">礼品名称</TD>
        		<TD>
					<input type="text" name="giftName" value="" id="giftName">   			
        		</TD>
            </TR>
            <TR>
            	<TD class="blue">类别</TD>
            	<TD>       								
              		<select name="subType" id="subType" v_must=1 v_name="类别">
										<option value ="">--请选择--</option>			    							
										<%for(int i = 0 ; i < subTypeStr.length ; i ++){%>
			            		<option value="<%=subTypeStr[i][0]%>"><%=subTypeStr[i][0]%></option>
			            	<%}%>		
									</select>
              			
            	</TD>
            	<TD class="blue">排序方式</TD>
            	<TD>
		   					  <select  name="sortType" id="sortType" v_name="排序方式">
		   					  	<option value ="">--请选择--</option>			    							
										<option value ="1">兑换量排序</option>
								    <option value ="0">积分值</option>
									</select>
            	</TD> 
            </TR>
			<TR>
            	<TD class="blue">积分</TD>
            	<TD >
						<input  type="text" name=accountMark value="30000">
				</td>
            	<TD class="blue">配送地:</TD>
            	<TD >
					<input type = "text" id = "" name = "custRegName" value = "" class = "InputGrey" size = '10' readOnly> 
					<input type = "text" id = "" name = "custDisName" value = "" class ="InputGrey" readOnly> 
					<input type = 'button' id = 'btnSel' name = '' value = '选择' class = 'b_text' onclick = 'selDis()' >
					<input type="hidden" id="" name="custRegCode" value="" > 
					<input type="hidden" id="" name="custDisCode" value="" > 
				</td>				
            </TR>
       <tr id="footer"> 
	      <td colspan="4" align="center"><input class="b_foot" name="query" type=button value=查询 onclick="getInfo_code()"></td>
	    </tr>   	          	
        </table>
              
		<table id="dyntb" cellspacing="0">
    		<tr>	  			     		 	
          		<th nowrap align="center">	
          			礼品编码
          		</th>
         	 	<th nowrap align="center">
          			礼品名称
          		</th>
          		<th nowrap align="center">
          			积分值
          		</th>
          		<th nowrap align="center">
          			大类
          		</th>
          		<th nowrap align="center">
          			小类
          		</th>        
          		<th nowrap align="center">
          			兑换数量
          		</th>   
          		<th nowrap align="center">
          			操作类型
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
                <TD class="blue" width="15%">是否需要录入收件人信息</TD>
	            	<TD colspan="6">	
	            		 <input type="radio" name="opFlag" value="0" onClick="addressInfo(this)">否
                   <input type="radio" name="opFlag" value="1" onClick="addressInfo(this)">是
	              </TD>
            </TR>               
        </TABLE>        
<div id="custInfo" style="display:none">
<div id="Operation_Table">
        <div class="title">
		<div id="title_zi">收件人信息</div>
		</div> 
		<table cellspacing="0">
            <TR>
                <TD class="blue">地市&nbsp;&nbsp;&nbsp;&nbsp;</TD>
	            <TD>

									
									
								<select id="regionName" name="regionName" v_must=1  onchange="selectChange(this, sesionCounty, district_Name, city_Id);" v_name="手机代理商">
						     	<option value ="">--请选择--</option>
			            <%for(int i = 0 ; i < cityNameString.length ; i ++){%>
			            <option value="<%=cityNameString[i][0]%>"><%=cityNameString[i][1]%></option>
			            <%}%>			              
								</select>
									
									
									<font color="orange">*</font> 	
	            </TD>
	            <TD class="blue">区县</TD>
        		<TD>
		   				    <select  name=sesionCounty" id="sesionCounty" v_must=1 v_name="区县">
										<option value ="">--请选择--</option>
								    			<input type="hidden" name="type_code" id="type_code" >
									</select>
									
									<font color="orange">*</font> 	   			       		        		    
        		</TD>
            </TR>
            <TR>
            	<TD class="blue">配送地址</TD>
            	<TD>
              		<input type="text" name="sendAddress" v_must=1>
              		<font color="orange">*</font> 	
            	</TD>
            	<TD class="blue">邮编</TD>
            	<TD>
				   			<input type="text" name="postCode" v_must=1 v_type="zip">
				   			<font color="orange">*</font> 	
            	</TD>
            </TR>
						<TR>
            	<TD class="blue">收件人</TD>
            	<TD>
								<input type="text" name="addressPerson" v_must=1 v_maxlength=60>
								<font color="orange">*</font> 	
							</TD>
            	<TD class="blue">联系电话</TD>
            	<TD>
              	<input type="text" name="phoneNum" v_must=1 v_maxlength=11 v_type="phone">
              	<font color="orange">*</font> 	
            	</TD>  
        		</TR>
        
        		<TR>
                <TD class="blue">配送时间&nbsp;&nbsp;&nbsp;&nbsp;</TD>
	            	<TD colspan="3">	
								<select id="sendTime" name="sendTime" v_must=1 >
						     	<option value ="">--请选择--</option>
						     	<option value ="01">仅上班时间送货</option>
						     	<option value ="02">周末送货</option>
						     	<option value ="03">周一到周日送货</option>
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
              <input class="b_foot" name=confirmAndPrint  onClick="printCommit()" type=button disabled  value=确认&打印> &nbsp;
              <input class="b_foot" name=colse  onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
             </TD>
            </TR>               
        </TABLE>
      

  <!------------------------>
  <input type="hidden" name="tmp_phone_no" value="">  
  <input type="hidden" name="codes" value="">  
  <input type="hidden" name="numbers" value="">  
  <input type="hidden" name="present_point" value="30000"> <!-----------当前积分------------->
  <input type="hidden" name="opCode" value="<%=opCode%>"> 
  <input type="hidden" name="login_accept" value="<%=printAccept%>"> 
  <input type="hidden" name="ItemCode" value="">  
  <input type="hidden" name="ItemNum" value=""> 
  <input type="hidden" name="flag" value="0"> <!---------验证按钮是否都按了--------------->
  <input type="hidden" name="flag_sql" value="0"> <!---------验证按钮是否都按了--------------->
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
				rdShowMessageDialog("请重新选择产品，该兑换产品没有确定的礼品编码!");
				return false;
			}
			if(tds[6].childNodes[0].disabled==false)
			{
				rdShowMessageDialog("有未验证的礼品，不能提交!");
				return false;				
			}
		
		}
	}else
	{	
			if(document.frm.query.disabled)
			{
				document.frm.query.disabled=false;
			}
			rdShowMessageDialog("请选择兑换的礼品!");
			return false;
	
	/*
	if(document.frm.flag.value=="0")
	{
		
			rdShowMessageDialog("有未验证的礼品，不能提交!");
			return false;
	}
	*/}
  if(checkPhone() != true)
  {
     return false;
  }
  //huangrong add 收件人信息单选按钮是否选择
  var opFlag=document.frm.opFlag;
  if(opFlag[0].checked==false && opFlag[1].checked==false)
  {
			rdShowMessageDialog("请选择是否需要录入收件人信息！");
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
	document.frm.confirmAndPrint.disabled=true;//huangrong add 防止二次确认
   //打印工单并提交表单
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
      {
	    frmCfm();
      }
	}
	if(ret=="continueSub")
	{
      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
      {
	    frmCfm();
      }
	}
  }
  else
  {
     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
     {
	   frmCfm();
     }
  }
  return true;
}

  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框
     var h=210;
     var w=400;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;

		 var pType="subprint";                           // 打印类型：print 打印 subprint 合并打印
		 var billType="1";                            // 票价类型：1电子免填单、2发票、3收据
		 var sysAccept=<%=printAccept%>;            // 流水号
		 var printStr = printInfo(printType);         //调用printinfo()返回的打印内容
		 var mode_code=null;                          //资费代码
		 var fav_code=null;                			  //特服代码
		 var area_code=null;           			      //小区代码
     var opCode="b882";                  			  //操作代码
     var phoneNo=<%=activePhone%>;                //客户电话    

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
   
    cust_info+="客户姓名："+document.all.custName.value+"|";
    cust_info+="手机号码："+document.all.phoneNo.value+"|";
    cust_info+="证件号码："+document.all.idIccid.value+"|";
    opr_info+="用户品牌："+document.all.Ed_Sm_name.value+"|";
    
    opr_info+="您本次兑换的礼品包括："+ "|";
    
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
				opr_info+="礼品名称："+mc+"，礼品编码："+bm+"，单个礼品积分："+djf+"，礼品数量："+sls+"，实际消耗积分："+jf+"。"+"|";
			
			}
		}
		note_info1+="备注："+"|"
		note_info1+="您可登陆http://jf.10086.cn/进行兑换，接收礼品时请当场验货，如有问题请拨打10086。"+"|";
	
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    
    return retInfo;
  }
  

 

function frmCfm()
{
	frm.submit();
	return true;	
}
//设置兑换产品的代码和数量
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


<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-03-19
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>

<%@ page import="java.util.ArrayList" %>
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s3500/pub.js"></script>

<%
    //得到输入参数
    ArrayList retArray = new ArrayList();
    String return_code,return_message;
    String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
    String[] paramsIn = null;
    String[] paraIn = null;
    String opName = "议价";

    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    Logger logger = Logger.getLogger("fpubprod_sel.jsp");

%> 	

<%
/*
SQL语句        sql_content
选择类型       sel_type   
标题           title      
字段1名称      field_name1
*/

    /*得到操作员的工号和密码*/

    String workno = (String)session.getAttribute("workNo");
    String nopass  = (String)session.getAttribute("password");
    String powerRight = ((String)session.getAttribute("powerRight")).trim();
    String prodCode = request.getParameter("prodCode");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);

	String group_id = "";
    String org_id = "";
    
	String sqlStr = "";
	//取运行省份代码 -- 为吉林增加，山西可以使用session
	//String[][] result2  = null;
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="1">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="result2" scope="end" />
	<%
	String province_run = "";
	if (result2 != null && result2.length != 0) 
	{
		province_run = result2[0][0];
	}
	
    
    String class_code = "";
int recordNum = 0;
    try
    {
        if(province_run.equals("20"))   //吉林
        {
        	sqlStr = "select '9999999', a.group_id, nvl(b.innet_type,'99') "
        	        +"  from dLoginMsg a, sTownCode b "
        	        +" where a.login_no =:workno "
        	        +"   and substr(a.org_code,1,2) = b.region_code(+)"
        	        +"   and substr(a.org_code,3,2) = b.district_code(+)"
        	        +"   and substr(a.org_code,5,3) = b.town_code(+)";
        }
        else
        {
        	sqlStr = "select org_id, a.group_id, nvl(b.innet_type,'99') from dLoginMsg a, sTownCode b where a.login_no =:workno and a.group_id = b.group_id(+)";
        }
        System.out.print("sqlStr:"+sqlStr);
        //retArray = callView.sPubSelect("3",sqlStr);
        
        paraIn[0] = sqlStr;    
        paraIn[1]="workno="+workno;
%>
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="3" >
        	<wtc:param value="<%=paraIn[0]%>"/>
        	<wtc:param value="<%=paraIn[1]%>"/> 
        </wtc:service>
        <wtc:array id="retArr2" scope="end"/>
<%

        //System.out.print("retArray:"+retArray);
        //result = (String[][])retArray.get(0);
        if(retCode2.equals("000000")){
            result = retArr2;
        }
        if (result[0][0].trim().length() == 0) {
            throw new Exception("查询操作员入网操作权限失败！");
        }
        org_id = result[0][0];
        group_id = result[0][1];
        class_code = result[0][2];
    }
    catch(Exception e){
        logger.error("查询sSmSelPAttr错误!");
    }

    String owner_code = "JT";
    String credit_code = "E";
    String product_level = "1"; //主产品
    String business_code = "0"; //开户

    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");

	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    //System.out.print("sqlStr="+sqlStr);
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    if(selType.compareTo("N") == 0)
    {   selType = "";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";   
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <HEAD>
<TITLE>黑龙江BOSS-集团产品查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<SCRIPT type=text/javascript>
	var sflagcheck="0";
function saveTo()
{
	
	var rIndex;        //选择框索引
	var retValue = ""; //返回值
	var chPos;         //字符位置
	var obj;
	var fieldNo;        //返回域序列号
	var retFieldNum = document.fPubSimpSel.retFieldNum.value;
	var retQuence = document.fPubSimpSel.retQuence.value;  //返回字段域的序列
	var retNum = retQuence.substring(0,retQuence.indexOf("|"));
	retQuence = retQuence.substring(retQuence.indexOf("|")+1);
	var tempQuence;
	if(retFieldNum == "")	
	{     
		return false;   
	}
	for(i=0;i<document.fPubSimpSel.elements.length;i++)
	{ 
		if (document.fPubSimpSel.elements[i].name=="List")
		{
			if (document.fPubSimpSel.elements[i].checked==true)
			{
				rIndex = document.fPubSimpSel.elements[i].RIndex;
				retValue += document.all("Rinput" + rIndex + "0").value + ",";
				retValue += document.all("Rinput" + rIndex + "2").value + ",";
				retValue += document.all("Rinput" + rIndex + "4").value + ",";
				retValue += "0000,";
				retValue += document.all("Rinput" + rIndex + "11").value + ",";
								
				var iCk=-1;
				var youhuimax;
				var youhuistr;
				var flag_14_val = document.all("flag_14_" + rIndex ).value;
				
				//alert("flag_14_val = "+flag_14_val);
				
				if(flag_14_val!=1){
				if (document.all("flag_" + rIndex)[0].checked) 
				{
					iCk=0;
					if (document.all("userPrice_" + rIndex).value=="")
					{
						rdShowMessageDialog("请输入打折信息");
						return false;
					}
					if (!forReal(document.all("userPrice_" + rIndex)))
					{
					    hiddenTip();
					    rdShowMessageDialog("输入格式有误！",0);
						return false;
					}
					if (parseFloat(document.all("userPrice_" + rIndex).value) <= 0 || parseFloat(document.all("userPrice_" + rIndex).value)>1)
					{
						//rdShowMessageDialog("打折信息输入有误，必须小于1");
						rdShowMessageDialog("打折时议价值应在0到1之间的小数,小数点后有两位数字!");
						document.all("userPrice_" + rIndex).select();
						document.all("userPrice_" + rIndex).focus();
						return false;
					}	
					
					var a=document.all("userPrice_"+rIndex).value.indexOf(".");
					if(a!=-1){
						var fStr=document.all("userPrice_"+rIndex).value.substring(a+1);
						if(fStr.length>2){
							rdShowMessageDialog("小数点后保留两位！");
							return false;
						}
					}
					
					if(document.all("isyhhzs_" + rIndex).value=="1") {
					if(document.all("youhuihzs_" + rIndex).value=="") {
						rdShowMessageDialog("请输入最高打信息");
						return false;
					}
					youhuimax=parseFloat(Math.abs(document.all("Rinput" + rIndex + "10").value)*(1-parseFloat(document.all("userPrice_" + rIndex).value))).toFixed(2);
					if(parseFloat(document.all("youhuihzs_" + rIndex).value)>(youhuimax*2).toFixed(2)) {
							rdShowMessageDialog("最高打允许填写的最大值为"+(youhuimax*2).toFixed(2));
						document.all("youhuihzs_" + rIndex).select();
						document.all("youhuihzs_" + rIndex).focus();
							return false;						
					}
					if(parseFloat(document.all("youhuihzs_" + rIndex).value)<youhuimax) {
							rdShowMessageDialog("最高打允许填写的最小值为"+youhuimax);
						document.all("youhuihzs_" + rIndex).select();
						document.all("youhuihzs_" + rIndex).focus();
							return false;						
					}
					
					youhuistr=(parseFloat(document.all("youhuihzs_" + rIndex).value).toFixed(2)-youhuimax).toFixed(2);
				 }
				}
				if (document.all("flag_" + rIndex)[1].checked) 
				{
					iCk=1;
					if (document.all("userPrice_" + rIndex).value=="")
					{
						rdShowMessageDialog("请输入定价信息");
						return false;
					}
					if (!forInt(document.all("userPrice_" + rIndex)))
					{
						return false;
					}
					
					if(document.all("isyhhzs_" + rIndex).value=="1") {
					
						if(document.all("youhuihzs_" + rIndex).value=="") {
						rdShowMessageDialog("请输入最高打信息");
						return false;
					}
					youhuimax=parseFloat(Math.abs(document.all("Rinput" + rIndex + "10").value)-parseFloat(document.all("userPrice_" + rIndex).value)).toFixed(2);
					if(parseFloat(document.all("youhuihzs_" + rIndex).value)>(youhuimax*2).toFixed(2)) {
							rdShowMessageDialog("最高打允许填写的最大值为"+(youhuimax*2).toFixed(2));
						document.all("youhuihzs_" + rIndex).select();
						document.all("youhuihzs_" + rIndex).focus();
							return false;						
					}
					if(parseFloat(document.all("youhuihzs_" + rIndex).value)<youhuimax) {
							rdShowMessageDialog("最高打允许填写的最小值为"+youhuimax);
						document.all("youhuihzs_" + rIndex).select();
						document.all("youhuihzs_" + rIndex).focus();
							return false;						
					}					
					youhuistr=(parseFloat(document.all("youhuihzs_" + rIndex).value).toFixed(2)-youhuimax).toFixed(2);
				}
					
				}
				if (iCk==-1)
				{
					rdShowMessageDialog("请选择议价内容");
					document.all("userPrice_" + rIndex).select();
					document.all("userPrice_" + rIndex).focus();
					return false;
				}
				
			
				retValue += document.all("flag_" + rIndex)[iCk].value + ",";
				retValue += document.all("userPrice_" + rIndex).value + ",";
				if(document.all("isyhhzs_" + rIndex).value=="1") {
					retValue += youhuistr + "|";
				}else {
					retValue +="|";
				}
				
				
				if(document.all("flag_" + rIndex)[iCk].value=="" && document.all("userPrice_" + rIndex).value=="") {
				}else {
					/*
					alert(
									"rIndex = "+rIndex+"\n"+
									"offerids = "+document.all("Rinput" + rIndex + "0").value+"\n"+
									
									"offerids = "+document.all("Rinput" + rIndex + "0").value+"\n"+
									"oldpricess = "+document.all("Rinput" + rIndex + "10").value+"\n"+
									"flagss = "+document.all("flag_" + rIndex)[iCk].value+"\n"+
									"userPrice = "+document.all("userPrice_" + rIndex).value+"\n"
									
							 );
							 */
					var myPacketsd = new AJAXPacket("ajax_checkYJMessage.jsp","正在校验数据请稍后，请稍候......");
					myPacketsd.data.add("offerids",document.all("Rinput" + rIndex + "0").value);
					myPacketsd.data.add("oldpricess",document.all("Rinput" + rIndex + "10").value);
					myPacketsd.data.add("flagss",document.all("flag_" + rIndex)[iCk].value);
					myPacketsd.data.add("userPrice",document.all("userPrice_" + rIndex).value);
					myPacketsd.data.add("opcode","3690");
					core.ajax.sendPacket(myPacketsd,checksimtypesd);
					myPacketsd=null;
				}	
				}else{
					/*
					alert(
									"rIndex = "+rIndex+"\n"+
									"offerids = "+document.all("Rinput" + rIndex + "0").value+"\n"+
									
									"offerids = "+document.all("Rinput" + rIndex + "0").value+"\n"+
									"oldpricess = "+document.all("Rinput" + rIndex + "10").value+"\n"+
									"flagss = "+"0\n"+
									"userPrice = "+document.all("userPrice_" + rIndex).value+"\n"
									
							 );
							 */

				retValue +="0" + ",";
				retValue += document.all("userPrice_" + rIndex).value + ",";
				retValue +="|";
				
				
						var myPacketsd = new AJAXPacket("ajax_checkYJMessage.jsp","正在校验数据请稍后，请稍候......");
					myPacketsd.data.add("offerids",document.all("Rinput" + rIndex + "0").value);
					myPacketsd.data.add("oldpricess",document.all("Rinput" + rIndex + "10").value);
					myPacketsd.data.add("flagss","0");
					myPacketsd.data.add("userPrice",document.all("userPrice_" + rIndex).value);
					myPacketsd.data.add("opcode","3690");
					core.ajax.sendPacket(myPacketsd,checksimtypesd);
					myPacketsd=null;
				}
					if(sflagcheck=="1") {
					break;
					}
				
				
			/*tempQuence = retQuence;
			for(n=0;n<retNum;n++)
			{   
				chPos = tempQuence.indexOf("|");
				fieldNo = tempQuence.substring(0,chPos);
				//alert(fieldNo);
				obj = "Rinput" + rIndex + fieldNo;
				//alert(obj);
					retValue = retValue + document.all(obj).value + "|";
					tempQuence = tempQuence.substring(chPos + 1);
				}
				window.returnValue= retValue;*/
			}
		}
	}
	if(retValue =="")
	{
		rdShowMessageDialog("请选择信息项！",0);
		return false;
	}

if(sflagcheck=="0") {
	opener.getvalue(retValue);
	window.close(); 
}
}

  function checksimtypesd(packet) {
 var retcode = packet.data.findValueByName("retcode");
 var retmsg = packet.data.findValueByName("retmsg");
  var retprodids = packet.data.findValueByName("retprodids");

 		if(retcode!="000000") {
 		rdShowMessageDialog("产品"+retprodids+"校验失败！错误代码："+retcode+"，错误原因："+retmsg);
 			sflagcheck="1";
 		}
 		else {
 			sflagcheck="0";
 		}
 
 }
function allChoose()
{   //复选框全部选中
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    { 
        if(document.fPubSimpSel.elements[i].type=="checkbox")
        {    //判断是否是单选或复选框
            document.fPubSimpSel.elements[i].checked = true;
        }
    }  
}

function cancelChoose()
{   //取消复选框全部选中
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    { 
        if(document.fPubSimpSel.elements[i].type =="checkbox")
        {    //判断是否是单选或复选框
            document.fPubSimpSel.elements[i].checked = false;
        }
    }  
}

function sOnclicks(num) {
			if (document.all("isyhhzs_" + num).value=="1") {
			if(document.all("userPrice_" + num).value!="") {
				var youhuimax;
				if (document.all("flag_" + num)[0].checked) 
				{
						youhuimax=parseFloat(Math.abs(document.all("Rinput" + num + "10").value)*(1-parseFloat(document.all("userPrice_" + num).value))).toFixed(2);
				    document.all("youhuihzs_" + num).value=youhuimax;		
				    //$("#keShowSpan").text("注：优惠为给予优惠的钱，即价格-优惠=最终价钱");	
				    soncheckbox(num);	
				}
				if (document.all("flag_" + num)[1].checked) 
				{
						youhuimax=parseFloat(Math.abs(document.all("Rinput" + num + "10").value)-parseFloat(document.all("userPrice_" + num).value)).toFixed(2);
				    document.all("youhuihzs_" + num).value=youhuimax;		
				    soncheckbox(num);			
				}
			}
		}

}

function soncheckbox(num) {
	

	var retFieldNum = document.fPubSimpSel.retFieldNum.value;
	var retQuence = document.fPubSimpSel.retQuence.value;  //返回字段域的序列
	var retNum = retQuence.substring(0,retQuence.indexOf("|"));
	retQuence = retQuence.substring(retQuence.indexOf("|")+1);
	var tempQuence;
	var rIndex;
	if(retFieldNum == "")	
	{     
		return false;   
	}
	for(i=0;i<document.fPubSimpSel.elements.length;i++)
	{ 
		if (document.fPubSimpSel.elements[i].name=="List")
		{
			if (document.fPubSimpSel.elements[i].checked==true)
			{
				
		var dixianxianshi;
		var youhhzsxianshi;
    rIndex = document.fPubSimpSel.elements[i].RIndex;
			if (document.all("isyhhzs_" + rIndex).value=="1") {
							if (document.all("flag_" + rIndex)[1].checked) 
					{
							dixianxianshi=parseFloat(Math.abs(document.all("Rinput" + rIndex + "10").value)-parseFloat(document.all("userPrice_" + rIndex).value)).toFixed(2);
							youhhzsxianshi=parseFloat(document.all("youhuihzs_" + rIndex).value);
					    $("#keShowSpan").text("注：优惠为给予优惠的钱，即价格-优惠=最终价钱;底线"+dixianxianshi+"，最高打"+youhhzsxianshi+"。");					
					}else if (document.all("flag_" + rIndex)[0].checked) {
						  dixianxianshi=parseFloat(Math.abs(document.all("Rinput" + rIndex + "10").value)*parseFloat(document.all("userPrice_" + rIndex).value)).toFixed(2);
							youhhzsxianshi=parseFloat(document.all("youhuihzs_" + rIndex).value);
					    $("#keShowSpan").text("注：优惠为给予优惠的钱，即价格-优惠=最终价钱;底线"+dixianxianshi+"，最高打"+youhhzsxianshi+"。");			
							
			    }
	
			}else {
							$("#keShowSpan").text("注：优惠为给予优惠的钱，即价格-优惠=最终价钱");
			}
	   
	}
}
}
}

function clearNoNum(obj){   obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  

 obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是. 

  obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.   

obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");

}

function shuzicheck(obj) {
	if(obj.value.indexOf(".")!=-1) {
	obj.value=parseFloat(obj.value).toFixed(2)
 }
}

</SCRIPT>
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">   
    <%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">查询结果</div>
</div>

  <table cellspacing="0">
<TR>
	<Th nowrap>产品代码</Th>
	<Th nowrap>产品名称</Th>
	<Th>服务代码</Th>
	<Th nowrap>服务名称</Th>
	<Th>价格代码</Th>
	<Th nowrap>价格名称</Th>
	<!--<TD nowrap>收费方式</TD>-->
	<Th>收费方式名称</Th>
	<!--<TD nowrap>收取方式</TD>-->
	<Th收取方式名称</Th>
	<Th nowrap>价格</Th>
	<Th nowrap>议价内容</Th>
</TR> 
<%  //绘制界面表头  
     chPos = fieldName.indexOf("|");
     out.print("");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("");
     fieldNum = String.valueOf(tempNum);
%> 

<%
    //根据传入的Sql查询数据库，得到返回结果
	try
 	{      	
            paramsIn = new String[1];
            paramsIn[0] = prodCode;

            //retArray = callView.callFXService("sHGetProdDet", paramsIn, "12", "region", "01");
            %>
            <wtc:service name="sHGetProdDetE" routerKey="region" routerValue="<%=regionCode%>" retcode="sHGetProdDetCode" retmsg="sHGetProdDetMsg" outnum="15" >
            	<wtc:param value="<%=paramsIn[0]%>"/>
            </wtc:service>
            <wtc:array id="sHGetProdDetArr" scope="end"/>
            <%
            
//callView.printRetValue();
      		//result = (String[][])retArray.get(4);
            //allNumStr = (String[][])retArray.get(0);
            //recordNum = result.length;
            recordNum = sHGetProdDetArr.length;
            
            System.out.println("recordNum:" + recordNum);
System.out.println("fieldNum:" + fieldNum);
      		for(int i=0;(i<recordNum) && (i<iEndPos);i++)
      		{
      		//out.println("-"+sHGetProdDetArr[i][12]);
      		//out.println("sHGetProdDetArr[i][14] - "+sHGetProdDetArr[i][14]);
      		//sHGetProdDetArr[0][12]="0";
      		//sHGetProdDetArr[1][12]="1";
       		//sHGetProdDetArr[0][13]="";
      		//sHGetProdDetArr[1][13]="4000";     		
      		//System.out.println("sHGetProdDetArr["+recordNum+"]["+iEndPos+"]="+sHGetProdDetArr[recordNum][iEndPos]);
                if (i < iStartPos) continue;
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR >");
      		    for(int j=0;j<12;j++)
      		    {
      		    System.out.println("sHGetProdDetArr["+i+"]["+j+"]="+sHGetProdDetArr[i][j]);
      		    	if (j==6 || j==8)
      		    		continue;
                    if(j==0)
                    {
                        typeStr = "<TD >&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            " onClick='soncheckbox("+i+")'  onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						}	          		            
                        typeStr = typeStr + (sHGetProdDetArr[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' value='" + 
          		            (sHGetProdDetArr[i][j]).trim() + "'readonly></TD>";          		            
                    }
                    else if(j==7 || j==11)
                    {
          		        inputStr = inputStr + "<TD style='display:none;'>&nbsp;" + (sHGetProdDetArr[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' value='" + 
          		            (sHGetProdDetArr[i][j]).trim() + "'readonly></TD>";          		            
                    } 
                	else
                    {
          		        inputStr = inputStr + "<TD >&nbsp;" + (sHGetProdDetArr[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' value='" + 
          		            (sHGetProdDetArr[i][j]).trim() + "'readonly></TD>";          		            
                    }          		           
      		    }
      		    
      		    if("1".equals(sHGetProdDetArr[i][14])) {
      		    	inputStr += "<TD nowrap><input type=hidden name=flag_14_"+i+" value=1   />打折&nbsp;<select name=userPrice_"+i+"><option value='0.6'>6折</option><option value='0.65'>6.5折</option><option value='0.7'>7折</option><option value='0.75'>7.5折</option><option value='0.8'>8折</option><option value='0.85'>8.5折</option><option value='0.9'>9折</option><option value='0.95'>9.5折</option><option value='1'>无折扣</option></select><input type=hidden name=isyhhzs_"+i+" value="+sHGetProdDetArr[i][12]+"></td>";
      		    }else{
      		    	inputStr += "<TD nowrap><input type=hidden name=flag_14_"+i+" value=0   /><input type=radio name=flag_"+i+" value=0 onClick='sOnclicks("+i+")'>打折&nbsp;<input type=radio name=flag_"+i+" value=1 onClick='sOnclicks("+i+")'>优惠&nbsp;";
      		    	inputStr += "<input type=text v_name='议价内容' size=5 name=userPrice_"+i+" onBlur='sOnclicks("+i+")'><input type=hidden name=isyhhzs_"+i+" value="+sHGetProdDetArr[i][12]+">";
      		    
	      		    if("1".equals(sHGetProdDetArr[i][12])) {
		      		    
		      		       inputStr += "&nbsp;最高打&nbsp;<input type=text v_name='最高打' onblur='shuzicheck(this);soncheckbox("+i+");'  onkeyup='clearNoNum(this)' size=10 name=youhuihzs_"+i+" value='0' ></TD>";
		      		    
	      		    }else {
	      		    inputStr += "</TD>";
	      		  	}
      		  	}
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		}
     	}catch(Exception e){
     		System.out.println(e.toString());
       		
     	}          
%>
<%


%>   
   </tr>
   	<tr>
   		<td colspan="9" style="text-align:right;">
   			<font class="orange" id="keShowSpan">注：优惠为给予优惠的钱，即价格-优惠=最终价钱</font>
   		</td>
  	</tr>
  </table>
    <TABLE cellSpacing=0>
    <tr><td>
<%	
//    int iQuantity = allNumStr.length;
    Page pg = new Page(iPageNumber,iPageSize,recordNum);
	PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>
</td></tr>
</table>
<!------------------------------------------------------>
    <TABLE cellSpacing=0>
        <TR id="footer"> 
            <TD align=center>
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input class='b_foot' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");       
    } 
%> 

<%
				if(selType.compareTo("") != 0)
				{
%>              
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
<%
				}
%>             
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;        
            </TD>
        </TR>
    </TABLE>
	
  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>  
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    

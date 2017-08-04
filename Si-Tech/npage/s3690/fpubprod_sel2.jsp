<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<!-------------------------------------------->
<%/*
* 功能    : 
* 版本    : 1.0
* 日期    : 2003-11-01
* 作者    : zhangwjl
* 版权    : si-tech
* update  @ 2008-5-20
*/%>
<!-------------------------------------------->

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
    Logger logger = Logger.getLogger("fpubprod_sel2.jsp");
    String op_code = request.getParameter("op_code");
    String sm_code = request.getParameter("sm_code");
    String product_code = request.getParameter("product_code");
    String iGrpId = WtcUtil.repNull((String)request.getParameter("grp_id"));
    String iCustId=WtcUtil.repNull((String)request.getParameter("cust_id"));
    String iBizTypeL = WtcUtil.repNull((String)request.getParameter("bizTypeL"));
    System.out.println("---------3690---------iBizTypeL="+iBizTypeL);
    String iBizTypeS = WtcUtil.repNull((String)request.getParameter("bizTypeS"));
    String iBizCode = WtcUtil.repNull((String)request.getParameter("biz_code"));
    
    String catalog_item_id = WtcUtil.repNull((String)request.getParameter("catalog_item_id")); /*diling add*/
    String openLabel = WtcUtil.repNull((String)request.getParameter("openLabel"));/*diling add*/
    String regCode = (String)session.getAttribute("regCode");/*diling add*/
    String  grodDisableStr [] = new String[2];
    grodDisableStr[0] = "SELECT main_type FROM sbiztypecode WHERE external_code = :externalCode";
    grodDisableStr[1] = "externalCode="+catalog_item_id;
    if("link".equals(openLabel)){
   %>
      <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="grodDisableRetCode" retmsg="grodDisableRetMsg" outnum="1"> 
        <wtc:param value="<%=grodDisableStr[0]%>"/>
        <wtc:param value="<%=grodDisableStr[1]%>"/> 
      </wtc:service>  
      <wtc:array id="grodDisableStrRet"  scope="end"/>
   <%
      if("000000".equals(grodDisableRetCode)){
        if(grodDisableStrRet.length>0){
          System.out.println("---------3690---grodDisableStrRet[0][0]="+grodDisableStrRet[0][0]);
          iBizTypeL = grodDisableStrRet[0][0];
        }
      }
    }
    
    String[] paramsIn = null;
    String[][] result = new String[][]{};
    String workno = (String)session.getAttribute("workNo");
    String nopass  = (String)session.getAttribute("password");
    String powerRight = ((String)session.getAttribute("powerRight")).trim();
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    
    String opName = request.getParameter("pageTitle");
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String sqlStr = request.getParameter("sqlStr");
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    System.out.println("sqlStr="+sqlStr);
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    if(selType.compareTo("N") == 0)
    {   selType = "";   }
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";   
    
    String org_id = "";
    String group_id = "";
    String class_code = "";
    String owner_code = "JT";
    String credit_code = "E";
    String [] paraIn = new String[2];
    
    try
    {
        //取运行省份代码 -- 为吉林增加，山西可以使用session
		//String[][] result2  = null;
		sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
		//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
		String province_run = "";
		%>
    	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="1">
        	<wtc:sql><%=sqlStr%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="result2" scope="end" />
    	<%
		if (result2.length>0 && retCode1.equals("000000")) 
		{
			province_run = result2[0][0];
		}
		
		if(province_run.equals("20"))   //吉林
        {
        	sqlStr = "select '9999999', a.group_id, nvl(b.innet_type,'99') "
        	        +"  from dLoginMsg a, sTownCode b "
        	        +" where a.login_no =:workno "
        	        +"   and substr(a.org_code,1,2) = b.region_code"
        	        +"   and substr(a.org_code,3,2) = b.district_code"
        	        +"   and substr(a.org_code,5,3) = b.town_code";
        }
        else
        {
        	//sqlStr = "select a.org_id, a.group_id, b.innet_type from dLoginMsg a, sTownCode b where a.login_no = '" + workno + "' and a.group_id = b.group_id";
			sqlStr = "select a.org_id, a.group_id, nvl(b.innet_type,'99') from dLoginMsg a, sTownCode b where a.login_no =:workno and a.group_id = b.group_id(+)";//luxc20060906修改
        }
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
        if(retArr2.length>0 && retCode2.equals("000000")){
            result = retArr2;
        }
        //result = (String[][])retArray.get(0);
        org_id = result[0][0];
        group_id = result[0][1];
        class_code = result[0][2];
    }
    catch(Exception e){
        logger.error("查询sSmSelPAttr错误!");
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>黑龙江BOSS-<%=pageTitle%></TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<SCRIPT type=text/javascript>
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
  //var tempQuence;
  var tmpArr = retQuence.split('|');
  if(retFieldNum == "")	
  {     return false;   }
   //返回单条记录
  var vLen = document.fPubSimpSel.elements.length;
  //for(i=0;i<vLen;i++)
  //{ 
  var i = $("#label").val()*19;
          var element = document.fPubSimpSel.elements[i];
	      if (element.name=="List")
	      {    //判断是否是单选或复选框
			   if (element.checked==true)
			   {     //判断是否被选中
			         rIndex = element.RIndex;
			         //tempQuence = retQuence;
			         for(n=0;n<retNum;n++)
			         {   
			            //chPos = tempQuence.indexOf("|");
			            //fieldNo = tempQuence.substring(0,chPos); 
			            obj = "Rinput" + rIndex + "0" + tmpArr[n];
			            //alert(obj);
			            retValue = retValue + document.all(obj).value + "|";
			            /* begin add for 关于IMS融合通信营帐优化、新增资费配置和经分报表开发需求的函@2014/8/13 */
									if("<%=sm_code%>" == "RH" && "<%=iBizTypeL%>" == "01"){
										if(n==2){
											if(document.all(obj).value == "Y"){ //集团产品可以议价
												if(document.all.retValue.value == ""){ //议价信息
													 rdShowMessageDialog("请点击议价按钮,获取议价信息！",1);
	    										 return false;
												}
											}
										}
									}
									/* end add for 关于IMS融合通信营帐优化、新增资费配置和经分报表开发需求的函@2014/8/13 */
			            //tempQuence = tempQuence.substring(chPos + 1);
			         }
					 window.returnValue= retValue;
					 //break;
               }
	    }
	//}		
	if(retValue =="")
	{
	    rdShowMessageDialog("请选择产品信息！",0);
	    return false;
	}
	opener.getValueProd2(retValue,document.all.retValue.value);
    window.close();
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

//调用公共界面，进行产品信息选择
function getInfo_Prod_detail(prodCode)
{
	document.all("prod_" + prodCode).checked=true;
    var pageTitle = "产品议价";
    var fieldName = "产品代码|产品名称|服务代码|服务名称|价格代码|价格名称|收费方式|收费方式名称|收取方式|收取方式名称|价格值|";
	var sqlStr = "";
    var selType = "M";    //'S'单选；'M'多选
    var retQuence = "1|0|";
    var retToField = "prodPriceStr|";

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,prodCode));
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,prodCode)
{
    var path = "fpubprod_detail_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	path = path + "&prodCode=" + prodCode;
    retInfo = window.open(path,"","height=450, width=900,top=100,left=250,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

function getvalue(retValue)
{
	//alert(retValue);
	document.all.retValue.value=retValue;
	
}

function doCheck(index){
    $("#label").val(index);
}
</SCRIPT>
</HEAD>
<body style="overflow-x:hidden">
<FORM method=post name="fPubSimpSel">   
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">查询结果</div>
	</div>	
  <table cellspacing="0">
    <tr>
<%  //绘制界面表头  
     chPos = fieldName.indexOf("|");
     out.print("<TR>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<TH nowrap>&nbsp;&nbsp;" + valueStr + "</TH>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);
     
    try
 	{
			fieldNum = "3";
      		String choiceFlag = "0";

            paramsIn = new String[21];
            paramsIn[0] = workno;
            paramsIn[1] = nopass;
            paramsIn[2] = sm_code;
            paramsIn[3] = op_code;
            paramsIn[4] = org_id;
            paramsIn[5] = group_id;
            paramsIn[6] = owner_code;
            paramsIn[7] = class_code;
            paramsIn[8] = credit_code;
            paramsIn[9] = powerRight;
            paramsIn[10] = "10";
            paramsIn[11] = "";
            paramsIn[12] = "u01";
            paramsIn[13] = product_code;
            paramsIn[14] = iGrpId;
            paramsIn[15] = iBizTypeL;
            paramsIn[16] = iBizTypeS;
            paramsIn[17] = iBizCode;
            paramsIn[18] = "";
            paramsIn[19] = "";
            paramsIn[20] = iCustId;
        
            int iOutNum = 18;
            String sOutNum = String.valueOf(iOutNum);
        %>
            <wtc:service name="sPubMProdSelE" routerKey="region" routerValue="<%=regionCode%>" retcode="sPubSubProdSelCode" retmsg="sPubSubProdSelMsg" outnum="<%=sOutNum%>" >
            	<wtc:param value="<%=paramsIn[0]%>"/>
                <wtc:param value="<%=paramsIn[1]%>"/> 
                <wtc:param value="<%=paramsIn[2]%>"/>
                <wtc:param value="<%=paramsIn[3]%>"/>
                <wtc:param value="<%=paramsIn[4]%>"/>
                
                <wtc:param value="<%=paramsIn[5]%>"/>
                <wtc:param value="<%=paramsIn[6]%>"/>
                <wtc:param value="<%=paramsIn[7]%>"/>
                <wtc:param value="<%=paramsIn[8]%>"/>
                <wtc:param value="<%=paramsIn[9]%>"/>
                
                <wtc:param value="<%=paramsIn[10]%>"/>
                <wtc:param value="<%=paramsIn[11]%>"/>
                <wtc:param value="<%=paramsIn[12]%>"/>
                <wtc:param value="<%=paramsIn[13]%>"/>
                    
                <wtc:param value="<%=paramsIn[14]%>"/>
                <wtc:param value="<%=paramsIn[15]%>"/>
                <wtc:param value="<%=paramsIn[16]%>"/>
                <wtc:param value="<%=paramsIn[17]%>"/>
               	<wtc:param value="<%=paramsIn[18]%>"/>
               	<wtc:param value="<%=paramsIn[19]%>"/>
               	<wtc:param value="<%=paramsIn[20]%>"/>
            </wtc:service>
            <wtc:array id="sPubSubProdSelArr" scope="end"/>
        <%
System.out.println("# sPubSubProdSelCode = "+sPubSubProdSelCode);
System.out.println("# sPubSubProdSelMsg  = "+sPubSubProdSelMsg );
      		int recordNum = sPubSubProdSelArr.length;
System.out.println("# recordNum = "+recordNum);
      		for(int i=0;i<recordNum;i++)
      		{
      		   String tdClass = ((i%2)==1)?"Grey":"";
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
      		    for(int j=0;j<iOutNum;j++)
      		    {
                    if(j==3)
                    {
                        typeStr = "<TD title=\'"+(sPubSubProdSelArr[i][j]).trim()+"\' class='"+tdClass+"'>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' id='prod_"+(sPubSubProdSelArr[i][3]).trim()+"' onClick='doCheck(\""+i+"\");' style='cursor:hand' RIndex='" + i + "'" + 
	          		            "onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						}	          		            
                        typeStr = typeStr + (sPubSubProdSelArr[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "'  value='" + 
          		            (sPubSubProdSelArr[i][j]).trim() + "'readonly></TD>";          		            
                    }
                    else if(j==13)
                    {      		        
                    /************liucm******************/
          		             String[][] favInfo = (String[][])session.getAttribute("favInfo");
          		              int infoLen = favInfo.length;
          		              boolean pwrf = false;
  													String tempStr = "";
  													for(int ll=0;ll<infoLen;ll++)
  													{
    														tempStr = (favInfo[ll][0]).trim();
    														if(tempStr.compareTo("a290") == 0)
    														{
      															pwrf = true;
    														}
	
  												}
  												/***********liucm end************/
                       if(pwrf){
                       if ((sPubSubProdSelArr[i][13]).trim().equals("Y")){
          		        inputStr = inputStr + "<TD class='"+tdClass+"'>&nbsp;" + (sPubSubProdSelArr[i][13]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            (sPubSubProdSelArr[i][13]).trim() + "'readonly>";
          		            }else{
          		            inputStr = inputStr + "<TD class='"+tdClass+"'>&nbsp;" + "N" + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            "N" + "'readonly>";
          		        	 }
          		          }else{
          		            inputStr = inputStr + "<TD class='"+tdClass+"'>&nbsp;" + "N" + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            "N" + "'readonly>";
          		        	 }
          		        	
          		        	
          		        	
          		            
          		         	if ((sPubSubProdSelArr[i][13]).trim().equals("Y")){
          		         			if(pwrf){
          		         						inputStr += "<a href=# onclick=\"getInfo_Prod_detail('"+(sPubSubProdSelArr[i][3]).trim()+"')\">" + "&nbsp;-->&nbsp;点击议价&nbsp;" + "</A>";
          		         						inputStr += "</TD>";
          		        			}
          		        	}
                    }
                    else if(j==4)
                    {
          		
                    	inputStr = inputStr + "<TD class='"+tdClass+"'>&nbsp;" + (sPubSubProdSelArr[i][4]).trim();
          		        inputStr = inputStr + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            (sPubSubProdSelArr[i][4]).trim() + "'readonly></TD>";
                    }
                    else if(("ML".equals(sm_code) || "AD".equals(sm_code)) && (j==15 || j==16))
                    {
          		        inputStr = inputStr + "<TD title=\'"+(sPubSubProdSelArr[i][j]).trim()+"\' class='"+tdClass+"'>&nbsp;" + (sPubSubProdSelArr[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "'  value='" + 
          		            (sPubSubProdSelArr[i][j]).trim() + "'readonly></TD>"; 
                    }
                    else if(j==17){
                        inputStr = inputStr + "<TD title=\'"+(sPubSubProdSelArr[i][j]).trim()+"\' class='"+tdClass+"' style='display:none;'>&nbsp;" + (sPubSubProdSelArr[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "'  value='" + 
          		            (sPubSubProdSelArr[i][j]).trim() + "'readonly></TD>"; 
                    }
                    else
                    {
          		        inputStr = inputStr + "<TD title=\'"+(sPubSubProdSelArr[i][j]).trim()+"\' class='"+tdClass+"' style='display:none;'>&nbsp;" + (sPubSubProdSelArr[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "'  value='" + 
          		            (sPubSubProdSelArr[i][j]).trim() + "'readonly></TD>";          		            
                    }
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		    }
          	}catch(Exception e){
    			e.printStackTrace();
         	}
%>
  
   </tr>
  </table>


<!------------------------------------------------------>
    <TABLE cellspacing="0">
        <TR> 
            <TD id="footer">
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input  name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input  name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");       
    } 
%> 

<%
				if(selType.compareTo("") != 0)
				{
%>              
                <input  name=commit onClick="saveTo()" class="b_foot" style="cursor:hand" type=button value=确认>&nbsp;
<%
				}
%>             
                <input  name=back onClick="window.close()" class="b_foot" style="cursor:hand" type=button value=返回>&nbsp;        
            </TD>
        </TR>
    </TABLE>

  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <input type='hidden' id='label' name='label' value='' />
  <input type="hidden" name="retValue"> 
  <!------------------------>  
 <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</body></HTML>    

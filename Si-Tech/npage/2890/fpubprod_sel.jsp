<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.18
 模块:EC产品订购
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%request.setCharacterEncoding("gbk");%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%

	String op_name ="黑龙江BOSS-集团产品查询";
	String opName = request.getParameter("pageTitle");

    //得到输入参数
    String return_code,return_message;
    String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
    String[] paramsIn = null;


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
    String powerRight = (String)session.getAttribute("powerRight");
    String regCode = (String)session.getAttribute("regCode");
    
    String op_code = request.getParameter("op_code");
    String sm_code = request.getParameter("sm_code");
    String direct_id = request.getParameter("direct_id");
    String product_attr ="";

	String group_id = "";
    String org_id = "";
    
	String sqlStr = "";
	//取运行省份代码 -- 为吉林增加，山西可以使用session
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
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
        	        +" where a.login_no = '" + workno + "' "
        	        +"   and substr(a.org_code,1,2) = b.region_code(+)"
        	        +"   and substr(a.org_code,3,2) = b.district_code(+)"
        	        +"   and substr(a.org_code,5,3) = b.town_code(+)";
        }
        else
        {
        	sqlStr = "select org_id, a.group_id, nvl(b.innet_type,'99') from dLoginMsg a, sTownCode b where a.login_no = '" + workno + "' and a.group_id = b.group_id(+)";
        }
        System.out.print("sqlStr:"+sqlStr);
        //retArray = callView.sPubSelect("3",sqlStr);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultTemp" scope="end" />
<%
       
        result = resultTemp;
        if (result[0][0].trim().length() == 0) {
            throw new Exception("查询操作员入网操作权限失败！");
        }
        org_id = result[0][0];
        group_id = result[0][1];
        class_code = result[0][2];
        
        System.out.println("org_id="+org_id);
        System.out.println("group_id="+group_id);
        System.out.println("class_code="+class_code);
    }
    catch(Exception e){
       
    }

    String owner_code = "JT";
    String credit_code = "E";
    String product_level = "1"; //主产品
    String business_code = "0"; //开户

    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");

	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 1000;
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
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0">

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
      var tempQuence;
      if(retFieldNum == "")	
      {     return false;   }
       //返回单条记录
          for(i=0;i<document.fPubSimpSel.elements.length;i++)
          { 
    		      if (document.fPubSimpSel.elements[i].name=="List")
    		      {    //判断是否是单选或复选框
    				   if (document.fPubSimpSel.elements[i].checked==true)
    				   {     //判断是否被选中
        			         rIndex = document.fPubSimpSel.elements[i].RIndex;
        			         tempQuence = retQuence;
        			         for(n=0;n<retNum;n++)
        			         {   
        			            chPos = tempQuence.indexOf("|");
        			            fieldNo = tempQuence.substring(0,chPos);
        			            obj = "Rinput" + rIndex + fieldNo;
        			            retValue = retValue + document.all(obj).value + "|";
        			            tempQuence = tempQuence.substring(chPos + 1);
        			         }
                                                           
        					 window.returnValue= retValue;
                       }
    		    }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("请选择信息项！",0);
		    return false;
		}
		 
		//opener.getvalue(retValue);
		opener.getvalue(retValue, document.all.retValue.value);
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
    var path = "../s3500/fpubprod_detail_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	path = path + "&prodCode=" + prodCode;
    retInfo = window.open(path,"","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

function getvalue(retValue)
{
	
	document.all.retValue.value=retValue;
}

</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">   
<%@ include file="/npage/include/header_pop.jsp" %>
  <table cellspacing="0">
	<TR>
		<TH nowrap>&nbsp;&nbsp;产品代码</TH>
		<TH nowrap>&nbsp;&nbsp;产品名称</TH>
		<TH nowrap>&nbsp;&nbsp;业务代码</TH>
		<TH nowrap>&nbsp;&nbsp;业务名称</TH>
		<!--TD>&nbsp;&nbsp;是否允许议价</TD></TR--> 
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
            paramsIn = new String[15];
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
            paramsIn[10] = product_level;
            paramsIn[11] = product_attr;
            paramsIn[12] = business_code;
            paramsIn[13] = "";
            paramsIn[14] = direct_id;
            
            //retArray = callView.callFXService("sPubMProdSelAdc", paramsIn, "17", "region", "01");
			//callView.printRetValue();
%>
			<wtc:service name="sPubMProdSelAdc" routerKey="region" routerValue="01" retcode="retCode3" retmsg="retMsg3" outnum="17">			
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
			</wtc:service>	
			<wtc:array id="resultTemp0" start="0" length="2" scope="end"/>
			<wtc:array id="resultTemp3" start="3" length="1" scope="end"/>
			<wtc:array id="resultTemp4" start="4" length="10" scope="end"/>
			<wtc:array id="resultTemp13" start="13" length="2" scope="end"/>
			<wtc:array id="resultTemp15" start="15" length="1" scope="end"/>
			<wtc:array id="resultTemp16" start="16" length="1" scope="end"/>
<%
      		result = resultTemp4;
            allNumStr = resultTemp0;
            recordNum = result.length;
            System.out.println("recordNum:" + recordNum);
					System.out.println("fieldNum:" + fieldNum);
      		for(int i=0;(i<recordNum) && (i<iEndPos);i++)
      		{
      			String tdClass=(i%2==0)?"Grey":"";
                if (i < iStartPos) continue;
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
      		      System.out.println("recordNum: " + j);                
      		    	if(j==0)
                {
                        typeStr = "<TD class="+tdClass+">&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' id='prod_"+(resultTemp3[i][0]).trim()+"' style='cursor:hand' RIndex='" + i + "'" + 
	          		            " onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
												}	          		            
                        typeStr = typeStr + (resultTemp3[i][0]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (resultTemp3[i][0]).trim() + "'readonly></TD>";          		            
                 }
                    /*
                    else
                    {        		        
          		        inputStr = inputStr + "<TD>&nbsp;" + (((String[][])retArray.get(4))[i][0]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (((String[][])retArray.get(4))[i][0]).trim() + "'readonly></TD>";          		            
                    } */
                    if(j==1)
                    {        		        
                    	if ((resultTemp13[i][0]).trim().equals("Y"))
                    		inputStr = inputStr + "<TD class="+tdClass+">" + (resultTemp4[i][0]).trim();
                    	else
                    		inputStr = inputStr + "<TD class="+tdClass+">&nbsp;" + (resultTemp4[i][0]).trim();
          		        inputStr = inputStr + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (resultTemp4[i][0]).trim() + "'readonly></TD>";          		            
                    }
                    
                    if(j==2)
                    {        		        
                    	inputStr = inputStr + "<TD class="+tdClass+">&nbsp;" + (resultTemp15[i][0]).trim();
          		        inputStr = inputStr + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (resultTemp15[i][0]).trim() + "'readonly></TD>";          		            
                    }
                    
                    if(j==3)
                    {        		        
                    	inputStr = inputStr + "<TD class="+tdClass+">&nbsp;" + (resultTemp16[i][0]).trim();
          		        inputStr = inputStr + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (resultTemp16[i][0]).trim() + "'readonly></TD>";          		            
                    }
                    
                    /*      luxc为检查封议价,此处还原时要同时还原表头 (上面)    		           
                    if(j==2)
                    {        		        
          		        inputStr = inputStr + "<TD>&nbsp;" + (((String[][])retArray.get(13))[i][0]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (((String[][])retArray.get(13))[i][0]).trim() + "'readonly>";
          		         	if ((((String[][])retArray.get(13))[i][0]).trim().equals("Y"))
          		         		inputStr += "<a href=# onclick=\"getInfo_Prod_detail('"+(((String[][])retArray.get(3))[i][0]).trim()+"')\">" + "&nbsp;-->&nbsp;点击议价&nbsp;" + "</A>";
          		         	inputStr += "</TD>";
                    }
                    */
                             		           
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
				System.out.println("--------------------99999999999999999");
      		}
      		System.out.println("--------------------96788");
     	}catch(Exception e){
     		System.out.println(e.toString());
       		
     	}          
%>
<%


%>   
   </tr>
  </table>

	<div style="position:relative;font-size:12px;">

<%	
//    int iQuantity = allNumStr.length;
    Page pg = new Page(iPageNumber,iPageSize,recordNum);
	PageView view = new PageView(request,out,pg);
   	view.setVisible(true,true,0,0);  
%>
   	</div>  

<!------------------------------------------------------>
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD id="footer" algin="center">
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input class='button' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input class='button' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");       
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
    </TBODY>
    </TABLE>
	
    <TR> 
    <BODY>
   <TABLE>

  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <input type="hidden" name="retValue">  
  <!------------------------>  
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    

<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by leimd @ 2009-04-15
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%
    String opName = "新集团产品查询";
    //得到输入参数
    String[][] result = new String[][]{};
    String[] paramsIn = null;

    Logger logger = Logger.getLogger("fpubprod_sel.jsp");
    String [] paraIn = new String[2];
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
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = (String)session.getAttribute("regCode");
    
    String op_code = request.getParameter("op_code");
    String sm_code = request.getParameter("sm_code");
    String product_attr = request.getParameter("product_attr");
    String oldMainProduct = request.getParameter("oldMainProduct");
    String iGrpId = WtcUtil.repNull((String)request.getParameter("grpId"));    
System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%iGrpId="+iGrpId);
	String group_id = "";
    String org_id = "";
    
	String sqlStr = "";
	//取运行省份代码 -- 为吉林增加，山西可以使用session
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	
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
        
        paraIn[0] = sqlStr;    
        paraIn[1]="workno="+workno;
%>
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="3" >
        	<wtc:param value="<%=paraIn[0]%>"/>
        	<wtc:param value="<%=paraIn[1]%>"/> 
        </wtc:service>
        <wtc:array id="retArr2" scope="end"/>
<%

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
    String product_level = "10"; //主产品
    String business_code = "u03"; //资费变更

    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");

	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
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
%>  

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>黑龙江BOSS-集团产品查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<SCRIPT type="text/javascript"> 
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
      var vShouldPay = "";
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
        			            obj = "Rinput" + rIndex +"0"+ fieldNo;
        			            retValue = retValue + document.all(obj).value + "|";
        			            tempQuence = tempQuence.substring(chPos + 1);
        			            /* begin add for 关于IMS融合通信营帐优化、新增资费配置和经分报表开发需求的函@2014/8/13 */
      			            	if("<%=sm_code%>" == "RH"){
      			            		if(n == 2){
      			            			if(document.all(obj).value == "Y"){//集团产品可以议价
      			            				if(document.all.retValue.value == ""){ //议价信息
      			            					rdShowMessageDialog("请点击议价按钮,获取议价信息！",1);
	    										 				return false;
      			            				}
      			            			}
      			            		}
      			            	}
      			            	/* end add for 关于IMS融合通信营帐优化、新增资费配置和经分报表开发需求的函@2014/8/13 */
        			         }
                                                           
        					 window.returnValue= retValue;
        					 vShouldPay = document.all("Rinput"+ rIndex +"020").value;
                       }
    		    }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("请选择信息项！",0);
		    return false;
		}
		
		opener.getvalue(retValue, document.all.retValue.value);
		opener.setShouldPay(vShouldPay);
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
    retInfo = window.open(path,"","height=450, width=900,top=50,left=20,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

function getvalue(retValue)
{
	document.all.retValue.value=retValue;
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
	<TR align="center">
	    <TH nowrap>产品代码 </TH>
	    <TH nowrap>产品名称 </TH>
	    <TH nowrap>是否允许议价 </TH>
	    <TH nowrap>生效方式 </TH>
	    <%if("ML".equals(sm_code) || "AD".equals(sm_code)){%>
	        <TH nowrap>业务代码</TH>
	        <TH nowrap>业务名称</TH>
	    <%}%>
    </TR> 
<% 
 //绘制界面表头  
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
     if("ML".equals(sm_code) || "AD".equals(sm_code)){
        fieldNum = "17";
     }else{
        fieldNum = String.valueOf(tempNum);
     }
%> 

<%
    //根据传入的Sql查询数据库，得到返回结果
	try
 	{      	
        paramsIn = new String[14];
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
        paramsIn[13] = oldMainProduct;
        
        int iOutNum = 0;
        if("ML".equals(sm_code) || "AD".equals(sm_code)){
            iOutNum = 21;
        }else{
            iOutNum = 15;
        }
        String sOutNum = String.valueOf(iOutNum);
       %>
			<wtc:service name="sPubMProdSelE" routerKey="region" routerValue="<%=regionCode%>" retcode="sPubMProdSelCode" retmsg="sPubMProdSelMsg" outnum="<%=sOutNum%>" >
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
			        
			    <wtc:param value="<%=iGrpId%>"/>
			    <wtc:param value=""/>
                <wtc:param value=""/>
                <wtc:param value=""/>
			</wtc:service>
			<wtc:array id="sPubMProdSelArr" scope="end"/>
      <%
            
            recordNum = sPubMProdSelArr.length;
            System.out.println("@:******************************");
            System.out.println("@:******************************");
            System.out.println("@:******************************");
            System.out.println("@:******************************");
            System.out.println("@:******************************");
            System.out.println("recordNum:" + recordNum);
			System.out.println("fieldNum:" + fieldNum);
			System.out.println("iEndPos:" + iEndPos);
			System.out.println("iStartPos:" + iStartPos);
      		for(int i=0;(i<recordNum) && (i<iEndPos);i++)
      		{
                if (i < iStartPos) continue;
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        typeStr = "<TD>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' id='prod_"+(sPubMProdSelArr[i][3]).trim()+"' style='cursor:hand' RIndex='" + i + "'" + 
	          		            " onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						}	          		            
                        typeStr = typeStr + (sPubMProdSelArr[i][3]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            (sPubMProdSelArr[i][3]).trim() + "'readonly></TD>";          		            
                    }
                    if(j==1)
                    {        		        
                    	if ((sPubMProdSelArr[i][13]).trim().equals("Y"))
                    		inputStr = inputStr + "<TD>" + (sPubMProdSelArr[i][4]).trim();
                    	else
                    		inputStr = inputStr + "<TD>&nbsp;" + (sPubMProdSelArr[i][4]).trim();
          		        inputStr = inputStr + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            (sPubMProdSelArr[i][4]).trim() + "'readonly></TD>";          		            
                    }          		           
                    if(j==2)
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
                       if ((sPubMProdSelArr[i][13]).trim().equals("Y")){
          		        inputStr = inputStr + "<TD>&nbsp;" + (sPubMProdSelArr[i][13]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            (sPubMProdSelArr[i][13]).trim() + "'readonly>";
          		            }else{
          		            inputStr = inputStr + "<TD>&nbsp;" + "N" + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            "N" + "'readonly>";
          		        	 }
          		          }else{
          		            inputStr = inputStr + "<TD>&nbsp;" + "N" + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            "N" + "'readonly>";
          		        	 }
          		        	
          		        	
          		        	
          		            
          		         	if ((sPubMProdSelArr[i][13]).trim().equals("Y")){
          		         			if(pwrf){
          		         						inputStr += "<a href=# onclick=\"getInfo_Prod_detail('"+(sPubMProdSelArr[i][3]).trim()+"')\">" + "&nbsp;-->&nbsp;点击议价&nbsp;" + "</A>";
          		         						inputStr += "</TD>";
          		        			}
          		        	}
                    }
                    if(j==3)
                    {        		        
          		
                    	inputStr = inputStr + "<TD>&nbsp;" + (sPubMProdSelArr[i][14]).trim();
          		        inputStr = inputStr + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            (sPubMProdSelArr[i][14]).trim() + "'readonly></TD>";
                    }
                    if(j==15||j==16)
                    {
                        inputStr = inputStr + "<TD>&nbsp;" + (sPubMProdSelArr[i][j]).trim()+"</TD>";
                    }
                    
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		    if(sPubMProdSelArr[i].length==21){
                  	out.print("<input type=hidden class='button'  id='Rinput"+i+"020' value='" + 
          		            (sPubMProdSelArr[i][20]).trim() +"' readonly  />");
                }else{
                  	out.print("<input type=hidden class='button'  id='Rinput"+i+"020' value='-1' readonly  />");
                }
      		}
     	}catch(Exception e){
     		System.out.println(e.toString());
       		
     	}          
%>
	</tr>
</table>

<TABLE cellSpacing=0>
  	 <TR>
         <TD>
<%	
    Page pg = new Page(iPageNumber,iPageSize,recordNum);
	PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>
		</TD>
    </TR>
</table>

<TABLE cellSpacing=0>
    <TBODY>
        <TR id="footer"> 
            <TD>
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
    </TBODY>
    </TABLE>


  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <input type="hidden" name="retValue"> 
  <!------------------------>  
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>    

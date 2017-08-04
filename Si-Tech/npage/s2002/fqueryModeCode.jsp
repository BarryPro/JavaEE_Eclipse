<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.util.ArrayList" %>

<%

	
	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String opName = "查询成员资费";
     //得到输入参数
     ArrayList retArray = new ArrayList();
     ArrayList retArray1 = new ArrayList();
     String return_code,return_message;
     String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
	
	String mode_code 	=  request.getParameter("mode_code")==null?"":request.getParameter("mode_code");
	String sm_code 	     = request.getParameter("sm_code")==null?null:request.getParameter("sm_code");
    String regionCode 	=  request.getParameter("regionCode")==null?"":request.getParameter("regionCode");
    System.out.println("# sm_code = "+sm_code);
%> 	

<%
/*
SQL语句       sql_content
选择类型       sel_type   
标题                title      
字段1名称     field_name1
*/
    String retToField 	= request.getParameter("retToField");    
    String pageTitle 	= request.getParameter("pageTitle");
    String fieldNum 	     = request.getParameter("pageNumber")==null?"":request.getParameter("fieldNum");
    String fieldName 	= request.getParameter("fieldName");
    
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

    String sqlFilter 	= "";

    if (mode_code.trim().length() > 0)
        sqlFilter = sqlFilter + " and a.offer_id  like '%" + mode_code +"%'"; 
          
    //String sqlStr =  "SELECT nvl(COUNT(*),0) num FROM product_offer a, region b ,sregioncode c WHERE 1=1 AND a.offer_id = b.offer_id AND b.group_id = c.group_id AND offer_attr_type <> 'JT' " + sqlFilter;
    String sqlStr =  "SELECT nvl(COUNT(*),0) num FROM product_offer a, region b ,sregioncode c ,band d WHERE a.offer_id = b.offer_id AND b.group_id = c.group_id AND offer_attr_type <> 'JT' and a.band_id=d.band_id and d.sm_code='"+sm_code+"' and substr(a.user_range,1,1)=any('1','4') and a.eff_date<sysdate and a.exp_date>sysdate " + sqlFilter;
	//String sqlStr1 = "SELECT * FROM (SELECT a.offer_id,a.offer_name,c.region_code,rownum id FROM product_offer a, region b ,sregioncode c WHERE a.offer_id = b.offer_id AND b.group_id = c.group_id AND offer_attr_type <> 'JT' " + sqlFilter + ") where id <"+iEndPos+" and id>="+iStartPos;
    String sqlStr1 = "SELECT * FROM (SELECT a.offer_id,a.offer_name,c.region_code,rownum id FROM product_offer a, region b ,sregioncode c ,band d WHERE a.offer_id = b.offer_id AND b.group_id = c.group_id AND offer_attr_type <> 'JT' and a.band_id=d.band_id and d.sm_code='"+sm_code+"' and substr(a.user_range,1,1)=any('1','4') and a.eff_date<sysdate and a.exp_date>sysdate " + sqlFilter + ") where id <"+iEndPos+" and id>="+iStartPos;
    String selType = request.getParameter("selType");
    System.out.println("sqlStr1===="+sqlStr1);

    String retQuence = request.getParameter("retQuence");
    System.out.println("sqlStr===="+sqlStr);    
    //展现单选
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
    String op_name = "黑龙江BOSS-个人产品查询";
    int recordNum = 0;
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=op_name%></TITLE>
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
        				     //alert(document.fPubSimpSel.elements[i].value);
        			         rIndex = document.fPubSimpSel.elements[i].RIndex;
        			         tempQuence = retQuence;
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
                             //alert(retValue);                                  
        					 window.returnValue= retValue;
                       }
    		    }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("请选择信息项！",0);
		    return false;
		}
		//alert(retValue);                                  
		opener.getValueModeCode(retValue);
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

//选择地区代码
function queryRegionCode()
{
	window.open("f2889_qryRegionCode.jsp","","height=600,width=400,scrollbars=yes");
}

//查询产品代码
function queryModeCode()
{   
	document.fPubSimpSel.action="fqueryModeCode.jsp";
     document.fPubSimpSel.submit();			
}	
</SCRIPT>
<!--**************************************************************************************-->
</HEAD>
<BODY>
       
<FORM method=post name="fPubSimpSel">
<input type="hidden" name="retToField" value="<%=retToField%>">
	<input type="hidden" name="fieldName" value=<%=fieldName%>>
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">集团业务参数配置</div>
</div>

<!--<table cellspacing=0>
	<tr>
			<TD class='blue'>地区代码</TD>
			<TD>
			<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10 name=regionCode  value="<%=regionCode%>"  maxlength=20 readonly ></input><font class='orange'>*</font>
			     <input class="b_text" type="button" name="query_regioncode" onclick="queryRegionCode()" value="选择">
				</TD>
			<TD class='blue'>产品代码</TD>
			<TD colspan=2>
		<input type=text  v_type="string"  v_must=1 v_minlength=8 v_maxlength=8 name=mode_code   value="<%=mode_code%>"   maxlength=8 ></input><font class='orange'>*</font>
				<input class="b_text" type="button" name="query_servicecode" onclick="queryModeCode()" value="查询">
			</TD>
		</tr>
  </table>-->
    <table cellspacing="0">
    <tr>
<TR>
	<TH>产品代码</TH>
	<TH>产品名称</TH>
	<TH>地市归属代码</TH>
</TR> 
<%  //绘制界面表头
      //System.out.println("2---------------------fieldName="+fieldName);
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
         //System.out.println("2---------------------fieldNum="+fieldNum);
%> 

<%
    //根据传人的Sql查询数据库，得到返回结果
	try
 	{      	
      		//retArray = callView.sPubSelect(fieldNum,sqlStr1);
			//retArray1 = callView.sPubSelect("1",sqlStr);
			%>
                <wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
                	<wtc:sql><%=sqlStr%></wtc:sql>
                </wtc:pubselect>
                <wtc:array id="retArr" scope="end"/>
            <%
			recordNum = Integer.parseInt(retArr[0][0].trim());
			%>
                <wtc:pubselect name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="<%=fieldNum%>" routerKey="region" routerValue="<%=regionCode%>">
                	<wtc:sql><%=sqlStr1%></wtc:sql>
                </wtc:pubselect>
                <wtc:array id="retArr1" scope="end"/>
            <%
			//System.out.println("1---------------------------");
      		//result = (String[][])retArray.get(0);
			//allNumStr = (String[][])retArray1.get(0);
            result = retArr1;

      		for(int i=0;i<recordNum;i++)
      		{
      		    //System.out.println("2---------------------fieldNum="+fieldNum);
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR bgcolor='#EEEEEE'>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        typeStr = "<TD>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            "onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						}	          		            
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
	                    }
	                    else
	                    {        		        
          		        inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                         }          		            
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		}
     	}catch(Exception e){
       		e.printStackTrace();
     	}
%>
<%


%>   
   </tr>
  </table>
<table cellspacing=0>
    <tr><td>
<%	
    int iQuantity = recordNum;
    //int iQuantity = 500;
     Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>
</td></tr>
</table>
<!------------------------------------------------------>
    <table cellspacing=0>
    <TBODY>
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
    </TBODY>
    </TABLE>
   	<!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="fieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>

  <input type="hidden" name="selType" value=<%=selType%>>
     <!------------------------>  
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    

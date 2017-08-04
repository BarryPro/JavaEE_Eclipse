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
	String op_name ="黑龙江BOSS-集团客户查询";

    //得到输入参数
    String return_code,return_message;
    String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
%> 	

<%
/*
SQL语句        sql_content
选择类型       sel_type   
标题           title      
字段1名称      field_name1
*/
	String opName = request.getParameter("pageTitle");
    String pageTitle 	= request.getParameter("pageTitle");
    String fieldNum 	= "";
    String fieldName 	= request.getParameter("fieldName");
	String iccid 			= request.getParameter("iccid");
    String cust_id		= request.getParameter("cust_id");
    String unit_id 		= request.getParameter("unit_id");
    String sqlFilter 	= "";
	String regionCode	=	request.getParameter("regionCode");
	int 	iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

    if (iccid.trim().length() > 0)
        sqlFilter = sqlFilter + " and a.id_iccid = '" + iccid + "'";
    if (unit_id.trim().length() > 0)
        sqlFilter = sqlFilter + " and b.unit_id = " + unit_id;
    if (cust_id.trim().length() > 0)
        sqlFilter = sqlFilter + " and b.cust_id = " + cust_id;
    if ( regionCode.trim().length() > 0 )
    		sqlFilter = sqlFilter + " and a.region_code = '" + regionCode +"'"; 
  
  /*      
	String sqlStr2 =  "select a.owner_type from dCustDoc a, dCustDocOrgAdd b where a.cust_id = b.cust_id " + sqlFilter;
	retArray = callView.sPubSelect("1",sqlStr2);
	result = (String[][])retArray.get(0);
	
	System.out.println(result[0][0]);
	
	if(!result[0][0].equals("04"))
	{
	%>
	<script>
	rdShowMessageDialog("不是EC集团用户，不能进行该操作！",0);
	window.close();
	</script>
	<%
	}
		*/
	/*wuxy alter 20090116 多取一个group_id并返回*/	
    String sqlStr = "select nvl(count(*),0) num from dCustDoc a, dCustDocOrgAdd b where a.owner_type='04' and a.cust_id = b.cust_id " + sqlFilter;
	String sqlStr1 = "select * from (select a.id_iccid, a.cust_id, a.cust_name, b.unit_id, b.unit_name, a.region_code||a.district_code||town_code,a.group_id, rownum id from dCustDoc a, dCustDocOrgAdd b where a.owner_type='04' and a.cust_id = b.cust_id " + sqlFilter + ") where id <"+iEndPos+" and id>="+iStartPos;

    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    System.out.print("..........sqlStr="+sqlStr);
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
<TITLE>黑龙江BOSS-集团客户查询</TITLE>
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
		opener.getvaluecust(retValue);
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
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">   
	<%@ include file="/npage/include/header_pop.jsp" %>
  <table cellspacing="0">
    <tr>
		<TR>
			<TH nowrap>&nbsp;&nbsp;证件号码</TH>
			<TH nowrap>&nbsp;&nbsp;集团客户ID </TH>
			<TH nowrap>&nbsp;&nbsp;集团客户名称</TH>
			<TH nowrap>&nbsp;&nbsp;集团编码</TH>
			<TH nowrap>&nbsp;&nbsp;集团名称</TH>
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
    //根据传人的Sql查询数据库，得到返回结果
	try
 	{      	
      		//retArray = callView.sPubSelect(fieldNum,sqlStr1);
      		//retArray1 = callView.sPubSelect("1",sqlStr);
%>
			<wtc:pubselect name="sPubSelect" outnum="7">
			<wtc:sql><%=sqlStr1%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="resultTemp" scope="end"/>
				
			<wtc:pubselect name="sPubSelect" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1Temp" scope="end"/>
<%
			System.out.println("resultTemp====="+fieldNum);
      		result = resultTemp;
			allNumStr = result1Temp;
            int recordNum = Integer.parseInt(allNumStr[0][0].trim());
            //wuxy alter 20090513 解决group_id显示问题
      		for(int i=0;i<recordNum;i++)
      		{
      			String tdClass=(i%2==0)?"Grey":"";
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
      		         //System.out.println("result["+i+"]["+j+"]="+result[i][j]);
                    if(j==0)
                    {
                        typeStr = "<TD class="+tdClass+">&nbsp;";
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
                    else if (j == (Integer.parseInt(fieldNum) - 1)||j==5)
                	{
          		        inputStr = inputStr + "<TD class="+tdClass+">" + "" + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                	}
                    else
                    {        		        
          		        inputStr = inputStr + "<TD class="+tdClass+">&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }          		            
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		}
     	}catch(Exception e){
       		
     	}          
%>
<%


%>   
   </tr>
  </table>
<%	
    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	PageView view = new PageView(request,out,pg); 
%>
<div style="position:relative;font-size:12px;">
<%
   	view.setVisible(true,true,0,0);       
%>
</div>

<!------------------------------------------------------>
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD id="footer">
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
  <!------------------------>  
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    

<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-16
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

<%@ page import="java.util.ArrayList" %>

<%
    String opName = "产品类型查询";
    String op_name ="黑龙江BOSS-集团产品查询";
    
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    //得到输入参数
    ArrayList retArray = new ArrayList();
	  ArrayList retArray1 = new ArrayList();
    String return_code,return_message;
    String[][] result = new String[][]{};
    String[] paramsIn = null;
	  String[][] allNumStr =  new String[][]{};
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    Logger logger = Logger.getLogger("fpubprod_sel.jsp");
%> 	

<%
    String fieldNum = "";
    String pageTitle = request.getParameter("pageTitle");
    String fieldName = request.getParameter("fieldName");
	  String op_code = request.getParameter("op_code");
    String sm_code = request.getParameter("sm_code");
    String groupFlag = request.getParameter("groupFlag")==null?"N":request.getParameter("groupFlag");
	  String grpProductCode = request.getParameter("grpProductCode");
	  //System.out.println("grpProductCode="+grpProductCode);
	  String product_attr = "";
	  String grpProductAttr = request.getParameter("grpProductAttr");
    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 25;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;

	  String sqlStr = null;
	  String sqlStr1 = null;

		//取运行省份代码 -- 为吉林增加，山西可以使用session
		//String[][] result2  = null;
		sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
		//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
		String province_run = "";
    %>
    	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="1">
        	<wtc:sql><%=sqlStr%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr1" scope="end" />
	<%
		
		if (retArr1.length>0 && retCode1.equals("000000")) 
		{
			province_run = retArr1[0][0];
		}
	
	
		if(groupFlag.equals("Y") || grpProductAttr==null )
		{
			sqlStr = "select nvl(count(*),0) num from sSmSelPAttr a, sProductAttrCode b where a.product_attrcode = b.product_attr  and a.sm_code = '" + sm_code + "'";
	    	
			sqlStr1 = "select * from (select a.product_attrcode, b.attr_name, rownum id from sSmSelPAttr a, sProductAttrCode b where a.product_attrcode = b.product_attr  and a.sm_code = '" + sm_code + "'  and a.product_attrcode not in('IG','IH','II')) where id <"+iEndPos+" and id>="+iStartPos;
		}
		else
		{
			sqlStr = "select nvl(count(*),0) num from sSmSelPAttr a, sProductAttrCode b where a.product_attrcode = b.product_attr  and a.sm_code = '" + sm_code + "' and product_attrcode='"+grpProductAttr+"'";
	    	
			sqlStr1 = "select * from (select a.product_attrcode, b.attr_name, rownum id from sSmSelPAttr a, sProductAttrCode b where a.product_attrcode = b.product_attr  and a.sm_code = '" + sm_code + "'  and product_attrcode='"+grpProductAttr+"' and a.product_attrcode not in('IG','IH','II')) where id <"+iEndPos+" and id>="+iStartPos;
			
		}
	

    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    System.out.print("sqlStr="+sqlStr);
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
function saveTo()
{
      var rIndex;        //选择框索引
      var retValue = ""; //返回值
      var chPos;         //字符位置
      var obj;
      var obj1;
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
        				     //alert("111"+document.fPubSimpSel.elements[i].value);
        			         rIndex = document.fPubSimpSel.elements[i].RIndex;
        			         tempQuence = retQuence;
        			         for(n=0;n<retNum;n++)
        			         {   
        			            chPos = tempQuence.indexOf("|");
        			            fieldNo = tempQuence.substring(0,chPos);
        			            //alert("222"+fieldNo);
        			            obj = "Rinput" + rIndex + fieldNo;
        			            obj1="Rinput"+ rIndex + eval(fieldNo+1);	//add
        			        
        			            retValue = retValue + document.all(obj).value + "|"+ document.all(obj1).value+ "|";
        			   			
        			            tempQuence = tempQuence.substring(chPos + 1);
        			         }
                 //        alert("444"+retValue);                                  
        					 window.returnValue= retValue;
                       }
    		    }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("请选择信息项！");
		    return false;
		}
		opener.getvalueProdAttr(retValue);
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
<div class="title">
	<div id="title_zi">查询结果</div>
</div>
  <table cellspacing="0">
<TR align=center>
    <TH>产品代码</TH>
    <TH>产品名称</TH>
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
     System.out.println("fieldNum === "+fieldNum);
%> 

<%
    //根据传入的Sql查询数据库，得到返回结果
	try
 	{      	
      		//retArray = callView.sPubSelect(fieldNum,sqlStr1);
    %>
    	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2"  outnum="3">
        	<wtc:sql><%=sqlStr1%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr2" scope="end" />
	<%
	    if(retArr2.length>0 && retCode2.equals("000000")){
	        result = retArr2;
	    }
			//retArray1 = callView.sPubSelect("1",sqlStr);
	%>
    	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3"  outnum="1">
        	<wtc:sql><%=sqlStr%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr3" scope="end" />
	<%
	    if(retArr3.length>0 && retCode3.equals("000000")){
	        allNumStr = retArr3;
	    }
      		//result = (String[][])retArray.get(0);
			//allNumStr = (String[][])retArray1.get(0);

            int recordNum = Integer.parseInt(allNumStr[0][0].trim());
            for(int i=0;i<recordNum;i++)
      		{
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        typeStr = "<TD>";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            " onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						}	          		            
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }
                    else
                    {        		        
          		        inputStr = inputStr + "<TD>" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' value='" + 
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
  <TABLE cellSpacing=0>
    <tr><td>
<%	
    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>
</td></tr>
</table>

<!------------------------------------------------------>
    <TABLE cellSpacing=0>
    <TBODY>
        <TR id="footer"> 
            <TD>
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>");
        out.print("<input class='b_foot' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>");       
    } 
%> 

<%
				if(selType.compareTo("") != 0)
				{
%>              
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>
<%
				}
%>             
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>
            </TD>
        </TR>
    </TBODY>
    </TABLE>

  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>  
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    

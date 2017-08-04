<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-15
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>

<%

    //得到输入参数
    String[][] result = new String[][]{};
    String[] paramsIn = null;
	  String[][] allNumStr =  new String[][]{};
    Logger logger = Logger.getLogger("fpubprod_sel.jsp");
%> 	
<%
    String opName           = "获取成员资费信息";

    String opCode           = WtcUtil.repNull((String)request.getParameter("opCode"));
    String idNo             = WtcUtil.repNull((String)request.getParameter("id_no"));
    String productId        = WtcUtil.repNull((String)request.getParameter("grpProdCode"));
    String regionCode       = WtcUtil.repNull((String)request.getParameter("regionCode"));
    String smCode           = WtcUtil.repNull((String)request.getParameter("smCode"));
    String opType           = "";
    String bizCode          = WtcUtil.repNull((String)request.getParameter("bizCode"));
    String payFlag          = WtcUtil.repNull((String)request.getParameter("payFlag"));
    
    if("AD".equals(smCode) || "ML".equals(smCode) || "MA".equals(smCode)){
        opType = WtcUtil.repNull((String)request.getParameter("opType"));
    }else{
        opType = "";
    }
    

    String fieldNum = "";
    String pageTitle = request.getParameter("pageTitle");
    String fieldName = request.getParameter("fieldName");
	  String op_code = request.getParameter("op_code");
    String sm_code = request.getParameter("sm_code");
    String groupFlag = request.getParameter("groupFlag")==null?"N":request.getParameter("groupFlag");
	  String grpProductCode = request.getParameter("grpProductCode");
	  String  product_id = request.getParameter("product_id");	
	  String  mebMonthFlag = request.getParameter("mebMonthFlag");
	  String mode_type  = request.getParameter("mode_type");
	  String pay_type = request.getParameter("payType");

	  //System.out.println("grpProductCode="+grpProductCode);
	  String product_attr = "";
	  String grpProductAttr = request.getParameter("grpProductAttr");
	   
	  //分页设置
    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 25;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;

	  String sqlStr = null;
	  String sqlStr1 = null;
	  
  	if ("1".equals(pay_type)){
		 pay_type="0";
		 }else{
		 pay_type="1";
	   }
	  
			sqlStr = "select nvl(count(*),0)"
						+" FROM sColorMemberMode a, sColorMode b, PRODUCT_OFFER c, REGION d, sregionCode e "  
    				    +" WHERE a.region_code = '"+regionCode+"'"
    					+" AND a.grp_prodcode = '"+product_id+"'"  
    					+" AND a.month_flag = 'Y'"  
    					+" AND a.meb_prodcode = b.product_code"  
    					+" AND a.region_code = b.region_code"  
    					+" AND c.eff_date  < sysdate"  
    					+" AND c.exp_date  > sysdate"  
    					+" AND e.group_id = d.group_id"  
    					+" AND c.offer_id = d.offer_id     "  
    					+" AND a.region_code = e.region_code"  
    					+" AND b.PRODUCT_CODE = to_char(c.offer_id)"  
    					+" AND b.MODE_BIND = '0'"  ; 
								
 	  /* modify by qidp @ 2009-10-21
			sqlStr1 = "select distinct meb_prodcode,mode_name"
								+" from sColorMemberMode a, scolorMode b,sbillmodecode c "
								+" where a.region_code='"+regionCode+"'"
								+" and   a.grp_prodcode='"+product_id+"'"
								+" and   a.month_flag='Y'"
								+" and   a.meb_prodcode=b.product_code"
								+" and   c.start_time<sysdate  and c.stop_time>sysdate"
								+" and   b.PRODUCT_CODE=c.MODE_CODE"
								+" and   b.MODE_BIND='0'";
							*/	
				 sqlStr1 = "SELECT distinct meb_prodcode, offer_name  "  
    				    +" FROM sColorMemberMode a, sColorMode b, PRODUCT_OFFER c, REGION d, sregionCode e "  
    				    +" WHERE a.region_code = '"+regionCode+"'"
    					+" AND a.grp_prodcode = '"+product_id+"'"  
    					+" AND a.month_flag = 'Y'"  
    					+" AND a.meb_prodcode = b.product_code"  
    					+" AND a.region_code = b.region_code"  
    					+" AND c.eff_date  < sysdate"  
    					+" AND c.exp_date  > sysdate"  
    					+" AND e.group_id = d.group_id"  
    					+" AND c.offer_id = d.offer_id     "  
    					+" AND a.region_code = e.region_code"  
    					+" AND b.PRODUCT_CODE = to_char(c.offer_id)"  
    					+" AND b.MODE_BIND = '0'"  ; 

								
	if(mebMonthFlag.equals("N"))
		{
		  System.out.println("AAAA"+mebMonthFlag);
			sqlStr=sqlStr+" and   b.group_flag='"+pay_type+"'";
			sqlStr1=sqlStr1+" and   b.group_flag='"+pay_type+"'";
    }		
       System.out.println("mebMonthFlag****="+mebMonthFlag);					  
       System.out.println("sqlStr####="+sqlStr);
       System.out.println("sqlStr1$$$$="+sqlStr1);	
         
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
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
<TITLE>包年转包月产品查询</TITLE>

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
      var retFieldNum = document.fpubmebProdCodesel.retFieldNum.value;
      var retQuence = document.fpubmebProdCodesel.retQuence.value;  //返回字段域的序列
      var retNum = retQuence.substring(0,retQuence.indexOf("|"));
      retQuence = retQuence.substring(retQuence.indexOf("|")+1);
      var tempQuence;
      if(retFieldNum == "")	
      {     return false;   }
          //返回单条记录
          for(i=0;i<document.fpubmebProdCodesel.elements.length;i++)
          { 
    		      if (document.fpubmebProdCodesel.elements[i].name=="List")
    		      {    //判断是否是单选或复选框
    				   if (document.fpubmebProdCodesel.elements[i].checked==true)
    				   {     //判断是否被选中
        				     //alert(document.fpubmebProdCodesel.elements[i].value);
        			         rIndex = document.fpubmebProdCodesel.elements[i].RIndex;
        			         tempQuence = retQuence;
        			         for(n=0;n<retNum;n++)
        			         {   
        			            chPos = tempQuence.indexOf("|");
        			            fieldNo = tempQuence.substring(0,chPos);
        			            //alert(fieldNo);
        			            obj = "Rinput" + rIndex +"0"+ fieldNo;
        			            //alert(obj);
        			            retValue = retValue + document.all(obj).value + "|";
        			            tempQuence = tempQuence.substring(chPos + 1);
        			         }
                   //alert("retValue="+retValue);                                  
        					 window.returnValue= retValue;
                }
    		    }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("请选择信息项！",0);
		    return false;
		}
		opener.getmatureProd(retValue);
		window.close(); 
}
	
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>

<BODY>
<FORM method=post name="fpubmebProdCodesel"> 
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">包年转包月产品查询</div>
	</div>

  <table  cellspacing="0">
    <tr>
<TR><TD class="blue">&nbsp;&nbsp;产品代码</TD><TD class="blue">&nbsp;&nbsp;产品名称</TD></TR> 
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

    %>
        <wtc:service name="sGetAddProduct" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6" >
            <wtc:param value=""/>
            <wtc:param value="<%=idNo%>"/>
            <wtc:param value="Y"/>
            <wtc:param value="<%=productId%>"/>
            <wtc:param value="<%=regionCode%>"/>
            <wtc:param value="<%=smCode%>"/>
            <wtc:param value="<%=opType%>"/>
            <wtc:param value="<%=opCode%>"/>
            <wtc:param value=""/>
            <wtc:param value="<%=bizCode%>"/>
            <wtc:param value="<%=payFlag%>"/>
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>

<% 	
      	//retArray = callView.sPubSelect(fieldNum,sqlStr1);
			  //retArray1 = callView.sPubSelect("1",sqlStr);
        //result = result_l ;
			 // allNumStr = allNumStr_l;
        result = retArr;
        
           // int recordNum = Integer.parseInt(allNumStr[0][0].trim());
           int recordNum = result.length;
            for(int i=0;i<recordNum;i++)
      		  {
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR >");
      		    for(int j=2;j<4;j++)
      		    {
                    if(j==2)
                    {
                        typeStr = "<TD>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            " onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						            }	          		            
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }
                    else
                    {        		        
          		        inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }          		           
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		}
     	}catch(Exception e){
       		
     	}          
%>

   </tr>
  </table>
<!------------------------------------------------------>
    <TABLE  cellSpacing="0">
    <TBODY>
        <TR id="footer"> 
            <TD align=center >
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

  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>  
  <%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY></HTML>    
	

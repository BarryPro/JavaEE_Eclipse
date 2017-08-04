<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 个人彩铃产品变更6712
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%	request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
    String opCode="6712";
	String opName="个人彩铃产品变更";
	String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String regionCode = (String)session.getAttribute("regCode");
	String UsingCRProdCode = request.getParameter("UsingCRProdCode");	
	String mode_type  = request.getParameter("mode_type");
	String month_num = request.getParameter("month_num");
	String power_right = (String)session.getAttribute("powerRight");
  String  groupId = (String)session.getAttribute("groupId");
	//分页设置
    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 25;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;
    if(month_num == null)
    {
    	month_num = "1";
    }
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
<TITLE>黑龙江BOSS-彩铃产品查询</TITLE>
</HEAD>
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
        			            obj = "Rinput" + rIndex + fieldNo;
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
		opener.getmebProdCode(retValue);
		window.close(); 
}
	
</SCRIPT>
</HEAD>
<BODY>
<FORM method=post name="fpubmebProdCodesel">
	<%@ include file="/npage/include/header_pop.jsp" %> 
<div class="title">
		<div id="title_zi">产品列表</div>
	</div>	
<table cellspacing="0">
	<TR align='center'><th>产品代码</th><th>产品名称</th></TR> 
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
    String[] inParam = new String[2];
   /*
	inParam[0] = "select a.mode_code,a.mode_code||'->'||mode_name from sbillmodecode a,scolormode b "+
				" where a.mode_code like 'CR%' and a.start_time<sysdate  and a.stop_time>sysdate "+
				" and a.power_right<=:power_right "+ " and a.mode_status='Y' "+
				" and a.region_code=:regionCode and a.mode_type=:mode_type"+
				" and a.region_code = b.region_code and a.MODE_CODE = b.PRODUCT_CODE"+
				" and a.mode_code !=:UsingCRProdCode"+
				" and b.mode_bind='0'"+
				" and b.month_num =:month_num";
	*/
	inParam[0] = "SELECT to_char(a.offer_id), a.offer_id || '->' || a.offer_name         "+
				  		 "FROM product_offer a, region b, dchngroupinfo c, scolormode d "+
							 "WHERE a.offer_id = b.offer_id                                 "+
							 "  AND b.GROUP_ID = c.parent_group_id                          "+
							 "  AND to_char(a.offer_id) = rtrim(d.product_code)             "+
							 "  AND a.eff_date < SYSDATE                                    "+
							 "  AND a.exp_date > SYSDATE                                    "+
							 "  AND b.right_limit <= '"+power_right+"'                           "+
							 "  AND c.GROUP_ID = '"+groupId+"'                                   "+	
							 "  AND a.offer_attr_type = '"+mode_type+"'                          "+							 						 							 
							 "  AND a.offer_id !='"+UsingCRProdCode+"'                           "+
							 "  AND a.state = 'A'                                           "+
							 "  AND d.mode_bind = '0'                                       "+
							 "  AND a.offer_id != 32318                                       "+
							 "  AND d.month_num = '"+month_num+"'                                "+
							 "	and a.offer_id not in ('40449','40425','40426','40427','40428','40429','40430','40431','40432','40433','40434','40435','40436')"
							 ;
	inParam[1] = "power_right="+power_right+",groupId="+groupId+",mode_type="+mode_type+",UsingCRProdCode="+UsingCRProdCode+",month_num="+month_num;
%>
	<wtc:service name="sPubSelect"  outnum="2" >
		<wtc:param value="<%=inParam[0]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%	  
  /*
	String sqlStr = "select nvl(count(*),0) num from sbillmodecode a,scolormode b "+
				" where a.mode_code like 'CR%' and a.start_time<sysdate  and a.stop_time>sysdate "+
				" and a.power_right<=" + power_right + " and a.mode_status='Y' "+
				" and a.region_code='" + regionCode + "' and a.mode_type='"+mode_type+"'"+
				" and a.region_code = b.region_code and a.MODE_CODE = b.PRODUCT_CODE"+
				" and a.mode_code !='"+UsingCRProdCode+"'"+
				" and b.mode_bind='0'"+
				" and b.month_num = "+month_num;
	*/
	String sqlStr  = "select nvl(count(*),0) num                                "+
				  		 "FROM product_offer a, region b, dchngroupinfo c, scolormode d "+
							 "WHERE a.offer_id = b.offer_id                                 "+
							 "  AND b.GROUP_ID = c.parent_group_id                          "+
							 "  AND to_char(a.offer_id) = rtrim(d.product_code)             "+
							 "  AND a.eff_date < SYSDATE                                    "+
							 "  AND a.exp_date > SYSDATE                                    "+
							 "  AND b.right_limit <= '"+power_right.trim()+"'               "+
							 "  AND c.GROUP_ID ='"+groupId+"'                               "+	
							 "  AND a.offer_attr_type = '"+mode_type+"'                     "+							 						 							 
							 "  AND a.offer_id !='"+UsingCRProdCode+"'                      "+
							 "  AND a.state = 'A'                                           "+
							 "  AND d.mode_bind = '0'                                       "+
							 "  AND a.offer_id != 32318                                       "+
							 "  AND d.month_num = "+month_num +
							 "  and a.offer_id not in ('40449','40425','40426','40427','40428','40429','40430','40431','40432','40433','40434','40435','40436')";				
	System.out.println("sqlStr=======1111"+sqlStr);
	
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="allNumStr" scope="end" />
<%	  
			System.out.println("allNumStr.length======="+allNumStr.length);
            int recordNum = 0;
            if(allNumStr.length>0){
            	recordNum = Integer.parseInt(allNumStr[0][0].trim());
            	System.out.println("#####################leimd->recordNum->"+recordNum);
            }
            String tbclass="";
            for(int i=0;i<recordNum;i++)
      		  {
      		  	tbclass=(i%2==0)?"Grey":"";
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR align='center'>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        typeStr = "<TD class='"+tbclass+"'>&nbsp;";
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
          		        inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }          		           
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		}
          
%>
</tr>
</table>
<table cellSpacing="0">
	<tr>
		<td>
			<%	
			    int iQuantity = 0;
			    iQuantity = recordNum;
			    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
				PageView view = new PageView(request,out,pg); 
			   	view.setVisible(true,true,0,0);  
			%>
		</td>
	</tr>
<!------------------------------------------------------>

	<TR> 
		<TD align=center>
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");       
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
	

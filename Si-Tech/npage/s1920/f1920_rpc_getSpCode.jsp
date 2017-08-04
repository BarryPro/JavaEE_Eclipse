<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-04 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String opCode = "1920";
	String opName = "企业信息查询";
	
  String pageTitle 	= "SP企业信息查询";
  String fieldNum 	= "";
  String fieldName 	= "sp企业代码|sp企业名称|sp企业英文名称|";    
  String sqlFilter 	= "";
  String retToField = request.getParameter("retToField") == null?"":request.getParameter("retToField");
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 12;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	
	String phoneNo = request.getParameter("phoneno");
	String oprcode = request.getParameter("optype");
	String busytype = request.getParameter("busytype");

	String sqlStr="select a.spid spid,decode(a.SPNAME,null,a.spshortname,a.SPNAME) spname,a.spenname spenname,rownum id from ddsmpspinfo a,oneboss.sOBSpType b where a.spid between b.beginspid and b.endspid  and a.spstatus='A' and b.biztype='"+busytype+"' and  a.spid in (select distinct c.spid from ddsmpSpBizInfo c)"; 
	if(oprcode.equals("99")||oprcode.equals("07")||oprcode.equals("02")){
		sqlStr="select a.spid spid,decode(a.SPNAME,null,a.spshortname,a.SPNAME) spname,a.spenname spenname,rownum id from ddsmpspinfo a,oneboss.sOBSpType b where a.spid between b.beginspid and b.endspid and b.biztype='"+busytype+"' and a.spid in (select distinct c.spid from ddsmpordermsg c where c.phone_no='"+phoneNo+"' and c.serv_code='"+busytype+"' and c.opr_code<>'02' and c.opr_code<>'07' and c.opr_code<>'17')";
	}
	else if(oprcode.equals("04")){
		sqlStr="select a.spid spid,decode(a.SPNAME,null,a.spshortname,a.SPNAME) spname,a.spenname spenname,rownum id from oneboss.ddsmpspinfo a,oneboss.sOBSpType b where a.spid between b.beginspid and b.endspid  and b.serv_code='"+busytype+"' and a.spid in (select distinct c.spid from ddsmpordermsg c where c.phone_no='"+phoneNo+"' and c.serv_code='"+busytype+"' and (c.opr_code='06' or c.opr_code='05' or c.opr_code='01'))";
	}
	else if(oprcode.equals("05")){
		sqlStr="select a.spid spid,decode(a.SPNAME,null,a.spshortname,a.SPNAME) spname,a.spenname spenname,rownum id from ddsmpspinfo a,oneboss.sOBSpType b where a.spid between b.beginspid and b.endspid  and a.spstatus='A' and b.biztype='"+busytype+"' and a.spid in (select distinct c.spid from ddsmpspinfo c where c.phone_no='"+phoneNo+"' and c.serv_code='"+busytype+"' and (c.opr_code='04'))";
	}
	
	String sqlStr1="select count(*) from ("+sqlStr+")";
	sqlStr="select *  from ("+sqlStr+") where id <"+iEndPos+" and id>="+iStartPos;
	System.out.println("###########sqlStr->"+sqlStr);
	
  String selType = request.getParameter("selType");
  String retQuence = request.getParameter("retQuence");

  selType = "radio"; 
  retQuence = "1|0|";
  //=====================
  int chPos = 0;
  String typeStr = "";
  String inputStr = "";
  String valueStr = "";   
%>

<HTML>
	<HEAD>
<TITLE><%=pageTitle%></TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<SCRIPT type=text/javascript>
function winReturn(val){
	window.returnValue=val;	
}
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
      var retToFieldBack= "<%=retToField%>";
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
		    rdShowMessageDialog("请选择信息项！");
		    return false;
		}
		opener.getvalue2(retValue,retToFieldBack);   /* 个性化配置 */
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
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
	<%@ include file="/npage/include/header_pop.jsp" %>
  <table cellspacing="0">
  	   
<%  //绘制界面表头  
     chPos = fieldName.indexOf("|");
     out.print("<TR align='center'>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<th>&nbsp;&nbsp;" + valueStr + "</th>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);
     String outNum = String.valueOf(tempNum+1);
%> 
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode1" retmsg="retMsg1" outnum="<%=outNum%>">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
			
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="allNumStr" scope="end" />		
<%
		int recordNum = 0;
		if(allNumStr!=null&&allNumStr.length>0){
			recordNum = Integer.parseInt(allNumStr[0][0].trim());
		}
    System.out.println("############################recordNum"+recordNum);  
          
    String tbclass="";
		for(int i=0;i<result.length;i++)
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
      		            " value='"+(result[i][j]).trim()+"' onclick='winReturn(this.value)'" + ">"; 
									}	          		            
                  typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
    		            " id='Rinput" + i + j + "' class='button' value='" + 
    		            (result[i][j]).trim() + "'readonly></TD>";          		            
              }
              else
              {        		        
    		        inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
    		            " id='Rinput" + i + j + "' class='button' value='" + 
    		            (result[i][j]).trim() + "'readonly></TD>";          		            
              }          		            
		    }
		    out.print(typeStr + inputStr);
		    out.print("</TR>");
		}
%>   
   </tr>
   <tr>
   	<td colspan="<%=fieldNum%>" align="center">
	   	<div style="position:relative;font-size:12px;">
	   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<%	
	    int iQuantity = recordNum;
	    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
			PageView view = new PageView(request,out,pg); 
	   	view.setVisible(true,true,0,0);       
	%>
		  </div>
		</td>
  </tr>
  </table>


<!------------------------------------------------------>
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD id="footer">
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
	<%@ include file="/npage/include/footer_pop.jsp" %>

  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------> 
</FORM>
</BODY></HTML>    


<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<!-------------------------------------------->
<%/*
* ����    :
* �汾    : 1.0
* ����    : 2003-11-01
* ����    : zhangwjl
* �޸�    : wanglei on 20100107 ����Զ�ѡ��һ��
* ��Ȩ    : si-tech
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

<%

    String opName = request.getParameter("pageTitle");
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
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
    
    
    String starLevel = request.getParameter("starLevel");
    String giftCode = request.getParameter("giftCode");
    String giftName = request.getParameter("giftName");
    String subType = request.getParameter("subType");
    String accountMark = request.getParameter("accountMark");
    String sortType = request.getParameter("sortType");
    String present_point = request.getParameter("present_point");
    String sqlStr ="select e.itemid, e.itemname, e.itempoint, e.maintype, e.subtype,e.num from ";
		sqlStr+= " (select c.itemid, c.itemname, c.itempoint, c.maintype, c.subtype,nvl(d.num,0) num "+
	           "  from     (select h.itemid itemid, h.itemname itemname, h.itempoint itempoint, h.maintype maintype, h.subtype subtype "+
					   "  from (select distinct a.itemid itemid, a.itemname itemname, g.itempoint itempoint, a.maintype maintype, a.subtype subtype "+
					   "  from dbcustadm.TOBMARKCHANGEMSG a,dbcustadm.TOBPOINTLISTMSG g where a.itemid=g.itemid  ";
		
		sqlStr +=  " and g.starlevel="+starLevel+") h ";	
					 
		 sqlStr += "  , SITEMLOSTCFG b where h.itemid = (trim(b.itemid(+))) "+
					     "  and b.itemid is null ";		
					 
		if(giftCode.length() !=0 || giftName.length() !=0 || subType.length() !=0 || accountMark.length() !=0 || "0".equals(sortType))
		{
			if(giftCode.length() !=0 ){
			sqlStr += " and h.itemid='"+giftCode+"' ";
			}
			if(giftName.length() !=0 ){
				sqlStr += " and h.itemname like'%"+giftName+"%' ";
			}
		  if(subType.length() !=0){
				sqlStr += " and h.subtype ='"+subType+"' ";
			}
		
			sqlStr += " ) c  , (select count(*) num, itemid from WITEMCHGMSG group by itemid) d where c.itemid =(trim(d.itemid(+))) ";
			if(accountMark.length() !=0){
				sqlStr += " and c.itempoint <="+accountMark;
			}
		  if("0".equals(sortType)){
				sqlStr += ") e order by e.itempoint";
			}else
			{
				sqlStr += ") e order by e.num desc  ";
			}
		}else
		{		
			sqlStr += " ) c  ,(select count(*) num, itemid from WITEMCHGMSG group by itemid) d where c.itemid =(trim(d.itemid(+))) ";
			sqlStr += " and c.itempoint <="+present_point;
			sqlStr += ") e order by e.num desc  ";
		}
    
    
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������BOSS-<%=pageTitle%></TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<SCRIPT type=text/javascript>
function saveTo()
{
      var rIndex;        //ѡ�������
      var retValue = ""; //����ֵ
      var chPos;         //�ַ�λ��
      var obj;
      var fieldNo;        //���������к�
      var retFieldNum = document.fPubSimpSel.retFieldNum.value;
      var retQuence = document.fPubSimpSel.retQuence.value;  //�����ֶ��������
      var retNum = retQuence.substring(0,retQuence.indexOf("|"));
      retQuence = retQuence.substring(retQuence.indexOf("|")+1);
      //var tempQuence;
      var tmpArr = retQuence.split('|');
      if(retFieldNum == "")
      {     return false;   }
       //���ص�����¼
          for(i=0;i<document.fPubSimpSel.elements.length;i++)
          {
    		      if (document.fPubSimpSel.elements[i].name=="List")
    		      {    //�ж��Ƿ��ǵ�ѡ��ѡ��
    				   if (document.fPubSimpSel.elements[i].checked==true)
    				   {     //�ж��Ƿ�ѡ��
        			         rIndex = document.fPubSimpSel.elements[i].RIndex;
        			         //tempQuence = retQuence;
        			         for(n=0;n<retNum;n++)
        			         {
        			            //chPos = tempQuence.indexOf("|");
        			            //fieldNo = tempQuence.substring(0,chPos);
        			            obj = "Rinput" + rIndex + tmpArr[n];
        			            retValue = retValue + document.all(obj).value + "|";
        			            //tempQuence = tempQuence.substring(chPos + 1);
        			         }
        					 window.returnValue= retValue
                       }
    		    }
    		}
		if(retValue =="")
		{
		    rdShowMessageDialog("��ѡ����Ϣ�",0);
		    return false;
		}

		window.close();
}

function allChoose()
{   //��ѡ��ȫ��ѡ��
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    {
        if(document.fPubSimpSel.elements[i].type=="checkbox")
        {    //�ж��Ƿ��ǵ�ѡ��ѡ��
            document.fPubSimpSel.elements[i].checked = true;
        }
    }
}

function cancelChoose()
{   //ȡ����ѡ��ȫ��ѡ��
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    {
        if(document.fPubSimpSel.elements[i].type =="checkbox")
        {    //�ж��Ƿ��ǵ�ѡ��ѡ��
            document.fPubSimpSel.elements[i].checked = false;
        }
    }
}

/*
 * @author wanglei
 * @date   20100107
 * @desc   once the page has only a single row
 					 then it will be selected automatic
 */
function SimpBySel(){
	var _rows = document.getElementById('tabData').rows;
	if(_rows.length == 3){
		document.getElementById('List').checked=true;
	}
	return;
}

</SCRIPT>
</HEAD>
<body style="overflow-x:hidden" onload=SimpBySel()>
<FORM method=post name="fPubSimpSel">
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">��ѯ���</div>
	</div>
  <table cellspacing="0" id="tabData">
    <tr>
<%  //���ƽ����ͷ
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
%>
  <wtc:pubselect name="sPubSelect" outnum="<%=fieldNum%>">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end"/>
<%
    //���ݴ��˵�Sql��ѯ���ݿ⣬�õ����ؽ��

      		int recordNum = result.length;
      		for(int i=0;i<recordNum;i++)
      		{
      		   String tdClass = ((i%2)==1)?"Grey":"";
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        typeStr = "<TD title=\'"+(result[i][j]).trim()+"\' class='"+tdClass+"'>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" +
	          		            "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
						}
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "'  value='" +
          		            (result[i][j]).trim() + "'readonly></TD>";
                    }
                    else
                    {
          		        inputStr = inputStr + "<TD title=\'"+(result[i][j]).trim()+"\' class='"+tdClass+"'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "'  value='" +
          		            (result[i][j]).trim() + "'readonly></TD>";
                    }
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
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
        out.print("<input  name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>&nbsp");
        out.print("<input  name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>&nbsp");
    }
%>

<%
				if(selType.compareTo("") != 0)
				{
%>
                <input  name=commit onClick="saveTo()" class="b_foot" style="cursor:hand" type=button value=ȷ��>&nbsp;
<%
				}
%>
                <input  name=back onClick="window.close()" class="b_foot" style="cursor:hand" type=button value=����>&nbsp;
            </TD>
        </TR>
    </TABLE>

  <!------------------------>
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>
 <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</body></HTML>
